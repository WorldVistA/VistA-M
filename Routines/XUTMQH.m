XUTMQH ;SEA/RDS - TaskMan: Option, ZTMINQ, Part 1A (Help) ;4/19/90  12:11 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
ENTRY G ^XUTMQ
 ;
HELP ;Help Prompt For '?'
 N ZT W @IOF,!!,"This option can only display the tasks that are currently defined on this",!?5,"volume set."
 W !!,"Enter A to see all tasks that you created."
 W !,"Enter Y to see all currently scheduled or waiting tasks that you created."
 W !,"Enter E to see every task."
 W !,"Enter L to pick by number the tasks you want to see."
 W !,"Enter U to see tasks that errored, were rejected, or were unscheduled."
 W:%ZTF !,"Enter F to see all currently scheduled or waiting tasks."
 W:%ZTI !,"Enter T to see all tasks waiting for busy devices to become available."
 W:%ZTI !,"Enter W to pick a device, and see all tasks waiting for that device."
 W:%ZTR !,"Enter R to see all tasks that are currently running."
 W:%ZTL !,"Enter C to see all tasks waiting for a dropped link to be restored."
 F ZT=0:0 R !!,"Press RETURN to continue: ",ZT:$S($D(DTIME)#2:DTIME,1:60) Q:ZT=""!(ZT="^")  W !!,"Enter either RETURN or '^'" W:ZT'["?" $C(7)
 W @IOF Q
 ;
