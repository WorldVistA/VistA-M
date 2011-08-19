FHPRI3 ; HISC/REL - List Vendors ;4/27/93  13:36 
 ;;5.5;DIETETICS;;Jan 28, 2005
L1 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRI3",FHLST="" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Vendors List
 D NOW^%DTC S DTP=% D DTP^FH S PG=0,Y="" D HDR
 S NX="" F K=0:0 S NX=$O(^FH(113.2,"B",NX)) Q:NX=""!(Y="^")  F D0=0:0 S D0=$O(^FH(113.2,"B",NX,D0)) Q:D0<1!(Y="^")  D Q2
 W ! Q
Q2 S X=$G(^FH(113.2,D0,0)) Q:X=""  D:$Y>(IOSL-11) HDR Q:Y="^"
 K A S N=0 F L=1:1:4 S A(L)="",Z=$P(X,"^",L+1) I Z'="" S N=N+1,A(N)=Z
 S N=4 F L=5,6 S A(L)="",Z=$P(X,"^",L+1) I Z'="" S N=N+1,A(N)=Z
 W !,$P(X,"^",1) W:A(1)'="" ?40,A(1)
 I A(2)'=""!(A(5)'="") W ! W:A(5)'="" ?5,A(5) W:A(2)'="" ?40,A(2)
 I A(3)'=""!(A(6)'="") W ! W:A(6)'="" ?5,A(6) W:A(3)'="" ?40,A(3)
 W:A(4)'="" !?40,A(4) W ! Q
HDR I PG,IOST?1"C".E W *7 R Y:DTIME S:'$T Y="^" Q:Y="^"
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !,DTP,?29,"V E N D O R   L I S T",?72,"Page ",PG
 W !!,"NAME",?40,"ADDRESS"
 W !,"-------------------------------------------------------------------------------",! Q
KIL G KILL^XUSCLEAN
