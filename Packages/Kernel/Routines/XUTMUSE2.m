XUTMUSE2 ;SEA/RDS - TaskMan: Option, XUTMUSER, Part 3 (Edit) ;05/26/98  16:46
 ;;8.0;KERNEL;**36,86**;Jul 10, 1995
 ;
TASK ;Handle Unusual Tasks
 N ZTD,ZTDEFALT,ZTL,ZTX
 I $D(^%ZTSK(XUTMT,0))[0 W !,"This task's record is missing critical data.  There's nothing to edit." Q
 I $D(^%ZTSCH("TASK",XUTMT)) W !,"This task is currently running.  You should either wait for the task to stop",!?5,"running, or use the Stop Task action to try to stop it sooner." Q
 ;
STOP ;Report Need To Stop Task, Prompt For Confirmation
 W ! S DIR(0)="YO",DIR("A")="Before you edit the task I must unschedule it, is this okay",DIR("B")="YES",DIR("?")="Yes - task will be unscheduled and you can edit it.  No - don't edit."
 D ^DIR K DIR I $D(DIRUT)!'Y W !,"Task not changed." Q
 D ^XUTMTS I ZTSK<1 W !!,"Task not available for editing."
 W !,"Task ready for editing."
 ;
OUTPUT ;Report Whether Task Involved Output
 W ! W:$P(ZTSK(.2),U)="" !,"Currently, this task does not request an output device." W:$P(ZTSK(.2),U)]"" !,"Currently, this task requests output device ",$P($P(ZTSK(.2),U),";"),"."
 S DIR(0)="YO",DIR("A")="Do you want to change the output device for this task",DIR("B")="NO"
 D ^DIR Q:$D(DIRUT)  K DIR I 'Y G RUNTIME
 ;
DEVICE ;Allow User To Change Output Device Request
 S ZTSK(.2)="",ZTSK(.25)="" K ZTIO
 S %ZIS="NQS",%ZIS("A")="Select Task's Output Device (^ for none): ",%ZIS("B")=$P(ZTSK(.2),U) D ^%ZIS G:POP RUNTIME
 S ZTIO=ION_";"_IOST_";"_$S($D(IO("DOC"))#2:IO("DOC"),1:IOM_";"_IOSL)_$S($D(IO("P"))[0:"",IO("P")="":"",1:";/"_IO("P")),ZTSK(.2)=ZTIO_U_IO_U_IOT_U_IOST_U_$P(ZTSK(.2),U,5)_U
 I $D(IO("HFSIO"))#2,$D(IOPAR)#2 S $P(ZTSK(.2),U,6)=IO("HFSIO"),ZTSK(.25)=IOPAR
 D HOME^%ZIS
 ;
RUNTIME ;Allow User To Change Task's Next Run Time
 W ! S ZTDEFALT=$$HTFM^XLFDT($P(ZTSK(0),U,6))
 S DIR(0)="D^::ERS^N ZTRSTRCT D SCREEN^XUTMUSE2 K:ZTRSTRCT X"
 S DIR("A")="When should this task run?"
 S DIR("B")=$$HTE^XLFDT($P(ZTSK(0),U,6))
 S DIR("?",1)="     Your response must be a date, @ sign, and time."
 S DIR("?",2)=" "
 S DIR("?")="     Enter ?? for more help."
 S DIR("??")="^D HELP2^XUTMUSE2"
 D ^DIR K DIR
R1 ;
 I $D(DTOUT) W "     ** TIME-OUT **",$C(7)
 I $D(DUOUT) W "     ** ^-ESCAPE **"
 I $D(DIRUT) Q
 S $P(ZTSK(0),U,6)=$$FMTH^XLFDT(Y)
 ;
PURPOSE ;Allow User To Edit Description Of Task's Purpose
 W ! S DIR(0)="FO^1:200",DIR("A")="Task's purpose" S:ZTSK(.03)]"" DIR("B")=ZTSK(.03) D ^DIR Q:$D(DIRUT)  K DIR S ZTSK(.03)=Y
 ;
BRIEF ;Show User Brief Of Task
 W !!,ZTSK,": ",$E(ZTSK(.03),1,70)
 S ZTD=$E(ZTSK(.03),$L(ZTSK(.03)))=".",ZTX=$L(ZTSK)+2+$L(ZTSK(.03))+3-ZTD,ZTL=$S($P($P(ZTSK(.2),U),";")]"":$L($P($P(ZTSK(.2),U),";")),1:16)
 W:ZTL+ZTX'>80 $E(".",'ZTD),"  " I ZTL+ZTX>80 W:ZTX<80&'ZTD "." W ! S ZTX=0
 W $S($P($P(ZTSK(.2),U),";")]"":$P($P(ZTSK(.2),U),";"),1:"No output device") S ZTX=ZTL+ZTX+3,%H=$P(ZTSK(0),U,6)
 S ZTD=$S(%H="":"Next run time unknown",1:"Next run time: "_$$TIME^XUTMTP(%H)),ZTL=$L(ZTD) W:ZTL+ZTX'>80 ".  " I ZTL+ZTX>80 W:ZTL<80 "." W ! S ZTX=0
 W ZTD I ZTL+ZTX<80 W "."
 ;
REQ ;Allow User To Reschedule Task
 W ! S DIR(0)="YO",DIR("A")="Shall I reschedule this task as shown",DIR("B")="YES" D ^DIR K DIR I $D(DIRUT)!'Y W !,"Task not rescheduled." Q
 S $P(ZTSK(.1),U,10,11)="^"
 S $P(ZTSK(0),U,3)=DUZ
 S $P(ZTSK(0),U,5)=$H
 S $P(ZTSK(0),U,10)=ZTNAME
 W !,"Task rescheduled."
 L +^%ZTSK(ZTSK) S ^%ZTSK(ZTSK,0)=ZTSK(0),^(.03)=ZTSK(.03),^(.1)=ZTSK(.1),^(.2)=ZTSK(.2),^(.25)=ZTSK(.25)
 K ZTDESC,ZTIO,ZTRTN S ZTDTH=$P(ZTSK(0),U,6) D REQ^%ZTLOAD L -^%ZTSK(ZTSK)
 Q
 ;
HELP2 ;RUNTIME--provide ?? help in selecting a start time for this task
 N ZTREC
 W !!?5,"This will be the time TaskMan starts your task."
 I $P(ZTSK(0),U,8)="" Q
 S ZTREC=$G(^DIC(19,+$P(ZTSK(0),U,8),0))
 I ZTREC="" Q
 I $P(ZTREC,U,2)="" Q
 W !!?5,"The option you used to queue this task was:"
 W !?5,$P(ZTREC,U,2)
H1 ;
 I $O(^DIC(19,+$P(ZTSK(0),U,8),3.92,0))="" D  Q
 .W !!?5,"It has no restricted times, so you may run this task any time"
 .W !?5,"you wish." Q
 W !!?5,"It may only be run at certain times."
 W !?5,"This option will notify you if you select a restricted time."
 Q
 ;
SCREEN ;RUNTIME--screen out start times prohibited according to the option
 ;...that queued the task (or the option itself, if the task is a
 ;...queued option).
 I Y=ZTDEFALT S ZTRSTRCT=0 Q
 N X,XQY S X=Y N Y
 S XQY=+$P(ZTSK(0),U,8)
 D ^XQ92
 S ZTRSTRCT=X=""
S1 ;
 I ZTRSTRCT D
 .W !!?5,"You may not start your task at that time."
 .W !!?5,"The option you used to queue this task does not allow the task"
 .W !?5,"to run at that time.  Please select a different time to start"
 .W !?5,"the task."
 .Q
 Q
 ;
