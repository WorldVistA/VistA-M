IBCRLM ;ALB/ARH - RATES: DISPLAY REVENUE CODE LINKS ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR REVENUE CODE LINK
 D EN^VALM("IBCR REVENUE CODE LINK")
 Q
 ;
HDR ; -- header code
 I +$G(IBCPT) S VALMHDR(1)="Revenue Codes linked to "_$P($$CPT^ICPTCOD(+IBCPT),U,2)
 I +$G(IBCPT) S VALMSG="* revenue code used on a bill for "_$P($$CPT^ICPTCOD(+IBCPT),U,2)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLM",$J)
 I '$G(IBCPT) S IBCPT=$$GETCPT^IBCRU1("",1) I IBCPT'>0 S VALMQUIT="" Q
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLM",$J) D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build charge set display array
 N IBRLFN,IBCPT1,IBRL0,IBLABEL,IBBRFN,IBCSFN,IBX,IBY,RVCPTARR,BRCSARR S VALMCNT=0
 ;
 D FNDSRT(+$G(IBCPT),.RVCPTARR,.BRCSARR)
 ;
 ; create LM display array
 S IBCPT1="" F  S IBCPT1=$O(RVCPTARR(IBCPT1)) Q:IBCPT1=""  D
 . S IBRLFN="" F  S IBRLFN=$O(RVCPTARR(IBCPT1,IBRLFN)) Q:IBRLFN=""  D
 .. ;
 .. S IBY="",IBRL0=$G(^IBE(363.33,+IBRLFN,0)) Q:IBRL0=""
 .. ;
 .. I $D(BRCSARR(IBRLFN)) S IBX="*",IBY=$$SETFLD^VALM1(IBX,IBY,"USED")
 .. S IBX=$P($$CPT^ICPTCOD(+$P(IBRL0,U,3)),U,2),IBY=$$SETFLD^VALM1(IBX,IBY,"PRC1")
 .. I +$P(IBRL0,U,4) S IBX=$P($$CPT^ICPTCOD(+$P(IBRL0,U,4)),U,2),IBY=$$SETFLD^VALM1(IBX,IBY,"PRC2")
 .. S IBX=$P($G(^DGCR(399.2,+$P(IBRL0,U,1),0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"RVCD")
 .. S IBX=$P($G(^DGCR(399.2,+$P(IBRL0,U,1),0)),U,2),IBY=$$SETFLD^VALM1(IBX,IBY,"RVDS")
 .. S IBX=$P($G(^IBE(363.32,+$P(IBRL0,U,2),0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"SGRP")
 .. D SET(IBY) S IBY=""
 .. ;
 .. S IBLABEL="applied to bills for:"
 .. S IBBRFN=0 F  S IBBRFN=$O(BRCSARR(IBRLFN,IBBRFN)) Q:'IBBRFN  D
 ... S IBCSFN="" F  S IBCSFN=$O(BRCSARR(IBRLFN,IBBRFN,IBCSFN)) Q:IBCSFN=""  D  Q:'IBCSFN
 .... S IBX=IBLABEL,IBY=$$SETFLD^VALM1(IBX,IBY,"RVDS"),IBLABEL=""
 .... I +IBCSFN S IBX=$P($G(^IBE(363.1,+IBCSFN,0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"SGRP")
 .... I 'IBCSFN S IBX=$P($G(^IBE(363.3,+IBBRFN,0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"SGRP")
 .... D SET(IBY) S IBY=""
 .. ;
 .. S IBY="" D SET(IBY) S IBY=""
 ;
 I VALMCNT=0 D SET(" "),SET("No Revenue Code links for this CPT.")
 Q
 ;
SET(X) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCRLM",$J,VALMCNT,0)=X
 Q
 ;
FNDSRT(CPT,CPTARR,BRARR) ; find and sort all revenue code links for a CPT
 ; array of all links for a CPT:   CPTARR(procedure 1, ifn of rev link) = special group
 ; array of links used on bills:   BRARR(ifn of rv link, billing rate, charge set) = special group
 N IBSGFN,IBSG0,IBRLFN,IBCPT1,IBSGFN1,IBSG10,IBX,RLARR K CPTARR,BRARR Q:'$G(CPT)
 ;
 S IBSGFN=0 F  S IBSGFN=$O(^IBE(363.32,IBSGFN)) Q:'IBSGFN  D
 . S IBSG0=$G(^IBE(363.32,IBSGFN,0)) I $P(IBSG0,U,2)'=1 Q
 . ;
 . ; find all revenue code links for the CPT
 . K RLARR S RLARR=1,IBX=$$GRVLNK^IBCRU6(CPT,IBSGFN,.RLARR) Q:'IBX
 . S IBRLFN=0 F  S IBRLFN=$O(RLARR(IBRLFN)) Q:'IBRLFN  D
 .. S IBCPT1=$P($G(^IBE(363.33,IBRLFN,0)),U,3)
 .. S CPTARR(IBCPT1,IBRLFN)=IBSGFN
 . ;
 . ; find the primary link to be used on a bill for the billing rates and charge sets
 . S IBSGFN1=0 F  S IBSGFN1=$O(^IBE(363.32,IBSGFN,11,IBSGFN1)) Q:'IBSGFN1  D
 .. S IBSG10=$G(^IBE(363.32,IBSGFN,11,IBSGFN1,0))
 .. S IBRLFN=$$RVLNK^IBCRU6(CPT,+$P(IBSG10,U,1),+$P(IBSG10,U,2))
 .. I +IBRLFN S BRARR(+IBRLFN,+$P(IBSG10,U,1),+$P(IBSG10,U,2))=IBSGFN
 ;
 Q
