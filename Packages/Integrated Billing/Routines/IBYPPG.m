IBYPPG ;ALB/ARH - IB*2*148 POST INIT: REASONABLE CHARGES V1.2 ; 05/17/01
 ;;2.0;INTEGRATED BILLING;**148**;21-MAR-94
 ; 
 Q
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*148 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 ;
 D CPTINA ; inactivate charges for inactive CPT codes
 D CSEMPTY ; delete Charge Sets with no charges assigned
 D ERRORCD ; add error code IB320 to IB Error file (#350.8)
 ;
 S IBA(1)="",IBA(2)="    IB*2*148 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
CPTINA ; inactivate charges for Inactive CPTs
 N IBA,IBCNT S IBCNT=0
 S IBA(1)="",IBA(2)="    >> Inactivating Charges for Inactive CPT codes, Please Wait..." D MES^XPDUTL(.IBA) K IBA
 ;
 S IBCNT=$$INACTCPT^IBCREC(0) ; inactivate charges for inactive CPT codes
 ;
 S IBA(1)="       Done.  "_IBCNT_" Charges Inactivated." D MES^XPDUTL(.IBA) K IBA
 Q
 ;
CSEMPTY ; delete Charges Sets with no Charges assigned
 N IBA,IBCNT S IBCNT=0
 S IBA(1)="",IBA(2)="    >> Removing Charges Sets that have no Charges Assigned..." D MES^XPDUTL(.IBA) K IBA
 ;
 S IBCNT=$$CSEMPTY^IBCRED() ; delete Charge Sets that have no charges
 ;
 S IBA(1)="       Done.  "_IBCNT_" Charges Sets Removed." D MES^XPDUTL(.IBA) K IBA
 Q
 ;
ERRORCD ; add a new Error Code to #350.8
 N IBA,IBCODE,IBEMES,IBFN,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y
 ;
 S IBCODE="IB320",IBEMES="Clinic Required for Surgical Procedures (10000-69999, 93501-93533)"
 ;
 I $O(^IBE(350.8,"AC",IBCODE,0)) Q
 ;
 K DD,DO S DLAYGO=350.8,DIC="^IBE(350.8,",DIC(0)="L",X=IBCODE D FILE^DICN K DIC I Y<1 K X,Y Q
 S IBFN=+Y
 ;
 S DR=".02///"_IBEMES_";.03///"_IBCODE_";.04////1;.05////1"
 S DIE="^IBE(350.8,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
 S IBA(1)="",IBA(2)="    >> Error Code IB320 Added to IB Error File (#350.8) " D MES^XPDUTL(.IBA) K IBA
 Q
