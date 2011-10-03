PSDEXGS ;BIR/BJW-Enter Existing Green Sheets at Startup ; 10 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,33,71**;13 Feb 97;Build 29
 ;**Y2K compliance**,added a "P" to date input string in ^DD(58.81,19)
 ;Reference to ^PSD(58.8 are covered by DBIA #2711
 ;Reference to ^PSD(58.81 are covered by DBIA #2808
 ;Reference to ^PSDRUG( are covered by DBIA #221
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH ADV",DUZ))) D  Q
 .W !!,"Contact your Pharmacy Coordinator for access to enter existing Green Sheets",!,"into the Controlled Substances package.",!!,"PSJ RPHARM or PSD TECH ADV security key required.",!
 S PSDUZ=DUZ
 W !!,?5,"The Order Status of all Green Sheets entered as existing before",!,?5,"the Controlled Substances package initialization will be",!,?10,"  *** DELIVERED - ACTIVELY ON NAOU ***",!!
ASKD ;ask disp site
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$D(^PSD(58.8,+PSDS,0)) W !!,"The ",PSDSN," vault is missing data.",!! G END
NAOU ;select NAOU 
 K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU: "
 S DIC("S")="I $P(^(0),""^"",4)=+PSDS,$P(^(0),""^"",2)=""N"""
 D ^DIC K DIC G:Y<0 END S NAOU=+Y,NAOUN=$P(Y,"^",2)
 I '$D(^PSD(58.8,NAOU,0)) W !!,"This NAOU is missing data.",!! G END
DRUG ;ask drug
 I '$O(^PSD(58.8,NAOU,1,0)) W !!,"There are no stocked drugs for this NAOU.",!! G END
 W !!,?15,"=> NAOU: ",NAOUN,!
 K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,NAOU,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""  *** INACTIVE ***"""
 S DIC("S")="I $S('$P(^(0),""^"",14):1,+$P(^(0),""^"",14)>DT:1,1:0)"
 S DA(1)=+NAOU,DIC(0)="QEAM",DIC="^PSD(58.8,"_+NAOU_",1," D ^DIC K DIC G:Y<0 END S PSDRG=+Y,PSDRGN=$S($P($G(^PSDRUG(PSDRG,0)),"^")]"":$P(^(0),"^"),1:"DRUG NAME MISSING")
 I '$D(^PSD(58.8,NAOU,1,PSDRG,0)) W !!,PSDRGN," is missing",!,"data in ",NAOUN G END
 I '$D(^PSD(58.8,+PSDS,1,PSDRG,0)) W !!,PSDRGN," is not stocked",!,"in ",PSDSN,!! G END
 S NBKU=$P(^PSD(58.8,+PSDS,1,PSDRG,0),"^",8),NPKG=+$P(^(0),"^",9)
 I 'NPKG!(NBKU']"") W $C(7),!!,PSDRGN," is missing breakdown unit or",!,"package size in ",PSDSN,".",! G END
GS W !!,"Enter Green Sheet #: " R X:DTIME I '$T!(X="")!(X["^") W !!,"** No action taken. **" G END
 I X'?1.9N D MSG1 G GS
 I 'X D MSG1 G GS
 I +$O(^PSD(58.81,"D",X,0)) W !!,"This number has already been used.",!! G GS
 S PSDPN=X K X
QTY W !!,"Enter Quantity ("_NBKU_"/"_NPKG_"): " R X:DTIME I '$T!(X="")!(X["^") D MSG G END
 I X'?1.6N D MSG2 G QTY
 I 'X D MSG2 G QTY
 S QTY=X K X
PHARM K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,18O" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S PHARM=$P(Y,"^")
RDATE K DA,DIR,DTOUT,DUOUT S DIR("A")="DISPENSED DATE: ",DIR(0)="58.81,19OA" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S RDATE=$P(Y,"^")
NURSE K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,20O" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S NURS=$P(Y,"^")
MFG K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,12O" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S MFG=Y
LOT K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,13O" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S LOT=Y
EXP K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,14O" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S EXP=Y
 ;DAVE B (PSD*3*33) add PRINTED 2638 field
PNT10 K DA,DIR,DTOUT,DUOUT S DIR(0)="58.81,103" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) D MSG G END
 S PNT10=Y
OK W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK"
 S DIR("?",1)="Answer 'YES' to post this Green Sheet information,",DIR("?")="answer 'NO' to erase this information and try again."
 D ^DIR K DIR G:$D(DIRUT) END
 I 'Y G QTY
 D ^PSDEXGS1 G DRUG
END K %,%DT,%H,%I,DA,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,EXP,LOT,MFG
 K NAOU,NAOUN,NBKU,NPKG,NURS,PHARM,PSDA,PSDPN,PSDRG,PSDRGN,PSDRN,PSDS,PSDSN,PSDT,PSDUZ,RDATE,QTY,X,Y
 Q
MSG W !!,"No action taken.  The Green Sheet # ",PSDPN," has not been added to your CS files.",!
 Q
MSG1 W !!,"You must enter a whole number between 1 and 999999999",!
 Q
MSG2 W !!,"You must enter a whole number between 1 and 999999",!
 Q
