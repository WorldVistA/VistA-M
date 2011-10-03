FHNU2 ; HISC/REL/NCA - Analyze Menu ;3/6/95  15:53
 ;;5.5;DIETETICS;;Jan 28, 2005
GET K DIC S MENU=0,DIC="^FHUM(",DIC(0)="AEQMZ",DIC("S")="I '$P(^(0),U,5)" W ! D ^DIC G KIL:U[X!$D(DTOUT),GET:Y<1 S MENU=+Y,MNAM="Menu: "_$P(Y,U,2),TYP=$P(Y(0),U,2)
F0 K DIC S DIC="^FH(112.2,",DIC(0)="AEQM",DIC("A")="Select DRI Category: " W ! D ^DIC G KIL:X["^"!$D(DTOUT),F0:Y<1 S RDA=+Y K DIC
S0 R !!,"Do you wish a detailed analysis? Y// ",SUM:DTIME G:'$T!(SUM["^") KIL S:SUM="" SUM="Y" S X=SUM D TR^FH S SUM=X I $P("YES",SUM,1)'="",$P("NO",SUM,1)'="" W *7,!,"  Answer YES or NO" G S0
 S SUM=$E(SUM,1),SUM=SUM="N"
 W !!,"The Analysis requires a 132 column printer.",!
 K IOP S %ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="F1^FHNU2",FHLST="MENU^MNAM^TYP^RDA^SUM" D EN2^FH G KIL
 U IO X ^%ZOSF("BRK") D F1 X ^%ZOSF("NBRK") D ^%ZISC K %ZIS,IOP G KIL
F1 ; Print Nutrient Menu Analysis
 S %DT="X",X="T" D ^%DT S DT=+Y,DTP=DT D DTP^FH,TOT^FHNU9 S (DAY,PG)=0 K D,T G:SUM ^FHNU3
F5 S DAY=$O(^TMP($J,"I",DAY)) G:DAY="" ^FHNU3 S MEAL=0,NEW=1
F6 S MEAL=$O(^TMP($J,"I",DAY,MEAL)) G:MEAL="" F8
 W:'NEW !!,"Meal ",MEAL,! D:NEW HEAD,HD1
F7 F NM=1:1 Q:'$D(^TMP($J,"I",DAY,MEAL,NM))  S X0=$G(^(NM,0)),X1=$G(^(1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D:$Y>(IOSL-8) HEAD,HD1 W !,$J(NM,5),"  ",$P(X0,"^",1),?24,$J($P(X0,"^",2),5,0) D LIS
 D:$Y>(IOSL-10) HEAD,HD1 W !!?7,"Meal Total",?29 S X1=$G(^TMP($J,"M",DAY,MEAL,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D LIS
 W !?7,"% of Kcal",?36 S Z1=$P(X1,"^",4) S:'Z1 Z1=1 F KK=1,3,2 W $J($P(X1,"^",KK)*$S(KK=2:900,1:400)/Z1,7,0)
 G F6
F8 D:$Y>(IOSL-12) HEAD,HD1 W !!,"Daily Total",?29 S X1=$G(^TMP($J,"D",DAY,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D LIS
 W !,"% DRI",?29 D RDA^FHNU9
 W !,"% of Kcal",?36 S Z1=$P(X1,"^",4) S:'Z1 Z1=1 F KK=1,3,2 W $J($P(X1,"^",KK)*$S(KK=2:900,1:400)/Z1,7,0)
 W:$P(X1,"^",1) !!,"Kcal:N Ratio = ",$J(6.25*$P(X1,"^",4)/$P(X1,"^",1),0,0),":1"
 S MEAL=0,NEW=1
F9 S MEAL=$O(^TMP($J,"I",DAY,MEAL)) G:MEAL="" F11
 W:'NEW !!,"Meal ",MEAL,! D:NEW HEAD,HD2
F10 F NM=1:1 Q:'$D(^TMP($J,"I",DAY,MEAL,NM))  S X0=$G(^(NM,0)),X1=$G(^(1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D:$Y>(IOSL-8) HEAD,HD2 W !,$J(NM,5),?12 D LIS
 D:$Y>(IOSL-9) HEAD,HD2 W !!?3,"Total",?12 S X1=$G(^TMP($J,"M",DAY,MEAL,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D LIS G F9
F11 D:$Y>(IOSL-10) HEAD,HD2 W !!,"Daily Total",?12 S X1=$G(^TMP($J,"D",DAY,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D LIS
 W !,"% DRI",?12 D RDA^FHNU9 G F5
LIS ; List nutrient values
 S KK=1
L1 S NODE=$E(NUT,KK) Q:'NODE  S ITM=+$E(NUT,KK+1,KK+2) Q:'ITM  S SIZ=$E(NUT,KK+3),DEC=$E(NUT,KK+4),KK=KK+7
 S Z1=$S(NODE=1:$P(X1,"^",ITM),NODE=2:$P(X2,"^",ITM-20),NODE=3:$P(X3,"^",ITM-38),1:$P(X4,"^",ITM-56))
 S Z1=$S(Z1'="":$J(Z1,SIZ,DEC),1:$J(Z1,SIZ)) W Z1 G L1
KIL ; Final Variable Kill
 K ^TMP($J) G KILL^XUSCLEAN
HEAD ; Print Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 I PG=1 D SITE^FH
 W !,"Station #: ",SITE(1),?44,"E N E R G Y / N U T R I E N T   A N A L Y S I S",?124,"Page ",PG
 W !,"Station Name: ",SITE,?61,DTP,?110,"DRI: ",$P(^FH(112.2,RDA,0),U,1)
 W !?(132-$L(MNAM)\2),MNAM S NEW=0 Q
HD1 W !!,"Day ",DAY,?24,"Quant  Energ    Pro    CHO    Fat    Sod    Pot   Calc   Phos   Iron   Zinc    Mag    Man   Cop   Sel  DFib"
 W ! W:MEAL'="" "Meal ",MEAL W ?27,"Gm   KCal     Gm     Gm     Gm     Mg     Mg     Mg     Mg     Mg     Mg     Mg     Mg    Mg   Mcg    Gm",!
 ;NUT String contains 7 characters per nut: 1=node in ^FHNU,2-3=pos. in ^FHNU, 4=field size, 5=# decimals, 6-7=pos. of DRI in ^FH(112.2
 S NUT="104700010171011037100102710011370191127020108701111170121097114114711511071131167218115621746661222376100" Q
HD2 W !!,"Day ",DAY,?18,"K      A      C      E    Rib    Thi    Nia     B6    B12    Fol   Pant   Chol   18C2   18C3   Mono   PuFA   SaFa"
 W ! W:MEAL'="" "Meal ",MEAL W ?16,"Mcg     RE     Mg     Mg     Mg     Mg     Mg     Mg    Mcg    Mcg     Mg     Mg     Gm     Gm     Gm     Gm     Gm",!
 S NUT="46571262337002119710411771032217206120720522272072247208226721022572092237216229700022771002287100231710023271002307100" Q
