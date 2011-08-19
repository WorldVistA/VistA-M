XUTMTR2 ;SEA/RDS - TaskMan: ToolKit, Report 2 (Status & Stop) ;05/26/98  16:42
 ;;8.0;KERNEL;**86**;Jul 10, 1995
 ;
TASK ;Lookup Task File Data And Set Stop Flag
 L +^%ZTSK(XUTMT) I '$D(^%ZTSK(XUTMT)),'$D(^%ZTSCH("TASK",XUTMT)) W !,"Task # ",XUTMT," does not exist." G NOPE
 I $D(^%ZTSK(XUTMT,0))[0,'$D(^%ZTSCH("TASK",XUTMT)) W !,"Task # ",XUTMT," does exist, but is missing critical data." G NOPE
 S ZTSK=XUTMT,ZTSK(0)=$S($D(^%ZTSK(ZTSK,0))#2:^(0),1:""),ZTSK(.1)=$S($D(^(.1))#2:^(.1),1:""),ZTSK(.2)=$S($D(^(.2))#2:^(.2),1:""),ZTSK(.26)=$S($D(^(.26))#2:^(.26),1:"")
 N %,%D,%H,%M,%Y,%ZTT,X,Y,ZT,ZT1,ZT2,ZT3,ZTC,ZTUNSCH S $P(^%ZTSK(ZTSK,.1),U,10)=ZTNAME,ZTUNSCH=0
 ;
SCHED ;Lookup Task In Schedule File And Unschedule Task
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  I $D(^%ZTSCH(ZT1,ZTSK))#2 S ZTSK("A",ZT1,ZTSK)="",ZT2=^(ZTSK),ZTUNSCH=1 K ^%ZTSCH(ZT1,ZTSK) I ZT2]"" S $P(^%ZTSK(ZTSK,.2),U)=ZT2,$P(ZTSK(.2),U)=ZT2
 S ZT1=""
 F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK))#2 S ZTSK("IO",ZT1,ZT2,ZTSK)="",ZTUNSCH=1 D DQIO
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  I $D(^(ZT1,ZTSK))#2 S ZTSK("JOB",ZT1,ZTSK)="",ZTUNSCH=1 K ^(ZTSK)
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK))#2 S ZTSK("LINK",ZT1,ZT2,ZTSK)="",ZTUNSCH=1 K ^(ZTSK)
 S:$D(^%ZTSCH("TASK",ZTSK))#2 ZTSK("TASK",ZTSK)=^(ZTSK) S:ZTUNSCH $P(^%ZTSK(ZTSK,.1),U,1,3)="F^"_$H_U_ZTNAME
 L -^%ZTSK(XUTMT)
 ;
REPORT ;Report Results Of Lookup And Stop
 I $D(ZTSK("TASK",ZTSK)) W !,"This task has already started running, but it has been asked to stop." W:$D(^%ZTSK(ZTSK,0))[0 !?5,"The task's record is missing critical data." K XUTMT Q
 I $O(ZTSK(.3))]"" W !,"Task unscheduled and stopped." K XUTMT Q
 I "1356ABCDEFGIL"[$P(ZTSK(.1),U) W !,"This task was already stopped." K XUTMT Q
 W !,"Task stopped!" K XUTMT Q
 ;
DQIO ;Remove A Device Waiting List Entry
 N %ZTIO,ZTDTH S %ZTIO=ZT1,ZTDTH=ZT2 L +^%ZTSK(ZTSK),+^%ZTSCH("IO") D DQ^%ZTM4 L -^%ZTSCH("IO"),-^%ZTSK(ZTSK) Q
 ;
NOPE L -^%ZTSK(XUTMT) K XUTMT Q
