DG531067P ;ALB/JAM - PATCH DG*5.3*1067 PRE/POST-INSTALL ROUTINE ;17 November 2021 10:00 AM
 ;;5.3;Registration;**1067**;Aug 13, 1993;Build 23
 ; ICRs:
 ; Reference to BMES^XPDUTL supported by ICR #10141
 ; Reference to MES^XPDUTL supported by ICR #10141
 ; Reference to EN^XPAR supported by ICR #2263 
 ; Reference to DIEZ^DIKCUTL3 support by ICR #3352 
 ;
 Q
PRE ; PRE INSTALL Main entry point
 ; Rename VHAPs
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1067 Pre-install routine")
 D BMES^XPDUTL("Updating the HEALTH BENEFIT PLAN file (#25.11)...")
 ; Rename ACTIVE DUTY AND TRICARE SHARING AGREEMENT to TRICARE
 D PRE1
 ; Rename VA DOD DIRECT RESOURCE SHARING AGREEMENTS to VA DOD SHARING MEDICAL RESOURCES
 D PRE2
 ; Rename BENEFICIARY CHAMPVA to CHAMPVA STANDARD
 D PRE3
 ; Rename VETERAN BENEFICIARY PLAN - CAMP LEJEUNE FAMILY to CAMP LEJEUNE FAMILY
 D PRE4
 D BMES^XPDUTL(">>> DG*5.3*1067 Pre-install completed")
 Q
PRE1 ; Rename "ACTIVE DUTY AND TRICARE SHARING AGREEMENT" to "TRICARE"
 N DGOLDNAME,DGIEN,DGDATA,DGSD,DGERR
 S DGOLDNAME="ACTIVE DUTY AND TRICARE SHARING AGREEMENT"
 S DGIEN=$O(^DGHBP(25.11,"B",DGOLDNAME,0))
 I 'DGIEN  D MES^XPDUTL("ACTIVE DUTY AND TRICARE SHARING AGREEMENT not found - no action needed.") Q
 ; Rename the old plan to the new plan name and change Short Desc field 
 S DGDATA(.01)="TRICARE"
 I $$UPD^DGENDBS(25.11,.DGIEN,.DGDATA,.DGERR) D
 . D MES^XPDUTL("ACTIVE DUTY AND TRICARE SHARING AGREEMENT (ADTSA) plan renamed to")
 . D MES^XPDUTL("TRICARE")
 I $G(DGERR)'="" D
 . D BMES^XPDUTL("**** Error updating the ACTIVE DUTY AND TRICARE SHARING AGREEMENT (ADTSA) plan.")
 . D MES^XPDUTL(">>> Error: "_DGERR)
 . D MES^XPDUTL(">>> DG*5.3*1067 Pre-install Routine Failed.")
 . D MES^XPDUTL("    - Installation Terminated.")
 . D MES^XPDUTL("    - Transport global removed from system.")
 . S XPDABORT=1
 Q
 ;
PRE2 ; Rename "VA DOD DIRECT RESOURCE SHARING AGREEMENTS" to "VA DOD SHARING MEDICAL RESOURCES"
 N DGOLDNAME,DGIEN,DGDATA,DGSD,DGERR
 S DGOLDNAME="VA DOD DIRECT RESOURCE SHARING AGREEMENTS"
 S DGIEN=$O(^DGHBP(25.11,"B",DGOLDNAME,0))
 I 'DGIEN  D MES^XPDUTL("VA DOD DIRECT RESOURCE SHARING AGREEMENTS not found - no action needed.") Q
 ; Rename the old plan to the new plan name
 S DGDATA(.01)="VA DOD SHARING MEDICAL RESOURCES"
 I $$UPD^DGENDBS(25.11,.DGIEN,.DGDATA,.DGERR) D
 . D MES^XPDUTL("VA DOD DIRECT RESOURCE SHARING AGREEMENTS plan renamed to")
 . D MES^XPDUTL("VA DOD SHARING MEDICAL RESOURCES")
 I $G(DGERR)'="" D
 . D BMES^XPDUTL("**** Error updating the VA DOD DIRECT RESOURCE SHARING AGREEMENTS plan.")
 . D MES^XPDUTL(">>> Error: "_DGERR)
 . D MES^XPDUTL(">>> DG*5.3*1067 Pre-install Routine Failed.")
 . D MES^XPDUTL("    - Installation Terminated.")
 . D MES^XPDUTL("    - Transport global removed from system.")
 . S XPDABORT=1
 Q
 ;
PRE3 ; Rename "BENEFICIARY CHAMPVA" to "CHAMPVA STANDARD"
 N DGOLDNAME,DGIEN,DGDATA,DGSD,DGERR
 S DGOLDNAME="BENEFICIARY CHAMPVA"
 S DGIEN=$O(^DGHBP(25.11,"B",DGOLDNAME,0))
 I 'DGIEN  D MES^XPDUTL("BENEFICIARY CHAMPVA not found - no action needed.") Q
 ; Rename the old plan to the new plan name and change Short Desc field 
 S DGDATA(.01)="CHAMPVA STANDARD"
 I $$UPD^DGENDBS(25.11,.DGIEN,.DGDATA,.DGERR) D
 . D MES^XPDUTL("BENEFICIARY CHAMPVA plan renamed to")
 . D MES^XPDUTL("CHAMPVA STANDARD")
 I $G(DGERR)'="" D
 . D BMES^XPDUTL("**** Error updating the BENEFICIARY CHAMPVA plan.")
 . D MES^XPDUTL(">>> Error: "_DGERR)
 . D MES^XPDUTL(">>> DG*5.3*1067 Pre-install Routine Failed.")
 . D MES^XPDUTL("    - Installation Terminated.")
 . D MES^XPDUTL("    - Transport global removed from system.")
 . S XPDABORT=1
 Q
 ;
PRE4 ; Rename "VETERAN BENEFICIARY PLAN - CAMP LEJEUNE FAMILY" to "CAMP LEJEUNE FAMILY"
 N DGOLDNAME,DGIEN,DGDATA,DGSD,DGERR
 S DGOLDNAME="VETERAN BENEFICIARY PLAN - CAMP LEJEUNE FAMILY"
 S DGIEN=$O(^DGHBP(25.11,"B",DGOLDNAME,0))
 I 'DGIEN  D MES^XPDUTL("VETERAN BENEFICIARY PLAN - CAMP LEJEUNE FAMILY not found - no action needed.") Q
 ; Rename the old plan to the new plan name and change Short Desc field 
 S DGDATA(.01)="CAMP LEJEUNE FAMILY"
 I $$UPD^DGENDBS(25.11,.DGIEN,.DGDATA,.DGERR) D
 . D MES^XPDUTL("VETERAN BENEFICIARY PLAN - CAMP LEJEUNE FAMILY plan renamed to")
 . D MES^XPDUTL("CAMP LEJEUNE FAMILY")
 I $G(DGERR)'="" D
 . D BMES^XPDUTL("**** Error updating the VETERAN BENEFICIARY PLAN - CAMP LEJEUNE FAMILY plan.")
 . D MES^XPDUTL(">>> Error: "_DGERR)
 . D MES^XPDUTL(">>> DG*5.3*1067 Pre-install Routine Failed.")
 . D MES^XPDUTL("    - Installation Terminated.")
 . D MES^XPDUTL("    - Transport global removed from system.")
 . S XPDABORT=1
 Q
 ;
POST ; Main entry point for post-install 
 ;
 D BMES^XPDUTL(">>> Patch DG*5.3*1067 - Post-install started.")
 ; Set the DG PATCH DG*5.3*1067 ACTIVE parameter to the timestamp in the PARAMETERS file (#8989.5)
 D POST1
 D POST2
 D POST3
 D BMES^XPDUTL(">>> Patch DG*5.3*1067 - Post-install complete.")
 Q
POST1 ; Set the parameter to Date/Time
 N DGERR
 D BMES^XPDUTL(" o Setting parameter instance DG PATCH DG*5.3*1067 ACTIVE in the")
 D MES^XPDUTL("   PARAMETER (#8989.5) file to date/time value of Feb 26, 2022@1700")
 D EN^XPAR("PKG","DG PATCH DG*5.3*1067 ACTIVE",1,3220226.1700,.DGERR)
 I $G(DGERR) D
 . D BMES^XPDUTL(" *** Parameter set failed: "_DGERR)
 . D MES^XPDUTL("  Please log YOUR IT Services ticket. ***")
 Q
 ;
POST2 ; Set the DG UAM API KEY parameter PROHIBIT EDITING (#.06) to 1 (YES)
 N DGPARAM,DGUAMKEY,DGERR
 ; Get the IEN of the Parameter Definition DG UAM API KEY
 S DGPARAM=$$FIND1^DIC(8989.51,,"B","DG UAM API KEY")
 Q:'DGPARAM
 D BMES^XPDUTL(" o Setting parameter definition DG UAM API KEY in the PARAMETER")
 D MES^XPDUTL("   DEFINITION (#8989.51) file to prohibit editing")
 ; Set PROHIBIT EDITING (#.06) field to 1
 S DGUAMKEY(8989.51,DGPARAM_",",.06)=1
 D FILE^DIE("","DGUAMKEY","DGERR")
 I $G(DGERR) D
 . D BMES^XPDUTL(" *** Parameter set failed: "_DGERR)
 . D MES^XPDUTL("  Please log YOUR IT Services ticket. ***")
 Q
POST3 ; Recompile all input templates for fields that were modified
 N DGFLD
 D BMES^XPDUTL(" o Recompile all compiled input templates that contain the following fields:")
 D MES^XPDUTL("    PATIENT file(#2): ")
 D MES^XPDUTL("    o K-RELATIONSHIP TO PATIENT field (#.212)")
 D MES^XPDUTL("    o K2-RELATIONSHIP TO PATIENT field (#.2192)")
 D MES^XPDUTL("    o E-RELATIONSHIP TO PATIENT field (#.332)")
 D MES^XPDUTL("    o E2-RELATIONSHIP TO PATIENT field (#.3312)")
 D MES^XPDUTL("    o D-RELATIONSHIP TO PATIENT field (#.342)")
 D MES^XPDUTL("    o RELIGIOUS PREFERENCE field (#.08)")
 D MES^XPDUTL("    o RACE INFORMATION field (#.01) of the RACE INFORMATION subfile (#2.02)")
 D MES^XPDUTL("    o ETHNICITY INFORMATION field (#.01) of the")
 D MES^XPDUTL("       ETHNICITY INFORMATION subfile (#2.06)")
 ;
 ;build array of file and field numbers for top-level file and fields being exported
 ;array format: DGFLD(file#,field)=""
 ;recompile all compiled input templates that contain the fields in the DGLFD array passed by reference
 ; PATIENT file #2
 S DGFLD(2,.212)=""
 S DGFLD(2,.2192)=""
 S DGFLD(2,.332)=""
 S DGFLD(2,.3312)=""
 S DGFLD(2,.342)=""
 S DGFLD(2,.08)=""
 S DGFLD(2.02,.01)=""
 S DGFLD(2.06,.01)=""
 D DIEZ^DIKCUTL3(2,.DGFLD)
 Q
