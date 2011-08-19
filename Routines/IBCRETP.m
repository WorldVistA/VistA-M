IBCRETP ;LL/ELZ - RATES: TRANSFER PRICING CM FAST ENTER/EDIT ; 24-AUG-1999
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENTER ; OPTION:  Transfer Pricing rates fast enter - this requires billing
 ; rate names are not changed.  Will set up charge sets if not defined.
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,IBARR,IBRATE,IBEFDT,IBRVCD,IBCS,IBA
 W @IOF W !!,?10,"Fast Enter of Transfer Pricing Rates",!!
 ;
 S DIR(0)="SO^I:Inpatient;O:Outpatient",DIR("A")="Enter which rates" D ^DIR K DIR
 S IBRATE=$S(Y="I":"1^TP INPATIENT",Y="O":"2^TP OUTPATIENT",1:"") Q:'IBRATE
 ;
 S IBEFDT=$$GETDT^IBCRU1() I IBEFDT'?7N Q
 ;
 S IBCS=$$FAC(IBRATE)
 D EDITCI(IBCS,IBEFDT)
 Q
 ;
FAC(TYPE) ; ask facility, create charge sets and billing region if not defined, return chargeset
 N DIC,X,Y,DTOUT,DUOUT,IBFAC,IBCS,IBRG
 ;
 S DIC="^DIC(4,",DIC(0)="AEMNQ" D ^DIC Q:Y<1 0 S IBFAC=Y
 ;
 S IBCS=$$TPCS^IBCRU7(TYPE,+IBFAC) Q:IBCS IBCS
 ;
 ; add billing region and charge set to charge master
 S IBRG=$$RG(IBFAC) Q:'IBRG 0
 S IBCS=$$ACS(TYPE,IBRG,IBFAC)
 Q IBCS
 ;
RG(INST) ; add a new Billing Region for Transfer pricing (363.31)
 ; input institution 0 by ref and institution pointer
 ; returns billing region IFN ^ name
 N IBNAME,IBRG,X,Y,DLAYGO,DIC,DA,DTOUT,DUOUT,MSG,D0
 I $G(INST)="" Q 0
 ;
 F X=0,1,3,99 S INST(X)=$G(^DIC(4,+INST,X))
 S IBNAME=$$NNT^XUAF4(+INST)
 S IBNAME="TP "_$S($P(IBNAME,"^",3)="VISN":$P(IBNAME,"^"),1:$P(INST(99),"^")_" "_$P(INST(1),"^",3))_$S($P(INST(0),"^",2)&($P(IBNAME,"^",3)'="VISN"):", "_$P($G(^DIC(5,$P(INST(0),"^",2),0)),"^",2),1:"")
 S IBRG=$O(^IBE(363.31,"B",IBNAME,0)) I IBRG Q IBRG_"^"_IBNAME
 ;
 K D0 S DLAYGO=363.31,DIC="^IBE(363.31,",DIC(0)="L",X=$E(IBNAME,1,30) D FILE^DICN I Y<1 Q 0
 S IBRG=Y D MSG("     Added Billing Region "_$P(IBRG,"^",2))
 ;
 K DA S DIC(0)="L",DA(1)=+IBRG,DIC=DIC_DA(1)_",21,",X=+INST D FILE^DICN
 D MSG("     with"_$S(Y>0:"",1:"OUT")_" Institution "_$P(INST(0),"^"))
 ;
 D MSGP Q IBRG
 ;
ACS(RATE,RG,FAC) ; find or add charge set
 ; returns IFN of new charge set, 0 otherwise, input is in internal^external format
 N IBOK,IBNAME,IBEVENT,IBFN,IBBR,IBBE,IBJ,DD,DO,DLAYDO,DINUM,DIC,DA,X,Y,DR,DIE,IBA,IBCSN,MSG S IBOK=1
 S RATE=$G(RATE),RG=$G(RG),FAC=$G(FAC) I RATE="" G ACSQ
 ;
 S IBNAME="TP-"_$S((+RATE)=1:"INPT ",1:"OPT ")_$S($E($P(FAC,"^",2),1,5)="VISN ":$P(FAC,"^",2),1:+FAC)
 S IBEVENT=$S(RATE[" I":"INPATIENT DRG",1:"PROCEDURE")
 S IBFN=$O(^IBE(363.1,"B",$E(IBNAME,1,30),0)) I +IBFN S IBOK=0 D MSG("     *** Charge Set "_$E(IBNAME,1,30)_" found")
 S IBBR=$O(^IBE(363.3,"B",$P(RATE,"^",2),0)) I 'IBBR S IBOK=0 D MSG("     *** Error: "_RATE_" Billing Rate does not exist")
 S IBBE=$$MCCRUTL(IBEVENT,14) I 'IBBE S IBOK=0 D MSG("     *** Error: "_IBEVENT_" Billable Event undefined")
 I '$D(^IBE(363.3,+RG)) S IBOK=0 D MSG("     *** Error: "_$P($E(RG,1,30),"^",2)_" Billing Region does not exist")
 I '$G(IBOK) G ACSQ
 ;
 F IBJ=1:1 S IBFN=$G(^IBE(363.1,IBJ,0)) I IBFN="" S DINUM=IBJ Q
 ;
 K DD,DO S DLAYGO=363.1,DIC="^IBE(363.1,",DIC(0)="L",X=$E(IBNAME,1,30) D FILE^DICN K DIC K DIC,DINUM,DLAYGO I Y<1 K X,Y Q
 S IBFN=+Y,IBCSN=$P(Y,U,2)
 ;
 S DR=".02////"_IBBR_";.03////"_IBBE_";.07////"_(+RG)
 S DIE="^IBE(363.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 S IBA(1)="     "_$E(IBNAME,1,30)_" Charge Set "_$S('$G(IBFN):"NOT ",1:"")_"added"
 ;
ACSQ D MSGP
 Q +$G(IBFN)
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
MSG(X) ; add message to end of message list, reserves IBA(1) for primary message
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
MSGP ; print error messages in IBA
 N IBX S IBX="" F  S IBX=$O(IBA(IBX)) Q:'IBX  W !,IBA(IBX)
 Q
 ;
EDITCI(IBCSFN,IBDT) ; Enter/Edit Charge Items
 N IBCS0,IBBR0,IBBRFN,IBITEM,IBBRBI,IBCIFN,IBX,DIE,DR,DA,X,Y
 ;
CS I '$G(IBCSFN) S IBCSFN=+$$GETCS^IBCRU1 Q:IBCSFN'>0
 D DISPCS^IBCRU7(+IBCSFN)
 ;
 S IBCS0=$G(^IBE(363.1,+IBCSFN,0)),IBBRFN=$P(IBCS0,U,2)
 S IBBR0=$G(^IBE(363.3,+IBBRFN,0)),IBBRBI=$P(IBBR0,U,4)
 W !!,"Enter/edit a billable item (",$$BITM(IBBRBI),") for Charge Set ",$P(IBCS0,U,1)
 ;
CI W ! S IBITEM=$$GETITEM^IBCRU1(IBCSFN,"",1) I +IBITEM<1 Q
 I '$$ITFILE^IBCRU2(IBBRBI,+IBITEM) W !!,$$BITM(IBBRBI)," ",$P(IBITEM,U,2)," CURRENTLY INACTIVE",!
 ;
EF D DISPCI^IBCRU5(+IBCSFN,+IBITEM)
 I IBDT<1 S IBDT="" W "   ... no change" G CI
 D SCRNDSPL
 ;
 S IBCIFN=$$FINDCI(+IBCSFN,+IBITEM,IBDT) I IBCIFN<0 G EF
 ;
 I IBCIFN>0 W !,?50,"Editing Charge Item!"
 ;
 I 'IBCIFN D  I 'IBCIFN W !!,"A charge can not be added for this item!",! Q
 . S IBCIFN=$$ADDCI^IBCREF(+IBCSFN,+IBITEM,IBDT) W !,?50,"Adding a new Charge Item!"
 ;
 S DR=$$DR01(+$P(IBITEM,U,4))_";.03;.04;.05;"
 ;
 I $P(IBITEM,U,4)=81 S DR=DR_".07"
 ;
DIE S DIDEL=363.2,DIE="^IBA(363.2,",DA=+IBCIFN D ^DIE K DIE,DR,X,DIDEL
 ;
        I $D(DA),$D(Y)=0 S IBX=$$RQCI^IBCREU1(+IBCIFN) I +IBX
 D DISPCSL^IBCRU7(+IBCSFN)
 G CI
 Q
BITM(X) ; return external form of billable item
 S X=+$G(X) S X=$$EXPAND^IBCRU1(363.3,.04,X)
 Q X
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
