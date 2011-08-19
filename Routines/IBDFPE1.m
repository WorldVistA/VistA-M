IBDFPE1 ;MAF/ALB - ENCOUNTER FORMS QUEUEING PARAMETERS DISPLAY CONT.; 1 31 94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15**;APR 24, 1997
EDT ; -- Edit Parameter Groups
 N IBDVALM,IBDAT,VALMY
 S VALMBCK=""
 D EN^VALM2($G(XQORNOD(0))) G REP:'$O(VALMY(0)) S IBDVALM=0
 D FULL^VALM1 S VALMBCK="R"
 F IBDVALM=0:0 S IBDVALM=$O(VALMY(IBDVALM)) Q:'IBDVALM  S DA=$S($D(IBDTYPE(IBDVALM)):$P(IBDTYPE(IBDVALM),"^",1),1:"") I DA]"" D
 .S DA(1)=1,DIE="^IBD(357.09,"_DA(1)_","_"""Q"""_",",DA=DA,DR=".01;.04:.1;.13" D ^DIE K DA,DIE,DIC,DR
 D REP Q
 ;
 ;
ADD ; -- Add New Print Parameters
 D FULL^VALM1
 N DLAYGO
 I '$O(^IBD(357.09,0))!($O(^IBD(357.09,0))&'$D(^IBD(357.09,+$O(^IBD(357.09,0)),"Q",0))) W ! S DIC="^IBD(357.09,",DIC(0)="AELQMN",DIC("DR")=".01",DLAYGO=357.09 D ^DIC K DIC G:Y<1 REP S DA=+Y D
 .;S DIE="^IBD(357.09,",DA=DA,DR="11",DR(2,357.091)=".04:.1" D ^DIE K DA,DIE,DR
 W ! S DA(1)=1,DIC("A")="Select Print Mgrs. Queuing Params. Name: ",DIC="^IBD(357.09,"_DA(1)_","_"""Q"""_",",DIC(0)="AELQMN",DIC("DR")=".01",DLAYGO=357.09 D ^DIC K DIC G:Y<1 REP S DA=+Y D
 .S DA(1)=1,DIE="^IBD(357.09,"_DA(1)_","_"""Q"""_",",DA=DA
 .S DR=".04//"_1_";.05//"_"NO"_";.06"_";.07//"_5_";.08//"_"R"_";.09"_";.1//"_10_";.13//"_0000
 .D ^DIE K DA,DIE,DIC,DR
 .Q
REP D INIT^IBDFPE S VALMBCK="R" Q
 ;
STAT ; -- Find out the status of the queued job and kill a tasked job
 N IBDVALM,IBDAT,VALMY,IBDFNODE,IBDFSTAT,IBQUIT
 S VALMBCK=""
 D EN^VALM2($G(XQORNOD(0))) G REP:'$O(VALMY(0)) S IBDVALM=0
 D FULL^VALM1 S VALMBCK="R"
 F IBDVALM=0:0 S IBDVALM=$O(VALMY(IBDVALM)) Q:'IBDVALM  S DA=$S($D(IBDTYPE(IBDVALM)):$P(IBDTYPE(IBDVALM),"^",1),1:"") I DA]"" D  K IBQUIT
 .S DA(1)=1,IBDFNODE=^IBD(357.09,DA(1),"Q",DA,0) D ASK Q:$D(IBQUIT)  D:$D(IBDFSTOP) KILL^%ZTLOAD D:'$D(IBDFSTOP)&(IBDFSTAT]"") STAT^%ZTLOAD D
 ..D FULL^VALM1
 ..I IBDFSTAT']"" W !!,"Status of Queued Job <<< "_$P(IBDFNODE,"^",1)_" >>>",!!,"JOB NOT TASKED!" W:$D(IBDFSTOP) "  NO NEED TO INTERRUPT JOB!" Q
 ..W !!,"Status of Queued Job <<< "_$P(IBDFNODE,"^",1)_" >>>",!!
 ..I $D(ZTSK(0)) W !,"       TASK: ",$S($D(ZTSK):ZTSK,1:"")_"  -  ",$S(ZTSK(0)=1:"Defined",1:"Undefined")
 ..I $D(ZTSK(1)) W !,"STATUS CODE: ",ZTSK(1)
 ..I $D(ZTSK(2)) W !,"     STATUS: ",ZTSK(2)
 ..I $D(IBDFSTOP) W:ZTSK(0)=1 !,"SUCCESSFUL DELETION OF TASK" W !!,"***JOB STOPPED UPON REQUEST***" S:ZTSK=$P(IBDFNODE,"^",11) $P(^IBD(357.09,DA(1),"Q",DA,0),"^",11)="" S:ZTSK=$P(IBDFNODE,"^",14) $P(^IBD(357.09,DA(1),"Q",DA,0),"^",14)=""
 ..Q
 ;I IBDFSTAT']"" W !!,"Status of Queued Job <<< "_$P(IBDFNODE,"^",1)_" >>>",!!,"JOB NOT TASKED!" I $D(IBDFSTOP) W "  NO NEED TO INTERRUPT JOB!"
 K DA,DA(1)
 D PAUSE^VALM1,REP Q
 Q
 ;
DEL ; -- Delete Clinic Group
 N IBDVALM,VALMY,DIR,DIRUT,DUOUT
 S VALMBCK=""
 D EN^VALM2($G(XQORNOD(0))) G REP:'$O(VALMY(0)) S IBDVALM=0
 D FULL^VALM1 S VALMBCK="R"
 ;
 F IBDVALM=0:0 S IBDVALM=$O(VALMY(IBDVALM)) Q:'IBDVALM  S DA=$S($D(IBDTYPE(IBDVALM)):$P(IBDTYPE(IBDVALM),"^",1),1:"") I DA]"" D
 .S DA(1)=1,DIK="^IBD(357.09,"_DA(1)_","_"""Q"""_","
 .W !!,"Paramater Group: "_$P($G(^IBD(357.09,1,"Q",DA,0)),"^",1)
 .W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are You Sure you want to delete "_$P($G(^IBD(357.09,1,"Q",DA,0)),"^",1)
 .D ^DIR K DIR I Y'=1 W !,"Entry ",$P($G(^IBD(357.09,1,"Q",DA,0)),"^",1)," not Deleted!" Q
 .D DP1
 ;
DELQ D REP
 S VALMBCK="R" Q
 ;
DP1 ; -- actual deletion
 S DIK="^IBD(357.09,"_DA(1)_","_"""Q"""_"," D ^DIK
 W !,"Entry ",IBDVALM," Deleted"
 Q
ASK I $P(IBDFNODE,"^",11)']""!($P(IBDFNODE,"^",14)']"")!($P(IBDFNODE,"^",11)=$P(IBDFNODE,"^",14)) D  Q
 .S (IBDFSTAT,ZTSK)=$P(IBDFNODE,"^",11)
 .Q
 S DIR(0)="S^1:CURRENT;2:PREVIOUS"
 S DIR("A")="Select action for print group "_$P(IBDFNODE,"^",1)
 S DIR("B")="CURRENT"
 S DIR("?")=" "
 S DIR("?",1)="Choose 1 or 'C' CURRENT TASK"
 S DIR("?",2)="                or"
 S DIR("?",3)="       2 or 'P' for PREVIOUS TASK"
 S DIR("?",4)=" "
 S DIR("?",5)="          Current task # ="_$P(IBDFNODE,"^",11)
 S DIR("?",6)=" "
 S DIR("?",7)="          Previous task # = "_$P(IBDFNODE,"^",14)
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S IBQUIT=1
 S (IBDFSTAT,ZTSK)=$S(Y=2:$P(IBDFNODE,"^",14),1:$P(IBDFNODE,"^",11))
 K DIR Q
