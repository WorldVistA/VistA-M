HMPWB1 ; Agilex/EJK/JD - WRITE BACK ACTIVITY;Nov 5, 2015@16:15:08
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;Sep 01, 2011;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; EDITSAVE^ORWDAL32             6427
 ;
 Q
 ; allergy write back from eHMP-UI to VistA
ALLERGY(RSLT,IEN,DFN,DATA) ;file allergy data
 ; RSLT - result, passed by reference
 ; IEN - zero for new allergy, or IEN for edit
 ; DFN - patient identifier
 ; DATA - array of allergy data. Subscript names are required. 
 ;  ("GMRACHT",0)=1 - Chart Marked indicator
 ;  ("GMRACHT",1)=3150603.0905 - Date/Time Chart Marked
 ;  ("GMRAGNT")="DIGITOXIN^9;PSNDF(50.6," - Allergy and Pointer to Allergen File
 ;  ("GMRAOBHX")="o^OBSERVED" - (O)bserved or (H)istorical
 ;  ("GMRAORIG")=10000000224 - Pointer to VA DRUG CLASS File (50.605)
 ;  ("GMRAORDT")=3150603.0805 - Allergy assessmant date and time. 
 ;  ("GMRASEVR")=2 - Severity of Allergy. 1=Mild, 2=Moderate, 3=Severe
 ;  ("GMRATYPE")="D^Drug" - Type of Allergen (F)ood or (D)rug
 ;  ("GMRANATR")="A^Allergy" - Mechanism of Allergy (A)llergy, (P)harmacologic, (U)nknown.
 ;  ("GMRASYMP",0)=2 - Number of Symptoms
 ;  ("GMRASYMP",1)="2^ITCHING,WATERING EYES" - IEN and Description of Symptom 1
 ;  ("GMRASYMP",2)="133^RASH" - IEN and Description of Symptom 2
 ;
 I $G(DFN)'>0 D MSG^HMPTOOLS("DFN",1) Q
 I '$D(DATA) D MSG^HMPTOOLS("DATA Array",1) Q
 N CMMT,FILTER,GMR0,GMRA,GMR0,GMRIEN,HMPALRGY,HMPDATA,HMPDFN,HMPSITE,I,ORY,REAC,STMPTM,USER,VPRI,X,XWBOS,Y
 N HMPIDX,HMPSTOP,HMPDFN
 S HMPSTOP=0
 ;
 N $ES,$ET,ERRPAT,ERRMSG,D0
 S HMPDFN=DFN
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred in the allergy domain, routine: "_$T(+0)
 S XWBOS=$$NOW^XLFDT  ; indicate that we're in the RPC broker, prevent interactive calls
 ;DE6629 - PB - Sep 7, 2016 - check DATA("GMRAGNT" and strip out all but the file root.
 I $P(DATA("GMRAGNT"),",",2)'=""  N GMR1 S GMR1=$P(DATA("GMRAGNT"),",",1),DATA("GMRAGNT")=$P(GMR1,";",2)_","
 L +^GMR(120.8,0):5
 D EDITSAVE^ORWDAL32(.ORY,IEN,DFN,.DATA)  ; update ADVERSE REACTION ASSESSMENT (#120.86)
 ; ejk US3232 if failure to file, send error message as result. 
 L -^GMR(120.8,0)
 I $P(ORY,"^",1)=-1 D MSG^HMPTOOLS($P(ORY,"^",2)) D ERROR Q
 I $P(ORY,U,1)=0,'$D(D0) D
 . S HMPSTOP=0,HMPIDX=""
 . F  S HMPIDX=$O(^GMR(120.8,"B",DFN,HMPIDX),-1) Q:HMPIDX=""!(HMPSTOP=1)  D
 .. S GMR0=$G(^GMR(120.8,HMPIDX,0))
 .. I $P(GMR0,U,1)=HMPDFN,$P(GMR0,U,2)=$P(DATA("GMRAGNT"),U,1) S D0=HMPIDX,DFN=HMPDFN,HMPSTOP=1
 .. Q
 . Q
 I HMPSTOP S D0=HMPIDX,DFN=HMPDFN
 ; return value in RSLT
 S HMP=$NA(^TMP("HMP",$J)) K @HMP
 S FILTER("id")=D0 ;ien for the entry into the allergy file
 S FILTER("patientId")=DFN ;patient identifier
 S FILTER("domain")="allergy" ;domain name for write back and freshness stream staging
 S FILTER("noHead")=1 ;no header record required.
 D GET^HMPDJ(.RSLT,.FILTER) ;build the JSON array in the ^TMP global
 K ^TMP("ALLERGY",$J)
 M ^TMP("ALLERGY",$J)=@RSLT
 S RSLT=$NA(^TMP("ALLERGY",$J))
 S HMPFCNT=0
 S HMPUID=$$SETUID^HMPUTILS("allergy",DFN,D0)
 S HMPE=^TMP("ALLERGY",$J,1,1)
 S STMPTM=$TR($P($P(HMPE,"lastUpdateTime",2),","),""":")
 D ADHOC^HMPUTIL2("allergy",HMPFCNT,DFN,HMPUID,STMPTM)
 K RSLT
 S RSLT=$$EXTRACT(HMP)
 M ^TMP("HMPALL",$J)=RSLT
 K RSLT
 S RSLT=$NA(^TMP("HMPALL",$J))
 ;Clear work files
 K @HMP
 Q
 ;
ALLEIE(RSLT,DATA) ;file allergy entered in error
 ;Since DFN is not relevant as an input parameter, we removed it from the DATA string
 ;Once we know the allergy IEN, DFN will also be known.  JD - 11/5/15.
 ; RSLT - result, passed by reference
 ; DATA - contains all information needed to mark a Allergy as Entered in Error
 ;   IEN^GMRAERR^GMRAERRBY^GMRAERRDT^GMRACMTS,0)^GMRACMTS,1)
 ;      IEN = Pointer to the Allergy to be marked as Entered in Error
 ;      GMRAERR = YES (must be YES. Any other value will cause the EIE to fail.)
 ;      GMRAERRBY = Pointer to the New Person file. 
 ;      GMRAERRDT = Fileman date.time (3150812.143206)
 ;      GMRACMTS,0) = Total number of comments
 ;      GMRACMTS,N) = Free text field for each comment
 ;
 N HMPSTOP,HMPIEN,HMPDFN
 S HMPIEN=$P(DATA,U,1)
 D CHECKREQ
 Q:HMPSTOP=1
 D PARSE
 I '$D(^GMR(120.8,HMPIEN)) D MSG^HMPTOOLS("Allergy "_HMPIEN_" does not exist",2) D ERROR Q
 D EDITSAVE^ORWDAL32(.RSLT,HMPIEN,HMPDFN,.DATA)
 S HMP=$NA(^TMP("HMP",$J)) K @HMP
 S FILTER("id")=HMPIEN ;ien for the entry into the allergy file
 S FILTER("patientId")=HMPDFN ;patient identifier
 S FILTER("domain")="allergy" ;domain name for write back and freshness stream staging
 S FILTER("noHead")=1 ;no header record required.
 D GET^HMPDJ(.RSLT,.FILTER) ;build the JSON array in the ^TMP global
 K ^TMP("ALLERGY",$J)
 M ^TMP("ALLERGY",$J)=@RSLT
 S RSLT=$NA(^TMP("ALLERGY",$J))
 S HMPFCNT=0
 S HMPUID=$$SETUID^HMPUTILS("allergy",HMPDFN,HMPIEN)
 S HMPE=^TMP("ALLERGY",$J,1,1)
 S STMPTM=$TR($P($P(HMPE,"lastUpdateTime",2),","),""":")
 D ADHOC^HMPUTIL2("allergy",HMPFCNT,HMPDFN,HMPUID,STMPTM)
 K RSLT
 S RSLT=$$EXTRACT(HMP)
 M ^TMP("HMPALL",$J)=RSLT
 K RSLT
 S RSLT=$NA(^TMP("HMPALL",$J))
 ;Clear work files
 K @HMP
 Q
 ;
CHECKREQ ; check for required fields
 ;Removed DFN from the input parameter DATA but for integrity purposes (and not to modify
 ;too much code), we need to keep the number of pieces in DATA the same.
 I HMPIEN'=+HMPIEN D MSG^HMPTOOLS("Allergy identifier is invalid/null: "_HMPIEN) D ERROR Q
 I '$D(^GMR(120.8,HMPIEN)) D MSG^HMPTOOLS("Allergy identifier "_HMPIEN_" does not exist.") D ERROR Q
 S DATA=$P(DATA,U)_U_$P($G(^GMR(120.8,HMPIEN,0)),U)_U_$P(DATA,U,2,999)
 S HMPSTOP=0
 I $P(DATA,U,1)'?1N.N D MSG^HMPTOOLS("Allergy Identifier must be numeric",1) D ERROR Q
 I $P(DATA,U,2)'?1N.N D MSG^HMPTOOLS("Patient Identifier ",2,"must be numeric") D ERROR Q
 I $P(DATA,U,3)'="YES" D MSG^HMPTOOLS("EIE indicator",2,"must be set to YES") D ERROR Q
 I $D(^GMR(120.8,HMPIEN,"ER"))>0 D MSG^HMPTOOLS("Allergy already entered in error: "_HMPIEN) D ERROR Q
 Q
 ;
CHKDATE ;CHECK DATES FOR PROPER FORMAT OF DATE.
 N HMPDT
 S HMPSTOP=0
 S HMPDT=$P($G(DATA("GMRACHT",1)),".",1)
 I $L(HMPDT)'=7 D MSG^HMPTOOLS("Date "_HMPDT_" not formatted correctly",2) D ERROR Q
 S HMPDT=$P($G(DATA("GMRAORDT")),".",1)
 I $L(HMPDT)'=7 D MSG^HMPTOOLS("Date "_HMPDT_" not formatted correctly",2) D ERROR Q
 S HMPDT=$P($G(GMRAERRDT),".",1)
 I $L(HMPDT)'=7 D MSG^HMPTOOLS("Date "_HMPDT_" not formatted correctly",2) D ERROR Q
 Q
 ;
PARSE ;Parse data string into data elements for EDITSAVE^ORWDAL32
 S HMPDFN=$P(DATA,U,2)
 S DATA("GMRAERR")=$P(DATA,U,3)
 S DATA("GMRAERRBY")=$P(DATA,U,4)
 S DATA("GMRAERRDT")=$P(DATA,U,5)
 S DATA("GMRAERRCMTS",0)=$P(DATA,U,6)
 S DATA("GMRAERRCMTS",1)=$P(DATA,U,7)
 Q
 ;
ERROR ;handle errors generated by MSG^HMPTOOLS
 S HMPSTOP=1
 S ^TMP("HMP",$J,1,1)=RSLT(1)
 S RSLT=$NA(^TMP("HMP",$J))
 K RSLT(1)
 Q
 ;
EXTRACT(GLOB) ; Move ^TMP("HMPF",$J) into string format
 N HMPSTOP,HMPFND
 S RSLT="",X=0,HMPSTOP=0,HMPFND=0
 S (I,J)=0
 F  S I=$O(^TMP("HMPF",$J,I)) Q:I=""!(HMPSTOP)  D
 . F  S J=$O(^TMP("HMPF",$J,I,J)) Q:J=""  D
 .. I $G(^TMP("HMPF",$J,I,J))["syncStatus" D
 ... Q:$P(^TMP("HMPF",$J,I,J),":",1)["domainTotals"
 ... S RSLT(X)=RSLT(X)_$P(^TMP("HMPF",$J,I,J),",",1)
 ... S HMPSTOP=1
 ... Q
 .. Q:$G(^TMP("HMPF",$J,I,J))=""
 .. Q:$P(^TMP("HMPF",$J,I,J),",",1)'["allergy"
 .. Q:$P(^TMP("HMPF",$J,I,J),",",4)'["localId"
 .. Q:$P(^TMP("HMPF",$J,I,J),":",1)["domainTotals"
 .. S X=X+1
 .. S RSLT(X)=$G(^TMP("HMPF",$J,I,J))
 .. F  S J=$O(^TMP("HMPF",$J,I,J)) Q:J=""  D
 ... Q:$P(^TMP("HMPF",$J,I,J),":",1)["domainTotals"
 ... S X=X+1
 ... S RSLT(X)=$G(^TMP("HMPF",$J,I,J))
 ... S HMPFND=1
 ... Q
 .. S I=$O(^TMP("HMPF",$J,I))
 .. Q
 . Q
 Q RSLT
