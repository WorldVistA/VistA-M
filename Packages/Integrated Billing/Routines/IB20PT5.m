IB20PT5 ;ALB/CPM - IB V2.0 POST-INIT ONE-TIME ITEMS ; 03-SEP-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ; Perform various one-time post-init items
 D ACHG ;       kill any dangling nodes in the IB ACTION TYPE file
 D DEF ;        enter the default billing form, if necessary
 D STAT ;       populate the IB ACTION STATUS (#350.21) file
 D BASC ;       update the BASC start date to 10/1/99
 D PSO ;        update eligibility logic for PSO SC RX COPAY NEW (#350.1)
 D CRES ;       update the cancellation reason MT CHARGE EDITED (#350.3)
 D CCMG ;       update the central collection mailgroup
 D FT ;         update form type file
 D ABP ;        set auto biller parameters
 D ^IB20PT51 ;  keep going...
 Q
 ;
 ;
ACHG ; Clean up any IB ACTION CHARGE (#350.2) nodes left hanging.
 W !!,">>> Cleaning up dangling nodes in the IB ACTION CHARGE (#350.2) file..."
 S I=0 F  S I=$O(^IBE(350.2,I)) Q:'I  I '$D(^(I,0)) K ^IBE(350.2,I)
 Q
 ;
DEF ; Enter default billing form type.
 W !!,">>> Initializing the DEFAULT FORM TYPE, if necessary..."
 I '$P($G(^IBE(350.9,1,1)),U,26) S DA=1,DIE="^IBE(350.9,",DR="1.26////1" D ^DIE K DA,DIE,DR
 Q
 ;
BASC ; Update the BASC start date to 10/1/99.
 W !!,">>> Updating the BASC start date to 10/1/99..."
 S $P(^IBE(350.9,1,1),"^",24)=2991001
 Q
 ;
STAT ; Set new entries into the IB ACTION STATUS (#350.21) file.
 W !!,">>> Populating the IB ACTION (#350.21) file... "
 K ^IBE(350.21)
 S ^IBE(350.21,0)="IB ACTION STATUS^350.21^99^12"
 S ^IBE(350.21,1,0)="INCOMPLETE^INCOMPLETE^INC^0^0^0"
 S ^IBE(350.21,2,0)="COMPLETE^PENDING A/R^PEND^0^0^0"
 S ^IBE(350.21,3,0)="BILLED^BILLED^BILL^1^0^0"
 S ^IBE(350.21,4,0)="UPDATED^UPDATED^UPD^1^0^0"
 S ^IBE(350.21,8,0)="ON HOLD^ON HOLD (INS)^INS^0^0^1"
 S ^IBE(350.21,9,0)="ERROR ENCOUNTERED^ERROR^ERR^0^1^0"
 S ^IBE(350.21,10,0)="CANCELLED^CANCELLED^CANC^1^1^0"
 S ^IBE(350.21,11,0)="CO-PAY EXEMPTION CANCELLATION^CANCELLED (EXEMPTED)^EXEMPTED^1^1^0"
 S ^IBE(350.21,20,0)="HOLD - RATE^ON HOLD (RATE)^RATE^0^0^1"
 S ^IBE(350.21,99,0)="CONVERTED RECORD^CONVERTED RECORD^CONV^0^0^0"
 S DIK="^IBE(350.21," D IXALL^DIK K DIK
 Q
 ;
CCMG ; Update the central collection mailgroup in file #350.9
 W !!,">>> Updating the central collection mailgroup to G.MCCR DATA@FORUM.VA.GOV ..."
 S IBX="G.MCCR DATA@FORUM.VA.GOV"
 S DA=1,DIE="^IBE(350.9,",DR="4.05///^S X=IBX" D ^DIE K DA,DR,DIE,IBX
 Q
 ;
CRES ; Update the cancellation reason MT CHARGE EDITED in file #350.3
 W !!,">>> Updating the cancellation reason MT CHARGE EDITED in file #350.3 ..."
 S DA=$O(^IBE(350.3,"B","MT CHARGE EDITED",0))
 I DA S DIE="^IBE(350.3,",DR=".03////2" D ^DIE K DIE,DR,DA
 Q
 ;
FT ; Update called routine for form type HCFA 1500
 W !!,">>> Updating the Form Types in #353..."
 S IBFT="HCFA 1500" S IBFTI=$O(^IBE(353,"B",IBFT,0)) I +IBFTI S DIE="^IBE(353,",DA=IBFTI,DR="1.01////EN^IBCF2" D ^DIE K DIE,DR,DA
 ;K DD,DO S DIC="^IBE(353,",DIC(0)="L",X="UB-92",DIC("DR")="1.01////EN^IBCF3" D FILE^DICN K DIC,X
 K IBFT,IBFTI
 Q
 ;
PSO ; Update the eligibility logic for PSO SC RX COPAY NEW
 W !!,">>> Updating the Eligibility logic for SC veterans for Pharmacy copay..."
 S IBNEWSC=$P($T(NEWCODE),";;",2,99)
 S IBX="PSO SC RX COPAY NEW",IBDA=+$O(^IBE(350.1,"B",IBX,0))
 S ^IBE(350.1,IBDA,40)=IBNEWSC
 K IBDA,IBNEWSC,IBX
 Q
 ;
NEWCODE ;;S X=0,X1="",X2="" G:'$D(VAEL) 1^IBAERR I VAEL(4),+VAEL(3),'IBDOM S X=$S($P(VAEL(3),"^",2)<50:2,1:0) I X S:$$RXEXMT^IBARXEU0(DFN,DT) X=0 I X S X2=$P(^IBE(350.1,DA,0),"^",4) D COST^IBAUTL
 ;
 ;
ABP ; Set auto biller parameters.
 Q:'$G(IBAUTOBP)
 W !!,">>> Initializing the AUTO BILLER PARAMETERS ..."
 S DA=1,DIE="^IBE(350.9,",DR="7.01////7;7.02////"_DT D ^DIE K DA,DIE,DR
 S DA=1,DIE="^IBE(356.6,",DR=".04////1;.06////2" D ^DIE K DA,DIE,DR
 Q
