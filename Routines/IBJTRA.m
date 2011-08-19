IBJTRA ;ALB/AAS,ARH - TPI CT INSURANCE COMMUNICATIONS ; 4/1/95
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; the IR contact list screen is based on the Insurance Reviews/Contacts screen of the 
 ;      Claims Tracking Insurance Review Edit [IBT EDIT COMMUNICATIONS] option
 ; the VR view expanded insurance reviews screen is based on the Expanded Insurance Reviews screen of the 
 ;      Claims Tracking Insurance Review Edit [IBT EDIT COMMUNICATIONS] option
 ; the VR view expanded appeals/denials screen is based on the Expanded Appeals/Denials screen of the 
 ;      Claims Tracking Appeal/Denial Edit [IBT EDIT APPEALS/DENIALS] option
 ;
 ; the IR contact list build (IBJTRA*) is a copy of IBTRC with modifications to show contacts for multiple events
 ; the two expanded screen builds did not need changes so the CT routines are called directly from the templates
 ;
 ; three Claims Tracking LM Templates were duplicated for JBI so the appropriate Protocol Menu could be used:
 ; IBJT CT/IR COMMUNICATIONS LIST  ---  IBT COMMUNICATIONS EDITOR
 ; IBJT CT/IR REVIEWS              ---  IBT EXPAND/EDIT COMMUNICATIONS
 ; IBJT CT/IR APPEALS/DENIALS      ---  IBT EXPAND/EDIT DENIALS
 ;
 ; expanded Insurance Reviews and expanded Appeals/Denials are called from
 ; the same protocol based on the action type of the entry to be displayed.
 ;
% ;
EN ; -- main entry point for IBT COMMUNICATIONS EDITOR from menu's
 I '$G(IBTRPRF) S IBTRPRF="12"
 D EN^VALM("IBJT CT/IR COMMUNICATIONS LIST")
 K IBTRPRF,VAERR,VA,DGPM
 Q
 ;
HDR ; -- header code
 D PID^VADPT
 S VALMHDR(1)="Insurance Review Entries for: "_$P($G(^DGCR(399,IBIFN,0)),U,1)_"   "_$$PT^IBTUTL1(DFN)
 Q
 ;
INIT ; -- init variables and list array
 S U="^",VALMCNT=0,VALMBG=1
 K ^TMP("IBJTRA",$J),^TMP("IBJTRADX",$J),I,X,XQORNOD,DA,DR,DIE,DNM,DQ
 I '$G(DFN)!'$G(IBIFN) S VALMQUIT="" G INITQ
 D BLD^IBJTRA1
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTRA",$J),^TMP("IBJTRADX",$J)
 D CLEAR^VALM1
 Q
 ;
NX ; -- IBJT CT/IR REVIEWS/APPEALS SCREEN action:  go to next screen template - expand review/denial/appeal
 ; gets user selection of contact then opens either the review or appeal/denial screen
 ;
 N VALMY,IBSELN,IBTRN,IBCNS,IBX,IBY,IBTRC,IBCNT,IBI,IBTRND,VAEL,VAIN,VAINDT,VA200,OFFSET,IBPCNT,IBLCNT,IBDCNT,IBOE
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBSELN=0 F  S IBSELN=$O(VALMY(IBSELN)) Q:'IBSELN  D
 . S IBTRC=$P($G(^TMP("IBJTRADX",$J,IBSELN)),U,2) Q:'IBTRC
 . S IBX=$G(^IBT(356.2,+IBTRC,0)) Q:IBX=""  S IBTRN=$P(IBX,U,2),IBCNS=$P(IBX,U,8)
 . ; if review was a appeal/denial or penalty or had a parent review (which can only be a denial or penalty)
 . ; then use appeals/denials template, otherwise use insurance review template
 . S IBY=$P($G(^IBE(356.7,+$P(IBX,U,11),0)),U,3) I IBY=20!(IBY=30)!(+$P(IBX,U,18)) D EN^VALM("IBJT CT/IR APPEALS/DENIALS") Q
 . D EN^VALM("IBJT CT/IR REVIEWS")
 S VALMBCK="R"
 Q
