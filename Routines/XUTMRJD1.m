XUTMRJD1 ;SEA/RDS - TaskMan: Option, XURESJOB Exit Action, Part 2 ;11/8/94  09:12
 ;;8.0;KERNEL;;Jul 10, 1995
HELP1A ;
 ;PROMPT1^XUTMRJD--? help
 W !!?5,"Answer yes or no.  Enter ?? for more help."
 Q
HELP1B ;
 ;PROMPT1^XUTMRJD--explain purpose and offer to show Task List
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !!?5,"If you answer yes, you will be asked to identify the tasks"
 W !?5,"you forcibly exited."
 W !!?5,"If you answer no, you will exit the option."
 W !!?5,"If you are not sure, answer yes.  At the next prompt, you"
 W !?5,"can enter ?TASK LIST to see the list of tasks TaskMan believes"
 W !?5,"are running, which may help you identify tasks you may have"
 W !?5,"forcibly exited."
 Q
HELP2A ;
 ;PROMPT2^XUTMRJD--? help
 I $D(ZTSCREEN) K ZTSCREEN Q
 W !!?5,"Answer must be the internal number(s) of the task(s) to be"
 W !?5,"selected."
 W !!?5,"Answer must be an integer between 1 and 999999999."
 W !?5,"Answer may be a range, for example 4000-5000."
 W !?5,"Answer may be a list, for example 4001,4004,4010-4020."
 W !!?5,"Enter ?? for more help."
 Q
HELP2B ;
 ;PROMPT2^XUTMRJD--explain, offer to show system status or Task List
 W !!?5,"Enter ?TASK LIST (or ?T) to list the tasks TaskMan believes"
 W !?5,"are running."
 W !!?5,"Enter ?SYSTEM STATUS (or ?S) to list the system status report."
 Q
SCREEN2A ;
 ;PROMPT2^XUTMRJD--screen out ?TASK LIST and ?SYSTEM STATUS as acceptable
 N ZTL,ZTX
 S ZTX=$$UP^XLFSTR(X)
 S ZTL=$L(X)
 I $E("?TASK LIST",1,ZTL)=ZTX D  Q
 .W $E("?TASK LIST",ZTL+1,999)
 .S Y="?TASK LIST",ZTOUT=1
 .Q
 I $E("?SYSTEM STATUS",1,ZTL)=ZTX D  Q
 .W $E("?SYSTEM STATUS",ZTL+1,999)
 .S Y="?SYSTEM STATUS",ZTOUT=1
 .Q
 Q
 ;
SCREEN2B ;
 ;PROMPT2^XUTMRJD--screen out lists w/o any running tasks as unacceptable
 N ZTCOUNT,ZTR1,ZTR2,ZTSK
 S ZTCOUNT=0 K ^TMP($J,"XUTMRJD")
S2B1 ;
 S ZTSK=0 F  S ZTSK=$O(^%ZTSCH("TASK",ZTSK)) Q:'ZTSK  D
 .I $D(^TMP($J,"XUTMT",ZTSK)) D  Q
 ..S ZTCOUNT=ZTCOUNT+1
 ..S ^TMP($J,"XUTMRJD",ZTSK)=""
 .S ZTR2=$O(^TMP($J,"XUTMT",ZTSK))
 .S ZTR1=$O(^TMP($J,"XUTMT",ZTSK))
 .I ZTR1="" Q
 .I ZTR1>ZTSK Q
 .S ZTCOUNT=ZTCOUNT+1
 .S ^TMP($J,"XUTMRJD",ZTSK)=""
 .Q
S2B2 ;
 I ZTCOUNT S ^TMP($J,"XUTMRJD")=ZTCOUNT Q
 W !!?5,"None of the tasks in that range are listed as running."
 W !!?5,"You must select from TaskMan's list of running tasks if you"
 W !?5,"want TaskMan to remove the ones you forcibly exited."
 W !!?5,"Enter ? for help."
 K X S ZTSCREEN=1
 Q
HELP3A ;
 ;PROMPT3^XUTMRJD--? help
 W !!?5,"Answer yes or no.  Enter ?? for more help."
 Q
HELP3B ;
 ;PROMPT3^XUTMRJD--explain consequences
 W !!?5,"Answer yes if before continuing you want to see the task",ZTPLURAL
 W !?5,"you have selected."
 W !!?5,"Answer no if you are sure which task",ZTPLURAL," you selected."
 Q
HELP4A ;
 ;PROMPT4^XUTMRJD--? help
 W !!?5,"Answer yes or no.  Enter ?? for more help."
 Q
HELP4B ;
 ;PROMPT4^XUTMRJD--explain consequences
 W !!?5,"Answer yes to remove the selected task",ZTPLURAL
 W " from TaskMan's list"
 W !?5,"of running tasks.  If you do, TaskMan will no longer believe"
 I ZTCOUNT>1 W !?5,"these tasks are running."
 E  W !?5,"this task is running."
 W !!?5,"Answer no to leave the task",ZTPLURAL," listed as running."
 Q
 ;
