IBCNSJ1 ;ALB/CPM - INACTIVATE AN INSURANCE PLAN ; 30-DEC-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
IA ; 'Inactivate Plan' Action
 ;   Required variable input:
 ;             DFN  --  Pointer to the patient in file #2
 ;          IBPPOL  --  Patient insurance policy definition
 ;
 D FULL^VALM1
 I '$D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ)) W !!,"Sorry, but you do not have the required privileges to inactivate plans." G IAQ
 N IBCNS,IBPLAN,IBPLAND,IBPICK,IBQUIT,X
 S X=+$P($G(IBPPOL),"^",4),X=$G(^DPT(DFN,.312,X,0))
 S IBCNS=+X,IBPLAN=+$P(X,"^",18),(IBPICK,IBQUIT)=0
 I 'IBPLAN D NOPL^IBCNSJ2 G IAQ
 S IBPLAND=$G(^IBA(355.3,+IBPLAN,0)) I 'IBPLAND W !!,"This plan has no company!  Please contact your IRM for assistance." G IAQ
 I IBCNS'=+IBPLAND D PLAN^IBCNSM32(DFN,+$P($G(IBPPOL),"^",4),+IBPLAND) G IAQ
 ;
 ; - inactivate multiple plans?
 S X=$$ASK^IBCNSJ4 G:X<0 IAQ I X D EN^IBCNSJ4 G IAQ
 ;
 W !!,"This action will allow you to inactivate an insurance plan."
 W !,"Inactivating a plan will inactivate all current subscribers to the plan."
 ;
 ; - main processing loop
 F  D  Q:IBQUIT
 .I IBPICK D SEL^IBCNSJ14 Q:IBQUIT
 .;
 .; - invoke inactivate function
 .S IBPICK=1
 .D INACT(IBCNS,IBPLAN)
 .;
 .; - select and inactivate another plan?
 .S DIR(0)="Y",DIR("A")="Do you wish to inactivate another plan",DIR("?")="To inactivate another plan, answer 'YES.'  Otherwise, answer 'NO.'"
 .W ! D ^DIR K DIR,DIRUT,DTOUT,DUOUT,DIROUT I 'Y S IBQUIT=1
 ;
IAQ D PAUSE^VALM1
 D HDR^IBCNSP,BLD^IBCNSP S VALMBCK="R"
 Q
 ;
 ;
INACT(IBCNS,IBPLAN) ; Inactivate an Insurance Plan
 ;  Input:   IBCNS  --  Pointer to the company in file #36 which
 ;          IBPLAN  --  Pointer to the plan in file #355.3
 ;
 N DA,DIK,IBX,IBPLAND,IBNEWP,IBFG
 N DFN,IBACT,IBSUB,IBQUIT,IBCDFN,IBREP,IBCPOL,IBALR,IBMAIL,IBBU,IBARR
 S IBPLAND=$G(^IBA(355.3,IBPLAN,0))
 D DISP
 I 'IBPLAND!(+IBPLAND'=+$G(IBCNS)) W !!,"This is not a valid insurance plan!" G INACTQ
 ;
 ; - is the plan an Individual Plan?
 I '$P(IBPLAND,"^",2) D  G INACTQ
 .W !,"You cannot inactivate an Individual Plan!"
 .W !!,"You must either delete the policy using the 'Delete Policy' action,"
 .W !,"or change the plan to which the patient has subscribed, using the action"
 .W !,"'Change Policy Plan'."
 ;
 ; - handle inactive plans
 S IBACT=$P(IBPLAND,"^",11),IBSUB=$$SUBS^IBCNSJ(IBCNS,IBPLAN,1)
 I IBACT D NOTACT^IBCNSJ11 G INACTQ
 ;
 ; - inactivate plan if there are no plan subscriptions
 I 'IBSUB D NAC^IBCNSJ12(IBPLAN,"There are no subscribers to this plan.  Would you like to inactivate it",1) G INACTQ
 ;
 ; - display plan attributes
 W !,"There are currently subscribers to this plan."
 I $D(^IBA(355.4,"APY",IBPLAN)) W !,*7,"  ** There are Annual Benefits associated with this plan!"
 I $D(^IBA(355.5,"B",IBPLAN)) S IBBU=1 W !,*7,"  ** There are Benefits Used associated with this plan!"
 ;
 ; - should subscriptions to this plan be switched to another plan?
 S DIR(0)="Y",DIR("A")="Would you like to re-point these policies to a new plan",DIR("?")="^D HLRP^IBCNSJ11"
 W ! D ^DIR K DIR,DIRUT,DTOUT,DUOUT,DIROUT
 I 'Y D MAIL^IBCNSJ11 G OKAY
 ;
 ; - select or add a new plan to re-point the policies
 S IBREP=1,IBFG=$$SUBS^IBCNSJ(IBCNS,IBPLAN,0,"",1)>1
 D GETPL^IBCNSJ12
 I 'IBCPOL S IBREP=0 D MAIL^IBCNSJ11 G OKAY
 ;
 ; - alert user that current plan has benefits used
 I $G(IBBU) D BU^IBCNSJ13(.IBQUIT) I IBQUIT G INACTQ
 ;
OKAY ; - okay to inactivate the plan?
 D DISP,NAC^IBCNSJ12(IBPLAN,"  Okay to inactivate this plan",0,.IBQUIT) I IBQUIT G INACTQ
 ;
 ; - if there is no-repointing, send the user the subscription list
 I $G(IBMAIL) D MSG^IBCNSJ12(IBCNS,IBPLAN)
 ;
 ; - re-point existing policies if necessary; allow plan deletion
 I $G(IBREP) D REP^IBCNSJ13(IBCNS,IBCPOL,IBPLAN,$G(IBMERGE)),DEL^IBCNSJ11(IBPLAN)
INACTQ Q
 ;
DISP ; Display plan name/number.
 W !!,$S($P(IBPLAND,"^",2):"Group",1:"Individual")," Plan Number: ",$S($P(IBPLAND,"^",4)]"":$P(IBPLAND,"^",4),1:"<not specified>"),?50,"Plan Name: ",$S($P(IBPLAND,"^",3)]"":$P(IBPLAND,"^",3),1:"<not specified>"),!
 Q
