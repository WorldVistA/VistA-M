SOWKQAM4 ;B'HAM ISC/SAB,DLR-Routine to print quality mgmt. monitor IV report ; 20 Apr 93 / 7:58 AM [ 09/26/94  8:30 AM ]
 ;;3.0; Social Work ;**34,53**;27 Apr 93
 K ^TMP($J)
BEG W ! S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y X ^DD("DD") S SBA=Y
END W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SE1=Y X ^DD("DD") S SEA=Y I SE1<SB1 W !,"Ending date must be after starting date ",! G BEG
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K SOWKION,IOP G CLOS Q
 K SOWKION I $D(IO("Q")) S ZTRTN="ENQ^SOWKQAM4",ZTDESC="QUALITY MGMT. MONITOR IV REPORT - SOCIAL WORK" F G="SE1","SB1","SBA","SEA" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) G CLOS
 I $D(ZTSK) W !!,"Task Queued to Print",! K ZTSK G CLOS
ENQ K ^TMP($J) F SOWK=0:0 S SOWK=$O(^SOWK(650,SOWK)) Q:'SOWK  D GET
 D PRI
CLOS W ! W:$E(IOST)'["C" @IOF D ^%ZISC K ^TMP($J),TOT,CN,PTO,OC,OUT,PG,D,D1,D2,D,T,WRK,SOWKI,SB1,CN,SBA,SEA,Y,SE1,IOP,POP,SOWK,%DT,G,I,X D:$D(ZTSK) KILL^%ZTLOAD
 Q
CAL ;CALCULATE TOTALS
 S CN=^SOWK(650,SOWK,0),WRK=$P(^VA(200,$P(CN,"^",3),654),"^",3) S:'$D(^TMP($J,WRK)) ^TMP($J,WRK)=0
 F SOWKI=0:0 S SOWKI=$O(^SOWK(650,SOWK,2,SOWKI)) Q:'SOWKI  S:'$D(^TMP($J,WRK,$P(^SOWK(650,SOWK,2,SOWKI,0),"^")))&($P(^SOWK(650,SOWK,2,SOWKI,0),"^",2)) ^TMP($J,WRK,$P(^SOWK(650,SOWK,2,SOWKI,0),"^"))=0
 F SOWKI=0:0 S SOWKI=$O(^SOWK(650,SOWK,2,SOWKI)) Q:'SOWKI  D:$P(^SOWK(650,SOWK,2,SOWKI,0),"^",2) CAL1
 S WRK="" F I=0:0 S WRK=$O(^TMP($J,WRK)) Q:WRK=""  F T=0:0 S T=$O(^TMP($J,WRK,T)) Q:'T  S:'$D(^TMP($J,WRK,"%",T)) ^(T)=0 F OC=1:1:8 S $P(^TMP($J,WRK,"%",T),"^",OC)=(+$P(^TMP($J,WRK,T),"^",OC)/^TMP($J,WRK,"TOT",T))*100
 Q
PRI ;print data
 S WRK="" F I=0:0 S WRK=$O(^TMP($J,WRK)) Q:WRK=""!($G(OUT)=1)  S TOT=^(WRK) I TOT D HDR1 D:$G(OUT)'=1 PR1
 Q
PR1 F G=0:0 S G=$O(^TMP($J,WRK,G)) Q:'G!($G(OUT)=1)  S D=^TMP($J,WRK,G),D1=^TMP($J,WRK,"%",G),D2=^TMP($J,WRK,"TOT",G) D PR2
 Q:$G(OUT)=1  W !!,"TOTALS: ",?12,$J(TOT,3,0),?20,$J(TOT(1),3,0),?27,$J(PTO(1),3,2),?34,$J(TOT(2),3,0),?41,$J(PTO(2),3,2),?48,$J(TOT(3),3,0),?55,$J(PTO(3),3,2),?62,$J(TOT(4),3,0),?69,$J(PTO(4),3,2)
 W ?76,$J(TOT(5),3,0),?83,$J(PTO(5),3,2),?90,$J(TOT(6),3,0),?96,$J(PTO(6),3,2),?102,$J(TOT(7),3,0),?108,$J(PTO(7),3,2),?115,$J(TOT(8),3,0),?122,$J(PTO(8),3,2)
 K TOT,PTO Q
HDR1 D CHK U IO W !!?45,"Department of Veterans Affairs",!?44,$P(^DD("SITE"),"^")_" ("_$P(^DD("SITE",1),"^")_")",!?40,"Social Work Information Management System",!?45,"Quality Management Monitor IV"
 W !?39,"Level of problem resolution by problem code",!,"Date: "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),?80,"Reporting Period "_SBA_" to "_SEA,!
 W !?8,"Worker's #: "_WRK,!!,"Problem",?11,"# Times",?60,"Resolutions",!?11,"Occurred",?25,1,?40,2,?54,3,?68,4,?82,5,?95,6,?107,7,?121,8
 W !?22,"#",?30,"%",?36,"#",?44,"%",?50,"#",?58,"%",?64,"#",?72,"%",?78,"#",?86,"%",?92,"#",?99,"%",?104,"#",?111,"%",?117,"#",?125,"%"
 Q
PR2 D CHK Q:$G(OUT)=1  W !,$J(G,3,0),?12,$J(D2,3,0),?20,$J($P(D,"^"),3,0),?27,$J($P(D1,"^"),3,2),?34,$J($P(D,"^",2),3,0),?41,$J($P(D1,"^",2),3,2),?48,$J($P(D,"^",3),3,0),?55,$J($P(D1,"^",3),3,2),?62,$J($P(D,"^",4),3,0),?69,$J($P(D1,"^",4),3,2)
 W ?76,$J($P(D,"^",5),3,0),?83,$J($P(D1,"^",5),3,2),?90,$J($P(D,"^",6),3,0),?96,$J($P(D1,"^",6),3,2),?102,$J($P(D,"^",7),3,0),?108,$J($P(D1,"^",7),3,2),?115,$J($P(D,"^",8),3,0),?122,$J($P(D1,"^",8),3,2)
 F OC=1:1:8 S:'$D(TOT(OC)) TOT(OC)=0 S TOT(OC)=TOT(OC)+$J($P(D,"^",OC),3,2)
 F OC=1:1:8 S:'$D(PTO(OC)) PTO(OC)=0 S PTO(OC)=(TOT(OC)/TOT)*100
 Q
CAL1 S $P(^TMP($J,WRK,$P(^SOWK(650,SOWK,2,SOWKI,0),"^")),"^",+$P(^(0),"^",2))=+$P(^TMP($J,WRK,$P(^SOWK(650,SOWK,2,SOWKI,0),"^")),"^",$P(^SOWK(650,SOWK,2,SOWKI,0),"^",2))+1
 S:'$D(^TMP($J,WRK,"TOT",$P(^SOWK(650,SOWK,2,SOWKI,0),"^"))) ^TMP($J,WRK,"TOT",$P(^SOWK(650,SOWK,2,SOWKI,0),"^"))=0
 S ^TMP($J,WRK,"TOT",$P(^SOWK(650,SOWK,2,SOWKI,0),"^"))=^TMP($J,WRK,"TOT",$P(^(0),"^"))+1,^TMP($J,WRK)=^TMP($J,WRK)+1
 Q
GET I $P(^SOWK(650,SOWK,0),"^",2)'<SB1,$P(^(0),"^",2)'>SE1,'$P(^(0),"^",18) D CAL Q
 I $P(^SOWK(650,SOWK,0),"^",18)'<SB1,$P(^(0),"^",18)'>SE1 D CAL
 Q
CHK ;
 S PG=$G(PG)+1 I PG=1 W:$Y @IOF Q
 Q:($Y+5)'>IOSL
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1
 W @IOF
 Q
