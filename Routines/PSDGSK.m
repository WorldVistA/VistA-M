PSDGSK ;BIR/CML,JPW-Build Sort Key for NAOUs in Inven. Grp ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S PSDT=Y K LN S $P(LN,"-",80)=""
DIC S DIC="^PSI(58.2,",DIC(0)="AEQ",DIC("A")="Select NAOU INVENTORY GROUP NAME: ",DIC("S")="I $D(^PSI(58.2,""CS"",+Y))" D ^DIC K DIC G:Y<0 END S INVGRP=+Y D PRINT
ASK1 R !!,"Make..... ",X:DTIME S:'$T X="^" G:"^"[X END I $E(X)="?" W !!,"Enter the name of the NAOU you wish to move to another location.",!,"Enter <RET> or ""^"" to EXIT." G ASK1
 S DIC="^PSI(58.2,"_INVGRP_",3,",DIC(0)="QEZ" D ^DIC K DIC G:Y<0 ASK1 S NAOUM=Y(0,0),NAOUDA=+Y
ASK2 R !,"Follow... ",X:DTIME S:'$T X="^" G:"^"[X END I $E(X)="?" W !!,"Enter the name of the NAOU you wish ",NAOUM," to follow.",!,"Enter <RET> or ""^"" to EXIT.",! G ASK2
 S DIC="^PSI(58.2,"_INVGRP_",3,",DIC(0)="QEZ",DIC("S")="I $P(^(0),""^"")'=NAOUDA" D ^DIC K DIC G:Y<0 ASK2
NEW S PSDSORT=$P(Y(0),"^",2),PSDSORTN=$O(^PSI(58.2,INVGRP,3,"D",PSDSORT)) I 'PSDSORTN S PSDNSORT=PSDSORT+50
 E  S PSDNSORT=PSDSORT+((PSDSORTN-PSDSORT)/2)
DIE S DIE="^PSI(58.2,",DA=INVGRP,DR="3///"_NAOUM,DR(2,58.29)="2///"_PSDNSORT D ^DIE I PSDNSORT["." D IGSET^PSDUTL
BOTTOM W !!,"Do you wish to print the NAOU List again " S %=2 D YN^DICN I %=0 W !?5,"Enter 'YES' if you wish to see the current AOU sort order for ",!?5,$P(^PSI(58.2,INVGRP,0),"^") G BOTTOM
 D:%=1 PRINT G ASK1
END K %,%H,%I,%Y,INVGRP,PSDFGRP,PSDNSORT,PSDSORT,PSDSORTN,A,DIC,DIE,DA,DR,DTOUT,X,Y,L,FLDS,BY,FR,TO,DIJ,DP,NAOUM,B,C,D,D0,D1,DI,DISYS,DQ,LN,PSDT,NAOUDA,POP,DHD
 Q
 ;
PRINT S L=0,DIC="^PSI(58.2,",FLDS="NARCOTIC,NARCOTIC",BY="'NUMBER@,NARCOTIC,SORT@",FR=INVGRP,TO=FR,DHD="W ?0 D HDR^PSDGSK" D EN1^DIP
 Q
HDR W !,"NAOU Inventory Group List",?60,PSDT,!!,"Current NAOU Sort Order for ",$P(^PSI(58.2,INVGRP,0),"^"),!,LN Q
