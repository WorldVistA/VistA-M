PSDNRGO ;BIR/JPW-Receive Green Sheet for NAOU ; 6 Jan 94
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
ORD S STAT=+$P(Y(0),"^",11),PSDPN=$P(Y(0),"^",17),STATN="" I STAT S STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 S ORD=+$P(Y(0),"^",20),NAOU=+$P(Y(0),"^",18),NAOUN=$P($G(^PSD(58.8,NAOU,0)),"^"),PSDR=+$P(Y(0),"^",5),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^"),QTY=+$P(Y(0),"^",6),OK=1,PSDUZ=DUZ
 I $D(^PSD(58.81,PSDA,4)),+$P(^(4),"^",3) S QTY=$P(^(4),"^",3)
 I AOU'=NAOU W $C(7),!!,"The Green Sheet # ",PSDPN," is assigned to ",NAOUN,".",!,"Please select another Green Sheet.",! S PSDOUT=1 G END
 I '$D(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)) W $C(7),!!,"There's no data on ",NAOUN," for Green Sheet # ",PSDPN,".",!,"Contact your Pharmacy Coordinator for assistance.",! S PSDOUT=1 G END
 I STAT'=3 W $C(7),!!,"This Green Sheet has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",!,"Please select another Green Sheet.",! S PSDOUT=1 G END
 D NOW^%DTC S (RECD,Y)=+$E(%,1,12) X ^DD("DD") S RECDT=Y
REC ;receive at order level in 58.8
 W !!,"Accessing ",PSDRN," information...",!!
 K DA,DIR,DIRUT S DIR(0)="58.81,27",DIR("B")=QTY D ^DIR K DIR I $D(DIRUT) W !!,"Quantity not entered.  No action taken.",!,"This order remains ",STATN,!! S PSDOUT=1 G END
 S RQTY=Y I RQTY'=QTY W $C(7),!!,"The quantity received does not match the quantity dispensed.",!,"This order must be returned to pharmacy for investigation.",!! S PSDOUT=1 G END
 K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU
 S DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,"
 S DR=$S(OK=1:"6////"_PSDUZ,1:"6RECEIVED BY NURSE")_";20////"_QTY_";15////"_RECD_";10////4;22////"_$P($G(^PSD(58.8,NAOU,1,PSDR,0)),U,4)_";25////"_$P($G(^PSD(58.8,NAOU,1,PSDR,0)),U,4) D ^DIE K DA,DIE,DR
 I ($D(Y))!($D(DTOUT)) W $C(7),!!,"*** THIS ORDER HAS NOT BEEN RECEIVED ***",!,"Receiving nurses name must be entered.",!!,"The status remains "_STATN,! S PSDOUT=1 G END
UPDATE ;update 58.8 and 58.81
 ;updating drug balance in 58.8
 ;F  L +^PSD(58.8,NAOU,1,PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S:'$P($G(^PSD(58.81,PSDA,9)),U) $P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)=$P(^PSD(58.8,NAOU,1,PSDR,0),"^",4)+QTY
 ;L -^PSD(58.8,NAOU,1,PSDR,0)
 ;update transaction file (58.81)
 S OREC=$P($G(^PSD(58.8,NAOU,1,PSDR,3,ORD,0)),"^",7)
 K DA,DIE,DR S DA=PSDA,DIE=58.81
 S DR="10////"_$S('$P($G(^PSD(58.8,NAOU,2)),U,5):4,$P($G(^PSD(58.81,PSDA,9)),U):4,1:13)_";20////"_OREC_";21////"_RECD_";27////"_QTY_";I OK=1 S Y=""@1"";15COMMENTS;@1"
 D ^DIE K DA,DIE,DR
 I OK=2 S $P(^PSD(58.81,PSDA,1),"^",11)=PSDUZ
 W !!,"Updating your records now..."
 ;update worksheet file (58.85) to be purged
 S DA=+$O(^PSD(58.85,"AD",NAOU,PSDR,ORD,0)) I DA,$D(^PSD(58.85,DA,0)) K DIE,DR S DIE=58.85,DR="6////4" D ^DIE K DA,DIE,DR
 W "done.",!!
 S STAT=$P($G(^PSD(58.81,PSDA,0)),"^",11) W ?5,"*** Your Green Sheet #"_PSDPN_" is now "_$S($P($G(^PSD(58.82,STAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_" ***",! S NAOU(1)=1
END K %,%DT,%H,%I,AOUN,D,DA,DIC,DIE,DR,DTOUT,DUOUT
 K NAOUN,OK,OREC,PSDPN,PSDRN,PSDUZ,PSDUZN,QTY,RECD,RECDT,RQTY,STATN,SUB,PSDA,X,Y
 Q
