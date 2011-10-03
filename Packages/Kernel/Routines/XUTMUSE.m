XUTMUSE ;SEA/RDS - TaskMan: Option, XUTMUSER, Part 1 (Driver) ;11/30/94  11:43
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
ENV ;Establish Routine Environment
 N DIR,XUTMT,ZTKEY,ZTNAME,ZTENV,ZTF,ZTUCI,ZTSK K DTOUT,DIRUT
 D ENV^XUTMUTL Q:'$D(ZTENV)
 S XUTMT(0)="A"_$E("U",'ZTKEY),XUTMT("?")="^D HELP1^XUTMUSE",XUTMT("??")="^D HELP2^XUTMUSE" D ^XUTMT Q:ZTSK=""
 ;
SELECT ;Prompt User For Action
 S DIR(0)="SAOM^D:Display status.;ST:Stop task.;E:Edit task.;P:Print task.;L:List own tasks.;SE:Select another task.",DIR("?")="^D HELP1^XUTMUSE3",DIR("??")="^D HELP2^XUTMUSE3"
 S DIR("A",1)="",DIR("A",2)="               Taskman User Option",DIR("A",3)="",DIR("A",4)="                    Display status.",DIR("A",5)="                    Stop task.",DIR("A",6)="                    Edit task."
 S DIR("A",7)="                    Print task.",DIR("A",8)="                    List own tasks.",DIR("A",9)="                    Select another task.",DIR("A",10)="",DIR("A")="               Select Action (Task # "_ZTSK_"): "
 D ^DIR Q:$D(DIRUT)  D ACT I ZTSK="" K ^TMP($J) Q
 G SELECT
 ;
ACT ;SELECT Subroutine--Act On User's Selection
 N DIR,DIRUT,DTOUT,DUOUT,XUTMT
 I Y="D" W ! D EN^XUTMTP(ZTSK,"",1) Q
 I Y="ST" W ! S XUTMT=ZTSK,XUTMT(0)="R2" D ^XUTMT Q
 I Y="E" S XUTMT=ZTSK D ^XUTMUSE2 Q
 I Y="P" D ^XUTMUSE1 Q
 I Y="L" D HELP2 Q
 W ! S XUTMT(0)="A"_$E("U",'ZTKEY),XUTMT("B")=ZTSK,XUTMT("?")="^D HELP3^XUTMUSE",XUTMT("??")="^D HELP2^XUTMUSE" D ^XUTMT Q
 Q
 ;
HELP1 ;ENV Subroutine--Help Message For Initial Task Selection For "?"
 W !!,"This option will allow you to look at and manipulate your queued jobs, and is",!?5,"only useful for you when you have such jobs to work with."
 W !!,"You must begin this option by entering the task number of the queued job that",!?5,"you want to work with first."
 W !!,"If you don't know the task number of any of your queued jobs then enter",!?5,"two question marks ('??') and you will be shown all of your queued jobs",!?5,"on this computer."
 W "  The task number of each task is the number listed on the",!?5,"first line of the display, before the colon (':')."
 W !!,"After you pick a task to work with, you will be shown a list of the things",!?5,"you can do with that task, and will be asked to pick one.",!
 Q
 ;
HELP2 ;Subroutine--Help Message For Initial Task Selection For "??"
 N %ZTI,DTOUT,DUOUT,X,Y,ZT,ZTD1,ZTD2,ZTDTH,XUTMT,ZTOUT,ZTREC,ZTS,ZTSK
 K ^TMP($J)
 W @IOF,"Please wait while I find your tasks...searching..."
 S %ZTI=0,ZTOUT=0
H1 S ZTS=0 F  S ZTS=$O(^%ZTSK(ZTS)) Q:'ZTS  D
 . S ZTREC=$G(^%ZTSK(ZTS,0)) Q:ZTREC=""
 . I $P(ZTREC,U,3)'=DUZ Q
 . I $P(ZTREC,U,10)]"",$P(ZTREC,U,10)'=ZTNAME Q
 . S ZTDTH=$$H3^%ZTM($P(ZTREC,U,6))
 . D SORT
 . Q
H2 S ZTS=0,ZTDTH=$$H3^%ZTM($H)
 F  S ZTS=$O(^%ZTSCH("TASK",ZTS)) Q:'ZTS  D
 . I $D(^%ZTSK(ZTS,0))#2 Q
 . S ZTREC=$G(^%ZTSCH("TASK",ZTS)) Q:ZTREC=""
 . I $P(ZTREC,U,9)'=DUZ,$P(ZTREC,U,9)'=ZTNAME Q
 . D SORT
 . Q
H3 W "finished!",!
 I '%ZTI W !,"There are no tasks listed that were queued by you.",!
 E  S ZTD1="0",%ZTI=0 F  S ZTD1=$O(^TMP($J,ZTD1)) Q:ZTD1'>0  D  I ZTOUT Q
 . S ZTS=0
 . F  S ZTS=$O(^TMP($J,ZTD1,ZTS)) Q:'ZTS  D HPRINT I ZTOUT Q
 I 'ZTOUT D EOL W !
 ;K ^TMP($J)
 Q
 ;
HPRINT ;HELP2 Subroutine--Print A Task
 N XUTMT,ZTSK
 S %ZTI=%ZTI+1,^TMP($J,0,%ZTI)=ZTS
 S ZTF=0 D EN^XUTMTP(ZTS,%ZTI)
 W !,"-------------------------------------------------------------------------------"
 I $Y>18 S ZTF=1 D EOP S ZTOUT=$D(DTOUT)!$D(DUOUT) Q:ZTOUT  W @IOF
 Q
 ;
SORT ;HELP2--sort tasks by start time, in reverse order
 ;input: start time, task number
 ;output: new cross reference in ^TMP($J)
 S %ZTI=%ZTI+1
 S ^TMP($J,ZTDTH,ZTS)=%ZTI
 Q
 ;
HELP3 ;ACT Subroutine--Help Message For Task Reselection For "?"
 W !!,"Enter the task number of the queued job you want to work with."
 W !!,"Enter '??' to see the list of tasks you can choose from.",! Q
 ;
EOP ;Simulate DIR(0)="E" Call To DIR (For Use Within DIR calls)
 S Y="" F ZT=0:0 R !,"Press RETURN to continue or '^' to exit: ",Y:$S($D(DTIME)#2:DTIME,1:60) S:'$T DTOUT="" S:Y="^" DUOUT="" Q:Y=""!(Y="^")  W !!,"Enter either RETURN or '^'",! W:Y'["?" $C(7)
 Q
 ;
EOL ;Simulate DIR(0)="E" call to DIR for end of listings
 S Y="" F ZT=0:0 R !,"End of listing.  Press RETURN to continue: ",Y:$S($D(DTIME)#2:DTIME,1:60) S:'$T DTOUT="" S:Y="^" DUOUT="" Q:Y=""!(Y="^")  W !!,"Enter either RETURN or '^'",! W:Y'["?" $C(7)
 Q
 ;
