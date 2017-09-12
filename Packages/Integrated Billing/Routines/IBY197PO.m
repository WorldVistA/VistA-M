IBY197PO ;ALB/JEH - IB*2*197 POST-INSTALL ;07-NOV-02
 ;;2.0;INTEGRATED BILLING;**197**;21-MAR-94
 ;
POST ; Set up check point for post-init
 N %
 S %=$$NEWCP^XPDUTL("UP364","UP364^IBY197PO")
 S %=$$NEWCP^XPDUTL("UP3646","UP3646^IBY197PO")
 S %=$$NEWCP^XPDUTL("END","END^IBY197PO")
 Q
 ;
UP364 ; Update transmission status in file 364
 N IBZ,Z0
 D BMES^XPDUTL("Updating existing TRANSMISSION STATUS (#.03) field entries in file 364 to closed for messages flagged as Auto filed - No review")
 S IBZ=0 F  S IBZ=$O(^IBM(361,"ANR",1,IBZ)) Q:IBZ=""  S Z0=$P($G(^IBM(361,IBZ,0)),U,11) I Z0,$$PRINTUPD^IBCEU0($G(^IBM(361,IBZ,1,1,0)),+Z0)
 D COMPLETE
 Q
UP3646 ; Update file 364.6
 ; Update Local Override Allowed field to YES for IEN #184
 ; Update Short Description field for IEN #945
 N DA,DIE,DR,IBDESC
 D BMES^XPDUTL("Updating the Local Override Allowed field for IEN #184 in the IB FORM SKELETON DEFINITION FILE")
 S DA=184,DIE="^IBA(364.6,",DR=".07////1" D ^DIE
 D COMPLETE
 D BMES^XPDUTL("Updating Short Description field for IEN #945 in the IB FORM SKELETON DEFINITION FILE")
 S IBDESC="REND PROV INS SPECIFIC ID"
 S DA=945,DIE="^IBA(364.6,",DR=".1///^S X=IBDESC" D ^DIE
 D COMPLETE
 Q
COMPLETE ;
 D BMES^XPDUTL("Step Complete.")
 Q
 ;
END ;
 D BMES^XPDUTL("Post-install Complete.")
 Q
