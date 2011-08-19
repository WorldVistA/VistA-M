PSDRDR ;BIR/BJW-Narc Disp/Rec Report (reprint VA FORM 10-2321) ; 12 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,69**;13 Feb 97;Build 13
 ;**Y2K compliance**,"P" added to date input string
 ;References to ^PSD(58.8, covered by DBIA2711
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"process/dispense narcotic supplies.",!!,"PSJ RPHARM, PSJ PHARM TECH or PSD TECH ADV security key required.",! K OK Q
ASKD ;ask dispensing location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) SUM
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
SUM ;if ret-to-stock or turn in for dest
 K DA,DIR,DIRUT W ! S DIR(0)="Y",DIR("A")="Is this a Return to Stock or Turn in for Destruction Reprint",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to select a Return to Stock or Turn in for Destruction form,",DIR("?")="answer 'NO' to print a dispensing VA FORM 10-2321."
 D ^DIR K DIR G:$D(DIRUT) END S SUM=Y G:SUM TYPE^PSDRPT
COPY ;ask vault, nursing or both
 K DA,DIR,DIRUT S DIR(0)="SO^V:VAULT COPY ONLY;N:NURSING COPY ONLY;B:BOTH VAULT AND NURSING COPY"
 S DIR("A")="Select Disp/Receiving Report(s) to Print"
 S DIR("?",1)="Answer 'V' to print only the vault copy of this report,",DIR("?",2)="answer 'N' to print only the nursing copy, or",DIR("?")="answer 'B' to print both the vault and nursing copies."
 D ^DIR K DIR
 I $D(DIRUT) W !,"No report will be printed.",! G END
 S PSDCPY=Y
ASKN ;ask naou or green sheet number
 K DA,DIR,DIRUT S DIR(0)="SO^N:NAOU;G:Green Sheet #",DIR("A")="Select Method"
 S DIR("?",1)="Enter 'N' to select one, several, or ^ALL NAOUs,",DIR("?")="enter 'G' to select a Green Sheet #, or '^' to quit"
 D ^DIR K DIR G:$D(DIRUT) END S SEL=Y
 I SEL="G" W ! K DA,DIC S DIC("A")="Select Green Sheet #: ",DIC=58.81,D="D",DIC(0)="QEAS",DIC("S")="I $P(^(0),""^"",3)=+PSDS" D IX^DIC G:Y<0 END S PSDA=+Y G DEV
NAOU ;sel naou
 W !!,?5,"You may select a single NAOU, several NAOUs,",!,?5,"or enter ^ALL to select all NAOUs.",!!
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",2)=""N"",$P(^(0),""^"",4)=+PSDS" D ^DIC K DIC Q:Y<0  S NAOU(+Y)=""
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $P($G(^PSD(58.8,PSD,0)),"^",2)="N",$P($G(^(0)),"^",4)=+PSDS S NAOU(PSD)=""
DATE ;asks date range if naou is selected
 W !!,"Please enter the DATE and TIME period you wish to reprint data for this report",!
 W ! K %DT S %DT="AEPRXT",%DT("A")="Start with Date/Time: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date/Time: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.0001
DEV ;ask device and queue info
 W !,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDRDR1",ZTDESC="Reprint Narcotic Disp Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G START^PSDRDR1
END K %,%I,%H,%ZIS,C,COMM,COPY,D,DA,DIC,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DRUG,DRUGN,DTOUT,DUOUT,EXP,EXPD,FLAG,LN,LOOP,LOT,MFG,NAOU,NAOUN,NODE,NUM,OK,ORD,ORDN
 K PG,PHARM,PHARMN,PSD,PSDA,PSDATE,PSDCPY,PSDDT,PSDED,PSDEV,PSDN,PSDNA,PSDOUT,PSDS,PSDSD,PSDSN,PSDST,QTY,REC,RECN,REQD,REQDT,RPDT,SEL,SUM,TEXT,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDRDR",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("PSDATE"),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDSN"),ZTSAVE("PSDS"),ZTSAVE("PSDCPY"))=""
 S:$D(NAOU) ZTSAVE("NAOU(")="" S:$D(PSDA) ZTSAVE("PSDA")=""
 Q
