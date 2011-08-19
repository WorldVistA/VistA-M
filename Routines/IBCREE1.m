IBCREE1 ;ALB/ARH - RATES: CM ENTER/EDIT (CI) ; 16-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EDITCI ; Enter/Edit Charge Items
 N IBCS0,IBBR0,IBBRFN,IBITEM,IBBRBI,IBDT,IBCIFN,IBX,DIE,DR,DA,X,Y
 ;
CS I '$G(IBCSFN) S IBCSFN=+$$GETCS^IBCRU1 Q:IBCSFN'>0
 D DISPCS^IBCRU5(+IBCSFN)
 ;
 S IBCS0=$G(^IBE(363.1,+IBCSFN,0)),IBBRFN=$P(IBCS0,U,2)
 S IBBR0=$G(^IBE(363.3,+IBBRFN,0)),IBBRBI=$P(IBBR0,U,4)
 W !!,"Enter/edit a billable item (",$$BITM(IBBRBI),") for Charge Set ",$P(IBCS0,U,1)
 ;
CI W ! S IBITEM=$$GETITEM^IBCRU1(IBCSFN,"",1) I +IBITEM<1 Q
 I '$$ITFILE^IBCRU2(IBBRBI,+IBITEM) W !!,$$BITM(IBBRBI)," ",$P(IBITEM,U,2)," CURRENTLY INACTIVE",!
 ;
EF D DISPCI^IBCRU5(+IBCSFN,+IBITEM)
 S IBDT=$$GETDT^IBCRU1($G(IBDT)) I IBDT<1 S IBDT="" W "   ... no change" G CI
 D SCRNDSPL
 ;
 S IBCIFN=$$FINDCI(+IBCSFN,+IBITEM,IBDT) I IBCIFN<0 G EF
 ;
 I IBCIFN>0 W !,?50,"Editing Charge Item!"
 ;
 I 'IBCIFN D  I 'IBCIFN W !!,"A charge can not be added for this item!",! Q
 . S IBCIFN=$$ADDCI^IBCREF(+IBCSFN,+IBITEM,IBDT) W !,?50,"Adding a new Charge Item!"
 ;
 S DR=$$DR01(+$P(IBITEM,U,4))_";.03;.04;.05;.06"
 ;
 I $P(IBITEM,U,4)=81 S DR=DR_";.07"
 I +$P(IBBR0,U,6) S DR=DR_";.08"
 ;
DIE S DIDEL=363.2,DIE="^IBA(363.2,",DA=+IBCIFN D ^DIE K DIE,DR,X,DIDEL
 ;
 I $D(DA),$D(Y)=0 S IBX=$$RQCI^IBCREU1(+IBCIFN) I +IBX D RQW S DR=".06" G DIE
 D DISPCSL^IBCRU5(+IBCSFN)
 G CI
 Q
BITM(X) ; return external form of billable item
 S X=+$G(X) S X=$$EXPAND^IBCRU1(363.3,.04,X)
 Q X
RQW ; write explanation of required fields
 W !!,"Enter either a Default Revenue Code for the Charge Set or a Revenue Code for",!,"this Charge Item:"
 W !,"    - a charge can not be added to a bill without a revenue code"
 W !,"    - no Revenue Code was added for this Charge Item and there is no"
 W !,"      Default Revenue code for the Charge Set."
 W !,"    - one or the other must be added before this charge will be used",!!
 W !!,"You may enter a revenue code for the Charge Item now:  (^ to exit)"
 Q
FINDCI(IBCSFN,IBITEM,IBDT) ; find item to edit returns CIIFN or 0 (new) or -1 (error)
 ;
 N IBY,IBI,IBCNT,DIR,X,Y,IBARR S IBY=-1
 S IBI=$O(^IBA(363.2,"AIVDTS"_IBCSFN,+IBITEM,-IBDT,0)) I 'IBI S IBY=0 G FCQ ; none found
 ;
 S (IBI,IBCNT)=0 F  S IBI=$O(^IBA(363.2,"AIVDTS"_IBCSFN,+IBITEM,-IBDT,+IBI)) Q:'IBI  D
 . S IBCNT=IBCNT+1,IBARR(IBCNT)=IBI D DISPCIL^IBCRU5(IBI,IBCNT)
 I +IBCNT S DIR(0)="NO^1:"_IBCNT D ^DIR I Y>0 S IBY=$G(IBARR(Y))
 I '$D(DTOUT),'$D(DUOUT),IBY<1 S DIR(0)="Y",DIR("A")="Add a new Charge Item? " S DIR("B")="Y" D ^DIR I Y=1 S IBY=0
FCQ Q IBY
 ;
DR01(FILE) ; return DR string for editing the .01 field of charge item
 N IBX S IBX=""
 I +$G(FILE) S IBX="S DIC(""V"")=""I +Y(0)="_+FILE_""";.01;K DIC(""V"")"
 Q IBX
 ;
SCRNDSPL ; if this edit is called from the screen return the items and dates edited so screen can be
 ; redisplayed with the new/edited items
 I $D(IBSRNITM) S IBSRNITM=IBITEM
 I $D(IBSRNBDT),IBSRNBDT>IBDT S IBSRNBDT=IBDT
 I $D(IBSRNEDT),+IBSRNEDT,IBSRNEDT<IBDT S IBSRNEDT=IBDT
 Q
