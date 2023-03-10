EC2P160A ;ALB/TXH - EC National Procedure Update; May 19, 2022@10:05
 ;;2.0;EVENT CAPTURE;**157,160**;May 8, 1996;Build 2
 ;
 ; This routine is used as a post-init in a KIDS build
 ; to correct 2 updates made by EC*2.0*157 and to change
 ; 2 CPT codes that were unavailable for the 2023 EC 
 ; National Procedure File (#725) update.
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
 D ADDPROC^EC2P160B  ;add new procedures
 D NAMECHG^EC2P160B  ;change description
 D CPTCHG^EC2P160C   ;change CPT code
 D INACT^EC2P160C    ;inactivate code
 ;
 ; -- Honor KIDS "No Delete" setting (XUPARAM) if called from a KIDS install.
 ; -- Delete routines EC2P160B, EC2P160C
 I '$$GET^XUPARAM("XPD NO_EPP_DELETE") D
 . F X="EC2P160B","EC2P160C" X ^%ZOSF("TEST") I $T D
 . .D MES^XPDUTL(" Deleting routine "_X_"...") X ^%ZOSF("DEL")
 K DA,DIC,DD,DO,DINUM,X
 Q
 ;
 ;create task to inspect event code screens
 ;D BMES^XPDUTL("Queuing the inspection of the EC Event Code Screens file (#720.3)")
 ;D MES^XPDUTL("for 10/02/2022 at 1:00 AM. If this patch is installed after that")
 ;D MES^XPDUTL("time, the inspection will queue immediately.")
 ;D MES^XPDUTL(" ")
 ;
 ;N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 ;S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=3221002.0100
 ;S ZTDESC="Inspecting EC Event Code Screens file",ZTIO="" D ^%ZTLOAD
 ;
 ;D MES^XPDUTL("Done. Task: "_$G(ZTSK)_" has been created for this job. You")
 ;D MES^XPDUTL("will receive a MailMan message with the results on 10/02/2022.")
 ;D MES^XPDUTL(" ")
 ;
 D MES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
