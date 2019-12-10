ICD1897P ;ALB/JDG - CLUSTER UPDATE PRE-INIT;8/9/2019
 ;;18.0;DRG Grouper;**97**;Oct 20, 2000;Build 5
 ;
 Q
 ;
EN ; start update
 D PREINIT
 Q
 ;
PREINIT ; Patch Pre-Init: Delete DD and Data of DRG PROCEDURE GROUPS Subfile PROCEDURES (#83.61, 10)
 ; The Cluster Procedures are being moved from Node 10 to Node 20 of file #83.61.  
 ; The Cluster Attributes will be added at Node 10. The patch will load the new Attribute Data and DD at node 10.
 ; During the Pre-Init both the Data and the DD for node 10 must be deleted for clean-up.  
 ;
 D BMES^XPDUTL("Pre-Installation Updates: PREINIT^ICD1897P")
 D BMES^XPDUTL(">>> Delete DRG MDC CATEGORY (#83) file.")
 ;
 D DELDA
 ;
 D MES^XPDUTL(" Deletion of file complete. Will be updated during install.")
 ;
 D BMES^XPDUTL(">>> Delete DRG PROCEDURE GROUPS Subfile PROCEDURES (#83.61, 10).")
 ;
 D DELDD
 ;
 D MES^XPDUTL("    Deletion of sub-file complete. Will be updated during install.")
 D BMES^XPDUTL("Pre-Installation Updates Complete.")
 Q 
 ;
DELDD ; Delete DD and Data of DRG PROCEDURE GROUPS Subfile PROCEDURES (#83.61, 10)
 ;
 N DIU S DIU=83.6101,DIU(0)="DST" D EN^DIU2 K DIU
 Q
 ;
DELDA ; Delete Data in DRG MDC CATEGORY (#83) file
 ;
 S DIK="^ICDD(83," S DA=0 F  S DA=$O(^ICDD(83,DA)) Q:DA=0  D ^DIK
 Q
