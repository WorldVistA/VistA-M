FHPRF2 ; HISC/REL - Print Diet Percentages ;4/27/93  13:41 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHP=$O(^FH(119.72,0)) I FHP'<1,$O(^FH(119.72,FHP))<1 S FHP=0 G R1
R0 R !!,"Select SERVICE POINT (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHP=0
 E  K DIC S DIC="^FH(119.72,",DIC(0)="EMQ" D ^DIC G:Y<1 R0 S FHP=+Y
R1 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRF2",FHLST="FHP" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Production Diet Percentage
 D NOW^%DTC S DTP=% D DTP^FH S PG=0
 I FHP S P0=FHP D Q2 Q
 F P0=0:0 S P0=$O(^FH(119.72,P0)) Q:P0<1  D Q2
 Q
Q2 ;
 I $G(^FH(119.72,P0,"I"))="Y" Q
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?13,"P R O D U C T I O N   D I E T   P E R C E N T A G E S"
 S X=$P(^FH(119.72,P0,0),"^",1) W !!?(79-$L(X)\2),X,!!?(79-$L(DTP)\2),DTP
 W !!?3,"Diet",?28,"Sun     Mon     Tue     Wed     Thu     Fri     Sat",!
 K S F L=1:1:7 S S(L)=0
 F P1=0:0 S P1=$O(^FH(116.2,"AP",P1)) Q:P1<1  F NX=0:0 S NX=$O(^FH(116.2,"AP",P1,NX)) Q:NX<1  I $D(^FH(119.72,P0,"A",NX)) S X=^(NX,0) D PR
 W !,"Not Eating",?23 F L=1:1:7 S Z=$S(S(L)<100:100-S(L),1:0),S(L)=S(L)+Z W $S('Z:$J("",8),1:$J(Z,8,1))
 W !!?3,"Total Sum",?23 F L=1:1:7 W $J(S(L),8,1)
 W ! Q
PR S NAM=$P(^FH(116.2,NX,0),"^",1) W !,$E(NAM,1,23),?23
 F L=1:1:7 S Z=$P(X,"^",L+1),S(L)=S(L)+Z W $S('Z:$J("",8),1:$J(Z,8,1))
 Q
KIL G KILL^XUSCLEAN
