SROCMP1 ;BIR/MAM - PERIOPERATIVE OCCURRENCES ;02/02/06
 ;;3.0; Surgery ;**38,50,153**;24 Jun 93;Build 11
EN ; entry point
 N SRSEL S (SRATT,SRSOUT,SRSP)=0,SRSEL=1 G:SRBOTH DEV
BY W @IOF K DIR S DIR(0)="N^1:3",DIR("A",1)="Print report by",DIR("A",2)=" 1. Surgical Specialty"
 S DIR("A",3)=" 2. Attending Surgeon",DIR("A",4)=" 3. Occurrence Category",DIR("A",5)="",DIR("A")="Select 1, 2 or 3",DIR("B")=1
 S DIR("?")="Select a number" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 D END Q
 S SRSEL=Y
 I SRSEL=2 D ATTND Q
 I SRSEL=3 D OCC Q
SPEC W @IOF K DIR S DIR("A")="Do you want to print this report for all Surgical Specialties ",DIR("B")="YES",DIR(0)="Y"
 S DIR("?",1)="  Press ENTER to print this report for all surgical specialties, or"
 S DIR("?")="  enter NO to select a specific specialty."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 D END Q
 I 'Y D SP I SRSOUT D END Q
DEV S SRGRAMM=$S(SRBOTH:"These reports are ",1:"This report is ")
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,SRGRAMM_"designed to use a 132 column format.",! D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="PERIOPERATIVE OCCURRENCES",ZTRTN="BEG^SROCMP",(ZTSAVE("SRBOTH"),ZTSAVE("SRED"),ZTSAVE("SRSD"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSP*"),ZTSAVE("SRSEL"))="" D ^%ZTLOAD G END
 D BEG^SROCMP
END ;
 Q:'$D(SRSOUT)  I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC,^SRSKILL K SRTN W @IOF
 Q
ATTND W @IOF K DIR S DIR("A")="Do you want to print this report for all Attending Surgeons ",DIR("B")="YES",DIR(0)="Y"
 S DIR("?",1)="  Press ENTER to print this report for all attending surgeons, or"
 S DIR("?")="  enter NO to select a specific attending surgeon."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 D END Q
 I 'Y D ATSUR I SRSOUT D END Q
 D DEV
 Q
ATSUR W !! S SRSP=1 K DIR S DIR(0)="130,.164AO",DIR("A")="Print the report for which Attending Surgeon ? "
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!(+Y'>0) S SRSOUT=1 Q
 S SRCT=+Y,SRSP(SRCT)=+Y
MOAT ; ask for more attending surgeons
 K DIR S DIR(0)="130,.164AO",DIR("A")="Select an Additional Attending Surgeon: "
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'+Y Q
 S SRCT=+Y,SRSP(SRCT)=+Y G MOAT
 Q
OCC W @IOF K DIR S DIR("A")="Do you want to print this report for all Occurrence Categories",DIR("B")="YES",DIR(0)="Y"
 S DIR("?",1)="  Press ENTER to print this report for all occurrence categoies, or"
 S DIR("?")="  enter NO to select an ocurrence category."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 D END Q
 I 'Y D CAT I SRSOUT D END Q
 D DEV
 Q
CAT W !! S SRSP=1 K DIR S DIR(0)="PAO^136.5:QEM",DIR("A")="Print the report for which Occurrence Category ? "
 S DIR("S")="I '$P(^(0),U,2)" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!(+Y'>0) S SRSOUT=1 Q
 S SRCT=+Y,SRSP(SRCT)=+Y
MOCAT ; ask for more occurrence categories
 K DIR S DIR(0)="PAO^136.5:QEM",DIR("A")="Select an Additional Occurrence Category: "
 S DIR("S")="I '$P(^(0),U,2)" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!(+Y'>0) Q
 S SRCT=+Y,SRSP(SRCT)=+Y G MOCAT
 Q
SP W !! S SRSP=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRCT=+Y,SRSP(SRCT)=+Y
MORE ; ask for more surgical specialties
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select an Additional Specialty:  " D ^DIC I Y>0 S SRCT=+Y,SRSP(SRCT)=+Y G MORE
 Q
