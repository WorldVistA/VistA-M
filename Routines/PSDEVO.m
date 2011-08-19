PSDEVO ;BIR/JPW,BJW-Edit/Cancel a Verified Order ; 20 Aug 98
 ;;3.0; CONTROLLED SUBSTANCES ;**10,66**;13 Feb 97;Build 3
 ;nois:mar-1297-21575
EN ;entry for edit/cancel verified order
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)) W !!,"Contact your Pharmacy Coordinator for access to edit or cancel",!,"a verified Controlled Substances order.",!!,"PSJ RPHARM security key required.",! G END
 S PSDUZ=DUZ
 W $C(7),!!,?18,"*** NOTE ***",!,?5,"Only Verified Orders with a status of FILLED - NOT DELIVERED",!,?5,"may be edited or cancelled.",!!
ASKD ;ask disp site
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) GS
 K DA,DIC S DIC=58.8,DIC("A")="Select Dispensing Site: ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)=""M"":1,$P(^(0),""^"",2)=""S"":1,1:0)"
 S DIC(0)="QEA",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
GS ;ask gs #
 K DA,DIC,NQTY S DIC=58.81,DIC("A")="Select Green Sheet #: ",DIC(0)="QEASZ",D="D"
 S DIC("S")="I $P(^(0),""^"",3)=+PSDS,$P(^(0),""^"",11)=3"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y,QTY=$P(Y(0),"^",6),PSDPN=$P(Y(0),"^",17),PSDR=$P(Y(0),"^",5),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^"),ORD=$P(Y(0),"^",20),NAOU=$P(Y(0),"^",18)
 I '$D(^PSD(58.8,+PSDS,1,PSDR,0)) W !!,PSDRN," is not stocked in ",PSDSN,!! D MSG G END
 S NBKU=$P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",8),NPKG=$P(^(0),"^",9)
 I 'NPKG!(NBKU']"") W !!,PSDRN," is missing breakdown unit or ",!,"package size data in ",PSDSN,".",!! D MSG G END
 I $D(^PSD(58.81,PSDA,4)),+$P(^(4),"^",3) S NQTY=$P(^(4),"^",3)
 W !!,"Drug: ",PSDRN,!,"     Quantity: ",$S($D(NQTY):NQTY,1:QTY),"    Breakdown Unit: ",NBKU,!!
ASK ;edit or cancel
 K DA,DIR,DIRUT S DIR("A")="ACTION (DC E): ",DIR(0)="SOBA^E:EDIT;DC:CANCEL"
 S DIR("?",1)="Select 'E' to Edit this verified order, 'DC' to cancel",DIR("?")="or '^' to quit."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 S ANS=Y I ANS="DC" D CANC G END
 I ANS="E" D ^PSDEVO1
END K %,%DT,%H,%I,ANS,AQTY,BAL,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,EXP,FIELD,LOT,MFG,NAOU,NAOUN,NBKU,NPKG,NQTY,OK,ORD,OREC
 K PSDA,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDSN,PSDT,PSDUZ,QTY,RECD,RECDT,RQTY,STAT,STATN,SUB,WK,X,Y
 Q
CANC ;canc ver ord
 W !!,"Green Sheet # ",PSDPN,"  Quantity Dispensed: ",$S($D(NQTY):NQTY,1:QTY),"   Breakdown Unit: ",NBKU,!
 K DA,DIR,DIRUT S DIR(0)="YOA",DIR("?",1)="Answer 'YES' to cancel this order and add the quantity",DIR("?")="back to your vault balance or '^' to quit."
 S DIR("A")="Are you sure? " D ^DIR K DIR I $D(DIRUT) D MSG S PSDOUT=1 Q
 I 'Y D MSG S PSDOUT=1 Q
 S AQTY=$S($D(NQTY):NQTY,1:QTY)
 W !!,"Accessing your transaction history..."
 F  L +^PSD(58.8,+PSDS,1,+PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDT=+%
 S BAL=$P(^PSD(58.8,+PSDS,1,+PSDR,0),"^",4),$P(^(0),"^",4)=$P(^(0),"^",4)+AQTY
 L -^PSD(58.8,+PSDS,1,+PSDR,0) W !!,"Old Balance: ",BAL,?35,"New Balance :",BAL+AQTY,!!
 W !!,"Updating your transaction history now..."
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="10////9;55////"_PSDT_";56////"_PSDUZ_";57///"_AQTY_";59////"_BAL_";58" D ^DIE K DA,DIE,DR
 W !!,"Order record..." K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////9;19////@" D ^DIE K DA,DIE,DR
 I +$O(^PSD(58.85,"AD",NAOU,PSDR,ORD,0)) W "worksheet..." S DA=+$O(^PSD(58.85,"AD",NAOU,PSDR,ORD,0)),DIE=58.85,DR="6////9" D ^DIE K DIE,DA,DR
 ;Betty I'm commenting out the following line like we discussed
 ;I $D(^PSD(58.8,NAOU,1,PSDR,0)) S $P(^(0),"^",4)=$P(^(0),"^",4)-AQTY
MON ;monthly activity
 I '$D(^PSD(58.8,+PSDS,1,PSDR,5,0)) S ^(0)="^58.801A^^"
 I '$D(^PSD(58.8,+PSDS,1,PSDR,5,$E(DT,1,5)*100,0)) K DIC S DIC="^PSD(58.8,"_+PSDS_",1,"_PSDR_",5,",DIC(0)="LM",DLAYGO=58.8,(X,DINUM)=$E(DT,1,5)*100,DA(2)=+PSDS,DA(1)=PSDR D ^DIC K DIC,DA,DINUM,DLAYGO
 K DA,DIE,DR S DIE="^PSD(58.8,"_+PSDS_",1,"_PSDR_",5,",DA(2)=+PSDS,DA(1)=PSDR,DA=$E(DT,1,5)*100,DR="11////^S X=$P($G(^(0)),""^"",7)+QTY" D ^DIE K DA,DIE,DR
 W !!,"Finished.  Your Green Sheet # ",PSDPN," has been cancelled.",!!
 Q
MSG W !!,"** No action taken. **",!!
 Q
