IBY181PO ;ALB/JEH - IB*2*181 POST-INSTALL ;01-MAY-02
 ;;2.0;INTEGRATED BILLING;**181**;21-MAR-94
 ;
POST ; Set up check points for post-init
 N %
 S %=$$NEWCP^XPDUTL("UP3646","UP3646^IBY181PO")
 S %=$$NEWCP^XPDUTL("UPD3643","UP3643^IBY181PO")
 S %=$$NEWCP^XPDUTL("END","END^IBY181PO")
 Q
 ;
UP3646 ; Update NDC CODE # field in file 364.6
 N DA,DIE,DR
 D BMES^XPDUTL("Updating the LENGTH Field of the NDC CODE # entry in the IB FORM SKELETON DEFINITION File")
 S DA=135,DIE="^IBA(364.6,",DR=".09////11" D ^DIE
 D COMPLETE
 Q
UP3643 ; Delete entries in Mailgroup to Notify field in file 364.3
 N Z,DA,DIE,DR
 D BMES^XPDUTL("Updating MAILGROUP TO NOTIFY Field of the IB MESSAGE ROUTER File")
 S DIE="^IBE(364.3,",DR=".02///@" S Z=0 F  S Z=$O(^IBE(364.3,Z)) Q:'Z  S DA=Z D ^DIE
 D COMPLETE
 Q
COMPLETE ;
 D BMES^XPDUTL("Step complete.")
 Q
END ;
 D BMES^XPDUTL("Post-install complete.")
 Q
