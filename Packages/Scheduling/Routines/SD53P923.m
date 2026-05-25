SD53P923 ;BAH/SA - SD*5.3*923 Post-Init Routine ;Sep 22, 2025
 ;;5.3;Scheduling;**923**;AUG 13, 1993;Build 4
 ;
 ; load new Stop codes to the SD TELE HEALTH STOP CODE FILE #40.6.
 ; *** post install can be rerun with no harm ***
 ;
 Q
POST ; entry point
 N STP,DA,DIK
 D MES^XPDUTL("")
 D MES^XPDUTL("Updating of SD TELE HEALTH STOP CODE FILE...")
 ;
 ;Delete removed codes
 S DIK="^SD(40.6," F STP=135,136,137,524 D
 . S DA=$O(^SD(40.6,"B",STP,"")) I 'DA D MES^XPDUTL(STP_"    already deleted") Q
 . D ^DIK
 . D MES^XPDUTL(STP_"    deleted")
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("Stop Code Update completed.")
 D MES^XPDUTL("") H 2
 Q
