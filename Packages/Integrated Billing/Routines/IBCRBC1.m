IBCRBC1 ;ALB/ARH - RATES: BILL CALCULATION BILLABLE EVENTS ; 22 MAY 96
 ;;2.0;INTEGRATED BILLING;**52,80,106,138,51,148,245,270,370**;21-MAR-94;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; For each type of Billable Event, search for items on the bill and calculate the charges
 ;  1) search the bill for items of the billable event type
 ;  2) determine how the charges should be calculated, based on Billable Item and Charge Method of the Set's Rate
 ;  3) calculate charges
 ; For per diem Billing Rates, no item pointers are passed since all items have a standard charge
 ; The Insurance Company Different Revenue Codes to Use (36,.07) is passed so standard rev codes can be replaced
 ; The Charge Type (363.1,.04) is passed so it can be added to the charge on the bill if it is defined for a Set
 ; Output:  ^TMP($J,"IBCRCC")= ..., (created in IBCRBC2 based on charge items found here)
 ;
INPTBS(IBIFN,RS,CS) ; Determine charges for INPATIENT BEDSECTION STAY billable events
 ; - the billable events are billable bedsections based on the patient movement treating specialties,
 ;   these are pulled from the PTF record each time the charges are calculated (INPTPTF^IBCRCG)
 ; - each day of billable care is calculated separately in case a rate becomes inactive
 ;
 N IBX,IBBLITEM,IBCHGMTH,IBEVDT,IBIDRC,IBBDIV,IBITM,IBDIV,IBTYPE,IBCMPNT,IBSAVE I '$G(IBIFN)!'$G(CS) Q
 ;
 D INPTPTF^IBCRBG(IBIFN,CS)
 ;
 S IBTYPE=1,IBCMPNT=$P($G(^IBE(363.1,+CS,0)),U,4),IBX=$$CSBR^IBCRU3(CS),IBBLITEM=$P(IBX,U,4),IBCHGMTH=$P(IBX,U,5)
 S IBIDRC=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBIDRC,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBIDRC=$$CURR^IBCEF2(IBIFN)
 S IBIDRC=$G(^DIC(36,+IBIDRC,0)),IBIDRC=$P(IBIDRC,U,7)
 ;
 S IBBDIV=$P($G(^DGCR(399,+IBIFN,0)),U,22) ; bill's default division
 ;
 I IBBLITEM=1,IBCHGMTH=1 D  ; inpt/bedsection/per diem
 . S IBEVDT="" F  S IBEVDT=$O(^TMP($J,"IBCRC-INDT",IBEVDT)) Q:'IBEVDT  D
 .. S IBX=$G(^TMP($J,"IBCRC-INDT",IBEVDT)),IBITM=+$P(IBX,U,2),IBDIV=$P(IBX,U,5)
 .. ;
 .. I $$CSDV^IBCRU3(CS,IBDIV,IBBDIV)<0 Q  ; check division
 .. ;
 .. S IBSAVE="1^^"_IBDIV_"^"_IBTYPE_"^^"_IBCMPNT
 .. D BITMCHG^IBCRBC2(RS,CS,IBITM,IBEVDT,1,"","",IBIDRC,IBSAVE)
 K ^TMP($J,"IBCRC-INDT")
 Q
 ;
OPTVST(IBIFN,RS,CS) ; Determine charges for OUTPATIENT VISIT DATE billable events
 ; - the billable event is the outpatient visit date(s) on the bill (399,43)
 ;
 N IBX,IBBLITEM,IBCHGMTH,IBIDRC,IBOPVARR,IBI,IBEVDT,IBTYPE,IBCMPNT,IBSAVE I '$G(IBIFN)!'$G(CS) Q
 ;
 D OPTVD^IBCRBG1(IBIFN,.IBOPVARR) Q:'IBOPVARR
 ;
 S IBTYPE=2,IBCMPNT=$P($G(^IBE(363.1,+CS,0)),U,4),IBX=$$CSBR^IBCRU3(CS),IBBLITEM=$P(IBX,U,4),IBCHGMTH=$P(IBX,U,5)
 S IBIDRC=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBIDRC,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBIDRC=$$CURR^IBCEF2(IBIFN)
 S IBIDRC=$G(^DIC(36,+IBIDRC,0)),IBIDRC=$P(IBIDRC,U,7)
 ;
 I IBBLITEM=1,IBCHGMTH=1 D  ; opt vst/bedsection/per diem
 . S IBI="" F  S IBI=$O(IBOPVARR(IBI)) Q:IBI=""  D
 .. S IBEVDT=IBOPVARR(IBI)
 .. S IBSAVE="1^^^"_IBTYPE_"^^"_IBCMPNT
 .. D ALLBEDS^IBCRBC2(RS,CS,IBEVDT,"",IBIDRC,IBSAVE)
 Q
 ;
RX(IBIFN,RS,CS) ; Determine charges for PRESCRIPTION billable events
 ; - the billable event is an rx that has been added to the bill (362.4)
 ; - the insurance company Prescription Refill Rev Code (36,.15) is passed to the calculator to be used as
 ;   the rev code for all Rx charges, all types, this overrides the rev codes for the set or item
 ; - on HCFA 1500, the site parameter Default Rx Refill CPT (350.9,1.3) is added as the CPT to all Rx RC entries
 ;
 N IBX,IBBLITEM,IBCHGMTH,IBRXCPT,IBIDRC,IBIRC,IBRXARR,IBRX,IBEVDT,IBUNIT,IBITM,IBNDC,IBTYPE,IBCMPNT,IBSAVE
 I '$G(IBIFN)!'$G(CS) Q
 ;
 D SET^IBCSC5A(IBIFN,.IBRXARR) Q:'$P(IBRXARR,U,2)
 ;
 S IBTYPE=3,IBCMPNT=$P($G(^IBE(363.1,+CS,0)),U,4),IBX=$$CSBR^IBCRU3(CS),IBBLITEM=$P(IBX,U,4),IBCHGMTH=$P(IBX,U,5)
 S IBIDRC=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBIDRC,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBIDRC=$$CURR^IBCEF2(IBIFN)
 S IBIDRC=$G(^DIC(36,+IBIDRC,0)),IBIRC=$P(IBIDRC,U,15),IBIDRC=$P(IBIDRC,U,7)
 ;
 S IBRXCPT="" I $$FT^IBCU3(IBIFN)=2 S IBRXCPT=$P($G(^IBE(350.9,1,1)),U,30)
 ;
 I IBBLITEM=1,IBCHGMTH=1 D  ; rx refill/bedsection/per diem
 . S IBRX="" F  S IBRX=$O(IBRXARR(IBRX)) Q:IBRX=""  D
 .. S IBEVDT=0 F  S IBEVDT=$O(IBRXARR(IBRX,IBEVDT)) Q:'IBEVDT  D
 ... ;
 ... S IBSAVE="1^"_IBRXCPT_"^^"_IBTYPE_"^"_+IBRXARR(IBRX,IBEVDT)_"^"_IBCMPNT
 ... D ALLBEDS^IBCRBC2(RS,CS,IBEVDT,IBIRC,IBIDRC,IBSAVE)
 ;
 I IBBLITEM=3,IBCHGMTH=3 D  ; ndc/quantity
 . S IBRX="" F  S IBRX=$O(IBRXARR(IBRX)) Q:IBRX=""  D
 .. S IBEVDT=0 F  S IBEVDT=$O(IBRXARR(IBRX,IBEVDT)) Q:'IBEVDT  D
 ... S IBX=IBRXARR(IBRX,IBEVDT),IBITM=+IBX,IBUNIT=$P(IBX,U,4),IBNDC=$P(IBX,U,5) Q:IBNDC=""
 ... S IBNDC=$O(^IBA(363.21,"B",IBNDC,0)) Q:'IBNDC
 ... S IBSAVE="1^"_IBRXCPT_"^^"_IBTYPE_"^"_IBITM_"^"_IBCMPNT
 ... D BITMCHG^IBCRBC2(RS,CS,IBNDC,IBEVDT,IBUNIT,"",IBIRC,IBIDRC,IBSAVE)
 ;
 I IBCHGMTH=2 D  ; va cost
 . S IBRX="" F  S IBRX=$O(IBRXARR(IBRX)) Q:IBRX=""  D
 .. S IBEVDT=0 F  S IBEVDT=$O(IBRXARR(IBRX,IBEVDT)) Q:'IBEVDT  D
 ... S IBX=IBRXARR(IBRX,IBEVDT),IBITM=+IBX,IBUNIT=$P(IBX,U,4) Q:'IBITM
 ... S IBSAVE="1^"_IBRXCPT_"^^"_IBTYPE_"^"_IBITM_"^"_IBCMPNT
 ... D BITMCHG^IBCRBC2(RS,CS,IBITM,IBEVDT,IBUNIT,"",IBIRC,IBIDRC,IBSAVE)
 ;
 Q
 ;
CPT(IBIFN,RS,CS) ; Determine charges for PROCEDURE billable events
 ; - the billable event is a CPT procedure from the bill (399,304)
 ; - the item to be billed is a CPT, this may include Modifier
 ; - for each CPT found on the bill that has a modifier, will first check to see if that CPT-modifier
 ;   combination is billable (ie. is defined as a charge item for the Billing Rate, does not have to be active)
 ;   if it does not then assumes the charge should be the CPT charge
 ; - if the charge set is limited by region then either the CPT's division or if no CPT division then the bill's
 ;   Default Division must be contained in the sets region
 ; - the billable CPT is added as the CPT of the charge entry, Division is also added if defined for the CPT
 ; - the procedures provider may affect the charges due to a provider discount
 ; - if an inpatient bill then the bedsection on date of procedure will be used as the default bedsection
 ; - different sets of charges apply to SNF and Inpatient care although the bill is defined as inpatient
 ; - the Default Rx CPT should not be billed the CPT charge, instead the Rx is charged
 ;
 N IBX,IBBLITEM,IBCHGMTH,IBBR,IBBDIV,IBIDRC,IBCPTARR,IBCPT,IBCPTFN,IBEVDT,IBMOD,IBDIV,IBTYPE,IBCMPNT
 N IBPPRV,IBBS,IBCLIN,IBOE,IBSAVE,IBUNIT,IBCPTRX,IBMODS I '$G(IBIFN)!'$G(CS) Q
 ;
 D CPT^IBCRBG1(IBIFN,.IBCPTARR) Q:'IBCPTARR
 ;
 S IBTYPE=4,IBCMPNT=$P($G(^IBE(363.1,+CS,0)),U,4),IBX=$$CSBR^IBCRU3(CS),IBBLITEM=$P(IBX,U,4),IBCHGMTH=$P(IBX,U,5)
 S IBIDRC=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBIDRC,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBIDRC=$$CURR^IBCEF2(IBIFN)
 S IBIDRC=$G(^DIC(36,+IBIDRC,0)),IBIDRC=$P(IBIDRC,U,7)
 S IBBR=$P(IBX,U,3) S IBCPTRX="" I $O(^IBA(362.4,"C",IBIFN,0)) S IBCPTRX=+$P($G(^IBE(350.9,1,1)),U,30)
 ;
 S IBBDIV=$P($G(^DGCR(399,+IBIFN,0)),U,22) ; bill's default division
 D INPTPTF^IBCRBG(IBIFN,CS) ; get inpatient bedsections
 ;
 I IBBLITEM=2 D  ; cpt/count/minutes/miles/hours
 . S IBCPT=0 F  S IBCPT=$O(IBCPTARR(IBCPT)) Q:'IBCPT  D
 .. S IBCPTFN=0 F  S IBCPTFN=$O(IBCPTARR(IBCPT,IBCPTFN)) Q:'IBCPTFN  D
 ... S IBX=IBCPTARR(IBCPT,IBCPTFN),IBEVDT=$P(IBX,U,1),(IBMOD,IBMODS)=$P(IBX,U,2)
 ... S IBDIV=$P(IBX,U,3),IBPPRV=$P(IBX,U,4),IBCLIN=$P(IBX,U,5),IBOE=$P(IBX,U,6)
 ... ;
 ... I '$$CHGOTH^IBCRBC2(IBIFN,RS,IBEVDT) Q
 ... I +IBCPTRX,'IBOE,IBCPT=IBCPTRX Q  ; site parameter rx procedure
 ... ;
 ... S IBUNIT=$$CPTUNITS^IBCRBC2(CS,IBCHGMTH,IBX) Q:'IBUNIT
 ... ;
 ... S IBBS=$P($G(^TMP($J,"IBCRC-INDT",IBEVDT)),U,2) ; get inpatient bedsection
 ... I 'IBBS S IBX=$O(^TMP($J,"IBCRC-INDT",IBEVDT),-1) I +IBX S IBBS=$P($G(^TMP($J,"IBCRC-INDT",IBX)),U,2)
 ... ;
 ... I '$P($$CPT^ICPTCOD(+IBCPT,+IBEVDT),U,7) Q  ; check is a valid active CPT
 ... I $$CSDV^IBCRU3(CS,IBDIV,IBBDIV)<0 Q  ; check division
 ... I +IBMOD S IBMOD=$P($$CPTMOD^IBCRCU1(CS,IBCPT,IBMOD,IBEVDT),",",1) ; check CPT-MODs for billable combination
 ... ;
 ... S IBSAVE="1^"_IBCPT_U_IBDIV_U_IBTYPE_U_IBCPTFN_U_IBCMPNT_U_IBBS_U_IBPPRV_U_IBCLIN_U_IBOE_U_IBMODS
 ... D BITMCHG^IBCRBC2(RS,CS,IBCPT,IBEVDT,IBUNIT,IBMOD,"",IBIDRC,IBSAVE)
 K ^TMP($J,"IBCRC-INDT")
 Q
 ;
PI(IBIFN,RS,CS) ; Determine charges for PROSTHETICS billable events
 ; - the billable event is a prosthetic item that has been added to the bill (362.5)
 ;
 N IBX,IBBLITEM,IBCHGMTH,IBPIARR,IBIDRC,IBEVDT,IBPI,IBITM,IBTYPE,IBCMPNT,IBSAVE I '$G(IBIFN)!'$G(CS) Q
 ;
 D SET^IBCSC5B(IBIFN,.IBPIARR) Q:'$P(IBPIARR,U,2)
 ;
 S IBTYPE=5,IBCMPNT=$P($G(^IBE(363.1,+CS,0)),U,4),IBX=$$CSBR^IBCRU3(CS),IBBLITEM=$P(IBX,U,4),IBCHGMTH=$P(IBX,U,5)
 S IBIDRC=+$G(^DGCR(399,+IBIFN,"MP"))
 I 'IBIDRC,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)) S IBIDRC=$$CURR^IBCEF2(IBIFN)
 S IBIDRC=$G(^DIC(36,+IBIDRC,0)),IBIDRC=$P(IBIDRC,U,7)
 ;
 I IBBLITEM=1,IBCHGMTH=1 D  ; pros/bedsection/per diem
 . S IBEVDT="" F  S IBEVDT=$O(IBPIARR(IBEVDT)) Q:'IBEVDT  D
 .. S IBPI=0 F  S IBPI=$O(IBPIARR(IBEVDT,IBPI)) Q:'IBPI  D
 ... S IBSAVE="1^^^"_IBTYPE_"^^"_IBCMPNT
 ... D ALLBEDS^IBCRBC2(RS,CS,IBEVDT,"",IBIDRC,IBSAVE)
 ;
 I IBCHGMTH=2 D  ; va cost
 . S IBEVDT="" F  S IBEVDT=$O(IBPIARR(IBEVDT)) Q:'IBEVDT  D
 .. S IBPI=0 F  S IBPI=$O(IBPIARR(IBEVDT,IBPI)) Q:'IBPI  D
 ... S IBITM=IBPIARR(IBEVDT,IBPI) Q:'IBITM
 ... S IBSAVE="1^^^"_IBTYPE_"^"_+IBITM_"^"_IBCMPNT
 ... D BITMCHG^IBCRBC2(RS,CS,+IBITM,IBEVDT,1,"","",IBIDRC,IBSAVE)
 ;
 Q
