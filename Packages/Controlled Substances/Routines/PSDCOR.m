PSDCOR ;BIR/JPW-CS Correction Action ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
EN1 ;sets type=1
 S TYPE=1 G START
EN2 ;sets type=2
 S TYPE=2 G START
EN3 ;sets type=3
 S TYPE=3
START ;start proc
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSDMGR",DUZ)) W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to correct",!,?12,"narcotic orders.",!!,"PSDMGR security key required.",! K TYPE Q
 W !!,"Controlled Substances Correction Action" S PSDUZ=DUZ
 G:TYPE=2 ^PSDCOR1 G:TYPE=3 ^PSDCOR2
ASKN ;ask naou
 W ! K DA,DIC S DIC=58.8,DIC(0)="QEAZ",DIC("A")="Select NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S AOU=+Y,AOUN=$P(Y,"^",2)
GS ;select green sheet #
 W $C(7),!!,?15,"** NOTE **",!,"Your Green Sheet selection is limited to those Green Sheets flagged as",!,"'COMPLETED - GREEN SHEET READY FOR PICKUP' on the selected NAOU.",!
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC=58.81,DIC(0)="QEASZ",D="D"
 S DIC("S")="I $P(^(0),""^"",11)=5,$P(^(0),""^"",18)=AOU"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y
 S STAT=+$P(Y(0),"^",11),PSDPN=$P(Y(0),"^",17),STATN="" I STAT S STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 S PSDS=+$P(Y(0),"^",3)
 S ORD=+$P(Y(0),"^",20),NAOU=+$P(Y(0),"^",18),NAOUN=$P($G(^PSD(58.8,NAOU,0)),"^"),PSDR=+$P(Y(0),"^",5)
 S NURS=$P($G(^PSD(58.81,PSDA,1)),"^",10)
 I AOU'=NAOU W $C(7),!!,"The Green Sheet # ",PSDPN," is assigned to ",NAOUN,".",!,"Please select another Green Sheet.",! G GS
 I '$D(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)) W $C(7),!!,"There's no data on ",NAOUN," for Green Sheet # ",PSDPN,".",!,"Contact your Pharmacy Coordinator for assistance.",! G END
 I STAT'=5 W $C(7),!!,"This Green Sheet has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",!,"Please select another Green Sheet.",! G GS
ASK W !!,"This action will update Green Sheet #",PSDPN," as ",!,?5,"** DELIVERED - ACTIVELY ON NAOU **",!
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Are you sure",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to update the status to 'DELIVERED - ACTIVELY ON NAOU' or",DIR("?")="answer 'NO' to quit and the status will remain 'COMPLETED - GREEN SHEET READY FOR PICKUP'."
 D ^DIR K DIR I 'Y W !!,"No action taken.",!! G END
COM ;complete correction
 D NOW^%DTC S RECDT=+$E(%,1,12)
 W !!,"Accessing Green Sheet #",PSDPN," information...",!!
 F  L +^PSD(58.87,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDCOR=$P(^PSD(58.87,0),"^",3)+1 I $D(^PSD(58.87,PSDCOR)) S $P(^PSD(58.87,0),"^",3)=PSDCOR G FIND
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.87,DIC(0)="L",X=PSDCOR D ^DIC K DIC,DLAYGO
 L -^PSD(58.87,0)
 K DA,DIE,DR S DIE=58.87,DA=PSDCOR,DR="1////"_RECDT_";2////"_PSDUZ_";3////"_PSDPN_";4////"_PSDR_";5////"_NAOU_";6////"_NURS_";8////"_ORD_";11////"_TYPE_";12////"_PSDS
 D ^DIE K DA,DIE,DR
 W !!,"Updating your records now..."
 ;update transaction file (58.81)
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="10////4" D ^DIE K DA,DIE,DR
 I $D(Y)!$D(DTOUT) W $C(7),!!,"** THIS GREEN SHEET HAS NOT BEEN CORRECTED **",!!,"The status remains "_STATN,! G END
 K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////4" D ^DIE K DA,DIE,DR
 S STAT=$P($G(^PSD(58.81,PSDA,0)),"^",11) W ?2,!,"*** Your Green Sheet #"_PSDPN_" is now "_$S($P($G(^PSD(58.82,STAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_" ***",!
END K %,%DT,%H,%I,AOU,AOUN,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT
 K NAOU,NAOUN,NURS,OK,ORD,PSDA,PSDCOR,PSDPN,PSDR,PSDS,PSDUZ,RECDT,STAT,STATN,TYPE,X,Y
 Q
