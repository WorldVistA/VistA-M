IBCNSP11 ;ALB/AAS - INSURANCE MANAGEMENT - EDIT PLAN ;23-JAN-95
 ;;2.0;INTEGRATED BILLING;**28,43,85,103,137,251,399,516,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PI ; -- edit plan information from policy edit
 D FULL^VALM1
 ;
 ;IB*2.0*549 - Added Security Key check
 I '$D(^XUSEC("IB GROUP PLAN EDIT",DUZ)) D  Q
 . W !!,*7,"Sorry, but you do not have the required privileges to edit Plan Information."
 . K DIR
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 N IBCDFN,IBCPOL
 S IBCDFN=$P($G(IBPPOL),"^",4)
 ;
 ; - build a plan on the fly if there is not one present
 S IBCPOL=$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",18)
 I IBCPOL="" S IBCPOL=$$CHIP^IBCNSU($G(^DPT(DFN,.312,IBCDFN,0))) I IBCPOL D  ;Stuff in file
 .S DIE="^DPT("_DFN_",.312,",DR=".18////"_IBCPOL
 .S DA=IBCDFN,DA(1)=DFN
 .D ^DIE
 .K DA,DR,DIE,DIC
 .Q
 D PIEDIT(IBCPOL,DFN,IBCDFN)
 Q
 ;
PI1 ; -- edit plan information from plan edit
 D FULL^VALM1
 ;
 ;IB*2.0*549 - Added Security Key check
 I '$D(^XUSEC("IB GROUP PLAN EDIT",DUZ)) D  Q
 . W !!,*7,"Sorry, but you do not have the required privileges to edit Plan Information."
 . K DIR
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 D PIEDIT(IBCPOL,"","")
 Q
 ;
PIEDIT(IBCPOL,IBDFN,IBCDFN) ;Entry point if already have the plan (IBCPOL)
 ; -- Edit the plan specific info
 ; The following parameters are only used when editing plan via the patient policy
 ; IBDFN = DFN of patient
 ; IBCDFN = entry # of multiple for policy in .312 nodes of ^DPT
 N DIRUT,DTOUT,DUOUT,DIROUT,IBDIF,DA,DR,DIC,DIE,IBCPOLD,IBGRP,IBTL,IBCNSEH,IBSUB
 D SAVE^IBCNSP3(IBCPOL)
 L +^IBA(355.3,+IBCPOL):5 I '$T D LOCKED^IBTRCD1 G PIQ
 S IBCNSEH=$S($G(IBDFN):+$G(^IBE(350.9,1,4)),1:0) D POL^IBCNSEH
 S IBCPOLD=$G(^IBA(355.3,IBCPOL,0)),IBGRP=$P(IBCPOLD,"^",2)
 I $P(IBCPOLD,"^",11) W !?2,*7,"Please note that this plan is inactive!",!
 W !,"This plan is currently defined as a",$S(IBGRP:" Group",1:"n Individual")," Plan."
 S IBSUB=$$SUBS^IBCNSJ(+$G(^IBA(355.3,IBCPOL,0)),IBCPOL,0,"",1)
 I 'IBGRP,IBSUB>1 W !!,"This Individual Plan has more than one subscriber!" G CHG
 I IBGRP,IBSUB>1 W !!,"There is more than one subscriber to this Group Plan.  The plan cannot",!,"be changed to an individual plan.",! G PIC
 ;
 ; - switch the plan to group/individual
 S DIR("A")="Do you wish to change this plan to a"_$S(IBGRP:"n Individual",1:" Group")_" Plan"
 S DIR(0)="Y",DIR("?")="Enter 'YES' to change this plan, or enter 'NO' to leave it as is."
 D ^DIR K DIR I $D(DIRUT) G PIQ1
 I 'Y W !,"No change was made.",! G PIC
 ;
CHG ; - change the plan type
 W !,"Changing the plan to a",$S(IBGRP:"n Individual",1:" Group")," Plan... "
 S DIE="^IBA(355.3,",DA=IBCPOL,DR=".02////"_$S(IBGRP:0,1:1)_";.1////"_$S(IBGRP&$G(IBDFN):IBDFN,1:"@")
 D ^DIE K DIE,DA,DR W "done.",!
 ;
PIC ; - edit name/number/type
 S IBTL=$S($P($G(^IBA(355.3,IBCPOL,0)),"^",2):"GROUP",1:"INDIVIDUAL")_" PLAN"
 S DIE="^IBA(355.3,",DA=IBCPOL
 ;IB*2.0*516/baa Use HIPAA Compliant fields - .03 to 2.01 .04 to 2.02
 ;S DR=".03"_IBTL_" NAME;.04"_IBTL_" NUMBER;6.02;6.03;.09;.15;S Y=$S($$CATOK^IBCEMRA($P(^IBA(355.3,IBCPOL,0),U,14)):""@1"",1:""@10"");@1;.14;@10;.16;I '$$FTFV^IBCNSU31(X) S Y=""@13"";.17;@13;.13"
 S DR="2.01"_IBTL_" NAME;2.02"_IBTL_" NUMBER;6.02;6.03;.09;.15;S Y=$S($$CATOK^IBCEMRA($P(^IBA(355.3,IBCPOL,0),U,14)):""@1"",1:""@10"");@1;.14;@10;.16;I '$$FTFV^IBCNSU31(X) S Y=""@13"";.17;@13;.13"
 ;
 D ^DIE K DIC,DIE,DA,DR
 D COMP^IBCNSP3(IBCPOL)
 I IBDIF D UPDATE^IBCNSP3(IBCPOL) D:$G(IBDFN) UPDATPT^IBCNSP3(IBDFN,IBCDFN),BLD^IBCNSP D:'$G(IBDFN) INIT^IBCNSC4
PIQ1 L -^IBA(355.3,+IBCPOL)
PIQ S VALMBCK="R"
 Q
