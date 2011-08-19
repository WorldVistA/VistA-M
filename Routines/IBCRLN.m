IBCRLN ;ALB/ARH - RATES: DISPLAY PROVIDER DISCOUNT ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,148**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR PROVIDER DISCOUNT
 D EN^VALM("IBCR PROVIDER DISCOUNT")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Provider Discounts for "_$P($G(^IBE(363.32,+$G(IBSGFN),0)),U,1)_" Group."
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLN",$J),^TMP("IBCRLNX1",$J)
 I '$G(IBSGFN) S IBSGFN=$$GETSG^IBCRU1(2) I IBSGFN'>0 S VALMQUIT="" Q
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLN",$J),^TMP("IBCRLNX1",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build charge set display array
 N IBPDN,IBPDFN,IBPD0,IBPCVA,IBPCFN,IBPC,IBX,IBY,IBZ S VALMCNT=0 K ^TMP($J,"IBCRLN")
 ;
 D SORT
 ;
 ; create LM display array
 S IBPDN="" F  S IBPDN=$O(^TMP($J,"IBCRLN",IBPDN)) Q:IBPDN=""  D
 . ;
 . S IBPDFN=+$G(^TMP($J,"IBCRLN",IBPDN)),IBPD0=$G(^IBE(363.34,+IBPDFN,0)) I $P(IBPD0,U,2)'=+$G(IBSGFN) Q
 . ;
 . D SET("",IBPDFN) S IBY="        Provider Type: "_$P(IBPD0,U,1)
 . D SET(IBY) D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM) D SET("")
 . ;
 . S IBY=""
 . S IBZ=$P(IBPD0,U,3) I IBZ'="" S IBX=$J(IBZ,3)_"%",IBY=$$SETFLD^VALM1(IBX,IBY,"PCNT")
 . ;
 . I '$O(^IBE(363.34,+IBPDFN,11,0)) S IBX="No Person Class Assigned",IBY=$$SETFLD^VALM1(IBX,IBY,"PRVPC") D SET(IBY) S IBY=""
 . ;
 . S IBPCVA="" F  S IBPCVA=$O(^TMP($J,"IBCRLN",IBPDN,IBPCVA)) Q:IBPCVA=""  D
 .. ;
 .. S IBPCFN=+$G(^TMP($J,"IBCRLN",IBPDN,IBPCVA)) Q:'IBPCFN
 .. S IBPC=$$CODE2TXT^XUA4A72(+IBPCFN)
 .. I $P(IBPC,U,1)'="" S IBX=IBPCVA_"  "_$P(IBPC,U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"PRVPC") D SET(IBY) S IBY=""
 .. I $P(IBPC,U,2)'="" S IBX="             "_$P(IBPC,U,2),IBY=$$SETFLD^VALM1(IBX,IBY,"PRVPC") D SET(IBY) S IBY=""
 .. I $P(IBPC,U,3)'="" S IBX="                 "_$P(IBPC,U,3),IBY=$$SETFLD^VALM1(IBX,IBY,"PRVPC") D SET(IBY) S IBY=""
 . I IBY'="" D SET(IBY) S IBY=""
 ;
 I VALMCNT=0 D SET(" "),SET("No Provider Discounts for this Group")
 ;
 K ^TMP($J,"IBCRLN")
 Q
 ;
 ;
SET(X,PDFN) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCRLN",$J,VALMCNT,0)=X
 I +$G(PDFN) S ^TMP("IBCRLNX1",$J,+PDFN)=VALMCNT
 Q
 ;
SORT ; sort the provider discount group by Provider Type then VA Code (IBSGFN expected)
 N IBPDFN,IBPD0,IBPDN,IBPCFN,IBPCVA
 S IBPDFN=0 F  S IBPDFN=$O(^IBE(363.34,IBPDFN)) Q:'IBPDFN  D
 . S IBPD0=$G(^IBE(363.34,IBPDFN,0)),IBPDN=$P(IBPD0,U,1)_" " I $P(IBPD0,U,2)'=+$G(IBSGFN) Q
 . S ^TMP($J,"IBCRLN",IBPDN)=IBPDFN
 . S IBPCFN=0 F  S IBPCFN=$O(^IBE(363.34,IBPDFN,11,"B",IBPCFN)) Q:'IBPCFN  D
 .. S IBPCVA=$$IEN2CODE^XUA4A72(IBPCFN)_" "
 .. S ^TMP($J,"IBCRLN",IBPDN,IBPCVA)=IBPCFN
 Q
