FHPRC2 ; HISC/REL - List Weekly Menu ;1/23/98  16:09
 ;;5.5;DIETETICS;;Jan 28, 2005
F0 R !!,"Select PRODUCTION DIET (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHX1=0
 E  K DIC S DIC="^FH(116.2,",DIC(0)="EQM" D ^DIC G:Y<1 F0 S FHX1=+Y
F1 S %DT("A")="Select SUNDAY Date: ",%DT="AEX" D ^%DT Q:"^"[X!$D(DTOUT)  G:Y<1 F1
 S (D1,X)=Y D DOW^%DTC I Y'=0 W *7,"  .. Not a Sunday" G F1
L0 W !!,"The Menu requires a 132 column compressed printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRC2",FHLST="D1^FHX1" D EN2^FH G F0
 U IO D Q1 D ^%ZISC K %ZIS,IOP G F0
Q1 ; Print Weekly Menu
 D ^FHDEV S X=220 X ^%ZOSF("RM") K D S D(1)=D1 F K=2:1:7 S X1=D(K-1),X2=1 D C^%DTC S D(K)=X
 S PG=0 I FHX1 D Q2 Q
 F NN=0:0 S NN=$O(^FH(116.2,"AP",NN)) Q:NN<1  F FHX1=0:0 S FHX1=$O(^FH(116.2,"AP",NN,FHX1)) Q:FHX1<1  D Q2
 Q
Q2 S FHPD=$P(^FH(116.2,FHX1,0),"^",2) K ^TMP($J)
 F KK=1:1:7 S X1=D(KK) D SET
 Q:'$D(^TMP($J))  W @FHIO("P16") D HDR F K3=1:1:3 D PRT
 W ! W @FHIO("P10") Q
SET D E1^FHPRC1 S X2="" I FHCY>0,$D(^FH(116,FHCY,"DA",FHDA,0)) S X2=^(0)
 I $D(^FH(116.3,+D(KK),0)) S X=^(0) F K3=2:1:4 I $P(X,"^",K3) S $P(X2,"^",K3)=$P(X,"^",K3)
 F K3=1:1:3 S X=$P(X2,"^",K3+1) I X D S1
 Q
S1 K M F P1=0:0 S P1=$O(^FH(116.1,X,"RE",P1)) Q:P1<1  S L1=^(P1,0),L1=+L1,Y=^FH(114,L1,0) D
 .F CAT=0:0 S CAT=$O(^FH(116.1,X,"RE",P1,"R",CAT)) Q:CAT<1  S MCA=$G(^(CAT,0)) I $P(MCA,"^",2)[FHPD D
 ..S K4=+MCA,K4=$P($G(^FH(114.1,+K4,0)),"^",3) S K4=$S('K4:99,K4<10:"0"_K4,1:K4),M("A"_K4_$P(Y,"^",1))=""
 ..Q
 .Q
 S P1=0,K4="" F L1=0:0 S K4=$O(M(K4)) Q:K4=""  S P1=P1+1,^TMP($J,K3,KK,P1)=$E(K4,4,99)
 K M,Y Q
PRT S P1=0
P1 S P1=P1+1,C=0,Y="|" F KK=1:1:7 S X="" S:$D(^TMP($J,K3,KK,P1)) X=^(P1),C=1 S Y=Y_" "_$E(X_$J("",27),1,27)_" |"
 I C W !,Y G P1
 W ! F P1=1:1:211 W "-"
 Q
HDR S DTP=D1 D DTP^FH S Y=$P(^FH(116.2,FHX1,0),"^",1) W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !?94,"W E E K L Y   M E N U",!!?(210-$L(Y)\2),Y,!!?96,"Week Of ",DTP
 W !!?2,"S U N D A Y",?32,"M O N D A Y",?62,"T U E S D A Y",?92,"W E D N E S D A Y",?122,"T H U R S D A Y",?152,"F R I D A Y",?182,"S A T U R D A Y",!
 F K=1:1:211 W "-"
 Q
KIL K ^TMP($J) G KILL^XUSCLEAN
