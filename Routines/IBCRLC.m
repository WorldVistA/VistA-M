IBCRLC ;ALB/ARH - RATES: DISPLAY CHARGE SETS ; 17-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR CHARGE SET
 D EN^VALM("IBCR CHARGE SET")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="                                                 Default"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLC",$J),^TMP("IBCRLCX1",$J)
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLC",$J),^TMP("IBCRLCX1",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build charge set display array
 N IBBRNM,IBBRFN,IBCSNM,IBCSFN,IBBEVNT,IBLN,IBX,IBY S VALMCNT=0 K ^TMP($J,"IBCRCS")
 ;
 D SORTCS
 ;
 ; create LM display array
 S IBBRNM="" F  S IBBRNM=$O(^TMP($J,"IBCRCS",IBBRNM)) Q:IBBRNM=""  D
 . ;
 . S IBBRFN=+$G(^TMP($J,"IBCRCS",IBBRNM))
 . D SET("",IBBRFN) S IBY="         Billing Rate: "_IBBRNM
 . D SET(IBY) D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM)
 . ;
 . S IBBEVNT="" F  S IBBEVNT=$O(^TMP($J,"IBCRCS",IBBRNM,IBBEVNT)) Q:IBBEVNT=""  D
 .. S IBCSNM="" F  S IBCSNM=$O(^TMP($J,"IBCRCS",IBBRNM,IBBEVNT,IBCSNM)) Q:IBCSNM=""  D
 ... S IBCSFN=0 F  S IBCSFN=$O(^TMP($J,"IBCRCS",IBBRNM,IBBEVNT,IBCSNM,IBCSFN)) Q:'IBCSFN  D
 .... ;
 .... S IBLN=$G(^IBE(363.1,IBCSFN,0)) Q:IBLN=""
 .... S IBY=""
 .... S IBX=$P(IBLN,U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"CGSET")
 .... S IBX=$$EMUTL^IBCRU1(+$P(IBLN,U,3),2),IBY=$$SETFLD^VALM1(IBX,IBY,"BEVNT")
 .... S IBX=$$CGTYPE(+$P(IBLN,U,4)),IBY=$$SETFLD^VALM1(IBX,IBY,"CGTYP")
 .... S IBX=$P($G(^DGCR(399.2,+$P(IBLN,U,5),0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"DRVCD")
 .... S IBX=$$EMUTL^IBCRU1(+$P(IBLN,U,6),2),IBY=$$SETFLD^VALM1(IBX,IBY,"DBEDS")
 .... S IBX=$P($G(^IBE(363.31,+$P(IBLN,U,7),0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"REGN")
 .... D SET(IBY)
 ;
 I VALMCNT=0 D SET(" ",0),SET("No Charge Sets defined",0)
 ;
 K ^TMP($J,"IBCRCS")
 Q
 ;
SET(X,BRFN) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCRLC",$J,VALMCNT,0)=X
 I +$G(BRFN) S ^TMP("IBCRLCX1",$J,+BRFN)=VALMCNT
 Q
 ;
SORTCS ; created array of all Charge Sets sorted by billing rate, billable event, and Charge Set name
 ; ^TMP($J,"IBCRCS", billing rate name) = billing rate IFN
 ; ^TMP($J,"IBCRCS", billing rate name, billable event, charge set name, charge set IFN) = ""
 N IBCSFN,IBBRNM,IBBEVNT,IBLN
 S IBCSFN=0 F  S IBCSFN=$O(^IBE(363.1,IBCSFN)) Q:'IBCSFN  D
 . S IBLN=$G(^IBE(363.1,IBCSFN,0))
 . S IBBRNM=$P($G(^IBE(363.3,+$P(IBLN,U,2),0)),U,1) I IBBRNM="" S IBBRNM=" "
 . S IBBEVNT=$$EMUTL^IBCRU1($P(IBLN,U,3),2) I IBBEVNT="" S IBBEVNT=" "
 . S ^TMP($J,"IBCRCS",IBBRNM)=$P(IBLN,U,2)
 . S ^TMP($J,"IBCRCS",IBBRNM,IBBEVNT,$P(IBLN,U,1),IBCSFN)=""
 Q
 ;
CGTYPE(X) ; return external form of Charge Type (363.1)
 S X=$G(X),X=$S(X=1:"INSTITUTIONAL",X=2:"PROFESSIONAL",1:"")
 Q X
