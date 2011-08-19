LRMITS ;SLC/STAFF - MICRO TREND ;10/14/92  15:59
 ;;5.2;LAB SERVICE;**96**;Sep 27, 1994
 ; from option LRMITS
 ;
 S LREND=0 D ^LRMITSE I LREND D CLEANUP Q
 ; device
DEVICE S %ZIS="MNQ",%ZIS("B")="",IOP="Q" D ^%ZIS I POP D CLEANUP Q
 ; default time
 S %DT="AET",%DT("A")="TIME TO RUN: T+1@1AM// " D ^%DT I X[U!$D(DTOUT) D CLEANUP Q
 S:Y>0 ZTDTH=Y I Y'>0 S %DT="T",X="T+1@1AM" D ^%DT S ZTDTH=Y
 ; it's possible to display this report to the home device
 ; for device enter 0, for queueing enter NO, then return at device and time prompts (time is ignored)
 I '$D(IO("Q"))&(IO'=IO(0)) W !!,"Please queue this report if not viewing on your screen",!! H 2 G DEVICE
 I '$D(IO("Q")) K ZTDTH D DQ^LRMITSP,CLEANUP Q
 ; queue report
 S ZTIO=ION,ZTDESC="MICRO TREND REPORT",ZTRTN="DQ^LRMITSP",ZTSAVE("LR*")=""
 D ^%ZTLOAD W !,$S($D(ZTSK):"Request queued",1:"Request canceled") D HOME^%ZIS K ZTSK
CLEANUP ; from LRMITSP
 W !! W:$E(IOST)="P" @IOF D ^%ZISC K ^TMP($J),%DT,DIR,DIRUT,DTOUT,DUOUT,LRAP,LRATS,LRDETAIL,LREND,LRFBEG,LRFEND,LRLOS,LRMERGE,LRM,LROTYPE,LRSORG,LRTBEG,LRTEND,LRTSAL,LRUNK,X,Y,LRAINT,LRNODE,LRSORT
 Q
