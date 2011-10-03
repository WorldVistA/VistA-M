PSDNDES ;BIR/JPW-Dispense from Pharmacy w/o Green Sheet ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**69**;13 Feb 97;Build 13
 ;References to ^PSD(58.8, supported by DBIA2711
 ;References to ^PSDRUG( supported by DBIA #221
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)),'$D(^XUSEC("PSD TECH ADV",DUZ)) W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"dispense narcotic supplies.  PSJ RPHARM or PSD TECH ADV",!?12,"security key required.",! Q
 S PSDUZ=DUZ,PSDUZN=$P($G(^VA(200,PSDUZ,0)),"^")
TEST ;to be reworked for narcotic disp equipment
 W !!,"For now this option is the same as dispense w/o green sheet.",!!
ASKD ;ask disp loc
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 I $P(PSDSITE,U,5) S ASK=$P($G(^PSD(58.8,+PSDS,0)),U,5) G CHKD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),ASK=$P(Y(0),"^",5)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.8,PSDS,1,0)) W !!,"There are no stocked drugs for this Pharmacy Vault!!",!! G END
DRUG ;select drug
 S PSDOUT=0 W !
 K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDS,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***"""
 S DA(1)=+PSDS,DIC(0)="QEAMZ",DIC="^PSD(58.8,"_PSDS_",1," D ^DIC K DIC G:Y<0 END S PSDR=+Y,PSDRN=$P($G(^PSDRUG(+PSDR,0)),"^")
 I '$D(^PSD(58.8,+PSDS,1,+PSDR,0)) W $C(7),!!,?10,"** Your Dispensing Site is missing stock drug data.",!,"Please contact your Pharmacy Coordinator for assistance.",! G END
 S (MFG,LOT,EXP,EXPD,NBKU,NPKG)="",MFG=$P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",10),LOT=$P(^(0),"^",11),EXP=$P(^(0),"^",12),NBKU=$P(^(0),"^",8),NPKG=$P(^(0),"^",9)
 I 'NPKG!(NBKU']"") W $C(7),!!,PSDRN," is missing breakdown unit or",!,"package size data in ",PSDSN,"." D MSG G END
 I EXP S Y=EXP X ^DD("DD") S EXPD=Y
 S NBKU=$P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",8),NPKG=+$P(^(0),"^",9)
 I NBKU']"" W !!,PSDSN,"is missing narcotic breakdown unit",!,"for ",PSDRN,"." G END
 I 'NPKG W !!,PSDSN,"is missing narcotic package size",!,"for ",PSDRN,"." G END
NAOU ;select NAOU
 K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"""
 D ^DIC K DIC G:Y<0 END S NAOU=+Y,NAOUN=$P(Y,"^",2)
QTY K DA,DIR,DIRUT S DIR(0)="58.85,18O",DIR("B")=NPKG,DIR("A")="QUANTITY DISPENSED ("_NBKU_"/"_NPKG_")" D ^DIR K DIR I 'Y!$D(DIRUT) D MSG G END
 S QTY=+Y I QTY>+$P(^PSD(58.8,PSDS,1,PSDR,0),"^",4) W !!,"The drug balance for this drug is ",+$P(^PSD(58.8,PSDS,1,PSDR,0),"^",4),".",!,"You cannot dispense ",QTY," for this drug.",!! G END
ASKM I ASK D MFG I PSDOUT D MSG G END
OK W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK? ",DIR("?",1)="Answer 'YES' to record dispensing this drug,"
 S DIR("?")="NO to select another drug or '^' to quit." D ^DIR K DIR
 I $D(DIRUT) D MSG G END
 I 'Y D MSG G DRUG
 D ^PSDDFP1 G:'PSDOUT DRUG
END K %,%DT,%H,%I,ASK,BAL,DA,DIC,DIE,DIK,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,EDIT,EXP,EXPD,LOT,MFG,NAOU,NAOUN,NBKU,NPKG,OK
 K PSDDT,PSDLES,PSDOUT,PSDR,PSDREC,PSDRN,PSDS,PSDSN,PSDUZ,PSDUZN,QTY,TEXP,TLOT,TMFG,X,Y
 Q
MFG K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,12O",DIR("B")=MFG D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 Q
 I Y]"",Y'=MFG S MFG=Y S $P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",10)=MFG
 K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,13O",DIR("B")=LOT D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 Q
 I Y]"",Y'=LOT S LOT=Y S $P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",11)=LOT
 K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,14O",DIR("B")=EXPD D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S PSDOUT=1 Q
 I Y,Y'=EXP S EXP=Y W !!,"Updating Expiration Date data..." K DA,DIE,DR S DA=+PSDR,DA(1)=+PSDS,DIE="^PSD(58.8,"_DA(1)_",1,",DR="11///"_EXP D ^DIE K DA,DIE,DR W "done.",!!
 Q
MSG W !!,"** No action taken. **",!!
 Q
