IBCRLG ;ALB/ARH - RATES: DISPLAY BILLING REGIONS ; 16-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,115,138,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR BILLING REGION
 D EN^VALM("IBCR BILLING REGION")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Regions/localities covered by the same charges"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLG",$J)
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLG",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build LM array for billing region display
 N IBRGN,IBRGFN,IBRG0,IBDVN,IBDV0,IBX,IBY,IBIST,IBIS0 S VALMCNT=0
 ;
 ; create LM display array
 S IBRGN="" F  S IBRGN=$O(^IBE(363.31,"B",IBRGN)) Q:IBRGN=""  D
 . S IBRGFN=0 F  S IBRGFN=$O(^IBE(363.31,"B",IBRGN,IBRGFN)) Q:'IBRGFN  D
 .. S IBRG0=$G(^IBE(363.31,IBRGFN,0)) Q:IBRG0=""
 .. D SET("") S IBY=""
 .. ;
 .. S IBX=$P(IBRG0,U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"REGN")
 .. S IBX=$P(IBRG0,U,2)_"-"_$P(IBRG0,U,3),IBY=$$SETFLD^VALM1(IBX,IBY,"ID")
 .. ;
 .. S IBDVN=0 F  S IBDVN=$O(^IBE(363.31,IBRGFN,11,IBDVN)) Q:'IBDVN  D
 ... S IBDV0=$G(^IBE(363.31,IBRGFN,11,IBDVN,0)) Q:IBDV0=""
 ... ;
 ... I IBY'="" S IBX=$J("Division:",12),IBY=$$SETFLD^VALM1(IBX,IBY,"TYPE")
 ... S IBX=$G(^DG(40.8,+IBDV0,0)),IBX=$E(($P(IBX,U,2)_"   "),1,6)_$P(IBX,U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"DI")
 ... ;
 ... D SET(IBY) S IBY=""
 .. ;
 .. ; institutions for transfer pricing
 .. S IBIST=0 F  S IBIST=$O(^IBE(363.31,IBRGFN,21,IBIST)) Q:'IBIST  D
 ... S IBIS0=$G(^IBE(363.31,IBRGFN,21,IBIST,0)) Q:IBIS0=""
 ... ;
 ... I IBY'="" S IBX=$J("Institution:",12),IBY=$$SETFLD^VALM1(IBX,IBY,"TYPE")
 ... S IBX=$P($$NNT^XUAF4(+IBIS0),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"DI")
 ... ;
 ... D SET(IBY) S IBY=""
 .. ;
 .. I IBY'="" D SET(IBY)
 ;
 I VALMCNT=0 D SET(" "),SET("No Billing Regions defined")
 ;
 Q
 ;
SET(X) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCRLG",$J,VALMCNT,0)=X
 Q
