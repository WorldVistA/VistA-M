PSDPWK ;BIR/JPW,BJW-Print Pharm Disp. Worksheet ; 3 Aug 98
 ;;3.0; CONTROLLED SUBSTANCES ;**10,69**;13 Feb 97;Build 13
 ;refer to nois#:sdc-0597-60187
 ;References to ^PSD(58.8, covered by DBIA2711
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"process/dispense narcotic supplies.",!!,"PSJ RPHARM, PSJ PHARM TECH or PSD TECH ADV security key required.",! K OK Q
 W !!,"=>  This report lists all pending CS requests for a dispensing site.",!!
 I '$O(^PSD(58.85,0)) W $C(7),!!,"There are no pending request orders.",!! K OK Q
SUM ;ask worksheet, summary or both
 K DA,DIR,DIRUT S DIR(0)="SO^W:WORKSHEET ONLY;S:SUMMARY TOTALS ONLY;B:BOTH WORKSHEET AND SUMMARY TOTALS"
 S DIR("A")="Select Worksheet Report(s) to Print"
 S DIR("?",1)="Answer 'W' to print only the worksheet for this report,",DIR("?",2)="answer 'S' to print only the summary totals, or",DIR("?")="answer 'B' to print the worksheet and the summary totals."
 D ^DIR K DIR G:$D(DIRUT) END S SUM=Y
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 I $P(PSDSITE,U,5) S PSDS=PSDS_"^"_+$P(^PSD(58.8,+PSDS,0),"^",5) G CHKD
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)",DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),PSDS=PSDS_"^"_+$P(Y(0),"^",5)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.85,"AE",+PSDS,0)) W !!,"There are no pending CS requests for "_PSDSN_".",!! G END
ASKN ;ask naou or group
 W !!,?5,"Select one of the following:",!!,?10,"N",?20,"NAOU (One, Some, or ^ALL)",!,?10,"G",?20,"Group of NAOUs",!
 K DA,DIR,DIRUT S DIR(0)="SOA^N:NAOU;G:Group of NAOUs",DIR("A")="Select Method: "
 S DIR("?",1)="Enter 'N' to select one, some or ^ALL NAOU(s).",DIR("?")="Enter 'G' to select a group of NAOUs, or '^' to quit"
 D ^DIR K DIR
 I $D(DIRUT),X="^ALL" S ALL=1,CNT=0,SEL="N" D NOW^%DTC S PSDT=X G SORT
 I $D(DIRUT) G END
 S SEL=Y D NOW^%DTC S PSDT=X K DA,DIC S CNT=0
 I SEL="G" D GROUP G:'$D(PSDG) END G SORT
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",2)=""N"",$P(^(0),""^"",4)=+PSDS" D ^DIC K DIC Q:Y<0  D
 .S NAOU(+Y)="",CNT=CNT+1
 I '$D(NAOU)&(X'="^ALL") G END
 S:X="^ALL" ALL=1
SORT ;asks sort
 S ANS=$P($G(^PSD(58.8,+PSDS,2)),"^",7)
 I (ANS="D")!(ANS="N") G DEV
 K DA,DIR,DIRUT S DIR(0)="SO^D:DRUG/NAOU;N:NAOU/DRUG",DIR("A",1)="You may print by either of these sorting methods."
 S DIR("?",1)="Enter 'D' to print the worksheet sorted by DRUG then NAOU",DIR("?")="Enter 'N' to print the worksheet sorted by NAOU then DRUG."
 S DIR("A")="Select SORT ORDER for Worksheet" D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
DEV ;ask device and queue info
 ;chgd L4 to s psdio=ion_";"_iost
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q") S PSDIO=ION_";"_IOST,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPWK1",ZTDESC="Compile Worksheet for CS PHARM" D SAVE,^%ZTLOAD K ZTSK G END
 U IO G START^PSDPWK1
END K %,%H,%I,%ZIS,ALL,ANS,C,CNT,COMM,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IO("Q"),JJ,JJ1,JJDA,LOOP,LOOP2,NAOU,NODE,OK,ORD,ORDN
 K POP,PRT,PSD,PSDCPY,PSDEV,PSDG,PSDIO,PSDN,PSDNA,PSDR,PSDRN,PSDS,PSDSN,PSDT
 K QTY,SEL,SUM,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK,^TMP("PSDWK",$J),^TMP("PSDWKT",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
GROUP ;select group of naous
 K DA,DIC F  S DIC=58.2,DIC("A")="Select NAOU INVENTORY GROUP NAME: ",DIC(0)="QEA",DIC("S")="I $S($D(^PSI(58.2,""CS"",+Y)):1,1:0)" D ^DIC K DIC Q:Y<0  S PSDG(+Y)=""
 Q
SAVE S (ZTSAVE("PSDT"),ZTSAVE("PSDIO"),ZTSAVE("ANS"),ZTSAVE("CNT"),ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("SUM"),ZTSAVE("PSDSITE"))=""
 S:$D(PSDG) ZTSAVE("PSDG(")="" S:$D(NAOU) ZTSAVE("NAOU(")="" S:$D(ALL) ZTSAVE("ALL")=""
 Q
