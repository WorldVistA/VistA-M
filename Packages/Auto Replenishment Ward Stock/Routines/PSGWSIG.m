PSGWSIG ;BHAM ISC/CML-Build Sort Key for AOUs in Inventory Group ; 17 Aug 93 / 12:58 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 S PSGWDT=$$PSGWDT^PSGWUTL1 S $P(LN,"-",80)=""
DIC S DIC="^PSI(58.2,",DIC(0)="AEQM",DIC("S")="I $D(^PSI(58.2,""WS"",+Y))" D ^DIC K DIC G:Y<0 END S INVGRP=+Y D PRINT G:POP END
ASK1 R !!,"Make..... ",X:DTIME S:'$T X="^" G:"^"[X END I $E(X)="?" W !!,"Enter the name of the AOU you wish to move to another location.",!,"Enter <RETURN> or ""^"" to Exit." G ASK1
 S DIC="^PSI(58.2,"_INVGRP_",1,",DIC(0)="QEMZ" D ^DIC K DIC G:Y<0 ASK1 S AOUM=Y(0,0),AOUDA=+Y
ASK2 R !,"Follow... ",X:DTIME S:'$T X="^" G:"^"[X END I $E(X)="?" W !!,"Enter the name of the AOU you wish ",AOUM," to follow.",!,"Enter <RETURN> or ""^"" to Exit.",! G ASK2
 S DIC="^PSI(58.2,"_INVGRP_",1,",DIC(0)="QEMZ",DIC("S")="I $P(^(0),""^"")'=AOUDA" D ^DIC K DIC G:Y<0 ASK2
NEW S PSGSORT=$P(Y(0),"^",2),PSGSORTN=$O(^PSI(58.2,INVGRP,1,"D",PSGSORT)) I PSGSORTN'>0 S PSGNSORT=PSGSORT+50
 E  S PSGNSORT=PSGSORT+((PSGSORTN-PSGSORT)/2)
DIE S DIE="^PSI(58.2,",DA=INVGRP,DR="1///"_AOUM,DR(2,58.21)="2///"_PSGNSORT D ^DIE I PSGNSORT["." D IGSET^PSGWUTL1
BOTTOM W !!,"Do you wish to print the AOU List again " S %=2 D YN^DICN I %=0 W !?5,"Enter 'YES' if you wish to see the current AOU sort order for ",!?5,$P(^PSI(58.2,INVGRP,0),"^") G BOTTOM
 D:%=1 PRINT G ASK1
END K %,%H,%I,%Y,INVGRP,PSGFGRP,PSGNSORT,PSGSORT,PSGSORTN,A,DIC,DIE,DA,DR,X,Y,L,FLDS,BY,FR,TO,DIJ,DP,AOUM,B,C,D,D0,D1,DI,DISYS,DQ,LN,PSGWDT,AOUDA
 Q
 ;
PRINT S L=0,DIC="^PSI(58.2,",FLDS="AREA,AREA",BY="'NUMBER@,AREA,SORT@",FR=INVGRP,TO=FR,DHD="W ?0 D HDR^PSGWSIG" D EN1^DIP Q
HDR W !,"AOU Inventory Group List",?60,PSGWDT,!!,"Current AOU Sort Order for ",$P(^PSI(58.2,INVGRP,0),"^"),!,LN Q
