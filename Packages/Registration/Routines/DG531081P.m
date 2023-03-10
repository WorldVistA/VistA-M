DG531081P ;OIT/ARF - PATCH DG*5.3*1081 INSTALL UTILITIES ;2/25/21 09:12am
 ;;5.3;Registration;**1081**;Aug 13, 1993;Build 4
 ;
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to MES^XPDUTL in ICR #10141
 ;
 ;No direct entry
 QUIT
 ;
 ;--------------------------------------------------------------------------
 ;Patch DG*5.3*1081: Environment, Pre-Install, and Post-Install entry points.
 ;--------------------------------------------------------------------------
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 Q
 ;
POST ;Main entry point for Post-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1081 Post-install routine...")
 D POST1
 D BMES^XPDUTL(">>> Patch DG*5.3*1081 Post-install complete.")
 Q
 ;
 ;
POST1 ; Add CLINICAL EVALUATION eligibility to file #8
 NEW DGEC,DGFDA,DGERR
 S DGEC="CLINICAL EVALUATION"
 D BMES^XPDUTL("  - Adding '"_DGEC_"' to the ELIGIBILITY CODE (#8) file.")
 I '$$FIND1^DIC(8.1,"","X",DGEC) D  Q
 . D BMES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("  - "_DGEC_" entry missing from MAS ELIGIBILITY CODE (#8.1) file")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 I $$FIND1^DIC(8,"","X",DGEC) D  Q
 . D BMES^XPDUTL("  - "_DGEC_" entry already exists... No action required.")
 ; Add entry to file
 S DGFDA(8,"+1,",.01)=DGEC
 S DGFDA(8,"+1,",.12)=0
 S DGFDA(8,"+1,",1)="RED"
 S DGFDA(8,"+1,",2)="CE"
 S DGFDA(8,"+1,",3)=14
 S DGFDA(8,"+1,",4)="N"
 S DGFDA(8,"+1,",5)=DGEC
 S DGFDA(8,"+1,",7)=1
 S DGFDA(8,"+1,",8)=DGEC
 S DGFDA(8,"+1,",9)="VA STANDARD"
 S DGFDA(8,"+1,",11)="VA"
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I '$D(DGERR) D BMES^XPDUTL("  - "_DGEC_" successfully added to ELIGIBILITY CODE (#8) file.")
 I $D(DGERR) D
 . D BMES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("  - "_DGEC_" was NOT successfully added to the ELIGIBILITY CODE (#8) file.")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 Q
