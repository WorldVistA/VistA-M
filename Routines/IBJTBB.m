IBJTBB ;ALB/ARH - TPI BILL DIAGNOSIS SCREEN ;01-MAR-1995
 ;;2.0;INTEGRATED BILLING;**39,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBJ TP BILL DX
 D EN^VALM("IBJT BILL DX")
 Q
 ;
HDR ; -- header code
 D HDR^IBJTU1(+IBIFN,+DFN,12)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJTBB",$J) N IBFT
 I '$G(DFN)!'$G(IBIFN) S VALMQUIT="" G INITQ
 D BLD
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTBB",$J)
 D CLEAR^VALM1
 Q
 ;
BLD ;
 N IBADX,IBI,IBX,IBCNT,IBLN,IBSTR,IBDATE
 S IBDATE=$$BDATE^IBACSV(IBIFN)
 D SET^IBCSC4D(IBIFN,"",.IBADX) I $D(IBADX)'>1 S IBLN=1 F IBSTR="","Bill contains no diagnosis." S IBLN=$$SET(IBSTR,IBLN,1,80)
 S IBI="",IBLN=1,IBCNT=0 F  S IBI=$O(IBADX(IBI)) Q:'IBI  D  S IBLN=$$SET(IBSTR,IBLN,1,80)
 . S IBCNT=IBCNT+1,IBX=$$ICD9^IBACSV(+IBADX(IBI),IBDATE)
 . S IBSTR=$J("",5)_$J(IBCNT,3)_")  "_$P(IBX,U,1)_$J("",(10-$L($P(IBX,U,1))))_$P(IBX,U,3)
 ;
 S VALMCNT=IBLN-1
 Q
 ;
SET(STR,LN,COL,WD,RV) ; set up TMP array with screen data
 D SET^VALM10(LN,STR)
 S LN=LN+1
 Q LN
