SOWKQAR4 ;B'HAM ISC/SAB-Routine to print quality mgmt. review IV ; 20 Apr 93 / 8:01 AM [ 09/26/94  10:27 AM ]
 ;;3.0; Social Work ;**34,53**;27 Apr 93
BEG W ! K ^TMP($J) S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SB1=Y,PG=0
END W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 END S SE1=Y X ^DD("DD") S SEA=Y I SE1<SB1 W !,"Ending date must be after starting date ",! G BEG
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K %ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G CLOS
 K SOWKION I $D(IO("Q")) S ZTDESC="QUALITY MANAGEMENT REVIEW IV REPORT - SOCIAL WORK",ZTRTN="EN^SOWKQAR4" F G="SE1","SB1" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued to Print" K ZTSK G CLOS
EN K ^TMP($J) S %H=$H D YX^%DTC S TD=$P(Y,"@")
EN0 S PG=0 F SOWK=0:0 S SOWK=$O(^SOWK(650,SOWK)) Q:'SOWK  D GET
 S Y=SB1 X ^DD("DD") S SB1=Y,Y=SE1 X ^DD("DD") S SE1=Y,STA=$P(^DD("SITE"),"^"),STN=$P(^DD("SITE",1),"^") D SET1
CLOS W ! W:$E(IOST)'["C" @IOF D ^%ZISC K SOWKBG,SOWKED,H,POP,STA,SUP,STN,SE1,^TMP($J),G,PG,SB1,%DT,SOWKI,SOWK,CN,C,D,I,OC,OUT,PR,PAT,T,X,Y,TD,WRK,%H D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD
 Q
SETUP S WRK=$P(^VA(200,$P(CN,"^",3),654),"^",3),C=0,(PR,OC)="" F I=0:0 S C=C+1,I=$O(^SOWK(650,SOWK,2,I)) Q:'I!(C>8)  I $P(^SOWK(650,SOWK,2,I,0),"^",2)'<6,$P(^(0),"^",2)'>8 D SETUP1
 Q
SETUP1 S PR=PR_$P(^SOWK(650,SOWK,2,I,0),"^")_" ",OC=OC_$P(^(0),"^",2)_" "
 S:'$D(^TMP($J,WRK)) ^TMP($J,WRK)=0
 S DFN=$P(CN,U,8) D PID^VADPT6
 S ^TMP($J,WRK,$P(^DPT($P(CN,"^",8),0),"^"),+CN)=$P(^DPT($P(CN,"^",8),0),"^")_"^"_VA("BID")_"^"_$P(^SOWK(651,$P(CN,"^",13),0),"^",4)_"^"_PR_"^"_OC
 Q
PRI U IO D:($Y+15)>IOSL CHK
 I $G(OUT)'=1 W !,PAT,?32,$P(D,"^",2),?43,$P(D,"^",3),?62,$P(D,"^",4),?89,$P(D,"^",5),?107,$P(D,"^",6)
 Q
HDR S PG=PG+1 U IO W !!?45,"Department of Veterans Affairs",!?45,STA_" ("_STN_")",!?40,"Social Work Information Management System",!?45,"Quality Management Review IV"
 W !?39,"Level of problem resolution by problem code",!?52,"Unresolved problems",!!,"Date: "_TD,?45,"Reporting Period: "_SB1_" to "_SE1,!,"Worker's #: "_WRK,!
 W !,"NAME",?32,"ID#",?43,"CDC LOCATION",?62,"PROBLEMS",?87,"OUTCOMES"
 Q
SET1 S (WRK,PAT)="" W:$Y @IOF
 F I=0:0 S WRK=$O(^TMP($J,WRK)) Q:WRK=""!($G(OUT)=1)  D SET2 I $G(OUT)'=1 W !!,"Total Patients: "_^TMP($J,WRK)
 Q
SET2 D HDR F G=0:0 S PAT=$O(^TMP($J,WRK,PAT)) Q:PAT=""!($G(OUT)=1)  F T=0:0 S T=$O(^TMP($J,WRK,PAT,T)) Q:'T!($G(OUT)=1)  S D=^TMP($J,WRK,PAT,T),^TMP($J,WRK)=^TMP($J,WRK)+1 D PRI
 Q
GET I $P(^SOWK(650,SOWK,0),"^",2)'<SB1,$P(^(0),"^",2)'>SE1,'$P(^(0),"^",18) S CN=^SOWK(650,SOWK,0) D SETUP Q
 I $P(^SOWK(650,SOWK,0),"^",18)'<SB1,$P(^(0),"^",18)'>SE1 S CN=^SOWK(650,SOWK,0) D SETUP
 Q
CHK ;
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1 W @IOF Q
 W @IOF D HDR
 Q
