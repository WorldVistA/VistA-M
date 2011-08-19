PSDLBLR ;BIR/JPW-CS Label Reprint for CS Disp Drug ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**69**;13 Feb 97;Build 13
 ;References to ^PSD(58.8, covered by DBIA2711
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print CS dispensing labels.",!!,"PSJ RPHARM, PSJ PHARM TECH or PSD TECH ADV security key required.",! K OK Q
 W !!,"Green Sheets/Transactions that have a status of FILLED - NOT DELIVERED",!,"or DELIVERED - ACTIVELY ON NAOU will be reprinted for a given number range.",!!
GS ;ask disp number range
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) GS1
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
GS1 ;
 W !!,"You may enter a Dispensing Number list and/or a Dispensing Number range.",!
 W "NOTE: This response must be a list or range, e.g., 1,3,5 or 2-4,8.",!
 K DA,DIR,DIRUT S DIR(0)="LOA^0:999999999",DIR("A")="Select Dispensing Number(s): "
 D ^DIR K DIR G:$D(DIRUT) END
 S PSD1="" F  S PSD1=$O(Y(PSD1)) Q:PSD1=""  S:$D(Y(PSD1)) PSD1(PSD1)=Y(PSD1) K Y(PSD1)
DEV ;ask device and queue info
 S DIR(0)="Y",DIR("A")="Would you like to try printing these on PIN FED labels",DIR("B")="No" D ^DIR K DIR Q:$D(DIRUT)  G:Y=1 ^PSDLBLR1
 W $C(7),!!,?3,"WARNING: The printing of these labels requires the use of a sheet fed",!,?12,"laser printer setup to create Controlled Substances",!,?12,"barcodes.",!
 W !,?12,"*** Check printer for LABEL paper before printing! ***",!
 W !!,"This report is designed for a 3 column label format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",10),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDLBLR0",ZTDESC="Print Dispensing Labels for CS PHARM" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO D ^PSDLBLR0
END ;kill variables and exit
 K %,%DT,%H,%I,%ZIS,C,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DRUG,DTOUT,DUOUT,JJ,JLP1,LIQ,NAOU,NAOUN,NODE,OK
 K POP,PSD,PSD1,PSDA,PSDBAR0,PSDBAR1,PSDCNT,PSDEV,PSDJ,PSDN,PSDPN,PSDOUT,PSDR,PSDRG,PSDPRT,PSDRN,PSDS,PSDSN,PSDT,PSDX1,PSDX2
 K QTY,STAT,TEMP,TEST,TEXT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDLBLR",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save queued variables
 S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"))=""
 S ZTSAVE("PSD1(")=""
 Q
