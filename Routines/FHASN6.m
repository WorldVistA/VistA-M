FHASN6 ; HISC/NCA - List Inpats By Nutrition Status Level ;3/1/95  10:58
 ;;5.5;DIETETICS;;Jan 28, 2005
EN2 ; Select Status to print
 K DIR S DIR(0)="SO^1:NORMAL;2:MILDLY COMPROMISED;3:MODERATELY COMPROMISED;4:SEVERELY COMPROMISED;5:UNCLASSIFIED",DIR("A")="Choose a Nutrition Status Level" D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL S STS=+Y
F0 R !!,"Print by CLINICIAN or WARD? WARD// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="W" D TR^FH I $P("CLINICIAN",X,1)'="",$P("WARD",X,1)'="" W *7,"  Answer with C or W" G F0
 S SRT=$E(X,1)
L0 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q0^FHASN6",FHLST="STS^SRT" D EN2^FH G KIL
 U IO D Q0 D ^%ZISC K %ZIS,IOP G FHASN6
Q0 ; Process Screening
 K ^TMP($J)
 S TIT="Current Inpatients At Nutrition Status: ",ANS=""
 S TIT=TIT_$P("I,II,III,IV,V",",",+STS)_" "_$S(STS<5:$P($G(^FH(115.4,+STS,0)),"^",2),1:"Unclassified")
 F W1=0:0 S W1=$O(^FH(119.6,W1)) Q:W1'>0  D W1 F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN<1  S ADM=$G(^FHPT("AW",W1,FHDFN)) Q:ADM<1  D Q1
 D P0
KIL K ^TMP($J) G KILL^XUSCLEAN
Q1 ; Tabulate status
 S DTE="",X5=$O(^FHPT(FHDFN,"S",0)) G:X5="" Q2 S X5=^(X5,0)
 I $P(X5,"^",1)<$S($D(^FHPT(FHDFN,"A",ADM,0)):$P(^(0),"^",1),1:9999999) G Q2
 S S1=$P(X5,"^",2),D1=$P(X5,"^",3),DTE=$P(X5,"^",1) I S1,S1<5 G Q3
Q2 ; Unclassified
 S S1=5,D1=WD
Q3 ; Set Classification
 S XX=$S(SRT="W":W1,1:D1)
Q4 ; Store Status
 I S1'=STS Q
 D PATNAME^FHOMUTL I DFN="" Q
 S X2=$G(^FHPT(FHDFN,"A",ADM,0)),RM=$P(X2,"^",9),RM=$P($G(^DG(405.4,+RM,0)),"^",1),X3=$G(^DPT(DFN,0)),PAT=$E($P(X3,"^",1),1,23) D PID^FHDPA
 D P1
 Q
P0 ; Print summary
 D NOW^%DTC S DTP=% D DTP^FH S NOW=DTP,PG=0,LN="",$P(LN,"-",80)="" D HDR
 I '$D(^TMP($J)) W !!,"There are No current inpatients with ",$S(STS<5:$P($G(^FH(115.4,+STS,0)),"^",2),1:"Unclassified")," nutrition status.",!! Q
 W ! S NAM="" F W1=0:0 S NAM=$O(^TMP($J,NAM)) Q:NAM=""!(ANS="^")  W NAM F W2=0:0 S W2=$O(^TMP($J,NAM,W2)) Q:W2<1!(ANS="^")  S PAT="" D P2
 W ! Q
P1 I SRT="W" S NAM=$E($P($G(^FH(119.6,+XX,0)),"^",1),1,15)
 E  S NAM=$E($P($G(^VA(200,+XX,0)),"^",1),1,26)
 Q:NAM=""  S:DTE="" DTE=$P(^FHPT(FHDFN,"A",ADM,0),"^",1) S ^TMP($J,NAM,DTE,PAT)=BID_"^"_$E(RM,1,10) Q
P2 S PAT=$O(^TMP($J,NAM,W2,PAT)) Q:PAT=""  S D1=$G(^(PAT))
 D:$Y'<(IOSL-3) HD Q:ANS="^"
 S BID=$P(D1,"^",1),RM=$P(D1,"^",2)
 W:SRT="W" ?15,RM W ?28,PAT,?53,BID,?62 S DTP=W2 D DTP^FH W DTP,!!
 G P2
W1 ; Get ward parameters
 S WD=$P($G(^FH(119.6,W1,0)),"^",2) S:'WD WD=0 Q
HD ; Check for end of page
 I IOST?1"C".E W:$X>1 ! W *7 K DIR S DIR(0)="E" D ^DIR I 'Y S ANS="^" Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,NOW,?72,"Page ",PG,!!?(80-$L(TIT)\2),TIT
 W !!,$S(SRT="W":"Ward           Room",1:"Clinician"),?28,"Patient",?53,"ID#",?62,"Date Entered",!,LN,! Q
