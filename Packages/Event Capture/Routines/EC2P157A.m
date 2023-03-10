EC2P157A ;ALB/TXH - EC National Procedure Update; May 19, 2022@10:05
 ;;2.0;EVENT CAPTURE;**157**;May 8, 1996;Build 4
 ;
 ; This routine is used as a post-init in a KIDS build
 ; to update the EC National Procedure File (#725).
 ;
 ; Reference to ^%ZTLOAD supported by DBIA# 10063
 ; Reference to BMES^XPDUTL supported by DBIA# 10141
 ; Reference to MES^XPDUTL supported by DBIA# 10141
 ;
 Q
 ;
POST ;Entry point
 ;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Updating the EC NATIONAL PROCEDURE FILE (#725)...")
 D MES^XPDUTL(" ")
 ;
 ;* add new/edit national procedures
 D ADDPROC^EC2P157B  ;add new procedures
 D NAMECHG^EC2P157B  ;change description
 D CPTCHG^EC2P157C   ;change CPT code
 D INACT^EC2P157C    ;inactivate code
 ;
 ;create task to inspect event code screens
 D BMES^XPDUTL("Queuing the inspection of the EC Event Code Screens file (#720.3)")
 D MES^XPDUTL("for 10/02/2022 at 1:00 AM. If this patch is installed after that")
 D MES^XPDUTL("time, the inspection will queue immediately.")
 D MES^XPDUTL(" ")
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=3221002.0100
 S ZTDESC="Inspecting EC Event Code Screens file",ZTIO="" D ^%ZTLOAD
 ;
 D MES^XPDUTL("Done. Task: "_$G(ZTSK)_" has been created for this job. You")
 D MES^XPDUTL("will receive a MailMan message with the results on 10/02/2022.")
 D MES^XPDUTL(" ")
 ;
 D MES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
