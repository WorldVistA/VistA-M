PRSAOTR ;HISC/REL-OT/CT Request/Cancel ;12-SEP-00
 ;;4.0;PAID;**2,34,61**;Sep 21, 1995
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX
O1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC G:DFN<1 EX
 D ^PRSAENT S ZENT=$S($E(ENT,12):"OT",1:"")_" "_$S($E(ENT,28):"CT",1:"")
 I ZENT=" " W !!?5,"This Employee is Not Entitled to Either OT or CT/CH" G O1
O2 L +^PRST(458.2,0) K DDSFILE,DA,DR
N1 S DA=$P(^PRST(458.2,0),"^",3)+1 I $D(^PRST(458.2,DA)) S $P(^PRST(458.2,0),"^",3)=DA G N1
 S $P(^PRST(458.2,0),"^",3)=DA,$P(^(0),"^",4)=$P(^(0),"^",4)+1 L -^PRST(458.2,0)
 S ^PRST(458.2,DA,0)=DA_"^"_DFN,^PRST(458.2,"B",DA,DA)="",^PRST(458.2,"C",DFN,DA)=""
 S DDSFILE=458.2,DR="[PRSA OT REQ]" D ^DDS K DS
 S %=$P(^PRST(458.2,DA,0),"^",3) I '% S DIK="^PRST(458.2," D ^DIK K DIK G EX
 D NOW^%DTC S $P(^PRST(458.2,DA,0),"^",8)="R",$P(^(0),"^",11,12)=DUZ_"^"_%,^PRST(458.2,"AR",DFN,DA)=""
 S X=$P($G(^PRSPC(DFN,0)),"^",29) I X S:X>100 X=X/2080 S $P(^PRST(458.2,DA,0),"^",10)=+$J(X*1.5*$P(^PRST(458.2,DA,0),"^",6),0,2)
 D UPD^PRSASAL G O1
CAN ; Cancel OT Request
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX
 K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 I DFN<1 G EX
 D HDR^PRSAOTS
 K %DT S %DT="AEFX",%DT("A")="Begin with Date: ",%DT("B")="T" W ! D ^%DT K %DT S:$D(DTOUT) Y=0 G:Y<1 EX S DTI=Y
 S NUM=1 D DISP^PRSAOTS
 G:'CNT EX
X1 R !!,"Cancel Which Request #? ",X:DTIME G:'$T!("^"[X) EX I X'?1N.N!(X<1)!(X>CNT) W *7," Enter # of Request to Cancel" G X1
 S X=+X,DA=R(X),$P(^PRST(458.2,DA,0),"^",8)="X" K ^PRST(458.2,"AR",DFN,DA),^PRST(458.2,"AS",DFN,DA)
 D UPD^PRSASAL W "  ... done"
EX G KILL^XUSCLEAN
