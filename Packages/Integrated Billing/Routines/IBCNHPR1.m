IBCNHPR1 ;ALB/CJS - HPID ADDED TO BILLING CLAIM REPORT (COMPILE) ;12-DEC-14
V ;;2.0;INTEGRATED BILLING;**525**;21-MAR-94;Build 105
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Queued Entry Point for Report.
 ;  Required variable input:  IBBEG, IBEND, IBOUT
 ;
 N IBCLAIM,IBCNS,IBDATE,IBIND,IBSTA
 ;
 ; - compile report data
 K ^TMP($J,"IBHP")
 S IBBEG=$G(IBBEG)-.01,IBEND=$S('$G(IBEND):9999999,1:$P(IBEND,".")+.9)
 S U="^",IBSTA=$P($$SITE^VASITE(),U,3)
 ;
 ; - Loop through all HPID EDIT DATE/TIME fields within date range
 F IBIND="E","F","G" D
 .S IBDATE=+IBBEG F  S IBDATE=$O(^DGCR(399,IBIND,IBDATE)) Q:'IBDATE!(IBDATE>IBEND)  D
 ..S IBCLAIM=0 F  S IBCLAIM=$O(^DGCR(399,IBIND,IBDATE,IBCLAIM)) Q:'IBCLAIM  I $D(^DGCR(399,IBCLAIM)),($$GET1^DIQ(399,IBCLAIM,.13)="AUTHORIZED") D GATH
 ;
PRINT ; - print report
 D EN^IBCNHPR2(IBOUT)
 K ^TMP($J,"IBHP")
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBCLAIM,IBCNS,IBDATE,IBIND,IBSTA
 Q
 ;
 ;
GATH ; Gather all relevant data for a claim.
 ;
 ; Get Insurance Company ID
 S IBCNS=$$GET1^DIQ(399,IBCLAIM,$S(IBIND="E":101,IBIND="F":102,IBIND="G":103,1:""),"I")
 ;
 ; - set final bill/claim info
 S ^TMP($J,"IBHP",IBDATE,IBCLAIM,IBIND)=$$CLAIMINF(IBCLAIM)_U_$$COMPINF(IBCNS)
 Q
 ;
 ;
CLAIMINF(IBCLAIM) ; Return formatted Insurance Plan information.
 ;  Input:  IBCLAIM  --  Pointer to the claim in file #399
 ; Output:  patient name ^ last 4 SSN ^ insurance company name ^ HPID ^ station number-claim number ^ user name ^ date HPID added
 ;
 N IBNAME,IBPAT,IBSSN,IBINSNM,IBHPID,IBCLNM,IBUSER,IBHPDT
 ;
 S IBNAME=$$GET1^DIQ(399,IBCLAIM,.02)
 S IBPAT=$$GET1^DIQ(399,IBCLAIM,.02,"I")
 S IBSSN=$E($$GET1^DIQ(2,IBPAT,.09),6,9)
 S IBINSNM=$$GET1^DIQ(399,IBCLAIM,$S(IBIND="E":101,IBIND="F":102,IBIND="G":103,1:""))
 S IBHPID=$$GET1^DIQ(399,IBCLAIM,$S(IBIND="E":471,IBIND="F":472,IBIND="G":473,1:""))
 S IBCLNM=$$GET1^DIQ(399,IBCLAIM,.01)
 S IBUSER=$$GET1^DIQ(399,IBCLAIM,$S(IBIND="E":475,IBIND="F":477,IBIND="G":479,1:""))
 S IBHPDT=$$GET1^DIQ(399,IBCLAIM,$S(IBIND="E":474,IBIND="F":476,IBIND="G":478,1:""),"I")
 S IBHPDT=$$FMTE^XLFDT(IBHPDT,"5DZ")
 Q IBNAME_U_IBSSN_U_IBINSNM_U_IBHPID_U_IBSTA_"-"_IBCLNM_U_IBUSER_U_IBHPDT
 ;
COMPINF(IBCNS) ; Return formatted Insurance Company information
 ;  Input:  IBCNS  --  Pointer to the insurance company in file #36
 ; Output:  professional ID ^ institutional ID
 ;
 N IBPID,IBIID
 ;
 S IBPID=$$GET1^DIQ(36,IBCNS,3.02)
 S IBIID=$$GET1^DIQ(36,IBCNS,3.04)
 Q IBPID_U_IBIID
