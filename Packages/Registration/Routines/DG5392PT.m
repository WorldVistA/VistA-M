DG5392PT ;ALB/MLI - post-install for DG*5.3*92 ; 4/17/96
 ;;5.3;Registration;**92**;Aug 13, 1993
 ;
 ; This routine will be run as a post-installation for patch
 ; DG*5.3*92.  It will automatically set the MAKE RECORD
 ; SENSITIVE? field in the ELIGIBILITY CODE file for all
 ; employee type eligibilities
 ;
EN ; begin processing
 N DA,DIE,DR,ELIG,X,Y
 D BMES^XPDUTL(">>> Updating MAKE RECORD SENSITIVE flag in ELIGIBILITY CODE")
 D MES^XPDUTL("    file for EMPLOYEE eligibilities..."),MES^XPDUTL(" ")
 S ELIG="",DIE="^DIC(8,",DR=".12////1"
 F  S ELIG=$O(^DIC(8,"D",14,ELIG)) Q:'ELIG  D
 .  S DA=ELIG
 .  D ^DIE
 .  D MES^XPDUTL("    "_$P($G(^DIC(8,ELIG,0)),"^",1)_" eligiblity updated")
