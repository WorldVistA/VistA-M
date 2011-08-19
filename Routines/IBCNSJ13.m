IBCNSJ13 ;ALB/CPM - INACTIVATE AN INSURANCE PLAN (CON'T) ; 18-JAN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,62,52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
REP(IBCNS,IBNEWP,IBOLDP,IBMER) ; Repoint patient policies from old to new plan
 ;  Input:   IBCNS  --  Pointer to the company in file #36 which
 ;                      offers the plans
 ;          IBNEWP  --  Pointer to the new plan in file #355.3
 ;          IBOLDP  --  Pointer to the old plan in file #355.3
 ;           IBMER  --  [optional]: set to 1 if benefits used should
 ;                                  be merged instead of deleted
 ;
 I '$G(IBCNS)!'$G(IBNEWP)!'$G(IBOLDP) G REPQ
 N DA,DFN,DIE,DR,IBARR,IBCDFN,IBCBUM,IBCBUD,IBSUB1
 S (IBCBUM,IBCBUD)=0 W !,"Repointing all policies to the new plan...",!
 K ^TMP($J,"IBSUBS")
 S IBSUB1=$$SUBS^IBCNSJ(IBCNS,IBOLDP,0,"^TMP($J,""IBSUBS"")")
 S DFN=0 F  S DFN=$O(^TMP($J,"IBSUBS",DFN)) Q:'DFN  D
 .S IBCDFN=0 F  S IBCDFN=$O(^TMP($J,"IBSUBS",DFN,IBCDFN)) Q:'IBCDFN  D
 ..Q:$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",18)'=IBOLDP
 ..D SWPL(IBNEWP,DFN,IBCDFN) W "."
 ..;
 ..; - merge or delete previous benefits used
 ..S IBDAT="" F  S IBDAT=$O(^IBA(355.5,"APPY",DFN,IBOLDP,IBDAT)) Q:IBDAT=""  D
 ...S IBCDFN1=0 F  S IBCDFN1=$O(^IBA(355.5,"APPY",DFN,IBOLDP,IBDAT,IBCDFN1)) Q:'IBCDFN1  I IBCDFN1=IBCDFN S IBBU=$O(^(IBCDFN1,0)) D
 ....I '$D(^IBA(355.4,"APY",IBNEWP,IBDAT))!'$G(IBMER) D DBU^IBCNSJ(IBBU) S IBCBUD=IBCBUD+1 Q
 ....D MERG(IBNEWP,IBBU) S IBCBUM=IBCBUM+1
 ;
 W !,"All policies have been re-pointed to the new plan."
 I 'IBCBUD,'IBCBUM W !,"There were no Benefits Used merged or deleted." G REPQ
 W !,$S(IBCBUM:IBCBUM,1:"No")," Benefits Used record",$S(IBCBUM=1:" was",1:"s were")," merged."
 W !,$S(IBCBUD:IBCBUD,1:"No")," Benefits Used record",$S(IBCBUD=1:" was",1:"s were")," deleted."
REPQ K ^TMP($J,"IBSUBS")
 Q
 ;
SWPL(IBCPOL,DFN,IBCDFN) ; Change plan in policy.
 ;  Input:  IBCPOL  --  Pointer to the new plan in file #355.3
 ;             DFN  --  Pointer to the patient in file #2
 ;          IBCDFN  --  Pointer to the policy in file #2.312
 ;
 I '$G(IBCPOL)!'$G(DFN)!'$G(IBCDFN) G SWPLQ
 S DR=".18////"_IBCPOL_";1.05///NOW;1.06////"_DUZ
 S DA=IBCDFN,DA(1)=DFN,DIE="^DPT("_DFN_",.312," D ^DIE K DIE,DA,DR
 D COV^IBCNSJ(DFN) ; adjust 'Covered by Insurance' field
 D POL^IBCNSU41(DFN) ; stuff sponsor data into Tricare policies
SWPLQ Q
 ;
MERG(IBCPOL,IBBU,IBD) ; Merge previous benefits used into a new plan.
 ;  Input:  IBCPOL  --  Pointer to the new plan in file #355.3
 ;            IBBU  --  Pointer to the benefit to merged in file #355.5
 ;             IBD  --  [optional] : new date for the benefit used
 ;
 N DIC,DLAYGO,IBCBU,X,Y
 I '$G(IBCPOL)!'$G(IBBU) G MERGQ
 S X=IBCPOL,DIC(0)="L",DLAYGO=355.5,DIC="^IBA(355.5,"
 K DD,DO D FILE^DICN G:+Y<0 MERGQ S IBCBU=+Y
 S $P(^IBA(355.5,IBCBU,0),"^",2,30)=$P($G(^IBA(355.5,IBBU,0)),"^",2,30)
 I $G(IBD) S $P(^IBA(355.5,IBCBU,0),"^",3)=IBD
 I $D(^IBA(355.5,IBBU,1)) S ^IBA(355.5,IBCBU,1)=^(1)
 S DA=IBCBU,DIK="^IBA(355.5," D IX1^DIK,EDUP^IBCNSD1
 D DBU^IBCNSJ(IBBU)
MERGQ Q
 ;
BU(IBQ) ; Be sure user really wants to repoint policies with benefits used.
 ;  Required variable input:
 ;      IBCPOL  --  Pointer to the new plan in file #355.3
 ;
 ;  Formal parameter output:
 ;         IBQ  --  Set to 1 if user wishes to quit
 ;
 ;  Optional variable output:
 ;     IBMERGE  --  Set to 1 if user wishes to merge applicable benefits
 ;       IBREP  --  Set to 0 if user does not want to repoint policies
 ;     
 S IBQ=0 I '$D(^IBA(355.4,"APY",IBCPOL)) D  G BUQ
 .W !!,*7,"  ** Please Note **",!!?5,"The selected plan has no Annual Benefits with which to associate"
 .W !?5,"the Benefits Used from the current plan!"
 .W !!?5,"If you re-point all policies to this plan, the Benefits Used for"
 .W !?5,"the current plan will be deleted!!"
 ;
 S DIR("A",1)="The selected plan has Annual Benefits on file.  Should the repointing"
 S DIR("A")="of the policies attempt to merge all transferable benefits"
 S DIR(0)="Y",DIR("?")="^D HLMT^IBCNSJ11" D ^DIR K DIR
 S IBMERGE=Y
 I $D(DIRUT) K DIRUT,DTOUT,DUOUT,DIROUT D
 .S DIR(0)="Y",DIR("A")="  Do you still wish to re-point these policies to a new plan",DIR("?")="^D HLRP^IBCNSJ11"
 .W ! D ^DIR K DIR I $D(DIRUT) S IBQ=1 D DELP^IBCNSJ11 Q
 .K DIRUT,DTOUT,DUOUT,DIROUT I 'Y S IBREP=0 D MAIL^IBCNSJ11,DELP^IBCNSJ11
BUQ Q
