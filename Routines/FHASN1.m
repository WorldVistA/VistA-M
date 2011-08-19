FHASN1 ; HISC/REL - Print Status Summary ;5/14/93  10:12
 ;;5.5;DIETETICS;;Jan 28, 2005
F0 R !!,"Print by CLINICIAN or WARD? WARD// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="W" D TR^FH I $P("CLINICIAN",X,1)'="",$P("WARD",X,1)'="" W *7,"  Answer with C or W" G F0
 S SRT=$E(X,1)
L0 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q0^FHASN1",FHLST="SRT" D EN2^FH G KIL
 U IO D Q0 D ^%ZISC K %ZIS,IOP G KIL
Q0 ; Process Screening
 K S
 F W1=0:0 S W1=$O(^FH(119.6,W1)) Q:W1'>0  D W1 F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN<1  S ADM=$G(^FHPT("AW",W1,FHDFN)) Q:ADM<1  D Q1
 G P0
Q1 ; Tabulate status
 S X5=$O(^FHPT(FHDFN,"S",0)) G:X5="" Q2 S X5=^(X5,0)
 I $P(X5,"^",1)<$S($D(^FHPT(FHDFN,"A",ADM,0)):$P(^(0),"^",1),1:9999999) G Q2
 S S1=$P(X5,"^",2),D1=$P(X5,"^",3) I S1,S1<5 G Q3
Q2 ; Unclassified
 S S1=5,D1=WD
Q3 ; Set Classification
 S X=$S(SRT="W":W1,1:D1) S:'$D(S(X)) S(X)="" S $P(S(X),"^",S1)=$P(S(X),"^",S1)+1 Q
P0 ; Print summary
 D NOW^%DTC S (NOW,DTP)=% D DTP^FH S PG=0,LN="",$P(LN,"-",66)="" D HDR
 K ^TMP($J) F W1=0:0 S W1=$O(S(W1)) Q:W1=""  D P1
 S NAM="" F W1=0:0 S NAM=$O(^TMP($J,NAM)) Q:NAM=""  S D1=^(NAM) D P2
 W ! Q
P1 I SRT="W" S NAM=$P($G(^FH(119.6,W1,0)),"^",1)
 E  S NAM=$P($G(^VA(200,W1,0)),"^",1)
 Q:NAM=""  S ^TMP($J,NAM_"~"_W1)=S(W1) Q
P2 D:$Y>(IOSL-8) HDR W !?7,$P(NAM,"~",1),?37 F K=1:1:5 S X=$P(D1,"^",K) W $J(X,7)
 Q
W1 ; Get ward parameters
 S WD=$P($G(^FH(119.6,W1,0)),"^",2) S:'WD WD=0 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?16,"N U T R I T I O N   S T A T U S   S U M M A R Y",?73,"Page ",PG
 W !!?(80-$L(DTP)\2),DTP
 W !!?7,$S(SRT="C":"CLINICIAN",1:"WARD"),?43,"I     II    III     IV    UNC",!?7,LN,! Q
KIL K ^TMP($J) G KILL^XUSCLEAN
