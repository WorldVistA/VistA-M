PSDAMIS ;BIR/BJW-AMIS Report for NAOUs ; 5 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)) W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to print",!,?12,"the narcotic NAOU AMIS Report.",!!,"PSJ RPHARM security key required.",! Q
 W !!,"Select Date Range for NAOU AMIS Report",!
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
 D NOW^%DTC S PSDT=X
SUM ;if summary only
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to print the summary totals only",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to print only the summary totals for this report,",DIR("?")="answer 'NO' to print the detail report including summary totals."
 D ^DIR K DIR G:$D(DIRUT) END S SUM=Y
SORT ;sel sort order
 K DA,DIR,DIRUT S DIR(0)="SO^D:DRUG/ALL NAOUS;N:NAOU/ALL DRUGS",DIR("A",1)="You may print by either of these sorting methods."
 S DIR("?",1)="Enter 'D' if you wish to print the NAOU AMIS Report sorted by DRUG",DIR("?",2)="  and within DRUG by each NAOU."
 S DIR("?",3)="Enter 'N' to print the NAOU AMIS Report by NAOU",DIR("?")="  and within NAOU by each DRUG."
 S DIR("A")="Select SORT ORDER for Report" D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
 G:ANS="D" DRUG
ASKN ;ask NAOU(s)
 W !!,?5,"You may select a single NAOU, several NAOUs,",!,?5,"or enter ^ALL to select all NAOUs.",!!
 K DA,DIC
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",2)=""N"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC Q:Y<0  S LOC(+Y)=""
 I '$D(LOC)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)="N",$P($G(^(0)),"^",3)=+PSDSITE S LOC(PSD)=""
 G DEV
DRUG ;ask drug(s)
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!!
 K DA,DIC F  S DIC("A")="Select DRUG: ",DIC=50,DIC(0)="QEAM",DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0),$P($G(^(2)),""^"",3)[""N""" D ^DIC K DIC Q:Y<0  S LOC(+Y)=""
 I '$D(LOC)&(X'="^ALL") G END
 I X="^ALL" S ALL=1
DEV ;asks device and queueing information
 W !!,"This report is designed for a 80 column format.",!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN=$S(ANS="D":"START^PSDAMIS1",1:"START^PSDAMIS2"),ZTDESC="CS PHARM NAOU AMIS Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G:ANS="D" START^PSDAMIS1 G:ANS="N" START^PSDAMIS2
END ;
 K %,%DT,%H,%I,%ZIS,ALL,ANS,DA,DATE,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IO("Q"),LOC
 K POP,PSD,PSDATE,PSDED,PSDOUT,PSDSD,PSDT,SUM,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save variables for queueing
 S ZTSAVE("ANS")="",ZTSAVE("SUM")="",ZTSAVE("PSDSITE")="",ZTSAVE("PSD")="",ZTSAVE("PSDT")="" S:$D(LOC) ZTSAVE("LOC(")=""
 S:$D(ALL) ZTSAVE("ALL")=""
 S (ZTSAVE("PSDATE"),ZTSAVE("PSDED"),ZTSAVE("PSDSD"))=""
 S ZTSAVE("DUZ")=""
 Q
