PSDPDR ;BIR/BJW-Narc Disp/Rec Report (in lieu of VA FORM 10-2321) ; 09 FEB 95
 ;;3.0; CONTROLLED SUBSTANCES ;**69**;13 Feb 97;Build 13
 ;References to ^PSD(58.8, covered by DBIA2711
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"process/dispense narcotic supplies.",!!,"PSJ RPHARM, PSJ PHARM TECH or PSD TECH ADV security key required.",! K OK Q
COPY ;ask vault, nursing or both
 K DA,DIR,DIRUT S DIR(0)="SO^V:VAULT COPY ONLY;N:NURSING COPY ONLY;B:BOTH VAULT AND NURSING COPY"
 S DIR("A")="Select Disp/Receiving Report(s) to Print"
 S DIR("?",1)="Answer 'V' to print only the vault copy of this report,",DIR("?",2)="answer 'N' to print only the nursing copy  or",DIR("?")="answer 'B' to print both the vault and nursing copies."
 D ^DIR K DIR
 I $D(DIRUT) W !,"No report will be printed.",! G END
 S PSDCPY=Y
ASKD ;ask dispensing location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) ASKN
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
ASKN ;ask naou or group
 W !!,?5,"Select one of the following:",!!,?10,"N",?20,"NAOU (One, Some, or ^ALL)",!,?10,"G",?20,"Group of NAOUs",!
 K DA,DIR,DIRUT S DIR(0)="SOA^N:NAOU;G:Group of NAOUs",DIR("A")="Select Method: "
 S DIR("?",1)="Enter 'N' to select one, some or ^ALL NAOU(s),",DIR("?")="enter 'G' to select a group of NAOUs, or '^' to quit"
 D ^DIR K DIR G:$D(DIRUT) END S SEL=Y D NOW^%DTC S PSDT=X,PSDPT=+$E(%,1,12) K DA,DIC S CNT=0
 I SEL="G" D GROUP G:'$D(PSDG) END G DEV
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",2)=""N"",$P(^(0),""^"",4)=+PSDS" D ^DIC K DIC Q:Y<0  D
 .S NAOU(+Y)="",CNT=CNT+1
 I '$D(NAOU)&(X'="^ALL") G END
 S:X="^ALL" ALL=1
DEV ;ask device and queue info
 W !,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q") S PSDIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPDR1",ZTDESC="Compile Narcotic Disp Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G START^PSDPDR1
END K %,%H,%I,%ZIS,ALL,C,CNT,COPY,COMM,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,EXP,EXPD,FLAG,LOT,MFG,NAOU,NODE,NUM
 K OK,ORD,ORDN,POP,PSD,PSDCPY,PSDA,PSDDT,PSDEV,PSDG,PSDIO,PSDN,PSDNA,PSDPT,PSDR,PSDRN,PSDS,PSDSN,PSDT,PSDSN,PSDST,QTY,REQD,REQDT,SEL,STAT,STATN,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDRPT",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
GROUP ;select group of naous
 K DA,DIC F  S DIC=58.2,DIC("A")="Select NAOU INVENTORY GROUP NAME: ",DIC(0)="QEA",DIC("S")="I $S($D(^PSI(58.2,""CS"",+Y)):1,1:0)" D ^DIC K DIC Q:Y<0  S PSDG(+Y)=""
 Q
SAVE S (ZTSAVE("PSDIO"),ZTSAVE("PSDT"),ZTSAVE("CNT"),ZTSAVE("PSDS"),ZTSAVE("PSDPT"),ZTSAVE("PSDCPY"))="" S:$D(PSDG) ZTSAVE("PSDG(")="" S:$D(NAOU) ZTSAVE("NAOU(")="" S:$D(ALL) ZTSAVE("ALL")=""
 Q
