IBCRBC2 ;ALB/ARH - RATES: BILL CALCULATION OF ITEM CHARGE ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,138,148,245,370**;21-MAR-94;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Input:  RS     - rate schedule necessary to calculated modified charges
 ;         CS     - required, charge set which defines the charges to calculate
 ;         ITEM   - required, ptr to source item to be billed, type defined by billable item of the rate
 ;         EVDT   - date of event, to be used when searching for a charge effective date, default=DT
 ;         UNITS  - required, used only for Quantity:  # of units of Charge Item Charge for each Item
 ;         MOD    - CPT Modifier if any
 ;         INSRC  - special revenue code to use (from ins comp), if any (overrides set and item rv cd)
 ;         IDFRC  - different revenue codes to use, these replace the standard set in CM (DRC:SRC,DRC:SRC)
 ;         SAVE   - serveral data items not needed here but passed on to next step (store) in TMP array:
 ;                  TUNITS - required to add charge to bill, total # of the Item on the bill
 ;                  CPT    - default CPT to be added to the bill for the charge
 ;                  DIV    - division charges apply to
 ;                  TYPE   - type of item being billed - defines the source of the item on the bill
 ;                  ITMPTR - soft pointer to the item on the bill:  may be a multiple or file IFN
 ;                  CMPNT  - what component of the total charge: institutional or professional
 ;                  BEDS   - billable bedsection to use if not a bedsection item, if null uses set default
 ;                  PROV   - procedure provider
 ;                  CLINIC - procedures associated clinic
 ;                  IBOE   - Outpatient Encounter, pointer to #408.69
 ;                  MODS   - list of all modifiers define for the procedure, separated by ','
 ;
 ; Total charge is calculated:  X = UNITS * UNIT CHARGE of the item         (per unit charge (un-adjusted))
 ;                              Y = X modified by Rate Schedule Adjustment  (per unit charge (adjusted))
 ; the Units are used to calculate the per item charge: 30 pills for an rx, 1 bs per bs
 ; and the Tunits are the number of that Item on the bill: 1 rx of 30 pills, 11 days of bs stay
 ;
 ; Output: TMP($J,"IBCRCC", containing all chargable items and all related info needed to file them on the bill
 ;         each charge will have it's own entry, nothing combined (12 = per unit charge (adjusted), p13 = Tunits)
 ;         TMP is not killed on entry so each items charges are compiled and added to existing charges
 ;         
BITMCHG(RS,CS,ITEM,EVDT,UNITS,MOD,INSRC,IDFRC,SAVE) ; get bill charges for a specific item, rate schedule and charge set and date set into temp array
 ;
 N IBCS0,IBDRVCD,IBBS,IBCHGARR,IBI,IBCNT,IBLN,IBCI,IBRVCD,IBPPRV,IBCHRG,IBTCHRG,IBRCHRG,IBPCHRG,IBACHRG
 N IBMCHRG,IBMODS,IBBASE,IBCOM I '$G(ITEM)!'$G(CS)!'$G(UNITS) Q
 ;
 S RS=$G(RS),EVDT=$S(+$G(EVDT):+EVDT\1,1:DT),MOD=$G(MOD),INSRC=$G(INSRC),IDFRC=$G(IDFRC),SAVE=$G(SAVE)
 S IBCS0=$G(^IBE(363.1,+CS,0)),IBDRVCD=$P(IBCS0,U,5),IBPPRV=$P(SAVE,U,8),IBMODS=$P(SAVE,U,11)
 S IBBS=+ITEM I $P($G(^IBE(363.3,+$P(IBCS0,U,2),0)),U,4)'=1 S IBBS=$P(SAVE,U,7) I 'IBBS S IBBS=$P(IBCS0,U,6)
 I 'IBBS Q
 ;
 D ITMCHG^IBCRCC(CS,ITEM,EVDT,MOD,.IBCHGARR)
 ;
 S IBCNT=+$G(^TMP($J,"IBCRCC"))
 S IBI=0 F  S IBI=$O(IBCHGARR(IBI)) Q:'IBI  D
 . S IBLN=IBCHGARR(IBI),IBCI=+IBLN,IBCHRG=$P(IBLN,U,3),(IBPCHRG,IBRCHRG)="" Q:'IBCHRG  S IBBASE=$P(IBLN,U,4)
 . S IBRVCD=INSRC I 'IBRVCD S IBRVCD=$P(IBLN,U,2)
 . I 'IBRVCD S IBRVCD=$P($$RVLNK^IBCRU6(+ITEM,"",+CS),U,2) I 'IBRVCD S IBRVCD=IBDRVCD Q:'IBRVCD
 . I +IDFRC,+$P(IDFRC,IBRVCD_":",2) S IBRVCD=+$P(IDFRC,IBRVCD_":",2) Q:IBRVCD'?3N
 . ;
 . S IBCHRG=IBCHRG*UNITS
 . S IBCHRG=IBCHRG+IBBASE
 . S IBPCHRG=IBCHRG I +IBPPRV S IBPCHRG=$$PRVCHG^IBCRCC(CS,IBCHRG,IBPPRV,EVDT,ITEM)
 . S IBMCHRG=+IBPCHRG I +IBMODS S IBMCHRG=$$MODCHG^IBCRCC(CS,IBPCHRG,IBMODS)
 . S (IBCHRG,IBTCHRG)=+IBMCHRG
 . S IBACHRG=IBTCHRG I +RS,+IBTCHRG S IBRCHRG=$$RATECHG^IBCRCC(RS,IBTCHRG,EVDT),IBACHRG=+IBRCHRG
 . ;
 . S IBCNT=IBCNT+1,^TMP($J,"IBCRCC")=IBCNT
 . S ^TMP($J,"IBCRCC",IBCNT)=IBCI_U_CS_U_RS_U_ITEM_U_MOD_U_IBRVCD_U_IBBS_U_EVDT_U_IBCHRG_U_UNITS_U_IBTCHRG_U_IBACHRG_U_$G(SAVE)
 . ;
 . I (UNITS>1)!(+IBBASE) S IBCOM=$$COMMUB(CS,UNITS,IBBASE) I IBCOM'="" D COMMENT(IBCNT,IBCOM)
 . I $P(IBPCHRG,U,2)'="" S IBCOM=$P(IBPCHRG,U,2) I IBCOM'="" D COMMENT(IBCNT,IBCOM)
 . I $P(IBMCHRG,U,2)'="" S IBCOM=$P(IBMCHRG,U,2) I IBCOM'="" D COMMENT(IBCNT,IBCOM)
 . I $P(IBRCHRG,U,2)'="" S IBCOM=$P(IBRCHRG,U,2) I IBCOM'="" D COMMENT(IBCNT,IBCOM)
 Q
 ;
COMMENT(LINE,COMM) ; set comment into charge array for a particular line item
 I +$D(^TMP($J,"IBCRCC",+$G(LINE))) N IBX D
 . S IBX=$O(^TMP($J,"IBCRCC",+LINE,"CC",9999),-1) S IBX=IBX+1
 . S ^TMP($J,"IBCRCC",+LINE,"CC",IBX)=$G(COMM)
 Q
 ;
COMMUB(CS,UNITS,BASE) ; return comment for special units and base
 N IBX,IBY,IBCM S IBX="",IBY="Charge calculated"
 S IBCM=$P($G(^IBE(363.1,+CS,0)),U,2),IBCM=$P($G(^IBE(363.3,+IBCM,0)),U,5)
 S IBCM=$S(IBCM=4:"Miles",IBCM=5:"SubUnits",IBCM=6:"Hours",1:"")
 I +$G(UNITS) S IBX=IBY_" for "_UNITS_" "_IBCM,IBY=""
 I +$G(BASE) S IBX=IBY_IBX_" with a Base Charge="_$J(BASE,0,2)
 Q IBX
 ;
ALLBEDS(RS,CS,EVDT,RC,DFRC,SAVE) ; get charges for all bedsections active on date of visit
 ; each effective date supercedes all previous effective date, regardless of the item
 ; used for per diem rates where the charges are associated with a bedsection, but the item being billed is not
 ; a bedsection, so the count of the item on the bill is found and applied as the units to all bedsections active
 ; on the event date  (the 3 opt visit dates on a bill are the units for the Outpatient Visit bedsection charge)
 ;
 N IBITM,IBITEMS I '$G(CS)!'$G(EVDT) Q
 ;
 D CSALL^IBCRCU1(CS,EVDT,.IBITEMS)
 ;
 I +IBITEMS S IBITM="" F  S IBITM=$O(IBITEMS(IBITM)) Q:'IBITM  D
 . D BITMCHG($G(RS),CS,IBITM,EVDT,1,"",$G(RC),$G(DFRC),$G(SAVE))
 Q
 ;
 ;
CPTUNITS(CS,CHGMTH,ITLINE) ; return CPT units based on Charge Method and CPT data
 ; Input:  CS is the related Charge Set
 ;         CHGMTH is the Rate Schedule Charge Method (363.3, .05)
 ;         ITLINE is item data from CPT^IBCRBG1
 ; Output: calculated units for CPT, 1 or calculated for miles/minutes/hours
 N IBUNIT S IBUNIT=1,CHGMTH=$G(CHGMTH),ITLINE=$G(ITLINE),CS=$G(CS)
 I CHGMTH=4 S IBUNIT=+$P(ITLINE,U,8) ; miles
 I CHGMTH=5 S IBUNIT=+$P(ITLINE,U,7) ; minutes
 I CHGMTH=6 S IBUNIT=+$P(ITLINE,U,9) ; hours
 S IBUNIT=$$CPTUNITS^IBCRCU1(CS,IBUNIT)
 Q IBUNIT
 ;
CHGOTH(IBIFN,RS,EVDT) ; check if the Rate Schedule charges are applicable to the event date for the bill
 ; this is relevent to RC v2.0 and type of care of Other
 ; both Rate Schedule is SNF and event date is SNF care or neither can be otherwise no charge
 ; SNF charges can't be used for non-SNF care and non-SNF charges can't be used for SNF care
 ; Output: returns true if charges and bill date are of same type, SNF or non-SNF
 N IBOK,IBRSTY,IBDTTY S (IBRSTY,IBDTTY)=0,IBOK=1
 I $G(EVDT)<$$VERSDT^IBCRU8(2) G CHGOTHQ
 I '$G(IBIFN)!'$G(RS) G CHGOTHQ
 ;
 S IBRSTY=$$RSOTHER^IBCRU8(RS) ; are charges for other type of care
 S IBDTTY=$$BOTHER^IBCU3(IBIFN,EVDT) ; is date other type of care
 ;
 I +IBRSTY,'IBDTTY S IBOK=0
 I 'IBRSTY,+IBDTTY S IBOK=0
 ;
CHGOTHQ Q IBOK
 ;
CHGICU(CS,BS) ; check if charge and bedsection match relative to ICU RC 2.0+, compares Charge Set Name and Bedsection
 ; both the charge set and the bedsection have to be ICU or neither of them can be ICU otherwise no charge
 ; ICU charges can't be used with non-ICU bedsections and non-ICU charges can't be used with ICU bedsection
 ; Output: returns true if charges and bedsection are of same type, ICU or non-ICU
 N IBCSICU,IBCSN,IBICU,IBOK S (IBOK,IBCSICU)=0,BS=+$G(BS)
 S IBICU=$$MCCRUTL^IBCRU1("ICU",5)
 S IBCSN=$G(^IBE(363.1,+$G(CS),0)) I $E(IBCSN,1,2)'="RC" S IBOK=1
 I $P(IBCSN,U,1)["ICU" S IBCSICU=1 ; charge set is icu
 ;
 I BS=IBICU,+IBCSICU S IBOK=1 ; both bedsection and charge set are icu
 I BS'=IBICU,'IBCSICU S IBOK=1 ; niether bedsection nor charge set are icu
 Q IBOK
