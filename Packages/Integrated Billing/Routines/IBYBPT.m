IBYBPT ;ALB/ARH - PATCH IB*2*27 POST-INITIALIZATION ; 16-DEC-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**27**; 21-MAR-94
 ;
EN ; Update Billing Parameters to activate CHAMPVA Billing.
 ;
 D LT ;     Install the IB CHARGES List Template.
 D ER ;     Add new error for CHAMPVA Rate and Insurer mismatch
 ;
 I '$$RERUN^IBYBPRE() D  G ENQ
 .I $G(IBCTP),$G(IBCCV),$G(IBCCS),$G(IBACN),$G(IBACC),$G(IBACU),$G(IBRTP),$G(IBRCV) D  Q
 ..W !!,">>> Initializing Billing Parameters for CHAMPVA Billing..."
 ..D TP ;   Update Third Party rate types
 ..D FP ;   Update Patient Billing action type; add new subsistence rate
 .W !!,">>> Unable to initialize your CHAMPVA billing parameters!"
 .W !,"    Please call your ISC for assistance."
 ;
 W !!,">>> It appears as if you are re-running the initialization."
 W !,"    The CHAMPVA Billing parameters were not updated."
 ;
ENQ K IBCTP,IBCCV,IBCCS,IBACN,IBACC,IBACU,IBRTP,IBRCV
 Q
 ;
 ;
TP ; Update Third Party rate types with the AR Category.
 S DA=IBRTP,DIE="^DGCR(399.3,",DR=".03///@;.06////"_IBCTP D ^DIE
 S DA=IBRCV,DIE="^DGCR(399.3,",DR=".03///@;.06////"_IBCCV D ^DIE
 W !!," >> The two CHAMPVA RATE TYPES have been activated and linked to an",!,"    ACCOUNTS RECEIVABLE CATEGORY..."
 K DA,DIE,DR
 Q
 ;
FP ; Update Patient Billing action types, and add the new subsistance rate.
 F IBI=IBACN,IBACC,IBACU S DA=IBI,DIE="^IBE(350.1,",DR=".03////"_IBCCS D ^DIE K DIE,DA,DR
 W !," >> The Patient Billing CHAMPVA Action Types have been updated..."
 ;
 S X="CHAMPVA PER DIEM",DIC(0)="",DIC="^IBE(350.2," K DD,DO D FILE^DICN
 S DA=+Y,DIE=DIC,DR=".02////2941001;.03////"_IBACN_";.04////9.50" D ^DIE
 W !," >> Added new CHAMPVA Subsistence rate, effective 10/1/94..."
 K DA,DIE,DR,X,Y,IBI
 Q
 ;
 ;
ER ; Update entry in IB ERROR file for CHAMPVA Rate Type and Insurer's Type of Coverage not both CHAMPVA
 S DIE="^IBE(350.8,",DA=85,DR=".01///IB CHAMPVA RATE/INSURER;.02///Rate Type and Primary Carrier's Type of Coverage do not both match CHAMPVA." D ^DIE
 W !!,">>> IB085 - CHAMPVA Rate/Insurer match error added to IB ERROR file."
 K DIE,DA,DR,X,Y
 Q
 ;
LT ; Install the IB CHARGES List Template.
 W !!,">>> Installing List Template..."
 W !,"'IB CHARGES' List Template..."
 S DA=$O(^SD(409.61,"B","IB CHARGES",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="IB CHARGES" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IB CHARGES^1^1^80^5^14^1^1^Charge^IBACM1 MENU^Charges^1^32"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBACM"",$J)"
 .S ^SD(409.61,VALM,"COL",0)="^409.621^7^7"
 .S ^SD(409.61,VALM,"COL",1,0)="CHARGE^71^9^Charge"
 .S ^SD(409.61,VALM,"COL",2,0)="FDATE^4^9^Bill From"
 .S ^SD(409.61,VALM,"COL",3,0)="ENTRY^25^23^Charge Type"
 .S ^SD(409.61,VALM,"COL",4,0)="STATUS^58^12^Status"
 .S ^SD(409.61,VALM,"COL",5,0)="CHG#^1^3"
 .S ^SD(409.61,VALM,"COL",6,0)="BILL#^49^8^Bill #"
 .S ^SD(409.61,VALM,"COL",7,0)="TDATE^15^8^Bill To"
 .S ^SD(409.61,VALM,"FNL")="D FNL^IBECEA"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBECEA"
 .S ^SD(409.61,VALM,"HLP")="S X=""?"" D DISP^XQORM1 W !!"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBECEA"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 K DIC,DIK,VALM,X,DA
 Q
