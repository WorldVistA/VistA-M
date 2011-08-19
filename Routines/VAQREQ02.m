VAQREQ02 ;ALB/JFP - PDX, REQUEST PATIENT DATA, REQUEST SCREEN;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor (called from protocol
 ;    vaq create request)
 ; -- K XQORS,VALMEVL (only kill on the first screen in)
 K ^TMP("VAQSEG",$J),^TMP("VAQNOTI",$J),^TMP("VAQCOPY",$J)
EP1 N X,K,DOM,SEG,SEGMENT,SP50,DISX
 D EN^VALM("VAQ REQUEST PDX2")
 K VALMBCK
 QUIT
 ;
INIT ; -- Initializes variables and defines screen
 K ^TMP("VAQR2",$J)
 S (VAQECNT,VALMCNT)=0,(DOM,SEG)=""
 ;
 S:VAQOPT="UNS" VALM("TITLE")="PDX V1.5 - UNSOLICITED"
 I '$D(^TMP("VAQSEG",$J)) D
 .S DISX=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S DISX=$$SETSTR^VALM1("** Select an option or <Return> to exit ","",1,79) D TMP
 F  S DOM=$O(^TMP("VAQSEG",$J,DOM))  Q:DOM=""  D SETD
 QUIT
 ;
SETD ;
 S VAQECNT=VAQECNT+1,K=0
 S DISX=$$SETFLD^VALM1(VAQECNT,"","ENTRY")
 S DISX=$$SETFLD^VALM1(DOM,DISX,"DOMAIN")
 S (SEGMENT,SEG)=""
 F  S SEG=$O(^TMP("VAQSEG",$J,DOM,SEG))  Q:SEG=""  D WSEG
 I K<3 D
 .S DISX=$$SETFLD^VALM1(SEGMENT,DISX,"SEGMENTS")
 .D TMP
 S DISX=$$SETSTR^VALM1(" ","",1,79) D TMP
 QUIT
 ;
WSEG ;
 S K=K+1
 S P1=K*14,POS=P1-14+K ; -- 3 segments across
 S HSCOMPND=$$HLTHSEG^VAQDBIH1(SEG,0)
 I $P(HSCOMPND,U,1)'=0 D SEGDIS^VAQEXT06
 S SEGMENT=$$SETSTR^VALM1(SEG,SEGMENT,POS,14)
 I K=3 D
 .S DISX=$$SETFLD^VALM1(SEGMENT,DISX,"SEGMENTS")
 .D TMP
 .S SEGMENT="",DISX="",K=0
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQR2",$J,VALMCNT,0)=$E(DISX,1,79)
 S ^TMP("VAQR2",$J,"IDX",VALMCNT,VAQECNT)=""
 S ^TMP("VAQIDX",$J,VAQECNT)=DOM
 Q
 ;
HD ; -- Make header line for list processor
 S SP50=$J("",50)
 S VALMHDR(1)="Patient    : "_$E(VAQNM_SP50,1,38)_"Type: "_VAQEELG
 S VALMHDR(2)="Patient SSN: "_$E(VAQESSN_SP50,1,39)_"DOB: "_VAQEDOB
 QUIT
 ;
 ; ------------------------ PROTOCOLS -------------------------------
REQ ; -- Request Domain and Segment
 D CLEAR^VALM1
 D EP^VAQREQ03
 D INIT
 S VALMBCK="R"
 QUIT
 ;
COPY ; -- Copies segments selected from one domain to main domains
 D SEL^VALM2
 Q:'$D(VALMY)
 D CLEAR^VALM1
 D EP^VAQREQ05
 D INIT
 S VALMBCK="R"
 QUIT
 ;
TRAN ; -- Transmits, Signature, Notify list)
 S VAQFLAG=0,VAQCMNT="Unsolicited Request "
 D CLEAR^VALM1
 I '$D(^TMP("VAQSEG",$J))  W !," ** No request to transmit on file" D TRANEX  QUIT
 S X=$$VRFYUSER^VAQAUT(DUZ) ; -- Signature
 I X<0 K X D TRANEX  QUIT
 D:VAQOPT="REQ" EP^VAQREQ07 ; -- Notify code
 D:VAQOPT="UNS" EP^VAQREQ08 ; -- Comment for unsolicited
 D EP^VAQREQ06 ; -- Transmit
 K ^TMP("VAQSEG",$J)
 ;
TRANEX D PAUSE^VAQUTL95
 S VALMBCK=$S(VAQFLAG=0:"R",1:"Q")
 QUIT
 ;
 ; 
PAT ; -- Change patient by exiting back to patient prompt
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 G:'$D(^TMP("VAQSEG",$J)) EXIT1
 I $D(^TMP("VAQSEG",$J)) W !!,"WARNING...Exiting this option will delete untransmitted request for this patient" R !,"Exit request? N// ",X:DTIME
 I ($E(X,1,1)="Y")!($E(X,1,1)="y") G EXIT1
 I ($E(X,1,1))="^" G EXIT1
 D EP1
 ;
EXIT1 K X,K,DOM,SEG,SEGMENT,SP50,DISX
 K ^TMP("VAQSEG",$J),^TMP("VAQNOTI",$J),^TMP("VAQR2",$J),^TMP("VAQCOPY",$J)
 K VAQEELG,VAQEDOB,VAQNM,VAQESSN,VAQECNT,VAQFLAG,VAQCMNT
 K LPDOM,OLIMIT,TLIMIT,P1,POS,SEGND,SEGNME,SEGNO,HSCOMPND,OLDEF,TLDEF
 K PARAMND
 Q
 ;
END ; -- End of code
 QUIT
