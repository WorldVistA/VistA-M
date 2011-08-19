PRSAOTX ; HISC/REL-OT/CT Approvals ;5/23/95  12:55
 ;;4.0;PAID;**34,114,110**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S (QT,NF)=0,PRSTLV=3 K ^TMP($J)
 S TLE="" F  S TLE=$O(^PRST(455.5,"B",TLE)) Q:TLE=""  S TLH=0 F TLI=0:0 S TLI=$O(^PRST(455.5,"B",TLE,TLI)) Q:TLI<1  I $D(^PRST(455.5,TLI,"A",DUZ)) D TLC I QT G ES
ES I '$D(^TMP($J)) W !!,$S('NF:"No Overtime or Comp/Credit actions to certify.",1:"No Overtime or Comp/Credit certification actions taken.") G EX
 D ^PRSAES G:'ESOK EX D NOW^%DTC S NOW=%
 F TLI=0:0 S TLI=$O(^TMP($J,TLI)) Q:TLI<1  S ACT=$G(^(TLI)) I ACT'="" F DA=0:0 S DA=$O(^TMP($J,TLI,DA)) Q:DA<1  S DFN=$G(^(DA)) D OT
 G EX
TLC ; Check T&L
 S (ECST,NUM)=0 K R
 S NN="" F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  I $D(^PRST(458.2,"AS",DFN)) D CHK I QT G T1
 Q:'$D(^TMP($J,TLI))  I ECST W !!,"Estimated Cost of Overtime: $",$J(ECST,0,2)
OK R !!,"Disposition (A=Approve, D=Disapprove, X=Dis. Line Item, RETURN to bypass): ",ACT:DTIME S:'$T!(ACT["^") QT=1 G:QT!(ACT="") T1 S ACT=$TR(ACT,"adx","ADX") I ACT'?1U!("ADX"'[ACT) W *7,!,"Enter A, D or X or Press RETURN to bypass" G OK
 I ACT="X" D CAN G:Y["^" T1 S ACT="A"
 S ^TMP($J,TLI)=ACT Q
T1 K ^TMP($J,TLI) Q
CHK ; Check for needed approvals
 F DA=0:0 S DA=$O(^PRST(458.2,"AS",DFN,DA)) Q:DA<1  D LST Q:QT  S ^TMP($J,TLI,DA)=DFN
 Q
OT ; Process action
 S X=ESNAM,X1=DUZ,X2=DA D EN^XUSHSHP
 S $P(^PRST(458.2,DA,0),"^",8)=$S($P(DFN,"^",2)="D":"D",1:ACT) K ^PRST(458.2,"AS",+DFN,DA)
 S $P(^PRST(458.2,DA,0),"^",16,18)=DUZ_"^"_NOW_"^"_X Q
LST ; Display Request
 S Z=$G(^PRST(458.2,DA,0)) Q:Z=""  D:'TLH HDR D:$Y>(IOSL-4) HDR Q:QT
 S NUM=NUM+1,X=$P(Z,"^",3) D DTP^PRSAPPU S R(NUM)=DA
 W !,$J(NUM,2)," ",Y," ",$P($G(^PRSPC(DFN,0)),"^",1),?42,$P(Z,"^",6)," Hrs. ",$S($P(Z,"^",5)="CT":"COMP TIME/CREDIT HRS",1:"OVERTIME")
 I $P(Z,"^",5)="OT",$P(Z,"^",10) S ECST=ECST+$P(Z,"^",10)
 S X=$P(Z,"^",9) I X'="" W " on T&L ",X
 S Y=$P(Z,"^",7) W:Y'="" !?10,Y S NF=NF+1 Q
HDR ; Display Header
 I TLH R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1 Q:QT
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?21,"OVERTIME & COMP TIME/CREDIT HRS APPROVAL"
 S Z0=$G(^PRST(455.5,TLI,0)),Z1=$P(Z0,"^",5),Z1=$P($G(^DIC(49,+Z1,0)),"^",1) I $P(Z0,"^",6)'="" S Z1=Z1_", "_$P(Z0,"^",6)
 S Z1=$P(Z0,"^",1)_" "_Z1 W !!?(80-$L(Z1)\2),Z1,! S TLH=1 Q
CAN ; Process selective disapproval
 R !,"Disapprove which Items: ",Y:DTIME I '$T!(Y["^") S K1=0 Q
 F K=1:1 S K1=$P(Y,",",K) Q:K1=""  S K2=$S(K1["-":$P(K1,"-",2),1:+K1),K1=+K1 D  G:'K1 CAN F K3=K1:1:K2 S DA=$G(R(K3)) I DA S $P(^TMP($J,TLI,DA),"^",2)="D"
 .I K1'<1,K1'>NUM,K1?1N.N Q
 .I K2'<1,K2'>NUM,K2?1N.N Q
 .W *7,!,"  Enter Numbers, or Range of Items (e.g., 1,3-5,7)"
 .S K1=0 Q
 Q
EX F TLI=0:0 S TLI=$O(^TMP($J,TLI)) Q:TLI<1  S TLE=$P($G(^PRST(455.5,TLI,0)),"^",1) D APP^PRSASAL
 G ^PRSAPPX
