SPNPRI21 ;SD/CM- Pre init action for patch 21; 8-20-2003
 ;;2.0;Spinal Cord Dysfunction;**21**;01/02/1997
EN ;
 S DA=""
 S DA=$O(^SPNL(154.92,"B","OUTCOMES",DA))
 I DA="" K DA Q
 S DIK="^SPNL(154.92,"
 D ^DIK
 K DA,DIK
 Q
