GMRCPP ;SLC/DCM - Print GMRC consult/request tracking protocols - List Manager routine ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
EN ; -- main entry point for GMRC PRINT CONSULT PROTOCOLS
 D EN^VALM("GMRC PRINT CONSULT PROTOCOLS")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="                          CONSULT PROTOCOLS."
 S VALMHDR(2)="Protocol File (#101)"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("GMRCR",$J,"PCL")
 S DSPLINE=0,VALMAR="^TMP(""GMRCR"",$J,""PLIST"")"
 F LINE=1:1:GMRCCT S DSPLINE=$O(^TMP("GMRCR",$J,"PRL",DSPLINE)) Q:DSPLINE=""  S DATA=^(DSPLINE,0) D SET^VALM10(LINE,DATA)
 S VALMCNT=GMRCCT
 K DATA,LINE,DSPLINE
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("GMRCR",$J,"PRL")
 K GMRCCT,TAB
 Q
 ;
EXPND ; -- expand code
 Q
 ;
