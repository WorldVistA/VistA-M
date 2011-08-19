PSGWBOE ;BHAM ISC/CML-Backorder Input Routine to replace 'PSGW BACKORDER INPUT' Template ; 29 Dec 93 / 8:31 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
ITEM ; Select ITEM to be backordered
 D NOW^%DTC S INDT=$P(%,".") K DA,DIC F QQ=0:0 S (DIC,DLAYGO)="^PSI(58.3,",DIC(0)="QEAMOLZ" W ! D ^DIC K DIC,DLAYGO Q:Y'>0  W ! D MEDRM
QUIT K %,%Y,C,D0,D1,D2,DI,DIE,DIG,DIH,DIU,DIV,DQ,DR,GRP,I,INDT,ITEM,ITM,ITMDT,LP,MEDR,MEDRPT,NUM,PC,QQ,X,Y,DA,DIC,DIK Q
MEDRM ; Select MED ROOM (AOU)
 S NUM=+Y,ITM=Y(0) I '$D(^PSI(58.3,NUM,1,0)) S ^(0)="^58.31PA^"
 F QQ=0:0 K DA S DA(1)=NUM,DIC="^PSI(58.3,"_NUM_",1,",DIC(0)="QEAMLZ" D ^DIC K DIC Q:Y'>0  W ! D DATE
 K DA I '$O(^PSI(58.3,NUM,1,0)) W *7,!!?5,"Missing MED ROOM data, deleting PHARMACY BACKORDER ITEM entry....",! S DIK="^PSI(58.3,",DA=NUM D ^DIK
 Q
DATE ; Select Backorder Date
 S MEDR=+Y,MEDRPT=Y(0) I '$D(^PSI(58.1,MEDRPT,1,"B",ITM)) W *7,!!,"The MED ROOM you have chosen does not stock this item!",! S DIK="^PSI(58.3,"_DA(1)_",1,",DA=MEDR D ^DIK K DIK Q
 S ITEM=$O(^PSI(58.1,+Y,1,"B",ITM,0)),ITMDT=$O(^PSI(58.1,MEDRPT,1,ITEM,"I",0))
 I ITMDT,ITMDT'>INDT,$P(^PSI(58.1,MEDRPT,1,ITEM,0),"^",9)'="ONE TIME REQ." W *7,!!,"This item is INACTIVE for the MED ROOM you have chosen.",! S DIK="^PSI(58.3,"_NUM_",1,",DA=MEDR D ^DIK K DIK Q
 I '$D(^PSI(58.3,NUM,1,MEDR,1,0)) S ^(0)="^58.32D^"
 F QQ=0:0 K DA S DA(2)=NUM,DA(1)=MEDR,DIC="^PSI(58.3,"_DA(2)_",1,"_DA(1)_",1,",DIC(0)="QEAML" D ^DIC Q:Y'>0  W ! S DA=+Y,DIE=DIC,DR=1 D ^DIE W ! I X']"" D DELBO
 K DA I '$O(^PSI(58.3,NUM,1,MEDR,1,0)) W *7,!!?5,"Missing DATE/TIME FOR BACKORDER data, deleting ",$P(^PSI(58.1,MEDRPT,0),"^")," entry...",! S DA(1)=NUM,DA=MEDR,DIK="^PSI(58.3,"_DA(1)_",1," D ^DIK K DIK
 Q
DELBO ;
 I $D(^PSI(58.3,NUM,1,MEDR,1,DA,0)),$P(^(0),"^",2) Q
 W *7,!!?5,"Missing CURRENT BACKORDER data, deleting BACKORDER entry...",! S DIK=DIC D ^DIK K DIK Q
