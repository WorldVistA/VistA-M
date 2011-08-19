PSGWCCE ;BHAM/CML-Input AOU 'LOCATION' field ; 29 Dec 93 / 2:09 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
START ;
 I '$O(^PSI(58.1,0)) W *7,!!,"There are no AOUs defined!!" Q
EDIT F JJ=0:0 S DIC="^PSI(58.1,",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",5)" W ! D ^DIC K DIC Q:Y<0  S DA=+Y,DIE="^PSI(58.1,",DR=7 D ^DIE K DIE Q:$D(Y)
QUIT K %,JJ,D,D0,DA,DI,DIC,DISYS,DQ,DR,JJ,X,Y Q
