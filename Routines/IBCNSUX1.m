IBCNSUX1 ;ALB/CMS - SPLIT COMBINATION PLANS CONT. ; 04-NOV-98
 ;;2.0;INTEGRATED BILLING;**103,133**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
BEG ; -- Start to process policy separation from IBCNSUX
 ;    Input: IBINS=Selected Medicare Company
 ;          IBPLAN=Selected Combination Plan
 ;           IBWNR=MED WNR INS IEN^"MEDICARE (WNR)"
 ;                  ^PART A IEN^"PART A"
 ;                  ^PART B IEN^"PART A"
 ;
 N DFN,DO,DD,DA,DR,DIC,DIE,DIK,DIR,DIRUT,X,Y
 N IBCDFN,IBERR,IB0,IBST,IBSUB1,IBPLANAM
 K ^TMP($J,"IBCNSUX"),^TMP($J,"IBCNSUX1")
 S IBST=$$NOW^XLFDT,IBPLANAM=$P($G(^IBA(355.3,IBPLAN,0)),U,3)
 S IBSUB1=$$SUBS^IBCNSJ(IBINS,IBPLAN,0,"^TMP($J,""IBCNSUX1"")")
 S DFN=0 F  S DFN=$O(^TMP($J,"IBCNSUX1",DFN)) Q:'DFN  D
 .S IBCDFN=0 F  S IBCDFN=$O(^TMP($J,"IBCNSUX1",DFN,IBCDFN)) Q:'IBCDFN  D
 ..S IB0=$G(^DPT(DFN,.312,IBCDFN,0))
 ..I $P(IB0,U,18)'=+IBPLAN Q
 ..;
 ..;  -- check for duplicate
 ..D DUP
 ..;
 ..;  -- if the policy to be split has no COB, and both an A and B
 ..;  -- policy need to be created, set it to Primary
 ..I '$P(IB0,"^",20),'$D(^TMP($J,"IBCNSUX","ERR",DFN,2)),'$D(^(1)) D
 ...N DIE,DA,DR,X,Y
 ...S DIE="^DPT("_DFN_",.312,",DA=+IBCDFN,DA(1)=DFN,DR=".2////1" D ^DIE
 ..;
 ..;  -- create Medicare (WNR) policies if none exists
 ..I '$D(^TMP($J,"IBCNSUX","ERR",DFN,2)) D ADDB
 ..I '$D(^TMP($J,"IBCNSUX","ERR",DFN,1)) D SETA
 ;
 ; -- delete combination plan if no subscribers left.
 I '$$SUBS^IBCNSJ(IBINS,IBPLAN) D DEL^IBCNSJ(IBPLAN)
 ;
 D WRT
 ;
BEGQ K ^TMP($J,"IBCNSUX"),^TMP($J,"IBCNSUX1")
 Q
 ;
 ;
ADDB ; -- Create a New MEDICARE PART B patient policy
 N DA,DIC,DIE,DR,IBBDFN,IBC,IBX,X,Y,IBCDA,IBNDA,IBN
 K DD,D0
 ;
 S DIC("DR")=".01////"_+IBWNR_";1.09////1;1.05///NOW;1.06////"_DUZ_";.18////"_$P(IBWNR,U,5)
 ;
 ; -- If the policy to be split has no COB, and a valid Part A policy
 ; -- already exists, set the COB to Primary
 I '$P(IB0,"^",20),$D(^TMP($J,"IBCNSUX","ERR",DFN,1)) S DIC("DR")=DIC("DR")_";.2////1"
 ;
 S DA(1)=DFN,DIC="^DPT("_DFN_",.312,",DIC(0)="L",X=+IBWNR,DLAYGO=2.312
 D FILE^DICN S IBBDFN=+Y K DIC
 I IBBDFN<1 S ^TMP($J,"IBCNSUX","ERR",DFN,3)="Could not create a Part B policy." G ADDBQ
 ;
 ; -- Get settings of combination policy
 S IBCDA=IBCDFN_","_DFN_","
 D GETS^DIQ(2.312,IBCDA,"*","IN","IBC")
 I $D(IBC("IBERR")) S ^TMP($J,"IBCNSUX","ERR",DFN,3)="Could not set Part B policy data." G ADDBQ
 ;
 ; -- Set Medicare Part B policy data - copy combination policy data to new new Part B policy
 S IBNDA=+IBBDFN_","_DFN_","
 S IBX=0 F  S IBX=$O(IBC(2.312,IBCDA,IBX)) Q:IBX=""  D
 . ;
 . ; -- Don't set system edited or triggered fields
 . I ",.01,1.01,1.02,1.1,1.05,1.06,.18,"[(","_IBX_",") Q
 . ;
 . S IBN(2.312,IBNDA,IBX)=IBC(2.312,IBCDA,IBX,"I")
 I $O(IBN(0)) D FILE^DIE("","IBN")
ADDBQ Q
 ;
SETA ; -- Change policy to point to Part A
 N DIE,DA,DR,X,Y
 S DIE="^DPT("_DFN_",.312,",DA=+IBCDFN,DA(1)=DFN
 S DR=".01////"_+IBWNR_";.18////"_$P(IBWNR,U,3)
 ;
 ; - if this policy still has no COB, set it to primary
 I '$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",20) S DR=DR_";.2////1"
 D ^DIE
 Q
 ;
DUP ; -- Check for duplicate
 N IBX,IB0,X,Y
 S IBX=0 F  S IBX=$O(^DPT(DFN,.312,"B",+IBWNR,IBX)) Q:'IBX  D
 .S IB0=$G(^DPT(DFN,.312,IBX,0))
 .I $P(IB0,U,18)=$P(IBWNR,U,3) S ^TMP($J,"IBCNSUX","ERR",DFN,1)="Medicare (WNR) Part A policy already exists." Q
 .I $P(IB0,U,18)=$P(IBWNR,U,5) S ^TMP($J,"IBCNSUX","ERR",DFN,2)="Medicare (WNR) Part B policy already exists." Q
 Q
 ;
WRT ; -- write report
 N IBX,VA,VADM,VAERR,X,Y
 W @IOF,!,"Separate Medicare Combination policies Part A and Part B"
 W !!,"Process started ",$$FMTE^XLFDT(IBST)," ended ",$$FMTE^XLFDT($$NOW^XLFDT)
 W !,?10,"Run by: ",$P($G(^VA(200,+$G(DUZ),0)),U,1)
 W !!,?5,"Combination Company: ",$P($G(^DIC(36,IBINS,0)),U,1)
 W !?3,"Combination Plan Name: ",IBPLANAM W:'$D(^IBA(355.3,IBPLAN,0)) "  (This plan was deleted)"
 W ! F IBX=1:1:79 W "="
 ;
 I '$O(^TMP($J,"IBCNSUX","ERR",0)) W !!,"SUCCESSFULLY COMPLETED,  COMBINATION PLAN DELETED." G WRTQ
 ;
 W !,"Exception Report:"
 S DFN=0 F  S DFN=$O(^TMP($J,"IBCNSUX","ERR",DFN)) Q:'DFN  D
 .K VADM D DEM^VADPT
 .W !!,VADM(1),?32,"SSN: ",$P(VADM(2),U,2),?50,"DOB: ",$P(VADM(3),U,2)
 .S IBX=0 F  S IBX=$O(^TMP($J,"IBCNSUX","ERR",DFN,IBX)) Q:'IBX  D
 ..W !,?5,^TMP($J,"IBCNSUX","ERR",DFN,IBX)
WRTQ Q
 ;IBCNSUX1
