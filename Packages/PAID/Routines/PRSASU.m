PRSASU ; HISC/REL-Supervisor Un-Certified List ;8/23/94  09:43
 ;;4.0;PAID;**114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
TK ; TimeKeeper Entry
 S PRSTLV=2 G S1
SUP ; Supervisor Entry
 S PRSTLV=3 G S1
PAY ; Payroll Entry
 S PRSTLV=7 G S1
S1 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?29,"UN-CERTIFIED EMPLOYEES"
 D ^PRSAUTL G:TLI<1 EX
 D NOW^%DTC S DT=%\1,Y=$G(^PRST(458,"AD",DT)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I DAY<6 S X1=DT,X2=-7 D C^%DTC S PPI=$P($G(^PRST(458,"AD",X)),"^",1) G:'PPI EX
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSASU",PRSALST="TLI^TLE^PPI" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 S PDT=$G(^PRST(458,PPI,2)),PDTI=$G(^(1)),(QT,PG,CNT)=0 D HDR
 S NN="" F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  I $D(^PRST(458,PPI,"E",DFN,0)) D CHK I QT G T0
 D CK,H1
T0 G EX
CK W:'CNT !!,"No Un-Certified Employees found." Q
CHK ; Check for needed approvals
 S STAT=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2) I STAT'="","PX"[STAT Q
 I $Y>(IOSL-5) D HDR Q:QT
 S X0=$G(^PRSPC(DFN,0)),SSN=$P(X0,"^",9),CNT=CNT+1
 I PRSTLV=2!(PRSTLV=3) W !,$E(SSN),"XX-XX-",$E(SSN,6,9),"  ",$P(X0,"^",1)
 I PRSTLV=7 W !,$E(SSN,1,3),"-",$E(SSN,4,5),"-",$E(SSN,6,9),"  ",$P(X0,"^",1)
 I SSN S EDUZ=+$O(^VA(200,"SSN",SSN,0)) I $D(^PRST(455.5,"AS",EDUZ,TLI)) S Z0=$P($G(^PRST(455.5,TLI,"S",EDUZ,0)),"^",2) I Z0'="",Z0'=TLE W "  Is Certified by T&L ",Z0
 Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !?29,"UN-CERTIFIED EMPLOYEES"
 S Z0=$G(^PRST(455.5,TLI,0)),Z1=$P(Z0,"^",5),Z1=$P($G(^DIC(49,+Z1,0)),"^",1) I $P(Z0,"^",6)'="" S Z1=Z1_", "_$P(Z0,"^",6)
 S Z1=$P(Z0,"^",1)_" "_Z1 W !!?(80-$L(Z1)\2),Z1
 S Z0=$P(PDT,"^",1)_" to "_$P(PDT,"^",14) W !!?(80-$L(Z0)\2),Z0,! Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
