IBCNSJ14 ;ALB/CPM - INACTIVATE AN INSURANCE PLAN (CON'T) ; 07-MAR-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SEL ; Select a company and plan.
 ;   Required variable input:
 ;           IBCNS  --  Pointer to the current company in file #36
 ;   Variable output:
 ;          IBPLAN  --  Pointer to the selected plan in file #355.3
 ;          IBQUIT  --  Set to 1 if user wants to quit.
 ;
 ; - does the user want to switch companies?
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Inactivate another plan offered by the same company",DIR("?")="To inactivate another plan from this company, answer 'YES.'  To switch companies, answer 'NO.'"
 D ^DIR K DIR I $D(DIRUT) S IBQUIT=1 G SELQ
 ;
SEL4 ; - this entry point is supported for a call from IBCNSJ4.
 ;     Input:  IBINACTM  --  [optional]: set to 1 if entry is from
 ;                           IBCNSJ4 (the multiple plan inactivator).
 ;                           If entry is from IBCNSJ4, inactive plans
 ;                           may not be selected.
 ;                    Y  --  must be set to 0 when called by IBCNSJ4.
 ;
 I 'Y D  I IBQUIT G SELQ
 .S DIC(0)="QEAMZ",DIC="^DIC(36,",DIC("S")="I $$ANYGP^IBCNSJ(+Y,0,1)"
 .S DIC("A")="Select PLAN COMPANY: "
 .D ^DIC K DIC S IBCNS=+Y I Y<0 S IBQUIT=1
 ;
 ; - see if user wants to directly select the plan
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you wish to directly enter this plan"
 S DIR("?")="The look-up facility to select "_$S($G(IBINACTM):"an active",1:"a")_" group plan has been enhanced to use the List Manager.  Enter 'NO' if you wish to select a plan from this look-up, or 'YES' to directly enter the plan."
 D ^DIR K DIR I $D(DIRUT) S IBQUIT=1 G SELQ
 ;
 ; - invoke the plan look-up
 I 'Y D  G SELQ
 .W "   ..." S IBPLAN=0 D LKP^IBCNSU2(IBCNS,0,0,.IBPLAN,0,'$G(IBINACTM))
 .I 'IBPLAN W !!,"No plan selected!",! S IBQUIT=1
 ;
 ; - allow a FileMan look-up
 S DIC("A")="Select "_$S($G(IBINACTM):"an Active",1:"a")_" GROUP PLAN: "
 S DIC="^IBA(355.3,",DIC(0)="AEQM",DIC("S")="I +^(0)=IBCNS,$P(^(0),U,2)"
 S DIC("W")="N IBX S IBX=$G(^(0)) W ""   Name: "",$E($S($P(IBX,U,3)]"""":$P(IBX,U,3),1:""<none>"")_$J("""",20),1,20),""   Number: "",$S($P(IBX,U,4)]"""":$P(IBX,U,4),1:""<none>"")"
 I $G(IBINACTM) S DIC("S")=DIC("S")_",'$P(^(0),U,11)"
 D ^DIC K DIC S IBPLAN=+Y I Y<0 S IBQUIT=1
 ;
SELQ K DIRUT,DUOUT,DTOUT,DIROUT
 Q
