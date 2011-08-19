PRSALVL ; HISC/REL-Display Leave Requests ;1/24/96  13:56
 ;;4.0;PAID;**9,114**;Sep 21, 1995;Build 6
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
D2 S SRT="E" I DFN<1 R !!,"Sort by: (E=Employee  D=Date) E// ",SRT:DTIME G:'$T!(SRT["^") EX S:SRT="" SRT="E" S SRT=$TR(SRT,"de","DE") I SRT'?1U!("DE"'[SRT) W *7," Enter E or D" G D2
 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S PRSAPGM="Q1^PRSALVL",PRSALST="DFN^TLE^SDT^EDT^SRT" D QUE^PRSAUTL G EX
 U IO D Q1 D ^%ZISC K %ZIS,IOP G EX
Q1 K ^TMP($J) I DFN>0 S NN=$P($G(^PRSPC(DFN,0)),"^",1) D Q2 G P1
 S NN="" F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  D Q2
 G P1
Q2 S LST=9999999-SDT
 F DTI=0:0 S DTI=$O(^PRST(458.1,"AD",DFN,DTI)) Q:DTI=""!(DTI>LST)  F DA=0:0 S DA=$O(^PRST(458.1,"AD",DFN,DTI,DA)) Q:DA=""  I $G(^(DA))'>EDT D Q3
 Q
Q3 I $P($G(^PRST(458.1,DA,0)),"^",9)="X" Q
 S Z=$P($G(^PRST(458.1,DA,0)),"^",3) I SRT="E" S ^TMP($J,NN_"~"_DFN,+Z,DA)="" Q
 S ^TMP($J,+Z,NN_"~"_DFN,DA)="" Q
P1 S (PG,QT)=0 D HDR S LVT=";"_$P(^DD(458.1,6,0),"^",3),LVS=";"_$P(^DD(458.1,8,0),"^",3)
 S N1="" F  S N1=$O(^TMP($J,N1)) Q:N1=""  S HDR=0,N2="" F  S N2=$O(^TMP($J,N1,N2)) Q:N2=""  F DA=0:0 S DA=$O(^TMP($J,N1,N2,DA)) Q:DA=""  D LST G:QT EX
 D H1 G EX
LST ; Display Request
 S DFN=$P($S(SRT="E":N1,1:N2),"~",2),Y0=$G(^PRSPC(DFN,0)) I HDR G:$Y'>(IOSL-3) L1 D HDR Q:QT
 D:$Y>(IOSL-6) HDR Q:QT  S HDR=1
 I SRT="E" W !!,$P(Y0,"^",1) S X=$P(Y0,"^",9) D  G L1
 . I PRSTLV=2!(PRSTLV=3) W ?50,$E(X),"XX-XX-",$E(X,6,9)
 . I PRSTLV=7 W ?50,$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9)
 S X=N1 D DTP W !!,Y
L1 ; List item
 S Z=$G(^PRST(458.1,DA,0)) Q:Z=""  S SCOM=$P($G(^(1)),"^",1)
 I SRT="D" W !?3,$P(Y0,"^",1)," ",$P(Z,"^",4)
 E  W !?3,$P(Z,"^",4)," " S X=$P(Z,"^",3) D DTP W Y
 W " to ",$P(Z,"^",6)," " S X=$P(Z,"^",5) D DTP W Y," "
 I SRT="E" S X=$P(Z,"^",15) I X W X," ",$S($P(Z,"^",16)="D":"days",1:"hrs")," "
 S X=$P(Z,"^",7),%=$F(LVT,";"_X_":") I %>0 W $P($E(LVT,%,999),";",1)," "
 S X=$P(Z,"^",9)
 S %=$F(LVS,";"_X_":") I %>0 W $P($E(LVS,%,999),";",1)
 S X=$P(Z,"^",8) W:X'="" !?5,X S Y=$P(Z,"^",11) D DTP^PRSAUDP W !?5,"Requested: ",Y
 W:SCOM'="" !?5,"Supr: ",SCOM Q
DTP ; Printable Date
 S Y=$J(+$E(X,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(X,4,5))_"-"_$E(X,2,3)
 Q
HDR ; Display Header
 D H1 Q:QT  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1,HDR=0 W !?26,"VA TIME & ATTENDANCE SYSTEM",?72,"Page ",PG
 W !?28,"T&L ",TLE," LEAVE REQUESTS"
 S X=SDT D DTP W !!?27,"From ",Y S X=EDT D DTP W " to ",Y Q
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX G KILL^XUSCLEAN
