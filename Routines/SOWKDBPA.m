SOWKDBPA ;B'HAM ISC/SAB-Routine to print Clinical Supervisory Report for workers ; 19 Jan 94 / 12:57 PM [ 09/26/94  1:02 PM ]
 ;;3.0; Social Work ;**17,34**;27 Apr 93
 K ^TMP($J)
LK I 'CCM S DIC("S")="I $D(^VA(200,""ASWC"",DUZ,+Y))&($D(^SOWK(655.2,""C"",+Y)))!$D(^VA(200,""ACSW"",DUZ,+Y))&($D(^SOWK(655.2,""C"",+Y)))",DIC="^VA(200,",DIC("A")="SELECT WORKER: ",DIC(0)="AEQMZ" D ^DIC G:"^"[$E(X) CLO G:Y<1 LK S DA=+Y K DIC,Y
 S:'$D(DA) DA=""
DEV W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K %ZIS,IOP,ZTSK S %ZIS="QM",SOWKION=ION,%ZIS("B")="" D ^%ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G CLO
 I $D(IO("Q")) K IO("Q") S ZTDESC="CLINICAL SUPERVISOR'S REPORT",ZTRTN="EN^SOWKDBPA" F G="CCM","DUZ","DA" S:$D(@G) ZTSAVE(G)=""
 I  D ^%ZTLOAD K G,DA,ZTSAVE,ZTRTN,DIC,IOP,POP G:'$D(ZTSK) CLO
 I $D(ZTSK) K ZTRTN,G,DA,ZTSAVE,DIC,ZTRTN,POP,ZTSK W !!,"Task Queued to Print !",! G CLO
EN S PG=0,S=1 F II=0:0 S II=$O(^SOWK(655.2,II)) Q:'II  F SDI=0:0 S SDI=$O(^SOWK(655.2,II,23,SDI)) Q:'SDI  D GN
 D PRI
CLO W:$E(IOST)'["C" @IOF D ^%ZISC,KVAR^VADPT K SDI,RT,PG,CCM,J1,WRD,DIC,DA,Y,II,J,K,OUT,P,PA,S,X,ZTRTN,ZTSAVE,^TMP($J),AMD,CN,COM,D,DCH,DFN,DIS,G,OD,CD,AML,WRK,ENT,SWWRK,SOWKION D:$D(ZTSK) KILL^%ZTLOAD
 Q
AD S DFN=II,Y=$P(P,"^",4) X ^DD("DD") S DIS=Y
 D INP^VADPT,PID^VADPT6 S AMD=+VAIN(7),WRD=$P(VAIN(4),"^",2),G=$S(AMD:9999999.9999999-AMD,1:0),G=+$O(^DGPM("ATID3",DFN,G)),PA=+$O(^DGPM("ATID3",DFN,G,0))
 S Y=$P(P,"^",6) X ^DD("DD") S CN=Y
 S DCH=$S(PA&'AMD:$P(^DGPM(PA,0),"^"),1:"INPATIENT"),AMD=$S(AMD:$P(VAIN(7),"^",2),1:"DISCHARGED") S:AMD]"" AMD=$P(AMD,"@") I 'AMD,DCH S Y=$P(DCH,".") X ^DD("DD") S DCH=Y
 S SWWRK=$S($D(^VA(200,+$P(P,"^"),0)):$P(^VA(200,+$P(P,"^"),0),"^"),1:"UNKNOWN")
 S Y=$S($P(P,"^",2)&($D(^SOWK(650,+$P(P,"^",2),0))):$P(^SOWK(650,+$P(P,"^",2),0),"^",2),1:"") X ^DD("DD") S OD=Y,Y=$S($P(P,"^",2)&($D(^SOWK(650,+$P(P,"^",2),0))):$P(^SOWK(650,+$P(P,"^",2),0),"^",18),1:"") X ^DD("DD") S CD=Y
 I $P(P,"^",2),$D(^SOWK(650,+$P(P,"^",2),0)) S AML=+$P(^SOWK(650,+$P(P,"^",2),0),"^",13),AML=$P(^SOWK(651,AML,0),"^",4)
 E  S AML="N/A"
SET S ^TMP($J,DUZ,SWWRK,$P(^DPT(DFN,0),"^"),+P)=SWWRK_"^"_$P(^DPT(DFN,0),"^")_"^"_WRD_"^"_VA("BID")_"^"_AML_"^"_AMD_"^"_OD_"^"_DCH_"^"_CD_"^"_DIS_"^"_CN
 K SWWRK,DFN,WRD,AML,AMD,OD,COM,DCH,CD,DIS,CN,G,PA
 Q
PRI S (ENT,WRK,J1)="" F J=0:0 S J1=$O(^TMP($J,DUZ,J1)) Q:J1=""!($G(OUT)=1)  F K=0:0 S ENT=$O(^TMP($J,DUZ,J1,ENT)) Q:ENT=""!($G(OUT)=1)  F P=0:0 S P=$O(^TMP($J,DUZ,J1,ENT,P)) Q:'P!($G(OUT)=1)  D
 .S D=^TMP($J,DUZ,J1,ENT,P) D OUT I $G(OUT)'=1 S WRK=$P(D,"^")
 Q
OUT U IO D NOW^%DTC S Y=% X ^DD("DD") S RT=Y K %,Y
 I S!($Y+6>IOSL) D CHK Q:$G(OUT)=1  S PG=PG+1 W @IOF,"Run Date/Time: "_RT,?65,"INPATIENT",?83,"CASE",?98,"INPATIENT",?126,"PG. "_PG,!,"CLINICAL SUPERVISORY REPORT",?65,"ADMIT DATE",?80,"OPEN DATE",?98,"DISCHARGE DATE"
 I  W !?65 F G=1:1:67 W "-"
 I  W !?53,"CDC",?68,"CASE",?83,"DISCHARGE",?98,"CLOSING",!,"PATIENT NAME",?35,"WARD",?45,"ID#",?53,"ACCOUNT",?65,"CLOSE DATE",?80,"PLANNING DATE",?98,"NOTE DATE",! F G=1:1:132 W "-"
 I S,$G(CCM) W !,"SUPERVISOR: ",$P(^VA(200,DUZ,0),"^")
 W:WRK'=$P(D,"^") !?5,"SOCIAL WORKER: ",$P(D,"^"),! S S=0
 W !,$P(D,"^",2),?35,$P(D,"^",3),?45,$P(D,"^",4),?53,$P(D,"^",5),?65,$P(D,"^",6),?83,$P(D,"^",7),?98,$P(D,"^",8)
 W !?65,$P(D,"^",9),?83,$P(D,"^",10),?98,$P(D,"^",11),!?65 F G=1:1:67 W "-"
 W !
 Q
GN S P=^SOWK(655.2,II,23,SDI,0) D:CCM&($P(^SOWK(655.2,II,0),"^",13)=DUZ)!('CCM&($D(DA))&($P(P,"^")=DA))!($D(^SOWK(655.2,"AC",DUZ,II))) AD
 Q
CHK ;
 Q:PG=0
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1 W @IOF Q
 Q
