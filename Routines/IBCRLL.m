IBCRLL ;ALB/ARH - RATES: DISPLAY SPECIAL GROUPS ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR SPECIAL GROUPS
 D EN^VALM("IBCR SPECIAL GROUPS")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=" "
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLL",$J)
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLL",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build charge set display array
 N IBTYNM,IBSGNM,IBSGFN,IBSGFN1,IBSG10,IBX,IBY S VALMCNT=0 K ^TMP($J,"IBCRXL")
 ;
 D SORTSG
 ;
 ; create LM display array
 S IBTYNM="" F  S IBTYNM=$O(^TMP($J,"IBCRXL",IBTYNM)) Q:IBTYNM=""  D
 . ;
 . D SET("") S IBY="         Group Type: "_IBTYNM
 . D SET(IBY) D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM) D SET("")
 . ;
 . S IBSGNM="" F  S IBSGNM=$O(^TMP($J,"IBCRXL",IBTYNM,IBSGNM)) Q:IBSGNM=""  D
 .. ;
 .. S IBY="",IBX=IBSGNM,IBY=$$SETFLD^VALM1(IBX,IBY,"GRP")
 .. ;
 .. S IBSGFN=$G(^TMP($J,"IBCRXL",IBTYNM,IBSGNM)) Q:'IBSGFN
 .. S IBSGFN1=0 F  S IBSGFN1=$O(^IBE(363.32,IBSGFN,11,IBSGFN1)) Q:'IBSGFN1  D
 ... ;
 ... S IBSG10=$G(^IBE(363.32,IBSGFN,11,IBSGFN1,0)) Q:'IBSG10
 ... S IBX=$P($G(^IBE(363.3,+IBSG10,0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"BR")
 ... I +$P(IBSG10,U,2) S IBX=$P($G(^IBE(363.1,+$P(IBSG10,U,2),0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"CS")
 ... S IBX=$P(IBSG10,U,3),IBY=$$SETFLD^VALM1(IBX,IBY,"ORD")
 ... D SET(IBY) S IBY=""
 .. I IBY'="" D SET(IBY) S IBY=""
 ;
 I VALMCNT=0 D SET(" "),SET("No Special Groups")
 ;
 K ^TMP($J,"IBCRXL")
 Q
 ;
 ;
SET(X) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCRLL",$J,VALMCNT,0)=X
 Q
 ;
SORTSG ; created array of all Special Link Groups sorted by Type and Name
 ; ^TMP($J,"IBCRXL", group type name) = group type set value
 ; ^TMP($J,"IBCRXL", group type name, group name) = group name IFN
 N IBSGFN,IBSGNM,IBTYNM,IBLN
 S IBSGFN=0 F  S IBSGFN=$O(^IBE(363.32,IBSGFN)) Q:'IBSGFN  D
 . S IBLN=$G(^IBE(363.32,IBSGFN,0))
 . S IBSGNM=$P(IBLN,U,1) I IBSGNM="" S IBSGNM=" "
 . S IBTYNM=$$EXPAND^IBCRU1(363.32,.02,$P(IBLN,U,2)) I IBTYNM="" S IBTYNM=" "
 . S ^TMP($J,"IBCRXL",IBTYNM)=$P(IBLN,U,2)
 . S ^TMP($J,"IBCRXL",IBTYNM,IBSGNM)=IBSGFN
 Q
