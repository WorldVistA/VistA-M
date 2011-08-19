PSGWEXP ;BHAM ISC/CML-Enter/Edit Drug Expiration Dates ; 26 Nov 93 / 2:46 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!,"Enter Expiration Dates for Stock Items"
 K DIC F QQ=0:0 S DIC="^PSI(58.1,",DIC(0)="QEAM",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0)" W ! D ^DIC K DIC Q:Y'>0  W ! S MEDR=+Y F QQ=0:0 D ITEM Q:"^"[X
QUIT K %,C,D0,DA,DI,DIE,DIC,DIYS,DQ,DR,MEDR,QQ,X,Y Q
ITEM I '$O(^PSI(58.1,MEDR,1,0)) W !!,"No items exist for this AOU." S X="^" Q
 S DIC="^PSI(58.1,"_MEDR_",1,",DIC(0)="QEAOM" W ! D ^DIC Q:Y'>0  S DA(1)=MEDR,DA=+Y,DIE=DIC,DR="35" W ! D ^DIE Q
