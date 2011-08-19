XUTMQ ;SEA/RDS - TaskMan: Option, XUTMINQ, Show task lists ;07/24/2000  13:23
 ;;8.0;KERNEL;**20,136,169**;Jul 10, 1995
 ;
ENV ;Establish Routine Environment
 N %,%ZTF,%ZTI,%ZTJ,%ZTL,%ZTR,DDH,DIR,DIRUT,DTOUT,DUOUT,X,Y,ZT,ZT1,ZTENV,ZTKEY,ZTNAME,XUTMUCI
 D ENV^XUTMUTL Q:'$D(ZTENV)
 I '+$O(^%ZTSK(0))&'$D(^%ZTSCH("TASK")) W !!,"The Task File is empty, and there are no tasks currently running." S DIR(0)="E" D ^DIR Q
 ;
SELECT ;Select listing (main loop)
 F ZT=0:0 D FLAGS,SET,PROMPT,^DIR Q:$D(DIRUT)  K DIR,DIRUT,DTOUT,DUOUT D BRANCH
 I $D(DTOUT) W "*TIMEOUT*",$C(7)
 K DIR,DIRUT,DTOUT,DUOUT,X,Y
 Q
 ;
FLAGS ;Reset Taskman Files Status Flags
 N X,Y
 W @IOF S ZT1="",%ZTL=0 F  S ZT1=$O(^%ZTSCH("LINK",ZT1)) Q:ZT1=""  I $O(^%ZTSCH("LINK",ZT1,""))]"" S %ZTL=1 Q
 S ZT1="",%ZTJ=0 F  S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  I $O(^%ZTSCH("JOB",ZT1,0))]"" S %ZTJ=1 Q
 S X="",%ZTI=0
 F  S X=$O(^%ZTSCH("IO",X)) Q:X=""  I $D(^%ZTSCH("IO",X))>9 S %ZTI=1 Q
 S %ZTF=+$O(^%ZTSCH(""))!%ZTI!%ZTL!%ZTJ,%ZTR=$D(^%ZTSCH("TASK"))
 Q
 ;
SET ;Create set of choices for user
 I ZTKEY S DIR(0)="A:All of one user's tasks.;O:One user's future tasks.;"
 E  S DIR(0)="A:All of your tasks.;Y:Your future tasks.;"
 S DIR(0)="SAOM^"_DIR(0)_"E:Every task.;L:List of tasks.;U:Unsuccessful tasks." S:%ZTF DIR(0)=DIR(0)_";F:Future tasks."
 S:%ZTI DIR(0)=DIR(0)_";T:Tasks waiting for devices.;W:Waiting list for a device." S:%ZTR DIR(0)=DIR(0)_";R:Running tasks."
 S:%ZTL DIR(0)=DIR(0)_";C:Cross-cpu waiting lists."
 Q
 ;
PROMPT ;Create prompt and help text
 S DIR("A",1)="                    List Tasks Option"
 S DIR("A",2)=""
 S DIR("A",3)="                         All of one user's tasks."
 S DIR("A",4)="                         One user's future tasks."
 S:'ZTKEY DIR("A",3)="                         All your tasks."
 S:'ZTKEY DIR("A",4)="                         Your future tasks."
 S DIR("A",5)="                         Every task."
 S DIR("A",6)="                         List of tasks."
 S DIR("A",7)="                         Unsuccessful tasks."
 S:%ZTF DIR("A",8)="                         Future tasks."
 S:%ZTI DIR("A",9)="                         Tasks waiting for devices."
 S:%ZTI DIR("A",10)="                         Waiting list for a device."
 S X=$S(%ZTI:11,%ZTF:9,1:8)
 S:%ZTR DIR("A",X)="                         Running tasks.",X=X+1
 S:%ZTL DIR("A",X)="                         Cross-cpu waiting lists.",X=X+1
 S DIR("A",X)="",DIR("A")="                    Select Type Of Listing: "
 S DIR("?")="^D HELP^XUTMQH"
 Q
 ;
BRANCH ;DO selected listing
 N ZT
 D @$S(Y="A":"ALL^XUTMQ0",Y="O"!(Y="Y"):"FUT^XUTMQ0",Y="E":"EVERY^XUTMQ1",Y="L":"LIST^XUTMQ1",Y="U":"NOT^XUTMQ1",Y="C":"LINK^XUTMQ2",Y="R":"RUN^XUTMQ2",Y="F":"FUT^XUTMQ2",Y="T":"IOQ^XUTMQ3",1:"IO1^XUTMQ3")
 Q
LIST ;Print a list of tasks in ^TMP($J,n,m).
 N XUTMT,XU1,XU2,IOCRT,XUDD,XUTSK,PG
 D LSTPRE,HDR S XU1=0
 F  S XU1=$O(^TMP($J,XU1)),XU2=0 Q:XU1'>0  F  S XU2=$O(^TMP($J,XU1,XU2)) Q:XU2'>0  D  I $D(DIRUT) S (XU1,XU2)="A"
 . I $Y+5'<IOSL D HDR Q:$D(DIRUT)
 . W !,"-------------------------------------------------------------------------------"
 . D EN^XUTMTP(XU2)
 . Q
 D:'$D(DIRUT)&IOCRT WAIT
 Q
LSTPRE ;
 S IOCRT=$E(IOST,1,2)["C-",XUDD=$$HTE^XLFDT($H,"1MP"),PG=0
 Q
HDR I PG>0,IOCRT D WAIT Q:$D(DIRUT)
 I (PG>0)!(IOCRT) W @IOF
 S PG=PG+1
 W "Task list  ",XUDD,?70,"Page ",PG
 Q
WAIT S DIR(0)="E" D ^DIR
 Q
