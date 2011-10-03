PSDGSL ;BIR/BJW-Review Green Sheet Log ; 10 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to view",!,?12,"Green Sheets.  PSJ RPHARM or PSJ PHARM TECH security key required.",! K OK Q
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) SORT
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
SORT ;sort gs number or date
 K DA,DIR,DIRUT S DIR(0)="SO^D:DATE RANGE;N:GREEN SHEET NUMBER"
 S DIR("A")="Select Sort for Green Sheet Listing"
 S DIR("?",1)="Answer 'D' to print for a specific date range or",DIR("?")="answer 'N' to print a range of Green Sheet numbers."
 D ^DIR K DIR G:$D(DIRUT) END S ASK=Y
 I ASK="N" G GS
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
 G DEV
GS ;ask gs num range
 W !!,"Start with Green Sheet: " R X:DTIME I '$T!(X="")!(X["^") G END
 I X'?1.9N W !!,"Please enter your starting Green Sheet number from 1 to 999999999.",! G GS
 S PSD1=X
GS2 W !!,"End with Green Sheet: " R X:DTIME I '$T!(X="")!(X["^") G END
 I X'?1.9N W !!,"Please enter your ending Green Sheet number from 1 to 999999999.",! G GS2
 I X'>PSD1 W !!,"Ending GS number must be larger that the starting GS number.",! G GS2
 S PSD2=X
DEV ;asks device and queueing information
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDGSL1",ZTDESC="CS PHARM GREEN SHEET HISTORY" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G START^PSDGSL1
END K %,%DT,%H,%I,%ZIS,ASK,C,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,OK,POP,PSD1,PSD2,PSDATE,PSDED,PSDEV,PSDOUT,PSDS,PSDSD,PSDSN,X,Y
 K ^TMP("PSDGSL",$J)
 K ZTDESC,ZTRTN,ZTSAVE,ZTSK D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;sets variables for queueing
 S (ZTSAVE("ASK"),ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDA"),ZTSAVE("NODE"))=""
 S:$D(PSDATE) ZTSAVE("PSDATE")="" S:$D(PSDSD) ZTSAVE("PSDSD")=""
 S:$D(PSDED) ZTSAVE("PSDED")=""
 S:$D(PSD2) ZTSAVE("PSD2")="" S:$D(PSD1) ZTSAVE("PSD1")=""
 Q
