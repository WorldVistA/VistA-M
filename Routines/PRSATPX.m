PRSATPX ; HISC/REL-Time Exceptions ;8/23/94  11:12
 ;;4.0;PAID;;Sep 21, 1995
TK0 ; TimeKeeper Entry - Posting date
 S PRSTLV=2,ALL=0 G TL
TK1 ; TimeKeeper Entry - Payperiod to date
 S PRSTLV=2,ALL=1 G TL
SUP0 ; Supervisor Entry - Posting date
 S PRSTLV=3,ALL=0 G TL
SUP1 ; Supervisor Entry - PayPeriod to date
 S PRSTLV=3,ALL=1 G TL
TL D ^PRSAUTL G:TLI<1 EX S %DT="X",X="T+3" D ^%DT
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT("B")="T-1",%DT(0)=-Y W ! D ^%DT
 G:Y<1 EX S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I PPI="" W !!,*7,"Pay Period is Not Open Yet!" G EX
 I ALL,$P($G(^PRST(458,PPI,1)),"^",14)<DT S DAY=14
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSATPX",PRSALST="PPI^DAY^ALL^TLE" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 ; Process Exception List
 S PPE=$P($G(^PRST(458,PPI,0)),"^",1),PDT=$G(^PRST(458,PPI,2)),DTE=$P(PDT,"^",DAY),QT=0
 I ALL S DTE=$P(PDT,"^",1)_" to "_DTE
 S (PG,CNT,HDR)=0 D HDR
 S LP=1,NN="" F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  I $D(^PRST(458,PPI,"E",DFN,0)) S HDR=0 F DAY=$S(ALL:1,1:DAY):1:DAY D FND I QT W ! G EX
 W ! D CK,H1 G EX
CK W:'CNT !,"No Exceptions found.",! Q
FND D ^PRSATPE Q:'$D(ER)  I 'HDR D:$Y>(IOSL-5) HDR Q:QT  W !!,$P(^PRSPC(DFN,0),"^",1) S HDR=1
 F K=0:0 S K=$O(ER(K)) Q:K<1  D:$Y>(IOSL-3) HDR Q:QT  W !?5 W:ALL $P(PDT,"^",DAY),"  " W:$P(ER(K),"^",2)'="" $P(ER(K),"^",2) W ?28,$P(ER(K),"^",1) S CNT=CNT+1
 Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !?30,"T&L ",TLE," EXCEPTIONS"
 W !!?(81-$L(DTE)\2),DTE W:HDR !!,$P(^PRSPC(DFN,0),"^",1) Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
