LRCKF ;SLC/RWF - CHECK FILE FOR COHESIVENESS ; 8/30/87  17:19 ;
 ;;5.2;LAB SERVICE;**272,293**;Sep 27, 1994
 D DT^LRX
 W !,"I WILL CHECK ALL LAB FILES TO LOOK FOR INCONSISTENCIES",!!
 D LOG Q:LREND  Q:POP
L D ENT^LRCKF60,ENT^LRCKF62,ENT^LRCKFLA,ENT^LRCKF68,ENT^LRCKF69,ENT^LRACDIAG,ENT^LRCKPTR ;,LRCKF^LRBLJI
 K LRCKW
 W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
LOG ;from LRCKF60, LRCKF62, LRCKF68, LRCKF69, LRCKFLA
 S U="^" D DT^LRX S LREND=0
 W !,"DO YOU WANT WARNINGS REPORTED " S %=2 D YN^DICN G LOG:%=0 S LRCKW=(%=1) I %<0 S LREND=1 Q
ASK W !!,"Do you want to only check tests in file 60 that are orderable and/or",!,"printable" S %=1 D YN^DICN Q:%=-1  G:%=0 HELP I %=1 S LRYES=1
 W !,"Where should I send the problem report?",! S %ZIS("A")="REPORT DEVICE: ",%ZIS="QM" D ^%ZIS I POP S LREND=1 Q
 I $D(IO("Q")) K IO("Q") S:'$D(ZTRTN) ZTRTN="DQ^LRCKF" S LREND=1,ZTSAVE("LRCKW")="",ZTDESC="Integrity Report" D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED" K ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE Q
 Q
DQ S:$D(ZTQUEUED) ZTREQ="@" U IO D DT^LRX G L
HELP W !!,"Enter 'YES' if you want me to only check tests that are orderable and/or",!,"printable.  Enter 'NO' if you want me to check all tests in file 60." G ASK
