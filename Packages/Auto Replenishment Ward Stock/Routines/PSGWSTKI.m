PSGWSTKI ;BHAM ISC/CML-Stock Item Enter/Edit ; 29 Dec 93 / 8:44 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;**17**;4 JAN 94
AOU ; SELECT AOU
 K DA,DIC F QQ=0:0 S DIC="^PSI(58.1,",DIC(0)="QEAMZ" W ! D ^DIC K DIC Q:Y'>0  S AOU=+Y S:'$D(^PSI(58.1,AOU,1,0)) ^(0)="^58.11IP^^" D ITEM
QUIT K %,AOU,C,D0,D1,DI,DA,DQ,DR,I,ITEM,QQ,X,Y,CHK,DRGDA Q
ITEM ; SELECT ITEM
 F QQ=0:0 K DA S CHK=1,DA(1)=AOU,DIC="^PSI(58.1,"_AOU_",1,",DIC(0)="QEAMOLZ" D ^DIC K DIC Q:Y'>0  S ITEM=+Y D CHK I CHK S DA(1)=AOU,DA=ITEM,DIE="^PSI(58.1,"_AOU_",1,",DR="1;13;14;3;10;5",DR(2,58.13)=".01" D ^DIE K DIE W !
 Q
CHK ; CHECK FOR CURRENT INACTIVATION DATE
 I '$D(^PSI(58.1,AOU,1,ITEM,"I")) D CHK2 Q
 D CHK2 Q:'CHK
 W *7,!!?5,"This Item is currently defined for this AOU with an INACTIVATION DATE.",!!?5,"If you want to add this Item as a new standard Stock Item for this AOU",!?5,"you must delete the INACTIVATION DATE.",!
 S DA(1)=AOU,DA=ITEM,DIE="^PSI(58.1,"_AOU_",1,",DR=30 D ^DIE K DIE S CHK=$S($D(Y):0,$D(^PSI(58.1,AOU,1,ITEM,"I")):0,1:1) W !
 Q
CHK2 ; CHECK FOR NON-PHARMACY ITEMS
 S DRGDA=+^PSI(58.1,AOU,1,ITEM,0)
 S CHK=$S('$D(^PSDRUG(DRGDA,2)):1,$P(^(2),"^",3)="":1,$P(^(2),"^",3)["O":1,$P(^(2),"^",3)["U":1,$P(^(2),"^",3)["I":1,$P(^(2),"^",3)["X":1,1:$P(^(2),"^",3)["N") Q:CHK
 I '$D(^PSI(58.1,AOU,1,ITEM,"I")) S DA(1)=AOU,DA=ITEM,DIE="^PSI(58.1,"_AOU_",1,",DR=30_"///"_DT D ^DIE K DIE
 W *7,!!?5,"This item is currently defined for this AOU but appears to be a",!?5,"non-pharmacy drug.  It has been inactivated as of " S Y=$O(^PSI(58.1,AOU,1,ITEM,"I",0)) X ^DD("DD") W Y,!
 Q
