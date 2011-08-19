IBCRLR ;ALB/ARH - RATES: DISPLAY BILLING RATES ; 16-MAY-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR BILLING RATE
 D EN^VALM("IBCR BILLING RATE")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=""
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLR",$J)
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLR",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build array for billing rate display
 N IBDSTR,IBBRN,IBBRFN,IBLN,IBCNT,IBX,IBY S VALMCNT=0,IBCNT=0 K ^TMP($J,"IBCRBR")
 ;
 D SORTBR
 ;
 ; create LM display array
 S IBDSTR=0 F  S IBDSTR=$O(^TMP($J,"IBCRBR",IBDSTR)) Q:'IBDSTR  D
 . D SET("")
 . S IBBRN="" F  S IBBRN=$O(^TMP($J,"IBCRBR",IBDSTR,IBBRN)) Q:IBBRN=""  D
 .. S IBBRFN=0 F  S IBBRFN=$O(^TMP($J,"IBCRBR",IBDSTR,IBBRN,IBBRFN)) Q:'IBBRFN  D
 ... ;
 ... S IBLN=$G(^IBE(363.3,IBBRFN,0)) Q:IBLN=""
 ... S IBCNT=IBCNT+1,IBY=""
 ... S IBX=$P(IBLN,U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"RATE")
 ... S IBX=$P(IBLN,U,2),IBY=$$SETFLD^VALM1(IBX,IBY,"ABBV")
 ... S IBX=$$EXPAND^IBCRU1(363.3,.03,$P(IBLN,U,3)),IBY=$$SETFLD^VALM1(IBX,IBY,"DSTR")
 ... S IBX=$$EXPAND^IBCRU1(363.3,.04,$P(IBLN,U,4)),IBY=$$SETFLD^VALM1(IBX,IBY,"BITM")
 ... S IBX=$$EXPAND^IBCRU1(363.3,.05,$P(IBLN,U,5)),IBY=$$SETFLD^VALM1(IBX,IBY,"CMTHD")
 ... D SET(IBY)
 ;
 I VALMCNT=0 D SET(" "),SET("No Billing Rates defined")
 ;
 K ^TMP($J,"IBCRBR")
 Q
 ;
SET(X) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCRLR",$J,VALMCNT,0)=X
 Q
 ;
SORTBR ; sort billing rates by distribution and billing rate name
 ; ^TMP($J,"IBCRBR", national/local grouping , billing rate name, IBBRFN)=""
 N IBBRFN,IBLN,IBDSTR
 S IBBRFN=0 F  S IBBRFN=$O(^IBE(363.3,IBBRFN)) Q:'IBBRFN  D
 . S IBLN=$G(^IBE(363.3,IBBRFN,0)) Q:IBLN=""
 . S IBDSTR=$P(IBLN,U,3) I IBDSTR=2,IBBRFN<1000 S IBDSTR=1.5
 . I 'IBDSTR S IBDSTR=9999
 . S ^TMP($J,"IBCRBR",IBDSTR,$P(IBLN,U,1),IBBRFN)=""
 Q
