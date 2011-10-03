IBJTLB ;ALB/ARH - TPI INACTIVE LIST SCREEN ; 14-FEB-1995
 ;;2.0;INTEGRATED BILLING;**39,61,153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBJ THIRD PARTY INACTIVE LIST
 D EN^VALM("IBJT INACTIVE LIST")
 Q
 ;
HDR ; -- header code
 N X S X=$$PT^IBEFUNC(+$G(DFN))
 S VALMHDR(1)=$P(X,U,1) I $P(X,U,3)'="" S VALMHDR(1)=VALMHDR(1)_"   "_$E(X,1)_$P(X,U,3)
 S VALMHDR(1)=VALMHDR(1)_$J(IBHMSG,(80-$L(VALMHDR(1))))
 S VALMSG="|r Referred |* MT on Hold |+ Multi Carriers |"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJTLB",$J),^TMP("IBJTLBX",$J)
 I '$G(DFN) S DFN=+$$PAT^IBJTU2 I 'DFN S VALMQUIT="" G INITQ
 D BLDA^IBJTLB1
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTLB",$J),^TMP("IBJTLBX",$J),IBBEG,IBEND,IBHMSG
 D CLEAR^VALM1
 Q
 ;
DATE(X) ;
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
NX(IBTPLNM) ; -- IBJT CLAIM SCREEN INACTIVE action:  go to next screen template
 ;            get user bill selection from Inactive Bills list then open Claim Info screen for that bill
 ;
 N VALMY,IBSELN,IBIFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBSELN=0 F  S IBSELN=$O(VALMY(IBSELN)) Q:'IBSELN  D
 . S IBIFN=$P($G(^TMP("IBJTLBX",$J,IBSELN)),U,2)
 . I +IBIFN D EN^VALM(IBTPLNM)
 S VALMBCK="R"
 Q
