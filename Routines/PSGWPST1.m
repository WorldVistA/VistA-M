PSGWPST1 ;BHAM ISC/KKA - POST INIT CONVERSION ROUTINE-CONT. ; 03 Sep 93 / 9:32 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
POST5 ;Reindex "WS" cross-reference 
 S CNT=0
 W !!,"Now reindexing the ""WS"" cross-reference on the AREA OF USE (AOU) field of the",!,"AREA OF USE (AOU) subfile of the AOU INVENTORY GROUP file."
 S NAME=0 F  S NAME=$O(^PSI(58.2,NAME)) Q:'NAME  S AOU=0 F  S AOU=$O(^PSI(58.2,NAME,1,AOU)) Q:'AOU  S ^PSI(58.2,"WS",NAME,AOU)="" S CNT=CNT+1 W:CNT#10=0 "."
 K AOU,NAME,CNT
POST6 ;Delete unnecessary fields from options
 F PSGWOPT="PSGW AOU INV GROUP EDIT","PSGW AREA OF USE EDIT","PSGW INV TYPE EDIT","PSGW ITEM LOC EDIT","PSGW SITE" D
 .K DIC S DIC="^DIC(19,",DIC(0)="X",D="B"
 .S X=PSGWOPT D MIX^DIC1 Q:Y<0
 .K DA,DR,DIE,DIC S DA=+Y,DIE=19,DR="30///@;31///@;50///@;51///@" D ^DIE
 K DIC,DIE,DR,DA,D,PSGWOPT,X,Y Q
