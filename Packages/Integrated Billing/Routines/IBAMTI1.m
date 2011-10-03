IBAMTI1 ;ALB/CPM - SPECIAL INPATIENT BILLING CASES (CON'T.) ; 11-AUG-93
 ;;2.0;INTEGRATED BILLING;**52,132,156,199,234,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
DISP ; Manually disposition a case record.
 W !!,"This option is used to disposition case records for special inpatient"
 W !,"episodes of care which are not to be billed. (AO/IR/SWA/SC/MST/HNC/CV/SHAD)"
 W !,"After identifying the case, please enter the reason (up to 80 characters)"
 W !,"for non-billing."
 ;
 ; - main processing loop
 S IBQ=0 F  W ! D SEL Q:IBQ
 K IBQ
 Q
 ;
SEL ; Select an inpatient billing case and enter the reason for non-billing.
 S DIC="^IBE(351.2,",DIC(0)="QEAMZ",DIC("A")="Select PATIENT: "
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 D ^DIC S IBC=+Y I Y<0 S IBQ=1 G SELQ
 I $P(Y(0),"^",5)=1 W !!,"You must wait until this patient has been discharged to disposition the case." G SELQ
 I $P(Y(0),"^",4) S IBBILLED=1 W !!,"Please note that it appears as if this case has been billed."
 I $P(Y(0),"^",8) W !!,"Please note that this case has already been dispositioned."
 ;
 ; - display case record
 W ! D DSPL(IBC)
 ;
 ; - allow user update of record
 S IBHC=$P(Y(0),"^",7),IBHR=$G(^IBE(351.2,IBC,1))
 S DIE="^IBE(351.2,",DA=IBC,DR=$S($G(IBBILLED):".07;",1:"")_1 D ^DIE
 ;
 S IBNC=$P(^IBE(351.2,IBC,0),"^",7),IBNR=$G(^IBE(351.2,IBC,1))
 I IBHC=IBNC,IBHR=IBNR W !!,"No changes made to the case record!" G SELQ
 I IBNR]"" W !!,"This case record will be dispositioned."
 S DR="2.03////"_DUZ_";2.04///NOW"
 I IBNR]"" S DR=".07////1;.08////1;"_DR
 S DIE="^IBE(351.2,",DA=IBC D ^DIE
SELQ K DA,DIC,DIE,DR,IBC,IBHC,IBHR,IBNC,IBNR,IBBILLED
 Q
 ;
CEA(IBPM,IBEVT) ; Automatically disposition the case from Cancel/Edit/Add.
 ;  Input:     IBPM  --  Pointer to the adm movement in file #405
 ;            IBEVT  --  Pointer to the billing event record in file #350
 I '$G(IBEVT) G CEAQ
 N DA,DIE,DR,IBC
 S IBC=$O(^IBE(351.2,"AC",+$G(IBPM),0)) I IBC D UPD(0)
CEAQ Q
 ;
CHK(IBC,IBEVT) ; Review the case after adding a charge from Cancel/Edit/Add.
 ;  Input:      IBC  --  Pointer to the case in file #351.2
 ;            IBEVT  --  Pointer to the billing event record in file #350
 I '$G(IBC)!'$G(IBEVT) G CHKQ
 N DA,DIE,DR,IBCD,IBCD1
 S IBCD=$G(^IBE(351.2,IBC,0)),IBCD1=$G(^(1))
 I $P(IBCD,"^",7)!'$P(IBCD,"^",8)!(IBCD1]"") D UPD(1)
CHKQ Q
 ;
UPD(IND) ; Disposition the case record.
 ;  Input:      IND  --  0 = dispositioning  |  1 = reviewing
 ;         variables --  IBC => ptr to case record
 ;                       IBEVT => ptr to event record in #350
 W !,"Dispositioning the special inpatient billing case record"
 W:$G(IND) " (as billable)" W "..."
 K ^IBE(351.2,IBC,1)
 S DR=".04////"_IBEVT_";.07////0;.08////1;2.03////"_DUZ_";2.04///NOW"
 S DIE="^IBE(351.2,",DA=IBC D ^DIE W "  done."
 Q
 ;
DSPL(IBC) ; Display a case record.
 ;  Input:      IBC  --  Pointer to the case record in file #351.2
 I '$G(IBC) G DSPLQ
 N DFN,IBCD,IBC1,IBC2,IBATYP,IBPT,IBDIS,IBCL,IBEVT,IBN,IBND,Y
 S IBCD=$G(^IBE(351.2,IBC,0)),IBC1=$G(^(1)),IBC2=$G(^(2))
 S DFN=+IBCD,IBPT=$$PT^IBEFUNC(DFN),IBCL=$P(IBCD,"^",3)
 W !,$$DASH(),!?1,"Pt. Name: ",$E($P(IBPT,"^"),1,17),"  (",$P(IBPT,"^",3),")"
 W ?38,"Care related to ",$$PATTYAB^IBACV(IBCL),": ",$S($P(IBCD,"^",7):"YES",$P(IBCD,"^",7)=0:"NO",1:"UNANSWERED")
 W !?5,"Type: ",$$UCCL^IBAMTI(IBCL),?39,"Case Dispositioned: ",$S($P(IBCD,"^",8):"YES",1:"NO")
 W !?1,"Adm Date: ",$$DAT1^IBOUTL(+$G(^DGPM(+$P(IBCD,"^",2),0)),1),?41,"Date Last Edited: ",$$DAT1^IBOUTL(+$P(IBC2,"^",4),1)
 S IBDIS=+$G(^DGPM(+$P($G(^DGPM(+$P(IBCD,"^",2),0)),"^",17),0))
 W !,"Disc Date: ",$S(IBDIS:$$DAT1^IBOUTL(IBDIS,1),1:"Still Admitted"),?43,"Last Edited By: ",$E($P($G(^VA(200,+$P(IBC2,"^",3),0)),"^"),1,20),!,$$DASH()
 ;
 S IBEVT=+$P(IBCD,"^",4)
 I $O(^IB("AF",IBEVT,IBEVT)) W !?1,"Charges Billed:" D
 .S IBN=0 F  S IBN=$O(^IB("AF",IBEVT,IBN)) Q:'IBN  I IBN'=IBEVT D
 ..S IBND=$G(^IB(IBN,0))
 ..S IBATYP=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^")
 ..S:$E(IBATYP,1,2)="DG" IBATYP=$E(IBATYP,4,99)
 ..W !?5,IBATYP,?35,$$DAT1^IBOUTL($P(IBND,"^",14)),?46,$$DAT1^IBOUTL($P(IBND,"^",15))
 ..W ?57,"$",$P(IBND,"^",7),?64,$P($G(^IBE(350.21,+$P(IBND,"^",5),0)),"^",2)
 .W !,$$DASH()
 ;
 I IBC1]"" W !?1,"Reason for Non-Billing:",!,IBC1,!,$$DASH(),!
DSPLQ Q
 ;
DASH() ; Return a dashed line.
 Q $TR($J("",80)," ","-")
