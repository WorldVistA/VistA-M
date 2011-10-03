RMPFEP2 ;DDC/KAW-ENTER/EDIT PRODUCTS FOR PSAS [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 W @IOF,!,"PRODUCT ENTER/EDIT"
 W !!,"***  USE THIS OPTION WITH CAUTION ***"
 W !!!,"Products must be entered or edited ONLY as directed by the DDC."
 W !!,"If entries vary in any way (even by one character) from the entry in the DDC",!,"file, all orders for which this entry is chosen will be rejected."
P1 W ! S DIC="^RMPF(791811,",DIC(0)="AEQLM",DLAYGO=791811
 D ^DIC G END:Y=-1 S DIE=DIC,DA=+Y,DR=".01;.03;.04;.05;.08;.09" D ^DIE
 K DIC,DIC,DA,DR,DD,DO,DQ,D0,DDH
 G P1
END K X,Y,DIC,DIE,DA,DR,DD,DO,DQ,D0,H,DI,DISYS,%,I,C,%R,%Y,DLAYGO Q
