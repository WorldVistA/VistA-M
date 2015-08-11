IBCNSM31 ;ALB/AAS - INSURANCE MANAGEMENT - OUTPUTS ;28-MAY-93
 ;;2.0;INTEGRATED BILLING;**6,28,68,413,497,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% G EN^IBCNSM
 ;
EA ; -- Edit all insurance policy data
 N IBDIF,I,J,IBXX,IBCDFN,IBTRC,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 D FULL^VALM1
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D  ;W !,"Entry ",X,"Selected" D
 .S IBPPOL=$G(^TMP("IBNSMDX",$J,$O(^TMP("IBNSM",$J,"IDX",IBXX,0))))
 .Q:IBPPOL=""
 .S IBCDFN=$P($G(IBPPOL),"^",4) I 'IBCDFN W !!,"Can't identify the policy!" Q
 .; -- edit patient data
 .N IBQUIT S IBQUIT=0
 .S IBCNSEH=$P($G(^IBE(350.9,1,4)),"^",1) D PAT^IBCNSEH
 .D BEFORE^IBCNSEVT
 .D PATPOL^IBCNSM32(IBCDFN)
 .D AFTER^IBCNSEVT,^IBCNSEVT
 .; -- edit policy data
 .D:'$G(IBQUIT) POL^IBCNSEH,EDPOL^IBCNSM3(IBCDFN)
 .W ! D AI^IBCNSP1 D:$G(IBTRC) AIP^IBCNSP02(IBTRC)
 .Q
 ;
EAQ D BLD^IBCNSM
 S VALMBCK="R"
 Q
 ;
LK(IBCNS) ; -- screened look up to policy file
 ;      input:   IBCNS = pointer to insurance company file (36)
 ;
 N DIC,IBX,DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y,IBCPOL
 S IBCPOL=""
 I $G(IBCNS)="" G LKQ
 ;
 I '$$ANYGP^IBCNSJ(IBCNS) W !!,"This company does not offer any active group plans." G LKQ
 ;
 S DIR(0)="Y",DIR("A")="This company offers active group plans.  Do you wish to select one"
 S DIR("?")="The look-up facility to select an active group plan has been enhanced to use the List Manager.  Enter 'YES' if you wish to select a plan from this look-up, or 'NO' to add your own plan."
 D ^DIR K DIR I 'Y G LKQ
 ;
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you wish to directly enter this plan"
 S DIR("?")="The look-up facility to select an active group plan has been enhanced to use the List Manager.  Enter 'NO' if you wish to select a plan from this look-up, or 'YES' to directly enter the plan."
 D ^DIR K DIR I $D(DIRUT) G LKQ
 ;
 I 'Y D LKP^IBCNSU2(IBCNS,0,0,.IBCPOL,$G(IBALR)) G LKQ
 ;
 ; MRD;IB*2.0*516 - Display new Group Name and Number fields.
 S DIC("A")="Select an Active GROUP PLAN: "
 S DIC="^IBA(355.3,",DIC(0)="AEQM",DIC("S")="I +^(0)=IBCNS,$P(^(0),U,2),'$P(^(0),U,11),$G(IBALR)'=+Y"
 ;S DIC("W")="N IBX S IBX=$G(^(0)) W ""   Name: "",$E($S($P(IBX,U,3)]"""":$P(IBX,U,3),1:""<none>"")_$J("""",20),1,20),""   Number: "",$S($P(IBX,U,4)]"""":$P(IBX,U,4),1:""<none>"")"
 S DIC("W")="N IBX S IBX=$G(^(2)) W ""   Name: "",$E($S($P(IBX,U,1)]"""":$P(IBX,U,1),1:""<none>"")_$J("""",20),1,20),""   Number: "",$E($S($P(IBX,U,2)]"""":$P(IBX,U,2),1:""<none>""),1,14)"
 D ^DIC K DIC I +Y>0 S IBCPOL=+Y
 ;
 ; -- see if only one policy
 ;I '$O(^IBA(355.3,"B",+IBCNS,IBX) D  G LKQ
 ;
 ; -- is more than one plan to choose from, let fileman do it.
 ;S DIC("A")="Select GROUP INSURANCE PLAN: "
 ;
 ;S DIC="^IBA(355.3,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U)=IBCNS,($P(^(0),U,2)=1!($P(^(0),U,10)=$G(DFN)))"
 ;
 ;D ^DIC K DIC I +Y>0 S IBCPOL=+Y
 ;
LKQ Q IBCPOL
 ;
FUTURE ; -- if expiration date in future give warning
 I $G(IBFUTUR) K IBFUTUR Q
 I $P(^DPT(DFN,.312,IBCDFN,0),"^",4),$P(^(0),"^",4)>DT W !!,*7,"WARNING:  The expiration date for this policy is in the future!",!,"          Normally this is a past date or left blank or a past date",! S Y="@333"
 S IBFUTUR=1
 Q
 ;
COVERED(DFN,IBCOVP) ; -- update covered by insurance in background
 ; -- input ibcovp = the covered by insurance field prior to editing
 ;                   (add/edit/delete) of the 2.312 insurance type mult.
 ;
 Q:$G(DFN)<1
 N X,Y,I,IBCOV,IBNCOV,DA,DR,DIE,DIC,IBINS,IBINSD
 S (IBCOV,IBNCOV)=$P($G(^DPT(DFN,.31)),"^",11)
 D ALL^IBCNS1(DFN,"IBINS",2,DT) S IBINSD=+$G(IBINS(0))
 ;
 ; -- initial value ="" or Unknown
 I $G(IBCOVP)=""!($G(IBCOVP)="U") S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"U",IBINSD:"Y",1:"N")
 ;
 ; -- initial value = YES or NO (treat the same)
 I $G(IBCOVP)="Y"!($G(IBCOVP)="N") S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"N",IBINSD:"Y",1:"N")
 ;
 ;
 I IBCOV'=IBNCOV D
 .S DIE="^DPT(",DR=".3192////"_IBNCOV,DA=DFN D ^DIE
 .I '$D(ZTQUEUED)&($G(IBSUPRES)'>0) W !!,"COVERED BY HEALTH INSURANCE changed to '"_$S(IBNCOV="Y":"YES",IBNCOV="N":"NO",1:"UNKNOWN"),"'.",! H 3
 .Q
 Q
 ;
3 ; -- display group name as uneditable
 ;    called by die, expects da = entry in 355.3
 N X
 S X=$P($G(^IBA(355.3,DA,2)),"^",1)      ; IB*2.0*497 (vd)
 W !,"GROUP NAME: ",X,$S(X'="":"// ",1:""),"  (No Editing)"
 Q
 ;
4 ; -- display group number as uneditable
 ;    called by die, expects da = entry in 355.3
 N X
 S X=$P($G(^IBA(355.3,DA,2)),"^",2)      ; IB*2.0*497 (vd)
 W !,"GROUP NUMBER: ",X,$S(X'="":"// ",1:""),"  (No Editing)"
 Q
