XUTMK ;SEA/RDS - Taskman: Option, ZTMCLEAN/ZTMQCLEAN ;11/1/07  14:44
 ;;8.0;KERNEL;**49,67,118,169,222,275,446**;Jul 10, 1995;Build 35
 ;
SETUP ;Setup Variables And Synchronize ^%ZTSK With ^%ZTSCH
 S ZTDTH=0
 F  S ZTDTH=$O(^%ZTSCH(ZTDTH)) Q:'ZTDTH  F ZTS=0:0 S ZTS=$O(^%ZTSCH(ZTDTH,ZTS)) Q:'ZTS  D
 . L +^%ZTSK(ZTS):2 Q:'$T  K:$D(^%ZTSK(ZTS,0))[0 ^%ZTSK(ZTS),^%ZTSCH(ZTDTH,ZTS)
 . S:$D(^%ZTSK(ZTS,0))#2 $P(^(0),U,6)=$$H0^%ZTM(ZTDTH)
 . L -^%ZTSK(ZTS) Q
 I $D(ZTKEEP)#2 G SX
 S ZTKEEP="",ZTV=^%ZOSF("VOL"),ZTI=$O(^%ZIS(14.5,"B",ZTV,""))
 I ZTI]"",$D(^%ZIS(14.5,ZTI,0))#2 S ZTKEEP=$P(^(0),U,9)
SX S:ZTKEEP="" ZTKEEP=7 S ZTKEEP=$H-ZTKEEP,ZTCNT=0,ZTMAX=100,ZTS=.9
 ;
CLEAN ;Delete Obsolete Entries
 I '(ZTCNT#20),$$S^%ZTLOAD S ZTSTOP=1 Q
 S ZTS=$O(^%ZTSK(ZTS)) I 'ZTS G FINAL
 S ZTMAX=ZTS,ZTCNT=ZTCNT+1
 L +^%ZTSK(ZTS):0 I '$T G CLEAN
 I $D(^%ZTSK(ZTS,0))[0 K ^%ZTSK(ZTS) W:'$D(ZTQUEUED) "." G NEXT
 ;
1 ;keep active tasks
 I $D(^%ZTSCH("TASK",ZTS)) G NEXT
 S ZTREC=^%ZTSK(ZTS,0),ZTDTH=$P(ZTREC,U,6) I ZTDTH="" G 2
 S:ZTDTH'["," ZTDTH=$$H0^%ZTM(ZTDTH) S ZTDTH3=$$H3^%ZTM(ZTDTH)
 I $D(^%ZTSCH(ZTDTH3,ZTS)) G NEXT
 I $D(^%ZTSCH("JOB",ZTDTH3,ZTS)) G NEXT
 S ZTCNTPU=$P(ZTREC,U,14),ZTIO=$P($G(^%ZTSK(ZTS,.2)),U,2)
 I ZTCNTPU]"",$D(^%ZTSCH("LINK",ZTCNTPU,ZTDTH3,ZTS)) G NEXT
 I ZTIO]"",$D(^%ZTSCH("IO",ZTIO,ZTDTH3,ZTS)) G NEXT
 ;
2 ;keep young inactive tasks
 S Z1=$G(^%ZTSK(ZTS,.1))
 I Z1]"",$P(Z1,U,8),$H'>$P(Z1,U,8) G NEXT ;Remember Until
 S ZTF=$S($P(Z1,U)="":0,"135AG"[$P(Z1,U):0,1:$P(Z1,U,2)'<ZTKEEP) ;Last status update
 S ZTF=$S(ZTF:ZTF,ZTDTH="":0,1:ZTDTH'<+ZTKEEP) ;Run time
 S ZTF=$S(ZTF:ZTF,$P(ZTREC,U,5)="":0,1:$P(ZTREC,U,5)'<+ZTKEEP) ;creation date
 I ZTF G NEXT
 ;
3 ;delete old inactive tasks
 K ^%ZTSK(ZTS) W:'$D(ZTQUEUED) "."
 ;
NEXT L -^%ZTSK(ZTS)
 G CLEAN
 ;
FINAL ;Final Steps.
 L +^%ZTSK(-1) ;lock top
 S $P(^%ZTSK(0),"^",3,4)=ZTMAX_"^"_ZTCNT
 I ^%ZTSK(-1)>9000000 S ^%ZTSK(-1)=100
 L -^%ZTSK(-1)
 D CLIST,TASK,SUB,CLEARIO,MONITOR
 ;Call TM error purge
 S %=$$PURGE^XUTMKE(0,ZTKEEP,"")
 ;Clear bad time
 K ^%ZTSCH(0)
 K ZT,ZTDTH,ZTF,ZTI,ZTKEEP,ZTS,ZTV
 Q
 ;
CLIST ;Clean up the C list
 S ZT1=""
 F  S ZT1=$O(^%ZTSCH("C",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("C",ZT1,ZT2)),ZT3="" Q:ZT2=""  D
 . F  S ZT3=$O(^%ZTSCH("C",ZT1,ZT2,ZT3)) Q:ZT3=""  I $D(^%ZTSK(ZT3,0))[0 K ^%ZTSCH("C",ZT1,ZT2,ZT3)
 . Q
 Q
TASK ;Clean the TASK nodes.
 N ZT1,ZT2
 F ZT1=0:0 S ZT1=$O(^%ZTSCH("TASK",ZT1)) Q:ZT1'>0  D
 . L +^%ZTSCH("TASK",ZT1):0 Q:'$T
 . S ZT2=$G(^%ZTSCH("TASK",ZT1)),$P(ZT2,U,5)=$G(^(ZT1,1))
 . L -^%ZTSCH("TASK",ZT1)
 . I ZT2="^^^^" K ^%ZTSCH("TASK",ZT1) Q
 . I $D(^%ZTSCH("TASK",ZT1,"P")) Q  ;Persistent tasks
 . I "^XMAD^"[(U_$E($P(ZT2,U,2),1,4)_U) Q
 . I $H-$P(ZT2,U,5)>4  K ^%ZTSCH("TASK",ZT1)
 . Q
 Q
 ;
SUB ;Sync the SUB nodes
 D SUBCHK^%ZTMS5($G(DILOCKTM,2))
 Q
CLEARIO ;Clear any empty IO lists
 L +^%ZTSCH("IO"):5 Q:'$T
 S ^%ZTSCH("WAIT","MGR")="XUTMK",^%ZTSCH("WAIT","SUB")="XUTMK"
 L -^%ZTSCH("IO")
 N %ZTIO,%ZTPAIR S %ZTIO="" H 10 ;Let jobs see flag
 F  S %ZTIO=$O(^%ZTSCH("IO",%ZTIO)) Q:%ZTIO=""  D
 . I $D(^%ZTSCH("IO",%ZTIO))=1 D
 . . K ^%ZTSCH("DEVTRY",%ZTIO)
 . . I $G(^%ZTSCH("IO",%ZTIO))="RES" Q  ;Leave Resource devices
 . . K ^%ZTSCH("IO",%ZTIO)
 . Q
 ;Now Clear and empty "C" lists
 S %ZTPAIR=""
 F  S %ZTPAIR=$O(^%ZTSCH("C",%ZTPAIR)) Q:%ZTPAIR=""  D
 . I $O(^%ZTSCH("C",%ZTPAIR,0))="" K ^%ZTSCH("C",%ZTPAIR)
 . Q
 K ^%ZTSCH("WAIT","MGR"),^%ZTSCH("WAIT","SUB")
 Q
 ;
MONITOR ;Move any Monitor data,
 N ZT1,ZT2,ZR,ZR2,IEN,ZFDA,X,DA,DIK
 I '($D(^%ZIS(14.71,0))#2) S ^%ZIS(14.71,0)="TASKMAN MONITOR^14.71D^"
 S ZT1="",IEN=0,ZR=$NA(^%ZTSCH("MON"))
 F  S ZT1=$O(@ZR@(ZT1)),ZT2=0 Q:ZT1=""  D
 . F  S ZT2=$O(@ZR@(ZT1,ZT2)) Q:ZT2=""  D
 . . S IEN=IEN+1,ZR2=$NA(ZFDA(14.71,"+"_IEN_","))
 . . S Y=@ZR@(ZT1,ZT2)
 . . S @ZR2@(.01)=$$HTFM^XLFDT(ZT2),@ZR2@(2)=ZT1
 . . F I=3:1:26 S @ZR2@(I)=$P(Y,U,I-2)
 . . D UPDATE^DIE("","ZFDA")
 . . K @ZR@(ZT1,ZT2),ZFDA ;Clear Global and Local.
 . . Q
 . Q
 ;Remove old data
 S ZT1=0,ZR2=$$HTFM^XLFDT($H-365)
 F  S ZT1=$O(^%ZIS(14.71,ZT1)) Q:'ZT1  S ZT2=$G(^(ZT1,0)) Q:$P(ZT2,U)>ZR2  D
 . S DA=ZT1,DIK="^%ZIS(14.71," D ^DIK
 . Q
 Q
 ;
OPTION ;Entry Point For ZTMCLEAN Option
 W !!,"This option queues a task to clean up the Task file."
 W !,"All tasks that have been inactive for a certain number of days are deleted.",!
 ;
ZTKEEP ;ask user how long to keep inactive tasks
 S DIR(0)="NA^0:365",DIR("A")="Number of days to save inactive tasks: ",DIR("B")=""
 S ZTV=^%ZOSF("VOL"),ZTI=$O(^%ZIS(14.5,"B",ZTV,""))
 I ZTI]"",$D(^%ZIS(14.5,ZTI,0))#2 S DIR("B")=$P(^(0),U,9)
 I DIR("B")="" S DIR("B")=7
 S DIR("?")="     Answer must be an integer between 0 and 365",DIR("??")="^D HELP1^XUTMK"
 D ^DIR W:$D(DTOUT) $C(7)
 K DIR,DIRUT,DTOUT,DUOUT,ZTI,ZTV
 I Y'=0&'Y K %,X,Y D NOTQED Q
 S ZTKEEP=Y
 ;
ZTDTH ;ask user when to start the cleanup
 S DIR(0)="DA^::AERSX",DIR("A")="Start time for cleanup task: ",DIR("B")="NOW"
 S DIR("?")="     Answer must be a date and time",DIR("??")="^D HELP2^XUTMK"
 D ^DIR W:$D(DTOUT) $C(7)
 K DIR,DIRUT,DTOUT,DUOUT
 I 'Y K %,X,Y D NOTQED Q
 S ZTDTH=Y
 ;
QUEUE ;queue the cleanup task
 S ZTRTN="XUTMK",ZTIO="",ZTDESC="TaskMan: clean the Task file",ZTSAVE("ZTKEEP")=""
 D ^%ZTLOAD
 W !!?5,"Task file cleanup queued!" H 1
 K ZTSK Q
 ;
HELP1 ;ZTKEEP--?? help for first prompt
 W !!?5,"Answer how many days inactive tasks should be kept."
 W !?5,"Any task currently scheduled, waiting, or running is still active."
 Q
 ;
HELP2 ;ZTDTH--?? help for second prompt
 W !!?5,"Answer exactly when the task should begin the cleanup."
 Q
 ;
NOTQED ;OPTION--feedback when task is canceled
 W !!?5,"Task file cleanup NOT queued!" H 1
 Q
 ;
