ZTMONH ;SEA/RDS-TaskMan: Option, ZTMON, Part 3 (Help Driver) ;4/19/90  12:00 ;
 ;;7.1;KERNEL;;May 11, 1993
 ;
ENTRY G ^ZTMON
 ;
RESET ;Setup parameters for DIR call
 W @IOF
 S DIR(0)="SAOM^S:Schedule List.;W:Waiting Lists.;O:One Waiting List.;J:Job List.;T:Task List.;L:Link Lists."
 S DIR("A",1)="                    Help For Monitor Taskman Option"
 S DIR("A",2)=""
 S DIR("A",3)="                         Schedule List."
 S DIR("A",4)="                         Waiting Lists."
 S DIR("A",5)="                         One Waiting List."
 S DIR("A",6)="                         Job List."
 S DIR("A",7)="                         Task List."
 S DIR("A",8)="                         Link Lists."
 S DIR("A",9)=""
 S DIR("A")="                    Select Type Of Listing: "
 S DIR("?")="^D HELP^ZTMONH"
 Q
 ;
BRANCH ;DO the selected listing
 D @$S(Y="S":"SCHED^ZTMONH1",Y="W":"WAIT^ZTMONH1",Y="O":"WAIT1^ZTMONH1",Y="J":"JOB^ZTMONH2",Y="T":"TASK^ZTMONH2",Y="L":"LINK^ZTMONH2")
 Q
 ;
HELP ;Help text for '?'
 W !!,"Enter S to see the list of tasks scheduled for the future."
 W !,"Enter W to see all tasks that are waiting for output devices."
 W !,"Enter O to see the waiting list for a single device."
 W !,"Enter J to see all tasks waiting for submanagers."
 W !,"Enter T to see all currently running tasks."
 W !,"Enter L to see all tasks waiting for a dropped link to be restored."
 Q
 ;
SCREEN ;Screen out unknown users
 S Y=1,Z="" I $S($D(DUZ)[0:1,DUZ="":1,1:0) W !!?5,"I do not know who you are (your DUZ variable is ",$S($D(DUZ)[0:"undefined).",1:"null).")
 E  I $D(^VA(200,DUZ,0))[0 W !!?5,"User # ",DUZ," is not defined in this uci.  I'm not sure who you are."
 Q:'$T  W !?5,"You may not use the monitor's help facility."
 W ! F ZT=0:0 R !,"Press RETURN to continue: ",Y:$S($D(DTIME)#2:DTIME,1:60) S Z=Y Q:Y=""!(Y="^")  W !!?5,"Enter RETURN.",! W:Y'["?" $C(7)
 Q
 ;
SELECT ;Select listing (main loop)
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZTNAME D SCREEN Q:'Y  N Y S ZTNAME=$P(^VA(200,DUZ,0),U)
 F ZT=0:0 D RESET,^DIR K DIR,DIRUT,DTOUT,DUOUT Q:U[Y  D BRANCH
 S Z=Y
 Q
 ;
