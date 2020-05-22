IBCNSJ5 ;ALB/TMP - INSURANCE PLAN MAINTENANCE ACTION PROCESSING ; 09-AUG-95
 ;;2.0;INTEGRATED BILLING;**43,516,549,652**;21-MAR-94;Build 23
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PL ; -- Insurance Company Plan List
 D FULL^VALM1 W !!
 N VALMY,VALMHDR,IBIND,IBMULT,IBW,IBSEL
 S (IBIND,IBMULT)=1,IBW=1,IBSEL=0
 D EN^VALM("IBCNS PLAN LIST")
 Q
 ;
AB ; -- Edit Annual Benefits from insurance company edit OR plan detail edit
 ;IB*2.0*549 - Added Security Key check
 I '$D(^XUSEC("IB GROUP PLAN EDIT",DUZ)) D  Q
 . W !!,*7,"Sorry, but you do not have the required privileges to edit Annual Benefits."
 . K DIR
 . D PAUSE^VALM1
 . D ABQ
 ;
 I $D(IBCPOL) D FULL^VALM1,EN^VALM("IBCNS ANNUAL BENEFITS") S VALMBCK="R" G ABQ
 D FULL^VALM1
 N I,J,IBXX,VALMY,IBCDFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .N IBCPOL
 .S IBCPOL=$G(^TMP("IBCNSJ",$J,"IDX",IBXX,+$O(^TMP("IBCNSJ",$J,"IDX",IBXX,0))))
 .Q:IBCPOL=""
 .D FULL^VALM1
 .W !!,"Plan Name: ",$$GET1^DIQ(355.3,IBCPOL,2.01),"   Number: ",$$GET1^DIQ(355.3,IBCPOL,2.02)  ;Get new HIPAA fields - IB*2*516
 .K IBCDFN
 .D EN^VALM("IBCNS ANNUAL BENEFITS")
 .Q
ABQ ; Annual Benefits exit
 I $D(IBCPOL) D INIT^IBCNSC4
 S VALMBCK=$S($D(IBFASTXT):"Q",1:"R")
 K IBFASTXT
 Q
 ;
IA ; -- (In)activate plan from insurance company edit OR plan detail edit
 I '$D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ)) D  G IAQ
 . W !!,"Sorry, but you do not have the required privileges to inactivate plans."
 . D PAUSE^VALM1
 ;
 ;IB*2.0*549 - Added Security Key check
 I '$D(^XUSEC("IB GROUP PLAN EDIT",DUZ)) D  Q
 . W !!,*7,"Sorry, but you do not have the required privileges to inactivate plans."
 . K DIR
 . D PAUSE^VALM1
 . D IAQ
 ;
 D FULL^VALM1
 I $D(IBCPOL) D INACT^IBCNSJ1(+$P($G(^IBA(355.3,IBCPOL,0)),U),IBCPOL) G IAQ
 N I,J,IBXX,VALMY,IBCDFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 . N IBCPOL,IBCPND,IBCPND1
 . S IBCPOL=$G(^TMP("IBCNSJ",$J,"IDX",IBXX,+$O(^TMP("IBCNSJ",$J,"IDX",IBXX,0))))
 . Q:IBCPOL=""
 . D FULL^VALM1
 . S IBCPND=$G(^IBA(355.3,IBCPOL,0))
 . I '$P(IBCPND,U,2) W !,"You cannot inactivate an individual plan." D PAUSE^VALM1 Q
 . K IBCDFN
 . D INACT^IBCNSJ1(+$P($G(^IBA(355.3,IBCPOL,0)),U),IBCPOL),PAUSE^VALM1
 . S IBCPND1=$G(^IBA(355.3,IBCPOL,0))
 . I $P(IBCPND1,U,11)'=$P(IBCPND,U,11)!(IBCPND1="") D
 . . D INIT^IBCNSU2 ;Rebuild list if plan changed or deleted
 . . N IBCPOLD S IBCPOLD=$G(^IBA(355.3,+$G(IBCPOL),0))
 . . I IBCPOLD'="" D HDR^IBCNSC41
IAQ ; Inactivate Plans exit
 I $G(IBCPOL) D  ;Rebuild header
 . N IBCPOLD
 . S IBCPOLD=$G(^IBA(355.3,+$G(IBCPOL),0))
 . I IBCPOLD'="" D HDR^IBCNSC41
 S VALMBCK="R"
 Q
 ;
VP ; -- Edit/View Plan
 D FULL^VALM1
 N IBCND1,IBCDFND,IBCPOL,IBCPOLD,IBXX,VALMY,IBCDFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBCPOL=$G(^TMP("IBCNSJ",$J,"IDX",IBXX,+$O(^TMP("IBCNSJ",$J,"IDX",IBXX,0))))
 .Q:IBCPOL=""
 .D FULL^VALM1
 .K IBCDFN
 .D EN^VALM("IBCNS INS CO PLAN DETAIL")
 .Q
 I '$D(IBFASTXT) D INIT^IBCNSU2
 S VALMBCK="R"
 Q
 ;
PC ; Plan comments
 ;IB*2.0*549 - Added Security Key check
 I '$D(^XUSEC("IB GROUP PLAN EDIT",DUZ)) D  Q
 . W !!,*7,"Sorry, you do not have the required privileges enter comments"
 . W " about this plan."
 . K DIR
 . D PAUSE^VALM1
 . D PCQ
 ;
 W !!,"You may now enter comments about this plan."
 L +^IBA(355.3,+IBCPOL):5 I '$T D LOCKED^IBTRCD1 G PCQ
 S DIE="^IBA(355.3,",DA=IBCPOL,DR="11" D ^DIE
 D INIT^IBCNSC4
 L -^IBA(355.3,+IBCPOL)
PCQ ; Exit Enter plan comments
 S VALMBCK="R"
 Q
 ;
CP ;Change insurance plans
 D FULL^VALM1
 S DIR(0)="Y",DIR("A")="Do you want to see the list of plans for this insurance company"
 S DIR("?")="Enter 'YES' if you want to use the LIST MANAGER lookup facility on the previous screen to select a plan.  Enter 'NO' to select a plan using the standard Fileman lookup."
 S VALMBCK="R"
 D ^DIR K DIR I $D(DIRUT) G CPEX
 I Y S VALMBCK="Q" G CPEX
 ; MRD;IB*2.0*516 - Display new Group Name and Number fields.
 S DIC("S")="I $P(^(0),U)=$G(IBCNS)",DIC="^IBA(355.3,",DIC(0)="AEMQ"
 ;S DIC("W")="N IBX S IBX=$G(^(0)) W ""  Name: "",$E($S($P(IBX,U,3)'="""":$P(IBX,U,3),1:""<none>"")_$J("""",20),1,20),""  Number: "",$S($P(IBX,U,4)'="""":$P(IBX,U,4),1:""<none>"")"
 S DIC("W")="N IBX,IBX2 S IBX=$G(^(0)),IBX2=$G(^(2)) W ""  Name: "",$E($S($P(IBX2,U,1)'="""":$P(IBX2,U,1),1:""<none>"")_$J("""",20),1,20),""  Number: "",$E($S($P(IBX2,U,2)'="""":$P(IBX2,U,2),1:""<none>""),1,14)"
 S DIC("W")=DIC("W")_",""  "",$S($P(IBX,U,2):""GROUP"",1:""INDIVIDUAL""),""  "",$S($P(IBX,U,11):""IN"",1:""""),""ACTIVE"""
 S DIC("A")="Select "_$P($G(^DIC(36,+$G(IBCNS),0)),U)_" PLAN: "
 D ^DIC K DIC
 G:Y<0 CPEX S IBCPOL=+Y
 D INIT^IBCNSC4
CPEX Q
 ;
CV ;Edit coverage limitations from edit patient policy
 ;IB*2.0*549 - Added Security Key check
 I '$D(^XUSEC("IB GROUP PLAN EDIT",DUZ)) D  Q
 . W !!,*7,"Sorry, but you do not have the required privileges edit Coverage Limitations."
 . K DIR
 . D PAUSE^VALM1
 . S VALMBCK="R"
 D EDCOV^IBCNSJ51
 D BLD^IBCNSP
 Q
 ;
CV1 ;Edit coverage limitations from edit plan
 ;IB*2.0*549 - Added Security Key check
 I '$D(^XUSEC("IB GROUP PLAN EDIT",DUZ)) D  Q
 . W !!,*7,"Sorry, but you do not have the required privileges edit Coverage Limitations."
 . K DIR
 . D PAUSE^VALM1
 . S VALMBCK="R"
 D EDCOV^IBCNSJ51
 D INIT^IBCNSC4
 Q
 ;
 ;IB*2.0*652/TAZ - Add logic for New Plan
NP ;Add a New Plan without subscribers
 N DA,DIE,DR,IBCPOL
 D FULL^VALM1 W !!
 ; Add plan and check for duplicates
 D NEW^IBCNSJ3(IBCNS,.IBCPOL,,1,1)
 ; If plan not added go to exit
 I IBCPOL<1 G NPQ
 ;
 W !!,"Now you may enter the plan information.",!
 ;Edit fields of New Policy
 S DIE="^IBA(355.3,",DA=IBCPOL
 S DR="S IBAD=$P($G(^IBA(355.3,DA,0)),U,2),Y=$S(IBAD=0:""@55"",IBAD="""":""@1"",1:""@25"");"
 S DR=DR_"@1;.02;@25;2.01;2.02;@55;6.02;6.03;.09;.15;S Y=$S($$CATOK^IBCEMRA($P(^(0),U,14)):""@60"",1:""@65"");"
 S DR=DR_"@60;.14;@65;.16;I '$$FTFV^IBCNSU31(X) S Y=""@66"";.17;@66;.13;.05;.12;.06;.07;.08//YES;"
 D ^DIE
 ;
NPQ ;
 I '$D(IBFASTXT) D INIT^IBCNSU2
 S VALMBCK="R"
 Q
 ;
