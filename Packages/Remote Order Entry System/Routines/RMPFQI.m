RMPFQI ;DDC/KAW-PRINT PRODUCT LIST [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!,"PRINT PRODUCT LIST"
 S MU=$O(^RMPF(791810.5,"C",RMPFMENU,0))
A1 W !!,"Select <A>ll or <I>ndividual Product Groups: "
 D READ G END:$D(RMPFOUT)
A11 I $D(RMPFQUT) W !!,"Enter an <A> to print all product groups or",!?6,"an <I> to select an individual product group." G A1
 G END:Y="" S Y=$E(Y,1) I "IiAa"'[Y S RMPFQUT="" G A1
 I "Aa"[Y S (RMPFPG,RMPFIT)="*" G QUE
A2 W !! S DIC=791811.1,DIC(0)="AEQM"
 S DIC("S")="I $D(^RMPF(791811.1,+Y,101,""B"",MU))"
 D ^DIC K DIC G A1:Y=-1
 S RMPFPG=+Y
ITEM W !!,"Print <A>ll items or an <I>ndividual item? A// "
 D READ G END:$D(RMPFOUT)
ITEM1 I $D(RMPFQUT) W !!,"Enter an <A> to print all items in the product group or",!?6,"an <I> to select an individual item." G ITEM
 S:Y="" Y="A" S Y=$E(Y,1) I "AaIi"'[Y S RMPFQUT="" G ITEM1
 I "Aa"[Y S RMPFIT="*" G QUE
I1 W !! S DIC=791811,DIC(0)="AEQM",DIC("S")="I '$P($G(^RMPF(791811,Y,""I"")),U,1)" D ^DIC G ITEM:Y=-1 S RMPFIT=+Y
QUE W ! S %ZIS="NPQ" D ^%ZIS G END:POP
 I IO=IO(0),'$D(IO("S")) D ^RMPFQIP G END:$D(RMPFOUT),A1
 I $D(IO("S")) S %ZIS="",IOP=ION D ^%ZIS G ^RMPFQIP
 S ZTRTN="^RMPFQIP",ZTDESC="PRODUCT PRINT",ZTIO=ION,ZTSAVE("RM*")=""
 D ^%ZTLOAD,HOME^%ZIS
 W:$D(ZTSK) !!,"*** Request Queued ***" H 2 G RMPFSET
END K X,Y,DIC,RMPFPG,RMPFIT,ZTSK,ZTRTN,ZTIO,ZTSAVE,ZTDESC,MU,%XX,%YY
 K RMPFOUT,RMPFQUT,DISYS,POP,%,%T Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
