FHPRF4 ; HISC/REL - Print Other Meals ;4/27/93  13:41 
 ;;5.5;DIETETICS;;Jan 28, 2005
R1 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRF4",FHLST="" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Other Meals
 D NOW^%DTC S DTP=% D DTP^FH
 W:$E(IOST,1,2)="C-" @IOF W !?29,"O T H E R   M E A L S"
 W !!?(79-$L(DTP)\2),DTP
 F P0=0:0 S P0=$O(^FH(119.72,P0)) Q:P0<1  S X1=0 F NX=0:0 S NX=$O(^FH(119.72,P0,"B",NX)) Q:NX<1  S X=^(NX,0) D PR
 W ! Q
PR I $G(^FH(119.72,P0,"I"))="Y" Q
 G:X1 P1 S Y=$P(^FH(119.72,P0,0),"^",1),X1=1 W !!?(79-$L(Y)\2),Y
 W !!,"Diet",?32,"Meal",?40,"Sun  Mon  Tue  Wed  Thu  Fri  Sat"
P1 S NAM=$P(^FH(116.2,NX,0),"^",1) W !!,NAM
 F L=1:1:3 W:L>1 ! W ?32,$P("Brk^Noon^Even","^",L),?38 F K=1:1:7 S Z=$P(X,"^",K*3-2+L) W $S('Z:$J("",5),1:$J(Z,5))
 Q
KIL G KILL^XUSCLEAN
