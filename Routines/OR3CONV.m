OR3CONV ;SLC/MLI-OE/RR v3 conversion entry points ;8/11/06  13:31
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**14,215,260,243,296**;Dec 17, 1997;Build 19
 ;
 ; This routine contains the entry points to convert orders from
 ; all package (OE/RR, pharmacy, dietetics, etc.).
 ;
 ; Entry points exist for:
 ; A. background conversion of orders (steps described in tag):  (BGJ)
 ; B. on-the-fly conversion if record is accessed before background
 ;    conversion gets to it.                                   (OTF)
 ;
 ; Only OTF is a supported call.  Remaining calls in routine are
 ; only called from within this routine (no external calls made in).
 ;
 ; Supporting calls exist in OR3CONV1 as follows:
 ; A. stop conversion process cleanly once in bgj              (STOP)
 ; B. restarting background process if it did not complete.    (RESTART)
 ; C. check status of conversion process                       (STATUS)
 ;
 Q
 ;
QUEUE ; queue background process to run.  DO NOT CALL MANUALLY!
 ; called from OR3POST and RESTART^OR3CONV1
 ;
 ; check entry...disallow calling tag once conversion has begun
 N X
 S X=$G(^ORD(100.99,1,"CONV"))
 I '$D(ZTSAVE("ORESTART")),$P(X,"^",1) W !!,"Conversion already done!" Q
 I '$D(ZTSAVE("ORESTART")),($P(X,"^",10)]"") D  Q
 . W !,"The conversion has already started."
 . W !,"Please call RESTART^OR3CONV1 to restart the conversion!"
 . Q
 ;
 ; if restart, ZTSAVE("ORESTART") set on entry - ask time to queue
 S ZTIO="",ZTRTN="BGJ^OR3CONV"
 I '$D(ZTSAVE("ORESTART")) S ZTDTH=$$NOW^XLFDT()
 S ZTDESC="OE/RR v3 orders conversion...use STATUS^OR3CONV1 to track progress"
 ;S:$D(ZTSAVE("ORESTART")) ORESTART=ZTSAVE("ORESTART") D BGJ^OR3CONV ; *****for testing only*****
 D ^%ZTLOAD
 I $G(ZTSK) D
 . D BMES^XPDUTL("Orders conversion tasked - #"_ZTSK)
 . D SET(10,ZTSK)
 E  D
 . D BMES^XPDUTL("***Problem encountered queuing conversion***")
 . D MES^XPDUTL("   D QUEUE^OR3CONV to start manually.")
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
BGJ ; process via background job in order below
 ; if restart, set ORPROCES = to step last on, call BGJ1
 ;   0.  initialize list of patients to convert, then convert orders for:
 ;   1.  current inpatients
 ;   2.  patients with future scheduled admissions
 ;   3.  patients on waiting list
 ;   4.  patients with discharges in last 4 weeks
 ;   5.  patients with appointments in last 4 weeks or next 4 weeks
 ;   6.  everyone else (loop through DPT for remaining patients)
 ;   7.  orders associated with entities not in the PATIENT file
 ;
 I '$D(ZTQUEUED) W !,"Use RESTART^OR3CONV1!!!" Q  ; prevent calling tag
 ;
 N ORPROCES,ORSTOP
 S ORSTOP=0 D SET(11,0) ; reset stop conversion parameter to no
 I $D(ORESTART) D
 . S ORPROCES=+$P(^ORD(100.99,1,"CONV"),"^",8)
 E  D
 . S ORPROCES=0
 . D SET(6,$$NOW^XLFDT())
 F  Q:ORPROCES>7  D  Q:ORSTOP
 . D SET(8,ORPROCES) ; update process currently on
 . D @ORPROCES Q:ORSTOP
 . S ORPROCES=ORPROCES+1
 I ORSTOP D SET(10,"") ; delete out task job
 Q
 ;
0 ; populate list of patients to convert
 I '$D(ORESTART) D SET(1,0)
 D PTCONV^OR3CONV1
 Q
 ;
1 ; order conversion for inpatients
 N DFN,ORWARD,X
 S ORWARD=$S($D(ORESTART):ORESTART,1:"") K ORESTART
 F  S ORWARD=$O(^DPT("CN",ORWARD)) Q:ORWARD']""!ORSTOP  D
 . D SET(4,ORWARD)
 . F DFN=0:0 S DFN=$O(^DPT("CN",ORWARD,DFN)) Q:'DFN!ORSTOP  D
 . . D SET(5,DFN)
 . . S X=$$CONVERT(DFN,1)
 . D SET(9,ORWARD)
 D SET(3,$$NOW^XLFDT())
 Q
 ;
 ;
2 ; patients with future scheduled admissions
 N ORDATE,ORIEN,X
 S ORDATE=$S($G(ORESTART):ORESTART,1:$$NOW^XLFDT()) K ORESTART
 F  S ORDATE=$O(^DGS(41.1,"C",ORDATE)) Q:'ORDATE!ORSTOP  D
 . F ORIEN=0:0 S ORIEN=$O(^DGS(41.1,"C",ORDATE,ORIEN)) Q:'ORIEN!ORSTOP  D
 . . S X=$G(^DGS(41.1,ORIEN,0))
 . . I X']"" Q
 . . S X=$$CONVERT(+X,1)
 . . D SET(9,ORDATE)
 Q
 ;
 ;
3 ; patients on waiting list
 N DFN,ORIEN,ORIEN1,ORFLAG,X
 S DFN=+$G(ORESTART) K ORESTART
 F  S DFN=$O(^DGWAIT("C",DFN)) Q:'DFN!ORSTOP  D
 . S ORFLAG=0
 . F ORIEN=0:0 S ORIEN=$O(^DGWAIT("C",DFN,ORIEN)) Q:'ORIEN  D  Q:ORFLAG
 . . F ORIEN1=0:0 S ORIEN1=$O(^DGWAIT("C",DFN,ORIEN,ORIEN1)) Q:'ORIEN1  D
 . . . I $G(^DGWAIT(ORIEN,"P",ORIEN1,"ADM")) Q  ; no longer active
 . . . S X=$$CONVERT(DFN,1),ORFLAG=1
 . . . D SET(9,DFN)
 Q
 ;
 ;
4 ; patients with discharges in last 4 weeks
 N DFN,ORDISCH,X
 S ORDISCH=$S($G(ORESTART):ORESTART,1:$$FMADD^XLFDT(DT,-29)) K ORESTART
 F  S ORDISCH=$O(^DGPM("AMV3",ORDISCH)) Q:'ORDISCH!(ORDISCH>DT)!ORSTOP  D
 . F DFN=0:0 S DFN=$O(^DGPM("AMV3",ORDISCH,DFN)) Q:'DFN  D
 . . S X=$$CONVERT(DFN,1)
 . . D SET(9,ORDISCH)
 Q
 ;
 ;
5 ; patients with appointments past 4 weeks through next 4 weeks
 ; this call is no longer used
 N DFN,OREND,ORERR,ORI,ORLOC,ORSTART,X
 S ORSTART=$$FMADD^XLFDT(DT,-29),OREND=$$FMADD^XLFDT(DT,+29)
 S ORLOC=+$G(ORESTART) K ORESTART
 K ^TMP($J,"SDAMA202","GETPLIST")
 F  S ORLOC=$O(^SC(ORLOC)) Q:'ORLOC!ORSTOP  D
 . D GETPLIST^SDAMA202(ORLOC,"4","",ORSTART,OREND)
 . S ORERR=$$CLINERR^ORQRY01
 . I $L(ORERR) W !,ORERR S ORSTOP=1 Q
 . S ORI=0
 . F  S ORI=$O(^TMP($J,"SDAMA202","GETPLIST",ORI)) Q:ORI<1  D
 .. S DFN=+$G(^TMP($J,"SDAMA202","GETPLIST",ORI,4))
 .. I DFN S X=$$CONVERT(DFN,1)
 . D SET(9,ORLOC)
 K ^TMP($J,"SDAMA202","GETPLIST")
 Q
 ;
 ;
6 ; rest of patients
 N DFN,X
 S DFN=+$G(ORESTART) K ORESTART
 F  S DFN=$O(^ORD(100.99,1,"PTCONV",DFN)) Q:'DFN!ORSTOP  D
 . S X=$$CONVERT(DFN,1)
 . D SET(9,DFN)
 Q
 ;
 ;
7 ; orders not associated with DPT entries
 N ORVP
 S ORVP=$S($G(ORESTART):ORESTART,1:"") K ORESTART
 F  S ORVP=$O(^OR(100,"AO",ORVP)) Q:ORVP=""!ORSTOP  D
 . D ORDERS^OR3C100(ORVP)
 . D EN^LR7OV2(ORVP,0)
 I ORSTOP Q
 D SET(7,$$NOW^XLFDT())
 D CLEANUP^OR3CONV1
 Q
 ;
 ;
OTF(DFN,ORQUIET) ; on-the-fly conversion
 ;
 ; *** Supported entry point for package to call to see if orders  ***
 ; *** for patient have been converted and convert if not done yet ***
 ;
 ; Input:   DFN as IEN of PATIENT file entry to convert orders for
 ;          ORQUIET as 1 conversion should be silent
 ;
 ; Output:  -1^error message if problem encountered
 ;          0 if patient already converted prior to call
 ;          1 if patient was successfully converted as part of call
 ;
 S DFN=$G(DFN),ORQUIET=+$G(ORQUIET)
 I $$ALLDONE() Q 0                 ; conversion already complete
 I DFN'=+DFN!'$D(^DPT(+DFN,0)) Q "-1^Error in DFN passed to OTF^OR3CONV"
 Q $$CONVERT(DFN,ORQUIET,1)        ; convert orders for patient
 ;
 ;
CONVERT(DFN,ORQUIET,OROTF) ; convert orders by patient, set flag when done
 ;
 ; Input  - DFN as IEN of PATIENT file
 ;          ORQUIET as 1 if conversion to be quiet
 ;          OROTF as 1 if conversion called on-the-fly
 ; Output - -1^error message if problem encountered
 ;          1 if patient successfully converted
 ;
 ; new variables from bgj calls to ensure not reset during conv calls
 N ORDATE,ORDATE,ORDISCH,OREND,ORIEN,ORIEN1,ORLOC,ORPROCES,ORSTART,ORWARD
 ;
 N ORERRMSG,ORPTLK,ORVP
 S ORVP=DFN_";DPT("
 S OROTF=+$G(OROTF)
 I 'OROTF,$$STOP() D               ; field set to request stop of bgj
 . S ORSTOP=1
 . D SET(10,"")
 I $$PTDONE(DFN) Q 0               ; patient already converted
 S ORPTLK=$$LOCK^ORX2(DFN)
 I 'ORPTLK D  Q ORERRMSG           ; record is locked
 . I 'ORQUIET W !!,$P(ORPTLK,U,2) H 1
 . S ORERRMSG="-1^"_$P(ORPTLK,U,2)
 ;
 I $$ORCONV(ORVP) D
 . N DFN
 . I 'ORQUIET D WRITE(+ORVP,"OE/RR")
 . D ORDERS^OR3C100(ORVP)
 I $$PSCONV(DFN) D
 . I 'ORQUIET D WRITE(DFN,"pharmacy")
 . D EN1^PSOHLUP(+DFN,'ORQUIET)
 I $$LRCONV() D
 . N DFN
 . I 'ORQUIET D WRITE(+ORVP,"lab")
 . D EN^LR7OV2(ORVP,'ORQUIET)
 D UNLOCK^ORX2(+DFN)
 D DONE(DFN)
 Q 1
 ;
ORCONV(ORVP) ; return 1 if OR orders need to be converted, otherwise 0
 I $O(^OR(100,"AO",ORVP,0)) Q 1
 Q 0
 ;
PSCONV(DFN) ; return 1 to convert pharmacy orders for patient, otherwise 0
 ;I $P($G(^PS(55,DFN,0)),U,6)'=2!'$P($G(^(5.1)),U,11) Q 1
 Q 0
 ;
LRCONV() ; return 1 to convert
 Q 1
 ;
WRITE(DFN,TYPE) ; write converting message
 W !,"Converting ",TYPE," orders for ",$P($G(^DPT(DFN,0)),"^",1)
 Q
 ;
ALLDONE() ; return 1 if conversion done, otherwise 0
 Q $G(^ORD(100.99,1,"CONV"))
 ;
PTDONE(DFN) ; return 1 if patient already converted or PTCONV mult not done
 I $D(^ORD(100.99,1,"PTCONV",DFN)) Q 0
 I +$P($G(^ORD(100.99,1,"CONV")),"^",8)=0 Q 0
 Q 1
 ;
STOP() ; check stop conversion flag
 Q $P($G(^ORD(100.99,1,"CONV")),"^",11)
 ;
SET(PIECE,VALUE) ; update order parameter file field with value
 N X
 S X=$G(^ORD(100.99,1,"CONV"))
 S $P(X,"^",PIECE)=VALUE
 I PIECE=1 S $P(X,"^",2)=$$NOW^XLFDT()
 I PIECE=3 S $P(X,"^",4,5)="^"
 I PIECE=7 S $P(X,"^",1)=1,$P(X,"^",8,10)="^^"
 I PIECE=8 S $P(X,"^",9)=""
 S ^ORD(100.99,1,"CONV")=X
 Q
 ;
DONE(DFN) ; remove entry from multiple
 N COUNT,NODE,LAST,X
 S X=$G(^ORD(100.99,1,"PTCONV",0)) Q:X']""  ; not done step 0
 K ^ORD(100.99,1,"PTCONV",DFN),^ORD(100.99,1,"PTCONV","B",DFN)
LOCK L +^ORD(100.99,1,"PTCONV",0):5 I '$T G LOCK
 S COUNT=$P(X,"^",4)-1,LAST=$O(^ORD(100.99,1,"PTCONV","A"),-1)
 S $P(^ORD(100.99,1,"PTCONV",0),"^",3,4)=LAST_"^"_$S(COUNT>0:COUNT,1:0)
 L -^ORD(100.99,1,"PTCONV",0)
 S $P(^("CONV"),"^",12)=$P(^ORD(100.99,1,"CONV"),"^",12)+1
 Q
