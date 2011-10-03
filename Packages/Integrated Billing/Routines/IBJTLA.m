IBJTLA ;ALB/ARH - TPI ACTIVE BILLS LIST SCREEN ; 14-FEB-1995
 ;;2.0;INTEGRATED BILLING;**39,61,153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBJ THIRD PARTY ACTIVE LIST
 D EN^VALM("IBJT ACTIVE LIST")
 Q
 ;
HDR ; -- header code
 N X S X=$$PT^IBEFUNC(+$G(DFN))
 S VALMHDR(1)=$P(X,U,1) I $P(X,U,3)'="" S VALMHDR(1)=VALMHDR(1)_"   "_$E(X,1)_$P(X,U,3)
 I $G(DFN) N VAEL,VAERR D ELIG^VADPT S X=$P(VAEL(1),U,2),VALMHDR(1)=VALMHDR(1)_$J(" ",(79-$L(VALMHDR(1))-$L(X)))_X
 S VALMSG="|r Referred |* MT on Hold |+ Multi Carriers |"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJTLA",$J),^TMP("IBJTLAX",$J)
 I '$G(DFN) S DFN=+$$PAT^IBJTU2 I 'DFN S VALMQUIT="" G INITQ
 D BLDA^IBJTLA1
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTLA",$J),^TMP("IBJTLAX",$J),IBFASTXT,DFN
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
NX(IBTPLNM) ; -- IBJT CLAIM SCREEN ACTIVE action: go to next screen template
 ;            get user bill selection from Active Bills screen then open Claim Info screen for that bill
 ;
 N VALMY,IBSELN,IBIFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBSELN=0 F  S IBSELN=$O(VALMY(IBSELN)) Q:'IBSELN  D
 . S IBIFN=$P($G(^TMP("IBJTLAX",$J,IBSELN)),U,2)
 . I +IBIFN D EN^VALM(IBTPLNM)
 S VALMBCK="R"
 Q
 ;
OPTION ; ENTRY POINT TO THIRD PARTY INQUIRY FROM MENU OPTION, gets patient or bill number then goes to correct screen
 ;
 N IBX S IBX=$$PB^IBJTU2
 I +IBX=1 S DFN=+$P(IBX,U,2) I +DFN D EN^IBJTLA G OPTQ
 I +IBX=2 S IBIFN=+$P(IBX,U,2),DFN=+$P($G(^DGCR(399,IBIFN,0)),U,2) I +DFN D EN^IBJTCA G OPTQ
OPTQ K DFN,IBIFN,IBFASTXT,IBPRVSCR,VALMBCK
 Q
