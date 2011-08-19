RCRCBL ;ALB/CMS - RC VIEW BILL LIST ; 26-MAR-1998
V ;;4.5;Accounts Receivable;**63**;Mar 20,1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for RCRC EOB LIST
 D EN^VALM("RCRC EOB LIST")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="                EOB Processing TP Partial Payments"
 S VALMHDR(2)="                   Regional Counsel Referrals"
 I +$G(VALMCNT)=0 S VALMSG="NO EOB TO PROCESS"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("RCRCBL",$J),^TMP("RCRCBLX",$J)
 S VALMCNT=0 D BLDL^RCRCBL1
 ;
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("RCRCBL",$J),^TMP("RCRCBLX",$J)
 K PRCABN,PRCATN,VALMCNT,VALMBCK
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
