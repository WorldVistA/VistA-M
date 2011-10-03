IBCRU5 ;ALB/ARH - RATES: UTILITIES (DISPLAYS) ; 16-MAY-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DISPCS(IBCSFN) ; display charge set data
 N IBCS0,IBBR0,IBRVCD,IBX S IBCSFN=+$G(IBCSFN)
 S IBCS0=$G(^IBE(363.1,IBCSFN,0)),IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0)),IBRVCD=$G(^DGCR(399.2,+$P(IBCS0,U,5),0))
 ;
 W !!!,?4,"Charge Set: ",?19,$E($P(IBCS0,U,1),1,30)
 I +$P(IBCS0,U,4) W ?49,"Charge Type: ",?65,$$EXPAND^IBCRU1(363.1,.04,+$P(IBCS0,U,4))
 W !,?4,"Billing Event: ",?19,$E($$EMUTL^IBCRU1($P(IBCS0,U,3),1),1,28)
 W ?49,"Default Rev Cd: ",?65,$P(IBRVCD,U,1)
 W !,?4,"Billing Rate: ",?19,$E($P(IBBR0,U,1),1,28)
 W ?49,"Default Bed: ",?65,$E($$EMUTL^IBCRU1(+$P(IBCS0,U,6),2),1,15)
 I +$P(IBCS0,U,7) S IBX=$$RGEXT^IBCRU4(+$P(IBCS0,U,7)) I IBX'="" W !,?4,"Region: ",?19,$P(IBX,U,1) W:($L($P(IBX,U,2))>40) !,?17 W "  (",$P(IBX,U,2),")"
 I +$P(IBCS0,U,5) W !!,?4,"All Charge Items will use Rev Code ",$P(IBRVCD,U,1)," if one is not specified for the Item."
 I '$P(IBCS0,U,5) W !!,?4,"A Default Rev Code is not specified, one will be required for each Item."
 I +$P(IBBR0,U,4) W !,?4,"All items billable to the ",$P(IBBR0,U,2)," Billing Rate must be ",$$EXPAND^IBCRU1(363.3,.04,+$P(IBBR0,U,4)),"s.",!!
 I '$P(IBBR0,U,4) W !,?4,"The ",$P(IBBR0,U,2)," Billing Rate charges are calculated, there are no Charge Items.",!!
 Q
 ;
DISPCSL(IBCSFN) ; display one line of charge set data
 N IBCS0,IBRVCD I '$G(IBCSFN) Q
 S IBCS0=$G(^IBE(363.1,IBCSFN,0)),IBRVCD=$G(^DGCR(399.2,+$P(IBCS0,U,5),0))
 I IBCS0'="" W !!,?4,"Set: ",$E($P(IBCS0,U,1),1,30),?55,"Default Rev Cd: ",$P(IBRVCD,U,1)
 Q
 ;
DISPCI(IBCSFN,IBCISI) ; display all Charge Items for a single billable event for a Charge Set
 ; input IBCISI = pointer to the items source file (not the CI FN)
 N XREF,IBEFDT,IBDA,IBCI0
 S IBCSFN=+$G(IBCSFN),IBCISI=+$G(IBCISI),XREF="AIVDTS"_IBCSFN W !
 S IBEFDT=-99999999 F  S IBEFDT=$O(^IBA(363.2,XREF,IBCISI,IBEFDT)) Q:'IBEFDT  D
 . S IBDA=0 F  S IBDA=$O(^IBA(363.2,XREF,IBCISI,IBEFDT,IBDA)) Q:'IBDA  D
 .. D DISPCIL(IBDA)
 W !
 Q
 ;
DISPCIL(IBDA,IBCNT) ; print a single Charge Item line  (input: IBDA = CI IFN, IBCNT = reference #)
 N IBCI0,IBRVCD S IBCI0=$G(^IBA(363.2,+$G(IBDA),0)) Q:'IBCI0
 W !,?5,$G(IBCNT)
 W ?10,$$DATE^IBCRU1($P(IBCI0,U,3))
 I +$P(IBCI0,U,4) W ?19,"- ",$$DATE^IBCRU1($P(IBCI0,U,4))
 W ?30,$J($P(IBCI0,U,5),10,2)
 S IBRVCD=$G(^DGCR(399.2,+$P(IBCI0,U,6),0))
 W ?45,$P(IBRVCD,U,1),?50,$E($P(IBRVCD,U,2),1,28)
 I +$P(IBCI0,U,7) W ?70,$$EXPAND^IBCRU1(363.2,.07,+$P(IBCI0,U,7))
 Q
