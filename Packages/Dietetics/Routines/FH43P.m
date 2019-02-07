FH43P ;EPIP/WLE - Remove three FILES for file  ;9/14/18 3:45 PM
 ;;5.5;DIETETICS;**43**;Jan 28, 2005;Build 66
 ; PRE install routine for patch FH*5.5*43 to remove the entries from File 117.0243, 117.0241, 117.024
 ; created in previous patch versions
 ;
EN ;
 I $D(^FH(117.0243,"B","FHNO2"))=0 Q
 S DIK="^FH(117.0243,"
 S DA="" F  S DA=$O(^FH(117.0243,DA)) Q:DA=""  D ^DIK
 S DIK="^FH(117.024,"
 S DA="" F  S DA=$O(^FH(117.024,DA)) Q:DA=""  D ^DIK
 S DIK="^FH(117.0241,"
 S DA="" F  S DA=$O(^FH(117.0241,DA)) Q:DA=""  D ^DIK
 K DIK,DA
 Q
