ICD125P ;ALB/DMR - YEARLY DRG UPDATE; October 01, 2025@15:42 ; 10/6/25 12:23pm
 ;;18.0;DRG Grouper;**125**;October 20, 2000;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;This routine will kick off routines needed for 
 ;FY 2026 updates to the DRG Grouper.
 ;
 ;
 Q
 ;
EN ; start update
 ;UNCOMMENT BELOW LINE AFTER TESTING 80.2 UPDATE
 D PRES
 D DRG^ICD125A ;FY2026 updates to MS-DRGS
 ; ********************************************************************************
 ; *****routines ICD115F-K contain the data needed for the DRG Grouper update****
 ; ********************************************************************************
 D INACTDRG^ICD125O ; Inactivate DRGs (DRG inactivations for FY2026)
 Q
 ;
PRES ;
 D BMES^XPDUTL(">>> Killing the DRG Calculation (#83.x) files to upload clean data...")
 S DIK="^ICDD(83," S DA=0 F  S DA=$O(^ICDD(83,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.1," S DA=0 F  S DA=$O(^ICDD(83.1,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.11," S DA=0 F  S DA=$O(^ICDD(83.11,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.2," S DA=0 F  S DA=$O(^ICDD(83.2,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.3," S DA=0 F  S DA=$O(^ICDD(83.3,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.5," S DA=0 F  S DA=$O(^ICDD(83.5,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.51," S DA=0 F  S DA=$O(^ICDD(83.51,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.6," S DA=0 F  S DA=$O(^ICDD(83.6,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.61," S DA=0 F  S DA=$O(^ICDD(83.61,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.7," S DA=0 F  S DA=$O(^ICDD(83.7,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.71," S DA=0 F  S DA=$O(^ICDD(83.71,DA)) Q:DA=0  D ^DIK
 K DA,DIK
 Q
