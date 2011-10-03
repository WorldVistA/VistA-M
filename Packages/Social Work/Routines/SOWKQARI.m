SOWKQARI ;B'HAM ISC/SAB-Routine to print quality mgmt. review II report ; 20 Apr 93 / 8:01 AM [ 09/26/94  1:12 PM ]
 ;;3.0; Social Work ;**34,53**;27 Apr 93
 K ^TMP($J)
BEG W ! S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y X ^DD("DD") S SBA=Y
END W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SE1=Y X ^DD("DD") S SEA=Y I SE1<SB1 W !,"Ending date must be after starting date ",! G BEG
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K SOWKION,IOP G CLOS Q
 K SOWKION I $D(IO("Q")) S ZTRTN="ENQ^SOWKQARI",ZTDESC="QUALITY MGMT. REVIEW II REPORT - SOCIAL WORK" F G="SE1","SB1","SBA","SEA" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) G CLOS
 I $D(ZTSK) W !!,"Task Queued to Print",! K ZTSK G CLOS
ENQ F SOWKWRK=0:0 S SOWKWRK=$O(^SOWK(650,"W",SOWKWRK)) Q:'SOWKWRK  F SOWK=0:0 S SOWK=$O(^SOWK(650,"W",SOWKWRK,SOWK)) Q:'SOWK  D GET
 W:$Y @IOF D HDR1 D:$G(OUT)'=1 PRI
CLOS W ! W:$E(IOST)'["C" @IOF D ^%ZISC K WRK,^TMP($J),CD,TOT,D,DFN,OD,OUT,PAT,PF,SOWKWRK,T,SOWKI2,SB1,CDC,CN,SBA,SEA,Y,SE1,IOP,POP,SOWK,%DT,SOWKI1,G,I,X D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD
 Q
CAL ;CALCULATE TOTALS
 S CN=^SOWK(650,SOWK,0),CDC=$P(CN,"^",13)
 F SOWKI1=0:0 S SOWKI1=$O(^SOWK(650,SOWK,5,SOWKI1)) Q:'SOWKI1  I $P(^SOWK(655.202,$P(^SOWK(650,SOWK,5,SOWKI1,0),"^"),0),"^")="DISCHARGE PLANNING" D POST
 Q
POST S PF=0 F SOWKI2=0:0 S SOWKI2=$O(^SOWK(650,SOWK,5,SOWKI2)) Q:'SOWKI2  I $P(^SOWK(655.202,$P(^SOWK(650,SOWK,5,SOWKI2,0),"^"),0),"^")="FAMILY CONFERENCE" S PF=1
 I 'PF S:'$D(WRK(SOWKWRK)) WRK(SOWKWRK)=0 S WRK(SOWKWRK)=WRK(SOWKWRK)+1 D SETUP
 Q
PRI ;print data
 S (WRK,PAT)=""
 F I=0:0 S WRK=$O(^TMP($J,WRK)) Q:WRK=""!($G(OUT)=1)  D PRI1 I $G(OUT)'=1 W !!,"Total Patients: "_TOT K TOT
 Q
PRI1 D CHK I $G(OUT)'=1 U IO W !?8,"SOCIAL WORKER: "_WRK,!?11,"SUPERVISOR: "_^TMP($J,WRK) F G=0:0 S PAT=$O(^TMP($J,WRK,PAT)) Q:PAT=""!($G(OUT)=1)  F T=0:0 S T=$O(^TMP($J,WRK,PAT,T)) Q:'T!($G(OUT)=1)  D
 .S D=^TMP($J,WRK,PAT,T) S:'$D(TOT) TOT=0 S TOT=TOT+1 D CHK I $G(OUT)'=1 W !,$P(D,"^"),?40,$P(D,"^",2),?50,$P(D,"^",3),?60,$P(D,"^",4),?77,$P(D,"^",5)
 Q
HDR1 U IO W !!?45,"Department of Veterans Affairs",!?44,$P(^DD("SITE"),"^")_" ("_$P(^DD("SITE",1),"^")_")",!?40,"Social Work Information Management System",!?45,"Quality Management Review II"
 W !?35,"Family involvement in Discharged Planning",!,"Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?60,"Reporting Period "_SBA_" to "_SEA,!
 W !,"Name",?40,"ID#",?50,"Location",?60,"Date Opened",?77,"Date Closed"
 Q
SETUP S DFN=$P(CN,"^",8) D DEM^VADPT,PID^VADPT6 S OD=$E($P(CN,"^",2),4,5)_"/"_$E($P(CN,"^",2),6,7)_"/"_$E($P(CN,"^",2),2,3),CD=$S($P(CN,"^",18):$E($P(CN,"^",18),4,5)_"/"_$E($P(CN,"^",18),6,7)_"/"_$E($P(CN,"^",18),2,3),1:"")
 S:'$D(^TMP($J,$P(^VA(200,$P(CN,"^",3),0),"^"))) ^TMP($J,$P(^VA(200,$P(CN,"^",3),0),"^"))=$P(^VA(200,$P(^VA(200,$P(CN,"^",3),654),"^",2),0),"^")
 S ^TMP($J,$P(^VA(200,$P(CN,"^",3),0),"^"),VADM(1),+CN)=VADM(1)_"^"_VA("BID")_"^"_$P(^SOWK(651,$P(CN,"^",13),0),"^",4)_"^"_OD_"^"_CD
 Q
GET I $P(^SOWK(650,SOWK,0),"^",2)'<SB1,$P(^(0),"^",2)'>SE1,'$P(^(0),"^",18) D CAL Q
 I $P(^SOWK(650,SOWK,0),"^",18)'<SB1,$P(^(0),"^",18)'>SE1 D CAL
 Q
CHK ;
 Q:($Y+5)'>IOSL
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1 W @IOF Q
 W @IOF D HDR1
 Q
