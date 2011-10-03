IBCNSUX ;ALB/CMS - SPLIT MEDICARE COMBINATION PLANS ; 29-OCT-98
 ;;2.0;INTEGRATED BILLING;**103**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine shoud not be modified.
 ;
 Q
 ;
EN ; Entry point from option.
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,1:0) W !!?3,"The variable DUZ must be set to an active user code before continuing." G ENQ
 W !!,?5,"SPLIT MEDICARE PART A /PART B COMBINATION PLANS"
 W !!,?5,"WARNING: CAUTION SHOULD BE TAKEN WHEN USING THIS OPTION!!"
 W !!,?5,"This option should ONLY be used at sites that have created a"
 W !,?5,"Medicare, Will Not Reimburse, Insurance Company which has a"
 W !,?5,"non-standard Group plan associated with it that combines Part A"
 W !,?5,"and Part B coverage.",!
 W !,?5,"Make sure the correct plan is selected. This option will create"
 W !,?5,"a Part B policy for each subscriber and edit the existing policy"
 W !,?5,"to point it to the standard Medicare Part A policy."
 W !!,$TR($J("",75)," ","-")
 ;
 N IBINS,IBPLAN,IBQUIT,IBWNR,X,Y
 S IBWNR=$$GETWNR^IBCNSMM1,IBQUIT=0
 I 'IBWNR W !!,*7,?5,IBWNR G ENQ
 ;
 ;I DT>2990301 W !!,*7,?5,"This option cannot be run after March 3, 1999."
 ;
 D SEL I IBQUIT G ENQ
 ;
 W !,"ALL POLICIES ENTERED FOR THE SELECTED COMBINATION PLAN WILL BE CHANGED"
 W !,"TO BE ASSOCIATED WITH MEDICARE PART A AND A NEW POLICY CREATED FOR "
 W !,"MEDICARE PART B.  THE COMBINATION PLAN WILL BE DELETED IF EMPTY!"
 ;
 D OKAY I IBQUIT G ENQ
 ;
 ; -- Ask Device
 N IBX,%ZIS,ZTRTN,ZTSAVE,ZTDESC
 W !,?10,"You should send the output to a printer.",!
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 .F IBX="IBINS","IBPLAN","IBWNR" S ZTSAVE(IBX)=""
 .S ZTRTN="BEG^IBCNSUX1",ZTDESC="IB - Separate Medicare Combination policies"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 I $E(IOST,1,2)["C-" W !!,?15,"...... One Moment Please ..."
 D BEG^IBCNSUX1
 ;
QUEQ ; Exit Clean-up
 W ! D ^%ZISC
 ;
ENQ Q
 ;
SEL ; Select a MEDICARE company and plan.
 ;  Output:   IBINS  --  Pointer to selected company in file #36
 ;           IBPLAN  --  Pointer to selected/added plan in file #355.3
 ;           IBQUIT  --  Set to 1 if the user wants to quit.
 ;
 N DA,DIC,DIRUT,DIROUT,DTOUT,DUOUT,DR,IBX,IBY,X,Y,IBSUBS
 S IBY=$O(^IBE(355.2,"B","MEDICARE",0))
 S DIC(0)="QEAMZ",DIC="^DIC(36,"
 S DIC("S")="I $$ANYGP^IBCNSJ(+Y,0,1),$P($G(^DIC(36,+Y,0)),U,13)=IBY"
 S DIC("A")="Select MEDICARE INSURANCE COMPANY: "
 D ^DIC K DIC S IBINS=+Y
 I Y<0 W "   <No Insurance Company selected>" S IBQUIT=1 G SELQ
 ;
SELP ; - select the Combination Plan
 K DIC
 S DIC("A")="Select COMBINATION GROUP PLAN: "
 S DIC="^IBA(355.3,",DIC(0)="AEQMZ"
 S DIC("S")="I +^(0)=IBINS,$P(^(0),U,2)"
 S DIC("W")="N IBX S IBX=$G(^(0)) W ""   Name: "",$E($S($P(IBX,U,3)]"""":$P(IBX,U,3),1:""<none>"")_$J("""",20),1,20),""   Number: "",$S($P(IBX,U,4)]"""":$P(IBX,U,4),1:""<none>"")"
 D ^DIC K DIC S IBPLAN=+Y
 I IBPLAN=$P(IBWNR,U,3) W !!,?5,*7,"* Cannot select standard Part A plan" G SELP
 I IBPLAN=$P(IBWNR,U,5) W !!,?5,*7,"* Cannot select standard Part B plan" G SELP
 I Y<0 W !!,?5,*7,"*  No plan selected!",! S IBQUIT=1 G SELQ
 W !!,"Collecting Subscribers ..."
 S IBSUBS=$$SUBS^IBCNSJ(IBINS,IBPLAN)
 W !!,?5,"This plan has ",IBSUBS," subscriber",$S(IBSUBS=1:"",1:"s"),"."
 W:'IBSUBS !?5,"You must select a plan with subscribers!  Please select another plan."
 W !! I 'IBSUBS G SELP
 ;
SELQ Q
 ;
OKAY ; -- Ask Okay to Continue
 ;    Returns IBQUIT=1 to exit
 N DIR,DTOUT,DIROUT,DIRUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO",DIR("A")="Okay to Continue"
 S DIR("?")="Enter 'Yes' to separate combination policies"
 W ! D ^DIR
 I $G(Y)'=1 S IBQUIT=1
 Q
