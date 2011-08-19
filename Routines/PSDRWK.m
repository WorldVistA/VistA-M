PSDRWK ;BIR/JPW-Reprint Pharm Disp. Worksheet ;12/14/99  16:40
 ;;3.0; CONTROLLED SUBSTANCES ;**20,69**;13 Feb 97;Build 13
 ;
 ; Reference to XUSEC( supported by DBIA # 10076
 ; Reference to DD(58.8 supported by DBIA # 10154
 ; Reference to DD("DD" supported by DBIA # 10017
 ; Reference to PSDRUG( supproted by DBIA # 221
 ; Reference to VA(200 supported by DBIA # 10060
 ; Reference to PSD(58.8 supported by DBIA # 2711
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"process/dispense narcotic supplies.",!!,"PSJ RPHARM, PSJ PHARM TECH or PSD TECH ADV security key required.",! K OK Q
 W !!,"=>  This report reprints a worksheet listing of all pending CS requests for a",!,"    dispensing site.",!!
 I '$O(^PSD(58.85,0)) W $C(7),!!,"There are no pending request orders.",!! K OK Q
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 I $P(PSDSITE,U,5) S PSDS=PSDS_"^"_+$P(^PSD(58.8,+PSDS,0),"^",5) G CHKD
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)",DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),PSDS=PSDS_"^"_+$P(Y(0),"^",5)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.85,"AE",+PSDS,0)) W !!,"There are no pending CS requests for "_PSDSN_".",!! G END
DEV ;ask device and queue info
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDRWK",ZTDESC="Reprint Worksheet for CS PHARM" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;entry for reprint
 K LN S (CNT,PG,PSDOUT)=0,$P(LN,"-",132)="" D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y D HDR Q:PSDOUT
 F JJ=0:0 S JJ=$O(^PSD(58.85,"AW",+PSDS,JJ)) Q:'JJ!(PSDOUT)  F PSD=0:0 S PSD=$O(^PSD(58.85,"AW",+PSDS,JJ,PSD)) Q:'PSD!(PSDOUT)  I $D(^PSD(58.85,PSD,0)) S PSDN=+$P(^(0),"^",3) D
 .S NODE=^PSD(58.85,PSD,0),CNT=CNT+1,WK=$S($P(NODE,"^",7)>2:"*",1:"")
 .S PSDNA=$S($P($G(^PSD(58.8,PSDN,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSDN)
 .S DRUG=+$P(NODE,"^",4),DRUGN=$S($P($G(^PSDRUG(DRUG,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_DRUG)
 .S QTY=$P(NODE,"^",6),ORD=+$P(NODE,"^",12),ORDN=$S($P($G(^VA(200,ORD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 .S COMM=$S($D(^PSD(58.85,PSD,1,0)):1,1:0)
 .;prints detail data
 .I 'CNT W !!,?45,"****  NO REQUESTS PREVIOUSLY PRINTED FOR THIS DISPENSING LOCATION  ****" S PSDOUT=1 Q
 .D:$Y+8>IOSL HDR Q:PSDOUT
 .W !,PSD_WK,?10,DRUGN,?52,QTY,?60,PSDNA,?100,ORDN
 .W:$P($G(^PSD(58.85,PSD,2)),U,2) !,"* PRIORITY *"
 .I COMM K ^UTILITY($J,"W") F TEXT=0:0 S TEXT=$O(^PSD(58.85,PSD,1,TEXT)) Q:'TEXT  S X=$G(^PSD(58.85,PSD,1,TEXT,0)),DIWL=15,DIWR=125,DIWF="W" D ^DIWP
 .I COMM D ^DIWW
 .W !!,?10,"Disp # ____________  Manufacturer: __________________   Lot # __________   Exp. Date: __________",!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END K %,%H,%I,%ZIS,C,CNT,COMM,DA,DIC,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DTOUT,DRUG,DRUGN,DUOUT,IO("Q"),JJ,LN,NODE,OK,ORD,ORDN
 K PG,POP,PSD,PSDEV,PSDN,PSDNA,PSDOUT,PSDS,PSDSN,QTY,RPDT,TEXT,WK,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDSITE"))=""
 Q
HDR ;lists header information
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,?40,"PHARMACY DISPENSING WORKSHEET (Reprint)",!!,"Dispensing Location: ",PSDSN,?65,RPDT,?105,"PG "_PG,!!
 W "WS #",?10,"DRUG",?50,"QUANTITY",?60,"DISPENSE TO",!,?12,"COMMENTS",?50,"ORDERED",?60,"LOCATION",?102,"ORDERED BY",!,LN,!
 Q
