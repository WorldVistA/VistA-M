PSDPLOG ;BIR/BJW-CS Inspector's Log ; 11 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 ;S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0) I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print the CS Inspector's Log.",! K OK Q
 W !,?5,"Inspector's Log for Active Green Sheets",!
RET ;ask to include returns
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Include Returns to Stock"
 S DIR("?")="Answer 'YES' or return to include returns to stock, 'NO' to continue without returns, or '^' to quit."
 D ^DIR K DIR I $D(DIRUT) D MSG G END
 S PSDRET=+Y G:'PSDRET ASKN
RDATE ;ask return date
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date Returned to Stock: " D ^%DT I Y<0 S PSDOUT=1 D MSG G END
 S PSDSD=Y,PSDSD=PSDSD-.0001
ASKN ;ask naou or group
 W !!,?5,"Select one of the following:",!!,?10,"N",?20,"NAOU (One, Some, or ^ALL)",!,?10,"G",?20,"Group of NAOUs",!
 K DA,DIR,DIRUT S DIR(0)="SOA^N:NAOU;G:Group of NAOUs",DIR("A")="Select Method: "
 S DIR("?",1)="Enter 'N' to select one, some or ^ALL NAOU(s),",DIR("?")="enter 'G' to select a group of NAOUs, or '^' to quit"
 D ^DIR K DIR G:$D(DIRUT) END S SEL=Y D NOW^%DTC S PSDT=X K DA,DIC S CNT=0
 I SEL="G" D GROUP G:'$D(PSDG) END G SORT
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)" D ^DIC K DIC Q:Y<0  D
 .S NAOU(+Y)="",CNT=CNT+1
 I '$D(NAOU)&(X'="^ALL") G END
 S:X="^ALL" ALL=1
SORT ;asks sort
 W ! K DA,DIR,DIRUT S DIR(0)="YO",DIR("A")="Do you wish to sort by Inventory Type",DIR("B")="NO"
 S DIR("?")="Answer YES to sort drugs by Inventory Type, NO or <RET> to sort by drug."
 D ^DIR K DIR G:$D(DIRUT) END S ASKN=Y
SORT2 ;asks second sort
 K DA,DIR,DIRUT S DIR(0)="SO^D:DRUG/DISPENSING #S;N:NUMERIC DISPENSING #S"
 S DIR("A")="Select Print Order for Inspector's Log",DIR("?",1)="Select D to print Dispensing Number numerically by drug, within an NAOU,",DIR("?")="select N to print numerically within an NAOU, or '^' to quit."
 D ^DIR K DIR G:$D(DIRUT) END S ASK=Y
DEV ;ask device and queue info
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q") S PSDIO=ION_";"_IOST_";"_IOM_";"_IOSL,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPLOG1",ZTDESC="Compile Narcotic Inspector Log" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G START^PSDPLOG1
END K %,%DT,%H,%I,%ZIS,ALL,ASK,ASKN,CNT,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,EXP,EXPD,JJ,NAOU,NODE,NODE3,NUM
 K OK,PSD,PSDA,PSDDT,PSDG,PSDIO,PSDOK,PSDOUT,PSDN,PSDNA,PSDPT,PSDR,PSDRN,PSDRD,PSDRDT,PSDRET,PSDSD,PSDST,PSDT,PSDTR
 K QTY,SEL,STAT,STATN,TYP,TYPN,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDLOG",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
GROUP ;select group of naous
 K DA,DIC F  S DIC=58.2,DIC("A")="Select NAOU INVENTORY GROUP NAME: ",DIC(0)="QEA",DIC("S")="I $S($D(^PSI(58.2,""CS"",+Y)):1,1:0)" D ^DIC K DIC Q:Y<0  S PSDG(+Y)=""
 Q
SAVE S (ZTSAVE("PSDIO"),ZTSAVE("PSDT"),ZTSAVE("CNT"),ZTSAVE("PSDSITE"),ZTSAVE("ASK"),ZTSAVE("ASKN"))=""
 S:$D(PSDG) ZTSAVE("PSDG(")="" S:$D(NAOU) ZTSAVE("NAOU(")="" S:$D(ALL) ZTSAVE("ALL")=""
 S ZTSAVE("PSDRET")="" S:$D(PSDSD) ZTSAVE("PSDSD")=""
 Q
MSG W !!,"No action taken.",!!
 Q
