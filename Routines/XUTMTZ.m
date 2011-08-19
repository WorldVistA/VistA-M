XUTMTZ ;SEA/RDS - Taskman: Toolkit: Test Utilities (General) ;10/01/97  15:11
 ;;8.0;KERNEL;**67**;Jul 10, 1995
LOAD ;Load up Queue jobs
 W !,"This call will allow you to start a large number of tasks for",!,"TaskMan to run."
 R !,"Enter the number of jobs to start: ",JOBS:DTIME Q:+JOBS'>0
 L +^TMP("XUTMTZ") K ^TMP("XUTMTZ"),ZTIO,ZTUCI,ZTCPU W !,"use '^' for no device."
 S %ZIS="Q" D ^%ZIS S TASKIO=POP
 S %DT="AETSX",%DT("B")="NOW" D ^%DT Q:Y<1  S XUDTH=Y
LD2 R !,"Entry point to use: ",RTN:DTIME
 I RTN["?" D  G LD2
 . F I=3:1 S X=$T(+I) Q:X=""  W:$E($P(X," ",2),1,2)=";;" !,X
 I $T(@RTN)'[";;" W !,"Not valid" G LD2
 W !,"=============================================================="
 W !,"New Batch:  ",$H,"...",$J,!,"Tasks: "
 F QUASI=1:1:JOBS S ZTRTN=RTN_"^XUTMTZ",ZTDTH=XUDTH,ZTDESC=$T(@RTN)_", Job #"_QUASI S:TASKIO ZTIO="" D ^%ZTLOAD W ZTSK,", "
 W !,"..............................................................."
 D HOME^%ZIS L -^TMP("XUTMTZ")
 Q
 ;
ERROR ;;Test Taskman's Error Handling
 S ^TMP("XUTMTZ",$H,$J)=ZTSK_", TEST ERROR HANDLING"
 H 1 X "ERROR "
 ;
BASIC ;;Basic Test With Hang
 L +^TMP("XUTMTZ") S ^TMP("XUTMTZ",$H,$J)=ZTSK_", BASIC TEST"_U_ZTDESC
 I IO]"" W "." S IONOFF=1
 H 1 L -^TMP("XUTMTZ") Q
 ;
QUICK ;;Quick Test To Exercise Submanager
 S FRANK="HONEST" Q
 ;
STOP ;;Test Stop Code
 S ^TMP("XUTMTZ",$H,$J)=ZTSK_", STOP CODE TEST: "
 H 60
 I $$S^%ZTLOAD S ZTSTOP=1,^TMP("XUTMTZ",$H,$J)="Stop Request Acknowledged." Q
 S ^TMP("XUTMTZ",$H,$J)="No Stop Request Detected." Q
 ;
SIZE ;TOOL--SIZE OF ROUTINES
 X ^%ZOSF("RSEL") S ZT1="" F ZT=0:0 S ZT1=$O(^TMP($J,ZT1)) Q:ZT1=""  X "ZL @ZT1 X ^%ZOSF(""SIZE"") W !,ZT1,?10,Y,?15,"" "",$P($P($T(+1),"";"",2),""-"",2,999)"
 K ^TMP($J) Q
 ;
MULTPL ;test task--Test running multiple managers on different nodes of VAXcluster
 L +^TMP("XUTMTZ") H 1
 W !,"..............................................................."
 W !,ZTSK,":  ",$H,"...",$J
 L -^TMP("XUTMTZ") Q
 ;
STOP2 ;;Test ZTSTOP code
 F ZT=1:1:792 S X=$$S^%ZTLOAD Q:X  W 9
 I X S ZTSTOP=1
 Q
 ;
WATCH ;DON'T QUEUE--watch tasks as they are scheduled and unscheduled
 S ZTSK=0
 F ZT=0:0 D LOOKUP W !,"Update: ",ZTU,?15,"Queued: ",ZTS,?30,"Late: ",ZTO,?40,"New: ",ZTN,?50,"Subs: ",ZTSU,?60,"Free Subs: ",ZTF R X:1 Q:X="^"
 Q
 ;
LOOKUP ;WATCH--get data to show
 S ZTH=$H,ZTR=$S($D(^%ZTSCH("RUN"))#2:^("RUN"),1:""),ZTU="off"
 I ZTR S ZTU=ZTH-ZTR*86400+$P(ZTH,",",2)-$P(ZTR,",",2) I ZTU>99 S ZTU="late"
 S ZT1=0,ZTO=0,ZTS=0 F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:'ZT2  S ZTS=ZTS+1,ZTH=$H I ZTH-ZT1*86400+$P(ZTH,",",2)-$P(ZT1,",",2)>0 S ZTO=ZTO+1
 S ZTN=^%ZTSK(-1)-ZTSK,ZTSK=^(-1)
 S ZTSU=0,ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("TASK",ZT1)) Q:ZT1=""  S ZTSU=ZTSU+1
 S ZTF=0 I $D(^%ZTSCH("SUB"))#2 S ZTF=^("SUB"),ZTSU=ZTSU+ZTF
 Q
 ;
HANG ;;Wait five minutes then quit
 H 300 Q
 ;
OWN ;;Hold a device until told to release it
 F A=0:0 H 1 I $D(^%ZTSK(ZTSK,.4))#2 Q
 Q
 ;
QOWN ;entry--queue an own task
 S ZTRTN="OWN^XUTMTZ",ZTDTH=$H,ZTIO="",ZTDESC="Toad test 1",ZTSAVE("ZTREQ")="@" D ^%ZTLOAD Q
 ;
Q ;entry--queue a test task
 S ZTRTN="QUICK^XUTMTZ",ZTDTH=$H,ZTIO="",ZTDESC="Toad test",ZTSAVE("ZTREQ")="@" D ^%ZTLOAD Q
 ;
DELAY ;;Record delay in start
 S ZTN=$H,ZTO=$P(^%ZTSK(ZTSK,0),"^",6),Y=$$DIFF^%ZTM(ZTN,ZTO,0)
 S ^TMP("XUTMTZ",ZTN,ZTSK)="DELAY^"_IO_"^"_ZTN_"^"_ZTO_"^"_Y
 I $$S^%ZTLOAD("DELAY TIME IS "_Y)
 Q
PTASK ;;See if persistent status works.
 S CNT=$G(^%ZTSCH("TASK",ZTSK,"CNT"),0)
 S ^%ZTSCH("TASK",ZTSK,"CNT",CNT)=$$HTE^XLFDT($H)
 I '$D(^%ZTSCH("TASK",ZTSK,"P")) S X=$$PSET^%ZTLOAD(ZTSK) H 15 HALT
 H 30
 S ^("CNT")=$G(^("CNT"))+1 I ^("CNT")>5 S X=$$PCLEAR^%ZTLOAD(ZTSK) Q
 HALT
 Q
