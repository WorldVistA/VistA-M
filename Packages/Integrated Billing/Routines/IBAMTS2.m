IBAMTS2 ;ALB/CPM - PROCESS UPDATED OUTPATIENT ENCOUNTERS ; 25-AUG-93
 ;;2.0;INTEGRATED BILLING;**52,91,117,132,153,156,167,247,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
UPD ; Perform encounter update actions.
 N IBCBK,IBFILTER,IBVAL
 ;
 ; - was check out deleted?
 I IBAST'=2,IBBST=2 S IBCRES=$S(IBAST=8:5,1:1)
 ;
 ; - see if checked out appt classifications were changed
 I IBAST=2,IBBST=2 D CLSF^IBAMTS1(1,.IBCLSF) S IBACT=$$CLUPD() G:'IBACT UPDQ D  I IBACT'=1 G UPDQ
 .I IBACT=1 S IBCRES=2 Q
 .I IBACT=2 N IBCLSF D NEW^IBAMTS1
 ;
 ; - cancel charge if there is a cancellation reason, and the billed
 ; - charge was for the appointment that is no longer billable
 I '$G(IBCRES) G UPDQ
 I '$$LINK(IBOE,$S(IBEVT:IBEVT,1:IBEV0),IBBILLED) G UPDQ
 D CANC G:IBY<0 UPDQ
 ;
 ; - look for other billable visits if Means Test billable
 I '$$BIL^DGMTUB(DFN,IBDT) G UPDQ
 S IBBILLED=0
 ;
 S IBVAL("DFN")=DFN,IBVAL("BDT")=IBDAT-.1,IBVAL("EDT")=IBDAT_.99
 S IBFILTER=""
 ; Skip encounter just cancelled,
 ;  consider only parent encounters, appts checked out
 S IBCBK="I Y'=IBOE,'$P(Y0,U,6),$P(Y0,U,12)=2 D BEDIT^IBAMTS2(Y,Y0) S:IBBILLED SDSTOP=1"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,1) K ^TMP("DIERR",$J)
 ;
UPDQ K IBCLSF,IBACT,IBC,IBOEN,IBEVT
 Q
 ;
BEDIT(IBOEN,IBEVT) ; - perform batch edit
 I $P(IBEVT,U,10)=1 S UNBILLED=1 Q  ; C&P exam -- stop looking
 S IBORG=+$P(IBEVT,U,8),IBAPTY=+$P(IBEVT,U,10)
 I IBORG=3 S IBDISP=+$$DISND^IBSDU(IBOEN,IBEVT,7) Q:'IBDISP
 Q:'$$CHKS^IBAMTS1
 ;
 ; - check classifications
 S IBCLSF=$$ENCL(IBOEN)
 I IBCLSF[1 Q  ; care was related to ao/ir/swa/sc/mst/hnc/cv/shad
 S IBSL="409.68:"_IBOEN ; set softlink
 ;
 ; - ready to bill another encounter
 D BLD^IBAMTS1 S IBBILLED=1
 Q
 ;
CRES ; List of cancellation reasons
 ;;CHECK OUT DELETED
 ;;CLASSIFICATION CHANGED
 ;;MT OP APPT NO-SHOW
 ;;MT OP APPT CANCELLED
 ;;RECD INPATIENT CARE
 ;;BILLED AT HIGHER TIER RATE
 ;
LINK(IBOE,IBEVT,IBN) ; Was the billed charge for the current appointment?
 ;  Input:     IBOE  --  Pointer to outpatient encounter in file #409.68
 ;            IBEVT  --  Zeroth node of encounter in file #409.68
 ;              IBN  --  Pointer to charge in file #350
 ;  Output:       0  --  Charge was not for current appointment
 ;                1  --  Charge was for current appointment
 N IBSL,Y
 I '$G(IBOE)!'$G(IBEVT)!'$G(IBN) G LINKQ
 S IBSL=$P($G(^IB(IBN,0)),"^",4)
 I +IBSL=44 S Y=$P(IBSL,";",1,2)=("44:"_$P(IBEVT,"^",4)_";S:"_+IBEVT) G LINKQ
 I +IBSL=409.68 S Y=IBSL=("409.68:"_IBOE)
LINKQ Q +$G(Y)
 ;
CLUPD() ; Examine changes in the classification.
 ;  Output:    0  --  no changes
 ;             1  --  changes require charges to be cancelled
 ;             2  --  changes require appt to be billed
 ;             3  --  [ec/swa] cancel charge, create deferred charge
 ;             4  --  [ec/swa] pass deferred charge, disposition case
 N I,Y S Y=0
 I IBCLSF("BEFORE")=IBCLSF("AFTER") G CLUPDQ
 F I=1,2,3,4,5,6,7,8 I '$P(IBCLSF("BEFORE"),U,I),$P(IBCLSF("AFTER"),U,I) S Y=$S(I=4:3,1:1) G CLUPDQ
 F I=1,2,3,4,5,6,7,8 I $P(IBCLSF("BEFORE"),U,I),'$P(IBCLSF("AFTER"),U,I) S Y=$S(I=4:4,1:2) Q
CLUPDQ Q Y
 ;
CANC ; Determine cancellation reason and cancel charge
 ;  Input variables:   IBCRES  --  Code for reason to be determined
 ;                   IBBILLED  --  Charge to be cancelled
 S IBCRES=$P($T(CRES+IBCRES),";;",2),IBCRES=+$O(^IBE(350.3,"B",IBCRES,0))
 D CANCH^IBECEAU4(IBBILLED,IBCRES)
 Q
 ;
ENCL(IBOE) ; Return classification results for an encounter.
 ;  Input:    IBOE  --  Pointer to outpatient encounter in file #409.68
 ;  Output:   ao^ir^sc^swa^mst^hnc^cv^shad, where, for each piece,
 ;                      1 - care was related to condition, and
 ;                      0 (or null) - care not related to condition
 N CL,CLD,X,Y S Y=""
 S CL=0 F  S CL=$O(^SDD(409.42,"OE",+$G(IBOE),CL)) Q:'CL  S CLD=$G(^SDD(409.42,CL,0)) I CLD S $P(Y,U,+CLD)=+$P(CLD,U,3)
 Q Y
