IBJTLA1 ;ALB/ARH - TPI ACTIVE BILLS LIST BUILD ;2/14/95
 ;;2.0;INTEGRATED BILLING;**39,80,61,51,153,137,183,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BLDA ; build active list for third party joint inquiry active list
 N IBIFN,IBCNT S VALMCNT=0,IBCNT=0
 S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"C",DFN,IBIFN)) Q:'IBIFN  I $$ACTIVE^IBJTU4(IBIFN) W "." D SCRN
 ;
 I VALMCNT=0 D SET(" ",0),SET("No Active Bills for this Patient",0)
 ;
 Q
 ;
SCRN ; add bill to screen list (IBIFN,DFN must be defined)
 N X,IBY,IBD0,IBDU,IBDM S X=""
 S IBCNT=IBCNT+1,IBD0=$G(^DGCR(399,+IBIFN,0)),IBDU=$G(^DGCR(399,+IBIFN,"U")),IBDM=$G(^DGCR(399,+IBIFN,"M"))
 S IBY=IBCNT,X=$$SETFLD^VALM1(IBY,X,"NUMBER")
 S IBY=$P(IBD0,U,1)_$$ECME^IBTRE(IBIFN),X=$$SETFLD^VALM1(IBY,X,"BILL")
 S IBY=$S($$REF^IBJTU31(+IBIFN):"r",1:""),X=$$SETFLD^VALM1(IBY,X,"REFER")
 S IBY=$S($$IB^IBRUTL(+IBIFN,0):"*",1:""),X=$$SETFLD^VALM1(IBY,X,"HD")
 S IBY=$$DATE($P(IBDU,U,1)),X=$$SETFLD^VALM1(IBY,X,"STFROM")
 S IBY=$$DATE($P(IBDU,U,2)),X=$$SETFLD^VALM1(IBY,X,"STTO")
 ;
 S IBY=$P($$LST^DGMTU(DFN,$P(IBDU,U)),U,4),IBY=$S(IBY="C":"YES",IBY="P":"PEN",IBY="R":"REQ",IBY="G":"GMT",1:"NO"),X=$$SETFLD^VALM1(IBY,X,"MT?")
 S IBY=$$TYPE($P(IBD0,U,5))_$$TF($P(IBD0,U,6)),X=$$SETFLD^VALM1(IBY,X,"TYPE")
 S IBY=" "_$P($$ARSTATA^IBJTU4(IBIFN),U,2),X=$$SETFLD^VALM1(IBY,X,"ARST")
 ;
 S IBY=$P($G(^DGCR(399.3,+$P(IBD0,U,7),0)),U,4),X=$$SETFLD^VALM1(IBY,X,"RATE")
 S IBY=$S($$MINS^IBJTU31(+IBIFN):"+",1:""),X=$$SETFLD^VALM1(IBY,X,"CB")
 S IBY=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBY,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBY=+$$CURR^IBCEF2(IBIFN)
 S IBY=$P($G(^DIC(36,+IBY,0)),U,1)
 S X=$$SETFLD^VALM1(IBY,X,"INSUR")
 S IBY=$$BILL^RCJIBFN2(IBIFN)
 S X=$$SETFLD^VALM1($J(+$P(IBY,U,1),8,2),X,"OAMT")
 S X=$$SETFLD^VALM1($J(+$P(IBY,U,3),8,2),X,"CAMT")
 D SET(X,IBCNT)
 Q
 ;
DATE(X) ; date in external format
 N Y S Y="" I X?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
TYPE(X) ; return abbreviated form of Bill Classification (399,.05)
 Q $S(X=1:"IP",X=2:"IH",X=3:"OP",X=4:"OH",1:"")
 ;
TF(X) ; return abbreviated form of Timeframe of Bill (399,.06)
 Q $S(X=2:"-F",X=3:"-C",X=4:"-L",X'=1:"-O",1:"")
 ;
SET(X,CNT) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBJTLA",$J,VALMCNT,0)=X Q:'CNT
 S ^TMP("IBJTLA",$J,"IDX",VALMCNT,+CNT)=""
 S ^TMP("IBJTLAX",$J,CNT)=VALMCNT_U_IBIFN
 Q
 ;
