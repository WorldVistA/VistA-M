IBCNSM32 ;ALB/AAS - INSURANCE MANAGEMENT - POLICY EDIT ;23-JAN-95
 ;;2.0;INTEGRATED BILLING;**28,40,52,85,103,133,361,371,413**;21-MAR-94;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PATPOL(IBCDFN) ; -- edit patient specific policy info
 I '$G(IBCDFN) G PATPOLQ
 D SAVEPT^IBCNSP3(DFN,IBCDFN)
 D POL^IBCNSU41(DFN)
 ;
 ; -- give warning if expired or inactive co.
 I $P(^DPT(DFN,.312,IBCDFN,0),"^",4),$P(^(0),"^",4)'>DT W !,"WARNING:  This appears to be an expired policy!",!
 I $P(^DIC(36,+$P(^DPT(DFN,.312,IBCDFN,0),"^"),0),"^",5) W !,*7,"WARNING:  This insurance company is INACTIVE!",!
 ;
 N IBAD,IBDIF,DA,DR,DIC,DIE,DGSENFLG S DGSENFLG=1
 L +^DPT(DFN,.312,+IBCDFN):5 I '$T D LOCKED^IBTRCD1 G PATPOLQ
 ;
 D EDIT^IBCNSP1(DFN,IBCDFN,.IBQUIT)    ; IB*371 edit 2.312 subfile data
 ;
 ; If the 2.312 subfile entry was deleted then unlock and get out
 I '$D(^DPT(DFN,.312,IBCDFN,0)) L -^DPT(DFN,.312,+IBCDFN) G PATPOLQ
 ;
 ; -- if the company was changed, change the policy plan
 I $G(IBREG),$G(IBCNS),+$G(^DPT(DFN,.312,IBCDFN,0))'=IBCNS D CHPL
 ;
 K IBFUTUR
 D COMPPT^IBCNSP3(DFN,IBCDFN)
 I IBDIF D UPDATPT^IBCNSP3(DFN,IBCDFN)
 L -^DPT(DFN,.312,+IBCDFN)
 ;
 D FUTURE^IBCNSM31 K Y,IBFUTUR
PATPOLQ Q
 ;
CHPL ; Change policy plan if the policy company differs from plan company.
 ;  Required variable input:
 ;        DFN  --  pointer to the patient in file #2
 ;     IBCDFN  --  pointer to the policy in file #2.312
 ;      IBCNS  --  pointer to the plan company in file #36
 ;
 N IBBU,IBCNS1,IBCPOL1,IBNEWP1,IBPLAN,IBIP,IBT,X
 S X=$G(^DPT(DFN,.312,IBCDFN,0)),IBCNS1=+X
 S IBPLAN=$P(X,"^",18),IBIP='$P($G(^IBA(355.3,IBPLAN,0)),"^",2)
 W !!,"Since you have changed the Insurance Company to ",$E($P($G(^DIC(36,IBCNS1,0)),"^"),1,25),","
 W !,"you must now change the Insurance Plan to which this veteran"
 W !,"is subscribing to one which is offered by this company!",!
 ;
 ; - warn about benefits used
 D BU^IBCNSJ21 I $O(IBBU(0)) D
 .W !,"The current policy plan has Benefits Used associated with it!"
 .W !,"If you add or select another plan to associate with this policy,"
 .W !,"these Benefits Used will be deleted!",!
 ;
 ; - warn about Individual Plans
 I IBIP D
 .W !,"  ***  Please note:  Since the veteran's current plan is an Individual Plan,"
 .W !?21,"this plan will be deleted if you add or select a new"
 .W !?21,"plan to associate with this policy.",!
 ;
 ; - select or add a new plan
 S IBCPOL1=$$LK^IBCNSM31(IBCNS1)
 I 'IBCPOL1 D NEW^IBCNSJ3(IBCNS1,.IBCPOL1) S:IBCPOL1 IBNEWP1=1
 I 'IBCPOL1 D  G CHPLQ
 .W !!,"A new plan was not added or selected!"
 .W !,"Changing the policy company back to ",$E($P($G(^DIC(36,IBCNS,0)),"^"),1,25),"..."
 .S DIE="^DPT(DFN,.312,",DA(1)=DFN,DA=IBCDFN,DR=".01////"_IBCNS_";1.05///NOW;1.06////"_DUZ D ^DIE K DA,DIE,DR
 ;
 W !!,"Changing the policy plan..."
 S DIE="^DPT(DFN,.312,",DA(1)=DFN,DA=IBCDFN,DR=".18////"_IBCPOL1_";1.05///NOW;1.06////"_DUZ D ^DIE K DA,DIE,DR
 I IBIP!$G(IBNEWP) W !!,"Deleting the ",$S(IBIP:"current Individual",1:"previously-added")," plan for ",$E($P($G(^DIC(36,IBCNS,0)),"^"),1,25),"..." D DEL^IBCNSJ(IBPLAN)
 ;
 ; - delete any dangling benefits used
 I $O(IBBU(0)) D
 .N IBDAT
 .W !!,"Deleting current Benefits Used... "
 .S IBDAT="" F  S IBDAT=$O(IBBU(IBDAT)) Q:IBDAT=""  D DBU^IBCNSJ(IBBU(IBDAT))
 ;
 ; - repoint all Insurance Reviews to new company
 I $$IR^IBCNSJ21(DFN,IBCDFN) D
 .W !!,"Repointing all Insurance Reviews to ",$E($P($G(^DIC(36,IBCNS1,0)),"^"),1,25),"... "
 .S IBT=0 F  S IBT=$O(^IBT(356.2,"D",DFN,IBT)) Q:'IBT  I $P($G(^IBT(356.2,IBT,1)),"^",5)=IBCDFN,$P($G(^(0)),"^",8)'=IBCNS1 S DA=IBT,DR=".08////"_IBCNS1,DIE="^IBT(356.2," D ^DIE K DA,DR,DIE W "."
 ;
 S IBCNS=IBCNS1,IBNEWP=$G(IBNEWP1)
CHPLQ Q
 ;
PLAN(DFN,IBCDFN,IBCNS) ; Fix policies when identified.
 ;
 ;  This function is invoked from Inactivate Plan or Change Policy Plan,
 ;  when it is recognized that the policy and plan companies are out
 ;  of synch.  If the user doesn't select a new plan to associate with
 ;  the policy, the policy company will be changed to the plan company.
 ;
 ;  The input parameters are defined above.
 ;
 N IBNEWP
 I '$G(DFN)!'$G(IBCDFN)!'$G(IBCNS) G PLANQ
 W !!,*7,"The policy company and plan company are not the same!!"
 W !,"This inconsistency probably occurred in the past when changing"
 W !,"the policy company through Screen 5 of Registration."
 W !!,"You must resolve this inconsistency.  If you do not choose a new plan"
 W !,"offered by the policy company, the policy company will be changed to"
 W !,"the plan company (",$P($G(^DIC(36,IBCNS,0)),"^"),") ...."
 D CHPL
PLANQ Q
HLP ; -- help text for subscriber id
 W !,?5,"Enter Medicare Claim Number (Subscriber ID) exactly as it"
 W !,?5,"appears on the Medicare Insurance Card including All Characters."
 W !,?5,"Valid HICN formats are:  1-3 alpha characters followed by 6 or 9 digits, "
 W !,?5,"or 9 digits followed by 1 alpha character optionally followed by another "
 W !,?5,"alpha character or 1 digit."
 Q
