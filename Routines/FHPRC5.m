FHPRC5 ; HISC/REL - List Menu Cycle ;4/27/93  13:44 
 ;;5.5;DIETETICS;;Jan 28, 2005
 S DIC="^FH(116,",DIC(0)="AEQM" W ! D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),FHPRC5:Y<1
 S FHCY=+Y
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRC5",FHLST="FHCY" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; List the Menu Cycle
 D NOW^%DTC S NOW=%,N=$P($G(^FH(116,FHCY,0)),"^",2) Q:'N
 S PG=0 D HDR F K=1:1:N D Q2
 W ! Q
Q2 D:$Y>(IOSL-11) HDR S X=$G(^FH(116,FHCY,"DA",K,0)) W !,$J(K,3)
 S S1=-20 F L=2:1:4 S Z=$P(X,"^",L),S1=S1+25 I Z S Z=$P($G(^FH(116.1,Z,0)),"^",1) I Z'="" W ?S1,$E(Z,1,23)
 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=NOW D DTP^FH W !,DTP,?30,"M E N U   C Y C L E",?73,"Page ",PG
 S Y=$P(^FH(116,FHCY,0),"^",1) W !!?(80-$L(Y)\2),Y
 W !!,"Day",?5,"Breakfast",?30,"Noon",?55,"Evening"
 W !,"-------------------------------------------------------------------------------",! Q
KIL G KILL^XUSCLEAN
