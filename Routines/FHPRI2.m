FHPRI2 ; HISC/REL/NCA - Ingredient Lists ;3/6/95  16:04
 ;;5.5;DIETETICS;;Jan 28, 2005
LIS1 ; List Ingredients - Recipe data
 S FHX1=1 G L0
LIS2 ; List Ingredients - Purchasing data
 S FHX1=2 G L0
LIS3 ; List Ingredients - Nutrient data
 S FHX1=3 G L0
L0 R !!,"Sort: (A=Alphabetically F=Food Group V=Vendor) F// ",FHX2:DTIME G:'$T!(FHX2="^") KIL S:FHX2="" FHX2="F" I "afv"[FHX2 S X=FHX2 D TR^FH S FHX2=X
 I FHX2'?1U!("AFV"'[FHX2) W *7,"  Enter A, F or V" G L0
L1 W !!,"The list requires a 132 column printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRI2",FHLST="FHX1^FHX2" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; List Ingredients
 D NOW^%DTC S DTP=% D DTP^FH I FHX2'="A" G Q2
 S PG=0 D HDR
 S NX="" F K=0:0 S NX=$O(^FHING("B",NX)) Q:NX=""  F D0=0:0 S D0=$O(^FHING("B",NX,D0)) Q:D0<1  D P0
 W ! Q
Q2 S PG=0,OLD="" K ^TMP($J)
 F K=0:0 S K=$O(^FHING(K)) Q:K<1  S X=^(K,0) D Q3
 S GRP="" F K=0:0 S GRP=$O(^TMP($J,GRP)) Q:GRP=""  S NAM="" F NX=0:0 S NAM=$O(^TMP($J,GRP,NAM)) Q:NAM=""  F D0=0:0 S D0=$O(^TMP($J,GRP,NAM,D0)) Q:D0<1  D:GRP'=OLD H0 D P0
 W ! Q
Q3 S NAM=$P(X,"^",1) I FHX2="F" S GRP=$P(X,"^",13) S:GRP<1 GRP=9
 E  S GRP=$P(X,"^",4) S:GRP GRP=$P($G(^FH(113.2,GRP,0)),"^",1) S:GRP="" GRP="~~~"
 S ^TMP($J,GRP,$E(NAM,1,30),K)="" Q
P0 D:$Y>(IOSL-8) HDR S X=$G(^FHING(D0,0))
 G P1:FHX1=1,P2:FHX1=2,P3:FHX1=3 Q
P1 W !,$P(X,"^",1) S Y=$P(X,"^",3),Y=$E(Y,$L(Y)-3,16) W:Y'="" ?53,Y
 S Y=$P(X,"^",12),Y=$S(Y="":Y,$D(^FH(113.1,Y,0))#2:$P(^(0),"^",2),1:Y) W:Y'="" ?61,Y
 W ?70,$P(X,"^",20),?75,$P(X,"^",5) S Y=$P(X,"^",8) W:Y'="" ?81,$J(+Y,10)
 S Y=$P(X,"^",6) S Y=$S(Y="":Y,$D(^FH(119.1,Y,0))#2:$P(^(0),"^",1),1:Y) W:Y'="" ?94,$E(Y,1,15)
 S Y=$P(X,"^",17) W:Y'="" ?113,$J(+Y,10)
 S Y=$P(X,"^",16) W:Y'="" ?126,Y Q
P2 W !,$E($P(X,"^",1),1,49),?50,$P(X,"^",2),?73,$P(X,"^",3),?92,$P(X,"^",13)
 S Y=$P(X,"^",4) S Y=$S(Y="":Y,$D(^FH(113.2,Y,0))#2:$P(^(0),"^",1),1:Y) W:Y'="" ?95,$E(Y,1,17)
 W ?114,$P(X,"^",5)
 S Y=$P(X,"^",7) W:Y'="" ?117,$J(Y,6,0)
 S Y=$P(X,"^",9) W:Y'="" ?123,$J(Y,8,3) Q
P3 W !,$E($P(X,"^",1),1,50) S Y=$P(X,"^",21),Y=$S(Y="":Y,$D(^FHNU(Y,0))#2:$E($P(^(0),"^",1),1,40),1:Y) W:Y'="" ?53,Y
 S Y=$P(X,"^",16) W:Y'="" ?110,Y
 S Y=$P(X,"^",22) W:Y'="" ?120,$J(Y,7,3) Q
H0 S OLD=GRP
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 G H1:FHX1=1,H2:FHX1=2,H3:FHX1=3 Q
H1 W !,DTP,?44,"I N G R E D I E N T   R E C I P E   D A T A",?124,"Page ",PG
 D:FHX2'="A" H5
 W !!,"NAME",?53,"STOCK",?60,"LOC'N",?68,"THAW",?75,"U/P",?85,"ISS/UP",?94,"ISSUE",?116,"REC/ISS",?126,"REC" G H4
H2 W !,DTP,?40,"I N G R E D I E N T   P U R C H A S I N G   D A T A",?124,"Page ",PG
 D:FHX2'="A" H5
 W !!,"NAME",?50,"SUPPLY DESCRIPTION",?73,"STOCK NUMBER",?91,"GRP VENDOR",?114,"U/P",?119,"MULT",?126,"PRICE" G H4
H3 W !,DTP,?42,"I N G R E D I E N T   N U T R I E N T   D A T A",?124,"Page ",PG
 D:FHX2'="A" H5
 W !!,"NAME",?53,"NUTRIENT DATA REFERENCE",?108,"REC UNIT",?119,"WT IN LBS."
H4 W !,"-----------------------------------------------------------------------------------------------------------------------------------",! Q
H5 I FHX2="F" S Y="Food Group: "_$P("MEAT PRODUCTS^MILK PRODUCTS^FRUITS & VEGETABLES^BREADS^COMMERCIAL NUTRITION SUPPLEMENTS^MISCELLANEOUS^^^UNCLASSIFIED","^",GRP)
 E  S Y="Vendor: "_$S(GRP'="~~~":GRP,1:"Unknown")
 W !!?(131-$L(Y)\2),Y Q
KIL K ^TMP($J) G KILL^XUSCLEAN
