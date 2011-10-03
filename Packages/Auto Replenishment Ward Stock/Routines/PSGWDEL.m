PSGWDEL ;BHAM ISC/CML-Delete Inventory Sheets ; 02/14/90 8:14
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!,"*** READY TO DELETE ***",! F II=0:0 S DIC="^PSI(58.19,",DIC(0)="QEAMN",DIC("A")="Select DATE/TIME FOR INVENTORY to be deleted: " W ! D ^DIC K DIC Q:Y'>0  S INVDA=+Y,INVDT=$P(Y,"^",2) D START
QUIT K ^TMP("PSGW",$J),%,%Y,BO,BODRUG,GRP,II,DA,DIK,INVDA,INVDT,ITM,LN,LP,MR,PC,X,Y Q
START ;
 W !!,"First, let me check for existing entries in other files for this Inventory Date.",! K ^TMP("PSGW",$J) D CHK
 I $D(^TMP("PSGW",$J)) D PRT W *7,!!,"Because this Inventory Date is pointed to, it cannot be deleted at this time." Q
 I '$D(^TMP("PSGW",$J)) W !!,"None found." F II=0:0 W !!,"Are you sure you want to delete this Inventory Sheet " S %=2 D YN^DICN Q:%  W !?60,"Enter 'Y' or 'N'"
 Q:%'=1  S DIK="^PSI(58.19,",DA=INVDA D ^DIK W !,"...Deleted" Q
CHK ;Check PHARMACY AOU STOCK FILE (#58.1)
 F MR=0:0 S MR=$O(^PSI(58.1,MR)) Q:'MR  W "." F ITM=0:0 S ITM=$O(^PSI(58.1,MR,1,ITM)) Q:'ITM  I $D(^(ITM,1,INVDA,0)) S ^TMP("PSGW",$J,"PASF",MR,ITM)=""
 ;Check PHARMACY BACKORDER file (#58.3)
 F BO=0:0 S BO=$O(^PSI(58.3,"D",INVDT,BO)) Q:'BO  S MR=$O(^(BO,0)) I MR W "." S ^TMP("PSGW",$J,"PBO",BO,MR)=""
 Q
PRT ;Print pointer entries
 S $P(LN,"-",80)=""
 I $D(^TMP("PSGW",$J,"PASF")) W !!,"***> There are entries in the PHARMACY AOU STOCK FILE (#58.1) for this",!?5,"DATE/TIME FOR INVENTORY for MED ROOM(S):",!,LN
 I  F MR=0:0 S MR=$O(^TMP("PSGW",$J,"PASF",MR)) Q:'MR  W !,$P(^PSI(58.1,MR,0),"^")
 I $D(^TMP("PSGW",$J,"PBO")) W !!,"***> There are entries in the PHARMACY BACKORDER FILE (#58.3) for this",!?5,"DATE/TIME FOR INVENTORY for the following ITEMS:",!!?18,"ITEM",?50,"MED ROOM",!,LN
 I  F BO=0:0 S BO=$O(^TMP("PSGW",$J,"PBO",BO)) Q:'BO  S:$D(^PSI(58.3,BO,0)) BODRUG=+^(0) Q:'BODRUG  F MR=0:0 S MR=$O(^TMP("PSGW",$J,"PBO",BO,MR)) Q:'MR  W !,$P(^PSDRUG(BODRUG,0),"^"),?45,$P(^PSI(58.1,MR,0),"^")
 Q
