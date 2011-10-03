SPNPRI20 ;SD/WDE/Pre init action for patch 20; 6/05/2003 14:23
 ;;2.0;Spinal Cord Dysfunction;**20**;01/02/1997
EN ;
 S DA=""
 S DA=$O(^SPNL(154.92,"B","DIAGNOSIS",DA))
 I DA="" K DA Q
 S DIK="^SPNL(154.92,"
 D ^DIK
 K DA,DIK
 Q
