ENXRIPS ;WISC/SAB-POST INIT ;9/24/96
 ;;7.0;ENGINEERING;**36**;Aug 17, 1993
 N DA,DIK,ENSN,ENX
 ;D MES^XPDUTL("  Performing Post-Init...")
 ; check for local field #.7 conflict
 I $$GET1^DID(6914.1,.7,"","GLOBAL SUBSCRIPT LOCATION","","ENX")="0;7" D
 . ;S FLDNAME=$$GET1^DID(6914.1,.7,"","LABEL","","ENX")
 . D MES^XPDUTL("    Removing field #.7 from file #6914.1 due to global conflict...")
 . S DIK="^DD(6914.1,",DA=.7,DA(1)=6914.1 D ^DIK K DA,DIK
 ; check for improper entires in 0;7
 S DA=0 F  S DA=$O(^ENG(6914.1,DA)) Q:'DA  D
 . S ENSN=$P($G(^ENG(6914.1,DA,0)),U,7)
 . I ENSN]"",ENSN'?3N.2NU S $P(^ENG(6914.1,DA,0),U,7)="" D MES^XPDUTL("     Spurious data for Station Number removed from CMR "_$P(^(0),U)_".")
 ;D MES^XPDUTL("  Completed Post-Init")
 Q
 ;ENXRIPS
