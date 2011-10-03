XUTMD ;SEA/RDS - TaskMan: Option, XUTMDEL, Part 1 (Single) ;12/28/94  14:23
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
ENV ;Establish Routine Environment
 N DDH,DIR,X,Y,ZTENV,ZTKEY,ZTNAME,ZTSK,XUTMUCI
 D ENV^XUTMUTL Q:'$D(ZTENV)
 ;
SELECT ;Prompt User To Select Task Or Tasks To Delete
 W !
 S XUTMT(0)="AL" D ^XUTMT
 I 'ZTSK K ^TMP($J,"XUTMT") Q
 I ZTSK["-"!(ZTSK[",") D ^XUTMD1 Q:$D(DTOUT)  G SELECT
 S XUTMT=ZTSK,XUTMT(0)="R3" D ^XUTMT
 ;
STATUS ;Report On Status Of Task And Whether User May Delete It
 I $D(ZTSK(.11))#2,ZTSK(.11)="UNDEFINED",$O(ZTSK(.3))="" W !!?5,"That task is not defined.",$C(7) G SELECT
 I $D(ZTSK(.11))#2,ZTSK(.11)="UNDEFINED",$O(ZTSK(.3))="TASK",$O(ZTSK("TASK"))="" W !!?5,"That task is running and has no record." G SELECT
 I $D(ZTSK(.11))#2,ZTSK(.11)="UNDEFINED" W !!?5,"That task is scheduled but has no record." G CONFIRM:ZTKEY G SELECT
 ;
S5 I $D(ZTSK(.11))#2,$O(ZTSK(.3))="" W !!?5,"That task's record is incomplete." G CONFIRM:ZTKEY G SELECT
 I $D(ZTSK(.11))#2,$O(ZTSK(.3))="TASK",$O(ZTSK("TASK"))="" W !!?5,"That task is running and has an incomplete record." G SELECT
 I $D(ZTSK(.11))#2 W !!?5,"That task is scheduled, but has an incomplete record." G CONFIRM:ZTKEY G SELECT
 ;
S9 I $O(ZTSK(.3))="TASK",$O(ZTSK("TASK"))="" W !!?5,"That task is running." G SELECT
 I 'ZTKEY,$S($P(ZTSK(0),U,11)_","_$P(ZTSK(0),U,12)=XUTMUCI:DUZ'=$P(ZTSK(0),U,3),1:ZTNAME'=$P(ZTSK(0),U,10)) W !!?5,"You may only delete your own tasks." G SELECT
 ;
CONFIRM ;Prompt User To Confirm Unscheduling
 I $S($D(ZTSK(.11))[0:1,1:ZTSK(.11)'="UNDEFINED") W ! D EN^XUTMTP(ZTSK)
 W !
 K DIR
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to delete this task"
 S DIR("B")="NO"
 S DIR("?")="     Answer YES to delete the task."
 D ^DIR
 I 'Y W !!?5,"Tasks NOT deleted!"
 I $D(DTOUT) W $C(7) Q
 K DIR,DIRUT,DTOUT,DUOUT
 I 'Y G SELECT
 ;
DELETE ;Delete Task
 I $D(ZTSK(0))#2,ZTSK(0)["ZTSK^XQ1",$P(ZTSK(0),U,11)_","_$P(ZTSK(0),U,12)=XUTMUCI,$P(ZTSK(0),U,8)]"" D
 . F DA=0:0 S DA=$O(^DIC(19.2,DA)) Q:DA'>0  I $G(^DIC(19.2,DA,1))=ZTSK D
 . . N DIE S DIE="^DIC(19.2,",DR="2///@;12///@" D ^DIE Q
 . Q
 S XUTMT=ZTSK,XUTMT(0)="D" D ^XUTMT
 W !!?5,"Deleted!"
 G SELECT
 ;
