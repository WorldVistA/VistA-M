IBCNSM3 ;ALB/AAS - INSURANCE MANAGEMENT - OUTPUTS ; 4/7/03 9:56am
 ;;2.0;INTEGRATED BILLING;**6,28,85,211,251,399,506,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% G EN^IBCNSM
 ;
AD ; -- Add new insurance policy
 N X,Y,DO,DD,DA,DR,DIC,DIE,DIK,DIR,DIRUT,IBCNSP,IBCPOL,IBQUIT,IBOK,IBCDFN,IBAD,IBGRP,IBADPOL,IBCOVP,ANS,IBGNA,IBGNU
 S IBCNSEH=$P($G(^IBE(350.9,1,4)),"^",1),IBQUIT=0,IBADPOL=1
 D FULL^VALM1
 S IBCOVP=$P($G(^DPT(DFN,.31)),"^",11)
 I '$D(^DPT(DFN,.312,0)) S ^DPT(DFN,.312,0)="^2.312PAI^^"
 ;
 D INS^IBCNSEH
 ; -- Select insurance company
 ;    If one already exists for same co. ask are you sure you are
 ;    adding a new one
 S DIR(0)="350.9,4.06"
 S DIR("A")="Select INSURANCE COMPANY",DIR("??")="^D ADH^IBCNSM3"
 S DIR("?")="Select the Insurance Company for the policy you are entering"
 D ^DIR K DIR S IBCNSP=+Y I Y<1 G ADQ
 I $P($G(^DIC(36,+IBCNSP,0)),"^",2)="N" W !,"This company does not reimburse.  "
 I $P($G(^DIC(36,+IBCNSP,0)),"^",5) W !,*7,"Warning: Inactive Company" H 3 K IBCNSP G ADQ
 I $$DUPCO^IBCNSOK1(DFN,IBCNSP,"",1) H 3
 ;
 ; -- see if can use existing policy
 D SEL^IBCNSEH
 S IBCPOL=$$LK^IBCNSM31(IBCNSP)
 ;
 ; IB*2.0*506 added IBKEY parameter (4th) to the NEW^IBCNSJ3 call (check user's security keys)
 I IBCPOL<1 D NEW^IBCNSJ3(IBCNSP,.IBCPOL,,1)
 I IBCPOL<1 G ADQ
 ;
 ; -- file new patient policy
 ;IB*2.0*516/baa - Use HIPAA Compliant fields
 ;S DIC("DR")=".18////"_IBCPOL_";1.09////1;1.05///NOW;1.06////"_DUZ
 S DIC("DR")=".18////"_IBCPOL_";1.09////7.02;1.05///NOW;1.06////"_DUZ
 K DD,DO S DA(1)=DFN,DIC="^DPT("_DFN_",.312,",DIC(0)="L",X=IBCNSP D FILE^DICN K DIC S IBCDFN=+Y,IBNEW=1 I +Y<1 G ADQ
 D BEFORE^IBCNSEVT
 ;
 ; -- Edit patient policy data
 D PAT^IBCNSEH,PATPOL^IBCNSM32(IBCDFN)
 ;
 ; -- edit PLAN data if hold key
 I '$D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ)) G ADQ
 I '$G(IBQUIT) D POL^IBCNSEH,EDPOL(IBCDFN)
 I '$G(IBNEW) D AI^IBCNSP1
 G ADQ
 ;
ADQ D COVERED^IBCNSM31(DFN,IBCOVP)
 I $G(IBCDFN)>0 D AFTER^IBCNSEVT,^IBCNSEVT
 I $G(IBCPOL)>0 D BLD^IBCNSM
 S VALMBCK="R"
 Q
 ;
EDPOL(IBCDFN) ; -- Edit GROUP PLAN specific info
 I '$G(IBCDFN) G EDPOLQ
 N DA,DR,DIE,DIC,IBAD,IBCPOL,IBDIF
 S IBCPOL=$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",18)
 L +^IBA(355.3,+IBCPOL):5 I '$T D LOCKED^IBTRCD1 G EDPOLQ
 I IBCPOL D
 .D SAVE^IBCNSP3(IBCPOL)
 .S DIE="^IBA(355.3,",DA=IBCPOL
 .;IB*2.0*516/baa - Use HIPAA Compliant fields
 .;S DR="S IBAD=$P($G(^IBA(355.3,DA,0)),U,2),Y=$S(IBAD=0:""@55"",IBAD="""":""@1"",1:""@25"");@1;.02;@25;.03;.04;@55;6.02;6.03;.09;"
 .S DR="S IBAD=$P($G(^IBA(355.3,DA,0)),U,2),Y=$S(IBAD=0:""@55"",IBAD="""":""@1"",1:""@25"");@1;.02;@25;2.01;2.02;@55;6.02;6.03;.09;"
 .S DR=DR_".15;S Y=$S($$CATOK^IBCEMRA($P(^(0),U,14)):""@60"",1:""@65"");@60;.14;@65;.16;I '$$FTFV^IBCNSU31(X) S Y=""@66"";.17;@66;.13;.05;.12;.06;.07;.08//YES;"
 .;
 .I $D(IBREG),'$G(IBNEWP) S DR="S IBAD=$P($G(^IBA(355.3,DA,0)),U,2),Y=$S(IBAD=0:""@55"",IBAD="""":""@1"",1:""@25"");@1;.02;@25;D 3^IBCNSM31;D 4^IBCNSM31;@55;6.02;6.03;.09;"
 .I $D(IBREG),'$G(IBNEWP) S DR=DR_".15;S Y=$S($$CATOK^IBCEMRA($P(^(0),U,14)):""@60"",1:""@65"");@60;.14;@65;.16;I '$$FTFV^IBCNSU31(X) S Y=""@66"";.17;@66;.13;.05;.12;.06;.07;.08//YES;"
 .;
 .D ^DIE
 .D COMP^IBCNSP3(IBCPOL)
 .I IBDIF D UPDATE^IBCNSP3(IBCPOL),UPDATPT^IBCNSP3(DFN,IBCDFN) I $$DUPPOL^IBCNSOK1(IBCPOL,1)
 L -^IBA(355.3,+IBCPOL)
EDPOLQ Q
 ;
OK ; -- ask okay
 S IBQUIT=0,DIR(0)="Y",DIR("A")="       ...OK",DIR("B")="YES" D ^DIR K DIR
 I $D(DIRUT) S IBQUIT=1
 S IBOK=Y
 Q
 ;
ADH ; -- show existing policies for help
 N DIR,DA,%A
 W !!,"The patient currently has the following Insurance Policies"
 D DISP^IBCNS
 Q
