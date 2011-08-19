IBCNSJ12 ;ALB/CPM - INACTIVATE AN INSURANCE PLAN (CON'T) ; 18-JAN-95
 ;;2.0;INTEGRATED BILLING;**28,62,142**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
GETPL ; Select an active group plan or add a new one.
 ;  Required variable input:
 ;     IBCNS  --  Pointer to the company in file #36 offering the plan
 ;    IBPLAN  --  Pointer to the current plan in file #355.3
 ;      IBFG  --  [Optional] -> set to 1 to force creation, if
 ;                necessary, of a group plan
 ;
 ;  Variable output:
 ;    IBCPOL  --  0   if no plan was selected/added, or
 ;                >0  points to the added/selected plan in file #355.3
 ;    IBNEWP  --  [optional]: set to 1 if a new plan was added.
 ;
 N IBALR
 S IBCPOL=0,IBALR=IBPLAN
 I '$$ANYGP^IBCNSJ(IBCNS,IBPLAN) W !!,$P($G(^DIC(36,IBCNS,0)),"^")," offers no other active group plans!" G ADD
 ;
 ; - select an active group plan
 S IBCPOL=$$LK^IBCNSM31(IBCNS) I 'IBCPOL W !,"No plan selected!",!
 ;
ADD ; - propose to add a new plan to which the patient may subscribe
 I 'IBCPOL D
 .W !,"You may ",$S($G(IBREP):"repoint these policies",1:"change the policy plan")," to a newly-added plan."
 .D NEW^IBCNSJ3(IBCNS,.IBCPOL,+$G(IBFG)) W ! I IBCPOL S IBNEWP=1
 I 'IBCPOL W !,"No Insurance Plan has been added or selected."
 Q
 ;
NAC(IBPLAN,IBPR,IBDEL,IBQ) ; Inactivate the plan.
 ;  Input:  IBPLAN  --  Pointer to the plan in file #355.3
 ;            IBPR  --  Prompt for the Reader call
 ;           IBDEL  --  [optional]: set to 1 if the plan may be deleted
 ; Output:     IBQ  --  set to 1 if the plan is not inactivated
 ;
 N DIR,DIRUT,DIROUT,DUOUT,DTOUT
 I '$G(IBPLAN) G NACQ
 S IBQ=0,DIR(0)="Y",DIR("?")="To inactivate this plan, answer 'YES.'  Otherwise, answer 'NO.'"
 S DIR("A")=$S($G(IBPR)]"":IBPR,1:"Is it okay to inactivate this plan")
 W ! D ^DIR I 'Y W !,"The plan was not inactivated." D DELP^IBCNSJ11 S IBQ=1 G NACQ
 W !,"Inactivating the plan... " D IRACT^IBCNSJ(IBPLAN,1) W "done."
 I $G(IBDEL) D DEL^IBCNSJ11(IBPLAN)
NACQ Q
 ;
MSG(IBCNS,IBPLAN) ; Send the subscription list to the user.
 ;  Input:   IBCNS  --  Pointer to the company in file #36 offering the plan
 ;          IBPLAN  --  Pointer to the current plan in file #355.3
 ;
 N DFN,IBCDFN,IBCDFND,IBPLAND,IBC,IBSUB1,VA,VAOA,VAERR,XMDUZ,XMTEXT,XMY,XMSUB,IBX
 I '$G(IBCNS)!'$G(IBPLAN) G MSGQ
 S IBPLAND=$G(^IBA(355.3,IBPLAN,0)) I 'IBPLAND G MSGQ
 W !,"Building the list of inactivated subscriptions to send to you..."
 ;
 ; - build message header
 K ^TMP($J,"IBSUB-LIST")
 S XMSUB="SUBSCRIPTION LIST FOR INACTIVATED PLAN"
 S ^TMP($J,"IBSUB-LIST",1)="The following plan offered by "_$E($P($G(^DIC(36,+IBCNS,0)),"^"),1,20)_" has been inactivated:"
 S ^TMP($J,"IBSUB-LIST",2)=" "
 S IBX="   Group Plan Number: "_$S($P(IBPLAND,"^",4)]"":$P(IBPLAND,"^",4),1:"<no number>")
 S ^TMP($J,"IBSUB-LIST",3)=$E(IBX_$J("",25),1,43)_"Plan Number: "_$S($P(IBPLAND,"^",3)]"":$P(IBPLAND,"^",3),1:"<no name>")
 S ^TMP($J,"IBSUB-LIST",4)=" "
 S ^TMP($J,"IBSUB-LIST",5)="The following plan subscriptions, which may have been active, were"
 S ^TMP($J,"IBSUB-LIST",6)="automatically inactivated:"
 S ^TMP($J,"IBSUB-LIST",7)=" "
 S ^TMP($J,"IBSUB-LIST",8)="Patient Name/ID             Whose    Employer              Effective  Expires"
 S ^TMP($J,"IBSUB-LIST",9)=" ",IBC=9
 ;
 ; - build message subscription list
 K ^TMP($J,"IBSUBS")
 S IBSUB1=$$SUBS^IBCNSJ(IBCNS,IBPLAN,0,"^TMP($J,""IBSUBS"")")
 S DFN=0 F  S DFN=$O(^TMP($J,"IBSUBS",DFN)) Q:'DFN  D
 .D COV^IBCNSJ(DFN)
 .S X=$$PT^IBEFUNC(DFN),IBM=1
 .S X=$E($P(X,"^"),1,20)_" "_$P(X,"^",3)
 .S IBC=IBC+1,^TMP($J,"IBSUB-LIST",IBC)=$E(X_$J("",28),1,28)
 .S IBCDFN=0 F  S IBCDFN=$O(^TMP($J,"IBSUBS",DFN,IBCDFN)) Q:'IBCDFN  D
 ..S IBCDFND=$G(^DPT(DFN,.312,IBCDFN,0))
 ..I 'IBM S IBC=IBC+1,^TMP($J,"IBSUB-LIST",IBC)=$J("",28) S IBM=1
 ..S X=$$EXPAND^IBTRE(2.312,6,$P(IBCDFND,"^",6))
 ..S IBX=^TMP($J,"IBSUB-LIST",IBC)
 ..S IBX=IBX_$E(X_$J("",9),1,9)
 ..S VAOA("A")=$S($P(IBCDFND,"^",6)="s":6,1:5) D OAD^VADPT
 ..S IBX=IBX_$E($E(VAOA(9),1,21)_$J("",22),1,22)
 ..S IBX=IBX_$E($$DAT1^IBOUTL($P(IBCDFND,"^",8))_$J("",10),1,10)
 ..S IBX=IBX_$E($$DAT1^IBOUTL($P(IBCDFND,"^",4))_$J("",10),1,10)
 ..S ^TMP($J,"IBSUB-LIST",IBC)=IBX
 ;
 ; - build message trailer and transmit
 S IBC=IBC+1,^TMP($J,"IBSUB-LIST",IBC)=" "
 S IBC=IBC+1,^TMP($J,"IBSUB-LIST",IBC)="You should review this list and change the policy plan for any of"
 S IBC=IBC+1,^TMP($J,"IBSUB-LIST",IBC)="these subscriptions if necessary."
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="^TMP($J,""IBSUB-LIST"","
 K XMY S XMY(DUZ)=""
 D ^XMD
MSGQ K ^TMP($J,"IBSUBS"),^TMP($J,"IBSUB-LIST")
 Q
