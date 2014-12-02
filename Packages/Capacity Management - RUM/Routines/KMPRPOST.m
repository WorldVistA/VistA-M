KMPRPOST ;OAK/RAK - RUM Post Install Routine ;1/30/13  06:46
 ;;2.0;CAPACITY MANAGEMENT - RUM;**2**;May 28, 2003;Build 12
 ;
EN ;-- entry point for post-install
 ;
 D BMES^XPDUTL(" Begin Post-Install...")
 D OPT
 D MES^XPDUTL(" Post-Install complete!")
 ;
 Q
 ;
OPT ;-- delete entry action from option
 N ERROR,FDA,IEN
 S IEN=$O(^DIC(19,"B","KMPR START COLLECTION",0)) Q:'IEN
 Q:'$D(^DIC(19,IEN,0))
 ; E ACTION PRESENT field
 S FDA($J,19,IEN_",",14)=""
 ; ENTRY ACTION field
 S FDA($J,19,IEN_",",20)=""
 D FILE^DIE("","FDA($J)","ERROR")
 Q
