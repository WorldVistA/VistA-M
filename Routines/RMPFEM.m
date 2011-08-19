RMPFEM ;DDC/KAW-INACTIVATE A LINE ITEM [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!!,"INACTIVATE A LINE ITEM"
 W !!,"Inactivating a line item will make that item unavailable for selection in the"
 W !,"ordering of new products.  This option should be used to disallow items no"
 W !,"longer under contract."
SEL W !! S DIC=791811,DIC(0)="AEQM" D ^DIC G END:Y=-1 S LI=+Y
 S MK=$P(^RMPF(791811,LI,0),U,2),CS=$P(^(0),U,4)
 W !!,"Item",?22,"Make",?40,"Price"
 W !,"--------------------",?22,"----------------",?40,"-------"
 W !,$E($P(Y,U,2),1,20),?22,$E(MK,1,16),?40,"$",$J(CS,6,2)
 G A2:$D(^RMPF(791811,LI,"I"))
A1 W !!,"Are you sure you wish to inactivate this item? NO// "
 D READ G END:$D(RMPFOUT)
A11 I $D(RMPFQUT) W !!,"Type <Y>es to prevent the item from being ordered or <N>o to exit." G A1
 S:Y="" Y="N" S Y=$E(Y,1) I "NnYs"'[Y S RMPFQUT="" G A11
 G SEL:"Nn"[Y S $P(^RMPF(791811,LI,"I"),U)=1
 W !!,"*** ITEM INACTIVATED ***"
 G SEL
A2 W !!,"This item has already been inactivated.  Do you wish to re-activate? NO// "
 D READ G END:$D(RMPFOUT)
A21 I $D(RMPFQUT) W !!,"Type <Y>es to re-activate the item.  If the item is no longer",!,"under contract, any orders will be rejected from the DDC.",!,"Enter <N>o or <RETURN> to exit without change." G A2
 S:Y="" Y="N" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G A21
 G SEL:"Nn"[Y K ^RMPF(791811,LI,"I")
 W !!,"*** ITEM RE-ACTIVATED ***" G SEL:"Nn"[Y K ^RMPF(791811,LI,"I") G SEL
END K %,CS,LI,MK,DIC,DISYS,X,Y,RMPFOUT,RMPFQUT Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
