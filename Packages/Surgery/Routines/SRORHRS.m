SRORHRS ;B'HAM ISC/ADM - O.R. NORMAL WORKING HOURS ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S SRSOUT=0 W @IOF,!,"Operating Room Normal Working Hours Report",!
DATE W ! K %DT S %DT="AEPX",%DT("A")="Print normal working hours starting with which date ?  " D ^%DT I Y<0 S SRSOUT=1 G END
 S SRSD=+Y
 W ! K %DT S %DT="AEPX",%DT("A")="Print normal working hours through which date ?  " D ^%DT I Y<0 S SRSOUT=1 G END
 I Y<SRSD W !!,"The ending date must be more recent than the starting date." G DATE
 S SRED=+Y
ROOMS ; all operating rooms ?
 S SROR="ALL" W @IOF,!,"Do you want to print the Operating Room Normal Working Hours Report for all",!,"operating rooms ?  YES//  " R SRYN:DTIME I SRYN["^" S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to print the normal working hours for every operating",!,"room, or 'NO' to print the report for one particular room.",!!,"Press RETURN to continue  " R X:DTIME G ROOMS
 I "Yy"[SRYN G ZIS
 W ! K DIC S DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),('$P(^SRS(+Y,0),U,6))",DIC="^SRS(",DIC(0)="QEAMZ",DIC("A")="Print the report for which Operating Room ?  " D ^DIC I Y<0 S SRSOUT=1 G END
 S SROR=+Y
ZIS W ! K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the report on which Device: ",%ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="O.R. Normal Working Hours Report",ZTRTN="EN^SRORHRS",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SROR"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
EN ; entry when queued
 N SRFRTO S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 D ^SRORHRS0
END I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC,^SRSKILL W @IOF
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 W:$Y @IOF W ! W:$E(IOST)="P" ?(80-$L(SRINST)\2),SRINST,?76,"PAGE",!,?31,"SURGICAL SERVICE",?78,SRPAGE,! W ?22,"OPERATING ROOM NORMAL WORKING HOURS"
 W !,?(80-$L(SRFRTO)\2),SRFRTO
 W !!,$S(SROR="ALL":"OPERATING ROOM",1:"DATE"),?20,"START TIME",?35,"END TIME",?62,"TOTAL TIME",! F LINE=1:1:80 W "-"
 I SRHDR,SROR="ALL" W !,?31,"** "_SRDT_" **",!!
 I SROR'="ALL" W !,?(80-$L("** OPERATING ROOM: "_$P(^SC($P(^SRS(SROR,0),"^"),0),"^")_" **")\2),"** OPERATING ROOM: "_$P(^SC($P(^SRS(SROR,0),"^"),0),"^")_"  **",!!
 S SRHDR=1,SRPAGE=SRPAGE+1
 Q
