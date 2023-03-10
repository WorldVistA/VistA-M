ORY558 ;ISP/JLC - POST-INSTALL FOR OR*3.0*558 ;Dec 30, 2021@16:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**558**;Dec 17, 1997;Build 15
 Q
POST ;DELETE Gender field, is present from demographic report
 N DA,DIK
 S DA=$O(^ORD(101.24,1033,3,"B","Gender","")) Q:DA=""
 S DIK="^ORD(101.24,1033,3,",DA(1)=1033 D ^DIK
 Q
