IBJTCA ;ALB/ARH - TPI CLAIMS INFO SCREEN ;16-FEB-1995
 ;;2.0;INTEGRATED BILLING;**39,137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBJ TP CLAIMS INFO
 D EN^VALM("IBJT CLAIM INFO")
 Q
 ;
HDR ; -- header code
 D HDR^IBJTU1(+IBIFN,+DFN,1)
 S:$$WNRBILL^IBEFUNC(+IBIFN) VALMSG="*=No payment expected, bill exists to obtain MRA"
 Q
 ;
INIT ; -- init variables and list array
 K IBPOLICY F I="IBJTCA","IBJTBA","IBJTBB","IBJTBC","IBJTBD","IBJTEA","IBJTRA","IBJTTA","IBJTTB","IBJTTC","IBTRCD","IBTRDD","IBCNSA","IBCNSC","IBCNSVP" K ^TMP(I,$J)
 I '$G(DFN)!'$G(IBIFN) S VALMQUIT="" G INITQ
 D BLD^IBJTCA1
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTCA",$J),IBIFN,IBPRVSCR,IBPOLICY,IBARCOMM
 D CLEAR^VALM1,CLEAN^VALM10
 Q
