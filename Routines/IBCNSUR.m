IBCNSUR ;ALB/CPM/CMS - MOVE SUBSCRIBERS TO DIFFERENT PLAN ;09-SEP-96
 ;;2.0;INTEGRATED BILLING;**103,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EN ; Entry point from option. Main processing loop.
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,1:0) W !!?3,"The variable DUZ must be set to an active user code before continuing." G ENQ
 W !!,?5,"MOVE SUBSCRIBERS OF ONE PLAN TO ANOTHER PLAN"
 W !,?5,"This option may be used to move subscribers from a selected Plan"
 W !,?5,"to a different Plan. The plans may be associated with the same"
 W !,?5,"Insurance Company or a different one. Plan and Annual Benefit"
 W !,?5,"information may be moved as well. Users of this option should"
 W !,?5,"be knowledgeable of the VistA Patient Insurance management options."
 W !
 W !,?5,"This option also gives the user the option to expire the old plan or"
 W !,?5,"replace it completely in the patient insurance profile.  The reason"
 W !,?5,"to expire the old plan is intended for use when Insurance groups change"
 W !,?5,"PBMs for processing electronic Pharmacy claims.  By leaving the old"
 W !,?5,"plan information intact (i.e. do not replace), the user will be able"
 W !,?5,"to monitor PBM changes  that affect the electronic Pharmacy claims."
 ;
 W !!,$TR($J("",75)," ","-")
 S IBSTOP=0 F  D PROC^IBCNSUR1 Q:IBSTOP
ENQ K IBSTOP
 Q
 ;
PROC ; - Process continuation from IBCNSUR1. 
 ; - display old plan attributes; allow new plan to be edited
 D PL^IBCNSUR2
 R !!,?10,"Press any key to continue.    ",IBX:DTIME
 ;
 ; - display coverage limitations; allow add/edit of plan 2 limitations
 D LIM^IBCNSUR2
 ;
 I $P($G(^IBA(355.3,IBP1,0)),"^",11) W !!,"Please note that ",IBC1N,"'s",!,"plan, subscribers were moved from, is already inactive." G PROCDP
 ;
 ; - does the user wish to inactivate the old plan?
 W !! S DIR(0)="Y",DIR("A")="Do you wish to inactivate "_IBC1N_"'s plan subscribers were moved from"
 S DIR("?")="If you wish to inactivate the old plan, enter 'Yes' - otherwise, enter 'No.'"
 D ^DIR K DIR I 'Y W !," <The old plan is still active>" G PROCQ
 ;
 D IRACT^IBCNSJ(IBP1,1) W !!,"The plan has been inactivated."
 ;
PROCDP ; - does the user wish to delete the old plan?
 W !! S DIR(0)="Y",DIR("A")="Do you wish to delete this plan"
 S DIR("?")="If you wish to delete the old plan, enter 'Yes' - otherwise, enter 'No.'"
 D ^DIR K DIR I 'Y G PROCQ
 ;
 D DEL^IBCNSJ(IBP1) W !!,"The plan has been deleted."
 ;
PROCQ Q
 ;
 ;
SEL(IBNP) ; Select a company and plan.
 ;   Input:     IBNP  --  If set to 1, allows adding a new plan and
 ;                    --  Screen Inactive Companies
 ;                    --  If set to 0, must have at least one group plan
 ;  Output:   IBCNS  --  Pointer to selected company in file #36
 ;           IBPLAN  --  Pointer to selected/added plan in file #355.3
 ;           IBQUIT  --  Set to 1 if the user wants to quit.
 ;
 N X,Y K DIC,DIR
 S DIC(0)="QEAMZ",DIC="^DIC(36,"
 I 'IBNP S DIC("S")="I $$ANYGP^IBCNSJ(+Y,0,1)"
 I IBNP S DIC("S")="I '$P($G(^DIC(36,+Y,0)),U,5)"
 S DIC("A")="Select INSURANCE COMPANY: "
 D ^DIC K DIC S IBCNS=+Y
 I Y<0 W "   <No Insurance Company selected>" S IBQUIT=1 G SELQ
 ;
 ; - if a new plan may be added, allow adding
 I IBNP D  I (IBPLAN)!(IBQUIT) G SELQ
 .W !!,"You may add a new Plan at this time or select an existing Plan."
 .D NEW^IBCNSJ3(IBCNS,.IBPLAN,1)
 .I 'IBPLAN,'$$ANYGP^IBCNSJ(+IBCNS,0,1) W !!,*7,"Insurance Company receiving subscribers must have a Plan." S IBQUIT=1
 ;
 ; - see if user wants to select the plan
 W !!,"You may select an existing Plan from a list or enter a specific Plan.",!
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you wish to enter a specific plan"
 S DIR("?")="The look-up facility to select a group plan has been enhanced to use the List Manager.  Enter 'NO' if you wish to select a plan from this look-up, or 'YES' to directly enter a plan."
 D ^DIR K DIR I $D(DIRUT) S IBQUIT=1 G SELQ
 ;
 ; - invoke the plan look-up
 I 'Y D  G SELQ
 .W "   ..." S IBPLAN=0 D LKP^IBCNSU2(IBCNS,0,0,.IBPLAN,0,1)
 .I 'IBPLAN W !!,*7,"*  No plan selected!",! S IBQUIT=1
 ;
 ; - allow a FileMan look-up
 S DIC("A")="Select a GROUP PLAN: "
 S DIC="^IBA(355.3,",DIC(0)="AEQM",DIC("S")="I +^(0)=IBCNS,$P(^(0),U,2)"
 S DIC("W")="N IBX S IBX=$G(^(0)) W ""   Name: "",$E($S($P(IBX,U,3)]"""":$P(IBX,U,3),1:""<none>"")_$J("""",20),1,20),""   Number: "",$S($P(IBX,U,4)]"""":$P(IBX,U,4),1:""<none>"")"
 D ^DIC K DIC S IBPLAN=+Y
 I Y<0 W !!,*7,"*  No plan selected!",! S IBQUIT=1
 ;
SELQ K DIRUT,DUOUT,DTOUT,DIROUT
 Q
