DG531140P ;ALB/JAM - PATCH DG*5.3*1140 INSTALL UTILITIES ;2/25/25 09:12am
 ;;5.3;Registration;**1140**;Aug 13, 1993;Build 10
 ;
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to MES^XPDUTL in ICR #10141
 ;
 ;No direct entry
 QUIT
 ;
 ;--------------------------------------------------------------------------
 ;Patch DG*5.3*1140: Environment, Pre-Install, and Post-Install entry points.
 ;--------------------------------------------------------------------------
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1140 Pre-install routine...")
 D PRE1
 D BMES^XPDUTL(">>> Patch DG*5.3*1140 Pre-install complete.")
 Q
 ;
PRE1 ; Rename VHAP "VFMP MEDS BY MAIL ELIGIBILITY" to "MEDS BY MAIL BENEFICIARY"
 ; Change Short Description to "MbM Rx"
 D BMES^XPDUTL("  - Updating the HEALTH BENEFIT PLAN file (#25.11)...")
 D MES^XPDUTL("  - Renaming VFMP MEDS BY MAIL ELIGIBILITY plan.")
 N DGOLDNAME,DGNEWNAME,DGIEN,DGDATA,DGERR
 S DGOLDNAME="VFMP MEDS BY MAIL ELIGIBILITY"
 S DGNEWNAME="MEDS BY MAIL BENEFICIARY"
 D CHKDUP
 S DGIEN=$O(^DGHBP(25.11,"B",DGOLDNAME,0))
 I 'DGIEN  D MES^XPDUTL("  - "_DGOLDNAME_" does not exist... No action required.") Q
 ; Rename the old plan to the new plan name 
 S DGDATA(.01)=DGNEWNAME
 I $$UPD^DGENDBS(25.11,.DGIEN,.DGDATA,.DGERR) D  Q
 . D BMES^XPDUTL("  - "_DGOLDNAME_" plan renamed to")
 . D MES^XPDUTL("    "_DGNEWNAME)
 I $G(DGERR)'="" D
 . D MES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("   - The "_DGOLDNAME_" plan was not updated.")
 . D MES^XPDUTL("   - Error: "_DGERR)
 . D MES^XPDUTL("   - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("     for assistance.")
 . D MES^XPDUTL(">>> DG*5.3*1140 Pre-install Routine Failed.")
 . D MES^XPDUTL("   - Installation Terminated.")
 . D MES^XPDUTL("   - Transport global removed from system.")
 . S XPDABORT=1
 Q
 ;
CHKDUP ; Check for the case of both old and new name plan exist
 ; Check if the new VHAP name already exists 
 D BMES^XPDUTL("  check for Duplicate "_DGOLDNAME_" "_DGNEWNAME)
 S DGIEN=$O(^DGHBP(25.11,"B",DGNEWNAME,0))
 ; If it doesn't exist, quit
 I 'DGIEN Q
 ; Check if the old name VHAP also exists
 S DGIEN=$O(^DGHBP(25.11,"B",DGOLDNAME,0))
 ; Old name is gone - quit
 I 'DGIEN Q
 ; The old and new name VHAP entries both exist - Delete the old name entry
 S DGDATA(.01)="@"
 I $$UPD^DGENDBS(25.11,.DGIEN,.DGDATA,.DGERR) D  Q
 . D BMES^XPDUTL("  - Duplicate "_DGOLDNAME_" removed.")
 E  D
 . D MES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("   - The duplicate "_DGOLDNAME_" plan was not removed.")
 . D MES^XPDUTL("   - Error: "_DGERR)
 . D MES^XPDUTL("   - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("     for assistance.")
 . D MES^XPDUTL(">>> DG*5.3*1140 Pre-install Routine Failed.")
 . D MES^XPDUTL("   - Installation Terminated.")
 . D MES^XPDUTL("   - Transport global removed from system.")
 . S XPDABORT=1
 Q
 ;
POST ;Main entry point for Post-Install items
 ;
 Q
