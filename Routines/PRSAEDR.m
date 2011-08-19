PRSAEDR ;HISC/REL-Environmental Diff. Requests ;12-SEP-00
 ;;4.0;PAID;**61**;Sep 21, 1995
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX
E1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC G:DFN<1 EX
 D ^PRSAENT I $E(ENT,15,16)'["1" W !!?5,"This employee is not entitled to Hazard or Environment Differential" G E1
 S ZENT=$S($E(ENT,15):"H",$E(ENT,16):"E",1:"")
 L +^PRST(458.3,0) K DDSFILE,DA,DR
N1 S DA=$P(^PRST(458.3,0),"^",3)+1 I $D(^PRST(458.3,DA)) S $P(^PRST(458.3,0),"^",3)=DA G N1
 S $P(^PRST(458.3,0),"^",3)=DA,$P(^(0),"^",4)=$P(^(0),"^",4)+1 L -^PRST(458.3,0)
 S ^PRST(458.3,DA,0)=DA_"^"_DFN,^PRST(458.3,"B",DA,DA)="",^PRST(458.3,"C",DFN,DA)=""
 S DDSFILE=458.3,DR="[PRSA ED REQ]" D ^DDS K DS
 S %=$P(^PRST(458.3,DA,0),"^",3) I '% S DIK="^PRST(458.3," D ^DIK K DIK G EX
 D NOW^%DTC S $P(^PRST(458.3,DA,0),"^",9,11)="R^"_DUZ_"^"_%,^PRST(458.3,"AR",DFN,DA)=""
 D UPD^PRSASAL G EX
VAL ; Validate request
 Q:'$D(Z1)  S X=$P(Z1,"^",2)_"^"_$P(Z1,"^",4) D CNV^PRSATIM
 S Z2=$P(Y,"^",1),Z4=$P(Y,"^",2)
 I Z2'<Z4 S STR="Start time must be less than ending time." G V1
 I Z4-Z2-$P(Z1,"^",3)'>0 S STR="Total time (End-Start-Meal) is not greater than 0." G V1
 I '$D(^PRST(458,"AD",+$P(Z1,"^",1))) S STR="Pay Period not established for that date." G V1
 Q
V1 S DDSERROR=1 D HLP^DDSUTL(.STR) Q
CAN ; Cancel ED Request
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX
 K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 I DFN<1 G EX
 D HDR^PRSAEDS
 K %DT S %DT="AEPX",%DT("A")="Begin with Date: ",%DT("B")="T",%DT(0)=-DT W ! D ^%DT K %DT S:$D(DTOUT) Y=0 G:Y<1 EX S EDT=9999999-Y
 W ! S NUM=1 D DISP^PRSAEDS
 G:'CNT EX
X1 R !!,"Cancel Which Request #? ",X:DTIME G:'$T!("^"[X) EX I X'?1N.N!(X<1)!(X>CNT) W *7," Enter # of Request to Cancel" G X1
 S X=+X,DA=R(X),$P(^PRST(458.3,DA,0),"^",9)="X" K ^PRST(458.3,"AR",DFN,DA)
 D UPD^PRSASAL W "  ... done"
EX G KILL^XUSCLEAN
