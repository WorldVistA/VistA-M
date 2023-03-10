DG531018P ;ALB/JAM - DG*5.3*1018 POST-INSTALL ROUTINE ;12/03/20 9:49am
 ;;5.3;Registration;**1018**;Aug 13, 1993;Build 5
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;         3352 : Provides the use of DIEZ^DIKCUTL3 to recompile all compiled input templates that contain specific fields.
 ;
 ; This post-install does the following:
 ;  - Set the BWN ACTIVE DATE field #1402 in the MAS PARAMETERS file #43
 ;  - Compiles all input templates that include the AGENT ORANGE EXPOSURE LOCATION field #.3213 (in the PATIENT file #2)
 Q
 ;
EN ; Entry point for post-install
 D BMES^XPDUTL(">>> Patch DG*5.3*1018 - Post-install begin...")
 N DGFDA,DGERR,X,Y
 ;
 D BMES^XPDUTL("   o Set BWN ACTIVE DATE (#1402) field in MAS PARAMETERS (#43) file")
 ; Set the active date (For readability, get internal date from external)
 S X="05/10/2021"
 D ^%DT
 S DGFDA(43,"1,",1402)=Y
 D FILE^DIE("","DGFDA","DGERR")
 I '$D(DGERR) D MES^XPDUTL("   o BWN ACTIVE DATE (#1402) field set to "_$$GET1^DIQ(43,1,1402))
 I $D(DGERR) D
 . D BMES^XPDUTL("   *** ERROR: "_DGERR("DIERR",1,"TEXT",1))
 . D MES^XPDUTL("    Please log YOUR IT Services ticket. ***")
 ;
 N DGFLD
 D BMES^XPDUTL("   o Recompile all compiled input templates that contain field:")
 D MES^XPDUTL("   - AGENT ORANGE EXPOSURE LOCATION (#.3213) field in PATIENT (#2) file")
 ;build array of file and field numbers for top-level (#2) file fields being exported
 ;array format: DGFLD(file#,field)=""
 S DGFLD(2,.3213)=""
 ;recompile all compiled input templates that contain the fields in the DGLFD array passed by reference
 D DIEZ^DIKCUTL3(2,.DGFLD)
 ;
 D BMES^XPDUTL(">>> Patch DG*5.3*1018 - Post-install complete.")
 Q
