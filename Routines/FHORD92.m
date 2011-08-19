FHORD92 ; HISC/NCA - Diet Census Percentage ;6/8/93  08:54 
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
 ;RVD 4/7/04 - add outpatient meals data.
 ;
 D DIV^FHOMUTL G:'$D(FHSITE) KIL
R0 R !!,"Do you want DIET CENSUS PERCENTAGE for MEAL? (Y/N): ",FHAN:DTIME G:'$T!("^"[FHAN) KIL S X=FHAN D TR^FH S FHAN=X I $P("YES",FHAN,1)'="",$P("NO",FHAN,1)'="" W *7,"  Enter YES or NO" G R0
 S FHAN=$E(FHAN,1)
 S FHP=$O(^FH(119.71,0)) I FHP'<1,$O(^FH(119.71,FHP))<1 G F1
F0 R !!,"Select PRODUCTION FACILITY: ",X:DTIME G:'$T!("^"[X) KIL
 K DIC S DIC="^FH(119.71,",DIC(0)="EMQ" D ^DIC G:Y<1 F0 S FHP=+Y
F1 S %DT("A")="Select Date: ",%DT="AEX" W ! D ^%DT G KIL:"^"[X!$D(DTOUT),F1:Y<1 S (X1,D1)=+Y
 I FHAN'="Y" S (MEAL,FHCY,FHDA,FHP1)="" G L0
 D E1^FHPRC1 I FHCY<1 W *7,!!,"No MENU CYCLE Defined for that Date!" G F1
 I '$D(^FH(116,FHCY,"DA",FHDA,0)) W *7,!!,"MENU CYCLE DAY Not Defined for that Date!" G F1
R1 R !!,"Select MEAL (B,N,E or ALL): ",MEAL:DTIME G:'$T!("^"[MEAL) KIL S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="A"
 I "BNEA"'[MEAL!(MEAL'?1U) W *7,!,"Select B for Breakfast, N for Noon, or E for Evening or ALL for all meals" G R1
 S FHDA=^FH(116,FHCY,"DA",FHDA,0)
 I $D(^FH(116.3,D1,0)) S X=^(0) F LL=2:1:4 I $P(X,"^",LL) S $P(FHDA,"^",LL)=$P(X,"^",LL)
 I MEAL'="A" S FHX1=$P(FHDA,"^",$F("BNE",MEAL)) I 'FHX1 W *7,!!,"*** NO MENU DEFINED FOR THIS MEAL ***" G KIL
R2 R !!,"Use CENSUS or FORECAST? (C OR F): ",FHP1:DTIME G:'$T!("^"[FHP1) KIL S X=FHP1 D TR^FH S FHP1=X I $P("CENSUS",FHP1,1)'="",$P("FORECAST",FHP1,1)'="" W *7," Enter C or F" G R2
 K M2 S FHP1=$E(FHP1,1),FHX1=$S(FHP1="C":"Census",1:"Forecast") G:FHX1["C" L0
 W !!,"Forecasting ..." D Q2^FHPRF1
 F P0=0:0 S P0=$O(^TMP($J,P0)) Q:P0<1  D C0 G:X="^" KIL
L0 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHORD93",FHLST="D1^MEAL^FHAN^FHDA^FHP^FHP1^M2(^FHSITE^FHSITENM" D EN2^FH G KIL
 U IO D Q1^FHORD93 D ^%ZISC K %ZIS,IOP G KIL
C0 S S1=^TMP($J,P0)
 W !!?5,"Service Point: ",$P(^FH(119.72,P0,0),"^",1)
C1 W !?5,"Forecast Census: ",S1," // " R X:DTIME I '$T!(X["^") S X="^" Q
 S:X="" X=S1 I X'?1N.N!(X>9999) W *7,"  Must be a number less than 9999" G C1
 S M2(P0)=X Q
KIL K %,%H,%I,%T,%DT,%ZIS,A1,ADM,C2,C3,D,D1,D2,CHK,CT,FHDFN,DFN,DIC,DOW,DTP,FHAN,FHCY,FHDA,FHLD,FHOR,FHORD,FHP,FHP1,FHPAR,FHX1,K,K1,K3,KK,L1,L2,LL,LN,LP,MEAL,M2,N,N1,N2,N3
 K NOW,NXW,P,P0,P1,PG,POP,S,S0,S1,S2,S3,S4,SP,T,T0,TF,TIM,TP,TOT,TYP,W1,WRD,WRDN,X,X0,X1,X2,Y,Y0,Z K ^TMP($J) Q
