XUTMRJD ;SEA/RDS - TaskMan: Option, XURESJOB exit action ;08/07/97  15:01
 ;;8.0;KERNEL;**49,67**;Jul 10, 1995
MAIN ;
 ;Main module of XURESJOB exit action
 I '$O(^%ZTSCH("TASK",0)) Q
 N ZTCOUNT,ZTENV,ZTKEY,ZTNAME,ZTPLURAL,ZTSK,ZTOOPS,ZTOUT,XUTMUCI
 S (ZTOOPS,ZTOUT)=0
 K ^TMP($J,"XUTMRJD")
 D ENV^XUTMUTL Q:'$D(ZTENV)
 D EXPLAIN
 D PROMPT1 Q:ZTOUT
M2 F  D  I ZTOUT Q
 .D PROMPT2 I ZTOUT Q
 .D PROMPT3 Q:ZTOUT
 .D:'ZTOOPS DISPLAY I ZTOUT Q
 .D PROMPT4 I ZTOOPS!ZTOUT Q
 .D REMOVE
 .Q
 K ^TMP($J,"XUTMRJD")
 Q
EXPLAIN ;
 ;MAIN--explain purpose of this exit action
 W !!,"If you forcibly exited any processes, some of them may have"
 W !,"been TaskMan tasks.  If so, TaskMan still believes the tasks"
 W !,"are running.  You can correct this problem by telling TaskMan"
 W !,"which tasks you forcibly exited.  TaskMan will then remove those"
 W !,"tasks from its list of running tasks.",!
 Q
PROMPT1 ;
 ;MAIN--ask whether system manager forcibly exited any tasks
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Did you forcibly exit any tasks",DIR("B")="Yes"
 S DIR("?")="^D HELP1A^XUTMRJD1",DIR("??")="^D HELP1B^XUTMRJD1"
 W ! D ^DIR
 I $D(DTOUT) W "     ** TIME-OUT **",$C(7)
 I $D(DUOUT) W "     ** ^-ESCAPE **"
 I $D(DIRUT) S ZTOUT=1 Q
 S ZTOUT='Y
 Q
PROMPT2 ;
 ;MAIN--ask system manager to select tasks to remove from Task List
 N DIR,DIRUT,DTOUT,DUOUT,X,Y,XUTMT S ZTSK="" K ^TMP($J,"XUTMT")
 F  D  Q:ZTSK!ZTOUT
 .W ! S XUTMT(0)="AL"
 .S XUTMT("A")="Which tasks did you forcibly exit (?T for list):  "
 .S XUTMT("S1")="D SCREEN2A^XUTMRJD1",XUTMT("S2")="D SCREEN2B^XUTMRJD1"
 .S XUTMT("?")="^D HELP2A^XUTMRJD1",XUTMT("??")="^D HELP2B^XUTMRJD1"
 .D ^XUTMT
P21 .;
 .I ZTSK="?SYSTEM STATUS" X ^%ZOSF("SS") Q
 .I ZTSK="?TASK LIST" D  Q
 ..K XUTMT
 ..S XUTMT(0)="R4"
 ..S XUTMT("NODE")="^%ZTSCH(""TASK"","
 ..S XUTMT("NONE")="There are no running tasks listed"
 ..W ! D ^XUTMT
 ..Q
 .I 'ZTSK S ZTOUT=1 W !!?5,"No tasks selected.",! Q
 .Q
 K ^TMP($J,"XUTMT")
 Q
PROMPT3 ;
 ;MAIN--ask system manager whether to display the selected tasks
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S ZTCOUNT=^TMP($J,"XUTMRJD")
 S ZTPLURAL="" I ZTCOUNT>1 S ZTPLURAL="s"
 W !!?5,"You have selected ",ZTCOUNT," task",ZTPLURAL," listed as running."
 W !
P3 ;
 S DIR(0)="Y",DIR("A")="Do you want to see the task"_ZTPLURAL_" you have selected",DIR("B")="Yes"
 S DIR("?")="^D HELP3A^XUTMRJD1",DIR("??")="^D HELP3B^XUTMRJD1"
 D ^DIR
 I $D(DTOUT) W "     ** TIME-OUT **",$C(7)
 I $D(DUOUT) W "     ** ^-ESCAPE **"
 I $D(DIRUT) S ZTOUT=1 Q
 I 'Y S ZTOOPS=1
 Q
DISPLAY ;
 ;MAIN--display the selected tasks
 N XUTMT,ZTSK
 S XUTMT(0)="R4"
 S XUTMT("NODE")="^TMP($J,""XUTMRJD"","
 S XUTMT("NONE")="There is an error in this program."
 W ! D ^XUTMT
 Q
PROMPT4 ;
 ;MAIN--ask system manager to confirm choice of tasks
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W ! S DIR(0)="Y",DIR("A")="Are you sure you want to remove"
 S DIR("A")=DIR("A")_$S(ZTCOUNT=1:" this task",1:" these tasks")_" from the list of running tasks"
P41 ;
 S DIR("B")="No",DIR("?")="^D HELP4A^XUTMRJD1",DIR("??")="^D HELP4B^XUTMRJD1"
 D ^DIR
 I $D(DTOUT) W "     ** TIME-OUT **",$C(7)
 I $D(DUOUT) W "     ** ^-ESCAPE **"
 I $D(DIRUT) S ZTOUT=1 Q
 S ZTOOPS='Y I Y Q
 W !!?5,"The selected task",ZTPLURAL," will remain listed as running.",!
 Q
REMOVE ;
 ;MAIN--remove selected tasks from Task List
 N ZTSK
 W !!,"Removing selected task",ZTPLURAL,"..."
 ;L +^%ZTSCH("TASK")  removed patch #67
 S ZTSK=0 F  S ZTSK=$O(^TMP($J,"XUTMRJD",ZTSK)) Q:'ZTSK  D
 .L +^%ZTSCH("TASK",ZTSK):0 I '$T D  Q
 ..W !!,"Task is still running, kill job first"
 ..W !,"Task "_ZTSK_" will not be removed, continuing..."
 ..Q
 .L -^%ZTSCH("TASK",ZTSK)
 .K ^%ZTSCH("TASK",ZTSK)
 .W !?5,"...",ZTSK," removed."
 ;L -^%ZTSCH("TASK")  removed patch #67
 W !?5,"...finished!"
 Q
ASK ;Call from the option
 I '$O(^%ZTSCH("TASK",0)) Q
 N ZTCOUNT,ZTENV,ZTKEY,ZTNAME,ZTPLURAL,ZTSK,ZTOOPS,ZTOUT,XUTMUCI
 S (ZTOOPS,ZTOUT)=0
 K ^TMP($J,"XUTMRJD")
 D ENV^XUTMUTL Q:'$D(ZTENV)
 W !,"This will allow you to remove entries from TaskMans list of",!,"running tasks that you believe are not running."
 W !,"The questions will be asked assuming you have just killed a task"
 G M2
