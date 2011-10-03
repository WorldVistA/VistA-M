PRCHCNV ; Covert purchase card orders to delivery orders and vice versa ;7/24/00  23:29
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 QUIT
PCDO ;Convert a purchase card order to a delivery order
 ;
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))
 N DIC,I,N,PRCHA,PRCHCARD,PRCHHLDR,PRCHNPO,PRCHDELV,PRCHPO,Y
 S DIC="^PRC(442,",DIC(0)="AEQM"
 S DIC("S")="I $P($G(^PRC(442,+Y,23)),U,11)=""P"",$P(^PRC(442,+Y,7),U,2)<9,$P(^PRC(442,+Y,1),U,10)=DUZ"
 S DIC("A")="Select PURCHASE CARD ORDER NUMBER: "
 D ^DIC Q:Y'>0  S PRCHOLD=+Y
 S PRCHDELV=1 D ENPO^PRCHUTL Q:'$D(PRCHPO)  S (DA,PRCHNEW)=PRCHPO
 S PRCHNPO=$P(^PRC(442,PRCHNEW,0),U)
 S %X="^PRC(442,PRCHOLD,",%Y="^PRC(442,PRCHNEW," D %XY^%RCR K %X,%Y
 S DIE="^PRC(442,"
 S DR=".01///^S X=PRCHNPO;48///^S X=""D"";.02///^S X=1;27///^S X=PRCHOLD"
 D ^DIE K DIE,DA,DR
 F I=8,15,16,17,20,21,22 S $P(^PRC(442,PRCHNEW,23),U,I)=""
 S PRCHCARD=$P(^PRC(442,PRCHOLD,23),U,8),PRCHHLDR=$P(^(23),U,22)
 K:$G(PRCHCARD) ^PRC(442,"M",PRCHCARD,PRCHOLD)
 K:$G(PRCHHLDR) ^PRC(442,"MCH",PRCHHLDR_"~",PRCHOLD)
 S DIE="^PRC(442,",DA=PRCHOLD
 S DR=".5///^S X=45;28///^S X=PRCHNEW"
 D ^DIE K DIE,DA,DR
 S DA=PRCHOLD D C2237^PRCH442A
 W !!,"This purchase card order has now been converted to a delivery order."
 W !!,?5,"The Purchase Card Order No: "_$P($P(^PRC(442,PRCHOLD,0),U),"-",2)_" has been converted",!,?5,"to Delivery Order No: "_$P($P(^PRC(442,PRCHNEW,0),U),"-",2)
 S PRCHA=""
 S N=0 F  S N=$O(^PRC(442,PRCHNEW,2,N)) Q:'N  I $P($G(^(N,2)),U,2)="" S PRCHA=PRCHA_N_","
 I PRCHA]"" D
 . W !!,?5,"The following line items on the new delivery order",!,?5," do not have a contract number: ",!,?5,PRCHA,!
 W !!,?5,"This delivery order must be edited."
 K PRCF,PRCHOLD,PRCHNEW,PRCHDELV
 N DIR S DIR(0)="E" W !!! D ^DIR
 QUIT
 ;
DOPC ;Convert a delivery order to a purchase card order
 ;
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))
 N DIC,PRCHNPO,PRCHPC,PRCHPO,Y
 S DIC="^PRC(442,",DIC(0)="AEQM"
 S DIC("S")="I $P($G(^(23)),U,11)=""D"",$P(^(7),U,2)<9"
 S DIC("A")="Select DELIVERY ORDER NUMBER: "
 D ^DIC Q:Y'>0  S PRCHOLD=+Y
 S PRCHPC=2 D ENPO^PRCHUTL Q:'$D(PRCHPO)  S (DA,PRCHNEW)=PRCHPO
 S PRCHNPO=$P(^PRC(442,PRCHNEW,0),U)
 S %X="^PRC(442,PRCHOLD,",%Y="^PRC(442,PRCHNEW," D %XY^%RCR
 S DIE="^PRC(442,",DR=".01///^S X=PRCHNPO;48///^S X=""P"";.02///^S X=25;27///^S X=PRCHOLD;.04///^S X=""@"""
 D ^DIE K DIE,DA,DR
 K ^PRC(442,PRCHNEW,5)
 S DIE="^PRC(442,",DA=PRCHOLD,DR=".5///^S X=45;28///^S X=PRCHNEW"
 D ^DIE K DIE,DA,DR
 S DA=PRCHOLD D C2237^PRCH442A
 W !!,"This delivery order is now converted to a purchase card order"
 W !!,?5,"The Deliver Order No: "_$P($P(^PRC(442,PRCHOLD,0),U),"-",2)_" has been converted",!,?5,"to Purchase Card Order No: "_$P($P(^PRC(442,PRCHNEW,0),U),"-",2)
 W !!,?5,"This purchase card order must be edited."
 K PRCF,PRCHOLD,PRCHNEW
 N DIR S DIR(0)="E" W !!! D ^DIR
 QUIT
