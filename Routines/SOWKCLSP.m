SOWKCLSP ;B'HAM ISC/SAB,DLR-Routine to print special population report ; 25 Feb 93 / 9:16 AM  [ 09/22/94  1:08 PM ]
 ;;3.0; Social Work ;**34,53**;27 Apr 93
 K ^TMP($J)
BEG W ! S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y X ^DD("DD") S SBA=Y
END W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SE1=Y X ^DD("DD") S SEA=Y
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K SOWKION,IOP G CLOS Q
 K SOWKION I $D(IO("Q")) S ZTRTN="ENQ^SOWKCLSP",ZTDESC="SPECIAL POPULATION REPORT - SOCIAL WORK" F G="SE1","SB1","SBA","SEA" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) G CLOS
 I $D(ZTSK) W !!,"Task Queued to Print",! K ZTSK G CLOS
ENQ F SOWK=0:0 S SOWK=$O(^SOWK(650,SOWK)) Q:'SOWK  I $P(^SOWK(650,SOWK,0),"^",2)'<SB1,$P(^(0),"^",2)'>SE1 S CN=^SOWK(650,SOWK,0) I $P(CN,"^",14) D SP
 D PRI
CLOS W ! W:$E(IOST)'["C" @IOF D ^%ZISC K ^TMP($J),C,X,SB1,SP,CN,SBA,SEA,Y,SE1,IOP,POP,SOWK,DFN,%DT,AG,G,I,PR,OC,OUT,DS,EL,SX,RU,RN D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD
 Q
SP S SP=$P(^SOWK(650.1,$P(CN,"^",5),2,$P(CN,"^",14),0),"^"),SP(SP)="" W:'$D(ZTSK) "." D CAL
 Q
 ;CALCULATE TOTALS
CAL S DFN=$P(CN,"^",8) D DEM^VADPT,ELIG^VADPT S AG=$S(+VADM(4)<29:1,+VADM(4)'<30&(+VADM(4)'>44):2,+VADM(4)'<45&(+VADM(4)'>59):3,+VADM(4)'<60&(+VADM(4)'>79):4,1:5)
 S:'$D(^TMP($J,SP,"AG",AG)) ^TMP($J,SP,"AG",AG)=0 S ^TMP($J,SP,"AG",AG)=^TMP($J,SP,"AG",AG)+1,SX=$S($P(VADM(5),"^")="M":1,$P(VADM(5),"^")="F":2,1:0)
 S EL=$S($P(VAEL(9),"^")="A":1,$P(VAEL(9),"^")="B":2,$P(VAEL(9),"^")="C":3,1:0) I SX S:'$D(^TMP($J,SP,"SX",AG,SX)) ^TMP($J,SP,"SX",AG,SX)=0 S ^TMP($J,SP,"SX",AG,SX)=^TMP($J,SP,"SX",AG,SX)+1
 I EL S:'$D(^TMP($J,SP,"EL",AG,EL)) ^TMP($J,SP,"EL",AG,EL)=0 S ^TMP($J,SP,"EL",AG,EL)=^TMP($J,SP,"EL",AG,EL)+1
 S (PR,OC)="" F I=0:0 S I=$O(^SOWK(650,SOWK,2,I)) Q:'I  S PR=$P(^SOWK(650,SOWK,2,I,0),"^") S:'$D(^TMP($J,SP,"PR",AG,PR)) ^TMP($J,SP,"PR",AG,PR)=0 S ^TMP($J,SP,"PR",AG,PR)=^TMP($J,SP,"PR",AG,PR)+1
 F I=0:0 S I=$O(^SOWK(650,SOWK,2,I)) Q:'I  S OC=+$P(^SOWK(650,SOWK,2,I,0),"^",2) I OC S:'$D(^TMP($J,SP,"OC",AG,OC)) ^TMP($J,SP,"OC",AG,OC)=0 S ^TMP($J,SP,"OC",AG,OC)=^TMP($J,SP,"OC",AG,OC)+1
 F I=0:0 S I=$O(^SOWK(650,SOWK,5,I)) Q:'I  S DS=$P(^SOWK(650,SOWK,5,I,0),"^") S:'$D(^TMP($J,SP,"DS",AG,DS)) ^TMP($J,SP,"DS",AG,DS)=0 S ^TMP($J,SP,"DS",AG,DS)=^TMP($J,SP,"DS",AG,DS)+1
 F I=0:0 S I=$O(^SOWK(650,SOWK,1,I)) Q:'I  I $P(^SOWK(650,SOWK,1,I,0),"^",3) S RU=$P(^(0),"^") S:'$D(^TMP($J,SP,"RU",AG,RU)) ^TMP($J,SP,"RU",AG,RU)=0 S ^TMP($J,SP,"RU",AG,RU)=^TMP($J,SP,"RU",AG,RU)+1
 F I=0:0 S I=$O(^SOWK(650,SOWK,1,I)) Q:'I  I '$P(^SOWK(650,SOWK,1,I,0),"^",3) S RN=$P(^(0),"^") S:'$D(^TMP($J,SP,"RN",AG,RN)) ^TMP($J,SP,"RN",AG,RN)=0 S ^TMP($J,SP,"RU",AG,RN)=^TMP($J,SP,"RN",AG,RN)+1
 Q
PRI ;print data
 U IO W:$Y @IOF D HDR1 S SP="" F I=0:0 S SP=$O(SP(SP)) Q:SP=""  D:($Y+10)>IOSL CHK Q:$G(OUT)=1  W !!?10,"SPECIAL PATIENT POPULATION: "_SP D HDR F AG=1:1:5 D OUT
 Q
OUT W !,$S(AG=1:"-29",AG=2:"30 TO 44",AG=3:"45 TO 59",AG=4:"60 TO 79",1:"80+")
 W ?10 W:$D(^TMP($J,SP,"SX",AG,1)) ^(1)_" " W:$D(^TMP($J,SP,"SX",AG,2)) ?14,^(2)_" "
 W ?18 F I=0:0 S I=$O(^TMP($J,SP,"EL",AG,I)) Q:'I  W ^TMP($J,SP,"EL",AG,I)_" "
 S C=0 W ?30 F I=0:0 S C=C+1,I=$O(^TMP($J,SP,"PR",AG,I)) Q:'I!(C>8)  W I_" "
 S C=0 W ?60 F I=0:0 S C=C+1,I=$O(^TMP($J,SP,"OC",AG,I)) Q:'I!(C>8)  W I_" "
 S C=0 W ?80 F I=0:0 S C=C+1,I=$O(^TMP($J,SP,"DS",AG,I)) Q:'I!(C>8)  W I_" "
 S C=0 W ?100 F I=0:0 S C=C+1,I=$O(^TMP($J,SP,"RU",AG,I)) Q:'I!(C>8)  W I_" "
 S C=0 W "/ " F I=0:0 S C=C+1,I=$O(^TMP($J,SP,"RN",AG,I)) Q:'I!(C>8)  W:($X+3)>IOM !?124 W I_" "
 Q
HDR W !,?11,"SEX",?18,"ELIG. CAT.",?110,"RESOURCES",!,"AGE RANGE",?10,"M   F",?18,"A  B  C",?30,"PROBLEMS",?60,"OUTCOMES",?80,"DIRECT SERVICES",?100,"USED",?120,"/ NEEDED",!
 Q
HDR1 W !!?45,"Department of Veterans Affairs",!?50,$P(^DD("SITE"),"^")_" ("_$P(^DD("SITE",1),"^")_")"
 W !?40,"Social Work Information Management System",!?20,"Special Patient Population Report",?60,"Reporting Period "_SBA_" to "_SEA,!
 D NOW^%DTC S Y=% X ^DD("DD") W ?45,"Run Date/Time: "_Y
 Q
CHK ;
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1
 W @IOF
 D:$G(OUT)'=1 HDR1
 Q
