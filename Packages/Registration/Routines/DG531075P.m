DG531075P ;ALB/JAM - DG*5.3*1075 INSTALL UTILITY;07/12/2021 15:21pm
 ;;5.3;Registration;**1075**;Jan 26 2022;Build 13
 ;
QUIT ;No direct entry
 ;
 ;---------------------------------------------------------------------------
 ;Patch DG*5.3*1075: Environment, Pre-Install, and Post-Install entry points.
 ;---------------------------------------------------------------------------
 ;
 ; Reference to DIEZ^DIKCUTL3 supported by ICR #3352 
 ; Reference to BMES^XPDUTL supported by ICR #10141
 ; Reference to MES^XPDUTL supported by ICR #10141
 ; Reference to DELIX^DDMOD supported by ICR #2916
 ;
 ; This routine is also used as an Environmental Check routine, though it does nothing except make the HELP
 ;  tag below available for the Installation question in the build.
 Q
 ;
HELP ; Help for ?? on Installation Question POS1 (use direct writes in env check routine)
 W !,"Enter 1 if patch is being installed in a Pre-Production (Mirror) system."
 W !,"Enter 2 if patch is being installed in a Software Quality Assurance system."
 W !,"Enter 3 if patch is being installed in a Development system."
 Q
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1075 Pre-install routine...")
 D PRE1
 D BMES^XPDUTL(">>> Patch DG*5.3*1075 - Pre-install complete.")
 Q
 ;
PRE1 ; ;Remove non-SAC compliant trigger on ELIGIBILITY field #.01 of PATIENT ELIGIBILITIES subfile #361 for PATIENT file #2
 ; ^^TRIGGER^2.0361^.03 
 ;  The patch DG*5.3*1075 will replace this with an updated trigger
 ;
 D BMES^XPDUTL(" o Removing non-SAC compliant trigger on ELIGIBILITY (#.01) field")
 D MES^XPDUTL("   of the PATIENT ELIGIBILITIES (#361) subfile")
 D MES^XPDUTL("   of the PATIENT (#2) file")
 N DGFILE,DGFIELD,DGREF
 S DGFILE=2.0361,DGFIELD=.01,DGREF=3
 D DELIX^DDMOD(DGFILE,DGFIELD,DGREF)
 Q
POST ;Main entry point for Post-Install items
 ;
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1075 Post-install routine...")
 D POST1
 D POST2
 D POST3
 D POST4
 D BMES^XPDUTL(">>> Patch DG*5.3*1075 - Post-install complete.")
 Q
 ;
POST1 ; Modify port/host DG EE SUMMARY SERVER and SEVICE
 ; ICRs:
 ;         7190 : Read access to file 18.02
 ;         7191 : R/W access to file 18.12
 ;
 N DGSRVR,DGIEN
 D BMES^XPDUTL(" o Modify DG EE SUMMARY SERVER Endpoint and Port...")
 S DGSRVR="DG EE SUMMARY SERVER"
 ; Get the IEN of the DG EE SUMMARY SERVER - if not found, notify user of the problem
 S DGIEN=$$FIND1^DIC(18.12,,"B",DGSRVR)
 I 'DGIEN D  Q
 . D BMES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("  - DG EE SUMMARY SERVER missing from WEB SERVER file (#18.12)")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 ; Set the DG EE SUMMARY SERVER to DISABLED so the update of the server won't cause errors
 ; The patch installation will set it back to ENABLED.
 D DISABLE(DGIEN)
 ; Modify the server
 D SERVER(DGIEN)
 Q
 ;
SERVER(DGIEN) ; Modify the web server
 N DGEXIT,DGTYPE,DGCOUNT,DGEPT,DGPORT,DGDATA
 N DGIENS,DGSERVER,DGERR12,DGSERVICE
 ; Get the site type entered in the Installation question POS1
 S DGTYPE=$G(XPDQUES("POS1"))
 ; DGTYPE will be a value of 1-3 (PRE-PROD, SQA, DEVELOPMENT) (if no value, this is a PRODUCTION system, set to 4)
 I 'DGTYPE S DGTYPE=4
 D BMES^XPDUTL(" o Setting up the server for "_$S(DGTYPE=1:"PRE-PROD",DGTYPE=2:"SQA",DGTYPE=3:"DEVELOPMENT",1:"PRODUCTION")_".")
 S DGEXIT=0
 ; Get the matching endpoint and port for the site type
 F DGCOUNT=1:1 S DGDATA=$P($T(TYPEMAP+DGCOUNT),";;",2) D  Q:DGEXIT
 . I $P(DGDATA,";",1)=DGTYPE S DGEPT=$P(DGDATA,";",3),DGPORT=$P(DGDATA,";",4),DGEXIT=1
 S DGIENS=DGIEN_","
 ; PORT
 S DGSERVER(18.12,DGIENS,.03)=DGPORT
 ; SERVER endpoint
 S DGSERVER(18.12,DGIENS,.04)=DGEPT
 ; STATUS
 ; For Pre-Prod, set Status to disabled, otherwise, enable
 S DGSERVER(18.12,DGIENS,.06)=$S(DGTYPE=1:0,1:1)
 ; SSL PORT
 S DGSERVER(18.12,DGIENS,3.03)=DGPORT
 ;
 D FILE^DIE("","DGSERVER","DGERR12")    ; update existing entry
 I '$D(DGERR12("DIERR",1,"TEXT",1)) D
 . I $S(DGTYPE=1:0,1:1) D BMES^XPDUTL(" o '"_DGSRVR_"' server enabled.")
 . D BMES^XPDUTL(" o WEB SERVER '"_DGSRVR_"' update succeeded.")
 I $D(DGERR12("DIERR",1,"TEXT",1)) D BMES^XPDUTL(" o WEB SERVER '"_DGSRVR_"' Error: "_DGERR12("DIERR",1,"TEXT",1)) Q
 Q
 ;
DISABLE(DGIEN) ; Get the DG EE SUMMARY server IEN and disable it - update of server will set it back to enabled (except for Pre-prod)
 N DGSERVER,DGERR12
 ; Set STATUS to DISABLED
 S DGSERVER(18.12,DGIEN_",",.06)=0
 D FILE^DIE("","DGSERVER","DGERR12")    ; update existing entry
 D BMES^XPDUTL(" o '"_DGSRVR_"' server disabled.")
 Q
 ;
POST2 ; Set the parameter to Date/Time
 N DGERR
 D BMES^XPDUTL(" o Setting parameter instance DG PATCH DG*5.3*1075 ACTIVE in the")
 D MES^XPDUTL("   PARAMETER (#8989.5) file to date/time value of Aug 3, 2022@1700")
 D EN^XPAR("PKG","DG PATCH DG*5.3*1075 ACTIVE",1,3220803.1700,.DGERR)
 I $G(DGERR) D
 . D BMES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("  - Parameter set failed: "_DGERR)
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 Q
 ;
POST3 ; Add HUD-VASH eligibility to file #8
 NEW DGEC,DGPH,DGFDA,DGERR
 S DGEC="HUD-VASH"
 D BMES^XPDUTL(" o Adding 'HUD-VASH' to the ELIGIBILITY CODE (#8) file.")
 S DGPH=$$FIND1^DIC(8.1,"","X",DGEC)
 I 'DGPH D  Q
 . D BMES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("  - HUD-VASH entry missing from MAS ELIGIBILITY CODE (#8.1) file")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 I $$FIND1^DIC(8,"","X",DGEC) D  Q
 . D BMES^XPDUTL("*** HUD-VASH entry already exists... No action required.")
 ; Add entry to file
 S DGFDA(8,"+1,",.01)=DGEC
 S DGFDA(8,"+1,",1)="RED"
 S DGFDA(8,"+1,",2)="HUDV"
 S DGFDA(8,"+1,",3)=13
 S DGFDA(8,"+1,",4)="N"
 S DGFDA(8,"+1,",5)=DGEC
 S DGFDA(8,"+1,",7)=1
 S DGFDA(8,"+1,",8)=DGEC
 S DGFDA(8,"+1,",9)="VA STANDARD"
 S DGFDA(8,"+1,",11)="VA"
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I '$D(DGERR) D BMES^XPDUTL(" o HUD-VASH successfully added to ELIGIBILITY CODE (#8) file.")
 I $D(DGERR) D
 . D BMES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("  - HUD-VASH was NOT successfully added to the ELIGIBILITY CODE (#8) file.")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 Q
 ;
POST4 ; Recompile all input templates for fields that were modified
 ; - ELIGIBILITY (#.01) field of the PATIENT ELIGIBILITIES (#361) subfile of the PATIENT (#2) file
 ;
 N DGFLD
 D BMES^XPDUTL(" o Recompile all compiled input templates that contain the following field:")
 D MES^XPDUTL("    PATIENT (#2) file: ")
 D MES^XPDUTL("    - ELIGIBILITY (#.01) field of the PATIENT ELIGIBILITIES (#361) subfile")
 ;
 ;build array of file and field numbers for top-level file and fields being exported
 ;array format: DGFLD(file#,field)=""
 ;recompile all compiled input templates that contain the fields in the DGLFD array passed by reference
 ; PATIENT file #2
 S DGFLD(2.0361,.01)=""
 D DIEZ^DIKCUTL3(2,.DGFLD)
 Q
 ;
TYPEMAP ;  Map the system type to the SERVER endpoint and Port values
 ;;1;PREPROD;prep.ves.domain.ext;443
 ;;2;SQA;sqa.ves.domain.ext;443
 ;;3;DEV;dev03.ves.domain.ext;443
 ;;4;PROD;ves.domain.ext;443
