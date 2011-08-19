XUTMDQ1 ;SEA/RDS - TaskMan: Option, XUTMDQ, Part 2 (Bulk DQ) ;11/28/90  16:07 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
COUNT ;Ask Whether To First Count The Number Of Tasks To Unschedule
 W !
 K DIR
 S DIR(0)="Y"
 S DIR("A")="Would you like to know how many tasks in that list can be unscheduled"
 S DIR("B")="YES"
 S DIR("?")="     Answer NO if you don't want a count of the tasks to be unscheduled."
 D ^DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) W !!?5,"Tasks NOT unscheduled!" Q
 I 'Y G SHOW
 S XUTMT(0)="LU" D ^XUTMT
 W !!?5,"There ",$S(ZTSK=1:"is ",1:"are "),ZTSK," task",$S(ZTSK=1:"",1:"s")," in that list that can be unscheduled."
 I ZTSK=0 Q
 ;
SHOW ;Ask Whether To Show The Tasks To Be Unscheduled
 W !
 K DIR
 S DIR(0)="Y"
 S DIR("A")="Would you like to see the tasks that will be unscheduled"
 S DIR("B")="YES"
 S DIR("?")="     Answer NO if you don't want to see the tasks to be unscheduled."
 D ^DIR
 I $D(DTOUT) W $C(7)
 I $D(DIRUT) W !!?5,"Tasks NOT unscheduled!" Q
 I 'Y G CONFIRM
 W !
 S XUTMT(0)="PU" D ^XUTMT
 I 'ZTSK W !?5,"There are 0 tasks in that list." Q
 ;
CONFIRM ;Prompt For Confirmation Of Unscheduling
 K DIR
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to unschedule these tasks"
 S DIR("B")="NO"
 S DIR("?")="     Answer YES if you want to unschedule the selected tasks."
 D ^DIR
 I $D(DTOUT) W $C(7)
 I 'Y W !!?5,"Tasks NOT unscheduled!" Q
 S XUTMT(0)="UL" D ^XUTMT
 I ZTSK W !!?5,"Tasks unscheduled!"
 I 'ZTSK W !!?5,"There are 0 tasks in that list."
 Q
 ;
