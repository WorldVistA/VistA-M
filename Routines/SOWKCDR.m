SOWKCDR ;B'HAM ISC/SAB,DLR  cost distribution percentage report; 16 Dec 93 / 10:25 AM
 ;;3.0; Social Work ;**17**;27 Apr 93
DEV ;
 K %ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G CLOS
 K SOWKION I $D(IO("Q")) S ZTDESC="SOCIAL WORK COST DISTRIBUTION FTEE REPORT",ZTRTN="EN^SOWKCDR" K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued to Print",! K POP,ZTSK G CLOS
EN K ^TMP($J) S (OUT,TOT,TOP)=0 F S=0:0 S S=$O(^SOWK(650.1,S)) Q:'S  F I=0:0 S I=$O(^SOWK(650.1,S,3,"B",I)) Q:'I  F H=0:0 S H=$O(^SOWK(650.1,S,3,"B",I,H)) Q:'H  D COM
 D NOW^%DTC S Y=% X ^DD("DD") S RD=Y
 W:$Y @IOF
 D HDR K I,G,H F I="" F G=0:0 S I=$O(^TMP($J,I)) Q:I=""!(OUT=1)  D:($Y+5)>IOSL FF,HDR Q:OUT=1  U IO W !,I,?50,$P(^TMP($J,I,0),"^"),?60,$J($P(^(0),"^",2),3,2),?70,$J(($P(^(0),"^",2)/TOT)*100,5,2) S TOP=TOP+($P(^(0),"^",2)/TOT)
 Q:OUT=1  W !!?50,"TOTALS",?59,$J(TOT,5,2),?69,$J(TOP*100,5,2)
CLOS W:$E(IOST)'["C" @IOF D ^%ZISC K ^TMP($J),IOP,OUT,XX,TOT,TOP,%I,S,I,X,Y,RD,H,G D:$D(ZTSK) KILL^%ZTLOAD
 Q
COM S:'$D(^TMP($J,$P(^SOWK(651,I,0),"^"),0)) ^TMP($J,$P(^SOWK(651,I,0),"^"),0)=$P(^SOWK(651,I,0),"^",4)_"^0"
 F G=0:0 S G=$O(^SOWK(650.1,S,3,H,1,G)) Q:'G  S $P(^TMP($J,$P(^SOWK(651,I,0),"^"),0),"^",2)=$P(^SOWK(650.1,S,3,H,1,G,0),"^",2)+$P(^TMP($J,$P(^SOWK(651,I,0),"^"),0),"^",2),TOT=TOT+$P(^SOWK(650.1,S,3,H,1,G,0),"^",2)
 Q
HDR Q:OUT=1
 U IO W $P(^DD("SITE"),"^")_" ("_^DD("SITE",1)_")",?35,"COST DISTRIBUTION CENTER FTEE REPORT" W:$O(^SOWK(650.1,1)) !?47,"FOR ALL DIVISIONS" W !!,"Run Date/Time: "_RD
 W !!,?50,"ACCOUNT",?60,"FTEE",!,"COST CENTER",?50,"NUMBER",?60,"TOTALS",?70,"% FTEE",!
 Q
FF I $E(IOST)["C" R !,"Press <RETURN> to continue: ",XX:DTIME I XX="^" S OUT=1
 W @IOF Q
