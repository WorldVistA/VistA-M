PSGWFIL ;BHAM ISC/MPH,CML-Fill Backorder ; 14 Feb 1989  1:49 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 S DIC="^PSI(58.3,",DIC(0)="QEAOM" D ^DIC K DIC G:Y'>0 DONE S DA(2)=+Y
 S DIC="^PSI(58.3,"_DA(2)_",1,",DIC(0)="QEAM" D ^DIC K DIC G:Y'>0 DONE S DA(1)=+Y
 S DIC="^PSI(58.3,"_DA(2)_",1,"_DA(1)_",1,",DIC(0)="QEAM" D ^DIC G:Y'>0 DONE S DA=+Y
 S DIE=DIC,DR="4" D ^DIE
DONE K DIC,DIE,DA,DR,X,Y,%DT,%X,C,D0,DI,DIYS,DQ Q
