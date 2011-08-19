PSOMGREP ;BHAM ISC/JMB - DAILY MANAGEMENT REPORT ; 3/30/93
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
BEG G:'$D(RUN) END S SDT=0,SDT=$O(^PS(59.12,"B",SDT)) G:$G(SDT)=""!($L(SDT)'=7) IV S Y=SDT D DD^%DT S PSDT=Y
IV S OK=$O(^PS(50.8,0)) G:OK="" DISP
 S IVS=0 F IEN=0:0 S IEN=$O(^PS(50.8,IEN)) Q:'IEN!($L(IVS)=7)  F IVS=0:0 S IVS=$O(^PS(50.8,IEN,2,IVS)) S:$L(IVS)=7 IVSDT=IVS Q:$L(IVS)=7!('IVS)
 G:$G(IVSDT)="" DISP S Y=IVSDT D DD^%DT S PIVSDT=Y
DISP K OK W:$G(SDT)'=""&(RUN'=4) !!!!?5,"**Prescription data available to print starts with "_PSDT_".**"
 I ('$D(SDT)!(SDT=""))&(RUN'=4) W !!?13,$C(7),$C(7),"**There is no prescription data available to print.**",!?8,"Use the Date Range Compile data option to make the data available." K SDT G END
 W:$D(IVSDT) !!?10,"**IV data available to print starts with "_PIVSDT_".**"
 I '$D(IVSDT) W !!?18,$C(7),$C(7),"**There is no IV data available to print.**" K IVSDT G:RUN=4 END
 I '$D(IVSDT)&('$D(SDT)) W !!,"There is no prescription and IV data available to print." G END
 I RUN=4 S ANS="A" G PAP
 S DVCNT=0 F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV  S DVCNT=DVCNT+1,DV=DIV
PRTDV S:DVCNT=1 ANS="S",DIV=DV I DVCNT>1 W !! S DIR("A")="Print data for all or a specific division",DIR(0)="SBO^A:ALL;S:SPECIFIC",DIR("?")="Answer 'A' for all if you want to print all divisions' report." D
 .S DIR("??")="Answer 'S' for specific if you want to print one division's report." D ^DIR K OUT S:$D(DIRUT) OUT=1 K DIR S ANS=Y
 G:$G(OUT) END I ANS="S",DVCNT>1 W ! S DIC("A")="Division: ",DIC=59,DIC(0)="AEMQZ" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<0) PRTDV S DIV=+Y
PAP W !!,"PLEASE PRINT ON WIDE PAPER, I.E., 132 COLUMNS."
SDT W !! S %DT(0)=-DT,%DT("A")="PRINT MANAGEMENT STATS STARTING: " S %DT="EPXA" D ^%DT G:"^"[X END
 I RUN'=4&(Y<$G(SDT)) W !!,$C(7),"Data available to print starts with "_PSDT_".",! G SDT
 I RUN=4&(Y<$G(IVSDT)) W !!,$C(7),"Data available to print starts with "_PIVSDT_".",! G SDT
 G:Y<0 PRTDV S SDT=Y
EDT W ! S %DT("A")="ENDING STATS DATE: " D ^%DT G:"^"[X END S EDT=Y I Y<0!(SDT>EDT) W $C(7)," INVALID ENDING DATE ???" G EDT
 S FND=$O(^PS(59.12,SDT-1)) I RUN'=4,(FND>EDT!(+FND=0)) S Y=SDT X ^DD("DD") S SDATE=Y,Y=EDT X ^DD("DD") S EDATE=Y
 I  W !!?5,$C(7),$C(7),"**There is no prescription data between "_SDATE_" and "_EDATE_".**",!?7,"Use the Date Range Compile data option to make the data available." G END
QUE K %DT,%ZIS,IOP,ZTSK,DVCNT,PSOION S PSOION=ION,%ZIS("B")="",%ZIS="QM" D ^%ZIS
 I POP S IOP=PSOION D ^%ZIS U IO K IOP,PSOION W !,$C(7),$C(7),"Report not Queued!" G END
 K DVCNT I $D(IO("Q")) S ZTRTN=$S(RUN="A":"ENQ^PSOMGRP1",RUN=1:"EN^PSOMGRP1",RUN=2:"EN^PSOMGRP2",RUN=3:"EN^PSOMGRP3",1:"EN^PSOMGRP4"),ZTDESC="Outpatient Management Report" F G="SDT","EDT","DIV","ANS","RUN" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued !" K G,Y,X,%DT G END
 D:RUN="A" ENQ^PSOMGRP1 D:RUN=1 EN^PSOMGRP1 D:RUN=2 EN^PSOMGRP2 D:RUN=3 EN^PSOMGRP3 D:RUN=4 EN^PSOMGRP4
END D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,%DT,ANS,BEG,CNT,DIR,DIRUT,DIV,DV,DVMN,DTOUT,DUOUT,EDATE,EDT,END,FND,G,K,I,IEN,IVE,IVS,M1,M2,M3,OUT,PG,POP,PRT,PRV,PDATE,PIVSDT,PSDT,PSOION,RUN,SDATE,SDT,S1,S2,S3,T1,T2,T3,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 Q
