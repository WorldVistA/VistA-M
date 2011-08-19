IBCRU7 ;LL/ELZ - TRANSFER PRICING CHARGE MASTER UTILITIES ; 20-AUG-1999
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TPCS(BR,RG) ; finds charge set for billing rate and region
 ; region in transfer pricing is an institution, not a division
 ; if RG not passed, looks up national default
 ;
 N BRIFN,CSIFN,X
 ;
 Q:'$D(BR) 0
 S BRIFN=$O(^IBE(363.3,"B",BR,0)) Q:'BRIFN 0
 ;
 I $D(RG) S RG=$O(^IBE(363.31,"AB",RG,0)) Q:'RG 0
 ;
 S (X,CSIFN)=0 F  S CSIFN=$O(^IBE(363.1,"C",BRIFN,CSIFN)) Q:'CSIFN!(X)  I $P(^IBE(363.1,CSIFN,0),U,7)=$G(RG) S X=CSIFN
 Q X
 ;
DISPCS(IBCSFN) ; display charge set data ** copy of same entry from IBCRU5 with items left off
 N IBCS0,IBBR0,IBRVCD,IBX S IBCSFN=+$G(IBCSFN)
 S IBCS0=$G(^IBE(363.1,IBCSFN,0)),IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0)),IBRVCD=$G(^DGCR(399.2,+$P(IBCS0,U,5),0))
 ;
 W !!!,?4,"Charge Set: ",?19,$E($P(IBCS0,U,1),1,30)
 I +$P(IBCS0,U,4) W ?49,"Charge Type: ",?65,$$EXPAND^IBCRU1(363.1,.04,+$P(IBCS0,U,4))
 W !,?4,"Billing Event: ",?19,$E($$EMUTL^IBCRU1($P(IBCS0,U,3),1),1,28)
 W !,?4,"Billing Rate: ",?19,$E($P(IBBR0,U,1),1,28)
 I +$P(IBCS0,U,7) S IBX=$$RGEXT^IBCRU4(+$P(IBCS0,U,7)) I IBX'="" W !,?4,"Region: ",?19,$P(IBX,U,1)
 I +$P(IBBR0,U,4) W !,?4,"All items billable to the ",$P(IBBR0,U,2)," Billing Rate must be ",$$EXPAND^IBCRU1(363.3,.04,+$P(IBBR0,U,4)),"s.",!!
 I '$P(IBBR0,U,4) W !,?4,"The ",$P(IBBR0,U,2)," Billing Rate charges are calculated, there are no Charge Items.",!!
 Q
 ;
DISPCSL(IBCSFN) ; display one line of charge set data ** copy of same entry from IBCRU5 with items left off
 N IBCS0 I '$G(IBCSFN) Q
 S IBCS0=$G(^IBE(363.1,IBCSFN,0))
 I IBCS0'="" W !!,?4,"Set: ",$E($P(IBCS0,U,1),1,30)
 Q
 ;
