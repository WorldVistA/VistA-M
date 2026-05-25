XUTMSYNC ;ISCSF/RWF - SYNC TASK MANAGMENT ;07/13/94  15:57
 ;;8.0;KERNEL;**163,761**;Jul 10, 1995;Build 6
 ;;Per VHA VA Directive 6402, this routine should not be modified
 ;
A ;Lookup and clear/restart a sync queue.
 N DIC,DIR,XUFLAG,XUIO,XUDA,X,Y
 S DIC="^%ZISL(14.8,",DIC(0)="AEMQ" D ^DIC G:Y'>0 EXIT
 S XUDA=+Y,XUFLAG=$P($P(Y,"^",2),"~"),XUIO=$P($P(Y,"^",2),"~",2)
A1 ;LOOP TAG AFTER LIST TASKS
 W @IOF,!,$G(^%ZISL(14.8,XUDA,0)),!,$G(^(1))
 S DIR(0)="S^L:LIST TASKS;S:START NEXT;D:DELETE/CLEAR QUEUE;Q:QUIT"
 S DIR("A")="Select Option" D ^DIR G:Y="Q" A
 D LIST:Y="L",DELCLR:Y="D",START:Y="S"
 G A:Y="D",A1
 ;
LIST ; List tasks related to Sync-Pair
 N TASK,SEP,ENTER,CNT,TNODE
 S $P(SEP,"-",IOM)="" ;Line separator for task
 S CNT=0
 W @IOF,!,"Task-Sync pair task list...",!
 S TASK=0 F  S TASK=$O(^%ZTSCH("TASK",TASK)) Q:'+TASK  D
 . S TNODE=$G(^%ZTSCH("TASK",TASK))
 . Q:(XUIO=$P(TNODE,U,6))+(XUFLAG=$P(TNODE,U,11))'=2
 . S CNT=CNT+1
 . D PAGE,EN^XUTMTP(TASK)
 . W !,SEP
 S TASK=0 F  S TASK=$O(^%ZTSCH("SYNC",XUIO,XUFLAG,TASK)) Q:'+TASK  D
 . S CNT=CNT+1
 . D PAGE,EN^XUTMTP(TASK)
 . W !,SEP
 R:CNT>0 !!,"Press <ENTER> to continue: ",ENTER
 W:CNT<1 !!,"No tasks to list for selected Task-Sync pair"
 Q
 ;
START ;Start, clear and start next
 N IOT,CNT,ENTER
 S IOT="RES",CNT=0
 W @IOF,!,"Task-Sync pair task(s) status...",!
 S TASK=0 F  S TASK=$O(^%ZTSCH("TASK",TASK)) Q:'+TASK  D
 . S TNODE=$G(^%ZTSCH("TASK",TASK))
 . Q:(XUIO=$P(TNODE,U,6))+(XUFLAG=$P(TNODE,U,11))'=2
 . S CNT=CNT+1
 . W !,TASK_" - Currently running."
 W:CNT=0 !,"No tasks running for this Task-Sync pair"
 S TASK=0,TASK=$O(^%ZTSCH("SYNC",XUIO,XUFLAG,TASK))
 I TASK="" W !!,"There are no waiting tasks to start." G STARTQ
 W !!,TASK_" - Next sync task to be started.",!
 S X=$$SYNCFLG^%ZTMS2("D",XUFLAG,XUIO)
 D SCHSYNC^%ZTMS2(XUFLAG,XUIO)
STARTQ ;Start end tag
 R !!,"Press <ENTER> to continue: ",ENTER
 Q
 ;
DELCLR ; Delete Task-Sync pair and sync tasks queue
 N IOT,TASK,ZTSK,X,CNT,SEP,DQLST,ENTER
 S IOT="RES",CNT=0,DQLST=""
 W @IOF,"Dequeuing/Unscheduling waiting task(s)..."
 S (CNT,ZTSK)=0 F  S ZTSK=$O(^%ZTSCH("SYNC",XUIO,XUFLAG,ZTSK)) Q:'+ZTSK  D
 . S CNT=CNT+1
 . S DQLST=DQLST_ZTSK_"  "
 . D DQ^%ZTLOAD
 W !!,$S(CNT>0:DQLST,1:"No waiting tasks for this Task-Sync pair")
 W:CNT>0 !,CNT_" waiting task(s) found and unscheduled."
 W !!,"Checking for running task(s)...",!
 S (CNT,TASK)=0 F  S TASK=$O(^%ZTSCH("TASK",TASK)) Q:'+TASK  D
 . S TNODE=$G(^%ZTSCH("TASK",TASK))
 . Q:(XUIO=$P(TNODE,U,6))+(XUFLAG=$P(TNODE,U,11))'=2
 . S CNT=CNT+1
 . W !,TASK_" - "_$P($$ASKSTOP^%ZTLOAD(TASK),U,2)
 W:CNT>0 !,CNT_" running task(s) found and requested to stop.",!,"NOTE:  Further action may be required to stop the task(s)."
 W:CNT=0 !,"No tasks running for this Task-Sync pair"
 W !!,"Deallocating and removing Task-Sync pair..."
 K ^%ZTSCH("SYNC",XUIO,XUFLAG)
 S X=$$SYNCFLG^%ZTMS2("D",XUFLAG,XUIO)
 W !!!,XUFLAG_" Task-Sync removed.",!
 R !!,"Press <ENTER> to continue: ",ENTER
 Q
 ;
PAGE ; Check for task list display new page needed
 N ENTER
 I $Y>18 D
 . R !!,"Press <ENTER> to continue: ",ENTER
 . W @IOF,!,"Task-Sync pair task list...",!
 Q
 ;
EXIT ; Exit
 Q
 ;
