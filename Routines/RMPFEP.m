RMPFEP ;DDC/KAW-ENTER/EDIT PRODUCTS FOR ASPS [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 W @IOF,!,"PRODUCT, COMPONENT & BATTERY ENTER/EDIT"
 W !!,"***  USE THIS OPTION WITH CAUTION ***"
 W !!!,"Products, components and batteries must be entered or edited ONLY"
 W !,"as directed by the DDC."
 W !!,"If entries vary in any way (even by one character) from the entry in the DDC",!,"file, all orders for which this entry is chosen will be rejected."
A1 W !!,"Edit <P>roduct, <C>omponent or <B>attery File? " D READ G END:$D(RMPFOUT)
A11 I $D(RMPFQUT) W !!,"Enter a <P> to edit the Product File",!?6,"a <C> to edit the Component File or",!?6,"a <B> to edit the Battery File" G A1
 G END:Y="" S Y=$E(Y,1) I "PpCcBb"'[Y S RMPFQUT="" G A11
 S RMPFSEL=$S("Pp"[Y:"P","Bb"[Y:"B",1:"C")
 D PRODUCT:RMPFSEL="P",COMPON:RMPFSEL="C",BATTERY:RMPFSEL="B"
 G RMPFEP
END K DIC,DIE,DR,DA,DI,DISYS,D1,D0,DLAYGO,DQ,%,RMPFSEL,X,Y Q
PRODUCT W @IOF,!!,"ENTER/EDIT PRODUCTS"
 W !!,"If you are entering a product that has components or batteries"
 W !,"the components and batteries must be entered into the Component File and"
 W !,"Battery File before they can be chosen through this option."
 W !!,"ONLY enter components and batteries for a product if they are DDC approved."
P1 W !! S DIC=791811,DIC(0)="AEQML",DLAYGO=791811 D ^DIC Q:Y=-1
 S DIE=791811,DA=+Y
 S DR=".01;.02;.03;.04;.05;.06////9;.07;.08;101;102"
 D ^DIE
 K DIC,DIE,DD,DO G P1
COMPON W @IOF,!,"ENTER/EDIT COMPONENTS"
 W !!,"ONLY enter components that are currently on contract."
C1 W !! S DIC=791811.2,DIC(0)="AEQML",DLAYGO=791811.2 D ^DIC Q:Y=-1
 W !! S DIE=DIC,DA=+Y,DR=".01;.03" D ^DIE
 K DIC,DIE,DD,DO G C1
BATTERY W @IOF,!,"ENTER/EDIT BATTERIES"
 W !!,"ONLY enter batteries that are distributed by the DDC."
B1 W !! S DIC=791811.3,DIC(0)="AEQML",DLAYGO=791811.3 D ^DIC Q:Y=-1
 K DIC,DIE,DO,DD G B1
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W *7 R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
