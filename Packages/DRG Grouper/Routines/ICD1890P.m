ICD1890P ;ALB/JDG - YEARLY DRG UPDATE;8/9/2010
 ;;18.0;DRG Grouper;**90**;Oct 20, 2000;Build 13
 ;
 ;This routine will kick off Routines needed for 
 ;FY 2017 updates to the DRG Grouper.
 ;
 ;
 Q
 ;
EN ; start update
 D PRES
 D DRG^ICD1890A ;FY2017 updates to MS-DRGS
 ; ********************************************************************************
 ; *****routines ICD1890F-K contain the data needed for the DRG Grouper update*****
 ; ********************************************************************************
 D INACTDRG^ICD1890O ; INACTIVATE DRGS
 Q
 ;
PRES ;
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
 Q
