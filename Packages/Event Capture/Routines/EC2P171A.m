EC2P171A ;MNTVBB/DBN - EC National Procedure Update; April 17, 2025@15:50
 ;;2.0;EVENT CAPTURE;**171**;May 8, 1996;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update the EC National Procedure file (#725) for FY25.
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
  ; File Backup prior to Install  
 N EC171FILE,EC171FILES,ECCNT
 S EC171FILE=""
 S EC171FILES="725"
 S ECCNT=0
 F ECCNT=1:1:$L(EC171FILES,"^") D
 . S EC171FILE=$P(EC171FILES,"^",ECCNT)
 . D GLBBKUP
 . Q
 ;* add new/edit national procedures
 ;D ADDPROC^EC2P171B  ;add new procedures - No FY26 Request
 D NAMECHG^EC2P171B  ;change description
 ;D REACT^EC2P171C    ;reactivate code - No FY26 Request
 ;D CPTCHG^EC2P171C   ;change CPT code - No FY26 Request
 D INACT^EC2P171C    ;inactivate code 
 ;
 ;create task to inspect event code screens
 D BMES^XPDUTL("Queuing the inspection of the EC Event Code Screens file (#720.3)")
 D MES^XPDUTL("for 10/2/2025 at 1:00 AM. If this patch is installed after that")
 D MES^XPDUTL("time, the inspection will queue immediately.")
 D MES^XPDUTL(" ")
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=3251002.0100
 S ZTDESC="Inspecting EC Event Code Screens file",ZTIO="" D ^%ZTLOAD
 ;
 D MES^XPDUTL("Done. Task: "_$G(ZTSK)_" has been created for this job. You")
 D MES^XPDUTL("will receive a MailMan message with the results on 10/2/2025.")
 D MES^XPDUTL(" ")
 ;
 D MES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
 ;
GLBBKUP  ; XTMP Backup of file(s)
 N ECBKUPNDE
 S ECBKUPNDE="EC*2*171-EC NATIONAL CODE UPDATES FOR FY25 - FILE BACKUP"
 S ^XTMP("EC2P171",0)=$$FMADD^XLFDT(DT,120)_"^"_DT_"^"_ECBKUPNDE
 M ^XTMP("EC2P171",EC171FILE,$H)=^EC(EC171FILE)
 Q
