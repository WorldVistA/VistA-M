PSGWPERE ;BHAM ISC/CML-Edit person doing inventory ; 06 Dec 93 / 11:09 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!,"This option will allow editing of the PERSON DOING INVENTORY field",!,"in the Pharmacy AOU Inventory file for a selected Date/Time for Inventory."
EN ;
 F II=0:0 S DIC="^PSI(58.19,",DIC(0)="QEAM" W ! D ^DIC K DIC Q:Y<0  S DA=+Y,DR=1,DIE="^PSI(58.19," D ^DIE K DIE Q:$D(Y)
QUIT K %,D0,DI,DISYS,QR,DR,GRP,II,LP,PC,DA,X,Y Q
