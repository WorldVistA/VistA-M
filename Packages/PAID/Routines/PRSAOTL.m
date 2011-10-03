PRSAOTL ; HISC/REL-List OT Requests ;5/24/95  16:28
 ;;4.0;PAID;**34,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
TK ; TimeKeeper Entry
 S PRSTLV=2 G TL
SUP ; Supervisor Entry
 S PRSTLV=3 G TL
PAY ; Payroll Entry
 S PRSTLV=7 G TL
TL D ^PRSAUTL G:TLI<1 EX
 K DIC S DIC("A")="Select EMPLOYEE (or RETURN for all): ",DIC("S")="I $P(^(0),""^"",8)=TLE",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 G:$D(DTOUT) EX I DFN<1,X'="" G EX
D1 K %DT S %DT="AEX",%DT("A")="Begin with Date: " W ! D ^%DT K %DT S:$D(DTOUT) Y=0 G:Y<1 EX S SDT=Y
 K %DT S %DT="AEX",%DT("A")="End with Date: " W ! D ^%DT K %DT S:$D(DTOUT) Y=0 G:Y<1 EX S EDT=Y
 I SDT>EDT W *7,!?5,"Starting Date cannot be later than Ending Date!" G D1
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSAOTL",PRSALST="DFN^TLE^SDT^EDT" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 S (PG,CNT,QT)=0 D HDR S OTS=";"_$P(^DD(458.2,10,0),"^",3)
 I DFN>0 D Q3,CK,H1 Q
 S NN="" F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  S HDR=0 D Q3 G:QT Q2
 D CK,H1
Q2 Q
Q3 F DTI=SDT-.1:0 S DTI=$O(^PRST(458.2,"AD",DFN,DTI)) Q:DTI=""!(DTI>EDT)  F DA=0:0 S DA=$O(^PRST(458.2,"AD",DFN,DTI,DA)) Q:DA=""  D LST G:QT Q4
Q4 Q
CK W:'CNT !!,"No Overtime or CompTime/CreditHrs Requests found for this period." Q
LST ; Display Request
 D:$Y>(IOSL-3) HDR Q:QT
 I 'HDR D:$Y>(IOSL-7) HDR Q:QT  S X=$G(^PRSPC(DFN,0)) W !!,$P(X,"^",1) S X=$P(X,"^",9) D
 . I X,PRSTLV=2!(PRSTLV=3) W ?50,$E(X),"XX-XX-",$E(X,6,9)
 . I X,PRSTLV=7 W ?50,$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9)
 . S HDR=1
L1 ; List item
 S Z=$G(^PRST(458.2,DA,0)) Q:Z=""  S SCOM=$P($G(^(1)),"^",1),CNT=CNT+1
 S X=$P(Z,"^",3) D DTP W !?3,Y,"   ",$P(Z,"^",6)," Hrs. ",$S($P(Z,"^",5)="CT":"COMP TIME/CREDIT HRS",1:"OVERTIME")
 I PRSTLV=3,$P(Z,"^",5)="OT",$P(Z,"^",10) W " ($",$J($P(Z,"^",10),0,2),")"
 S X=$P(Z,"^",9) I X'="" W " on T&L ",X
 S X=$P(Z,"^",8),%=$F(OTS,";"_X_":") I %>0 W " ",$P($E(OTS,%,999),";",1)
 S Y=$P(Z,"^",7) W:Y'="" !?10,Y W:SCOM'="" !?10,"Supr: ",SCOM Q
DTP ; Printable Date
 S Y=$J(+$E(X,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(X,4,5))_"-"_$E(X,2,3)
 Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1,HDR=0 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !?25,"T&L ",TLE," OT and CT/CH REQUESTS"
 S X=SDT D DTP W !!?27,"From ",Y S X=EDT D DTP W " to ",Y Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
