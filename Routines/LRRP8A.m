LRRP8A ;DALISC/TNN/J0 - WKLD STATS REPORT BY SHIFT ; 4/9/93
 ;;5.2;LAB SERVICE;**63**;Sep 27, 1994
 W !!,"ENTRY POINT IS AT EN^LRRP8." H 3 QUIT
 ;
ASK ;
 D INST Q:LREND
 D ACCAREA Q:LREND
 D DATES Q:LREND
 D CAPS Q:LREND
 D TIMES Q:LREND
 D REPTYP Q:LREND
 D DEVICE Q:LREND
 Q
INST ;*** Query for institution ***
 K DIC
 W @IOF,!
 S DIC="^LRO(64.1,",DIC(0)="AQENM" D ^DIC
 I (+Y<0)!($D(DUOUT))!($D(DTOUT)) S LREND=1 Q
 S LRIN=+Y
 Q
ACCAREA ;*** Query for accession areas ***
 S LRAA=0
 K DIR,X,Y S DIR(0)="S^Y:YES;N:NO",DIR("B")="NO"
 S DIR("A")="Do you want to select accession areas (YES or NO) "
 S DIR("?",1)="Enter 'NO' to include ALL accession areas."
 S DIR("?")="Enter 'YES' to limit report to one or more accession areas."
 D ^DIR
 Q:Y="N"
 I ($D(DTOUT))!($D(DUOUT)) S LREND=1 Q
 K DIC S DIC=68,DIC(0)="AEMQZ"
 F  D ^DIC Q:Y=-1  D
 .S LRAA=+Y,LRAA(+Y)=$P(Y(0),U,11)
 I ($D(DTOUT))!($D(DUOUT)) S LREND=1 Q
 Q
DATES ;*** Query for date ***
 W !,"DATE selection:"
 K DIR,X,Y S DIR(0)="S^1:A specific date;2:A range of dates"
 D ^DIR
 I $D(DIRUT)!($D(DUOUT)) S LREND=1 Q
 I X=1 D QDT Q
 D DATE^LRCAPR1A S:Y=-1 LREND=1
 Q
CAPS ;*** Query for CAP codes ***
 N I S LRCAPS=0 K DIR,X,Y
 S DIR(0)="S^Y:YES;N:NO",DIR("B")="NO"
 S DIR("A")="Do you want to select workload codes (YES or NO) "
 S DIR("?",1)="Enter 'NO' to include ALL workload codes."
 S DIR("?")="Enter 'YES' to limit report to one or more workload codes."
 D ^DIR
 Q:Y="N"
 I ($D(DTOUT))!($D(DUOUT)) S LREND=1 Q
 W !
 S DIC="^LAM(",DIC(0)="AQENM",DIC("A")="Select WKLD code:"
 F I=1:1 D ^DIC Q:Y=-1  S LRCAPS(+Y)=$P(Y,U),LRCAPS=I
 S:($D(DTOUT))!($D(DUOUT)) LREND=1
 Q
TIMES ;*** Query for type of time search ***
 W !,"TIME selection:"
 K DIR S DIR(0)="S^1:A time range;2:A set of shifts"
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S LREND=1 Q
 I X=2 D QST Q
 D QTR I ($G(LRSTRT)<0)!($G(LRSTOP)<0) S LREND=1
 Q
REPTYP ;*** Query for type of type of report ***
 W !,"REPORT selection:"
 K DIR S DIR(0)="S^1:Detail report;2:Summary report"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S LREND=1 Q
 S LRRPT=+X
 Q
DEVICE ;
 K %ZIS,POP S %ZIS="Q" D ^%ZIS
 I POP S LREND=1 Q
 I $D(IO("Q")) D QUE S LREND=1
 Q
QUE ;
 S ZTSAVE("LR*")="",ZTRTN="DQ^LRRP8",ZTDESC="LR WKLD SHIFT REPORT"
 S:$G(LRAA) ZTSAVE("LRAA*")=""
 D ^%ZTLOAD,^%ZISC
 W:$G(ZTSK) !!,"TASK ",ZTSK," QUEUED." H 3
 Q
QDT ;*** Query for a specific date ***
 W !
 S DIC="^LRO(64.1,"_LRIN_",1,",DIC(0)="AQENM" D ^DIC
 I Y=-1 S LREND=1 Q
 S (LRDATE,LRFR,LRTO)=+Y,LRDR=1 D DD^%DT
 S LRDTH="For: "_Y
 Q
QST ;*** Query for shifts ***
 N I3
 S LRSTFLG=1 W !,"How many shifts?"
 K DIR S DIR(0)="N^1:4:0"
 D ^DIR K DIR S LRNSFT=X I $D(DIRUT)!($D(DUOUT)) S LREND=1 Q
 F I3=1:1:LRNSFT D  Q:LREND
 . W !!,"For Shift # ",I3
 . D QTR Q:LREND=1
 . S LRST(I3)=LRSTRT_"^"_LRSTOP
 Q
QTR ;*** Query for a time range (in military format) ***
 W !,"Enter TIME RANGE in military format HHMM.SS (0.00 - 2400.00):"
 K DIR S DIR(0)="LO^0.00:2400.00",DIR("A")="START time: "
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S LREND=1 Q
 S LRSTRT=X S:+LRSTRT=0 LRSTRT=.01 I LRSTRT="" G QTR
Q1 K DIR S DIR(0)="LO^0.00:2400.00",DIR("A")="STOP time: "
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S LREND=1 Q
 S LRSTOP=X I LRSTOP="" G Q1
 I LRSTOP<LRSTRT W !,"Stop time should be GREATER than start time" G QTR
 Q
