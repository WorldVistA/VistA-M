PRSALVS ;HISC/REL-Display Leave Request ;11/21/06
 ;;4.0;PAID;**9,69,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S DFN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9) I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0))
 I 'DFN W !!,*7,"Your SSN was not found in both the New Person & Employee File!" G EX
 D HDR
 K %DT S %DT="AEX",%DT("A")="Begin with Date: ",%DT("B")="T" W ! D ^%DT K %DT S:$D(DTOUT) Y=0 G:Y<1 EX S EDT=9999999-Y
 W ! S NUM=0 D DISP,H1 G EX
DISP ; Display Leave Requests
 S LVT=";"_$P(^DD(458.1,6,0),"^",3),LVS=";"_$P(^DD(458.1,8,0),"^",3),CNT=0,QT=0 K:NUM R
 F DTI=0:0 S DTI=$O(^PRST(458.1,"AD",DFN,DTI)) Q:DTI=""!(DTI>EDT)  F DA=0:0 S DA=$O(^PRST(458.1,"AD",DFN,DTI,DA)) Q:DA=""  D LST G:QT D0
 W:'CNT !,"No Requests on File."
D0 Q
LST ; Display Request
 S Z=$G(^PRST(458.1,DA,0)) Q:Z=""  Q:$P(Z,"^",9)="X"  S SCOM=$P($G(^(1)),"^",1) I NUM,$P(Z,"^",9)'="R" Q:"D"[$P(Z,"^",9)  D  Q:Z=""
 .S X=$P(Z,"^",3),X=$G(^PRST(458,"AD",+X))
 .S Y=$G(^PRST(458,+$P(X,"^",1),"E",DFN,"D",+$P(X,"^",2),2))
 .Q:Y'[$P(Z,"^",7)  S Z="" Q
 I CNT D:$Y>(IOSL-4) H1 Q:QT
 S CNT=CNT+1 W ! I NUM W $J(CNT,2)," " S R(CNT)=DA
 W $P(Z,"^",4)," " S X=$P(Z,"^",3) D DTP^PRSAPPU W Y," to ",$P(Z,"^",6)," "
 S X=$P(Z,"^",5) D DTP^PRSAPPU W Y," "
 S X=$P(Z,"^",15) I X W X," ",$S($P(Z,"^",16)="D":"days",1:"hrs")," "
 S X=$P(Z,"^",7),%=$F(LVT,";"_X_":") I %>0 W $P($E(LVT,%,999),";",1)," "
 S X=$P(Z,"^",9)
 S %=$F(LVS,";"_X_":") I %>0 W $P($E(LVS,%,999),";",1)
 S X=$P(Z,"^",8) W:X'="" !?5,X S Y=$P(Z,"^",11) D DTP^PRSAUDP W !?5,"Requested: ",Y
 W:SCOM'="" !?5,"Supr: ",SCOM Q
BAL ; Leave Balance
 N CNT,PPE S Z=$P($G(^PRST(458.1,DA,0)),"^",7),(BAL,INC,CNT)="" Q:Z=""
 I "CB AD"[Z N Z S Z="SL"
 Q:"AL SL CU ML RL"'[Z  D ^PRSALVT I NH'=48!(DB'=1) G B0
 I Z="AL" S BAL=$P($G(^PRSPC(DFN,"BAYLOR")),"^",1) G B2
 I Z="SL" S BAL=$P($G(^PRSPC(DFN,"BAYLOR")),"^",13) G B2
 I Z="RL" S BAL=$G(^PRSPC(DFN,"BAYLOR")),BAL=$P(BAL,"^",9)+$P(BAL,"^",10) G B2
 G B1
B0 I Z="AL" S BAL=$P($G(^PRSPC(DFN,"ANNUAL")),"^",3) G B2
 I Z="SL" S BAL=$P($G(^PRSPC(DFN,"SICK")),"^",3) G B2
 I Z="RL" S BAL=$G(^PRSPC(DFN,"ANNUAL")),BAL=$P(BAL,"^",10)+$P(BAL,"^",11) G B2
B1 I Z="ML" S BAL=$P($G(^PRSPC(DFN,"MILITARY")),"^",1) G B2
 Q:Z'="CU"  S Z="CT",Y=$G(^PRSPC(DFN,"COMP"))
 F K=1:1:8 S BAL=BAL+$P(Y,"^",K)
B2 S LST=+$P($G(^PRSPC(DFN,"MISC4")),"^",16),D1=DT D PP^PRSAPPU S YR=$P(PPE,"-",1)
 S D1=+$P(PPE,"-",2),YR=$S(D1'<LST:YR,1:$E(199+YR,2,3)),PPE=YR_"-"_$S(LST>9:LST,1:"0"_LST)
 S PPI=$O(^PRST(458,"B",PPE,0)),SDT=DT I PPI S D1=$P($G(^PRST(458,PPI,2)),"^",14),SDT=$P($G(^(1)),"^",14)
 I PRT W !,Z," Leave Balance: ",$S(Z="ML":$J(BAL,13,2),1:$J(BAL,13,3))," as of ",D1
 I "AL SL"'[Z Q
 S EDT=$P($G(^PRST(458.1,DA,0)),"^",5) I EDT'>SDT G B3
 S X1=EDT,X2=SDT D ^%DTC S INC=X+13\14*$S(Z="AL":AINC,1:SINC)
 I NH=80,DB=2 S X1=EDT,X2=X+13\14*14-X D C^%DTC S INC=INC-$$RT(X,SDT) S:INC<0 INC=0
 I PRT W !,Z," Estimated Earnings: ",$J(INC,8,3)
 S LST=9999999-SDT,CNT=0
 F DTI=0:0 S DTI=$O(^PRST(458.1,"AD",DFN,DTI)) Q:DTI=""!(DTI>LST)  F RDA=0:0 S RDA=$O(^PRST(458.1,"AD",DFN,DTI,RDA)) Q:RDA=""  I $G(^(RDA))'>EDT D
 .S Z1=$G(^PRST(458.1,RDA,0)) S X1=$P(Z1,"^",7) S:"CB AD"[X1 X1="SL" Q:X1'=Z  Q:"AR"'[$P(Z1,"^",9)
 .I NH=72,DB=1 S $P(Z1,U,15)=$$LC($P(Z1,U,15))
 .S CNT=CNT+$P(Z1,"^",15)
 .I $P(Z1,"^",3)'<SDT,$P(Z1,"^",5)'>EDT Q
 .S X1=$P(Z1,"^",5),X2=$P(Z1,"^",3) D ^%DTC S Z3=$P(Z1,"^",15)/$S($G(X):X,1:1)
 .I $P(Z1,"^",3)<SDT S X1=SDT,X2=$P(Z1,"^",3) D ^%DTC  I X>0 S CNT=CNT-(X*Z3)
 .I $P(Z1,"^",5)>EDT S X1=$P(Z1,"^",5),X2=EDT D ^%DTC I X>0 S CNT=CNT-(X*Z3)
 .Q
 I PRT W !,Z," Estimated Usage: ",$J(CNT,11,3)
B3 S BAL=BAL+INC-CNT I PRT W !,Z," Projected Balance: ",$J(BAL,9,3)
 I PRT,BAL<0 W !,"Warning: Approval MAY result in a negative leave balance."
 Q
HDR ; Display Header
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?32,"LEAVE REQUESTS"
 S X=$G(^PRSPC(DFN,0)) W !!,$P(X,"^",1) S X=$P(X,"^",9) I X W ?50,"XXX-XX-",$E(X,6,9) Q
H1 I $E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1 I 'QT W @IOF,!
 Q
EX G KILL^XUSCLEAN
 ;Multiply leave request by 1.111 and round down to the quarter hour
 ;for 36/40 nurses
LC(X) S X=X*1.111\.25*.25 Q X
 ;Calculate number of Recess hours scheduled for a 9-month AWS Nurse 
 ;before the date leave has been requested for
RT(EDT,SDT) N SFY,EFY,T,WK
 S SFY=$E($P($$GETFSCYR^PRSARC04(SDT),U,2),3,6),EFY=$E($P($$GETFSCYR^PRSARC04(EDT),U,2),3,6)
 D RES^PRSARC05(.WK,DFN,SFY,EFY,SDT,EDT) S (I,T)=0 F  S I=$O(WK(I)) Q:I=""  S T=T+WK(I)
 ;Calculate the number of hours of leave that would have been
 ;accumulated for the time the nurse was on recess.
 Q T/80*$S(Z="AL":AINC,1:SINC)\.25*.25
