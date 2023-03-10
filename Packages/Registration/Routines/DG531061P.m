DG531061P ;ALB/JAM - DG*5.3*1061 INSTALL UTILITY;07/12/2021 15:21pm
 ;;5.3;Registration;**1061**;Feb 23 2021;Build 22
 ;
QUIT ;No direct entry
 ;
 ;---------------------------------------------------------------------------
 ;Patch DG*5.3*1061: Environment, Pre-Install, and Post-Install entry points.
 ;---------------------------------------------------------------------------
 ;
 ; ICR:  10141 : BMES^XPDUTL
 ;             : MES^XPDUTL
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1061 Pre-install routine...")
 ;
 ; Remove non-SAC compliant triggers from MAS ELIGIBILITY CODE field (#8) of ELIGIBILITY CODE file (#8)
 D BMES^XPDUTL("*** Removing non-SAC compliant triggers from MAS ELIGIBILITY CODE")
 D MES^XPDUTL("    field (#8) of the ELIGIBILITY CODE file (#8).")
 ;
 ; Delete trigger cross references 2, 3, 4 and 5 in the MAS ELIGBILITY CODE field (#8) in ELIGIBILITY CODE file (#8)
 N DGXREF,DGXREFNM
 F DGXREF=2:1:5 D
 . D DELIX^DDMOD(8,8,DGXREF)
 . S DGXREFNM=$S(DGXREF=2:"CARD COLOR",DGXREF=3:"VA CODE NUMBER",DGXREF=4:"TYPE",DGXREF=5:"SELECT AS ADDITIONAL",1:"")
 . D MES^XPDUTL("*** Trigger cross reference for field '"_DGXREFNM_"' removed.")
 ;
 D BMES^XPDUTL(">>> Patch DG*5.3*1061 - Pre-install complete.")
 Q
 ;
POST ;Main entry point for Post-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1061 Post-install routine...")
 D POST1
 D POST2
 D BMES^XPDUTL(">>> Patch DG*5.3*1061 - Post-install complete.")
 Q
 ;
POST1 ; Add COMPACT ACT ELIGIBLE eligibility to file #8
 NEW DGEC,DGPH,DGFDA,DGERR
 S DGEC="COMPACT ACT ELIGIBLE"
 D BMES^XPDUTL("*** Adding 'COMPACT ACT ELIGIBLE' to the ELIGIBILITY CODE file (#8).")
 S DGPH=$$FIND1^DIC(8.1,"","X",DGEC)
 I 'DGPH D  Q
 . D BMES^XPDUTL("*** WARNING!")
 . D MES^XPDUTL("  - COMPACT ACT ELIGIBLE entry missing from MAS ELIGIBILITY CODE file (#8.1)")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 I $$FIND1^DIC(8,"","X",DGEC) D  Q
 . D BMES^XPDUTL("*** COMPACT ACT ELIGIBLE entry already exists... No action required.")
 ; Add entry to file
 S DGFDA(8,"+1,",.01)=DGEC
 S DGFDA(8,"+1,",1)="BLUE"
 S DGFDA(8,"+1,",2)="CMPT"
 S DGFDA(8,"+1,",3)=12
 S DGFDA(8,"+1,",4)="N"
 S DGFDA(8,"+1,",5)=DGEC
 S DGFDA(8,"+1,",7)=1
 S DGFDA(8,"+1,",8)=DGEC
 S DGFDA(8,"+1,",9)="VA STANDARD"
 S DGFDA(8,"+1,",11)="VA"
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I '$D(DGERR) D BMES^XPDUTL("*** COMPACT ACT ELIGIBLE successfully added to ELIGIBILITY CODE file (#8).")
 I $D(DGERR) D
 . D BMES^XPDUTL("*** COMPACT ACT ELIGIBLE was NOT successfully added to the ELIGIBILITY CODE file (#8).")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 Q
 ;
POST2 ; Add SPECIAL TX AUTHORITY CARE eligibility to file #8
 NEW DGEC,DGPH,DGFDA,DGERR
 S DGEC="SPECIAL TX AUTHORITY CARE"
 D BMES^XPDUTL("*** Adding 'SPECIAL TX AUTHORITY CARE' to the ELIGIBILITY CODE file (#8).")
 S DGPH=$$FIND1^DIC(8.1,"","X",DGEC)
 I 'DGPH D  Q
 . D BMES^XPDUTL("*** WARNING!")
 . D MES^XPDUTL("  - SPECIAL TX AUTHORITY CARE entry missing from the")
 . D MES^XPDUTL("    MAS ELIGIBILITY CODE file (#8.1)")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 I $$FIND1^DIC(8,"","X",DGEC) D  Q
 . D BMES^XPDUTL("*** SPECIAL TX AUTHORITY CARE entry already exists... No action required.")
 ; Add entry to file
 S DGFDA(8,"+1,",.01)=DGEC
 S DGFDA(8,"+1,",1)="BLUE"
 S DGFDA(8,"+1,",2)="STAC"
 S DGFDA(8,"+1,",3)=12
 S DGFDA(8,"+1,",4)="N"
 S DGFDA(8,"+1,",5)=DGEC
 S DGFDA(8,"+1,",7)=1
 S DGFDA(8,"+1,",8)=DGEC
 S DGFDA(8,"+1,",9)="VA STANDARD"
 S DGFDA(8,"+1,",11)="VA"
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I '$D(DGERR) D
 . D BMES^XPDUTL("*** SPECIAL TX AUTHORITY CARE successfully added to the")
 . D MES^XPDUTL("     ELIGIBILITY CODE file (#8).")
 I $D(DGERR) D
 . D BMES^XPDUTL("*** SPECIAL TX AUTHORITY CARE was NOT successfully added to the")
 . D MES^XPDUTL("     ELIGIBILITY CODE file (#8).")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 Q
