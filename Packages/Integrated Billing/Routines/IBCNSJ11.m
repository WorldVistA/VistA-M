IBCNSJ11 ;ALB/CPM - INACTIVATE AN INSURANCE PLAN (CON'T) ; 18-JAN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,62**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NOTACT ; Handle plans which have already been inactivated.
 ;  Required variable input:
 ;      IBCNS  --  Pointer to company in file #36 offering the plan
 ;     IBPLAN  --  Pointer to the plan in file #355.3
 ;      IBSUB  --  Flagged high if there are any plan subscriptions
 ;
 N DFN,IBQUIT,IBSUB1,Y
 W !,"This plan has already been inactivated!"
 S DIR(0)="Y",DIR("A")="Do you wish to reactivate this plan",DIR("?")="To reactivate this plan, answer 'YES.'  Otherwise, answer 'NO.'"
 W ! D ^DIR K DIR,DIRUT,DTOUT,DUOUT,DIROUT
 I 'Y,IBSUB W !,"There are still subscribers to this plan.  The plan cannot be deleted." G NOTACTQ
 I 'Y D DEL(IBPLAN) G NOTACTQ
 ;
 ; - note that insurance policies will be activated
 I IBSUB S IBQUIT=0 D  I IBQUIT G NOTACTQ
 .W !!,"There are still subscribers to this plan!  Reactivating the plan will activate"
 .W !,"the policies of these subscribers."
 .S DIR(0)="Y",DIR("A")="  Is it okay to continue",DIR("?")="Answer 'YES' to reactivate this plan.  Otherwise, answer 'NO.'"
 .W ! D ^DIR K DIR,DIRUT,DTOUT,DUOUT,DIROUT I 'Y W !,"The plan was not reactivated." S IBQUIT=1 Q
 ;
 ; - reactivate the plan
 W !,"Reactivating the plan... " D IRACT^IBCNSJ(IBPLAN,0) W "done."
 I 'IBSUB W !,"Please note there are no subscribers to this plan." G NOTACTQ
 W !,"Updating the 'Covered by Insurance?' field for all plan subscribers... "
 K ^TMP($J,"IBSUBS")
 S IBSUB1=$$SUBS^IBCNSJ(IBCNS,IBPLAN,0,"^TMP($J,""IBSUBS"")")
 S DFN=0 F  S DFN=$O(^TMP($J,"IBSUBS",DFN)) Q:'DFN  D COV^IBCNSJ(DFN)
 W "done." K ^TMP($J,"IBSUBS")
NOTACTQ Q
 ;
 ;
DEL(IBPLAN) ; Want to delete an Insurance Plan?
 ;  Input:  IBPLAN  --  Pointer to the plan in file #355.3
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="Y",DIR("A")="There are no subscribers to this plan.  Would you like to delete it",DIR("?")="If you wish to delete this inactive plan, answer 'YES.'  Otherwise, answer 'NO.'"
 W ! D ^DIR I 'Y W !,"The plan was not deleted."
 I Y W !,"Deleting the plan... " D DEL^IBCNSJ(IBPLAN) W "done."
 Q
 ;
 ;
HLRP ; Reader help for repointing policies to a new plan.
 W !!,"If you wish to change the subscribed-to plan of ALL policies which are"
 W !,"currently associated with this plan, enter 'YES.'  Otherwise, enter 'NO.'"
 W !!,"You may only repoint all policies to a single plan.  If you enter 'NO,'"
 W !,"you will receive a mailman message of all the inactivated policies which"
 W !,"will result from inactivating the plan, and then you may use the 'Change"
 W !,"Policy Plan' action to change the subscribed-to plan on an individual basis."
 Q
 ;
MAIL ; Note that the subscription list will be mailed to the user.
 S IBMAIL=1
 W !,"The policies will not be re-pointed.  You will receive a mail message of"
 W !,"all the subscribers to this plan if you choose to inactivate it."
 Q
 ;
REP(IBCNS,IBNEWP,IBOLDP) ; Repoint patient policies from old to new plan
 ;  Input:   IBCNS  --  Pointer to the company in file #36 which
 ;                      offers the plans
 ;          IBNEWP  --  Pointer to the new plan in file #355.3
 ;          IBOLDP  --  Pointer to the old plan in file #355.3
 ;
 I '$G(IBCNS)!'$G(IBNEWP)!'$G(IBOLDP) G REPQ
 N DA,DFN,DIE,DR,IBCDFN
 S DFN=0 F  S DFN=$O(^DPT("AB",IBCNS,DFN)) Q:'DFN  D
 .S IBCDFN=0 F  S IBCDFN=$O(^DPT("AB",IBCNS,DFN,IBCDFN)) Q:'IBCDFN  D
 ..Q:$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",18)'=IBOLDP
 ..S DA=IBCDFN,DA(1)=DFN,DIE="^DPT("_DFN_",.312,",DR=".18////"_IBNEWP
 ..D ^DIE
REPQ Q
 ;
DELP ; Delete the newly-added plan.
 I $G(IBNEWP) W !,"Deleting the newly-added plan... " D DEL^IBCNSJ(IBCPOL) W "done."
 Q
 ;
HLMT ; Reader help for merging transferrable benefits used.
 W !!,"If you want to merge the patient's current benefits used into the"
 W !,"newly-proposed plan, enter 'YES'.  Otherwise, enter 'NO' and these"
 W !,"benefits used will be deleted."
 Q
