EC2P154A ;MNT/TXH - EC National Procedure Update; Jul 29, 2021@09:50
 ;;2.0;EVENT CAPTURE;**154**;May 8, 1996;Build 2
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the EC National Procedure file (#725) for FY22.
 ;
 ; Reference to ^%ZTLOAD supported by ICR# 10063
 ; Reference to BMES^XPDUTL supported by ICR# 10141
 ; Reference to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
POST ;Entry point
 ;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Updating the EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 ;
 ;* add new/edit national procedures
 D ADDPROC^EC2P154B  ;add new procedures
 D NAMECHG^EC2P154B  ;change description
 D REACT^EC2P154C    ;reactivate code
 D CPTCHG^EC2P154C   ;change CPT code
 ;D INACT^EC2P154C    ;inactivate code - No FY22 Request
 ;
 ;create task to inspect event code screens
 D BMES^XPDUTL("Queuing the inspection of the EC Event Code Screens file (#720.3)")
 D MES^XPDUTL("for 10/02/2021 at 1:00 AM. If this patch is installed after that")
 D MES^XPDUTL("time, the inspection will queue immediately.")
 D MES^XPDUTL(" ")
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=3211002.0100
 S ZTDESC="Inspecting EC Event Code Screens file",ZTIO="" D ^%ZTLOAD
 ;
 D MES^XPDUTL("Done. Task: "_$G(ZTSK)_" has been created for this job. You")
 D MES^XPDUTL("will receive a MailMan message with the results on 10/02/2021.")
 D MES^XPDUTL(" ")
 ;
 D MES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
