PSDDFP1 ;BIR/JPW-Disp from Pharm w/o Green Sheet (cont'd) ; 2 Aug 93
 ;;3.0; CONTROLLED SUBSTANCES ;**16,66**;13 Feb 97;Build 3
 ;
 ;References to ^PSD(58.8, supported by DBIA2711
 ;References to ^PSD(58.81 are supported by DBIA2808
TRANS ;create a disp transaction
 W !!,"Creating a dispensing transaction..."
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDREC=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDREC)) S $P(^PSD(58.81,0),"^",3)=PSDREC G FIND
 K DA,DIC,DLAYGO S DIC(0)="L",(DIC,DLAYGO)=58.81,(X,DINUM)=PSDREC D ^DIC K DIC,DLAYGO
 L -^PSD(58.81,0)
ADD ;add info to your vault (58.8)
 W "vault activity" S:'$D(^PSD(58.8,PSDS,1,PSDR,4,0)) ^(0)="^58.800119PA^^"
 K DA,DIC,DD,DO S DIC(0)="L",DIC="^PSD(58.8,"_PSDS_",1,"_PSDR_",4,",DA(2)=PSDS,DA(1)=PSDR,(X,DINUM)=PSDREC D FILE^DICN K DIC,DD,DO
 ;monthly activity
 I '$D(^PSD(58.8,PSDS,1,PSDR,5,0)) S ^(0)="^58.801A^^"
 I '$D(^PSD(58.8,PSDS,1,PSDR,5,$E(DT,1,5)*100,0)) K DIC S DIC="^PSD(58.8,"_PSDS_",1,"_PSDR_",5,",DIC(0)="LM",DLAYGO=58.8,(X,DINUM)=$E(DT,1,5)*100,DA(2)=PSDS,DA(1)=PSDR D ^DIC K DIC,DA,DINUM,DLAYGO
 K DA,DIE,DR S DIE="^PSD(58.8,"_PSDS_",1,"_PSDR_",5,",DA(2)=PSDS,DA(1)=PSDR,DA=$E(DT,1,5)*100,DR="9////^S X=$P($G(^(0)),""^"",6)+QTY" D ^DIE K DA,DIE,DR
UPDATE ;update transaction with activity # from 58.8
 W !!,?5,"Updating on-hand quantity..."
 ;
 ;DAVE B (PSD*3*16 -28APR99) Removed lock, because it is now
 ;in routine PSDDFP where the user selects the drug.
 ;F  L +^PSD(58.8,PSDS,1,PSDR,0):0 I  Q
 D NOW^%DTC S PSDDT=+%
 S BAL=$P(^PSD(58.8,PSDS,1,PSDR,0),"^",4),$P(^(0),"^",4)=$P(^(0),"^",4)-QTY
 L -^PSD(58.8,PSDS,1,PSDR,0) S $P(^PSD(58.81,PSDREC,0),"^",10)=BAL W "done.",!
 W !!,"Old Balance : ",BAL,?35,"New Balance: ",BAL-QTY
 W !!,"Updating your transaction history..."
 K DA,DIE,DR S DA=PSDREC,DIE=58.81
 S DR="1////2;2////"_PSDS_";4////"_PSDR_";3////"_PSDDT_";5////"_QTY_";9////"_BAL_";6////"_PSDUZ_";17////"_NAOU_";100////1" D ^DIE
 I ASK W "still updating..." K DR S DR="12///"_MFG_";13///"_LOT_";14///"_EXP D ^DIE
 K DA,DIE,DR W "done.",!!
END Q
