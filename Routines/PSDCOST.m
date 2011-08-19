PSDCOST ;BIR/BJW,LTL-Cost Report for NAOUs ; 6 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)) W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to print",!,?12,"the narcotic NAOU Cost Report.",!!,"PSJ RPHARM security key required.",! Q
 W !!,"Before printing a Cost Report, be sure accurate data exists in the",!!,"PRICE PER ORDER UNIT & DISPENSE UNITS PER ORDER UNIT fields in the DRUG file."
 N %,%H,%I,DIR,DIRUT,DUOUT,DTOUT,LOC,X,Y,POP,PSDATE,PSDED,PSDSD,PSDCHO,PSDEV,PSDIO,PSDOUT,ZTSK
CHOICE S DIR(0)="S^1:Cost Report By NAOU(s);2:Cost Report By Drug(s);3:High Cost Report;4:High Volume Report",DIR("A")="Please select Report"
 S DIR("?")="These reports may be printed for a date range which you select, and you may choose to print the report for a single NAOU, several NAOUs, or for ALL NAOUs." D ^DIR K DIR G:Y<1 END S PSDCHO=Y,PSDCHO(1)=Y(0)
 W !!,"Select Date Range for ",PSDCHO(1),!
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " W ! D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
 G:PSDCHO>2 ASKN
SUM ;if summary only
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to print the summary totals only",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to print only the summary totals for this report,",DIR("?")="answer 'NO' to print the detail report including summary totals."
 D ^DIR K DIR G:$D(DIRUT) END S SUM=Y G:PSDCHO=2 DRUG
ASKN ;ask NAOU(s)
 W !!,?5,"You may select a single NAOU, several NAOUs,",!,?5,"or enter ^ALL to select all NAOUs.",!!
 D NOW^%DTC S PSDT=X,Y=% X ^DD("DD") S PSDT(1)=Y K DA,DIC
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$P(^(0),""^"",2)=""N"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC Q:Y<0  S LOC(+Y)=""
 I '$D(LOC)&(X'="^ALL") G END
 I X="^ALL" S ALL=1 F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$P($G(^(0)),"^",2)="N",$P($G(^(0)),"^",3)=+PSDSITE S LOC(PSD)=""
 D:PSDCHO>2  G:$D(DIRUT) END
 .S DIR(0)="N",DIR("A")="Please enter CUT OFF "_$S(PSDCHO=3:"amount",1:"quantity")
 .S DIR("A",1)="The High Cost Report will show all drugs with a total dispensed "_$S(PSDCHO=3:"cost",1:"quantity"),DIR("A",2)=""
 .S DIR("A",3)="greater than your specified cut off amount.",DIR("A",4)=""
 .W ! D ^DIR K DIR Q:$D(DIRUT)  S PSD=Y Q:PSDCHO=4
 .S DIR(0)="S^1:By COST (Highest to Lowest);2:Alphabetical by DRUG"
 .S DIR("A",1)="You may print by either of these sorting methods"
 .S DIR("A",2)="",DIR("A")="Please select SORT ORDER",DIR("B")=1
 .D ^DIR K DIR Q:Y<1  S PSD(1)=Y,PSD(2)=Y(0)
 G DEV
DRUG ;ask drug(s)
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!!
 D NOW^%DTC S PSDT=X,Y=% X ^DD("DD") S PSDT(1)=Y
 K DA,DIC F  S DIC("A")="Select DRUG: ",DIC=50,DIC(0)="QEAM",DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0),$P($G(^(2)),""^"",3)[""N""" D ^DIC K DIC Q:Y<0  S LOC(+Y)=""
 I '$D(LOC)&(X'="^ALL") G END
 I X="^ALL" S ALL=1
DEV ;asks device and queueing information
 W !!,"This report is designed for a 80 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDSITE,2)),U,9),C=$P(^DD(58.8,24,0),U,2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS
 I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q") S PSDIO=ION,ZTIO="" K ZTSAVE,ZTDTH,ZTSK S ZTRTN=$S(PSDCHO=1:"^PSDCOSN",PSDCHO=2:"^PSDCOSD",PSDCHO=3:"^PSDCOSH",1:"^PSDCOSV"),ZTDESC="Compile CS Cost Report data" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 W !,"Compiling ",PSDCHO(1)," data." U IO
 D @$S(PSDCHO=1:"^PSDCOSN",PSDCHO=2:"^PSDCOSD",PSDCHO=3:"^PSDCOSH",1:"^PSDCOSV")
END ;
 K %,%DT,%H,%I,%ZIS,ALL,ANS,DA,DATE,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IO("Q"),POP,PSD,PSDT,SUM,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save variables for queueing
 S ZTSAVE("SUM")="",ZTSAVE("PSDSITE")="",ZTSAVE("PSD*")="" S:$D(LOC) ZTSAVE("LOC(")=""
 S:$D(ALL) ZTSAVE("ALL")=""
 Q
