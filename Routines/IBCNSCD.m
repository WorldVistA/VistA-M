IBCNSCD ;ALB/CPM - DELETE INSURANCE COMPANY ;01-FEB-95
 ;;2.0;INTEGRATED BILLING;**28,46,232**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DEL ; 'Delete Insurance Company' Action
 ;   Required variable input:
 ;     IBCNS  --  Pointer to the company in file #36
 ;
 N I,IBC,IBDAT,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S VALMBCK="R" D FULL^VALM1
 I '$G(IBCNS) G DELQ
 S IBCNSD=$G(^DIC(36,IBCNS,0))
 I IBCNSD="" W !!,"This Insurance Company does not exist!",! G DELQ
 I '$D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ)) D SORRY^IBTRE1 G DELQ
 I '$P(IBCNSD,"^",5) D  G DELQ
 .W !!,"This Insurance Company is still active!  You must use the"
 .W !,"'Inactivate Company' action to inactivate this company before"
 .W !,"you can delete it."
 I $D(^DPT("AB",IBCNS)) D  G DELQ
 .W !!,"There are still patient policies with this company!  These policies"
 .W !,"must be deleted or re-pointed to another company before you can"
 .W !,"delete the company."
 I $D(^IBA(355.3,"B",IBCNS)) D  G DELQ
 .W !!,"There are still Insurance Plans on file with this company!  These plans"
 .W !,"must be deleted or re-pointed to another company before you can"
 .W !,"delete the company."
 I $O(^IBA(355.9,"AE",IBCNS,""))!$O(^IBA(355.91,"AC",IBCNS,"")) D  G DELQ
 .W !!,"There are still provider ids defined for this company!  These ids must"
 .W !,"be deleted before you can delete this company."
 I $O(^IBA(355.96,"AC",IBCNS,""))!$O(^IBA(355.95,"C",IBCNS,"")) D  G DELQ
 .W !!,"There are still provider id care units defined for this company!  These"
 .W !,"care unit entries must be deleted before you can delete this company."
 I $O(^IBA(355.92,"B",IBCNS,"")) D  G DELQ
 .W !!,"There are still facility ids defined for this company!  These ids must be"
 .W !,"deleted before you can delete this company."
 ;
 ; - explain functionality
 D INTRO^IBCNSCD3 S DIR(0)="E" W ! D ^DIR K DIR I $D(DIRUT)!$D(DUOUT) G DELQ1
 ;
 ; - need to merge data into another company?
 D MERGE^IBCNSCD3 I IBQUIT G DELQ
 ;
 ; - provide a warning message
 D WARN^IBCNSCD3
 ;
 ; - okay to proceed?
 S DIR(0)="Y",DIR("A")="Is it okay to "_$S(IBREP:"merge",1:"delete")_" this company"_$S(IBREP:" information into the other",1:""),DIR("?")="^D HLP^IBCNSCD3"
 W ! D ^DIR K DIR I 'Y W !!,"The company was not deleted." G DELQ
 ;
 ; - merge Insurance Reviews
 I IBCALLIR,$D(^IBT(356.2,"AIACT",IBCNS)) D
 .W !!,"  >> Merging known Insurance Reviews into ",IBREPN,"... "
 .S IBC=0 F  S IBC=$O(^IBT(356.2,"AIACT",IBCNS,IBC)) Q:'IBC  D
 ..S IBX=0 F  S IBX=$O(^IBT(356.2,"AIACT",IBCNS,IBC,IBX)) Q:'IBX  S DA=IBX,DIE="^IBT(356.2,",DR=".08////"_IBREP D ^DIE K DA,DIE,DR
 .W "done."
 ;
 ; - merge bills/receivables
 I IBCALLAR W !!,"  >> Merging known bills and receivables into ",IBREPN,"... ",!
 S IBERR="" D EN^RCAMINS(IBCNS,$S(+$G(IBREP):IBREP,1:""),'IBCALLAR,.IBERR)
 I IBCALLAR W !?5,$S(IBERR<0:"AR Error: "_$P(IBERR,"^",2),1:"All done.")
 ;
 ; - flag company for deletion
 W !!,"  >> Flagging ",$P(IBCNSD,"^")," for deletion... "
 S DA=IBCNS,DIE="^DIC(36,",DR="5.01////1;5.02////"_$S($G(IBREP):IBREP,1:"@")
 D ^DIE K DA,DIE,DR W "done."
 ;
 ; - queue the final clean up job
 W !!,"  >> Queuing the final clean-up job... "
 S IBTASK=$$ALR I IBTASK W !?5,"This job is already queued as task number ",IBTASK,"." G DELC
 S IBDAT=$S($P($H,",",2)<25200:$H,$P($H,",",2)>82800:$H,1:+$H_",82800")
 S ZTRTN="DQ^IBCNSCD1",ZTDTH=IBDAT,ZTIO="",ZTDESC="IB - INSURANCE COMPANY DELETION"
 S IBCNSN=$P(IBCNSD,"^") F I="IBCNS","IBREP","IBCNSN" S ZTSAVE(I)=""
 D ^%ZTLOAD
 W !?5,$S($D(ZTSK):"The job has been queued to run "_$S($P($H,",",2)<$P(IBDAT,",",2):"at 11:00pm",1:"now")_".  The task number is "_ZTSK_".",1:"Unable to queue this job.  Please contact your IRM Service.")
 I $D(ZTSK)#2 S $P(^IBE(350.9,1,4),"^",8)=ZTSK
 ;
DELC S VALMBCK="Q"
 ;
DELQ D PAUSE^VALM1
DELQ1 K IBCNSD,IBCNSN,IBREP,IBREPN,IBIP,IBBU,IBAB,IBMRGN,IBMRGF,IBX,IBTASK
 K DIRUT,DUOUT,DTOUT,DIROUT,ZTSK,IBQUIT,IBCALLAR,IBCALLIR,IBERR
 Q
 ;
ALR() ; Has the background clean-up job already been queued?
 ;   Input:   None
 ;  Output:   0  --  Job hasn't been queued
 ;           >0  --  Task # of queued job
 N ZTSK
 S ZTSK=+$P($G(^IBE(350.9,1,4)),"^",8) I 'ZTSK G ALRQ
 D ISQED^%ZTLOAD I 'ZTSK(0) S ZTSK=0
ALRQ Q ZTSK
