IBCRLI ;ALB/ARH - RATES: DISPLAY CHARGE ITEMS ; 16-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; if Charge Set/Rates Billable Item is Bedsection then default display is current charge for all items
 ; all other Charge Sets display all charges for a user selected item
 ; this is due to unknown number of possible entries, for example a CPT set may have thousands of current charges
 ;
EN ; -- main entry point for IBCR CHARGE ITEM
 D EN^VALM("IBCR CHARGE ITEM")
 Q
 ;
HDR ; -- header code
 N IBY,IBX,IBZ,IBI,IBK S IBI=1,(IBX,IBY,IBZ,IBK,VALMHDR(1),VALMHDR(2))=""
 ;
 I +$P(IBCS0,U,5) S IBK="Default Revenue Code: "_$P($G(^DGCR(399.2,+$P(IBCS0,U,5),0)),U,1)
 ;
 S IBZ=IBBRBIN_$S(+IBSRNITM:" ",1:"")_$P(IBSRNITM,U,2)_" items billable to Charge Set "
 ;
 S IBX=$P(IBCS0,U,1) I +$G(IBSRNBDT)!(+$G(IBSRNEDT)) D
 . I IBSRNBDT=IBSRNEDT S IBX=$E(IBX,1,28),IBY=" on "_$$DATE(IBSRNBDT) Q
 . I 'IBSRNBDT S IBY=" on or before "_$$DATE(IBSRNEDT) Q
 . I 'IBSRNEDT S IBY=" on or after "_$$DATE(IBSRNBDT) Q
 . I IBSRNBDT'=IBSRNEDT S IBY=" between "_$$DATE(IBSRNBDT)_" and "_$$DATE(IBSRNEDT)
 ;
 S VALMHDR(1)=IBZ_IBX
 I ($L(IBZ)+$L(IBX)+$L(IBY))<80 S VALMHDR(1)=VALMHDR(1)_IBY,IBY=""
 S VALMHDR(2)=IBK_$J("",(80-($L(IBK)+$L(IBY))))_IBY
 Q
 ;
INIT ; -- init variables and list array  IBCSFN required
 K ^TMP("IBCRLI",$J)
 I '$G(IBCSFN) S IBCSFN=$$GETCS^IBCRU1 I IBCSFN'>0 S VALMQUIT="" Q
 I $$GET(IBCSFN)<0 S VALMQUIT="" Q
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLI",$J),IBCS0,IBBRBI,IBBRBIN,IBSRNITM,IBSRNBDT,IBSRNEDT
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build array for display for Charge Item display: charge set required
 N IBITEM,IBDT1,IBCIFN,IBLN,IBX,IBY S VALMCNT=0 K ^TMP($J,"IBCRCI")
 S IBSRNITM=$G(IBSRNITM),IBSRNBDT=$G(IBSRNBDT),IBSRNEDT=$G(IBSRNEDT)
 ;
 I (IBBRBI=1)!(+IBSRNITM) D SORTCI(IBCSFN,$G(IBSRNITM),$G(IBSRNBDT),$G(IBSRNEDT))
 ;
 ; create LM diplay array of charge items
 S IBITEM="" F  S IBITEM=$O(^TMP($J,"IBCRCI",IBITEM)) Q:IBITEM=""  D
 . S IBDT1="" F  S IBDT1=$O(^TMP($J,"IBCRCI",IBITEM,IBDT1)) Q:IBDT1=""  D
 .. S IBCIFN=0 F  S IBCIFN=$O(^TMP($J,"IBCRCI",IBITEM,IBDT1,IBCIFN)) Q:'IBCIFN  D
 ... ;
 ... S IBLN=$G(^IBA(363.2,IBCIFN,0)),IBY=""
 ... S IBX=$$EXPAND^IBCRU1(363.2,.01,$P(IBLN,U,1))
 ... I +$P(IBLN,U,7) S IBX=IBX_" - "_$$EXPAND^IBCRU1(363.2,.07,+$P(IBLN,U,7))
 ... S IBY=$$SETFLD^VALM1(IBX,IBY,"ITEM")
 ... S IBX=$J($P(IBLN,U,5),8,2),IBY=$$SETFLD^VALM1(IBX,IBY,"UCHG")
 ... S IBX=$J($P(IBLN,U,8),8,2),IBY=$$SETFLD^VALM1(IBX,IBY,"BCHG")
 ... S IBX=$P($G(^DGCR(399.2,+$P(IBLN,U,6),0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"RVCD")
 ... S IBX=$$DATE($P(IBLN,U,3)),IBY=$$SETFLD^VALM1(IBX,IBY,"EFFDT")
 ... S IBX=$P(IBLN,U,4)
 ... I +IBX S IBY=$$SETFLD^VALM1("-",IBY,"DS"),IBX=$$DATE(IBX),IBY=$$SETFLD^VALM1(IBX,IBY,"INADT")
 ... D SET(IBY)
 ;
 I VALMCNT=0 D SET(" ") D
 . I 'IBBRBI D SET("The Billing Rate of this Set has no Billable Item defined, therefore no"),SET("Charge Items may be defined for it.  (The charges may be calculated amounts.)") Q
 . I '$D(^IBA(363.2,"AIVDTS"_+$G(IBCSFN))) D SET("No Charge Items defined for this Set.") Q
 . I +IBSRNITM,'$D(^IBA(363.2,"AIVDTS"_+$G(IBCSFN),+IBSRNITM)) D SET(IBBRBIN_" "_$P(IBSRNITM,U,2)_" has no charges for this set.") Q
 . I 'IBSRNITM,IBBRBI'=1 D SET("No Charge Item chosen for display:"),SET("       - Non-bedsection type Items must be specifically chosen for display."),SET("       - Use the CI action and select an item to display.") Q
 . I 'IBSRNITM D SET("This set has no charges in this date range.") Q
 . D SET(IBBRBIN_" "_$P(IBSRNITM,U,2)_" has no charges for this set in this date range.")
 ;
 K ^TMP($J,"IBCRCI")
 Q
 ;
DATE(X) ; date in external format
 N Y S Y="" I $G(X)?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
SET(X) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCRLI",$J,VALMCNT,0)=X
 Q
 ;
 ;
SORTCI(IBCSFN,IBITM,IBDT1,IBDT2) ; sort a charge sets items by item name and inverse effective date
 ; if ITEM is not defined than dates should be, if ITEM or dates not defined then assumes all should be included
 ; ^TMP("IBCRCI",$J, item name, - effective date, ITEM IFN)=""
 ;
 N IBXRF,IBBITM,IBEITM,IBITEM,IBBDT,IBEDT,IBEFDT,IBCIFN,IBLN,IBITEMN
 ;
 S IBXRF="AIVDTS"_+$G(IBCSFN)
 S IBBITM=+$G(IBITM)-.0001,IBEITM=$S(+$G(IBITM):IBITM,1:9999999999)
 S IBBDT=$S(+$G(IBDT1):-IBDT1,1:-1000000),IBEDT=$S(+$G(IBDT2):-(IBDT2+.01),1:-9999999) Q:IBBDT<IBEDT
 ;
 S IBITEM=IBBITM F  S IBITEM=$O(^IBA(363.2,IBXRF,IBITEM)) Q:'IBITEM!(IBITEM>IBEITM)  D
 . S IBEFDT=IBEDT F  S IBEFDT=$O(^IBA(363.2,IBXRF,IBITEM,IBEFDT)) Q:'IBEFDT  D  Q:(IBEFDT'<IBBDT)
 .. S IBCIFN=0 F  S IBCIFN=$O(^IBA(363.2,IBXRF,IBITEM,IBEFDT,IBCIFN)) Q:'IBCIFN  D
 ... S IBLN=$G(^IBA(363.2,IBCIFN,0)),IBITEMN=$$EXPAND^IBCRU1(363.2,.01,$P(IBLN,U,1))_" - "
 ... I +$P(IBLN,U,7) S IBITEMN=IBITEMN_$$EXPAND^IBCRU1(363.2,.07,+$P(IBLN,U,7))
 ... I $P(IBLN,U,4),+$P(IBLN,U,4)<-IBBDT Q
 ... S ^TMP($J,"IBCRCI",IBITEMN,IBEFDT,IBCIFN)=""
 Q
 ;
GET(IBCSFN) ; get item to display on screen for specific charge set, set up general variables required
 ; (returns 0 if error, -1 if ^) all active bedsections or all entries for a specific CPT or NDC #
 ;
 ; returns general data on the Charge set to be diplayed, may ask user for a specific item
 ; variables defined on exit: IBCS0,IBBRBI,IBBRBIN,IBSRNITM,IBSRNBDT,IBSRNEDT
 ; if billable item is bedsection returns current date but no item
 ; if billable item is anything else asks user for specific item but returns no date
 ;
 N IBX S IBX=1,(IBBRBI,IBBRBIN,IBSRNITM,IBSRNBDT,IBSRNEDT)=""
 S IBCS0=$G(^IBE(363.1,+$G(IBCSFN),0)) I IBCS0="" S IBX=0 G GETQ
 S IBBRBI=$P($G(^IBE(363.3,+$P(IBCS0,U,2),0)),U,4) I 'IBBRBI S IBX=0 G GETQ
 S IBBRBIN=$$EXPAND^IBCRU1(363.3,.04,IBBRBI)
 I IBBRBI>1 W !!,"Select a billable ",IBBRBIN," to display for Charge Set ",$P(IBCS0,U,1),!
 ;
 I IBBRBI=1 S (IBSRNBDT,IBSRNEDT)=DT ; all currently active charges (bedsection)
 I IBBRBI=2 S (IBX,IBSRNITM)=$$GETCPT^IBCRU1("",1) ; all charges for a specific CPT
 I IBBRBI=3 S (IBX,IBSRNITM)=$$GETNDC^IBCRU1 ; all charges for a specific NDC #
 I IBBRBI=4 S (IBX,IBSRNITM)=$$GETDRG^IBCRU1 ; all charges for a specific DRG
 I IBBRBI=9 S (IBX,IBSRNITM)=$$GETMISC^IBCRU1 ; all charges for a specific MISCELLANEOUS item
GETQ Q IBX
