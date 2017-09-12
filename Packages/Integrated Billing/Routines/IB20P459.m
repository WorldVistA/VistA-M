IB20P459 ;ALB/CXW - IB V2.0 POST INIT, IB Action Type Update; 12-SEP-2011
 ;;2.0;INTEGRATED BILLING;**459**;21-MAR-94;Build 16
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ; 
 D MSG("    IB*2*459 Post-Install .....")
 D UPACT
 D MSG("    IB*2*459 Post-Install Complete")
 Q
 ;
UPACT ;Update to file #350.1
 N IBI,IBY,IBCR,IBAT,IBCEN,IBNCC,DIE,DA,DR,X
 S IBNCC="HOSPITAL CARE (NSC)"
 S IBCEN=$O(^PRCA(430.2,"B",IBNCC,0))
 I 'IBCEN D MSG(">>> "_IBNCC_" not defined on file #430.2, no update on file #350.1") Q
 D MSG(">>> Updating Charge Category to file #350.1...")
 F IBI=1:1 S IBCR=$P($T(IBAT+IBI),";;",2) Q:IBCR="QUIT"  D
 . S IBY=$P(IBCR,"^")
 . S IBY=$O(^IBE(350.1,"B",IBY,0))
 . I 'IBY D MSG(" >> "_IBCR_" not defined on file #350.1") Q
 . S DA=+IBY,DIE="^IBE(350.1,",DR=".03///"_IBNCC D ^DIE K DA,DIE,DR
 . D MSG(" >> "_IBNCC_" updated to the "_IBCR_" type")
 Q
 ;
MSG(X) ;
 D MES^XPDUTL(X)
 Q
 ;
IBAT ; Name
 ;;DG FEE SERVICE (INPT) NEW
 ;;DG FEE SERVICE (INPT) UPDATE
 ;;DG FEE SERVICE (INPT) CANCEL
 ;;QUIT
 ;
