IBCNSJ5 ;ALB/TMP - INSURANCE PLAN MAINTENANCE ACTION PROCESSING ; 09-AUG-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**43**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PL ; -- Insurance Company Plan List
 D FULL^VALM1 W !!
 N VALMY,VALMHDR,IBIND,IBMULT,IBW,IBSEL
 S (IBIND,IBMULT)=1,IBW=1,IBSEL=0
 D EN^VALM("IBCNS PLAN LIST")
 Q
 ;
AB ; -- Edit Annual Benefits from insurance company edit OR plan detail edit
 I $D(IBCPOL) D FULL^VALM1,EN^VALM("IBCNS ANNUAL BENEFITS") S VALMBCK="R" G ABQ
 D FULL^VALM1
 N I,J,IBXX,VALMY,IBCDFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .N IBCPOL
 .S IBCPOL=$G(^TMP("IBCNSJ",$J,"IDX",IBXX,+$O(^TMP("IBCNSJ",$J,"IDX",IBXX,0))))
 .Q:IBCPOL=""
 .D FULL^VALM1
 .W !!,"Plan Name: ",$P($G(^IBA(355.3,IBCPOL,0)),U,3),"   Number: ",$P($G(^IBA(355.3,IBCPOL,0)),U,4)
 .K IBCDFN
 .D EN^VALM("IBCNS ANNUAL BENEFITS")
 .Q
ABQ I $D(IBCPOL) D INIT^IBCNSC4
 S VALMBCK=$S($D(IBFASTXT):"Q",1:"R") K IBFASTXT Q
 ;
IA ; -- (In)activate plan from insurance company edit OR plan detail edit
 I '$D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ)) W !!,"Sorry, but you do not have the required privileges to inactivate plans." D PAUSE^VALM1 G IAQ
 D FULL^VALM1
 I $D(IBCPOL) D INACT^IBCNSJ1(+$P($G(^IBA(355.3,IBCPOL,0)),U),IBCPOL) G IAQ
 N I,J,IBXX,VALMY,IBCDFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .N IBCPOL,IBCPND,IBCPND1
 .S IBCPOL=$G(^TMP("IBCNSJ",$J,"IDX",IBXX,+$O(^TMP("IBCNSJ",$J,"IDX",IBXX,0))))
 .Q:IBCPOL=""
 .D FULL^VALM1
 .S IBCPND=$G(^IBA(355.3,IBCPOL,0))
 .I '$P(IBCPND,U,2) W !,"You cannot inactivate an individual plan." D PAUSE^VALM1 Q
 .K IBCDFN
 .D INACT^IBCNSJ1(+$P($G(^IBA(355.3,IBCPOL,0)),U),IBCPOL),PAUSE^VALM1
 .S IBCPND1=$G(^IBA(355.3,IBCPOL,0))
 .I $P(IBCPND1,U,11)'=$P(IBCPND,U,11)!(IBCPND1="") D
 ..D INIT^IBCNSU2 ;Rebuild list if plan changed or deleted
 ..N IBCPOLD S IBCPOLD=$G(^IBA(355.3,+$G(IBCPOL),0))
 ..I IBCPOLD'="" D HDR^IBCNSC41
IAQ I $G(IBCPOL) D  ;Rebuild header
 .N IBCPOLD S IBCPOLD=$G(^IBA(355.3,+$G(IBCPOL),0))
 .I IBCPOLD'="" D HDR^IBCNSC41
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
 W !!,"You may now enter comments about this plan."
 L +^IBA(355.3,+IBCPOL):5 I '$T D LOCKED^IBTRCD1 G PCQ
 S DIE="^IBA(355.3,",DA=IBCPOL,DR="11" D ^DIE
 D INIT^IBCNSC4
 L -^IBA(355.3,+IBCPOL)
PCQ S VALMBCK="R" Q
 ;
CP ;Change insurance plans
 D FULL^VALM1
 S DIR(0)="Y",DIR("A")="Do you want to see the list of plans for this insurance company"
 S DIR("?")="Enter 'YES' if you want to use the LIST MANAGER lookup facility on the previous screen to select a plan.  Enter 'NO' to select a plan using the standard Fileman lookup."
 S VALMBCK="R"
 D ^DIR K DIR I $D(DIRUT) G CPEX
 I Y S VALMBCK="Q" G CPEX
 S DIC("S")="I $P(^(0),U)=$G(IBCNS)",DIC="^IBA(355.3,",DIC(0)="AEMQ"
 S DIC("W")="N IBX S IBX=$G(^(0)) W ""  Name: "",$E($S($P(IBX,U,3)'="""":$P(IBX,U,3),1:""<none>"")_$J("""",20),1,20),""  Number: "",$S($P(IBX,U,4)'="""":$P(IBX,U,4),1:""<none>"")"
 S DIC("W")=DIC("W")_",""  "",$S($P(IBX,U,2):""GROUP"",1:""INDIVIDUAL""),""  "",$S($P(IBX,U,11):""IN"",1:""""),""ACTIVE"""
 S DIC("A")="Select "_$P($G(^DIC(36,+$G(IBCNS),0)),U)_" PLAN: "
 D ^DIC K DIC
 G:Y<0 CPEX S IBCPOL=+Y
 D INIT^IBCNSC4
CPEX Q
 ;
CV ;Edit coverage limitations from edit patient policy
 D EDCOV^IBCNSJ51
 D BLD^IBCNSP
 Q
CV1 ;Edit coverage limitations from edit plan
 D EDCOV^IBCNSJ51
 D INIT^IBCNSC4
 Q
 ;
