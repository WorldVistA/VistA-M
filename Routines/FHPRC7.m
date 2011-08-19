FHPRC7 ; HISC/REL - Find Meals Containing a Recipe ;4/26/93  15:53 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S (DIC,DIE)="^FH(114,",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:U[X!$D(DTOUT),FHPRC7:Y<1 S FHX1=+Y
L0 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRC7",FHLST="FHX1" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; List Meals Containing a Recipe
 K ^TMP($J) D NOW^%DTC S DTP=% D DTP^FH
 F M1=0:0 S M1=$O(^FH(116.1,M1)) Q:M1<1  F R1=0:0 S R1=$O(^FH(116.1,M1,"RE",R1)) Q:R1<1  S X=+$G(^FH(116.1,M1,"RE",R1,0)) S:X=FHX1 ^TMP($J,"M",M1)=""
 F C1=0:0 S C1=$O(^FH(116,C1)) Q:C1<1  F D1=0:0 S D1=$O(^FH(116,C1,"DA",D1)) Q:D1<1  D Q2
 S N1=$P(^FH(114,FHX1,0),"^",1),PG=0,LN="",$P(LN,"-",80)="" D HDR,P0
 W ! Q
Q2 S X=$G(^FH(116,C1,"DA",D1,0)) Q:X=""
 F K1=1:1:3 S Z=$P(X,"^",K1+1) I Z,$D(^TMP($J,"M",Z)) S ^TMP($J,"M",Z,"C",C1_"~"_D1_"~"_K1)=""
 Q
P0 F M1=0:0 S M1=$O(^TMP($J,"M",M1)) Q:M1<1  S X=$P($G(^FH(116.1,M1,0)),"^",1) I X'="" D:$Y>(IOSL-9) HDR W !,X D P1
 Q
P1 S A1="" F C1=0:0 S A1=$O(^TMP($J,"M",M1,"C",A1)) Q:A1=""  D P2
 Q
P2 S C1=+A1,D1=$P(A1,"~",2),K1=$P(A1,"~",3)
 W ?31,$P(^FH(116,C1,0),"^",1),", Day ",D1,", ",$S(K1=1:"Breakfast",K1=2:"Noon",1:"Evening"),! D:$Y>(IOSL-6) HDR Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,DTP,?28,"R E C I P E   U S A G E",?73,"Page ",PG
 W !!?(80-$L(N1)\2),N1
 W !!,"Meal",?31,"Cycle",!,LN,! Q
KIL K ^TMP($J) G KILL^XUSCLEAN
