FHSEL4 ; HISC/REL/NCA - Tabulate Food Preferences ;4/27/93  13:09 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHP=$O(^FH(119.73,0)) I FHP'<1,$O(^FH(119.73,FHP))<1 S FHP=0 G R1
D0 R !!,"Select COMMUNICATION OFFICE (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHP=0
 E  K DIC S DIC="^FH(119.73,",DIC(0)="EMQ" D ^DIC G:Y<1 D0 S FHP=+Y
R1 R !!,"Select MEAL (B,N,E or ALL): ",MEAL:DTIME G:'$T!("^"[MEAL) KIL S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="A"
 I "BNEA"'[MEAL!(MEAL'?1U) W *7,!,"Select B for Breakfast, N for Noon, E for Evening or ALL for all meals" G R1
D1 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHSEL4",FHLST="FHP^MEAL" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 D NOW^%DTC S NOW=%,PG=0 K ^TMP($J)
 F WRD=0:0 S WRD=$O(^FH(119.6,WRD)) Q:WRD<1  S X=^(WRD,0),D2=+$P(X,"^",8) I D2,'FHP!(FHP=D2) S ^TMP($J,"W",D2,WRD)=""
 F D2=0:0 S D2=$O(^TMP($J,"W",D2)) Q:D2<1  D W0
 S DTP=NOW\1 D DTP^FH S H1=DTP D SES
 I MEAL'="A" D Q2 Q
 F MEAL="B","N","E" D Q2
 Q
Q2 K ^TMP($J,"L"),^TMP($J,"D") F Z=0:0 S Z=$O(^TMP($J,"P",MEAL,Z)) Q:Z<1  D C1
 D HDR I $D(^TMP($J,"L")) S TP="L" W !!?(S1-9\2),"L I K E S",! D L0
 I $D(^TMP($J,"D")) S TP="D" W !!?(S1-15\2),"D I S L I K E S",! D L0
 W ! Q
L0 S X1="" F LL=0:0 S X1=$O(^TMP($J,TP,X1)) Q:X1=""  S Z=^(X1) I $D(^TMP($J,"P",MEAL,Z)) D L1
 Q
L1 D:$Y>(IOSL-6) HDR S TOT=0 W !,$P(^FH(115.2,Z,0),"^",1)
 F D2=0:0 S D2=$O(^TMP($J,"P",MEAL,Z,D2)) Q:D2<1  S N1=^(D2) W ?(30+P(D2)),$J(N1,6) S TOT=TOT+N1
 W ?S2,$J(TOT,7) Q
SES K N,P S PD="",P0=0,N=0
 F K=2:11 S P0=$O(^TMP($J,"W",P0)) Q:P0<1  S Y=$E($P(^FH(119.73,P0,0),"^",1),1,9),PD=PD_$J(Y_$E("         ",1,10-$L(Y)\2),9)_"  ",P(P0)=K,N=N+1
 S S2=31+$L(PD),S1=S2+7 Q
C1 S X=$G(^FH(115.2,Z,0)),TP=$P(X,"^",2)
 Q:TP=""  S ^TMP($J,TP,$P(X,"^",1)_Z)=Z Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,H1,?(S1-29\2),"M E A L   P R E F E R E N C E S",?(S1-6),"Page ",PG
 S X=$S(MEAL="B":"B R E A K F A S T",MEAL="N":"N O O N",1:"E V E N I N G") W !!?(S1-$L(X)\2),X
 W !!,"Preference",?32,PD,"  TOTAL"
 S LN="",$P(LN,"-",S1+8)="" W !,LN Q
KIL K ^TMP($J) G KILL^XUSCLEAN
W0 F WRD=0:0 S WRD=$O(^TMP($J,"W",D2,WRD)) Q:WRD<1  D W2
 Q
W2 Q:$O(^FHPT("AW",WRD,0))<1  S WRDN=$P($G(^FH(119.6,WRD,0)),"^",1)
 F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",WRD,FHDFN)) Q:FHDFN<1  S ADM=^FHPT("AW",WRD,FHDFN) I ADM>0 D W3
 Q
W3 Q:'$D(^FHPT(FHDFN,"A",ADM,0))
 F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S Z=^(K,0),Z2=$P(Z,"^",2),QTY=$P(Z,"^",3),Z=+Z D W4
 Q
W4 I MEAL'="A" Q:Z2'[MEAL  S:'$D(^TMP($J,"P",MEAL,Z,D2)) ^TMP($J,"P",MEAL,Z,D2)=0 S ^(D2)=^(D2)+$S(QTY:QTY,1:1) Q
 F LL="B","N","E" I Z2[LL S:'$D(^TMP($J,"P",LL,Z,D2)) ^TMP($J,"P",LL,Z,D2)=0 S ^(D2)=^(D2)+$S(QTY:QTY,1:1)
 Q
