PRSATD2 ; HISC/REL-Display Tours for T&L ;4/5/93  13:16
 ;;4.0;PAID;;Sep 21, 1995
R0 R !!,"Select T&L Unit (or ALL): ",X:DTIME G:'$T!("^"[X) EX S X=$TR(X,"al","AL") I X="ALL" S TLI=0
 E  K DIC S DIC="^PRST(455.5,",DIC(0)="EMQ" D ^DIC G EX:$D(DTOUT),R0:Y<1 S TLI=+Y
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSATD2",PRSALST="TLI" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; Process List
 D NOW^%DTC S X=%\1 D DTP^PRSAPPU S DTE=Y,(PG,QT)=0 D HDR
 S NX="" F  S NX=$O(^PRST(457.1,"B",NX)) Q:NX=""  F TD=0:0 S TD=$O(^PRST(457.1,"B",NX,TD)) Q:TD<1  D Q3 G:QT Q2
 D H1
Q2 Q
Q3 S Y0=$G(^PRST(457.1,TD,0)),ALL=$P(Y0,"^",4) I TLI,'ALL,'$D(^PRST(457.1,TD,"T","B",TLI)) Q
 S Y1=$G(^PRST(457.1,TD,1)) I $Y>(IOSL-6) D HDR Q:QT
 W !,$J(TD,3),"  ",$P(Y0,"^",1),?35,$J($P(Y0,"^",6),6,2),"  " I Y1="" W !
 E  F K=1:3:19 Q:$P(Y1,"^",K)=""  W $P(Y1,"^",K),"-",$P(Y1,"^",K+1) S Z=$P(Y1,"^",K+2) W:Z ?58,$P($G(^PRST(457.2,Z,0)),"^",1) W !?43
 Q:TLI  W !?8,"T&Ls: " I ALL W "All",! Q
 F K=0:0 S K=$O(^PRST(457.1,TD,"T",K)) Q:K<1  S Z=$P($G(^(K,0)),"^",1) W:$X>73 !?14 W $P($G(^PRST(455.5,+Z,0)),"^",1),"  "
 W ! Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !,DTE,?27,"T & L   T O U R   L I S T",?72,"Page ",PG
 I TLI S TLE=$P(^PRST(455.5,TLI,0),"^",1) W !!?(79-$L(TLE)\2),TLE
 W !!," #   Tour",?37,"Hrs.     Segment     Special Indicator",! Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
