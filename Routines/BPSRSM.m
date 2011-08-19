BPSRSM ;BHAM ISC/SS - ECME REPORTS ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
EN ; -- main entry point for BPS LSTMN RSCH MENU
 D EN^VALM("BPS LSTMN RSCH MENU")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$$HDR^BPSSCR01(1)
 S VALMHDR(2)=$$HDR^BPSSCR01(2)
 S VALMHDR(3)=$$HDR^BPSSCR01(3)
 Q
 ;
INIT ; -- init variables and list array
 ;^TMP for "BPS LSTMN ECME USRSCR" is used
 ;set the Research Screen "begin" line to the current User Screen begin line
 I $G(BPVALMBG)>0 S VALMBG=BPVALMBG
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 I $D(BPVALMBG) S BPVALMBG=VALMBG
 D CLEANUP
 Q
 ;
EXPND ; -- expand code
 Q
 ;
RM ;
 N BPVALMBG
 ;save the current User Screen "begin" line to use for Research Screen (to stay at the same place)
 S BPVALMBG=VALMBG
 D EN
 ;save the current Research "begin" line to use for the User Screen
 I $G(BPVALMBG)>0 S VALMBG=BPVALMBG
 S VALMBCK="R"
 Q
 ;
CLEANUP ;
 Q
 ;
