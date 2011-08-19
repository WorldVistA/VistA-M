XUTMTS ;SEA/RDS - TaskMan: ToolKit, Stop Task ;04/17/95  10:11
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
TASK ;Lookup Task File Data
 S ZTSK=XUTMT L +^%ZTSK(ZTSK):5 I '$T S ZTSK="" G NOPE
 I '$D(^%ZTSK(ZTSK)),'$D(^%ZTSCH("TASK",ZTSK)) S ZTSK="" G NOPE
 ;S $P(^%ZTSK(ZTSK,.1),U,10)=ZTNAME,ZTSK(0)=$S($D(^%ZTSK(ZTSK,0))#2:^(0),1:""),ZTSK(.1)=$S($D(^(.1))#2:^(.1),1:""),ZTSK(.2)=$S($D(^(.2))#2:^(.2),1:""),ZTSK(.25)=$S($D(^(.25))#2:^(.25),1:"")
 N XUTMP
 D LOAD^XUTMUTL(XUTMT,"XUTMP")
 ;S ZTUNSCH=0
 ;
SCHED ;Lookup Task In Schedule File And Dequeue It
 D DQ^%ZTLOAD
 ;ZTUNSCH is to tell if task was found in a list
 ;Need to Mod %ZTLOAD6 if needed
 ;I $D(^%ZTSCH(ZT1,ZTSK))#2 S ZTSK("A",ZT1,ZTSK)="",ZT2=^(ZTSK),ZTUNSCH=1 K ^(ZTSK) I ZT2]"" S $P(^%ZTSK(ZTSK,.2),U)=ZT2,$P(ZTSK(.2),U)=ZT2
 ;I $D(^(ZT2,ZTSK))#2 S ZTSK("JOB",ZT1,ZT2,ZTSK)="",ZTUNSCH=1 K ^(ZTSK)
 ;I $D(^(ZT2,ZTSK))#2 S ZTSK("LINK",ZT1,ZT2,ZTSK)="",ZTUNSCH=1 K ^(ZTSK)
 S:$D(^%ZTSCH("TASK",ZTSK))#2 ZTSK("TASK",ZTSK)=^(ZTSK)
 ;
QUIT ;Set Status For Task And Quit
 S XUTMP=ZTSK M ZTSK=XUTMP
 S $P(^%ZTSK(ZTSK,.1),U,1,3)="F^"_$H_U_ZTNAME
NOPE L -^%ZTSK(XUTMT) K XUTMT
 Q
 ;
SCHEDIO ;Extend Waiting List Traversal Loop
 N %ZTIO,ZTDTH,XUTMUCI S ZTSK("IO",ZT1,ZT2,ZT3,ZTSK)="",%ZTIO=ZT1,ZTDTH=ZT2,XUTMUCI=ZT3,ZTUNSCH=1 L +^%ZTSCH("IO"):15 D DQ^%ZTM4 L -^%ZTSCH("IO") Q
 ;
