FHORE2 ; HISC/REL/NCA - List Early/Late Trays ;3/15/95  08:59
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHP=$O(^FH(119.73,0)) I FHP'<1,$O(^FH(119.73,FHP))<1 G N1
R0 R !!,"Select COMMUNICATION OFFICE (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHP=0 G N1
 K DIC S DIC="^FH(119.73,",DIC(0)="EMQ" D ^DIC G:Y<1 R0 S FHP=+Y
N1 W ! S %DT="AEX",%DT("A")="Select Date: " D ^%DT K %DT G KIL:X[U!$D(DTOUT),N1:Y<1 S DTE=+Y\1
N2 R !!,"Select Meal (B,N,E or ALL): ",MEAL:DTIME G:'$T!("^"[MEAL) KIL S X=MEAL D TR^FH S MEAL=X
 S:$P("ALL",MEAL,1)="" MEAL="A" I "BNEA"'[MEAL!(MEAL'?1U) W *7,!,"Select B for Breakfast, N for Noon, E for Evening or ALL for all meals" G N2
N3 R !!,"Do you want Labels? N// ",X:DTIME G:'$T!(X["^") KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Enter YES or NO" G N3
 S LAB=X?1"Y".E
 S FHLBFLG=1 I LAB>0 D  I FHLBFLG=0 Q
 .W ! K DIR,LABSTART S DIR(0)="NA^1:10",DIR("A")="If using laser label sheets, what row do you want to begin printing at? ",DIR("B")=1 D ^DIR
 .I $D(DIRUT) S FHLBFLG=0 Q
 .S LABSTART=Y Q
 I 'LAB W !!,"The list requires a 132 column printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select "_$S(LAB:"LABEL",1:"LIST")_" Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="^FHORE21",FHLST="FHP^LAB^DTE^MEAL^LABSTART" D EN2^FH G KIL
 U IO D ^FHORE21 D ^%ZISC K %ZIS,IOP G KIL
KIL K %,%H,%I,%DT,A1,ADM,ANS,BAG,D1,D3,FHDFN,DFN,DIC,DP,DTP,DTE,FHDU,FHLD,FHOR,FHP,H1,IS,K,K1,K2,KK,L,L1,LAB,LABSTART,M1,M2,MEAL,N,N1,N2,O1,OLW,FHORD,P0,P1,P2,PG,POP,RM,S1,TIM,W1,WARD,X,X2,Y K ^TMP($J) Q
