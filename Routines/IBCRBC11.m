IBCRBC11 ;ALB/ARH - RATES: BILL CALCULATION BILLABLE EVENTS ;10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,245,155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; continuation of IBCRBC1
 ;
INPTDRG(IBIFN,RS,CS) ; Determine charges for INPATIENT DRG billable events
 ; - the billable events are DRG's, the Transfer DRG of the patient treating specialties movements,
 ;   pulled from the PTF record each time the charges are calculated (INPTPTF^IBCRCG)
 ; - each day of billable care is calculated separately in case a rate becomes in/active
 ; - if bedsection is ICU then allow ICU Charge Set only
 ;
 N IBX,IBBLITEM,IBCHGMTH,IBEVDT,IBIDRC,IBBS,IBITM,IBTYPE,IBCMPNT,IBSAVE I '$G(IBIFN)!'$G(CS) Q
 ;
 D INPTPTF^IBCRBG(IBIFN,CS)
 ;
 S IBTYPE=6,IBCMPNT=$P($G(^IBE(363.1,+CS,0)),U,4),IBX=$$CSBR^IBCRU3(CS),IBBLITEM=$P(IBX,U,4),IBCHGMTH=$P(IBX,U,5)
 S IBIDRC=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBIDRC,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBIDRC=$$CURR^IBCEF2(IBIFN)
 S IBIDRC=$G(^DIC(36,+IBIDRC,0)),IBIDRC=$P(IBIDRC,U,7)
 ;
 S IBBDIV=$P($G(^DGCR(399,+IBIFN,0)),U,22) ; bill's default division
 ;
 I IBBLITEM=4,IBCHGMTH=1 D  ; inpt/DRG/per diem
 . S IBEVDT="" F  S IBEVDT=$O(^TMP($J,"IBCRC-INDT",IBEVDT)) Q:IBEVDT=""  D
 .. ;
 .. S IBX=$G(^TMP($J,"IBCRC-INDT",IBEVDT)),IBITM=$P(IBX,U,4),IBBS=$P(IBX,U,2),IBDIV=$P(IBX,U,5) Q:'IBITM
 .. ;
 .. I '$$CHGICU^IBCRBC2(CS,IBBS) Q  ; check icu charges are applied to icu bedsection
 .. ;
 .. I $$CSDV^IBCRU3(CS,IBDIV,IBBDIV)<0 Q  ; check division
 .. ;
 .. S IBSAVE="1^^"_IBDIV_"^"_IBTYPE_"^"_IBITM_"^"_IBCMPNT_"^"_IBBS
 .. D BITMCHG^IBCRBC2(RS,CS,IBITM,IBEVDT,1,"","",IBIDRC,IBSAVE)
 K ^TMP($J,"IBCRC-INDT")
 Q
 ;
UNASSOC(IBIFN,RS,CS,IBMIARR) ; Determine charges for UNASSOCIATED billable events
 ; - the billable event is not associated with any data element on the bill
 ; - the item to charge is selected by the user from the list of billing items (363.21)
 ; - the items the user selected to add charges to the bill for are passed in in array IBMIARR
 ; - if the charge set is limited by region then either the items division or if no item division then the bill's
 ;   Default Division must be contained in the sets region
 ;
 N IBX,IBBLITEM,IBCHGMTH,IBIDRC,IBBDIV,IBI,IBITM,IBEVDT,IBTUNITS,IBDIV,IBRVCD,IBTYPE,IBCMPNT,IBSAVE
 I '$G(IBIFN)!'$G(CS)!'$G(IBMIARR) Q
 ;
 S IBTYPE=9,IBCMPNT=$P($G(^IBE(363.1,+CS,0)),U,4),IBX=$$CSBR^IBCRU3(CS),IBBLITEM=$P(IBX,U,4),IBCHGMTH=$P(IBX,U,5)
 S IBIDRC=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBIDRC,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBIDRC=$$CURR^IBCEF2(IBIFN)
 S IBIDRC=$G(^DIC(36,+IBIDRC,0)),IBIDRC=$P(IBIDRC,U,7)
 ;
 S IBBDIV=$P($G(^DGCR(399,+IBIFN,0)),U,22) ; bill's default division
 ;
 I IBBLITEM=9,IBCHGMTH=1 D  ; charge per item
 . S IBI=0 F  S IBI=$O(IBMIARR(RS,CS,IBI)) Q:'IBI  D
 .. S IBX=IBMIARR(RS,CS,IBI),IBITM=+$P(IBX,U,1),IBEVDT=$P(IBX,U,2)
 .. S IBTUNITS=$P(IBX,U,3),IBDIV=$P(IBX,U,4),IBRVCD=$P(IBX,U,5)
 .. ;
 .. I $$CSDV^IBCRU3(CS,IBDIV,IBBDIV)<0 Q  ; check division
 .. ;
 .. S IBSAVE=IBTUNITS_"^^"_IBDIV_"^"_IBTYPE_"^"_IBITM_"^"_IBCMPNT
 .. D BITMCHG^IBCRBC2(RS,CS,IBITM,IBEVDT,1,"",IBRVCD,IBIDRC,IBSAVE)
 Q
