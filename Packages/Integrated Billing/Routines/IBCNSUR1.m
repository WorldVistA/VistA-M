IBCNSUR1 ;ALB/CPM/CMS - MOVE SUBSCRIBERS TO DIFFERENT PLAN (CON'T) ;09-SEP-96
 ;;2.0;INTEGRATED BILLING;**103,225,276,516,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
PROC ; - Top of processing from IBCNSUR
 ; Move subscribers to another company's insurance plan.
 N D0,DA,DFN,DIC,DIE,DIK,DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT
 N I,IBAB,IBBU,IBC1,IBC1N,IBC1X,IBC2,IBC2N,IBC2X
 N IBCAB,IBCDFN,IBCDFN1,IBCNS,IBCPOL,IBDAT,IBDEAD,IBDONE
 N IBEFDT,IBEFDT1,IBEFDT2,IBEFFDT,IBEXPDT,IBGRP,IBI,IBIAB,IBLN
 N IBNP,IBP1,IBP1N,IBP1X,IBP2,IBP2N,IBP2X,IBPLAN,IBQ,IBQUIT
 N IBSPLIT,IBST,IBSUB,IBSUBACT,IBSUBID,IBVALUE,IBW,IBXXX,IBX
 N NUMSEL,REF,X,Y
 ;
 K ^TMP($J,"IBCNSUR")  ; subscribers
 K ^TMP($J,"IBCNSUR1") ; e-mail bulletin
 S REF=$NA(^TMP($J,"IBCNSUR1")),IBLN=0
 ;
 S (IBDONE,IBQUIT,NUMSEL)=0
 ;
 W !!!,"=====================",!,"MOVE SUBSCRIBERS FROM",!,"====================="
 W !!,"Select the Insurance Company and Plan to move subscribers FROM.",!
 ;
 ; - select company/plan for subscribers to be moved
 S IBQUIT=0
 D SEL^IBCNSUR(0)
 I IBQUIT S IBSTOP=1 Q
 ;
 ; IB*2.0*549 - Filtering questions begin here.
 ; - ask if they want to move the entire group plan
 S DIR(0)="Y",DIR("A")="Do you want to move the entire group plan"
 S DIR("B")="YES"
 S DIR("?")="If you wish to be Selective of which Subscribers are moved, enter 'No' - otherwise, enter 'Yes'"
 W ! D ^DIR K DIR
 I Y="^" S IBQUIT=1 G PROCQ
 S IBGRP=Y
 ;
 ; Make sure is at least one subscriber in the selected Insurance Company/Group Plan
 I '$$SUBS^IBCNSJ(IBCNS,IBPLAN,0,,1) D  G PROCQ
 . W !!,?5,*7,"*  This group plan has no subscribers!"
 . S IBQUIT=1
 ;
 I 'IBGRP D FILTER   ; IB*2.0*549 - if not moving entire plan...proceed with filter questions. 
 I IBQUIT G PROCQ
 ;
COLLECT  ; - collect the plan subscribers
 S IBC1=IBCNS,IBP1=IBPLAN
 W !!,"Collecting Subscribers ..."
 I IBGRP D  G:IBQUIT PROCQ
 . S IBSUB=$$SUBS^IBCNSJ(IBC1,IBP1,0,"^TMP($J,""IBCNSUR"")")
 . ; Proceed after all subscribers, etc. are accounted for.
 . I 'IBSUB W !!,?5,*7,"*  This group plan has no subscribers!" S IBQUIT=1 Q
 . W !!,"This group plan has "_+IBSUB_" subscribers. All subscribers will be moved."
 . S DIR(0)="Y",DIR("A")="Okay to continue"
 . S DIR("?")="If you wish to move these subscribers, enter 'Yes' - otherwise, enter 'No.'"
 . W ! D ^DIR K DIR
 . I 'Y W !!,?10,"<Okay, nothing moved>" S IBQUIT=1 Q
 ;
 I 'IBGRP D  G:IBQUIT PROCQ   ; Prompt for selected subscribers to move - IB*2*549 (vd)
 . S NUMSEL=$$EN^IBCNSUR4(IBC1,IBP1,IBDEAD,IBSUBID,IBVALUE,IBSUBACT,IBEFDT,IBEFDT1,IBEFDT2)   ; This is a new sub-routine to collect the subscribers using the various filters.
 . I IBQUIT S IBSTOP=1 Q
 . S IBSUB=+$P(NUMSEL,U,2)
 . I '+NUMSEL W !!,?5,*7,"*  No subscribers selected to be moved." S IBQUIT=1 Q
 . ;
 . W !!,"This group plan has "_+IBSUB_" subscribers. You have selected to move"
 . W !,+NUMSEL_" of these subscribers."
 . S DIR(0)="Y",DIR("A")="Okay to continue"
 . S DIR("?")="If you wish to move these subscribers, enter 'Yes' - otherwise, enter 'No.'"
 . W ! D ^DIR K DIR
 . I 'Y W !!,?10,"<Okay, nothing moved>" S IBQUIT=1 Q
 ;
 ; - select company/plan to move subscribers
 W !!!,"MOVE SUBSCRIBERS TO"
 W !!,"Select the Insurance Company and Plan to move subscribers TO.",!
 D SEL^IBCNSUR(1)
 I IBQUIT G PROCQ
 I $P($G(^DIC(36,IBCNS,0)),"^",5) W !!,*7,"You must move the subscribers to an active insurance company!" G PROCQ
 S IBC2=IBCNS,IBP2=IBPLAN
 ;
 ; - make sure not moving the subscribers to their current plan
 I (IBC1=IBC2)&(IBP1=IBP2) W !!,*7,"You must move the subscribers to a different plan!" G PROCQ
 ;
 ; - set name and plan number
 S IBC1N=$P($G(^DIC(36,+IBC1,0)),U,1)
 ;IB*2.0*516/TAZ - Retrieve data from HIPAA compliant fields
 ;S IBP1N=$P($G(^IBA(355.3,+IBP1,0)),U,3,4),IBP1X=$P(IBP1N,U,2)  ; 516 - baa
 S IBP1N=$$GET1^DIQ(355.3,+IBP1,2.01)_U_$$GET1^DIQ(355.3,+IBP1,2.02),IBP1X=$P(IBP1N,U,2)
 S IBP1X=$S(IBP1X]"":IBP1X,1:"<Not Specified>")
 S IBC2N=$P($G(^DIC(36,+IBC2,0)),U,1)
 ;IB*2.0*516/TAZ - Retrieve data from HIPAA compliant fields
 ;S IBP2N=$P($G(^IBA(355.3,+IBP2,0)),U,3,4),IBP2X=$P(IBP2N,U,2)  ; 516 - baa
 S IBP2N=$$GET1^DIQ(355.3,+IBP2,2.01)_U_$$GET1^DIQ(355.3,+IBP2,2.02),IBP2X=$P(IBP2N,U,2)
 S IBP2X=$S(IBP2X]"":IBP2X,1:"<Not Specified>")
 S IBP2N=$S($P(IBP2N,U,1)="":"<Not Specified>",1:$P(IBP2N,U,1))
 ;
 ; - ask if they want to delete the old insurance
 S DIR(0)="Y",DIR("A")="policy Effective date"
 S DIR("A",1)="Do you want to EXPIRE the old patient policy(s) by entering the new"
 S DIR("B")="NO"
 S DIR("?")="If you wish to apply Effective Date, enter 'Yes' - otherwise, enter 'No'"
 W ! D ^DIR K DIR
 I $D(DIRUT) G PROCQ
 S IBSPLIT=''Y
 ; if yes then
 ; - ask the effective date of the new insurance
 I IBSPLIT D  I IBQ G PROCQ
 . S IBQ=0
 . S %DT="AEX",%DT("A")="Effective Date of the new Plan Policy(s): "
 . W ! D ^%DT K %DT I Y'>0 S IBQ=1 Q
 . S IBEFFDT=$P(+Y,".")
 . S IBEXPDT=$$FMADD^XLFDT(IBEFFDT,-1)
 ;
 ; - ask are they sure
 W !!!,"You selected to move ",$S(+IBGRP:IBSUB,1:+NUMSEL)," subscriber(s) and "
 W $S(IBSPLIT:"EXPIRE",1:"REPLACE")," the old group plan &"
 W !,"policy in the patient profile.",!
 W !?5,"FROM Insurance Company ",IBC1N
 W !?10,"Plan Name ",$P(IBP1N,U,1),"     Number ",IBP1X
 W !?5,"TO Insurance Company ",IBC2N
 W !?10,"Plan Name ",IBP2N,"     Number ",IBP2X
 I IBSPLIT D
 . W !?5,"BY switching to the new Insurance/Plan"
 . W !?10,"with Effective Date ",$$DAT2^IBOUTL(IBEFFDT)
 W !
 W !,"Please Note that the old group plan & policy will be "
 W $S(IBSPLIT:"EXPIRED",1:"REPLACED")," in the patient",!,"profile!",!
 ;
 S DIR(0)="Y",DIR("A")="Okay to continue"
 S DIR("?")="If you wish to move these subscribers, enter 'Yes' - otherwise, enter 'No.'"
 W ! D ^DIR K DIR
 I 'Y W !!,?10,"<Okay, nothing moved>" G PROCQ
 ;
 ; - should annual benefits be moved?
 S (IBAB,IBQ)=0
 I $D(^IBA(355.4,"APY",IBP1)),'$D(^IBA(355.4,"APY",IBP2)) D  G:IBQ PROCQ
 .S DIR(0)="Y",DIR("A")="Okay to add "_IBC1N_"'s plan Annual Benefits to "_IBC2N_"'s plan"
 .S DIR("?")="If you wish to move these Annual Benefits, enter 'Yes' - otherwise, enter 'No.'"
 .W ! D ^DIR K DIR I $D(DIRUT)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) S IBQ=1
 .S:Y IBAB=1 K DIRUT,DUOUT,DTOUT,DIROUT
 ;
 ; - copy annual benefits over to the new plan
 I IBAB D
 .S IBI=0 F  S IBI=$O(^IBA(355.4,"C",IBP1,IBI)) Q:'IBI  D
 ..S IBIAB=$G(^IBA(355.4,IBI,0)) Q:'IBIAB
 ..S X=+IBIAB,DIC(0)="L",DLAYGO=355.4,DIC="^IBA(355.4,"
 ..K DD,DO D FILE^DICN Q:+Y<0  S IBCAB=+Y
 ..S $P(^IBA(355.4,IBCAB,0),"^",2)=IBP2
 ..S $P(^IBA(355.4,IBCAB,0),"^",5,6)=$P(IBIAB,"^",5,6)
 ..F I=1:1:5 I $G(^IBA(355.4,IBI,I))]"" S ^IBA(355.4,IBCAB,I)=^(I)
 ..S DA=IBCAB,DIK="^IBA(355.4," D IX1^DIK,EDUP^IBCNSA2
 ;
 ; - should plan comments be copied over to the new plan?
 S (IBAB,IBQ)=0
 I $P($G(^IBA(355.3,IBP1,11,0)),U,4),'$P($G(^IBA(355.3,IBP2,11,0)),U,4) D  G:IBQ PROCQ
 .S DIR(0)="Y"
 .S DIR("A")="Okay to add "_IBC1N_"'s Comments to "_IBC2N_"'s plan"
 .S DIR("?")="If you wish to move these Comments, enter 'Yes'"
 .S DIR("?")=DIR("?")_" - otherwise, enter 'NO'."
 .W ! D ^DIR K DIR I $D(DIRUT)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) S IBQ=1
 .S:Y IBAB=1 K DIRUT,DUOUT,DTOUT,DIROUT
 ;
 ; - copy plan comments over to the new plan
 I IBAB D
 .S DIC="^IBA(355.3,"_IBP2_",11,",DIC(0)="L",DIC("P")=355.311
 .S IBI=0 F  S IBI=$O(^IBA(355.3,IBP1,11,IBI)) Q:'IBI  D
 ..I $G(^IBA(355.3,IBP1,11,IBI,0))]"" S X=^(0) D FILE^DICN
 ;
 ; The MailMan bulletin header
 D BHEAD^IBCNSUR3
 ;
 ; - move the subscribers to the new plan
 W !!,"Moving subscribers"
 I IBGRP D  G PROCA  ; Move a group of subscribers
 . S DFN=0 F  S DFN=$O(^TMP($J,"IBCNSUR",DFN)) Q:'DFN  D
 . . S IBCDFN=0 F  S IBCDFN=$O(^TMP($J,"IBCNSUR",DFN,IBCDFN)) Q:'IBCDFN  D MOVESUB
 ;
 I 'IBGRP D    ; Move individual subscribers - IB*2*549 (VD)
 . S DFN=0 F  S DFN=$O(^TMP("IBCNSUR4A",$J,DFN)) Q:'DFN  D
 . . S IBCDFN=0 F  S IBCDFN=$O(^TMP("IBCNSUR4A",$J,DFN,IBCDFN)) Q:'IBCDFN  D MOVESUB
 ;
PROCA ; Proc continuation.
 ;
 W !!,"Done.  All subscribers were moved as requested!",!
 D DONE^IBCNSUR3
 W !,"The Bulletin was sent to you and members of 'IB NEW INSURANCE' Mail Group.",!
 R !!,?10,"Press any key to continue.  ",IBX:DTIME
 ;
 ; - finish processing in IBCNSUR (keep RSIZE down)
 D PROC^IBCNSUR
 ;
PROCQ ;
 K ^TMP($J,"IBCNSUR")
 K ^TMP($J,"IBCNSUR1")
 K ^TMP($J,"IBCNSURS")
 K ^TMP("IBCNSUR4A",$J)
 Q
 ;
MOVESUB ; Move the current subscriber.
 Q:$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",18)'=IBP1
 ;
 D ADS^IBCNSUR3(DFN,IBCDFN)
 I 'IBSPLIT D MODIFINS(IBC2,IBP2,DFN,IBCDFN) ;regular mode
 I IBSPLIT D SPLITINS(IBC2,IBP2,DFN,IBCDFN,IBEFFDT,IBEXPDT)
 ; - merge previous benefits used
 S IBDAT="" F  S IBDAT=$O(^IBA(355.5,"APPY",DFN,IBP1,IBDAT)) Q:IBDAT=""  D
 . S IBCDFN1=0 F  S IBCDFN1=$O(^IBA(355.5,"APPY",DFN,IBP1,IBDAT,IBCDFN1)) Q:'IBCDFN1  I IBCDFN1=IBCDFN S IBBU=$O(^(IBCDFN1,0)) D
 . . I '$D(^IBA(355.4,"APY",IBP2,IBDAT)) D DBU^IBCNSJ(IBBU) Q
 . . D MERG^IBCNSJ13(IBP2,IBBU)
 ;
 W "."
 Q
 ;
 ; modify the ins plan
MODIFINS(IBC2,IBP2,DFN,IBCDFN) ;
 N DA,DIE,DR,IBX,IBXXX
 ; - change the policy company
 S IBXXX='$G(^DPT(DFN,.312,IBCDFN,1))
 S DIE="^DPT(DFN,.312,",DA(1)=DFN,DA=IBCDFN,DR=".01///`"_IBC2 D ^DIE K DIE,DA,DR
 I IBXXX S $P(^DPT(DFN,.312,IBCDFN,1),"^",1,2)="^"
 ;
 ; - repoint Insurance Reviews to the new company
 S IBX=0 F  S IBX=$O(^IBT(356.2,"D",DFN,IBX)) Q:'IBX  I $P($G(^IBT(356.2,IBX,1)),"^",5)=IBCDFN S DIE="^IBT(356.2,",DA=IBX,DR=".08////"_IBC2 D ^DIE K DIE,DA,DR
 ;
 ; - change the policy plan
 D SWPL^IBCNSJ13(IBP2,DFN,IBCDFN)
 Q
 ; change the ins plan effective IBEFFDT
SPLITINS(IBC2,IBP2,DFN,IBCDFN,IBEFFDT,IBEXPDT) ;
 N DA,DGRUGA08,DIE,DIK,DR,IBCDFN2,IBERR,IBI,IBIEN,IBRT,IBX,IBZ,IBZ1
 S IBZ=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBZ1=$G(^DPT(DFN,.312,IBCDFN,1))
 ; - ignore if the old plan expired
 I $P(IBZ,U,4),$P(IBZ,U,4)<IBEFFDT Q
 ; - if the ins is effective later - no need to split
 I $P(IBZ,U,8),$P(IBZ,U,8)'<IBEFFDT D MODIFINS(IBC2,IBP2,DFN,IBCDFN) Q
 ;
 S DGRUGA08=1 ; Disable HL7 triggered by 2.312/3 and 2.312/8
 ; - create the new insurance record for the DFN (clone)
 S IBI="+1,"_DFN_","
 ; - add a record
 S IBRT(2.312,IBI,.01)=IBC2
 D UPDATE^DIE("","IBRT","IBIEN","IBERR")
 I $D(IBERR) Q  ; error
 I '$G(IBIEN(1)) Q  ; error
 S IBCDFN2=+IBIEN(1)
 ; - clone the insurance data
 M ^DPT(DFN,.312,IBCDFN2)=^DPT(DFN,.312,IBCDFN)
 S $P(^DPT(DFN,.312,IBCDFN2,0),U,1)=IBC2
 S $P(^DPT(DFN,.312,IBCDFN2,0),U,8)=IBEFFDT
 ; - now reindex
 S DA(1)=DFN,DA=IBCDFN2,DIK="^DPT("_DFN_",.312,"
 D IX1^DIK
 ; - change the policy plan
 D SWPL^IBCNSJ13(IBP2,DFN,IBCDFN2)
 ; - set the expiration date
 S $P(^DPT(DFN,.312,IBCDFN,0),U,4)=IBEXPDT
 S DA(1)=DFN,DA=IBCDFN,DIK="^DPT("_DFN_",.312,"
 D IX1^DIK
 Q
 ;
FILTER ; IB*2.0*549 - Prompts for Filter questions.
 ; if no, then proceed with the filtering questions.
 ; - ask if they want to continue because they are about to select individual subscribers
 S DIR(0)="Y",DIR("A")="You have selected to move individual subscribers.  Okay to continue"
 S DIR("B")="YES"
 S DIR("?")="If you wish to continue being Selective of which Subscribers are moved, enter 'Yes' - otherwise, enter 'No' to quit."
 W ! D ^DIR K DIR
 ; if yes then proceed with collecting the subscribers for the entire plan.
 I '+Y!(Y="^") S IBQUIT=1 Q  ; QUIT
 ;
 ; - ask if they want to filter out Deceased Patients
 S DIR(0)="Y",DIR("A")="Do you want to filter out deceased patients"
 S DIR("B")="YES"
 S DIR("?")="If you wish to ignore Deceased Patients in the selection process, enter 'Yes' - otherwise, enter 'No'"
 W ! D ^DIR K DIR
 I Y="^" S IBQUIT=1 Q
 S IBDEAD=+Y   ; 1=ignore deceased patients,  0=include deceased patients.
 ;
 ; - ask if they want to filter based on Subscriber ID
 S DIR(0)="YO",DIR("A")="Do you want to filter Subscriber ID"
 S DIR("B")="YES"
 S DIR("?")="If you wish to filter subscribers based upon the Subscriber ID, enter 'Yes' - otherwise, enter 'No'"
 W ! D ^DIR K DIR
 I Y="^" S IBQUIT=1 Q
 S IBSUBID=+Y   ; 1=filter based upon the Subscriber ID,  0=ignore Subscriber IDs.
 S IBQUIT=0
 S IBVALUE=""
 I +IBSUBID D  I +IBQUIT Q
 . ;
 . ; - ask user to enter the value that subscriber IDs need to 'contain'
 . S DIR(0)="FAO",DIR("A")="Filter Subscriber IDs that contain:  "
 . S DIR("?")="Enter value that Subscriber IDs should contain.  NULL value means blank values."
 . D ^DIR K DIR
 . I Y="^" S IBQUIT=1 Q
 . S IBVALUE=$$UP^XLFSTR(Y)
 ;
 ; - ask if they want to filter based on ACTIVE or INACTIVE
 S DIR(0)="Y",DIR("A")="Do you want to filter for active or inactive policies"
 S DIR("B")="YES"
 S DIR("?")="If you wish to specify filter subscribers based upon ACTIVE or INACTIVE, enter 'Yes' - otherwise, enter 'No'"
 W ! D ^DIR K DIR
 I Y="^" S IBQUIT=1 Q
 S IBSUBACT=+Y   ; 1=filter based upon the ACTIVE or INACTIVE,  0=ignore ACTIVE status.
 ;
 I IBSUBACT D  I +IBQUIT Q
 . ; Filter based on Active or Inactive policies.
 . S DIR(0)="SA^1:1  Active Policies;2:2  Inactive Policies;3:3  Both"
 . S DIR("A")=" SELECT 1 or 2 or 3: "
 . S DIR("A",1)="1. Active Policies"
 . S DIR("A",2)="2. Inactive Policies"
 . S DIR("A",3)="3. Both"
 . S DIR("B")=1
 . S DIR("?",1)=" 1 - Only allow selection of ACTIVE Policies"
 . S DIR("?",2)=" 2 - Only allow selection of INACTIVE Policies"
 . S DIR("?")=" 3 - Allow selection of ACTIVE and INACTIVE Policies"
 . D ^DIR K DIR I Y<0!$D(DIRUT) S IBQUIT=1 Q
 . S IBSUBACT=Y K Y
 ;
 ; - ask if they want to filter based on Effective Dates
 S DIR(0)="Y",DIR("A")="Do you want to filter Effective Dates"
 S DIR("B")="NO"
 S DIR("?")="If you wish to specify filter subscribers based upon Effective Dates, enter 'Yes' - otherwise, enter 'No'"
 W ! D ^DIR K DIR
 I Y="^" S IBQUIT=1 Q
 S IBEFDT=+Y   ; 1=filter based upon Effective Dates,  0=ignore Effective Dates.
 I 'IBEFDT S (IBEFDT1,IBEFDT2)="" Q
 ;
FILTERA ; Enter Effective Date range to filter subscribers.
 N TODAY
 S TODAY=$$DAT1^IBOUTL(DT) K DIR
 W ! S DIR(0)="DAO",DIR("A")="Start with DATE: ",DIR("?")="Enter the earliest Effective Date to filter Subscribers."
 D ^DIR K DIR
 I '$L(Y) D  Q
 . S IBEFDT=0,(IBEFDT1,IBEFDT2)="" Q
 I Y="^" S IBQUIT=1 Q
 S IBEFDT1=Y
 ;
FILTERB ; Enter End Date
 W ! S DIR(0)="DA",DIR("A")="Go to DATE: ",DIR("B")=TODAY,DIR("?")="Enter the latest Effective Date to filter Subscribers."
 D ^DIR K DIR
 I 'Y S IBQUIT=1 Q
 S IBEFDT2=Y
 I IBEFDT2<IBEFDT1 W !,"End date cannot be less than Start date. Please re-enter date range." G FILTERB
 Q
 ;
