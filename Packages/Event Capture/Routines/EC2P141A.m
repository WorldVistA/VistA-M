EC2P141A ;ALB/DE - EC National Procedure Update ; 11/9/17 11:00am
 ;;2.0;EVENT CAPTURE;**141**;8 May 96;Build 4
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the EC National Procedure file (#725)
 ;
 Q
 ;
POST ; entry point 
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Updating the National Procedures file (#725)...")
 D MES^XPDUTL(" ")
 ;* add new/edit national procedures
 ;D ADDPROC^ ;add new procedures -- No request for Mid-FY18
 ;D NAMECHG^ ;change description -- No request for Mid-FY18
 D CPTCHG^EC2P141C  ;change CPT code
 D INACT^EC2P141C   ;inactivate code
 ;
 D BMES^XPDUTL("  ")
 D BMES^XPDUTL("Inspecting EC Event Code Screens file (#720.3)...")
 D BMES^XPDUTL("You will receive a MailMan message regarding file #720.3 ")
 D MES^XPDUTL("  ")
 D INACTSCR^ECUTL3(1) ;api to automatically inactivate associated event code screens
 ;
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
