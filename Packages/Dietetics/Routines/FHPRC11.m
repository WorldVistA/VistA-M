FHPRC11 ; HISC/NCA - Meal Analysis (cont.) ;2/15/95  16:10 
 ;;5.5;DIETETICS;;Jan 28, 2005
 D Q1^FHPRC14
PRT ; Print Meal Analysis
 D NOW^%DTC S DT=%,DTP=DT D DTP^FH S (DAY,PG)=0 G:SUM ^FHPRC12
P1 S DAY=$O(^TMP($J,"R",DAY)) G:DAY="" ^FHPRC12 S MEAL=0,NEW=1
P2 S MEAL=$O(^TMP($J,"R",DAY,MEAL)) G:MEAL="" P3
 I 'NEW W !!,"Meal ",MEAL,! S X=$G(^TMP($J,"RECIPES",DAY,MEAL,0)) S Y=$E($P($G(^FH(116.1,+$P(X,"^",1),0)),"^",1),1,22) W Y,!,"Prod Diet: " S Y=$E($P($G(^FH(116.2,+$P(X,"^",2),0)),"^",1),1,14) W Y,!
 D:NEW HEAD,HD1
 S RNAM="" F  S RNAM=$O(^TMP($J,"R",DAY,MEAL,RNAM)) Q:RNAM=""  S X0=$G(^(RNAM,0)),X1=$G(^(1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)),SVG=+X0 D:$Y>(IOSL-8) HEAD,HD1 W !,$J(SVG,4)," ",RNAM,?24,$J($P(X0,"^",2),5,0) D LIS^FHNU2
 D:$Y>(IOSL-10) HEAD,HD1 W !!?7,"Recipe Total",?29 S X1=$G(^TMP($J,"M",DAY,MEAL,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D LIS^FHNU2
 W !?7,"% of Kcal",?36 S Z1=$P(X1,"^",4) S:'Z1 Z1=1 F KK=1,3,2 W $J($P(X1,"^",KK)*$S(KK=2:900,1:400)/Z1,7,0)
 G P2
P3 D:$Y>(IOSL-12) HEAD,HD1 W !!,"Daily Total",?29 S X1=$G(^TMP($J,"D",DAY,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D LIS^FHNU2
 I RDA W !,"% DRI",?29 D RDA^FHNU9
 W !,"% of Kcal",?36 S Z1=$P(X1,"^",4) S:'Z1 Z1=1 F KK=1,3,2 W $J($P(X1,"^",KK)*$S(KK=2:900,1:400)/Z1,7,0)
 W:$P(X1,"^",1) !!,"Kcal:N Ratio = ",$J(6.25*$P(X1,"^",4)/$P(X1,"^",1),0,0),":1"
P4 S MEAL=0,NEW=1
P5 S MEAL=$O(^TMP($J,"R",DAY,MEAL)) G:MEAL="" P6
 I 'NEW W !!,"Meal ",MEAL,! S X=$G(^TMP($J,"RECIPES",DAY,MEAL,0)) S Y=$E($P($G(^FH(116.1,+$P(X,"^",1),0)),"^",1),1,14) W Y,!,"PD: " S Y=$E($P($G(^FH(116.2,+$P(X,"^",2),0)),"^",1),1,11) W Y,!
 D:NEW HEAD,HD2
 S RNAM="" F  S RNAM=$O(^TMP($J,"R",DAY,MEAL,RNAM)) Q:RNAM=""  S X0=$G(^(RNAM,0)),X1=$G(^(1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)),SVG=+X0 D:$Y>(IOSL-8) HEAD,HD2 W !,$E(RNAM,1,10),?12 D LIS^FHNU2
 D:$Y>(IOSL-9) HEAD,HD2 W !!?3,"Total",?12 S X1=$G(^TMP($J,"M",DAY,MEAL,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D LIS^FHNU2 G P5
P6 D:$Y>(IOSL-10) HEAD,HD2 W !!,"Daily Total",?12 S X1=$G(^TMP($J,"D",DAY,1)),X2=$G(^(2)),X3=$G(^(3)),X4=$G(^(4)) D LIS^FHNU2
 I RDA W !,"% DRI",?12 D RDA^FHNU9
 G P1
HEAD ; Print Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 D:PG=1 SITE^FH G:NAM'="" HEAD1
 W !,"Station #: ",SITE(1),?42,"A N A L Y S I S   O F   M E A L   P O R T I O N",?124,"Page ",PG
 W !,"Station Name: ",SITE,?57,DTP W:RDA ?110,"DRI: ",$P(^FH(112.2,RDA,0),U,1)
 W !?(132-$L(MNAM)\2),MNAM S NEW=0 Q
HEAD1 W !?42,"A N A L Y S I S   O F   M E A L   P O R T I O N",?124,"Page ",PG,!?57,DTP
 W !?(132-$L(MNAM)\2),MNAM S NEW=0
 W !!,"Patient: ",NAM,?63,$S(SEX="M":"Male",1:"Female"),?124,"Age: ",AGE,! Q
HD1 W !!,"Day ",DAY,!! W:MEAL'="" "Meal ",MEAL S:MEAL'="" X=$G(^TMP($J,"RECIPES",DAY,MEAL,0)) S Y=$S(MEAL'="":$E($P($G(^FH(116.1,+$P(X,"^",1),0)),"^",1),1,22),1:"") W !
 W Y,?24,"Quant  Energ    Pro    CHO    Fat    Sod    Pot   Calc   Phos   Iron   Zinc    Mag    Man   Cop   Sel  DFib" S Y=$S(MEAL'="":$E($P($G(^FH(116.2,+$P(X,"^",2),0)),"^",1),1,14),1:"")
 W ! W:MEAL'="" "Prod Diet: ",Y W ?27,"Gm   KCal     Gm     Gm     Gm     Mg     Mg     Mg     Mg     Mg     Mg     Mg     Mg    Mg   Mcg    Gm",!
 ;NUT String contains 7 characters per nut: 1=node in ^FHNU,2-3=pos. in ^FHNU, 4=field size, 5=# decimals, 6-7=pos. of DRI in ^FH(112.2
 S NUT="104700010171011037100102710011370191127020108701111170121097114114711511071131167218115621746661222376100" Q
HD2 W !!,"Day ",DAY,!! W:MEAL'="" "Meal ",MEAL S:MEAL'="" X=$G(^TMP($J,"RECIPES",DAY,MEAL,0)) S Y=$S(MEAL'="":$E($P($G(^FH(116.1,+$P(X,"^",1),0)),"^",1),1,14),1:"") W !
 W Y,?18,"K      A      C      E    Rib    Thi    Nia     B6    B12    Fol   Pant   Chol   18C2   18C3   Mono   PuFA   SaFa" S Y=$S(MEAL'="":$E($P($G(^FH(116.2,+$P(X,"^",2),0)),"^",1),1,11),1:"")
 W ! W:MEAL'="" "PD: ",Y W ?16,"Mcg     RE     Mg     Mg     Mg     Mg     Mg     Mg    Mcg    Mcg     Mg     Mg     Gm     Gm     Gm     Gm     Gm",!
 S NUT="46571262337002119710411771032217206120720522272072247208226721022572092237216229700022771002287100231710023271002307100" Q
