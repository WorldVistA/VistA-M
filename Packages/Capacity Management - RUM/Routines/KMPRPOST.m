KMPRPOST ;OAK/RAK - RUM Post Install Routine ;11/19/04  09:02
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
EN ;-- entry point for post-install
 ;
 D BMES^XPDUTL(" Begin Post-Install...")
 D KILL
 D FIELD
 D MES^XPDUTL(" Post-Install complete!")
 ;
 Q
 ;
FIELD ;-- update field #2.11 - RUM WEEKS TO KEEP DATA
 ;
 N ERROR,FDA,IEN
 S IEN=$O(^KMPD(8973,0)) Q:'IEN
 ; quit if field #2.11 RUM WEEKS TO KEEP DATA contains data
 Q:$P($G(^KMPD(8973,IEN,2)),U,11)
 ; update field
 D MES^XPDUTL(" Updating field #2.11 - RUM WEEKS TO KEEP DATA...")
 S FDA($J,8973,IEN_",",2.11)=2
 D FILE^DIE("","FDA($J)","ERROR")
 ;
 Q
 ;
KILL ;-- kill off no longer used subscript
 ;
 D MES^XPDUTL(" Removing data from  ^KMPTMP(""KMPR"",""BACKGROUND"")...")
 K ^KMPTMP("KMPR","BACKGROUND")
 ;
 Q
