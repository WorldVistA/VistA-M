KMPSPOST ;OAK/RAK - SAGG Post Install Routine ;9/1/2015
 ;;2.0;SAGG PROJECT;**1**;Jul 02, 2007;Build 67
 ;
EN ;-- entry point for post-install
 ;
 D BMES^XPDUTL(" Begin Post-Install...")
 D GROUP
 D MES^XPDUTL(" Post-Install complete!")
 ;
 Q
 ;
GROUP ;-- delete entry REMOTE MEMBER 'G.A1B5@FO-BIRM.DOMAIN.EXT' or 'G.A1B5@ISC-BIRM.DOMAIN.EXT' from KMP-CAPMAN mail group
 N ERROR,FDA,GROUP,IEN,IEN1
 S IEN=$O(^XMB(3.8,"B","KMP-CAPMAN",0))
 Q:'IEN
 F GROUP="G.A1B5@FO-BIRM.DOMAIN.EXT","G.A1B5@ISC-BIRM.DOMAIN.EXT" D 
 .K FDA,IEN1
 .S IEN1=$O(^XMB(3.8,IEN,6,"B",GROUP,0))
 .; MEMBER - REMOTE field
 .S FDA($J,3.812,IEN1_","_IEN_",",.01)="@"
 .D FILE^DIE("","FDA($J)","ERROR")
 Q
