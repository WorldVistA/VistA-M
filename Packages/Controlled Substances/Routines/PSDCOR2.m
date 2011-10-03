PSDCOR2 ;BIR/JPW-CS Correction Action (cont'd) ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4) G:$P(PSDSITE,U,5) GS
ASKD ;ask disp site
 K DA,DIC W ! S DIC=58.8,DIC(0)="QEA",DIC("A")="Select Dispensing Site: ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)=""M"":1,$P(^(0),""^"",2)=""S"":1,1:0)",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END S PSDS=+Y,PSDSN=$P(Y,"^",2)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
GS ;select green sheet #
 W $C(7),!!,?15,"** NOTE **",!,"Your Green Sheet selection is limited to those Green Sheets marked as",!,"COMPLETED - REVIEWED NO DISCREPANCY.",!
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC=58.81,DIC(0)="QEASZ",D="D"
 S DIC("S")="I $P(^(0),""^"",3)=+PSDS,$P(^(0),""^"",11)=7,$P(^(0),""^"",12)=1"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y
 S STAT=+$P(Y(0),"^",11),PSDPN=$P(Y(0),"^",17),STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 S COMP=+$P(Y(0),"^",12),COMPN=$P($G(^PSD(58.83,COMP,0)),"^")
 S ORD=+$P(Y(0),"^",20),NAOU=+$P(Y(0),"^",18),NAOUN=$P($G(^PSD(58.8,NAOU,0)),"^"),PSDR=+$P(Y(0),"^",5)
 S CPBY=+$P($G(^PSD(58.81,PSDA,1)),"^",14),CPBYD=+$P(Y(0),"^",19)
 I '$D(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)) W $C(7),!!,"There's no data on ",NAOUN," for Green Sheet # ",PSDPN,".",!,"Contact your Pharmacy Coordinator for assistance.",! G END
 I STAT'=7 W $C(7),!!,"This Green Sheet has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",!,"Please select another Green Sheet.",! G GS
ASKS ;ask new stat
 K DA,DIC S DIC=58.83,DIC(0)="QEA",DIC("A")="Select Completion Status: ",DIC("S")="I $S(Y<4:0,1:1)"
 D ^DIC K DIC I Y<0 G END
 S NCOMP=+Y,NCOMPN=$P($G(^PSD(58.83,NCOMP,0)),"^")
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Is this OK",DIR("?",1)="Answer 'YES' to update the status",DIR("?")="or 'NO' to select another status."
 S DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) END I 'Y G ASKS
ASK W !!,"This action will update Green Sheet #",PSDPN," as ",!,?5,"** COMPLETED - PENDING PROBLEM RESOLUTION",!,?8,NCOMPN," **",!
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Are you sure",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to update the status to COMPLETED - PENDING PROBLEM",DIR("?",2)="RESOLUTION "_NCOMPN_" or answer 'NO' to quit",DIR("?")="and the status will remain COMPLETED - REVIEWED NO DISCREPANCY."
 D ^DIR K DIR I 'Y W !!,"No action taken.",!! G END
COM ;complete correction
 D NOW^%DTC S RECDT=+$E(%,1,12)
 W !!,"Accessing Green Sheet #",PSDPN," information...",!!
 F  L +^PSD(58.87,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDCOR=$P(^PSD(58.87,0),"^",3)+1 I $D(^PSD(58.87,PSDCOR)) S $P(^PSD(58.87,0),"^",3)=PSDCOR G FIND
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.87,DIC(0)="L",X=PSDCOR D ^DIC K DIC,DLAYGO
 L -^PSD(58.87,0)
 K DA,DIE,DR S DIE=58.87,DA=PSDCOR,DR="1////"_RECDT_";2////"_PSDUZ_";3////"_PSDPN_";4////"_PSDR_";5////"_NAOU_";7////"_CPBYD_";8////"_ORD_";9////"_CPBY_";11////"_TYPE_";12////"_PSDS_";13////"_COMP_";14////"_NCOMP
 D ^DIE K DA,DIE,DR
 W !!,"Updating your records now..."
 ;update transaction file (58.81)
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="10////8;11////"_NCOMP D ^DIE K DA,DIE,DR
 I $D(Y)!$D(DTOUT) W $C(7),!!,"** THIS GREEN SHEET HAS NOT BEEN CORRECTED **",!!,"The status remains "_STATN,! G END
 K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////8;11////"_NCOMP D ^DIE K DA,DIE,DR
 S STAT=+$P($G(^PSD(58.81,PSDA,0)),"^",11) W ?2,!,"*** Your Green Sheet #"_PSDPN_" is now ",!
 S COMP=+$P($G(^PSD(58.81,PSDA,0)),"^",12) W ?2,$S($P($G(^PSD(58.83,COMP,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_" ***",!
END K %,%DT,%H,%I,COMP,COMPN,CPBY,CPBYD,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT
 K NAOU,NAOUN,NCOMP,NCOMPN,OK,ORD,PSDA,PSDCOR,PSDPN,PSDR,PSDS,PSDSN,PSDUZ,RECDT,STAT,STATN,TYPE,X,Y
 Q
