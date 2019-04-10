IBCNSUR ;ALB/CPM/CMS - MOVE SUBSCRIBERS TO DIFFERENT PLAN ;09-SEP-96
 ;;2.0;INTEGRATED BILLING;**103,276,506,516,549,602**;21-MAR-94;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
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
 .; IB*2.0*506 added IBKEY parameter (4th) to the NEW^IBCNSJ3 call (check user's security keys)
 .D NEW^IBCNSJ3(IBCNS,.IBPLAN,1,1)
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
 . N IBTITLE
 . S IBTITLE="Group Plan Lookup"
 . W "   ..."
 . S IBPLAN=0
 . D LKP^IBCNSU2(IBCNS,0,0,.IBPLAN,0,1,IBTITLE)
 . I 'IBPLAN W !!,*7,"*  No plan selected!",! S IBQUIT=1
 ;
 ; - allow a FileMan look-up
 ; MRD;IB*2.0*516 - Display new Group Name and Number fields.
 S DIC("A")="Select a GROUP PLAN: "
 S DIC="^IBA(355.3,",DIC(0)="AEQM",DIC("S")="I +^(0)=IBCNS,$P(^(0),U,2)"
 ;S DIC("W")="N IBX S IBX=$G(^(0)) W ""   Name: "",$E($S($P(IBX,U,3)]"""":$P(IBX,U,3),1:""<none>"")_$J("""",20),1,20),""   Number: "",$S($P(IBX,U,4)]"""":$P(IBX,U,4),1:""<none>"")"
 S DIC("W")="N IBX S IBX=$G(^(2)) W ""   Name: "",$E($S($P(IBX,U,1)]"""":$P(IBX,U,1),1:""<none>"")_$J("""",20),1,20),""   Number: "",$E($S($P(IBX,U,2)]"""":$P(IBX,U,2),1:""<none>""),1,14)"
 D ^DIC K DIC S IBPLAN=+Y
 I Y<0 W !!,*7,"*  No plan selected!",! S IBQUIT=1
 ;
SELQ K DIRUT,DUOUT,DTOUT,DIROUT
 Q
 ;
EXPGRP ; EP for [IBCN EXPIRE GROUP SUBSCRIBERS]
 ; IB*2.0*602/DM implement expire group plan 
 N X,Y,DIC,DIR,DTA,ERR,REF,IBLN,XMDUZ,XMTEXT,XMSUB,XMY
 N IBQUIT,IBCNS,IBPLAN,IBSUB,IBEXP,DFN,IBIPOL,IBIENWK
 N IBINSNM,IBGRPNM,IBGRPNO,IBEXPOK,IBEXPERR,IBSUPRES,IBCBI
 ;
 W !!,?5,"EXPIRE ALL SUBSCRIBERS WITHIN A GROUP PLAN"
 W !,?5,"You can use this option to specify an expiration date for all subscriber"
 W !,?5,"policies in a group plan without moving the subscribers to another group"
 W !,?5,"plan. If the group plan status is currently ""active"", you can also choose"
 W !,?5,"to ""inactivate"" the group plan."
 W !!,$TR($J("",75)," ","-")
 S IBQUIT=1
 ;
NXTGRP ; EP for next expire group process
 K ^TMP($J,"IBCNSUR") ; subscribers
 K ^TMP($J,"IBCNSURBLL") ; bulletin  
 I 'IBQUIT D
 . W !!,"=========================================="
 . W !,"EXPIRE ALL SUBSCRIBERS WITHIN A GROUP PLAN"
 . W !,"==========================================",!
 ; get insco and plan
 S IBQUIT=0
 D SEL^IBCNSUR(0) I IBQUIT Q
 ;
 ; Make sure plan has at least one subscriber
 I '$$SUBS^IBCNSJ(IBCNS,IBPLAN,0,,1) W !!,?5,*7,"* This group plan has no subscribers!",! G NXTGRP
 ;
 S IBINSNM=$$GET1^DIQ(36,IBCNS_",","NAME")
 S IBGRPNM=$$GET1^DIQ(355.3,IBPLAN_",","GROUP NAME")
 S IBGRPNO=$$GET1^DIQ(355.3,IBPLAN_",","GROUP NUMBER")
 ;
 W !!,"Collecting Subscribers ..."
 S IBSUB=$$SUBS^IBCNSJ(IBCNS,IBPLAN,0,"^TMP($J,""IBCNSUR"")")
 W !!,"This group plan has "_+IBSUB_" subscribers. All subscribers will be expired.",!
 S DIR(0)="Y"
 S DIR("A")="Do you want to expire all subscribers' policies for this plan"
 S DIR("?",1)="You will be asked for an expiration date to terminate the attached policies."
 S DIR("?",2)="You will have an opportunity to stop if desired."
 S DIR("?")="Enter 'Yes' to continue, or 'No' to stop the process now."
 D ^DIR K DIR
 I 'Y!$D(DIRUT) G NXTGRP
 ;
 W !
 ; get the expiration date
 S DIR(0)="D",DIR("A")="Enter expiration date (applies to all subscribers in this plan)"
 S DIR("?")="Each active policy will be expired with the expiration date entered."
 D ^DIR K DIR
 I 'Y!$D(DIRUT) G NXTGRP
 S IBEXP=Y
 ;
 W !!,"You selected to expire "_+IBSUB_" subscriber(s) with Expiration Date "_$$FMTE^XLFDT(IBEXP)_" for:"
 W !,?5,"Insurance Company "_IBINSNM
 W !,?5,"Plan Name "_IBGRPNM_"    Number "_IBGRPNO
 W !!,"Please Note that the policy will be EXPIRED in the patient profile!!",!
 ; 
 S DIR(0)="Y",DIR("A")="Okay to continue"
 S DIR("?",1)="If you wish to expire the policies for these subscribers, enter 'Yes'."
 S DIR("?")="Otherwise, enter 'No' to exit."
 D ^DIR K DIR
 I 'Y!$D(DIRUT) G NXTGRP
 ;
 ; expire the plan subscribers
 ; as we process the policies, we'll set the ^TMP nodes to 'O'k or 'E'rror
 W !!,"Expiring Policies...",!
 S IBSUPRES=1 ; tell COVERED^IBCNSM31 to be quiet
 S (IBEXPOK,IBEXPERR)=0
 S DFN=0 F  S DFN=$O(^TMP($J,"IBCNSUR",DFN)) Q:'DFN  D
 . S IBIPOL=0 F  S IBIPOL=$O(^TMP($J,"IBCNSUR",DFN,IBIPOL)) Q:IBIPOL=""  D
 .. S IBIENWK=IBIPOL_","_DFN_","
 .. Q:$$GET1^DIQ(2.312,IBIENWK,"GROUP PLAN","I")'=IBPLAN
 .. Q:+$$GET1^DIQ(2.312,IBIENWK,"INSURANCE EXPIRATION","I")
 .. I $$GET1^DIQ(2.312,IBIENWK,"EFFECTIVE DATE OF POLICY","I")>IBEXP S ^TMP($J,"IBCNSUR",DFN,IBIPOL)="E",IBEXPERR=IBEXPERR+1 Q
 .. S IBCBI=$$GET1^DIQ(2,DFN_",","COVERED BY HEALTH INSURANCE?","I")
 .. K DTA,ERR
 .. S DTA(2.312,IBIENWK,3)=IBEXP ; set the expiration date
 .. S DTA(2.312,IBIENWK,1.05)=$$NOW^XLFDT() ; last edited
 .. S DTA(2.312,IBIENWK,1.06)=DUZ ; by
 .. D FILE^DIE("","DTA","ERR")
 .. I $D(ERR) S ^TMP($J,"IBCNSUR",DFN,IBIPOL)="E",IBEXPERR=IBEXPERR+1 Q
 .. S ^TMP($J,"IBCNSUR",DFN,IBIPOL)="O",IBEXPOK=IBEXPOK+1
 .. D COVERED^IBCNSM31(DFN,IBCBI) ; set covered by insurance 
 ;
 W !,"Done. "_IBEXPOK_" Subscribers' policies were expired as of "_$$FMTE^XLFDT(IBEXP)_"."
 W !,"A Bulletin was sent to you and members of 'IB NEW INSURANCE' Mail Group."
 ;
 ; prepare the bulletin
 S IBLN=0,REF=$NA(^TMP($J,"IBCNSURBLL"))
 D ADD^IBCNSUR3(1,"EXPIRE ALL SUBSCRIBERS WITHIN A GROUP PLAN")
 D ADD^IBCNSUR3()
 D ADD^IBCNSUR3(1,"You selected to expire ",IBSUB," subscriber(s)")
 D ADD^IBCNSUR3()
 D ADD^IBCNSUR3(1,"FROM Insurance Company ",IBINSNM)
 D ADD^IBCNSUR3(1,"Plan Name ",IBGRPNM,"    Number ",IBGRPNO)
 D ADD^IBCNSUR3()
 D ADD^IBCNSUR3(1,"Policies will be expired as of ",$$FMTE^XLFDT(IBEXP),".")
 D ADD^IBCNSUR3()
 ;
 I IBEXPERR D
 . D ADD^IBCNSUR3(1,"* These ",IBEXPERR," entries could not be processed, they'll need to be adjusted manually")
 . W !!,@REF@(IBLN)
 . D ADD^IBCNSUR3(1,"-------------------------------------------------------------------------------")
 . W !,@REF@(IBLN)
 . D ADD^IBCNSUR3(1,"Patient Name/ID             Whose    Employer              Effective   Expires")
 . W !,@REF@(IBLN),!
 . S DFN=0 F  S DFN=$O(^TMP($J,"IBCNSUR",DFN)) Q:'DFN  D
 .. S IBIPOL=0 F  S IBIPOL=$O(^TMP($J,"IBCNSUR",DFN,IBIPOL)) Q:IBIPOL=""  D
 ... I ^TMP($J,"IBCNSUR",DFN,IBIPOL)'="E" Q
 ... D ADS^IBCNSUR3(DFN,IBIPOL)
 ... W !,@REF@(IBLN)
 . D ADD^IBCNSUR3(1,"============================")
 . D ADD^IBCNSUR3()
 . W !!,"Examine the entries that could not be processed."
 ;
 I IBEXPOK D
 . D ADD^IBCNSUR3(1,"These ",IBEXPOK," policies were processed successfully")
 . D ADD^IBCNSUR3(1,"-------------------------------------------------------------------------------")
 . D ADD^IBCNSUR3(1,"Patient Name/ID             Whose    Employer              Effective   Expires")
 . S DFN=0 F  S DFN=$O(^TMP($J,"IBCNSUR",DFN)) Q:'DFN  D
 .. S IBIPOL=0 F  S IBIPOL=$O(^TMP($J,"IBCNSUR",DFN,IBIPOL)) Q:IBIPOL=""  D
 ... I ^TMP($J,"IBCNSUR",DFN,IBIPOL)'="O" Q
 ... D ADS^IBCNSUR3(DFN,IBIPOL)
 . D ADD^IBCNSUR3(1,"============================")
 . D ADD^IBCNSUR3()
 ;
 I 'IBEXPOK,'IBEXPERR D
 . D ADD^IBCNSUR3(1,"============================")
 . D ADD^IBCNSUR3(1,"After processing, no changes were needed, no policies were expired.")
 . W !!,@REF@(IBLN)
 . D ADD^IBCNSUR3(1,"============================")
 . D ADD^IBCNSUR3()
 ;
 W !
 S DIR(0)="EA",DIR("A")="Press RETURN to continue." D ^DIR K DIR
 ;
 I +$$GET1^DIQ(355.3,IBPLAN_",","INACTIVE","I") D  G NXTGRP
 . D ADD^IBCNSUR3(1,"Please note the ",IBGRPNM," plan is already inactive.")
 . W !!,@REF@(IBLN),!
 . D SNDBULL
 ;
 W !
 S DIR(0)="Y",DIR("B")="NO"
 I IBEXPERR D
 . S DIR("A",1)="       ***********************************************"
 . S DIR("A",2)="       *                   WARNING                   *"
 . S DIR("A",3)="       *     There are still active subscribers      *"
 . S DIR("A",4)="       *   that will need to be adjusted manually    *"
 . S DIR("A",5)="       ***********************************************"
 . S DIR("A",6)=" "
 S DIR("A")="Do you wish to inactivate plan "_IBGRPNM
 D ^DIR K DIR
 I 'Y!$D(DIRUT) D  G NXTGRP
 . D ADD^IBCNSUR3(1,"The ",IBGRPNM," plan is still active.")
 . W !!,@REF@(IBLN),!
 . D SNDBULL
 ; inactivate the plan
 S IBIENWK=IBPLAN_","
 K DTA,ERR
 S DTA(355.3,IBIENWK,.11)=1 ; inactive
 S DTA(355.3,IBIENWK,1.05)=$$NOW^XLFDT() ; last edited
 S DTA(355.3,IBIENWK,1.06)=DUZ ; by
 D FILE^DIE("","DTA","ERR")
 I $D(ERR) D  G NXTGRP
 . D ADD^IBCNSUR3(1,"There was an issue inactivating the ",IBGRPNM," plan.")
 . W !!,@REF@(IBLN),!
 . D SNDBULL
 D ADD^IBCNSUR3(1,"The ",IBGRPNM," plan has been inactivated.")
 W !!,@REF@(IBLN),!
 D SNDBULL
 G NXTGRP
 ;
SNDBULL ; send out the bulletin 
 I '$G(IBLN) Q
 D ADD^IBCNSUR3()
 D ADD^IBCNSUR3(1,"THE PROCESS COMPLETED SUCCESSFULLY ON "_$$DAT1^IBOUTL($$NOW^XLFDT(),1))
 S XMSUB="SUBSCRIPTION LIST FOR INACTIVATED PLAN"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="^TMP("_$J_",""IBCNSURBLL"","
 S XMY(DUZ)=""
 S XMY("G.IB NEW INSURANCE")=""
 D ^XMD
 Q
