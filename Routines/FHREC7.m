FHREC7 ; HISC/NCA - Display Analyzed Recipes ;1/18/94  12:30 
 ;;5.5;DIETETICS;;Jan 28, 2005
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHREC7",FHLST="" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Analyzed Recipes
 D NOW^%DTC S DTP=% D DTP^FH S PG=0 D HDR
 S NX="" F  S NX=$O(^FH(114,"B",NX)) Q:NX=""  F D0=0:0 S D0=$O(^FH(114,"B",NX,D0)) Q:D0<1  D CHK
 D:$Y>(IOSL-10) HDR W !!,"'**' preceding a recipe name indicates recipe not analyzed.",! Q
CHK D:$Y>(IOSL-8) HDR S X=$G(^FH(114,D0,0))
 W ! W:'$P(X,"^",14) ?3,"** " W ?6,$P(X,"^",1)
 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,DTP,?20,"A N A L Y Z E D   R E C I P E   L I S T",?71,"Page ",PG
 W !!?17,"RECIPE NAME"
 W !,"--------------------------------------------------------------------------------",! Q
KIL G KILL^XUSCLEAN
