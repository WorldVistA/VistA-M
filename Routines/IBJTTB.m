IBJTTB ;ALB/ARH - TPI AR TRANSACTION PROFILE ; 06-MAR-1995
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; this screen is based on Transaction Profile [PRCAC TRANS PROFILE] option
 ;
EN ; -- main entry point for IBJ TP AR TRANSACTIONS
 D EN^VALM("IBJT AR TRANSACTION PROFILE")
 Q
 ;
HDR ; -- header code
 D HDR^IBJTU1(+IBIFN,+DFN,13)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJTTB",$J)
 I '$G(DFN)!'$G(IBIFN)!('$G(IBTRNS)) S VALMQUIT="" G INITQ
 D BLD^IBJTTB1
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTTB",$J)
 D CLEAR^VALM1
 Q
