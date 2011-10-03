IBCRU8 ;ALB/ARH - RATES: UTILITIES (RC) ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
VERSDT(VERS) ; return effective date of RC version passed in
 N IBX S IBX=0 I +$G(VERS) S IBX=$$VERSDT^IBCRHBRV(VERS)
 Q IBX
 ;
RCDV(DIV) ; return RC Billing Region Data a division 'Region IFN^ID^TYPE'
 N IBX,IBRG,IBRG0 S IBX=0
 I +$G(DIV) S IBRG=0 F  S IBRG=$O(^IBE(363.31,IBRG)) Q:'IBRG  D
 . I '$O(^IBE(363.31,IBRG,11,"B",+DIV,0)) Q
 . S IBRG0=$G(^IBE(363.31,IBRG,0)) I $E(IBRG0,1,3)'="RC " Q
 . S IBX=IBRG_U_$P(IBRG0,U,2,3)
 Q IBX
 ;
RSOTHER(RS) ; return Billable Service if the Rate Schedule is applicable to Other Type of Care
 ; with RC v2.0 Skilled Nursing and Sub-Acute has an entire set of charges separate from inpatient charges
 ; charges are identified as Other (SNF/SA) by the Rate Schedule Billable Service for RC v2.0+ only
 ; Output: 0 - Charges are not applicable to Other Care
 ;         Billable Service ifn - Charges are applicable to the Billable Service only
 ; only the Billable Service SKILLED NURSING is defined as an 'Other' type of care and for RC 2.0+ only
 N IBRS0,IBRCX,IBFND,IBX S (IBRCX,IBFND)=0 S IBRS0=$G(^IBE(363,+$G(RS),0)) I IBRS0="" G RSOTHERQ
 I $P(IBRS0,U,5)<$$VERSDT(2) G RSOTHERQ
 S IBX=0 F  S IBX=$O(^IBE(363,RS,11,"B",IBX)) Q:'IBX  I $E($G(^IBE(363.1,IBX,0)),1,3)="RC-" S IBRCX=1 Q
 I 'IBRCX G RSOTHERQ
 S IBX=$$MCCRUTL^IBCRU1("SKILLED NURSING",13) I +$P(IBRS0,U,4)=IBX S IBFND=IBX
RSOTHERQ Q IBFND
