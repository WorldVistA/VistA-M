IBCNSP2 ;ALB/AAS - PATIENT INSURANCE INTERFACE FOR REGISTRATION ;21-JUNE-93
 ;;2.0;INTEGRATED BILLING;**6,28,75,82,155,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
% ;
REG ; --Edit Patient insurance from registration, fee and mccr, allow new entries
 ;   only edit policy if new policy
 ;   call event driver if adding a new policy
 ;
 ; -- Input  DFN  = patient
 ;
 I $G(DGPRFLG) D PREG^IBCNBME(DFN) Q
 D REG^IBCNBME(DFN)
 Q
 ;
 N DIC,DIE,DE,DQ,DIR,DA,DR,DIC,DIV,X,Y,I,J,L,D,DIH,DIY,IBSEL,IBDD,IBD,IBNEW,IBNEWP,IBDT,IBQUIT,IBCNS,IBCDFN,IBCNSEH,IBCNP,IBCPOL,IBOK,VALMQUIT,IBCNT,IBEVT1,IBEVTA,VAERR,IBCOVP
 S IBCNP=1
 I '$D(DFN) D  G:$D(VALMQUIT) REGQ
 .S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC
 .S DFN=+Y
 I $G(DFN)<1 S IBQUIT=1,VALMQUIT="" G REGQ
 ;
 I '$$ASKCOVD(DFN,.IBCOV,.IBCOVP) S IBQUIT=1 G REGQ
 ;
R1 S (IBNEW,IBNEWP,IBQUIT)=0
 S DIC="^DPT("_DFN_",.312,",DIC(0)="AEQLM",DIC("A")="Select INSURANCE COMPANY: "
 S DIC("W")="N IBD S IBD=$G(^DPT(DFN,.312,+Y,0)) W ""  Group: ""_$$GRP^IBCNS($P(IBD,U,18))_""  Whose: ""_$$EXPAND^IBTRE(2.312,6,$P(IBD,U,6))"
 I IBCNP=1 S X=$P($G(^DIC(36,+$G(^DPT(DFN,.312,+$P($G(^DPT(DFN,.312,0)),"^",3),0)),0)),"^") I X'="" S DIC("B")=X
 S DA(1)=DFN
 I $G(^DPT(DFN,.312,0))="" S ^DPT(DFN,.312,0)="^2.312PAI^^"
 D ^DIC K DIC I +Y<1 S IBQUIT=1,VALMQUIT="" G REGQ
 S IBCDFN=+Y,IBCNS=$P(Y,"^",2)
 I $P(Y,"^",3) S IBNEW=1 I $$DUPCO^IBCNSOK1(DFN,IBCNS,IBCDFN,1)
 D BEFORE^IBCNSEVT
 S IBCNSEH=$P($G(^IBE(350.9,1,4)),"^",1)
 S IBCNP=IBCNP+1
 I 'IBNEW,$P($G(^DPT(DFN,.312,+IBCDFN,0)),"^",18)="" D  G REGQ
 .I '$P($G(^IBE(350.9,1,3)),"^",18) W !,"Insurance conversion not complete, NO EDITING ALLOWED",!! S IBQUIT=1 H 3 Q
 .I $P($G(^IBE(350.9,1,3)),"^",18) W !,"INVALID ENTRY, DELETE AND RE-ENTER, NO EDITING ALLOWED",!! S IBQUIT=1 H 3 Q
 ;
 I $G(IBFEE),'$G(IBNEW) G REGQ ; fee users can add but not edit existing  info
 I $G(IBNEW) D  G:$G(IBQUIT) REGQ
 .D SEL^IBCNSEH
 .S IBCPOL=$$LK^IBCNSM31(IBCNS)
 .I IBCPOL<1 D NEW^IBCNSJ3(IBCNS,.IBCPOL) S:IBCPOL<1 IBQUIT=1 Q:IBQUIT  S IBNEWP=1
 .;  dgprflg is a 1 if called from pre-registration, set default 4
 .;  for pre-reg, otherwise set the default to 1 for interview
 .S DR=".18////"_IBCPOL_";1.09////"_$S($G(DGPRFLG):4,1:1)_";1.05///NOW;1.06////"_DUZ
 .S DA=IBCDFN,DA(1)=DFN,DIE="^DPT("_DFN_",.312," D ^DIE
 .K DIE,DA,DR,DIC
 ;
 ; -- edit patient ins. data
 S IBREG=1 G:$G(IBQUIT) REGQ
 D PAT^IBCNSEH,PATPOL^IBCNSM32(IBCDFN),UPDCLM(+$G(IBIFN),DFN,IBCDFN)
 ;
 ; -- edit policy specific data if new or have key
 I $G(IBNEWP)!($D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ))) D:'$G(IBQUIT) POL^IBCNSEH,EDPOL^IBCNSM3(IBCDFN)
 K IBREG S IBQUIT=0
 ;
REGQ ; -- exit logic and checks
 ; -- if no policy pointer delete
 I $G(IBNEW),$G(IBCDFN),$P($G(^DPT(DFN,.312,+IBCDFN,0)),"^",18)="" D
 .D DP1^IBCNSM1 W !,"<DELETED>  GROUP INSURANCE PLAN REQUIRED BUT NOT ENTERED" K IBNEW
 ;
 ; -- call event driver
 I $G(IBCDFN),$P($G(^DPT(DFN,.312,+$G(IBCDFN),0)),"^",18) D
 .K IBNEW
 .D AFTER^IBCNSEVT,^IBCNSEVT
 ;
 K IBCNS,IBCDFN,IBNEW,IBNEWP
 I '$G(IBQUIT) W ! G R1
 D COVERED^IBCNSM31(DFN,$G(IBCOVP))
 K IBQUIT
 Q
 ;
FEE ; -- fee entry point to add patient insurance.
 D FEE^IBCNBME(DFN)
 Q
 ;
MCCR ; -- called from screen 3 of the edit bill option in mccr
 N DLAYGO,DIC,DIE,DE,DQ,DIR,DA,DR,DIC,DIV,X,Y,I,J,L,D,DIH,DIY,IBSEL,IBDD,IBD,IBNEW,IBNEWP,IBDT,IBQUIT,IBCNS,IBCDFN,IBCNSEH,IBCNP,IBCPOL,IBOK,VALMQUIT,IBMCR
 ;
 S IBCNP=1,IBMCR=$$WNRBILL^IBEFUNC(IBIFN)
 S DIE="^DGCR(399,",DA=IBIFN,DR="[IB SCREEN3]" D ^DIE K DIC,DIE,DA,DR
 ;
 I $G(IBADI)=1 D R1 S IBCNRTN=1 K IBADI G MCCR
 I 'IBMCR,$$WNRBILL^IBEFUNC(IBIFN) S DGRVRCAL=1
 K IBCNRTN
 Q
 ;
UPDCLM(IBIFN,DFN,IBCDFN) ; Update the claim's insurance nodes when edits are made
 ;   to the patient insurance file.
 ;  This procedure is called when a claim is being edited from IB billing
 ;  screen#3 and also when the patient insurance is being edited directly.
 ;
 I '$G(IBIFN)!'$G(DFN)!'$G(IBCDFN) Q         ; missing something
 I $P($G(^DGCR(399,IBIFN,0)),U,2)'=DFN Q     ; mismatch of claim and DFN
 I $P($G(^DGCR(399,IBIFN,0)),U,13)'=1 Q      ; claim not editable
 I '$D(^DPT(DFN,.312,IBCDFN,0)) Q            ; missing pat ins data
 NEW X,Z,NODE
 S X=IBCDFN
 F Z=1:1:3 I $P($G(^DGCR(399,IBIFN,"M")),U,11+Z)=IBCDFN D  Q
 . S NODE="I"_Z
 . D IX^IBCNS2(IBIFN,NODE)
 . Q
 Q
 ;
DISP ; -- Display Patient insurance policy information for registrations
 Q:'$D(DFN)
 D DISP^IBCNS
DISPQ Q
 ;
ASKCOVD(DFN,IBCOV,IBCOVP) ; ask user if patient covered by insurance (2,.3192), returns true if answered yes
 ;
 N IBX,IBINSD,DIC,DIE,DA,DR,X,Y,DTOUT
 ;
 S IBCOV=$P($G(^DPT(DFN,.31)),"^",11),IBINSD=$$INSURED^IBCNS1(DFN),IBX=1 W !
 ;
 ; -- if covered by ins but none currently active so indicate
 I IBCOV="Y",'IBINSD W !!,"Covered By Health Insurance indicates 'YES' but none currently Active.",!,"Please Review!",!!
 ;
 ; -- ask if covered by insurance
 S DIE="^DPT(",DR=".3192",DA=DFN D ^DIE K DIC,DIE,DA,DR I $D(Y)!($D(DTOUT)) S IBX=0
 ;
 S IBCOVP=$P($G(^DPT(DFN,.31)),"^",11) I +IBX,IBCOVP'="Y",'IBINSD S IBX=0
 ;
 Q IBX
