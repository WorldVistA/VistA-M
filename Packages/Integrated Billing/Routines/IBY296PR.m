IBY296PR ;ALB/TMK - IB*2*296 PRE-INSTALL ;12-JAN-05
 ;;2.0;INTEGRATED BILLING;**296**;21-MAR-94
 ;
 D BMES^XPDUTL("Pre-Installation Updates")
 ;
 D BMES^XPDUTL("Updating/removing output formatter records")
 S DA=1015,DIE="^IBA(364.7,",DR=".03////5" D ^DIE
 ;
 D ENDST
 ;
 D END
 Q
 ;
ENDST ;
 D BMES^XPDUTL("Step complete")
 Q
 ;
END ;
 D BMES^XPDUTL("Pre-install complete")
 Q
 ;
