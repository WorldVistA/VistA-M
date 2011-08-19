%ZTMS2 ;SEA/RDS-TaskMan: Submanager, Part 4 (Unload, Get Device) ;2/19/08  13:38
 ;;8.0;KERNEL;**2,18,23,36,67,118,127,163,167,175,199,275,446**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;^%ZTSK(ZTSK),^%ZTSCH("DEV",IO) is locked on entry or return from GETNEXT
PROCESS ;SUBMGR--process task and all others waiting for same device
 L +^%ZTSCH("TASK",ZTSK):1 I '$T Q  ;Only allow one copy of a task at one time
 D LOOKUP I $D(ZTREJECT) Q
 D DEVICE
 I POP L  Q  ;Release all locks
 I ZTSYNCFL]"",'$$SYNCFLG("A",ZTSYNCFL,%ZTIO) D  Q
 . D SYNCQ(ZTSYNCFL,%ZTIO,ZTDTH,ZTSK),^%ZISC L  ;Release all locks
 . Q
 ;Go run task
 D TASK^%ZTMS3 I ZTYPE="C"!$D(ZTNONEXT) Q
 D GETNEXT^%ZTMS7 I $D(ZTNONEXT)!$D(ZTQUIT) Q
 G PROCESS
 ;
LOOKUP ;PROCESS--unload task, switch ucis, and test entry routine
 K (%ZTIME,%ZTIO,DT,IO,U,ZTCPU,ZTDEVN,ZTDTH,ZTNODE,ZTPAIR,ZTPFLG,ZTQUEUED,ZTSK,ZTUCI,ZTYPE,ZTLKTM) ;p446
 D TSKSTAT(4,"")
 S ZTREC=^%ZTSK(ZTSK,0),ZTREC02=^(.02)
 S ZTREC2=^%ZTSK(ZTSK,.2),ZTREC21=^(.21),ZTREC25=^(.25)
 S ZTSYNCFL=$P(ZTREC2,"^",7),DUZ=+$P(ZTREC,U,3),DUZ(0)="@"
 S X=$P(ZTREC02,U)_","_$P(ZTREC02,U,2)
 I $P(ZTREC02,U,4) S $P(X,",",2)=ZTCPU
 ;should do a check to see if X is OK, Should check UCI mapping.
 I X'=ZTUCI S ZTUCI=X D SWAP^%XUCI
 S X=$P($P(ZTREC,U,2),"("),ZTRTN=$P(ZTREC,U,1,2)
 I $E(X)'="%",$L(X) X ^%ZOSF("TEST") I X=""!'$T D REJECT S ZTREJECT=""
 Q
 ;
REJECT ;LOOKUP--entry routine isn't here; reject task
 N Y X ^%ZOSF("UCI")
 D TSKSTAT("B","No routine at destination "_Y_".")
 I $D(ZTDEVN) D DEVLK^%ZTMS1(-1,%ZTIO) K ZTDEVN
 L  Q  ;Clear all locks
 ;
DEVICE ;PROCESS--prepare requested device; if can't, make task wait
 ;First clean-up all IO variables that could influence the device
 K %ZIS,IO,IOCPU,IOHG,IOPAR,IOUPAR,IOS
 ;If don't need a device, Setup minimum.
 S ZTIO=$P(ZTREC2,U),ZTIOT=$P(ZTREC2,U,3)
 I ZTIO="" S (IO,IO(0),IOF,IOM,ION,IOS,IOSL,IOST,IOT)="",POP=0 Q
 ;
 ;setup call
 S %ZIS="LRS0"_$S($P(ZTREC2,U,5)="DIRECT":"D",1:"")
 S:ZTIOT="HFS" %ZIS("HFSIO")=$P(ZTREC2,U,6),%ZIS("IOPAR")=ZTREC25
 S:ZTIOT="MT" %ZIS("IOPAR")=ZTREC25
 S (IO,IO(0))=%ZTIO,IOP=ZTIO
 S:'$D(^%ZTSCH("DEVTRY",$P(ZTIO,";"))) ^($P(ZTIO,";"))=%ZTIME ;Set problem device check
 K ^XUTL("XQ",$J),IO("ERROR")
 ;
 S:$P(ZTREC2,U,4)["MINIOUT" %ZISLOCK="^%ZTSCH(""NETMAIL"",IO)" ;The hang is on the close
 ;call
 S %ZISTO=3 D ^%ZIS K %ZISTO,%ZISLOCK ;See that we use a timeout.
 I %ZTIO]"" D DEVLK^%ZTMS1(-1,%ZTIO) K ZTDEVN
 I 'POP K ^%ZTSCH("DEVTRY",IO),^($P(ZTIO,";")) ;Clear problem device check
 ;Reset %ZTIO if IO doesn't match
 I 'POP,%ZTIO]"",IO'=%ZTIO C %ZTIO K IO(1,%ZTIO),^%ZTSCH("DEVTRY",$P(%ZTIO,";")) S %ZTIO=IO
 ;
 ;results
 I POP,(ZTYPE'="C"),(ZTIOT="TRM")!(ZTIOT="RES")!(ZTIOT="HG") D IONQ Q  ;only add to IO queue if not type C.
 I POP D SCHNQ Q
 I IOT'="RES",IOT'="HG" U IO
 S IO(0)=IO
 I $P(^%ZIS(1,+IOS,0),U,7)="y" D ^%ZTMSH
 Q
 ;
IONQ ;DEVICE--put task on Device Waiting List
 I $D(^%ZTSK(ZTSK,0))[0 D TSKSTAT("I",4) G IOQX
 D TSKSTAT("A","")
 N %ZTIO S %ZTIO=IO
 S ZTIO(1)=$P(ZTREC2,U,5),ZTIOS=ZTREC21
 D NQ^%ZTM4 ;Uses %ZTIO as the Device $I value
IOQX L  Q  ;Clear all Locks
 ;
SCHNQ ;DEVICE--if HFS or SPL or TYPE'=C, reschedule task 10 min in future (try later)
 S ZTH=$$NEWH($H,300)
 D TSKSTAT(1,"rescheduled for busy device")
 S $P(^%ZTSK(ZTSK,.2),U,8)=$P(^%ZTSK(ZTSK,.2),U,8)+1 ;ReQ count
 D SCHTM(ZTH)
 I $L($G(IO("ERROR"))) S $P(^%ZTSK(ZTSK,.12),U,2,9)=$H_U_IO("ERROR") ;May tell why couldn't get device
 L  Q  ;Clear all locks
 ;
SCHTM(ZTDTH) ;Set a new schedule time, See that task is updated
 S $P(^%ZTSK(ZTSK,0),U,6)=$$H0^%ZTM(ZTDTH),^%ZTSK(ZTSK,.04)=ZTDTH,^%ZTSCH(ZTDTH,ZTSK)=""
 Q
NEWH(%H,%Y) ;Build a new schedule time, Return $H3 time.
 N %
 I %H["," S %H=$$H3^%ZTM(%H)
 Q (%H+%Y)
 ;
SYNCFLG(ACT,FLAG,ZIO,STAT) ;Allocate/deallocate sync flag
 N X,DA,SYNC
 L +^%ZISL(14.8):30 E  Q 0
 S X=0,SYNC=FLAG_"~"_ZIO,DA=$O(^%ZISL(14.8,"B",SYNC,0))
 I ACT["A" D
 . I DA S X=0 Q
 . ;I $D(^%ZTSCH("SYNC",ZIO,FLAG)) S X=0 Q
 . S X=$P(^%ZISL(14.8,0),"^",3)+1 F  Q:'$D(^%ZISL(14.8,X))  S X=X+1
 . S $P(^(0),"^",3,4)=X_"^"_($P(^%ZISL(14.8,0),"^",4)+1),^%ZISL(14.8,X,0)=SYNC,^%ZISL(14.8,"B",SYNC,X)=""
 . S X=1 Q
 I ACT["D" D  S X=1
 . Q:DA'>0
 . K ^%ZISL(14.8,DA),^%ZISL(14.8,"B",SYNC,DA)
 . S $P(^(0),"^",3,4)=(DA-1)_"^"_($P(^%ZISL(14.8,0),"^",4)-1)
 . Q
 I ACT["S" D  S X=1
 . Q:DA'>0
 . S ^%ZISL(14.8,DA,1)=$G(STAT)
 . Q
 I ACT["?" S X=(DA)!($D(^%ZTSCH("SYNC",ZIO,FLAG)))
 L -^%ZISL(14.8)
 Q X
 ;
SYNCQ(FLAG,ZIO,ZTH,ZTSK) ;Put task on sync flag waiting list
 L +^%ZTSCH("SYNC")
 S ^%ZTSCH("SYNC",ZIO,FLAG,ZTSK)=ZTH
 L -^%ZTSCH("SYNC")
 Q
SCHSYNC(FLAG,ZIO) ;put a waiting task in IO queue
 L +^%ZTSCH("SYNC") I $D(^%ZTSCH("SYNC",ZIO,FLAG)) N ZTH,ZTSK D
 . S ZTSK=$O(^(FLAG,0)),ZTH=$G(^(+ZTSK)) Q:ZTSK=""  S:$D(^%ZTSCH("IO",ZIO))[0 ^(ZIO)=IOT
 . S ^%ZTSCH("IO",ZIO,ZTH,ZTSK)=""
 . K ^%ZTSCH("SYNC",ZIO,FLAG,ZTSK)
 . Q
 L -^%ZTSCH("SYNC")
 Q
TSKSTAT(CODE,MSG) ;Record status
 S $P(^%ZTSK(ZTSK,.1),U,1,3)=$G(CODE)_U_$H_U_$G(MSG)
 Q
 ;
POST ;Post INIT cleanup for patch XU*8*167
 N T S T=0
 F  S T=$O(^%ZTSCH(T)) Q:T'>0  I $D(^%ZTSCH(T,0)) K ^%ZTSCH(T,0)
 Q
