PRCH65 ;WISC/REW/SC-Deletes Delivery Schedules for already deleted items
 ;;5.0;IFCAP;**65**;4/21/95
 ;
AZPSCH N PR,DAA,IEN4428,PO,DIK,MSG,DA
 S DIK="^PRC(442.8,"
 S PR=0 F  S PR=$O(^PRC(442.8,"AC",PR)) Q:PR=""  D
 .  S DAA=0 F  S DAA=$O(^PRC(442.8,"AC",PR,DAA)) Q:DAA'=+DAA  D
 .  .  S IEN4428=0 F  S IEN4428=$O(^PRC(442.8,"AC",PR,DAA,IEN4428)) Q:IEN4428'=+IEN4428  D
 .  .  .  S PO=$O(^PRC(442,"B",PR,0))
 .  .  .  I PO="" D KILL Q
 .  .  .  I '$D(^PRC(442,+PO,2,DAA)) D KILL Q
 .  .  .  Q
 .  .  Q
 .  Q
 Q
 ;
KILL S MSG(1)=" "
 S MSG(2)=">>> Patch 65 is deleting delivery schedule : "_IEN4428
 S MSG(3)="    since "_$S('PO:"no purchase order presently exists named: "_PR_" [`"_PO_"]",1:"there is no item "_DAA_" in purchase order "_PR_" [`"_PO_"]")
 S MSG(4)=" "
 D MES^XPDUTL(.MSG)
 S DA=IEN4428 D ^DIK
 Q
