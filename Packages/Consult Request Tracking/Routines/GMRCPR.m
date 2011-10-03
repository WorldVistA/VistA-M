GMRCPR ;SLC/DCM - GMRC List Manager Routine - Get information for abbreviated print of GMRC protocols and format for List Manager ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
EN ; -- main entry point for GMRC PRINT ABBREV PROTOCOLS
 D EN^VALM("GMRC PRINT ABBREV PROTOCOLS")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=TAB_"GMRC PROTOCOL LIST"
 S VALMHDR(2)="Consults/Request Tracking Protocols from file #101"
 Q
 ;
INIT ; -- init variables and list array
 S DSPLINE=0,VALMAR="^TMP(""GMRCR"",$J,""PSLIST"")"
 F LINE=1:1:GMRCCT S DSPLINE=$O(^TMP("GMRCR",$J,"PRS",DSPLINE)) Q:DSPLINE=""  S DATA=^(DSPLINE,0) D SET^VALM10(LINE,DATA)
 K DATA,LINE,DSPLINE
 S VALMCNT=30
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("GMRCR",$J,"PRS")
 K TAB,GMRCCT
 Q
 ;
EXPND ; -- expand code
 Q
 ;
