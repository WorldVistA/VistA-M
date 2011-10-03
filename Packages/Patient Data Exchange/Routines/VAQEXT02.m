VAQEXT02 ;ALB/JFP - PDX, PROCESS EXTERNAL (MANUAL),PROCESS SCREEN;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**1,10,14**;NOV 17, 1993
EP ; -- Main entry point for the list processor
 ; -- K XQORS,VALMEVL ;(only kill on the first screen in)
 D EN^VALM("VAQ PROCESS PDX4")
 N VALMCNT S VALMCNT=0
 QUIT
 ;
INIT ; -- Builds array of Patients based on PDX transactions for manual
 ;    processing
 ;
 K ^TMP("VAQR4",$J),^TMP("VAQR4","VAQIDX",$J)
 N VAQST,VAQFLAG,VAQCMNT,VAQDFN,VAQECNT
 N VADM,VA,VAERR
 ;
 S (VAQECNT,VALMCNT)=0,(VAQDFN,DFN)=""
 F  S DFN=$O(DPTD(DFN)) Q:DFN=""  D
 .S VAQECNT=VAQECNT+1
 .D DEM^VADPT
 .S X=$$SETFLD^VALM1(VAQECNT,"","ENTRY")
 .S X=$$SETFLD^VALM1(VADM(1),X,"LOCAL PATIENT NAME")
 .S X=$$SETFLD^VALM1($P(VADM(2),U,2),X,"SSN")
 .S VA("DOB")=$$DOBFMT^VAQUTL99($P(VADM(3),U,1))
 .S X=$$SETFLD^VALM1(VA("DOB"),X,"DOB")
 .S X=$$SETFLD^VALM1(VA("PID"),X,"PID")
 .D TMP
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQR4",$J,VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQR4",$J,"IDX",VALMCNT,VAQECNT)=""
 S ^TMP("VAQR4","VAQIDX",$J,VAQECNT)=VALMCNT_"^"_VAQTRDE_"^"_DFN
 Q
 ;
HD ; -- Make header line for list processor
 Q:'$D(VALMY)
HD1 N X,SP50
 S SP50=$J("",50)
 S X=$$SETSTR^VALM1("Remote Patient: "_VAQPTNM,"",1,41)
 S:VAQPTID="" X=$$SETSTR^VALM1("SSN: "_VAQESSN,X,42,17)
 S:VAQPTID'="" X=$$SETSTR^VALM1(" ID: "_VAQPTID,X,42,17)
 S X=$$SETSTR^VALM1(" DOB: "_VAQEDOB,X,59,20)
 S VALMHDR(1)=" "
 S VALMHDR(2)=X
 S VALMHDR(3)=" "
 QUIT
 ;
REJ ; -- Reject PDX with comment
 S VAQST="REJ",VAQFLAG=0,VAQCMNT="Reject "
 D CLEAR^VALM1
 S:'$D(VAQSIG) VAQSIG=$$VRFYUSER^VAQAUT(DUZ) ; -- Signature
 I VAQSIG<0 K VAQSIG D TRANEX  QUIT
 D EP^VAQREQ08 ; -- Comment for reject
 D EP^VAQEXT03
 D TRANEX
 QUIT
 ;
REL ;  -- Release PDX with comment
 D SEL^VALM2
 Q:'$D(VALMY)
 N ENT S ENT=$O(VALMY(""))
 S DFN=$P(^TMP("VAQR4","VAQIDX",$J,ENT),"^",3)
 S VAQFLAG=0,VAQST="REL",VAQCMNT="Release "
 D CLEAR^VALM1
 S:'$D(VAQSIG) VAQSIG=$$VRFYUSER^VAQAUT(DUZ) ; -- Signature
 I VAQSIG<0 K VAQSIG D TRANEX  QUIT
 D EP^VAQREQ08 ; -- Comment for reject
 D EP^VAQEXT03 ; --
 D TRANEX
 QUIT
 ;
NFND ; -- Not found (reject)
 D CLEAR^VALM1 ;clears screen
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Requested patient not found...Process as not found"
 D ^DIR K DIR
 I ('Y)!($D(DUOUT))!($D(DTOUT)) S VALMBCK="Q"  QUIT
 S:'$D(VAQSIG) VAQSIG=$$VRFYUSER^VAQAUT(DUZ) ; -- Signature
 I VAQSIG<0 K VAQSIG D TRANEX  QUIT
 S:'$D(DFN) DFN=""
 S VAQST="NFND"
 D:Y EP^VAQEXT03
 D TRANEX
 QUIT
 ;
EXP ; -- Expand entry
 D SEL^VALM2
 Q:'$D(VALMY)
 N ENT S ENT=$O(VALMY(""))
 S DFN=$P(^TMP("VAQR4","VAQIDX",$J,ENT),"^",3)
 D EP^VAQDIS01
 S VALMBCK="R"
 QUIT
 ;
TRANEX ; -- Pauses screen
 D PAUSE^VAQUTL95
 S:'$D(VAQFLAG) VAQFLAG=""
 S VALMBCK=$S(VAQFLAG=0:"R",1:"Q")
 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K ^TMP("VAQR4",$J),^TMP("VAQR4","VAQIDX",$J)
 K VAQST,VAQFLAG,VAQCMNT,VAQDFN,VAQECNT
 K VALMCNT,VADM,SP50,DFN
 Q
 ;
END ; -- End of code
 QUIT
