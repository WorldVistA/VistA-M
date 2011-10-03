PSDORST ;BIR/JPW-Pharmacy Vault Order Stats Report ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print this status report.",!!,"PSJ RPHARM or PSJ PHARM TECH security key required.",! K OK Q
ASKD ;ask dispensing location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) DEV
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
DEV ;ask device and queue info
 W !!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDORST",ZTDESC="Pharm Status of Pending Narcotic Orders",(ZTSAVE("PSDS"),ZTSAVE("PSDSN"))="" D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;loops thru pending orders and orders cancelled in the past 3 days
 K ^TMP("PSDTST",$J)
 D NOW^%DTC S PSDT=X
 F STAT=0:0 S STAT=$O(^PSD(58.85,"AC",STAT)) Q:'STAT!(STAT>2)  F NAOU=0:0 S NAOU=$O(^PSD(58.85,"AC",STAT,NAOU)) Q:'NAOU  D LOOP
PRINT ;prints the report
 S (PG,PSDOUT)=0,Y=PSDT X ^DD("DD") S RPDT=Y
 K LN S $P(LN,"-",80)="" I '$D(^TMP("PSDTST",$J)) D HDR W !!,?10,"****  NO PENDING ORDERS TO REPORT  ****" G END
 D HDR
 S DRUG="" F  S DRUG=$O(^TMP("PSDTST",$J,DRUG)) Q:DRUG=""!(PSDOUT)  W !,?2,"=>  ",DRUG,!! F ORD=0:0 S ORD=$O(^TMP("PSDTST",$J,DRUG,ORD)) Q:'ORD!(PSDOUT)  D  Q:PSDOUT
 .S NODE=^TMP("PSDTST",$J,DRUG,ORD) I $Y+5>IOSL D HDR Q:PSDOUT  W !,?2,"=> ",DRUG,!!
 .W $P(NODE,"^",4),?11,$P(NODE,"^",3),?33,$P(NODE,"^",2),?40,$E($P(NODE,"^",5),1,12),?58,$P($P(NODE,"^"),"-"),!,?55,$P($P(NODE,"^"),"-",2),!!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END K %,%H,%I,%ZIS,C,DA,DIC,DIR,DIROUT,DIRUT,DRUG,DRUGN,DTOUT,DUOUT,LN,NAOU,NAOUN,NODE,OK,ORD
 K PG,PSDA,PSDEV,PSDOUT,PSDPN,PSDS,PSDSN,PSDT,QTY,REQ,RPDT,STAT,STATN,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDTST",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
LOOP ;starts drug loop for all orders
 F DRUG=0:0 S DRUG=$O(^PSD(58.85,"AC",STAT,NAOU,DRUG)) Q:'DRUG  F ORD=0:0 S ORD=$O(^PSD(58.85,"AC",STAT,NAOU,DRUG,ORD)) Q:'ORD  S PSDA=$O(^PSD(58.85,"AC",STAT,NAOU,DRUG,ORD,0)) I PSDA D SET
 Q
SET ;sets data for printing
 Q:'$D(^PSD(58.85,PSDA,0))  S NODE=^(0) Q:+$P(NODE,"^",2)'=+PSDS
 S DRUGN=$S($P($G(^PSDRUG(DRUG,0)),"^")]"":$P(^(0),"^"),1:"DRUG NAME MISSING")
 S NAOUN=$S($P($G(^PSD(58.8,NAOU,0)),"^")]"":$P(^(0),"^"),1:"NAOU NAME MISSING")
 S STATN=$P($G(^PSD(58.82,STAT,0)),"^"),STATN=$E(STATN,1,30),QTY=$P(NODE,"^",6),PSDPN=$P(NODE,"^",15),REQ=$P(NODE,"^",18) I REQ S Y=REQ X ^DD("DD") S REQ=Y
 S ^TMP("PSDTST",$J,DRUGN,PSDA)=STATN_"^"_QTY_"^"_REQ_"^"_PSDPN_"^"_NAOUN
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?20,"Pharmacy Status of Pending Narcotic Orders",?70,"Page: ",PG,!,?35,PSDSN,!,?35,RPDT,!
 W !,?2,"=> DRUG",!,?13,"DATE",!,"DISP #",?12,"ORDERED",?32,"QTY",?40,"NAOU",?55,"ORDER STATUS"
 W !,LN,!
 Q
