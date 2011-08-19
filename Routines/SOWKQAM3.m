SOWKQAM3 ;B'HAM ISC/SAB,DLR-Routine to print quality mgmt. monitor III report ; 20 Apr 93 / 7:57 AM [ 09/23/94  1:03 PM ]
 ;;3.0; Social Work ;**34,53**;27 Apr 93
 K ^TMP($J)
BEG W ! S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y X ^DD("DD") S SBA=Y
END W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SE1=Y X ^DD("DD") S SEA=Y I SE1<SB1 W !,"Ending date must be after starting date ",! G BEG
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K SOWKION,IOP G CLOS Q
 K SOWKION I $D(IO("Q")) S ZTRTN="ENQ^SOWKQAM3",ZTDESC="QUALITY MGMT. MONITOR III REPORT - SOCIAL WORK" F G="SE1","SB1","SBA","SEA" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) G CLOS
 I $D(ZTSK) W !!,"Task Queued to Print",! K ZTSK G CLOS
ENQ K ^TMP($J) S ELD=$P(^SOWK(650.1,1,0),"^",21) F SOWK=0:0 S SOWK=$O(^SOWK(650,SOWK)) Q:'SOWK  D GET
 D PRI I $G(OUT)'=1 W !!,"TOTALS",?30,$J(PAT,3,0),?55,$S(PAT:$J(TOT/PAT,4,0),1:$J("0",4,0))
CLOS W ! W:$E(IOST)'["C" @IOF D ^%ZISC K ^TMP($J),ADM,D,DFN,ELD,ELDS,PAT,LOC,TOT,SB1,CDC,CN,SBA,SEA,Y,SE1,IOP,OUT,POP,SOWK,%DT,SOWKI1,G,I,X,X1,X2 D:$D(ZTSK) KILL^%ZTLOAD
 Q
CAL ;CALCULATE TOTALS
 S CN=^SOWK(650,SOWK,0),CDC=$P(CN,"^",13) F SOWKI1=0:0 S SOWKI1=$O(^SOWK(650,SOWK,5,SOWKI1)) Q:'SOWKI1  I $P(^SOWK(655.202,$P(^SOWK(650,SOWK,5,SOWKI1,0),"^"),0),"^")="DISCHARGE PLANNING" D POST
 Q
POST S DFN=$P(CN,"^",8),G=$O(^DGPM("ATID1",DFN,0)) Q:'G  S ADM=$O(^DGPM("ATID1",DFN,G,0)),ADM=$P(^DGPM(ADM,0),"^")
 S X1=$P(CN,"^",2),X2=$E(ADM,1,7) D ^%DTC I X'<ELD S ELDS=X D SETUP
 Q
PRI ;print data
 S (TOT,PAT)=0,LOC="" W:$Y @IOF D HDR1
 F I=0:0 S LOC=$O(^TMP($J,LOC)) Q:LOC=""!($G(OUT)=1)  S D=^TMP($J,LOC,0) D:($Y+10)>IOSL CHK Q:$G(OUT)=1  W !,LOC,?32,$P(D,"^"),?55,$J($P(D,"^",2)/$P(D,"^"),4,0) S PAT=PAT+$P(D,"^"),TOT=TOT+($P(D,"^",2)/$P(D,"^"))
 Q
HDR1 U IO W !!?45,"Department of Veterans Affairs",!?44,$P(^DD("SITE"),"^")_" ("_$P(^DD("SITE",1),"^")_")",!?40,"Social Work Information Management System",!?45,"Quality Management Monitor III"
 W !?30,"Timeliness of service to patients receiving discharge planning",!,"Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?60,"Reporting Period "_SBA_" to "_SEA,!
 W !,"Location: ",?30,"# PTS REC'D",!?30,"DISCH. PLAN.",?50,"AVG. # ELAPSED DAYS",!
 Q
SETUP S:'$D(^TMP($J,$P(^SOWK(651,CDC,0),"^",4),0)) ^TMP($J,$P(^SOWK(651,CDC,0),"^",4),0)=0
 S $P(^TMP($J,$P(^SOWK(651,CDC,0),"^",4),0),"^")=$P(^TMP($J,$P(^SOWK(651,CDC,0),"^",4),0),"^")+1,$P(^(0),"^",2)=$P(^(0),"^",2)+ELDS
 Q
GET I $P(^SOWK(650,SOWK,0),"^",2)'<SB1,$P(^(0),"^",2)'>SE1,'$P(^(0),"^",18) D CAL Q
 I $P(^SOWK(650,SOWK,0),"^",18)'<SB1,$P(^(0),"^",18)'>SE1 D CAL
 Q
CHK ;
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1 W @IOF Q
 W @IOF D HDR1
 Q
