PSDGSPU ;BIR/JPW-Pickup Green Sheet ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):2,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to return",!,?12,"Green Sheets.  PSJ RPHARM or PSJ PHARM TECH security key required.",! K OK Q
 W ?10,!!,"Return a Green Sheet to Pharmacy",! S PSDUZ=DUZ,PSDUZN=$P($G(^VA(200,PSDUZ,0)),"^")
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) GS
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
GS ;select green sheet #
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC=58.81,DIC(0)="QEASZ",D="D"
 S:OK=1 DIC("S")="I $P(^(0),""^"",3)=+PSDS,$S($P(^(0),""^"",11)=4:1,$P(^(0),""^"",11)=5:1,1:0)"
 S:OK=2 DIC("S")="I $P(^(0),""^"",3)=+PSDS,$P(^(0),""^"",11)=5" D IX^DIC K DIC G:Y<0 END S PSDA=+Y
 S STAT=+$P(Y(0),"^",11),PSDPN=$P(Y(0),"^",17),STATN="" I STAT S STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 S ORD=+$P(Y(0),"^",20),NAOU=+$P(Y(0),"^",18),NAOUN=$P($G(^PSD(58.8,NAOU,0)),"^"),PSDR=+$P(Y(0),"^",5),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^")
 I '$D(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)) W $C(7),!!,"There's no data on ",NAOUN," for Green Sheet # ",PSDPN,".",!,"Contact your Pharmacy Coordinator for assistance.",! G END
 I OK=2,STAT'=5 W !!,"This order has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",!,"Please contact your Pharmacy Coordinator for assistance.",! G END
 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RECDT=Y
RET ;return gs
 W !!,"Accessing ",PSDRN," information...",!
 ;update transaction file (58.81)
 S NURSE=+$P($G(^PSD(58.81,PSDA,1)),"^",10)
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="31//^S X=RECDT;32//^S X=PSDUZN;I NURSE S Y=10;29;10////6" D ^DIE K DA,DIE,DR
 I $D(Y)!$D(DTOUT) W $C(7),!!,"** THIS GREEN SHEET HAS NOT BEEN PICKED UP **",!!,"The status remains "_STATN,! G END
 ;update order info in 58.8
 W !!,"Updating your records now..."
 K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////6" D ^DIE K DA,DIE,DR
 W "done.",!!
 S STAT=$P($G(^PSD(58.81,PSDA,0)),"^",11) W ?2,"*** Your Green Sheet #"_PSDPN_" is now "_$S($P($G(^PSD(58.82,STAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_" ***",!
 G GS
END K %,%DT,%H,%I,D,DA,DIC,DIE,DR,DTOUT,DUOUT
 K NAOU,NAOUN,NURSE,OK,ORD,PSDA,PSDPN,PSDR,PSDRN,PSDS,PSDSN,PSDUZ,PSDUZN,RECDT,STAT,STATN,X,Y
 Q
