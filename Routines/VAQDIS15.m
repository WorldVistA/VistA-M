VAQDIS15 ;ALB/JFP - PDX,DISPLAY SEGMENTS FOR DISPLAY;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**1,17**;NOV 17, 1993
EP ; -- Main entry point for the list processor
 ; -- K XQORS,VALMEVL (only kill on the first screen in)
 D EN^VALM("VAQ DISPLAY SEGMENT PDX11") ; -- protocol = VAQ PDX11 (MENU)
 ;K VALMBCK
 QUIT
 ;
INIT ; -- Initializes variables and defines screen
 K ^TMP("VAQD2",$J)
 S (VAQECNT,VALMCNT,SEGDE)=0
 ;
 I '$D(^VAT(394.61,DFN,"SEG",0)) D  QUIT
 .S X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1("  ** No Segment(s)... <Return> to exit ","",1,79)
 .D TMP
 ;
 F  S SEGDE=$O(^VAT(394.61,DFN,"SEG","B",SEGDE))  Q:SEGDE=""  D
 .S SEGMNU=$P($G(^VAT(394.71,SEGDE,0)),U,2)
 .S SEGNM=$P($G(^VAT(394.71,SEGDE,0)),U,1)
 .S VAQECNT=VAQECNT+1
 .S X=$$SETFLD^VALM1(VAQECNT,"","ENTRY")
 .S X=$$SETFLD^VALM1(SEGMNU,X,"SEGMENTS")
 .S X=$$SETFLD^VALM1(SEGNM,X,"SEGNAME")
 .D TMP
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQD2",$J,VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQD2",$J,"IDX",VALMCNT,VAQECNT)=""
 S ^TMP("VAQIDXSG",$J,VAQECNT)=SEGDE_"^"_SEGMNU
 QUIT
 ;
HD ; -- Make header line for list processor
 N X0,X1,X2
 S X0=$$TRNDATA^VAQUTL92(VAQDFN) ; -- sets variable from transaction file
 S X1=$$SETSTR^VALM1("Patient: "_VAQPTNM,"",1,41)
 S X1=$$SETSTR^VALM1("Remote Domain: "_VAQADOM,X1,42,79)
 S:VAQPTID="" X2=$$SETSTR^VALM1("    SSN: "_VAQESSN,"",1,41)
 S:VAQPTID'="" X2=$$SETSTR^VALM1("     ID: "_VAQPTID,"",1,41)
 S X2=$$SETSTR^VALM1("    Date/Time: "_VAQADT,X2,42,79)
 ;
 S VALMHDR(1)=" "
 S VALMHDR(2)=$E(X1,1,79)
 S VALMHDR(3)=$E(X2,1,79)
 ;
 D KILLTRN^VAQUTL92 ; -- cleans up variables set in TRNDATA CALL
 K X0,X1,X2
 QUIT
 ;
 ; ------------------------ PROTOCOLS -------------------------------
SEL ; -- Selected segment(s) for display
 D SEL^VALM2
 Q:'$D(VALMY)
 S VALMCNT=1
 S ROOT="^TMP(""VAQD3"",$J)" K @ROOT
 D CLEAR^VALM1
 S X=$$DEVICE^VAQDIS17("SEL")
 ; -- Added call to INIT to clear variables
 I X=-1 W !,"Error in getting device" D INIT S VALMBCK="R" QUIT
 I X=0 S VALMBCK="R" G SEL2 ; -- allows for re-selection
 S ENTRY=""
 F  S ENTRY=$O(VALMY(ENTRY))  Q:ENTRY=""  D BLDDIS
 D ENDLN
 D EP^VAQDIS16
SEL2 D INIT
 S VALMBCK="R"
 QUIT
 ;
ALL ; -- Selects all segments for display
 I '$D(^TMP("VAQIDXSG",$J)) S VALMBCK="Q" QUIT
 S VALMCNT=1
 S ROOT="^TMP(""VAQD3"",$J)" K @ROOT
 D CLEAR^VALM1
 S X=$$DEVICE^VAQDIS17("ALL")
 I X=-1 W !,"Error in getting device" D INIT S VALMBCK="R" QUIT
 I X=0 K VALMBCK  QUIT
 S ENTRY=""
 F  S ENTRY=$O(^TMP("VAQIDXSG",$J,ENTRY)) Q:ENTRY=""  D BLDDIS
 D ENDLN
 D EP^VAQDIS16
 K VALMBCK
 QUIT
 ;
TRANEX D PAUSE^VALM1
 S VALMBCK=$S(VAQFLAG=0:"R",1:"Q")
 QUIT
 ;
BLDDIS ; -- Builds display
 D:$D(XRTL) T0^%ZOSV ; -- Capacity start
 S SDAT=$G(^TMP("VAQIDXSG",$J,ENTRY))
 S SEGDE=$P(SDAT,U,1)
 S OFFSET=$$BLDDSP^VAQUPD2(DFN,SEGDE,ROOT,VALMCNT)
 S:+OFFSET'=-1 VALMCNT=VALMCNT+OFFSET
 I +OFFSET=-1 S ERRMSG=$P($G(OFFSET),U,2) D ERRMSG
 ;W !,"Segment = ",SEGDE,"     Offset = ",OFFSET,"     VALMCNT = ",VALMCNT
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; -- Capacity stop
 QUIT
 ;
ERRMSG ; -- Displays a message if segment could be extracted
 S EROOT=$$ROOT^VAQDIS20(ROOT)
 S VAQSEGND=""
 S:SEGDE'="" VAQSEGND=$G(^VAT(394.71,SEGDE,0))
 S VAQLN=$$REPEAT^VAQUTL1("-",79)
 S VAQCTR="< "_$S($P(VAQSEGND,"^",1)'="":$P(VAQSEGND,"^",1),1:"Segment  Description Missing")_" >"
 S X=$$CENTER^VAQDIS20(VAQLN,VAQCTR) D ETMP
 S X=$$SETSTR^VALM1(" ","",1,79) D ETMP
 S X=$$SETSTR^VALM1("  ** "_ERRMSG,"",1,79) D ETMP
 S X=$$SETSTR^VALM1(" ","",1,79) D ETMP
 S X=$$SETSTR^VALM1(" ","",1,79) D ETMP
 S OFFSET=VALMCNT
 K VAQLN,VAQCTR,VAQSEGND,X,EROOT
 QUIT
 ;
ENDLN ; -- End of display
 S EROOT=$$ROOT^VAQDIS20(ROOT)
 S X=$$SETSTR^VALM1(" ","",1,79) D ETMP
 S X=$$SETSTR^VALM1("  [ End of Data ]","",1,79) D ETMP
 K EROOT
 QUIT
 ;
ETMP ; -- Display for error message
 S VALMCNT=VALMCNT+1
 S @EROOT@(VALMCNT,0)=$E(X,1,79)
 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K ^TMP("VAQD2",$J),^TMP("VAQIDXSG",$J)
 K SEGDE,SEGMNU,SEGNM
 K ROOT,OFFSET
 Q
 ;
END ; -- End of code
 QUIT
