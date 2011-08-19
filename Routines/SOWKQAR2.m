SOWKQAR2 ;B'HAM ISC/SAB-Routine to print quality mgmt. review III report ; 08 Dec 93 / 9:25 AM [ 09/26/94  10:10 AM ]
 ;;3.0; Social Work ;**17,34,53**;27 Apr 93
 K ^TMP($J)
BEG W ! S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y X ^DD("DD") S SBA=Y
END W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SE1=Y X ^DD("DD") S SEA=Y I SE1<SB1 W !,"Ending date must be after starting date ",! G BEG
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K SOWKION,IOP G CLOS Q
 K SOWKION I $D(IO("Q")) S ZTRTN="ENQ^SOWKQAR2",ZTDESC="QUALITY MGMT. REVIEW III REPORT - SOCIAL WORK" F G="SE1","SB1","SBA","SEA" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) G CLOS
 I $D(ZTSK) W !!,"Task Queued to Print",! K ZTSK G CLOS
ENQ K ^TMP($J) S ELD=$P(^SOWK(650.1,1,0),"^",21) F SOWK=0:0 S SOWK=$O(^SOWK(650,SOWK)) Q:'SOWK  D GET
 W:$Y @IOF D HDR1 D:$G(OUT)'=1 PRI
CLOS W ! W:$E(IOST)'["C" @IOF D ^%ZISC K X1,X2,^TMP($J),ADM,D,DFN,ELD,ELDS,OD,OUT,PAT,T,LOC,ALD,SB1,CDC,CN,SBA,SEA,Y,SE1,IOP,POP,SOWK,%DT,SOWKI1,G,I,X D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD
 Q
CAL ;CALCULATE TOTALS
 S CN=^SOWK(650,SOWK,0),CDC=$P(CN,"^",13)
 F SOWKI1=0:0 S SOWKI1=$O(^SOWK(650,SOWK,5,SOWKI1)) Q:'SOWKI1  I $P(^SOWK(655.202,$P(^SOWK(650,SOWK,5,SOWKI1,0),"^"),0),"^")="DISCHARGE PLANNING" D POST
 Q
POST S DFN=$P(CN,"^",8),G=$O(^DGPM("ATID1",DFN,0)) Q:'G  S ADM=$O(^DGPM("ATID1",DFN,G,0)),ADM=$P(^DGPM(ADM,0),"^")
 S X1=$P(CN,"^",2),X2=$E(ADM,1,7) D ^%DTC I X'<ELD S ELDS=X D SETUP
 Q
PRI ;print data
 S (LOC,PAT)=""
 F I=0:0 S LOC=$O(^TMP($J,LOC)) Q:LOC=""!($G(OUT)=1)  D PRI1 I $G(OUT)'=1 W !!,"Total Patients: "_^TMP($J,LOC),?77,"Avg. # Elapsed Days: "_$J(ALD/^TMP($J,LOC),3,0) K ALD
 Q
PRI1 D CHK I $G(OUT)'=1 F G=0:0 S PAT=$O(^TMP($J,LOC,PAT)) Q:PAT=""!($G(OUT)=1)  D HDR F T=0:0 S T=$O(^TMP($J,LOC,PAT,T)) Q:'T!($G(OUT)=1)  S D=^TMP($J,LOC,PAT,T),^TMP($J,LOC)=^TMP($J,LOC)+1 S:'$D(ALD) ALD=0 S ALD=ALD+$P(D,"^",6) D
 .D CHK I $G(OUT)'=1 W !,$P(D,"^",2),?38,$J($P(D,"^"),3,0),?50,$P(D,"^",3),?60,$P(D,"^",4),?77,$P(D,"^",5),?90,$J($P(D,"^",6),4,0)
 Q
HDR1 U IO W !!?45,"Department of Veterans Affairs",!?44,$P(^DD("SITE"),"^")_" ("_$P(^DD("SITE",1),"^")_")",!?40,"Social Work Information Management System",!?45,"Quality Management Review III"
 W !?30,"Timeliness of service to patients receiving discharge planning",!,"Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?60,"Reporting Period "_SBA_" to "_SEA,!
 Q
HDR W !!?8,"Location: "_LOC,!,"Name",?38,"Worker's #",?50,"ID#",?60,"Adm. Date",?77,"Date Opened",?90,"Elapsed Days"
 Q
SETUP S DFN=$P(CN,"^",8) D DEM^VADPT,PID^VADPT6 S OD=$E($P(CN,"^",2),4,5)_"/"_$E($P(CN,"^",2),6,7)_"/"_$E($P(CN,"^",2),2,3),ADM=$E(ADM,4,5)_"/"_$E(ADM,6,7)_"/"_$E(ADM,2,3)
 S:'$D(^TMP($J,$P(^SOWK(651,$P(CN,"^",13),0),"^",4))) ^TMP($J,$P(^SOWK(651,$P(CN,"^",13),0),"^",4))=0
 S ^TMP($J,$P(^SOWK(651,$P(CN,"^",13),0),"^",4),VADM(1),+CN)=$P(^VA(200,$P(CN,"^",3),654),"^",3)_"^"_VADM(1)_"^"_VA("BID")_"^"_ADM_"^"_OD_"^"_ELDS
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
