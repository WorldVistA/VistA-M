IBCNSJ3 ;ALB/CPM - ADD NEW INSURANCE PLAN ; 11-JAN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NEW(IBCNS,IBCPOL,IBFG) ; Add a new insurance plan
 ;  Input:   IBCNS  --  Pointer to an insurance company in file #36
 ;            IBFG  --  [Optional] -> Set to 1 to force creation
 ;                      of a group plan
 ; Output:  IBCPOL  --  0, if a new plan was not added, or
 ;                      >0 => pointer to the new plan in file #355.3
 ;
 N DA,DIR,DIRUT,DIROUT,DTOUT,DUOUT,IBTL,IBGRP,IBGNA,IBGNU,X,Y
 S IBCPOL=0
 I '$G(IBCNS) G NEWQ
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to add a new Insurance Plan"
 S DIR("?")="If you have identified a new plan that has not been previously entered, and you wish to add it, answer 'YES'.  If you do not wish to add a new plan, enter 'NO'."
 D ^DIR K DIR I Y<1!($D(DIRUT)) G NEWQ
 ;
 ; - collect plan characteristics
 I $G(IBFG) S IBGRP=1 G MORE
 S DIR(0)="355.3,.02",DIR("A")="  IS THIS A GROUP PLAN" D ^DIR K DIR S IBGRP=Y
 I $D(DIRUT) G NEWQ
 ;
MORE S IBTL="  "_$S(IBGRP:"GROUP",1:"INDIVIDUAL")_" PLAN "
 S DIR(0)="355.3,.03",DIR("A")=IBTL_"NAME" D ^DIR K DIR G NEWQ:$D(DUOUT)!$D(DTOUT) S IBGNA=Y
 S DIR(0)="355.3,.04",DIR("A")=IBTL_"NUMBER" D ^DIR K DIR G NEWQ:$D(DUOUT)!$D(DTOUT) S IBGNU=Y
 ;
 ; - check for duplicates and file the plan
 I $$CHECK(IBCNS,IBGNA,IBGNU) S IBCPOL=$$ADDH^IBCNSU(IBCNS,IBGRP,IBGNA,IBGNU)
NEWQ Q
 ;
 ;
CHECK(IBCNS,IBGNA,IBGNU) ; Check for potential duplicate plans
 ;  Input:   IBCNS  --  Pointer to an insurance company in file #36
 ;           IBGNA  --  Plan Name for potential new plan
 ;           IBGNU  --  Plan Number for potential new plan
 ; Output:   IBANS  --  1 ->  Okay to add the new plan
 ;                      0 ->  Don't add the new plan.
 ;
 N IBANS,IBCT,IBCNSD
 S (IBANS,IBCT)=1
 S IBCNSD=$G(^DIC(36,+$G(IBCNS),0)) I IBCNSD="" G CHECKQ
 K ^TMP($J,"DUP"),^TMP($J,"DUP1")
 W !!,"  Searching for potential duplicate plans offered by ",$E($P(IBCNSD,"^"),1,20),"..."
 I '$D(^IBA(355.3,"B",IBCNS)) G CHECKQ
 ;
 ; - look for potential duplicate plans
 D:$G(IBGNA)]"" FIND(IBCNS,IBGNA)
 D:$G(IBGNU)]"" FIND(IBCNS,IBGNU)
 ;
 ; - display potential duplicates and see if plan should be filed
 I $D(^TMP($J,"DUP")) D LIST
 ;
CHECKQ I '$D(^TMP($J,"DUP")) W !!,"  No potential duplicate plans have been identified."
 K ^TMP($J,"DUP"),^TMP($J,"DUP1")
 Q IBANS
 ;
 ;
FIND(IBCNS,IBGN) ; Check cross-references for duplicate plans
 ;  Input:  IBCNS  --  Pointer to the insurance company in file #36
 ;           IBGN  --  value to use to find duplicates
 ;
 N INP,LEN,SUB,TYPE
 F SUB="AGNA","AGNU","ACCP" D
 .I SUB="ACCP" S IBGN=$$COMP^IBCNSJ(IBGN)
 .S INP=IBGN,LEN=$L(INP) Q:LEN<2!(LEN>20)
 .S TYPE=$S(IBGN?1N.N:"NUM",1:"STR")
 .I $D(^IBA(355.3,SUB,IBCNS,INP)) D GDATA
 .I TYPE="STR" F  S INP=$O(^IBA(355.3,SUB,IBCNS,INP)) Q:$E(INP,1,LEN)'=IBGN  D GDATA
 .I TYPE="NUM" F  S INP=$O(^IBA(355.3,SUB,IBCNS,INP)) Q:INP=""  I $E(INP,1,LEN)=IBGN D GDATA
 Q
 ;
GDATA ; Place potential duplicate plan into an array.
 N X,Y S X=0
 F  S X=$O(^IBA(355.3,SUB,IBCNS,INP,X)) Q:'X  I '$D(^TMP($J,"DUP",X)) D
 .S Y=$G(^IBA(355.3,X,0)),IBCT=IBCT+1
 .S ^TMP($J,"DUP",X)="",^TMP($J,"DUP1",IBCT)=$P(Y,"^",4)_U_$P(Y,"^",3)_U_$P(Y,"^",2)_U_$P(Y,"^",11)
 Q
 ;
LIST ; List potential duplicates to screen and prompt to add plan.
 W !!,"  The following plans have been identified as potential duplicates:"
 W !!,?3,"PLAN",?22,"PLAN",?45,"GROUP",?55,"ACTIVE",!,?2,"NUMBER",?22,"NAME",?45,"PLAN?",?55,"PLAN?",!
 S IBCT=0 F  S IBCT=$O(^TMP($J,"DUP1",IBCT)) Q:'IBCT  D
 .S IBST=$G(^TMP($J,"DUP1",IBCT))
 .W !?2,$S($P(IBST,"^")'="":$P(IBST,"^"),1:"<NO PLAN NUM>"),?22,$S($P(IBST,"^",2)'="":$P(IBST,"^",2),1:"<NO PLAN NAME>")
 .W ?45,$S($P(IBST,"^",3)'="":$$EXPAND^IBTRE(355.3,.02,$P(IBST,"^",3)),1:"<UNK>"),?55,$S($P(IBST,"^",4):"NO",1:"YES")
 ;
 ; - see if it is okay to add the plan
 S DIR(0)="Y",DIR("A",1)="Do you still want to add a new plan with Plan Name "_$S(IBGNA'="":IBGNA,1:"<NO PLAN NAME>")
 S DIR("A")="and Plan Number "_$S(IBGNU'="":IBGNU,1:"<NO PLAN NUMBER>")
 S DIR("B")="NO"
 W ! D ^DIR K DIR S IBANS=Y
 Q
