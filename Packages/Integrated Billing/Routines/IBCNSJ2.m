IBCNSJ2 ;ALB/CPM - CHANGE POLICY PLAN ; 03-JAN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CSTP ; 'Change Policy Plan' Action
 ;   Required variable input:
 ;             DFN  --  Pointer to the patient in file #2
 ;          IBPPOL  --  Patient insurance policy definition
 ;
 N DA,DIK,IBCDFN,IBCPOL,IBNEWP,IBX,IBPLAN,IBPLAND,X
 N IBCNS,IBALR,IBMERGE,IBIP,IBBU,IBAB,IBMRGN,IBMRGF,IBX
 S IBCDFN=$P($G(IBPPOL),"^",4)
 I '$G(DFN)!'IBCDFN G CSTPQ
 D FULL^VALM1
 I '$D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ)) W !!,"Sorry, but you do not have the required privileges to change the policy plan." G CSTPQ
 ;
 S X=$G(^DPT(DFN,.312,IBCDFN,0)) I 'X W !!,"This policy is not valid!" G CSTPQ
 S IBCNS=+X,IBPLAN=+$P(X,"^",18),IBPLAND=$G(^IBA(355.3,IBPLAN,0))
 I 'IBPLAN D NOPL G CSTPQ
 I 'IBPLAND W !!,"This plan has no company!  Please contact your IRM for assistance." G CSTPQ
 I IBCNS'=+IBPLAND D PLAN^IBCNSM32(DFN,IBCDFN,+IBPLAND) G CSTPQ
 ;
 ; - introduction
 W !!,"This action will allow you to change the insurance plan to which the"
 W !,"veteran is subscribing through this policy."
 W !!,$S($P(IBPLAND,"^",2):"Group",1:"Individual")," Plan Number: ",$S($P(IBPLAND,"^",4)]"":$P(IBPLAND,"^",4),1:"<not specified>"),?50,"Plan Name: ",$S($P(IBPLAND,"^",3)]"":$P(IBPLAND,"^",3),1:"<not specified>"),!
 D NOTES^IBCNSJ21
 ;
 ; - select or add a new plan for the policy
 D GETPL^IBCNSJ12
 I 'IBCPOL W !,"Can't change subscribed-to plan..." G CSTPQ
 ;
 ; - last few notes
 I IBIP W !,*7," *** Please note that this Individual Plan will be deleted if you select",!,"     to switch plans associated with this policy."
 I '$O(IBBU(0)) G OK
 W !,*7,"This patient has Benefits Used associated with his current plan and policy!"
 D AB^IBCNSJ21 I '$O(IBAB(0)) W !,"The newly proposed subscribed-to plan has no associated Annual Benefits,",!,"so the Benefits Used associated with the current plan will be deleted!" G OK
 ;
 ; - display mergeable benefits used
 D DMBU^IBCNSJ21
 W !!,"Please note that ",$S('$O(IBMRGF(0)):"no",$G(IBMRGN):"some",1:"all")," Benefits Used are transferable."
 I $G(IBMRGN) W !,$S('$O(IBMRGF(0)):"All Benefits Used",1:"Note that those Benefits Used which cannot be merged")," will be deleted!"
 I '$O(IBMRGF(0)) G OK
 ;
 ; - merge or delete previous benefits used?
 S DIR(0)="Y",DIR("A")="Do you want to merge the transferable Benefits Used",DIR("?")="^D HLMT^IBCNSJ11"
 W ! D ^DIR K DIR I $D(DIRUT) D DELP^IBCNSJ11 G CSTPQ
 S IBMERGE=Y
 W !,$S(IBMERGE:"The transferable",1:"All")," Benefits Used will be ",$S(IBMERGE:"merged.",1:"deleted.")
 ;
OK ; - okay to switch subscribed-to plan?
 S DIR(0)="Y",DIR("A")="Okay to change the subscribed-to plan",DIR("?")="^D HLSW^IBCNSJ21"
 W ! D ^DIR K DIR,DIRUT,DTOUT,DUOUT,DIROUT
 I 'Y W !!,"The subscribed-to plan for this policy was not changed.",! D DELP^IBCNSJ11 G CSTPQ
 ;
 ; - change plan in policy; adjust 'covered by insurance' field
 W !!,"Changing the subscribed-to plan... " D SWPL^IBCNSJ13(IBCPOL,DFN,IBCDFN) W "done."
 ;
 ; - merge/delete benefits used, if necessary
 D MD^IBCNSJ21
 ;
 ; - delete the previous individual plan, if necessary
 I IBIP W !,"Deleting the formerly subscribed-to Individual Plan... " D DEL^IBCNSJ(IBPLAN) W "done." G CSTPQ
 ;
 ; - if plan no longer has subscribers, say so.
 I '$$SUBS^IBCNSJ(IBCNS,IBPLAN,1) W !!,"There are no longer any subscribers to the previous plan.  You may wish",!,"to inactivate or delete this plan using the 'Inactivate Plan' action."
 ;
CSTPQ D PAUSE^VALM1
 D HDR^IBCNSP,BLD^IBCNSP S VALMBCK="R"
 Q
 ;
NOPL ; Display message if there is no insurance plan.
 W !!,"There is no plan associated with this policy!"
 W !!,"Please use the action 'Change Plan Info', which will create a plan"
 W !,"for the policy."
 Q
