IB20P619 ;ALB/CXW - REMOVE TC MODIFIER FOR MEDICARE ;02/08/2018
 ;;2.0;INTEGRATED BILLING;**619**;21-MAR-94;Build 34
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ;
 N IBZ,U S U="^"
 D MSG("    IB*2.0*619 Post-Install starts .....")
 D MSG(""),RMTC,MSG("")
 D MSG("    IB*2.0*619 Post-Install is complete.")
 Q
 ;
RMTC ; Remove TC modifier for Medicare in file (#399)
 N IBA,IBBCT,IBBCPT,IBCHG,IBCNT,IBEDT,IBFND,IBIFN,IBLN,IBMCR,IBMODS,IBTC,IBVDT,IB26
 ; effective date 01/11/18 of TC modifier auto added to institutional claims
 S IBCNT=0,IBEDT=3180110
 S IBTC=+$$MOD^ICPTMOD("TC","E") I IBTC<1 D MSG("TC Modifier not defined, the BILL/CLAIMS (#399) file not updated") Q
 S IB26=+$$MOD^ICPTMOD("26","E") I IB26<1 D MSG("26 Modifier not defined, the BILL/CLAIMS (#399) file not updated") Q
 F  S IBEDT=$O(^DGCR(399,"D",IBEDT)) Q:'IBEDT  S IBIFN=0 D
 . F  S IBIFN=$O(^DGCR(399,"D",IBEDT,IBIFN)) Q:'IBIFN  S IBFND=0 D
 .. S IBA=$G(^DGCR(399,IBIFN,0)) Q:IBA=""
 .. S IBBCT=$P(IBA,U,27) Q:'IBBCT
 .. ; Medicare claim or quit
 .. S IBMCR=$$MCRB(IBIFN) Q:'IBMCR
 .. S IBBCPT=0 F  S IBBCPT=$O(^DGCR(399,IBIFN,"CP",IBBCPT)) Q:'IBBCPT  D
 ... S IBLN=$G(^DGCR(399,IBIFN,"CP",IBBCPT,0))  Q:IBLN'[";ICPT("
 ... S IBVDT=$P(IBLN,U,2)
 ... S IBCHG=$$CHGMOD^IBCRCU1(IBIFN,+IBLN,IBVDT,2)
 ... I (+IBCHG'=1)!(+$P(IBCHG,":",3)'=IB26) Q
 ... S IBMODS=","_$$GETMOD^IBEFUNC(IBIFN,IBBCPT)_","
 ... ; institutional charge type, tc modifier 
 ... I IBBCT=1,$F(IBMODS,","_IBTC_",") D DELMOD^IBCU73(IBIFN,IBBCPT,IBTC) S IBFND=1
 .. S:IBFND IBCNT=IBCNT+1
 D MSG("TC modifier removed for Medicare on total "_IBCNT_" bill"_$S(IBCNT'=1:"s",1:"")_" of the BILL/CLAIMS (#399) file")
 Q
MSG(IBZ) ;
 D MES^XPDUTL(IBZ)
 Q
 ;
MCRB(IBIFN) ; No TC modifier for Medicare
 ; input-IBIFN, output-1 if payer sequence is primary and 1st or 2nd payer is Medicare, otherwise 0
 N IBMCR,IBCOB S IBMCR=0
 S IBCOB=$$COBN^IBCEF(IBIFN)
 I IBCOB=1 I ($$WNRBILL^IBEFUNC(IBIFN,1))!($$WNRBILL^IBEFUNC(IBIFN,2)) S IBMCR=1
 Q IBMCR
 ;
