IBCRBC ;ALB/ARH - RATES: BILL CALCULATION OF CHARGES ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,80,106,51,137,245,370**;21-MAR-94;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Variable DGPTUPDT may be defined on entry/exit for inpt bills so the PTF will only be updated once per session
 ; Charges may be filed on the bill and if IBRSARR is passed but does not exist it may be updated
 ; otherwise there are no other outputs/results of this call.
 ;
BILL(IBIFN,IBRSARR) ; given a bill number calculate and store all charges
 ; if IBRSARR is defined it will be used to create charges rather than the standard set for the bills Rate Type
 ;
 N IB0,IBU,IBBRT,IBBTYPE,IBCTYPE,DFN,PTF,IBDGPT,IBRS,IBCS,IBBEVNT Q:'$G(IBIFN)
 K ^TMP($J,"IBCRCC"),^TMP($J,"IBCRCS")
 ;
 S IB0=$G(^DGCR(399,+IBIFN,0)) Q:IB0=""  S IBU=$G(^DGCR(399,+IBIFN,"U")) Q:'IBU
 S IBBRT=+$P(IB0,U,7),IBBTYPE=$S($$INPAT^IBCEF(IBIFN):1,1:3),IBCTYPE=+$P(IB0,U,27),DFN=$P(IB0,U,2) Q:'DFN
 ;
 ; if who's responsible is insurer, but bill has no insurer defined quit
 I $P(IB0,U,11)="i",'$G(^DGCR(399,+IBIFN,"MP")),'$$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(IBIFN)) Q
 ;
 ; if inpt bill, PTF Status is Open, not a Fee Basis record and not previously done then Update the PTF record
 I IBBTYPE<3,'$D(DGPTUPDT) S PTF=$P(IB0,U,8) Q:'PTF  S IBDGPT=$G(^DGPT(+PTF,0)) Q:IBDGPT=""  D
 . I '$P(IBDGPT,U,6),'$P(IBDGPT,U,4) D UPDT^DGPTUTL S DGPTUPDT=""
 ;
 ;
 D DSPDL^IBCRBC3,DELALLRC^IBCRBF(IBIFN) ; delete all existing auto charges on the bill
 ;
 ; get standard set of all rate schedules and charge sets available for entire date range of the bill
 I '$D(IBRSARR) D RT^IBCRU3(IBBRT,IBBTYPE,$P(IBU,U,1,2),.IBRSARR,"",IBCTYPE) I 'IBRSARR G END
 ;
 ; process charge sets - set all charges for the bill into array
 S IBRS=0 F  S IBRS=$O(IBRSARR(IBRS)) Q:'IBRS  D
 . S IBCS=0 F  S IBCS=$O(IBRSARR(IBRS,IBCS)) Q:'IBCS  I +IBRSARR(IBRS,IBCS) D
 .. S IBBEVNT=+$P($G(^IBE(363.1,+IBCS,0)),U,3) Q:'IBBEVNT  S IBBEVNT=$$EMUTL^IBCRU1(IBBEVNT) Q:IBBEVNT=""
 .. ;
 .. I IBBEVNT["INPATIENT BEDSECTION STAY" D INPTBS^IBCRBC1(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["INPATIENT DRG" D INPTDRG^IBCRBC11(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["OUTPATIENT VISIT DATE" D OPTVST^IBCRBC1(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["PRESCRIPTION" D RX^IBCRBC1(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["PROSTHETICS" D PI^IBCRBC1(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["PROCEDURE" D CPT^IBCRBC1(IBIFN,IBRS,IBCS)
 ;
 I '$D(^TMP($J,"IBCRCC")) G END
 ;
 D SORTCI^IBCRBC3 I '$D(^TMP($J,"IBCRCS")) G END
 ;
 D ADDBCHGS^IBCRBC3(IBIFN)
 ;
 D MAILADD(IBIFN,IBBTYPE)
 ;
END I $D(^TMP("IBCRRX",$J)) D CLEANRX^IBCRBC3(IBIFN)
 K ^TMP($J,"IBCRCC"),^TMP($J,"IBCRCS")
 Q
 ;
MAILADD(IBIFN,BTYPE) ; update the bill mailing address:  it may be based on the types of charges
 ; an outpatient bill may go to either the opt or rx mailing addresses depending on the types of charges
 N DA,IB01,IB02
 I $G(BTYPE)>2,+$G(IBIFN),$D(^IBA(362.4,"C",+IBIFN)),+$$CHGTYPE^IBCU(+IBIFN)=3 S DA=IBIFN D MAILA^IBCU5 D
 . I '$D(ZTQUEUED),'$G(IBAUTO) W !!,"Updating Bill Mailing Address"
 Q
 ;
BILLITEM(IBIFN,IBITMARR) ; add selected unassociated item charges to the bill
 N IBRS,IBCS,IBBEVNT K ^TMP($J,"IBCRCC"),^TMP($J,"IBCRCS")
 ;
 S IBRS=0 F  S IBRS=$O(IBITMARR(IBRS)) Q:'IBRS  D
 . S IBCS=0 F  S IBCS=$O(IBITMARR(IBRS,IBCS)) Q:'IBCS  D
 .. S IBBEVNT=+$P($G(^IBE(363.1,+IBCS,0)),U,3) Q:'IBBEVNT  S IBBEVNT=$$EMUTL^IBCRU1(IBBEVNT) Q:IBBEVNT=""
 .. ;
 .. I IBBEVNT["UNASSOCIATED" D UNASSOC^IBCRBC11(IBIFN,IBRS,IBCS,.IBITMARR)
 ;
 I $D(^TMP($J,"IBCRCC")) D SORTCI^IBCRBC3
 ;
 I $D(^TMP($J,"IBCRCS")) D ADDBCHGS^IBCRBC3(IBIFN)
 ;
 K ^TMP($J,"IBCRCC"),^TMP($J,"IBCRCS")
 Q
 ;
 ;
 ;
 ; There are 3 types of charges/items:
 ; - ITEM: charge for an individual item:  specific item has one or more charge entries in 363.2
 ;   for the charge to be applied to the bill the specific item must be found on the bill
 ;
 ; - EVENT: charge for an event, not an item:  items are defined in 363.2
 ;   all charge items active on a date in the set define the charge for the event
 ;   the item does not need to be defined on the bill for the charge to be applied to the bill
 ;   the charge set on a date becomes the events charge, so effective date cuts across item and applies to event
 ;   all charge items with the same effective date are used to calculate the event charge for that date
 ;   each charge item effective date in the set overrides all previous entries in the set regardless of item
 ;
 ; - VA COST:  charge for an individual item but no entries in 363.2
 ;   instead the charge is calculated/obtained when it is needed from an interface with the source package
 ;
 ;
 ; Auto calculation and filing of a bills charges
 ;
 ; IBCRBC (BILL) - determine if charges can be calculated and which rates (RS/CS) should be used
 ;                 then find billable items/events, calculate and store the charges
 ;                 called anytime a bills charges need to be updated
 ;        
 ;                 IBCRBC1 (event) - gather billable items/events for each billable event type
 ;                                   then accumulate all charges for the bill for each billable event/item
 ;
 ;                                   IBCRCGx (event) - pull billable items/events from the bill
 ;                                   IBCRBC2 (BITMCHRG) - calculate charges for billable item/event
 ;
 ;                 IBCRBC3 (SORTCI) - sort accumulated charges into order to store on bill, combine if possible
 ;                 IBCRBC3 (ADDBCHRGS) -  store the sorted accumulated charges on the bill
 ;
 ;
 ; The Billable Event of the Charge Set is directly related to the Type of charge assigned
 ; to the charges calculated for that Charge Set.  So, Billable Event (363.1,.03) <-> Type (399,42,.1)
 ;
 ;
 ;  ^TMP($J,"IBCRCC")  -  array containing raw charges for a bill and related data, created in IBRCBC2
 ;  ^TMP($J,"IBCRCC",X) = 1  charge item ifn
 ;                        2  charge set ifn
 ;                        3  rate schedule ifn
 ;                        4  item ptr (to source)
 ;                        5  cpt modifier ptr
 ;                        6  revenue code ptr
 ;                        7  billable bedsection (bill)
 ;                        8  event date (visit or st from or admission)
 ;                        9  charge per unit/qty
 ;                        10 units/qty (qty of item)
 ;                        11 total charge per unit/qty
 ;                        12 adjusted total charge per unit/qty
 ;                        13 units (# item on bill)
 ;                        14 CPT ptr
 ;                        15 division ptr
 ;                        16 item type (source)
 ;                        17 item ptr (to source)
 ;                        18 charge component
 ;                        19 billable bedsection (for item)
 ;                        20 procedure provider
 ;                        21 procedures associated clinic
 ;                        22 procedures Outpatient Encounter, pointer to #409.68
 ;                        23 list of all the procedures modifiers, separated by ','
 ;
 ;  ^TMP($J,"IBCRCC",X,"CC",x) = comments explaining charge adjustements
 ;
 ;  ^TMP($J,"IBCRCS")  -  array of charges from IBCRCC in sorted order and with only data needed to save on bill
 ;  ^TMP($J,"IBCRCS", BS, RV, X) = 1  revenue code ptr
 ;                                 2  bedsection ptr
 ;                                 3  charge per units (adjusted total charge)
 ;                                 4  units (# item on bill)
 ;                                 5  CPT ptr
 ;                                 6  division ptr
 ;                                 7  item type
 ;                                 8  item ptr
 ;                                 9  charge component
 ;
 ;
 ;
 ; Inpatient Bill Dates use follow rules:
 ; - admission date is counted as billable
 ; - the discharge date is not billable and is not counted
 ; 
 ; - if admission movement is found in the Patient Movement file then the dates of admission and discharge
 ;   will be used as the outside limits of the LOS, even if date range of the bill is longer   (LOS^IBCU64)
 ; 
 ; - a day is counted as billable to the bedsection the patient was in at the end of the day (ie. counted
 ;   in LOS of next movement after midnight)
 ; - if there is a movement on any given date that date is included in the LOS of the bedsection the patient
 ;   moved into (same as admission date)
 ; - if there is a movement on any given date that date is NOT included in the LOS of the bedsection the 
 ;   patient moved out of (same as discharge date)
 ; 
 ; - if the time frame of the bill is:
 ;   - either interim-first or interim-continuous the last date on the bill should be billed
 ;     - if the last date is counted it is added to the LOS of the bedsection the patient was in at the end
 ;       of the day
 ;   - either NOT interim-first or interim-continuous (final bills) the last date on the bill
 ;     should NOT be billed (i.e. this is considered the discharge date)
 ;
 ; - start with first bedsection after begin date, day is counted in the bedsection the patient is in at midnight
 ; - continuous: last bedsection counted is the bedsection the patient is in at midnight of the end date
 ; - final:last bedsection counted is the bedsection the patient is in at midnight of the day before the end date
 ;
