IBCNSUR1 ;ALB/CPM/CMS - MOVE SUBSCRIBERS TO DIFFERENT PLAN (CON'T) ;09-SEP-96
 ;;2.0;INTEGRATED BILLING;**103,225,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PROC ; - Top of processing from IBCNSUR
 ; Move subscribers to another company's insurance plan.
 N IBCNS,IBPLAN,IBC1,IBC1N,IBC1X,IBC2,IBC2N,IBC2X,IBCPOL
 N IBP1,IBP1N,IBP1X,IBP2,IBP2N,IBP2X,IBQ,IBQUIT,IBSUB,DFN,IBCDFN
 N IBXXX,IBX,IBDAT,IBCDFN1,IBNP,IBAB,IBI,IBIAB,IBCAB,IBW,IBST
 N DIC,DIE,DR,DA,D0,DIR,DIRUT,DIROUT,DTOUT,DUOUT,I,X,Y,DIK,DLAYGO
 N IBSPLIT,IBEFFDT,IBEXPDT,REF,IBLN
 ;
 K ^TMP($J,"IBCNSUR")  ; subscribers
 K ^TMP($J,"IBCNSUR1") ; e-mail bulletin
 S REF=$NA(^TMP($J,"IBCNSUR1")),IBLN=0
 ;
 S IBQUIT=0
 W !!!,"=====================",!,"MOVE SUBSCRIBERS FROM",!,"====================="
 W !!,"Select the Insurance Company and Plan to move subscribers FROM.",!
 ;
 ; - select company/plan for subscribers to be moved
 S IBQUIT=0
 D SEL^IBCNSUR(0)
 I IBQUIT S IBSTOP=1 G PROCQ
 ;
 ; - collect the plan subscribers
 S IBC1=IBCNS,IBP1=IBPLAN
 W !!,"Collecting Subscribers ..."
 S IBSUB=$$SUBS^IBCNSJ(IBC1,IBP1,0,"^TMP($J,""IBCNSUR"")")
 I 'IBSUB W !!,?5,*7,"*  This plan has no subscribers!" S IBQUIT=1 G PROCQ
 W !!,"This plan has ",+IBSUB," subscribers. All subscribers will be moved."
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
 S IBP1N=$P($G(^IBA(355.3,+IBP1,0)),U,3,4),IBP1X=$P(IBP1N,U,2)
 S IBP1X=$S(IBP1X]"":IBP1X,1:"<Not Specified>")
 S IBP1N=$S($P(IBP1N,U,1)="":"<Not Specified>",1:$P(IBP1N,U,1))
 S IBC2N=$P($G(^DIC(36,+IBC2,0)),U,1)
 S IBP2N=$P($G(^IBA(355.3,+IBP2,0)),U,3,4),IBP2X=$P(IBP2N,U,2)
 S IBP2X=$S(IBP2X]"":IBP2X,1:"<Not Specified>")
 S IBP2N=$S($P(IBP2N,U,1)="":"<Not Specified>",1:$P(IBP2N,U,1))
 ;
 ; - ask if they want to delete the old insurance
 S DIR(0)="Y",DIR("A")="Do you want to EXPIRE the old plan by entering the new plan Effective date"
 S DIR("B")="NO"
 S DIR("?")="If you wish to apply Effective Date, enter 'Yes' - otherwise, enter 'No'"
 W ! D ^DIR K DIR
 I $D(DIRUT) G PROCQ
 S IBSPLIT=''Y
 ; if yes then
 ; - ask the effective date of the new insurance
 I IBSPLIT D  I IBQ G PROCQ
 . S IBQ=0
 . S %DT="AEX",%DT("A")="Effective Date of the new Plan: "
 . W ! D ^%DT K %DT I Y'>0 S IBQ=1 Q
 . S IBEFFDT=$P(+Y,".")
 . S IBEXPDT=$$FMADD^XLFDT(IBEFFDT,-1)
 ;
 ; - ask are they sure
 W !!!,"You selected to move ",IBSUB," subscribers and "
 W $S(IBSPLIT:"EXPIRE",1:"REPLACE")," the old plan in the patient",!,"profile.",!
 W !?5,"FROM Insurance Company ",IBC1N
 W !?10,"Plan Name ",IBP1N,"     Number ",IBP1X
 W !?5,"TO Insurance Company ",IBC2N
 W !?10,"Plan Name ",IBP2N,"     Number ",IBP2X
 I IBSPLIT D
 . W !?5,"BY switching to the new Insurance/Plan"
 . W !?10,"with Effective Date ",$$DAT2^IBOUTL(IBEFFDT)
 W !
 W !,"Please Note that the old insurance group plan will be "
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
 .S DIR("?")=DIR("?")_" - otherwise, ente"
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
 W !!,"Moving subscribers "
 S DFN=0 F  S DFN=$O(^TMP($J,"IBCNSUR",DFN)) Q:'DFN  D
 .S IBCDFN=0 F  S IBCDFN=$O(^TMP($J,"IBCNSUR",DFN,IBCDFN)) Q:'IBCDFN  D
 ..Q:$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",18)'=IBP1
 ..;
 ..D ADS^IBCNSUR3(DFN,IBCDFN)
 ..I 'IBSPLIT D MODIFINS(IBC2,IBP2,DFN,IBCDFN) ;regular mode
 ..I IBSPLIT D SPLITINS(IBC2,IBP2,DFN,IBCDFN,IBEFFDT,IBEXPDT)
 ..; - merge previous benefits used
 ..S IBDAT="" F  S IBDAT=$O(^IBA(355.5,"APPY",DFN,IBP1,IBDAT)) Q:IBDAT=""  D
 ...S IBCDFN1=0 F  S IBCDFN1=$O(^IBA(355.5,"APPY",DFN,IBP1,IBDAT,IBCDFN1)) Q:'IBCDFN1  I IBCDFN1=IBCDFN S IBBU=$O(^(IBCDFN1,0)) D
 ....I '$D(^IBA(355.4,"APY",IBP2,IBDAT)) D DBU^IBCNSJ(IBBU) Q
 ....D MERG^IBCNSJ13(IBP2,IBBU)
 ..;
 ..W "."
 ;
 W !!,"Done.  All subscribers were moved as requested!",!
 D DONE^IBCNSUR3
 W !,"The Bulletin was sent to you and members of 'IB NEW INSURANCE' Mail Group.",!
 R !!,?10,"Press any key to continue.  ",IBX:DTIME
 ;
 ; - finish processing in IBCNSUR (keep RSIZE down)
 D PROC^IBCNSUR
 ;
 ;
PROCQ ;I 'IBSTOP S IBQUIT=0 D ASK^IBCOMC2 I IBQUIT=1 S IBSTOP=1
 K ^TMP($J,"IBCNSUR")
 K ^TMP($J,"IBCNSUR1")
 Q
 ;
 ; modify the ins plan
MODIFINS(IBC2,IBP2,DFN,IBCDFN) ;
 N IBXXX,DIE,DA,DR,IBX
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
 ;
 ;
 ;
 ; change the ins plan effective IBEFFDT
SPLITINS(IBC2,IBP2,DFN,IBCDFN,IBEFFDT,IBEXPDT) ;
 N IBX,IBZ,IBZ1,IBRT,IBI,IBIEN,IBCDFN2,IBERR,DIK,DA,DIE,DR,DGRUGA08
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
