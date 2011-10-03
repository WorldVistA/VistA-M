IBY5PT ;ALB/NLR - Post-init for Patch IB*2*6 ; 05-MAY-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**6**; 21-MAR-94
 ;
 D POP ;        Add the IVM Center domain to file #350.9
 D ADD ;        Add the new option to the Mgmt reports menu
 D ^IBY5ONIT ;  Install the IBCN NEW INSURANCE EVENTS protocol
 Q
 ;
POP ; Add the IVM Center domain to file #350.9
 W !!,">>> Updating the IVM Center domain in the IB SITE PARAMETERS (#350.9) file..."
 S $P(^IBE(350.9,1,4),"^",7)="G.IVM REPORTS@IVM.VA.GOV"
 Q
 ;
ADD ; Add the option IVM Billing Activity Report to the Mgmt reports menu
 S (IBUY,Y)=$O(^DIC(19,"B","IB OUTPUT MANAGEMENT REPORTS",0)) Q:Y=""
 S X=$O(^DIC(19,"B","IB OUTPUT IVM BILLING ACTIVITY",0)) Q:X=""
 W !!,"<<< Adding IB OUTPUT IVM BILLING ACTIVITY option to IB OUTPUT MANAGEMENT",!,"    REPORTS menu..."
 I '$D(^DIC(19,+Y,10,0)) S ^DIC(19,+Y,10,0)="^19.01IP^0^0"
 S (DA,D0)=+Y,DIC="^DIC(19,"_+Y_",10,",DIC(0)="L",DA(1)=+Y,DLAYGO=19.01,X="IB OUTPUT IVM BILLING ACTIVITY" D ^DIC
 S DA=+Y,DIE="^DIC(19,"_DA(1)_",10,",DR="2///^S X=""IVM""" D ^DIE
 K DIC,DIE,DA,IBUY,DR,X,Y
 Q
