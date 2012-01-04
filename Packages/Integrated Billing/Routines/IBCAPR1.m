IBCAPR1 ;ALB/GEF - CAPR PRINT FUNCTIONS ;OCT 1 2010
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
STFLP(IBIFN) ;Secondary/Tertiary Force Local Print
 ; Forces automatically generated secondary/tertiary claims to electronic payers to print 
 ; locally based upon flag in the Insurance Company file 
 ; Required input = IBIFN (claim internal entry#)
 ; Returns 1 if printed successfully
 ; Otherwise, returns 0^Reason not printed
 ;
 N IBF,IB,IBFT,IBJ,IBDV,Z,IBINS
 S Z=$$COBN^IBCEF(IBIFN)
 S IBINS=$$POLICY^IBCEF(IBIFN,1,Z)
 Q:$P($G(^DIC(36,IBINS,6)),U,9)'=1 "0^Insurance Company not set to print locally"
 S IB=$$FT^IBCU3(IBIFN) ; form type ien (2 or 3)
 Q:"2^3"'[IB "0^Form type not 2 or 3"
 S IBFT=$$FTN^IBCU3(IB) ; form type name
 S IBF=$P($G(^IBE(353,+IB,2)),U,8)
 S:IBF="" IBF=IB ;Forces the use of the output formatter to print bills
 ; get default CMS or UB printer (based on claim form type)
 S IBDV=$S(IB=2:$$CMS1500(),1:$$UB4PRT())
 Q:IBDV="" "0^Auto-printer not defined in IB Site Parameters"
 Q:'$$FORM(IBF,IB,IBDV) "0^Claim Print not tasked"
 K ^TMP("IBQONE",$J)
 I IBF=2 D RXP
 ; Print EOB
 Q $$PRINT8Q^IBCAPR(IBIFN)
 ;
RXP ;queue an Rx Addendum for a bill, IBIFN must be defined
 N IBFORM1
 Q:'$D(^DGCR(399,+$G(IBIFN),0))  I '$D(^IBA(362.4,"AIFN"_+IBIFN)),'$D(^IBA(362.5,"AIFN"_+IBIFN)) Q
 N IBFT S IBFT=$$FNT^IBCU3("BILL ADDENDUM") Q:'IBFT  S (IBFORM1,ZTDESC)="BILL ADDENDUM FOR "_$P(^DGCR(399,+IBIFN,0),U,1)
 S ZTSAVE("IB*")="",ZTDTH=$H
 S ZTIO=$P($G(^IBE(353,IBFT,0)),"^",2),ZTRTN=$G(^IBE(353,IBFT,1)) I (ZTIO="")!(ZTRTN="") K ZTDESC,ZTSAVE,ZTDTH,ZTIO,ZTRTN Q
 D ^%ZTLOAD
 Q
 ;
FORM(IBFORM,IB,IBQUE) ;For ien IBFORM, extract data using output generater
 ; Queued job entrypoint - IBFORM needs to be defined
 ; IBQUE = the output queue for transmitted forms or the printer queue
 ;          for printed output
 ; Returns ZTSK if job is queued sucessfully
 ;
 N ZTIO,ZTRTN,ZTDESC,ZTSAVE,ZTREQ,ZTDTH,IBFT,IBFTP,IBJ,ZTSK
 S %ZIS="QN"
 S IBFT=IB,IBFTP="IBCFP"_IB,IBJ=$J
 K ^XTMP(IBFTP,$J),^TMP("IBQONE",$J)
 S ^XTMP(IBFTP,$J,1,1,1,IBIFN)="",^TMP("IBQONE",$J)=""
 S ZTRTN="FORMOUT^IBCEFG7",ZTIO=IBQUE,ZTDESC="OUTPUT FORMATTER - FORM: "_$P($G(^IBE(353,IBFORM,0)),U),ZTSAVE("IB*")="",ZTDTH=$$NOW^XLFDT()
 S:'$G(DUZ) DUZ=.5
 D ^%ZTLOAD
 Q:'$D(ZTSK) "0^Claim Print not tasked"
 Q "1^"_ZTSK
 ;
UB4PRT() ; Get UB4 Printer Name
 Q $$GET1^DIQ(350.9,"1, ",8.15)
 ;
CMS1500() ; Get CMS1500 Printer Name
 Q $$GET1^DIQ(350.9,"1, ",8.14)
 ;
