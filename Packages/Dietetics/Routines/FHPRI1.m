FHPRI1 ; HISC/REL - Find Recipes with Ingredient ;4/27/93  13:31 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S (DIC,DIE)="^FHING(",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:U[X!$D(DTOUT),FHPRI1:Y<1 S FHX1=+Y
L0 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRI1",FHLST="FHX1" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Recipes with selected Ingredient
 K ^TMP($J) D NOW^%DTC S DTP=% D DTP^FH
 F R1=0:0 S R1=$O(^FH(114,R1)) Q:R1<1  F I1=0:0 S I1=$O(^FH(114,R1,"I",I1)) Q:I1<1  S X=$G(^FH(114,R1,"I",I1,0)) I +X=FHX1 S ^TMP($J,"R",R1)=$P(X,"^",2)
 F M1=0:0 S M1=$O(^FH(116.1,M1)) Q:M1<1  F I1=0:0 S I1=$O(^FH(116.1,M1,"RE",I1)) Q:I1<1  S R1=+$G(^FH(116.1,M1,"RE",I1,0)) I $D(^TMP($J,"R",R1)) S ^TMP($J,"R",R1,"M",M1)="" D Q2
 S X2=^FHING(FHX1,0),N1=$P(X2,"^",1),UNT=$P(X2,"^",16)
 S PG=0,LN="",$P(LN,"-",80)="" D HDR
 F R1=0:0 S R1=$O(^TMP($J,"R",R1)) Q:R1<1  S Y=^(R1) D P0
 W ! Q
Q2 F C1=0:0 S C1=$O(^FH(116,C1)) Q:C1<1  F D1=0:0 S D1=$O(^FH(116,C1,"DA",D1)) Q:D1<1  D Q3
 Q
Q3 S X=$G(^FH(116,C1,"DA",D1,0)) Q:X=""
 F K1=1:1:3 S Z=$P(X,"^",K1+1) I Z,$D(^TMP($J,"R",R1,"M",Z)) S ^TMP($J,"R",R1,"M",Z,"C",C1_"~"_D1_"~"_K1)=""
 Q
P0 D:$Y>(IOSL-6) HDR S R2=^FH(114,R1,0) D EN2^FHREC1
 W !,$P(R2,"^",1),?32,$J($P(R2,"^",2),5),?45,Y
 F M1=0:0 S M1=$O(^TMP($J,"R",R1,"M",M1)) Q:M1<1  S X=$P($G(^FH(116.1,M1,0)),"^",1) I X'="" D:$Y>(IOSL-6) HDR W !?3,"Meal:  ",X D P1
 Q
P1 S A1="" F C1=0:0 S A1=$O(^TMP($J,"R",R1,"M",M1,"C",A1)) Q:A1=""  D P2
 Q
P2 S C1=+A1,D1=$P(A1,"~",2),K1=$P(A1,"~",3) D:$Y>(IOSL-6) HDR
 W !?6,"Cycle: ",$P(^FH(116,C1,0),"^",1),", Day ",D1,", ",$S(K1=1:"Breakfast",K1=2:"Noon",1:"Evening") Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,DTP,?24,"I N G R E D I E N T   U S A G E",?73,"Page ",PG
 W !!?(80-$L(N1)\2),N1
 W !!,"Recipe",?30,"# Portions",?45,"Amount",!,LN Q
KIL K ^TMP($J) G KILL^XUSCLEAN
