IBJTLB1 ;ALB/ARH - TPI INACTIVE LIST BUILD ;2/14/95
 ;;2.0;INTEGRATED BILLING;**39,80,61,137,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BLDA ; build active list for third party joint inquiry active list, DFN must be defined
 ; first search starts at dt and works backwards for 6 months of bills or IBMAXCNT bills, whichever is greater
 ; all bills for a single day are included in the same search so even IBMAXCNT may be exceeded
 ; if IBEND is defined on entry it is used as the end dt of the search, otherwise DT is used
 ; IBBEG is left defined on exit, if it has a value then it is used by the Change Dates action to define the next
 ; end date of the search, this results in each CD action default working backwards through the date range until
 ; no bills are found and IBBEG is null then search restarts at DT, IBEND is defined so can tell if range changed
 N IBIFN,IBCNT,IBBDT,IBEDT,IBFIRST,IBLAST,IBDT1,IBDT2,IBMAXCNT K IBHMSG
 S IBEDT=$S(+$G(IBEND):IBEND,1:DT),IBBDT=$$FMADD^XLFDT(IBEDT,-180),IBMAXCNT=52
 ;
 S (VALMCNT,IBCNT)=0,IBDT1=$S(IBEDT'="":-(IBEDT+.01),1:""),IBDT2=-IBBDT
 S IBFIRST=IBBDT,IBLAST=-$O(^DGCR(399,"APDS",DFN,""))
 ;
 F  S IBDT1=$O(^DGCR(399,"APDS",DFN,IBDT1)) Q:'IBDT1!(IBDT1>IBDT2&(IBCNT'<IBMAXCNT))  S IBFIRST=-IBDT1 D
 . S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"APDS",DFN,IBDT1,IBIFN)) Q:'IBIFN  I '$$ACTIVE^IBJTU4(IBIFN) D SCRN W "."
 ;
 S IBBEG=$S('IBDT1:"",IBBDT>IBFIRST:IBFIRST,1:IBBDT),IBBDT=$S(+IBBEG:$$DATE(IBBEG),1:"BEGIN")
 S IBEND=$S(IBEDT=""!(IBLAST'>IBEDT):"",1:IBEDT),IBEDT=$S(+IBEND:$$DATE(IBEND),1:"END")
 ;
 I 'IBBEG,'IBEND S IBHMSG="** All Inactive Bills **"
 I $G(IBHMSG)="" S IBHMSG=IBBDT_" - "_IBEDT
 S IBHMSG=IBHMSG_"   ("_VALMCNT_")"
 ;
 I VALMCNT=0 D SET(" ",0),SET("No Inactive Bills for this Patient",0)
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
 S IBY=$$TYPE($P(IBD0,U,5))_$$TF($P(IBD0,U,6)),X=$$SETFLD^VALM1(IBY,X,"TYPE")
 S IBY=" "_$P($$ARSTATA^IBJTU4(IBIFN),U,2),X=$$SETFLD^VALM1(IBY,X,"ARST")
 ;
 S IBY=$P($G(^DGCR(399.3,+$P(IBD0,U,7),0)),U,4),X=$$SETFLD^VALM1(IBY,X,"RATE")
 S IBY=$S($$MINS^IBJTU31(IBIFN):"+",1:""),X=$$SETFLD^VALM1(IBY,X,"CB")
 S IBY=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBY,$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN)) S IBY=+$$CURR^IBCEF2(IBIFN)
 S IBY=$P($G(^DIC(36,+IBY,0)),U,1),X=$$SETFLD^VALM1(IBY,X,"INSUR")
 S IBY=$$BILL^RCJIBFN2(IBIFN)
 S X=$$SETFLD^VALM1($J(+$P(IBY,U,1),8,2),X,"OAMT")
 S X=$$SETFLD^VALM1($J(+$P(IBY,U,3),8,2),X,"CAMT")
 D SET(X,IBCNT)
 Q
 ;
DATE(X) ; date in external format
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
TYPE(X) ; return abbreviated form of Bill Classification (399,.05)
 Q $S(X=1:"IP",X=2:"IH",X=3:"OP",X=4:"OH",1:"")
 ;
TF(X) ; return abbreviated form of Timeframe of Bill (399,.06)
 Q $S(X=2:"-F",X=3:"-C",X=4:"-L",X'=1:"-O",1:"")
 ;
SET(X,CNT) ; set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBJTLB",$J,VALMCNT,0)=X Q:'CNT
 S ^TMP("IBJTLB",$J,"IDX",VALMCNT,+CNT)=""
 S ^TMP("IBJTLBX",$J,CNT)=VALMCNT_U_IBIFN
 Q
