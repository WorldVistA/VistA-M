IBCBB9 ;ALB/BGA MEDICARE PART B EDIT CHECKS ;10/15/98
 ;;2.0;INTEGRATED BILLING;**51,137,155,349,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PARTB ; MEDICARE specific edit checks for PART B claims (CMS-1500)
 ;
 N IBXDATA,IBXERR,IBXIEN,IBXSAVE,IBPR,IBDTFLG
 ;
 I $$NEEDMRA^IBEFUNC(IBIFN) D
 . K IBXDATA
 . D F^IBCEF("N-HCFA 1500 SERVICE LINE (EDI)",,,IBIFN)
 . S IBI=0
 . F  S IBI=$O(IBXDATA(IBI)) Q:'IBI  D
 .. S IBJ=$P(IBXDATA(IBI),U,5)
 .. I IBJ'="","^CJ^HC^"[(U_$P(IBXDATA(IBI),U,6)_U) S IBPR(IBJ)=""
 . I $$REQMRA^IBEFUNC(IBIFN),$O(IBXDATA(""),-1)>12 D WARN^IBCBB11("This claim will be split into multiple EOB'S since there are more than 12"),WARN^IBCBB11("service lines being submitted on the claim.")
 . I $$REQMRA^IBEFUNC(IBIFN),$E(IBFDT,1,3)'=$E(IBTDT,1,3) D WARN^IBCBB11("This claim will be split into multiple EOB'S due to the service dates"),WARN^IBCBB11("spanning different calendar years.")
 . D NONMCR^IBCBB3(.IBPR,.IBLABS) ; Oxygen, labs, influenza shots
 . S Z="80000" F  S Z=$O(IBPR(Z)) Q:Z'?1"8"4N  S IBLABS=1
 . I $G(IBLABS) D WARN^IBCBB11("The only possible billable procedures on this bill are labs -"),WARN^IBCBB11(" Please verify that MEDICARE does not reimburse these labs at 100%") Q
 . I $O(IBPR(""))="" S IBQUIT=$$IBER^IBCBB3(.IBER,"098")
 ;
 ; First char of the pat's first and last name must be present and
 ; must be an alpha
 K IBXDATA D F^IBCEF("N-PATIENT NAME",,,IBIFN)
 S IBXDATA=$$NAME^IBCEFG1(IBXDATA)
 I $S($G(IBXDATA)="":1,$E($P(IBXDATA,U))=" "!($E($P(IBXDATA,U))'?1A):1,$E($P(IBXDATA,U,2))=" "!($E($P(IBXDATA,U,2))'?1A):1,1:0) S IBQUIT=$$IBER^IBCBB3(.IBER,300) Q:IBQUIT
 ;
 ; Must be a valid HIC #
 I '$$VALID^IBCBB8(IBIFN) S IBQUIT=$$IBER^IBCBB3(.IBER,215) Q:IBQUIT
 ;
 ; Specialty code 99 is not valid for Medicare MRA request claims
 I $$REQMRA^IBEFUNC(IBIFN),$$BILLSPEC^IBCEU3(IBIFN)=99 S IBQUIT=$$IBER^IBCBB3(.IBER,122) Q:IBQUIT
 ;
 Q
 ;
