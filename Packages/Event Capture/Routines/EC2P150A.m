EC2P150A ;ALB/TXH - EC National Procedure Update; Apr 27, 2020@14:12
 ;;2.0;EVENT CAPTURE;**150**;May 8, 1996;Build 5
 ;
 ;This routine is used as a post-init in a KIDS build
 ;to update the EC National Procedure file (#725).
 ;
 Q
 ;
PRETRAN ;Load Inactivate Code table into KIDS build
 ;
 M @XPDGREF@("ECDATA")=^XTMP("ECDATA")
 Q
 ;
POST ;Post installation processes
 ;
 I $G(DUZ("AG"))'="V" Q  ;do not install in non-VA environments
 D LOADIACT              ;Load gold inactivate codes into XTMP
 I +$G(XPDQUIT) Q        ;abort installation if error loading table
 ;
 D MES^XPDUTL("Updating the EC NATIONAL PROCEDURE File (#725)...")
 D MES^XPDUTL(" ")
 ;
 ;* add new/edit national procedures
 D ADDPROC^EC2P150B  ;add new procedures
 D NAMECHG^EC2P150B  ;change description
 D CPTCHG^EC2P150C   ;change CPT code
 D INACT^EC2P150C    ;inactivate code
 ;
 ;create task to inspect event code screens
 D BMES^XPDUTL("Queuing the inspection of the EC Event Code Screens file (#720.3)")
 D MES^XPDUTL("for 09/02/2020 at 1:00 AM. If this patch is installed after that")
 D MES^XPDUTL("time, the inspection will queue immediately.")
 D MES^XPDUTL(" ")
 ;
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSK
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=3200902.0100
 S ZTDESC="Inspecting EC Event Code Screens file",ZTIO="" D ^%ZTLOAD
 ;
 D MES^XPDUTL("Done. Task: "_$G(ZTSK)_" has been created for this job. You")
 D MES^XPDUTL("will receive a MailMan message with the results on 09/02/2020.")
 D MES^XPDUTL(" ")
 ;
 D MES^XPDUTL("Update of EC NATIONAL PROCEDURE file (#725) completed.")
 D MES^XPDUTL(" ")
 Q
 ;
LOADIACT ;Put gold codes in local XTMP
 ;
 K ^XTMP("ECDATA")
 M ^XTMP("ECDATA")=@XPDGREF@("ECDATA")
 I '$D(^XTMP("ECDATA")) D BMES^XPDUTL("Gold inactivate code table not loaded - INSTALLATION ABORTED") S XPDQUIT=2 Q
 ; Set auto-delete date from XTMP global
 S ^XTMP("ECDATA",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^Patch EC*2.0*150 Gold Inactivate Codes"
 Q
