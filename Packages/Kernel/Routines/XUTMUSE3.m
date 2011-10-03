XUTMUSE3 ;SEA/RDS - TaskMan: Option, XUTMUSER, Part 4 (Help) ;9/14/94  10:10
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
HELP1 ;SELECT^XUTMU Subroutine--Help Message For Action Selection For "?"
 W !,"Pick an action to perform on the task you have selected."
 Q
 ;
HELP2 ;SELECT^XUTMU Subroutine--Help Message For Action Selection For "??"
 W !!,"Enter D to find out what Task Manager is currently doing with your task."
 W !!,"Enter ST to 'stop' your task.  What this actually means is that Task Manager",!?5,"will TRY to stop your task.  If the task is scheduled, waiting, being",!?5,"validated, or being prepared, then your task will be stopped."
 W "  If your",!?5,"task is already running then it probably won't stop because the",!?5,"programmers who write your tasks don't yet know how to tell if they've",!?5,"been asked to stop.  In the future, though, most of your tasks will"
 W !?5,"stop when you ask even if they have already started running."
 W !!,"Enter E to edit the task you've selected.  This action will ask you if it is",!?5,"okay to stop the task so that you can edit it, and when you are done",!?5,"editing the task it will let you reschedule the task."
 W "  This action",!?5,"will let you decide whether or not the task needs an output device,",!?5,"and will let you edit which output device it uses.  You can also",!?5,"change the description of the task and the time it should start."
 W !!,"Action P will let you print what the task does."
 W !!,"Enter L to see the list of tasks that you queued."
 W !!,"Action SE lets you select a different task to work with.",!
 F ZT=0:0 R !,"Press RETURN to continue or '^' to exit: ",X:DTIME Q:"^"[X  W:X'="?" $C(7) W !!,"Enter either RETURN or '^'",!
 Q
 ;
