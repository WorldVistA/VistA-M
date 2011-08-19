SOWKQAM1 ;B'HAM ISC/SAB,DLR-Routine to print quality mgmt. monitor II report ; 20 Apr 93 / 7:57 AM [ 09/26/94  1:07 PM ]
 ;;3.0; Social Work ;**34,53**;27 Apr 93
 K ^TMP($J)
BEG W ! S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y X ^DD("DD") S SBA=Y
END W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SE1=Y X ^DD("DD") S SEA=Y I SE1<SB1 W !,"Ending date must be after starting date ",! G BEG
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K SOWKION,IOP G CLOS Q
 K SOWKION I $D(IO("Q")) S ZTRTN="ENQ^SOWKQAM1",ZTDESC="QUALITY MGMT. MONITOR I REPORT - SOCIAL WORK" F G="SE1","SB1","SBA","SEA" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) G CLOS
 I $D(ZTSK) W !!,"Task Queued to Print",! K ZTSK G CLOS
ENQ S (TOT,TOP)=0
 F SOWK=0:0 S SOWK=$O(^SOWK(650,SOWK)) Q:'SOWK  D GET
 D PRI Q:$G(OUT)=1  W !,"TOTALS",?13,$J(TOT,3,0),?33,$J(TOP,3,0),?63,$S(TOT:$J((TOP/TOT)*100,3,0),1:$J("0",3,0))
CLOS W ! W:$E(IOST)'["C" @IOF D ^%ZISC K ^TMP($J),I2,SB1,CDC,CN,SBA,SEA,Y,SE1,IOP,OUT,POP,SOWK,%DT,I1,G,TOT,TOP,X D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD
 Q
 ;CALCULATE TOTALS
CAL S CN=^SOWK(650,SOWK,0),CDC=$P(CN,"^",13) F I1=0:0 S I1=$O(^SOWK(650,SOWK,5,I1)) Q:'I1  I $P(^SOWK(655.202,$P(^SOWK(650,SOWK,5,I1,0),"^"),0),"^")="DISCHARGE PLANNING" D POST
 Q
POST S:'$D(^TMP($J,CDC,"PR")) (^TMP($J,CDC,"PR"),^TMP($J,CDC,"PF"))=0 S CDC(CDC)="",^TMP($J,CDC,"PR")=^TMP($J,CDC,"PR")+1,TOT=TOT+1 D DIS
 Q
DIS F I2=0:0 S I2=$O(^SOWK(650,SOWK,5,I2)) Q:'I2  I $P(^SOWK(655.202,$P(^SOWK(650,SOWK,5,I2,0),"^"),0),"^")="FAMILY CONFERENCE" S ^TMP($J,CDC,"PF")=^TMP($J,CDC,"PF")+1,TOP=TOP+1
 Q
PRI ;print data
 U IO W:$Y @IOF D HDR1 F CDC=0:0 S CDC=$O(CDC(CDC)) Q:'CDC!($G(OUT)=1)  D:($Y+10)>IOSL CHK Q:$G(OUT)=1  D
 .W !,$P(^SOWK(651,CDC,0),"^",4),?13,$J(^TMP($J,CDC,"PR"),3,0),?33,$J(^TMP($J,CDC,"PF"),3,0),?63,$J((^TMP($J,CDC,"PF")/^TMP($J,CDC,"PR"))*100,3,0)
 Q
HDR1 W !!?45,"Department of Veterans Affairs",!?44,$P(^DD("SITE"),"^")_" ("_$P(^DD("SITE",1),"^")_")",!?40,"Social Work Information Management System",!?45,"Quality Management Monitor II"
 W !?40,"Family involvement in Discharged Planning",!,"Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?60,"Reporting Period "_SBA_" to "_SEA,!
 W !,"Location",?10,"Total Patients",?30,"Family Conference",?60,"% rec'd Family Conference"
 Q
GET I $P(^SOWK(650,SOWK,0),"^",2)'<SB1,$P(^(0),"^",2)'>SE1,'$P(^(0),"^",18) D CAL Q
 I $P(^SOWK(650,SOWK,0),"^",18)'<SB1,$P(^(0),"^",18)'>SE1 D CAL
 Q
CHK ;
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1
 W @IOF D HDR1
 Q
