SOWKPAO ;B'HAM ISC/SAB,DLR-Routine to print Problems & Outcome report ; 25 Feb 93 / 9:19 AM [ 09/26/94  3:23 PM ]
 ;;3.0; Social Work ;**34,53**;27 Apr 93
 S:'$D(SOWKAB) SOWKFD=""
BEG W ! S %DT="AEXP",%DT("A")="ALL CASES STARTING FROM: " D ^%DT G:"^"[X CLOS G:Y'>0 BEG S SOWKFD=Y
EN W ! S %DT("A")="ALL CASES ENDING: " D ^%DT G:"^"[X CLOS G:Y'>0 EN S SOWKFB=Y
OC F L=0:0 W !,"Do you want Complete Service " S %=2 D YN^DICN Q:%  I %Y["?" D YN^SOWKHELP
 I %=1 S SWA=1,SWB=0 G DEV
 G:%=-1 CLOS F L=0:0 W !,"Do you want report by Supervisor " S %=2 D YN^DICN Q:%  I %Y["?" D YN^SOWKHELP
 I %=1 S SWB=1,SWA=0
 G:%=2 SWW G:%=-1 CLOS S DIC="^VA(200,",DIC(0)="AEQ",DIC("A")="Enter Supervisor's last name: ",D="B",DIC("S")="I $D(^VA(200,""ASWC"",+Y))"
 D IX^DIC G:"^"[X CLOS S SWZ=+Y K DIC G:Y'>0 CLOS G DEV
SWW S DIC("S")="I $D(^VA(200,+Y,654)),$P(^VA(200,+Y,654),""^"")",DIC="^VA(200,",DIC(0)="AEQ",DIC("A")="Enter Social Worker's last name: "
 D ^DIC G:"^"[X CLOS S SWZ=+Y K DIC G:Y'>0 CLOS S (SWB,SWA)=0
DEV D EN1 I $D(ZTSK)!($D(OUT))!(POP) K ZTSK G CLOS
ENQ D CLE S SWD=SOWKFD-1 F I=0:0 S SWD=$O(^SOWK(650,"ACD",SWD)) Q:SWD>SOWKFB!'SWD  F F=0:0 S F=$O(^SOWK(650,"ACD",SWD,F)) Q:'F  S E=^SOWK(650,F,0),W=$P(E,"^",3) D
 .I $S(SWB:$P(^VA(200,W,654),"^",2)=SWZ,('SWA&'SWB):$P(E,"^",3)=SWZ,1:1) D CAT
 D CAL G CLOS
CAT F P=0:0 S P=$O(^SOWK(650,F,2,P)) Q:'P  S C=$P(^(P,0),"^"),T=$P(^(0),"^",2) F Q=0:0 S Q=$O(^SOWK(655.201,Q)) Q:'Q  F K=0:0 S K=$O(^SOWK(655.203,K)) Q:'K  I Q=C,K=T S SW(Q,K)=SW(Q,K)+1
 Q
CLE S (TOT,VT,HT,TOTB)=0 S X=1
 F I=0:0 S I=$O(^SOWK(655.203,I)) Q:'I  S (TO(I),IM(I))=0 F P=0:0 S P=$O(^SOWK(655.201,P)) Q:'P  S:$P(^SOWK(655.201,P,0),"^",2) (SW(P,I),PT(P),VT(P))=0
 Q
CLOS I $G(SOWKAB)'="ALL" W:$E(IOST)'["C" @IOF D ^%ZISC K SWA,SWB,SOWKFD,SOWKFB,SOWKAB,SWZ,X
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT1=1
 K %,%Y,D,L,Y,OUT,OUT1,W,SWD,F,%DT,HT,K,Q,TOT,TOTB,VT,C,T,TO,IM,SW,SWXX,PT,VT,I,P,E,DIC,IOP,POP D:$D(ZTSK) KILL^%ZTLOAD
 Q
EN1 W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K ZTSK,OUT,%ZIS,IOP S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K SOWKION,IOP S POP=1 Q
 K SOWKION I $D(IO("Q")) S ZTRTN="ENQ^SOWKPAO" F G="SOWKAB","X","SOWKFD","SWZ","SOWKFB","SWB","SWA" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD K %DT,G I '$D(ZTSK) S OUT=1 Q
 I $D(ZTSK) K %DT,G W !!,"Task Queued to Print",!
 Q
CAL ;CALCULATE/PRINT
 F I=0:0 S I=$O(^SOWK(655.203,I)) Q:'I  F P=0:0 S P=$O(^SOWK(655.201,P)) Q:'P  S:$D(SW(P,I)) TO(I)=SW(P,I)+TO(I)
 F P=0:0 S P=$O(^SOWK(655.201,P)) Q:'P  F I=0:0 S I=$O(^SOWK(655.203,I)) Q:'I  S:$D(SW(P,I)) VT(P)=SW(P,I)+VT(P)
 F I=0:0 S I=$O(^SOWK(655.203,I)) Q:'I  S VT=TO(I)+VT
 F I=0:0 S I=$O(^SOWK(655.201,I)) Q:'I  I $D(VT(I)),$D(PT(I)) S:VT PT(I)=(VT(I)/VT)*100,HT=PT(I)+HT
 F I=0:0 S I=$O(^SOWK(655.203,I)) Q:'I  S:VT IM(I)=(TO(I)/VT)*100,TOT=IM(I)+TOT
 S:TOT TOTB=(TOT/TOT)*100
 U IO W:$Y @IOF W $S(SWA:"COMPLETE SERVICE",SWB:"SUPERVISOR "_$P(^VA(200,SWZ,0),"^"),1:"SOCIAL WORKER "_$P(^VA(200,SWZ,0),"^")),!
 W !,$E(SOWKFD,4,5)_"/"_$E(SOWKFD,6,7)_"/"_$E(SOWKFD,2,3)_" TO "_$E(SOWKFB,4,5)_"/"_$E(SOWKFB,6,7)_"/"_$E(SOWKFB,2,3)
 W ?45,"Problems and Outcomes Report",!!
 W ?8,"CLINICAL",?22,"PLANNED",?32,"PARTIALLY",?45,"PARTIALLY",?58,"PARTIALLY"
 W !?8,"DECISION",?22,"RESULTS",?32,"ATTAINED",?45,"ATTAINED",?58,"ATTAINED",?72,"NOT ATTAINED",?87,"NOT ATTAINED",?102,"NOT ATTAINED"
 W !,"PROB.",?8,"NOT TO TREAT",?22,"ATTAINED",?32,"P/F BARR.",?45,"CR BARR.",?58,"VAMC BARR.",?72,"P/F BARR.",?87,"CR BARR.",?102,"VAMC BARR.",?120,"TOTALS",?130,"%"
 F I=0:0 S I=$O(^SOWK(655.201,I)) Q:'I!($G(OUT1)=1)  D PRI
 Q:$G(OUT1)=1
 W !,"TOTALS",?10,$J(TO(1),3,0),?22,$J(TO(2),3,0),?32,$J(TO(3),3,0),?45,$J(TO(4),3,0),?58,$J(TO(5),3,0),?72,$J(TO(6),3,0),?87,$J(TO(7),3,0),?102,$J(TO(8),3,0),?120,$J(VT,3,0),?128,$J(HT,3,0)
 W !,"PERCENT",?10,$J(IM(1),3,0),?22,$J(IM(2),3,0),?32,$J(IM(3),3,0),?45,$J(IM(4),3,0),?58,$J(IM(5),3,0),?72,$J(IM(6),3,0),?87,$J(IM(7),3,0),?102,$J(IM(8),3,0),?120,$J(TOT,3,0),?128,$J(TOTB,3,0)
 W !!?10,"NOTE:  P/F=PATIENT/FAMILY, CR=COMMUNITY RESOURCES, BARR.=BARRIERS"
 Q
PRI D:$E(IOST)["C"&($O(^SOWK(655.201,0))'=I) CHK Q:$G(OUT1)=1  I $D(SW(I,1)) W !,$J($P(^SOWK(655.201,I,0),"^",2),2,0)
 W ?10,$J(SW(I,1),3,0),?22,$J(SW(I,2),3,0),?32,$J(SW(I,3),3,0),?45,$J(SW(I,4),3,0),?58,$J(SW(I,5),3,0),?72,$J(SW(I,6),3,0),?87,$J(SW(I,7),3,0),?102,$J(SW(I,8),3,0),?120,$J(VT(I),3,0),?128,$J(PT(I),3,0)
 Q
CHK ;
 Q:($Y+5)'>IOSL
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT1=1
 W @IOF
 Q
