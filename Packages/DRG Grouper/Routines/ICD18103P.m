ICD18103P ;ALB/JDG - DRG UPDATE COVID19; 4/1/2020@13:36
 ;;18.0;DRG Grouper;**103**;Oct 20, 2000;Build 4
 ;
 ;This routine will kick off FY 2020 COVID-19 
 ;updates to the DRG Grouper.
 ;
 ;
 Q
 ;
EN ; start update
 D PRES
 Q
 ;
PRES ;
 S DIK="^ICDD(83.1," S DA=0 F  S DA=$O(^ICDD(83.1,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.2," S DA=0 F  S DA=$O(^ICDD(83.2,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.5," S DA=0 F  S DA=$O(^ICDD(83.5,DA)) Q:DA=0  D ^DIK
 S DIK="^ICDD(83.51," S DA=0 F  S DA=$O(^ICDD(83.51,DA)) Q:DA=0  D ^DIK
 Q
