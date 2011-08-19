IBCREU1 ;ALB/ARH - RATES: CM ENTER/EDIT UTILITIES ; 16-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,138**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
RQCI(IBCIFN) ; check all required data defined for charge item
 ; either the item's Charge Set must have a Default Revenue Code or the Charge Item must have revenue code
 ; Charge Set and Effective Date are required
 ; returns: 0 or 1 ^ 1 (needs CS) ^ 1 (needs EF DT) ^ 1 (needs Revenue Code)
 N IBCS0,IBCI0,IBX S IBX=0
 S IBCI0=$G(^IBA(363.2,+$G(IBCIFN),0)),IBCS0=$G(^IBE(363.1,+$P(IBCI0,U,2),0))
 I IBCS0="" S $P(IBX,U,1)=1,$P(IBX,U,2)=1
 I '$P(IBCI0,U,2) S $P(IBX,U,1)=1,$P(IBX,U,2)=1
 I '$P(IBCI0,U,3) S $P(IBX,U,1)=1,$P(IBX,U,3)=1
 I '$P(IBCS0,U,5),'$P(IBCI0,U,6) S $P(IBX,U,1)=1,$P(IBX,U,4)=1
 Q IBX
 ;
RQCS(CSFN) ; check that new charge set has all required fields
 ; Billing Rate is required to define the sets Charge Items
 ; Billable Event is required to link the sets charges to the items on the bills
 ; if the Billable Item of the Sets rate is not bedsection then Default Bedsection is required for the set
 ; if Charge Method of Sets rate is VA Cost then the Default Rev Code is required
 ; returns: 0 or 1 ^ 1 (needs BR) ^ 1 (needs BE) ^ 1 (needs bedsection)
 N IBCS,IBBR,IBX S IBX=0
 S IBCS=$G(^IBE(363.1,+$G(CSFN),0)),IBBR=$G(^IBE(363.3,+$P(IBCS,U,2),0))
 I IBBR="" S $P(IBX,U,1)=1,$P(IBX,U,2)=1
 I '$P(IBCS,U,2) S $P(IBX,U,1)=1,$P(IBX,U,2)=1
 I '$P(IBCS,U,3) S $P(IBX,U,1)=1,$P(IBX,U,3)=1
 I '$P(IBCS,U,6),+$P(IBBR,U,4)'=1 S $P(IBX,U,1)=1,$P(IBX,U,4)=1
 I '$P(IBCS,U,5),+$P(IBBR,U,5)=2 S $P(IBX,U,1)=1,$P(IBX,U,5)=1
 Q IBX
 ;
CHKBR(IBBRFN) ; check billing rate to determine if it can be edited (has CS or charge items or national)
 ; if the Rate is National or (since the Rate defines the items billed to a set)
 ; if the Rate has a Charge Set or a set of this Rate has Charge items, don't edit
 ; returns: 0 if editable or 1 ^ 1 (if national) ^ 1 (CS defined) ^ 1 (if charge items exist)
 N IBX,IBY,IBCSFN S IBBRFN=+$G(IBBRFN),IBX=0
 S IBY=$G(^IBE(363.3,IBBRFN,0)) I +IBBRFN<1000!($P(IBY,U,3)=1) S $P(IBX,U,1)=1,$P(IBX,U,2)=1
 S IBCSFN=0 F  S IBCSFN=$O(^IBE(363.1,IBCSFN)) Q:'IBCSFN  I +$P($G(^IBE(363.1,IBCSFN,0)),U,2)=IBBRFN D
 . S $P(IBX,U,1)=1,$P(IBX,U,3)=1
 . S IBY="AIVDTS"_IBCSFN I $O(^IBA(363.2,IBY,0)) S $P(IBX,U,1)=1,$P(IBX,U,4)=1
 Q IBX
 ;
CHKCS(IBCSFN) ; check charge set to determine if/what can be edited
 ; if the set was exported nationally (ie. any set not created locally) Name, Rate, and Event not editable
 ; if the Set has Charge Items defined then the Rate should not be changed since it defines the type of Item
 ; returns: 0 if editable or 1 ^ 1 (if charge items exist for the set) ^ 1 (not created locally)
 ;
 N IBX,IBY S IBCSFN=+$G(IBCSFN),IBX=0
 S IBY="AIVDTS"_IBCSFN I $O(^IBA(363.2,IBY,0)) S IBX=1,IBX=IBX_"^1"
 I +IBCSFN<1000 S $P(IBX,U,1)=1,$P(IBX,U,3)=1
 Q IBX
 ;
CHKSG(IBSGFN) ; check special groups to determine if it can be edited
 ; returns: 0 if editable or 1 ^ 1 (if exported nationally) ^ 1 (has rv cd links) ^ 1 (has PD links)
 N IBX,IBY S IBSGFN=+$G(IBSGFN),IBX=0,IBY=$G(^IBE(363.32,IBSGFN,0))
 I IBY'="",+IBSGFN<1000 S $P(IBX,U,1)=1,$P(IBX,U,2)=1
 I $P(IBY,U,2)=1,$O(^IBE(363.33,"C",+IBSGFN,0)) S $P(IBX,U,1)=1,$P(IBX,U,3)=1
 I $P(IBY,U,2)=2,$O(^IBE(363.34,"C",+IBSGFN,0)) S $P(IBX,U,1)=1,$P(IBX,U,4)=1
 Q IBX
