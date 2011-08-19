FBAAVD3 ;WCIOFO/SAB-EDIT VENDOR FPDS DATA ;10/6/97
 ;;3.5;FEE BASIS;**9,10**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RDV ; ask vendor
 D GETVEN^FBAAUTL1 G:IFN="" EXIT S DA=IFN
 ; display vendor
 ;D EN1^FBAAVD
 ; check vendor
 I $D(^FBAA(161.25,"AF",DA)) D  G RDV
 . ; linked vendor
 . W !,"Current vendor information is pending Austin processing."
 . W !,"Use the Display/Edit Vendor option if changes need to be made."
 I $D(^FBAA(161.25,DA,0)),$P(^(0),U,5)]"" D  G RDV
 . ; awaiting reply from Austin
 . W !,"Current vendor information is pending Austin processing."
 . W !,"Use the Display/Edit Vendor option if changes need to be made."
 I $P($G(^FBAAV(DA,"ADEL")),U)="Y" D  G RDV
 . W !,"Vendor has been deleted."
 . W !,"Use the Display/Edit Vendor option if changes need to be made."
 ; lock vendor
 L +^FBAAV(DA):5 I '$T D  G RDV
 . W !,"Vendor is being accessed by another user."
 . W !,"Please try again later."
 ; save current FPDS data
 S FBBT("O")=$P($G(^FBAAV(DA,1)),U,10)
 D GETGRP^FBAAUTL6(DA)
 ; edit vendor FPDS data
 S DIE="^FBAAV(",DR="24;S FBBT=X;25;S:$$VGRP^FBAAUTL6(D0) Y=24"
 D ^DIE K DIE
 ; if data changed store in 161.25
 I $P($G(^FBAAV(DA,1)),U,10)'=FBBT("O")!$$GRPDIF^FBAAUTL6(DA) D
 . Q:$D(^FBAA(161.25,DA,0))  ; already queued, all actions inc. FPDS data
 . ; add to file 161.25 with action of F
 . S FBT="F",FBIEN1=DA,FEEO="" D SETGL^FBAAVD
 . K FBT,FBIEN1,FEEO
 ; unlock vendor
 L -^FBAAV(DA)
 ; 
 G RDV
EXIT ;
 K DA,DIE,DR,IFN,FBBT,FBSG
 Q
