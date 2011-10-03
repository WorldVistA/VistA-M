IBJTTA ;ALB/ARH - TPI AR ACCOUNT/CLAIM PROFILE ; 06-MAR-1995
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; this screen is based on the Profile of Accounts Receivable [PRCAC PROFILE] option
 ;
EN ; -- main entry point for IBJ TP AR TRANSACTIONS
 D EN^VALM("IBJT AR ACCOUNT PROFILE")
 Q
 ;
HDR ; -- header code
 D HDR^IBJTU1(+IBIFN,+DFN,13)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJTTA",$J),^TMP("IBJTTAX",$J),IBARCOMM
 I '$G(DFN)!'$G(IBIFN) S VALMQUIT="" G INITQ
 D BLD^IBJTTA1
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K IBPOLICY,IBARCOMM,^TMP("IBJTTA",$J),^TMP("IBJTTAX",$J)
 D CLEAR^VALM1
 Q
 ;
NX(IBTPLNM) ; -- IBJT AR TRANSACTION PROFILE SCREEN action: go to next screen template
 ; get user transaction selection from transaction list on Account Profile screen then open transaction profile
 ;
 N VALMY,IBSELN,IBIFN,IBTRNS
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBSELN=0 F  S IBSELN=$O(VALMY(IBSELN)) Q:'IBSELN  D
 . S IBIFN=$P($G(^TMP("IBJTTAX",$J,IBSELN)),U,2)
 . S IBTRNS=$P($G(^TMP("IBJTTAX",$J,IBSELN)),U,3)
 . D EN^VALM(IBTPLNM)
 S VALMBCK="R"
 Q
 ;
REBLD ; -- called as part of Entry Code for IBJT AR ACCOUNT PROFILE MENU
 ; necessary to cause the AR screen to be rebuilt,  if a Comment Transaction is added to the account (AD action)
 ; and the AR screen is already open, then the AR screen will have incomplete information,  IBARCOMM is
 ; set when a comment is added, if set on entry into the menu protocol for the AR screen then this procedure
 ; is called to rebuild the AR screen so it will have the new transaction listed
 D INIT K IBARCOMM
 Q
