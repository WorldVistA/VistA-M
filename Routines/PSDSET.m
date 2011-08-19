PSDSET ;BIR/JPW-Check Inpatient Site for CS Use ;6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;**59**;13 Feb 97;Build 1
SITE ;checks for valid cs inpatient site
 K XQUIT,X,PSDA,LOC I '$D(^PS(59.4,"B")) D  G:$G(XQUIT)="" END1 G END
 .W ! K DA,DIC,DIE,DLAYGO,DR S (DIC,DIE,DLAYGO)=59.4,DIC("A")="Enter Controlled Substances Inpatient Site Name: ",DIC(0)="QEAL" D ^DIC K DIC,DLAYGO I Y<0 S XQUIT="" Q
 .S (DA,PSDA)=+Y,DR="31///1" D ^DIE K DIE,DR S PSDSITE=PSDA
LOOP S (CNT,LOC,PSDA)=0 F PSDA=0:0 S PSDA=$O(^PS(59.4,PSDA)) Q:'PSDA  S CNT=CNT+1 S:$P(^PS(59.4,PSDA,0),"^",31) LOC=LOC+1,LOC(+PSDA)=""
CHK I LOC=1 S PSDSITE=+$O(LOC(0)) W !!,"Controlled Substances Inpatient Site Name: "_$P(^PS(59.4,PSDSITE,0),"^")
 I 'LOC,CNT=1 S PSDA=$O(^PS(59.4,0)),$P(^(PSDA,0),"^",31)=1,PSDSITE=+^(0) W !!,"Controlled Substances Inpatient Site Name: "_$P(^(0),"^")
 I CNT>1,LOC'=1 D  G:'$G(PSDSITE) END1
 .K DIC,DLAYGO S (DIC,DLAYGO)=59.4,DIC("A")="Enter Controlled Substances Inpatient Site Name: ",DIC(0)="QEA" S:LOC>1 DIC("S")="I $P(^(0),""^"",31)" S:LOC=0 DIC(0)="QEAL" D ^DIC K DIC,DLAYGO
 .S:Y<0 XQUIT="" Q:Y<0  S $P(^PS(59.4,+Y,0),"^",31)=1,PSDSITE=+Y_"^M"
END K LOC,PSDS,PSDSN,PSDCHO D EN^PSDSP
 I $G(PSDS) S $P(PSDSITE,U,3)=PSDS,$P(PSDSITE,U,4)=$P($G(^PSD(58.8,+PSDS,0)),U),$P(PSDSITE,U,5)=1 Q
 ;Set up Default Dispensing Site
 D:'$P(PSDSITE,U,3)&($P($G(XQY0),U)'["NUR")&($P($G(XQY0),U)'["INS")
 .;Make sure there's at least one Master Vault
 .Q:'$O(^PSD(58.8,"ASITE",+PSDSITE,"M",0))
 .S DIC="^PSD(58.8,",DIC(0)="AEQ"
 .S DIC("A")="Select Default Dispensing Site: "
 .S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$S($P($G(^(0)),U,2)[""M"":1,$P($G(^(0)),U,2)[""S"":1,1:0),$S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0)"
 .W ! D ^DIC K DIC S:$D(DTOUT) XQUIT="" Q:Y<0
 .S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=$P(Y,U,2)
END1 K CNT,DA,DIC,DIE,DLAYGO,DR,DTOUT,DUOUT,LOC,PSDA,PSDS,PSDSN,X,Y
