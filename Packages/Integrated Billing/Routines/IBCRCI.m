IBCRCI ;ALB/ARH - RATES: CALCULATION ITEM/EVENT COST FNCTNS ; 22-MAY-96
 ;;2.0;INTEGRATED BILLING;**52,106,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified
 ;
 ;       standard callable functions to get item charge/cost
 ;
 ; notice that each function works for all Charge Methods and both types of Sets (Item/Event)
 ; - if the Charge Set is based on event then the event charge will be calculated (item passed will not be used)
 ; - the charges are the unit charges so UNIT should only be defined (or not 1) if the Charge Method is Quantity
 ;
ITCHG(CS,ITEM,EVDT,MOD) ; returns total base unit charge for a specific charge set, item/event and date
 ; works for both types of Charge Set (Item and Event) and all Charge Methods
 ; does not factor in division, units or rate schedule adjustment
 ; if charges for the Set are based on event rather than item, will get active events, ITEM is not required/used
 ; Input:  CS = Charge Set ifn, ITEM = billable item pointer, MOD = cpt modifier
 ; Output: total item charge on EVDT ^ effective date of charge ^ total base charge
 ;
 N IBX,IBITMARR,IBCHGARR,IBITEM,IBI,IBLN,IBCHG,IBCHGB,IBCI,IBEFDT S IBX=0,EVDT=$G(EVDT)\1
 I '$D(^IBE(363.1,+$G(CS),0))!(EVDT'?7N) G ITCHGQ
 I +$G(ITEM),'$$ITBICHK^IBCRU2(+CS,+ITEM) G ITCHGQ
 ;
 I $$CSITMS^IBCRCU1(CS)=2 D CSALL^IBCRCU1(CS,EVDT,.IBITMARR)
 I +$G(ITEM),'$G(IBITMARR) S IBITMARR=EVDT,IBITMARR(ITEM)=""
 I '$G(IBITMARR) G ITCHGQ
 ;
 S (IBCHG,IBCHGB,IBCI,IBITEM)=0 F  S IBITEM=$O(IBITMARR(IBITEM)) Q:'IBITEM  D
 . D ITMCHG^IBCRCC(CS,IBITEM,EVDT,$G(MOD),.IBCHGARR)
 . S IBI=0 F  S IBI=$O(IBCHGARR(IBI)) Q:'IBI  D
 .. S IBLN=IBCHGARR(IBI) S IBCHG=IBCHG+$P(IBLN,U,3),IBCI=+IBLN,IBCHGB=IBCHGB+$P(IBLN,U,4)
 ;
 I +IBCI S IBEFDT=$P($G(^IBA(363.2,+IBCI,0)),U,3)
 I +IBCHG S IBX=+$FN(+IBCHG,"",2)_U_$G(IBEFDT) I +IBCHGB S IBX=IBX_U_+$FN(+IBCHGB,"",2)
 ;
ITCHGQ Q IBX
 ;
ITCOST(RS,CS,ITEM,EVDT,MOD,DIV,UNIT) ; returns total adjusted unit cost/charge for a specific schedule/set, item/event, date
 ; this is the actual cost of one item/event, does factor in division, units and rate schedule adjustment
 ; units should be 1 or undefined unless the Charge Method of the rate is Quantity/Miles/Minutes/Hours
 ; if the Charge Set is region specific, Division passed must be within that region or no charge
 ; Input:  CS = Charge Set ifn, ITEM = billable item pointer, MOD = cpt modifier, UNIT = 1 unless Quantity
 ; Output: total adjusted item charge/cost on EVDT ^ effective date of charge
 ;
 N IBCOST,IBBCOST,IBDT S IBCOST=0,EVDT=$G(EVDT)\1,UNIT=$S(+$G(UNIT):UNIT,1:1)
 I '$D(^IBE(363.1,+$G(CS),0))!(EVDT'?7N) G ITCOSTQ
 I $$CSDV^IBCRU3(CS,+$G(DIV))<0 G ITCOSTQ
 S UNIT=$$CPTUNITS^IBCRCU1(CS,UNIT)
 ;
 S IBCOST=$$ITCHG(CS,$G(ITEM),EVDT,$G(MOD)),IBDT=$P(IBCOST,U,2),IBBCOST=$P(IBCOST,U,3)
 S IBCOST=+IBCOST*UNIT
 I +IBBCOST S IBCOST=IBCOST+IBBCOST
 I +$G(RS) S IBCOST=+$$RATECHG^IBCRCC(RS,+IBCOST,EVDT)
 I +IBCOST S IBCOST=+$FN(+IBCOST,"",2)_U_IBDT
 ;
ITCOSTQ Q IBCOST
 ;
BICOST(RT,BT,EVDT,BE,ITEM,MOD,DIV,UNIT,CT) ; returns the total unit cost of a particular item/event for a specific Rate Type and Bill Type, i.e. payer
 ; this includes all cost for the item and payer, which may include more than one charge set or rate schedule
 ; ITEM is not required if it is an Event CS, BE is required only as a screen for a specific event, if desired
 ;
 N IBX,IBY,IBCOST,IBDT,IBARR,IBRS,IBCS S (IBX,IBCOST)=0,IBDT=""
 I $G(BE)'=""!(+$G(ITEM)) D RT^IBCRU3($G(RT),$G(BT),$G(EVDT),.IBARR,$G(BE),$G(CT))
 ;
 S IBRS=0 F  S IBRS=$O(IBARR(IBRS)) Q:'IBRS  D
 . S IBCS=0 F  S IBCS=$O(IBARR(IBRS,IBCS)) Q:'IBCS  I +IBARR(IBRS,IBCS) D
 .. S IBY=$$ITCOST(IBRS,IBCS,$G(ITEM),$G(EVDT),$G(MOD),$G(DIV),$G(UNIT)) I +$P(IBY,U,2)>IBDT S IBDT=+$P(IBY,U,2)
 .. S IBCOST=+IBCOST+IBY
 S IBX=IBCOST_U_IBDT
 Q IBX
 ;
BILLCOST(IBIFN,EVDT,BE,ITEM,MOD,UNIT) ; returns total cost of a particular item or event for a specific bill
 ; cost may include more than one set or schedule charge if the item/event is defined for more than one set
 ; or schedule assigned to the rate type/event type of the bill
 ;
 N IBX,IB0,IBRT,IBBT S IBX=0,IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBRT=+$P(IB0,U,7),IBBT=$P(IB0,U,5)
 I IB0'="" S IBX=$$BICOST(IBRT,IBBT,$G(EVDT),$G(BE),$G(ITEM),$G(MOD),$P(IB0,U,22),$G(UNIT),$P(IB0,U,27))
 Q IBX
