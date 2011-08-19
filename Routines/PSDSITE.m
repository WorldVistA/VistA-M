PSDSITE ;BIR/JPW,LTL-Site Parameters for CS ; 3 May 95
 ;;3.0; CONTROLLED SUBSTANCES ;**65**;13 Feb 97;Build 5
SITE ;entry for selecting inpatient sites in file 59.4
 K DIC,DLAYGO S DIC="^PS(59.4,",DLAYGO=59.4,DIC(0)="QEAL",D="B",DZ="??"
 D DQ^DICQ K D,DZ W ! D ^DIC K DIC G:Y<0 END
 K DA,DIE,DR S DIE=59.4,DA=+Y,DR="31"_"Is "_$P(Y,U,2)_" selectable for Controlled Subs" W ! D ^DIE K DIE
END K DA,DIC,DIE,DLAYGO,DR,DTOUT,DUOUT,X,Y
 Q
 ;
LOW ;if auto generate, check low range for numbers
 I '$D(X) S PSDFLAG=1 Q
 K PSD,PSDFLAG,PSDL F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $D(^PSD(58.8,PSD,0)),$D(^(2)),$P(^(2),"^") D
 .I +$P(^PSD(58.8,PSD,2),"^",2),+$P(^(2),"^",3) S PSDL(+PSD)=""
 I $O(PSDL(0)) F PSD=0:0 S PSD=+$O(PSDL(PSD)) Q:'PSD  D
 .I X'<$P($G(^PSD(58.8,PSD,2)),"^",2),(X'>$P($G(^(2)),"^",3)),PSD'=DA D MSG S PSDFLAG=1 Q
 W:$D(PSDFLAG) "  Select another range.",! K PSD,PSDL
 Q
 ;
HIGH ;validates high range for dispensing numbers
 I '$D(X) S PSDFLAG=1 Q
 K PSD,PSDFLAG,PSDH,PSDL F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $D(^PSD(58.8,PSD,0)),$D(^(2)),$P(^(2),"^") D
 .I +$P(^PSD(58.8,PSD,2),"^",2) S PSDL(+$P(^(2),"^",2))=PSD
 S PSDL=+$P($G(^PSD(58.8,DA,2)),"^",2),PSDH=+$O(PSDL(PSDL)) I PSDH S PSD=+$P(PSDL(PSDH),"^")
 I X'>PSDL W !!,"High dispensing # must be larger than your low dispensing # "_PSDL_".",!! S PSDFLAG=1 Q
 I PSDH,X'<PSDH D MSG S PSDFLAG=1
 W:$D(PSDFLAG) "  Select another range.",! K PSD,PSDH,PSDL
 Q
 ;
MSG ;prints message if range already in use
 W $C(7),!!,?12," =>  Dispensing Site "_$S($P(^PSD(58.8,PSD,0),"^")]"":$P(^(0),"^"),1:"NAME MISSING")_"  <=",!,"has set aside the range "_$P($G(^PSD(58.8,PSD,2)),"^",2)_" through "_$P($G(^(2)),"^",3)_"."
 Q
 ;
LAST ;checks range for 'last dispensed'
 I '$D(X) S PSDFLAG=1 Q
 I $D(PSDEN) D LAST1 K LOW,HIGH,PSDCHK Q
 I X<$P($G(^PSD(58.8,DA,2)),"^",2) D MSG1 S PSDFLAG=1 Q
 I X>$P($G(^PSD(58.8,DA,2)),"^",3) D MSG1 S PSDFLAG=1
 Q
 ;
MSG1 ;prints message if not in dispensing range
 W $C(7),!!,"Last number dispensed must be within the range "_$P($G(^PSD(58.8,DA,2)),"^",2)_" to "_$S($P($G(^(2)),"^",3):$P($G(^(2)),"^",3),1:999999999)_".",!
 Q
LAST1 ;checks LOW/HIGH range and LAST dispensed
 I X<LOW D MSG2 S PSDFLAG=1 Q
 I X>HIGH D MSG2 S PSDFLAG=1
 Q
MSG2 ;prints msg if not in dispensing range
 S PSDCHK=1
 W $C(7),!!,"Last number dispensed must be within the range ",LOW," to ",HIGH,".",!
 Q
