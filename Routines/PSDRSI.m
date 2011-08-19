PSDRSI ;BIR/JPW-Inspector Remove Hold on Green Sheet ; 10 Nov 93
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 W !!,"Inspector Remove a Green Sheet from Hold" S PSDUZ=DUZ,PSDUZN=$S($P($G(^VA(200,PSDUZ,0)),"^")]"":$P(^(0),"^"),1:"")
ASKN ;if nurse ask naou
 W ! K DA,DIC S DIC=58.8,DIC(0)="QEAZ",DIC("A")="Select NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S AOU=+Y,AOUN=$P(Y,"^",2)
GS ;select green sheet #
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC=58.81,DIC(0)="QEASZ",D="D"
 S DIC("S")="I $P(^(0),""^"",11)=11"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y
 S STAT=+$P(Y(0),"^",11),PSDPN=$P(Y(0),"^",17),STATN="" I STAT S STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 S ORD=+$P(Y(0),"^",20),NAOU=+$P(Y(0),"^",18),NAOUN=$P($G(^PSD(58.8,NAOU,0)),"^"),PSDR=+$P(Y(0),"^",5),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^")
 I AOU'=NAOU W $C(7),!!,"The Green Sheet # ",PSDPN," is assigned to ",NAOUN,".",!,"Please select another Green Sheet.",! G GS
 I '$D(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)) W $C(7),!!,"There's no data on ",NAOUN," for Green Sheet # ",PSDPN,".",!,"Contact your Pharmacy Coordinator for assistance.",! G END
 I STAT'=11 W $C(7),!!,"This Green Sheet has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",!,"Please select another Green Sheet.",! G GS
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Are you sure",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to to remove this Green Sheet from hold for the Inspector or",DIR("?")="answer 'NO' to leave the Green Sheet status under review by Inspector."
 D ^DIR K DIR G:$D(DIRUT) END G:'Y GS
 D NOW^%DTC S (RECD,Y)=+$E(%,1,12) X ^DD("DD") S RECDT=Y
COM ;complete at order level in 58.8
 W !!,"Accessing ",PSDRN," information...",!!
 W !!,"Updating your records now..."
 ;update transaction file (58.81)
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="29.7////"_RECD_";10////4" D ^DIE K DA,DIE,DR
 I $D(Y)!$D(DTOUT) W $C(7),!!,"** THIS GREEN SHEET HAS NOT BEEN REMOVED FROM HOLD **",!!,"The status remains "_STATN,! G END
 K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////4" D ^DIE K DA,DIE,DR
 S STAT=$P($G(^PSD(58.81,PSDA,0)),"^",11) W ?2,!,"*** Your Green Sheet #"_PSDPN_" is now "_$S($P($G(^PSD(58.82,STAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_" ***",!
 G GS
END K %,%DT,%H,%I,AOU,AOUN,D,DA,DIC,DIE,DR,DTOUT,DUOUT
 K NAOU,NAOUN,OK,ORD,PSDA,PSDPN,PSDR,PSDRN,PSDUZ,PSDUZN,RECD,RECDT,STAT,STATN,SUB,TRANS,X,Y
 Q
