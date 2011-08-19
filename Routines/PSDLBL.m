PSDLBL ;BIR/JPW-CS Label Print for CS Disp Drug ; 5 Oct 94
 ;;3.0; CONTROLLED SUBSTANCES ;**69**;13 Feb 97;Build 13
 ;References to ^PSD(58.8, covered by DBIA2711
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print CS dispensing labels.",!!,"PSJ RPHARM, PSJ PHARM TECH or PSD TECH ADV security key required.",! K OK Q
ASKD ;ask disp number range
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.8,+PSDS,1,0)) W !!,"There are no CS stocked drugs for your dispensing vault.",!! G END
ONE ;asks print type
 K DA,DIR,DIRUT S DIR(0)="S^N:NAOU(s);R:Range of Green Sheet Numbers",DIR("A")="Printing Method"
 S DIR("?",1)="Answer 'N' to select printing by NAOU(s), 'R' to select a number range",DIR("?")="to print ALL Green Sheets not previously printed, or '^' to quit."
 D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
 G:ANS="N" SEL
GS1 ;ask gs # range
 W !!,"You may enter a Green Sheet # list and/or a Green Sheet # range.",!
 W "NOTE: This response must be a list or range, e.g. 1,3,5 or 2-4,8.",!
 K DA,DIR,DIRUT S DIR(0)="LOA^0:999999999",DIR("A")="Select Green Sheet #(s): "
 D ^DIR K DIR G:$D(DIRUT) END
 S PSD1="" F  S PSD1=$O(Y(PSD1)) Q:PSD1=""  S:$D(Y(PSD1)) PSD1(PSD1)=Y(PSD1) K Y(PSD1)
 G DEV
SEL ;sel naou or group
 W !!,?5,"Select one of the following:",!!,?10,"N",?20,"NAOU (One, Some, or ^ALL)",!,?10,"G",?20,"Group of NAOUs",!
 K DA,DIR,DIRUT S DIR(0)="SOA^N:NAOU;G:Group of NAOUs",DIR("A")="Select Method: "
 S DIR("?",1)="Enter 'N' to select one, some or ^ALL NAOU(s),",DIR("?")="enter 'G' to select a group of NAOUs, or '^' to quit"
 D ^DIR K DIR G:$D(DIRUT) END S SEL=Y D NOW^%DTC S PSDT=X K DA,DIC S CNT=0
 I SEL="G" D GROUP G:'$D(PSDG) END G DEV
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$P(^(0),""^"",2)=""N""" D ^DIC K DIC Q:Y<0  D
 .S NAOU(+Y)="",CNT=CNT+1
 I '$D(NAOU)&(X'="^ALL") G END
 S:X="^ALL" ALL=1
DEV ;ask device and queue info
 S DIR(0)="Y",DIR("A")="Would you like to try printing these on PIN FED labels",DIR("B")="No" D ^DIR K DIR Q:$D(DIRUT)  G:Y=1 ^PSDLBL4
 W $C(7),!!,?3,"WARNING: The printing of these labels requires the use of a sheet fed",!,?12,"laser printer setup to create Controlled Substances",!,?12,"barcodes.",!
 W !,?12,"*** Check printer for LABEL paper before printing! ***",!
 W !!,"This report is designed for a 3 column label format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",10),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="Q",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDLBL0",ZTDESC="Print Dispensing Labels for CS PHARM" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO D ^PSDLBL0
END ;kill variables and exit
 K %,%DT,%H,%I,%ZIS,ALL,ANS,C,CNT,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DRUG,DTOUT,DUOUT,JJ,JLP1,LIQ,NAOU,NAOUN,NODE,OK
 K POP,PSD,PSD1,PSD2,PSDA,PSDBAR0,PSDBAR1,PSDCNT,PSDEV,PSDG,PSDJ,PSDN,PSDPN,PSDOUT,PSDR,PSDRG,PSDPRT,PSDRN,PSDS,PSDSN,PSDT,PSDX1,PSDX2
 K SEL,STAT,TEMP,TEST,TEXT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDLBL",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save queued variables
 S:$D(ALL) ZTSAVE("ALL")=""
 S:$D(PSDS) (ZTSAVE("PSDS"),ZTSAVE("PSDSN"))=""
 S:$D(PSD1) ZTSAVE("PSD1(")="" S:$D(NAOU) ZTSAVE("NAOU(")="" S:$D(PSDG) ZTSAVE("PSDG(")="" S:$D(CNT) ZTSAVE("CNT")=""
 S (ZTSAVE("ANS"),ZTSAVE("PSDSITE"))=""
 Q
GROUP ;select group of naous
 K DA,DIC F  S DIC=58.2,DIC("A")="Select NAOU INVENTORY GROUP NAME: ",DIC(0)="QEA",DIC("S")="I $S($D(^PSI(58.2,""CS"",+Y)):1,1:0)" D ^DIC K DIC Q:Y<0  S PSDG(+Y)=""
 Q
