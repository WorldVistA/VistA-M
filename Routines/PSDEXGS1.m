PSDEXGS1 ;BIR/JPW-Enter Existing GS (cont'd) ; 22 Jun 93
 ;;3.0; CONTROLLED SUBSTANCES ;**33,66**;13 Feb 97;Build 3
 ;Reference to ^PSD(58.8 are covered by DBIA #2711
 ;Reference to ^PSD(58.81 are covered by DBIA #2808
EN ;create order,transaction
 W !!,"Creating entries in the CS files..."
DIE ;create the order request
 S:'$D(^PSD(58.8,NAOU,1,PSDRG,3,0)) ^(0)="^58.800118A^^"
 S PSDRN=$P(^PSD(58.8,NAOU,1,PSDRG,3,0),"^",3)+1 I $D(^PSD(58.8,NAOU,1,PSDRG,3,PSDRN)) S $P(^PSD(58.8,NAOU,1,PSDRG,3,0),"^",3)=$P(^PSD(58.8,NAOU,1,PSDRG,3,0),"^",3)+1 G DIE
 K DA,DIC,DIE,DD,DR,DO S DIC(0)="L",(DIC,DIE)="^PSD(58.8,"_NAOU_",1,"_PSDRG_",3,",DA(2)=NAOU,DA(1)=PSDRG,(X,DINUM)=PSDRN D FILE^DICN K DIC
 D NOW^%DTC S PSDT=+$E(%,1,12) W "processing now..."
 S DA=PSDRN,DA(1)=PSDRG,DA(2)=NAOU
 S DR="2////"_+PSDS_";4////"_PHARM_";5///"_QTY_";6////"_NURS_";7///"_MFG_";8///"_LOT_";9///"_EXP_";14///"_RDATE_";16///"_PSDPN_";19///"_QTY_";20///"_QTY_";10////4" D ^DIE K DIE,DR
 W "transaction history..."
ADD ;find entry number
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDA=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDA)) S $P(^PSD(58.81,0),"^",3)=PSDA G FIND
 K DA,DIC,DLAYGO S DIC(0)="L",(DIC,DLAYGO)=58.81,(X,DINUM)=PSDA D ^DIC K DIC,DLAYGO
 L -^PSD(58.81,0)
TRANS ;add trans fields
 W !!,"Still updating..."
 K DA,DIE,DR S DA=PSDA,DIE=58.81
 S DR="1////12;2////"_+PSDS_";4////"_PSDRG_";3///"_PSDT_";Q;5////"_QTY_";12///"_MFG_";13///"_LOT_";14///"_EXP_";16///"_PSDPN_";17////"_NAOU_";18////"_PHARM_";20////"_NURS_";19///"_RDATE_";27////"_QTY_";40////"_PSDRN_";10////4;100////1"
 ;DAVE B (PSD*3*33) Add field 103 to DIE call
 S DR=DR_";103////"_PNT10
 D ^DIE K DA,DIE,DR W "vault activity..."
VAULT ;
 S:'$D(^PSD(58.8,+PSDS,1,PSDRG,4,0)) ^(0)="^58.800119PA^^"
 I '$D(^PSD(58.8,+PSDS,1,PSDRG,4,PSDA,0)) K DA,DIC,DD,DO S DIC(0)="L",DIC="^PSD(58.8,"_+PSDS_",1,"_PSDRG_",4,",DA(2)=+PSDS,DA(1)=PSDRG,(X,DINUM)=PSDA D FILE^DICN K DA,DIC
 W "done.",!!
 S $P(^PSD(58.8,NAOU,1,PSDRG,3,PSDRN,0),"^",17)=PSDA
 W !!,"Press <RET> to continue" R X:DTIME W @IOF
 Q
