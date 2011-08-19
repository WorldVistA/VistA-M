FHPRR1 ; HISC/REL/RVD - Projected Usage ;3/6/95  16:07
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHP=$O(^FH(119.71,0)) I FHP'<1,$O(^FH(119.71,FHP))<1 G P1
P0 R !!,"Select PRODUCTION FACILITY: ",X:DTIME G:'$T!("^"[X) KIL
 K DIC S DIC="^FH(119.71,",DIC(0)="EMQ" D ^DIC G:Y<1 P0 S FHP=+Y
P1 D DT G:"^"[X KIL
 K M F P0=0:0 S P0=$O(^FH(119.72,P0)) Q:P0<1  I $P($G(^(P0,0)),"^",3)=FHP D C0 G:X="^" KIL
R0 R !!,"Sort by Vendor Y// ",V0:DTIME G:'$T!(V0="^") KIL S:V0="" V0="Y" S X=V0 D TR^FH S V0=X I $P("YES",V0,1)'="",$P("NO",V0,1)'="" W *7,"  Answer YES or NO" G R0
 S V0=V0?1"Y".E
 W !!,"The report requires a 132 column compressed printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRR1",FHLST="FHP^SDT^EDT^V0^M(" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Projected Usage
 K ^TMP($J) F DOW=1:1:7 F K3=1:1:3 D FOR
 G ^FHPRR2
C0 I $G(^FH(119.72,P0,"I"))="Y" Q
 W !!?5,"Service Point: ",$P(^FH(119.72,P0,0),"^",1)
C1 W !?5,"Average Census: " R X:DTIME I '$T!(X["^") S X="^" Q
 I X'?1N.N!(X>9999) W *7,"  Must be a number less than 9999" G C1
 S M(P0)=X Q
FOR F P0=0:0 S P0=$O(M(P0)) Q:P0<1  D F1
 Q
F1 S S1=M(P0),N0=$P(^FH(119.72,P0,0),"^",2)
 F LL=0:0 S LL=$O(^FH(119.72,P0,"A",LL)) Q:LL<1  S S0=$P(^(LL,0),"^",DOW+1) D F2
 F LL=0:0 S LL=$O(^FH(119.72,P0,"B",LL)) Q:LL<1  S Y=$P(^(LL,0),"^",3*DOW-2+K3) I Y>0 S C0=$P(^FH(116.2,LL,0),"^",2) D F3
 Q
F2 S Y=$J(S0*S1/100,0,0) Q:Y<1
 S X=^FH(116.2,LL,0),C0=$P(X,"^",2)
F3 S:'$D(^TMP($J,"P",DOW_K3,P0,C0,N0)) ^TMP($J,"P",DOW_K3,P0,C0,N0)=0 S ^(N0)=^(N0)+Y
 S:'$D(^TMP($J,"M",DOW_K3,C0,N0)) ^TMP($J,"M",DOW_K3,C0,N0)=0 S ^(N0)=^(N0)+Y Q
DT ; Get From/To Dates
D1 S %DT="AEX",%DT("A")="Starting Date: " W ! D ^%DT Q:U[X!$D(DTOUT)  G:Y<1 D1 S SDT=+Y
D2 S %DT="AEFX",%DT("A")=" Ending Date: " D ^%DT Q:U[X!$D(DTOUT)  G:Y<1 D2 S EDT=+Y
 I EDT<SDT W *7,"  [End before Start?] " G D1
 Q
KIL K ^TMP($J) G KILL^XUSCLEAN
