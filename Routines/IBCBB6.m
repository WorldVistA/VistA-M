IBCBB6 ;ALB/BGA - CONT. OF MEDICARE EDIT CHECKS ;08/12/98
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified
 ;
 ; Occurrence Span Codes and Dates
 ; occ span 74 req admit and discharge of hosp stays for bill types
 ; 13x,23x,72x,74x,75x
 ;I $D(IBOCSP(74)),"^13^23^72^74^75^"[(U_IBTOB12_U),('IBZADMIT!'IBZDISCH) S IBQUIT=$$IBER^IBCBB3(.IBER,169) Q:IBQUIT
 ; Internal Control Number (ICN) or Document Control Number (DCN)
 I ($E(IBTOB,3)=7!($E(IBTOB,3)=8)),$P(IBNDUF3,U,4)="" S IBQUIT=$$IBER^IBCBB3(.IBER,174) Q:IBQUIT
 ;
 D ^IBCBB7
 Q
