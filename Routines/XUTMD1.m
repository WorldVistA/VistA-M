XUTMD1 ;SEA/RDS - TaskMan: Option, XUTMDEL, Part 2 (Bulk Delete) ;1/31/96  10:15
 ;;8.0;KERNEL;**20**;Jul 10, 1995
 ;
COUNT ;Ask Whether To First Count The Number Of Tasks To Delete
 W !
 K DIR
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Would you like to know how many tasks in that list can be deleted"
 S DIR("?")="     Answer NO if you don't want to know how many tasks can be deleted."
 D ^DIR
 I $D(DIRUT) W:$D(DTOUT) $C(7) W !!?5,"NO tasks deleted!" Q
 K DIR,DIRUT,DTOUT,DUOUT
 I 'Y G SHOW
 S XUTMT(0)="LD" D ^XUTMT G:$D(DIRUT) EXIT
 W !!?5,"There ",$S(ZTSK=1:"is ",1:"are "),ZTSK," task",$S(ZTSK=1:"",1:"s")," in that list that can be deleted."
 I ZTSK=0 W $C(7) Q
 ;
SHOW ;Ask Whether To Show The Tasks To Be Deleted
 W !
 K DIR
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Would you like to see the tasks that will be deleted"
 S DIR("?")="     Answer NO if you don't want to see the tasks that will be deleted."
 D ^DIR
 I $D(DIRUT) W:$D(DTOUT) $C(7) W !!?5,"NO tasks deleted!" Q
 K DIR,DIRUT,DTOUT,DUOUT
 I 'Y G CONFIRM
 W ! S XUTMT(0)="PD" D ^XUTMT
 I 'ZTSK W !?5,"There are 0 tasks in that list." Q
 ;
CONFIRM ;Prompt For Confirmation Of Deletion
 K DIR
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to delete these tasks"
 S DIR("?")="     Answer YES to delete the selected tasks."
 D ^DIR
 I 'Y W !!?5,"Tasks NOT deleted!" W:$D(DTOUT) $C(7) G EXIT
 S XUTMT(0)="DL" D ^XUTMT
 I ZTSK W !!?5,"Tasks deleted!"
 I 'ZTSK W !!?5,"There are 0 tasks in that list."
 ;
EXIT Q
