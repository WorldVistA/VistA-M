PSDCOR1 ;BIR/JPW-CS Correction Action (cont'd) ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4) G:$P(PSDSITE,U,5) GS
ASKD ;ask disp site
 K DA,DIC W ! S DIC=58.8,DIC(0)="QEA",DIC("A")="Select Dispensing Site: ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)=""M"":1,$P(^(0),""^"",2)=""S"":1,1:0)"
 S DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END S PSDS=+Y,PSDSN=$P(Y,"^",2)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
GS ;select green sheet #
 W $C(7),!!,?15,"** NOTE **"
 W !,"Your Green Sheet selection is limited to those Green Sheets added using the"
 W !,"Add Existing Green Sheets option.  The Green Sheet status must still be",!,"DELIVERED - ACTIVELY ON NAOU for you to make this correction.",!!
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC=58.81,DIC(0)="QEASZ",D="D"
 S DIC("S")="I $P(^(0),""^"",2)=12,$P(^(0),""^"",3)=+PSDS,$P(^(0),""^"",11)=4"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y
 I $D(^PSD(58.81,PSDA,7)) W $C(7),!!,"This Green Sheet has been transferred between NAOUs.",!,"You may not delete this Green Sheet.",! G END
 S STAT=+$P(Y(0),"^",11),PSDPN=$P(Y(0),"^",17),STATN="" I STAT S STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 S ORD=+$P(Y(0),"^",20),NAOU=+$P(Y(0),"^",18),NAOUN=$P($G(^PSD(58.8,NAOU,0)),"^"),PSDR=+$P(Y(0),"^",5)
 S PHARM=$P($G(^PSD(58.81,PSDA,1)),"^"),PSDT=$P(Y(0),"^",4),QTY=$P(Y(0),"^",6) I $D(^PSD(58.81,PSDA,4)),$P(^(4),"^",3) S QTY=$P(^(4),"^",3)
 I '$D(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)) W $C(7),!!,"There's no data on ",NAOUN," for Green Sheet # ",PSDPN,".",!,"Contact your Pharmacy Coordinator for assistance.",! G END
 I STAT'=4 W $C(7),!!,"This Green Sheet has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",!,"Please select another Green Sheet.",! G GS
ASK W !!,"This action will delete Green Sheet #",PSDPN,"."
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Are you sure",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to delete the Green Sheet or",DIR("?")="answer 'NO' to quit and the Green Sheet data will not be deleted."
 D ^DIR K DIR I 'Y W !!,"No action taken.  The Green Sheet data still exists.",!! G END
COM ;complete correction
 D NOW^%DTC S RECDT=+$E(%,1,12)
 W !!,"Accessing Green Sheet #",PSDPN," information...",!!
 F  L +^PSD(58.87,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDCOR=$P(^PSD(58.87,0),"^",3)+1 I $D(^PSD(58.87,PSDCOR)) S $P(^PSD(58.87,0),"^",3)=PSDCOR G FIND
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.87,DIC(0)="L",X=PSDCOR D ^DIC K DIC,DLAYGO
 L -^PSD(58.87,0)
 K DA,DIE,DR S DIE=58.87,DA=PSDCOR,DR="1////"_RECDT_";2////"_PSDUZ_";3////"_PSDPN_";4////"_PSDR_";5////"_NAOU_";7////"_PSDT_";8////"_ORD_";9////"_PHARM_";10////"_QTY_";11////"_TYPE_";12////"_PSDS
 D ^DIE K DA,DIE,DR
 W !!,"Updating your records now..."
 ;update transaction file (58.81)
 K DA,DIE,DR S DIDEL=58.81,DA=PSDA,DIE=58.81,DR=".01////@" D ^DIE K DA,DIE,DR,DIDEL
 I $D(Y)!$D(DTOUT) W $C(7),!!,"** THIS GREEN SHEET HAS NOT BEEN CORRECTED **",!!,"The status remains "_STATN,! G END
 K DA,DIE,DR S DIDEL=58.800119,DA=PSDA,DA(1)=PSDR,DA(2)=+PSDS,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",4,",DR=".01////@" D ^DIE K DA,DIE,DR,DIDEL
 K DA,DIE,DR S DIDEL=58.800118,DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR=".01////@" D ^DIE K DA,DIE,DR,DIDEL
 W ?2,!,"*** Your Green Sheet #"_PSDPN_" has been deleted. ***",!,"If you wish to add this Green Sheet again,",!,"please use the 'Add Existing Green Sheets' option.",!
END K %,%DT,%H,%I,D,DA,DIC,DIDEL,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT
 K NAOU,NAOUN,OK,ORD,PHARM,PSDA,PSDCOR,PSDPN,PSDR,PSDS,PSDSN,PSDT,PSDUZ,QTY,RECDT,STAT,STATN,TYPE,X,Y
 Q
