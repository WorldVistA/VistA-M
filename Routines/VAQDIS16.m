VAQDIS16 ;ALB/JFP - PDX,DISPLAY DATA (GENERIC);01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor
 ; -- K XQORS,VALMEVL (only kill on the first screen in)
 D EN^VALM("VAQ DISPLAY DATA PDX12") ; -- protocol = VAQ PDX12 (MENU)
 ;K VALMBCK
 QUIT
 ;
INIT ; -- Initializes variables and defines screen
 I '$D(^TMP("VAQD3",$J,"DISPLAY")) D  QUIT
 .S VALMCNT=0
 .S X=$$SETSTR^VALM1(" ","",1,79) D TMP
 .S X=$$SETSTR^VALM1("  ** No Data to Display ... <Return> to exit ","",1,79)
 .D TMP
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQD3",$J,"DISPLAY",VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQD3",$J,"IDX",VALMCNT,VAQECNT)=""
 QUIT
 ;
HD ; -- Make header line for list processor
 D HD^VAQDIS15 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K ^TMP("VAQD3",$J,"DISPLAY")
 QUIT
 ;
END ; -- End of code
 QUIT
