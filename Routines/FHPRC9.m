FHPRC9 ; HISC/NCA - Weekly Menu Blocks ;1/23/98  16:10
 ;;5.5;DIETETICS;;Jan 28, 2005
D0 K DIC W !! S DIC="^FH(114.1,",DIC(0)="AEQM",DIC("A")="Select RECIPE CATEGORY: " D ^DIC S:$D(DTOUT) X="^" G KIL:"^"[X,D0:Y<1 S FHX1=+Y
F0 R !!,"Select PRODUCTION DIET (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHX2=0
 E  K DIC S DIC="^FH(116.2,",DIC(0)="EQM" D ^DIC G KIL:$D(DTOUT),F0:Y<1 S FHX2=+Y
F1 S %DT("A")="Select SUNDAY Date: ",%DT="AEX" D ^%DT S:$D(DTOUT) X="^" G KIL:"^"[X,F1:Y<1
 S (D1,X)=Y D DOW^%DTC I Y'=0 W *7,"  .. Not a Sunday" G F1
L0 W !!,"The Menu requires a 132 column compressed printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRC9",FHLST="D1^FHX1^FHX2" D EN2^FH G D0
 U IO D Q1 D ^%ZISC K %ZIS,IOP G D0
Q1 ; Print Menu Block
 D ^FHDEV S X=220 X ^%ZOSF("RM") S (T0,X1)=D1 D E1^FHPRC1 Q:FHCY'>0  S ST=X,WKS=$S(K1<7:7,1:K1) S ST=ST#WKS,WKS=WKS-ST S:WKS<7 WKS=$S(K1<7:7,1:K1)
 S WKS=WKS/7 S:WKS#1 WKS=$S(WKS#1'<5:WKS+.95\1,1:WKS\1) S:WKS'<7 WKS=6
 K D S X=T0 F J=1:1:WKS F K=1:1:7 S D(J,K)=X,X1=D(J,K),X2=1 D C^%DTC
 S PG=0 I FHX2 D Q2 Q
 F NN=0:0 S NN=$O(^FH(116.2,"AP",NN)) Q:NN<1  F FHX2=0:0 S FHX2=$O(^FH(116.2,"AP",NN,FHX2)) Q:FHX2<1  D Q2
 Q
Q2 S FHPD=$P(^FH(116.2,FHX2,0),"^",2) K ^TMP($J)
 F XX=1:1:WKS F KK=1:1:7 S X1=D(XX,KK) D SET
 Q:'$D(^TMP($J))
 W @FHIO("P16") S N2=$P(^FH(116.2,FHX2,0),"^",1),N3=$P($G(^FH(114.1,FHX1,0)),"^",1) D HDR S X3=T0 F XX=1:1:WKS D:$Y+6>(IOSL-10) HDR D HDR1 S X1=X3,X2=7 D C^%DTC S X3=X F K3=1:1:3 D PRT
 W ! W @FHIO("P10") Q
SET D E1^FHPRC1 S X2="" I FHCY>0,$D(^FH(116,FHCY,"DA",FHDA,0)) S X2=^(0)
 I $D(^FH(116.3,+D(XX,KK),0)) S X=^(0) F K3=2:1:4 I $P(X,"^",K3) S $P(X2,"^",K3)=$P(X,"^",K3)
 F K3=1:1:3 S X=$P(X2,"^",K3+1) I X D S1
 Q
S1 K M F P1=0:0 S P1=$O(^FH(116.1,X,"RE",P1)) Q:P1<1  S L1=^(P1,0) D
 .S L1=+L1,Y=$G(^FH(114,L1,0))
 .F CAT=0:0 S CAT=$O(^FH(116.1,X,"RE",P1,"R",CAT)) Q:CAT<1  S MCA=^(CAT,0),K0=+MCA I K0 D S2
 .Q
 S P1=0,K4="" F L1=0:0 S K4=$O(M(K4)) Q:K4=""  S P1=P1+1,^TMP($J,XX,K3,KK,P1)=$E(K4,4,99)
 K M,Y Q
S2 I FHX1,FHX1'=K0 Q
 I $P(MCA,"^",2)[FHPD S K4=$P($G(^FH(114.1,+K0,0)),"^",3),K4=$S('K4:99,K4<10:"0"_K4,1:K4),M("A"_K4_$P(Y,"^",1))=K0
 Q
PRT S P1=0
P1 S P1=P1+1,C=0,Y="|" F KK=1:1:7 S X="" S:$D(^TMP($J,XX,K3,KK,P1)) X=^(P1),C=1 S Y=Y_" "_$E(X_$J("",27),1,27)_" |"
 I C W !,Y G P1
 W ! F P1=1:1:211 W "-"
 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !!!!?88,"W E E K L Y   M E N U   B L O C K S",!!?(210-$L(N2_"  "_N3)\2),N2,"  ",N3 Q
HDR1 S DTP=X3 D DTP^FH
 W !!!?96,"Week Of ",DTP
 W !!?2,"S U N D A Y",?32,"M O N D A Y",?62,"T U E S D A Y",?92,"W E D N E S D A Y",?122,"T H U R S D A Y",?152,"F R I D A Y",?182,"S A T U R D A Y",!
 F K=1:1:211 W "-"
 Q
KIL K ^TMP($J) G KILL^XUSCLEAN
