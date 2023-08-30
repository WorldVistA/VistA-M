ECX3P186 ;MNTVBB/DMR - NATIONAL CLINIC (#728.441) File Update; FEB 1, 2023@14:42
 ;;3.0;DSS EXTRACTS;**186**;Dec 22, 1997;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Post-init routine updating entries in the NATIONAL CLINIC (#728.441)
 ; file for FY23 Mid-Year.
 ;
 ; Reference(s) to $$FIND1^DIC supported by ICR# 2051
 ; Reference(s) to FILE^DIE supported by ICR# 2053
 ; Reference(s) to UPDATE^DIE supported by ICR# 2053
 ; Reference(s) to BMES^XPDUTL supported by ICR# 10141
 ; Reference(s) to MES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
POST ;routine entry point
 ;
 D BMES^XPDUTL("Update NATIONAL CLINIC (#728.441) file starts.")
 D ADD    ;add new code
 D UPDATE ;change short description of existing clinic codes
 D BMES^XPDUTL("Update complete.")
 D MES^XPDUTL("")
 ;
 Q
 ;
ADD ; Add new code
 ;
 N ECXI,ECXREC,ECXNM,ECXCODE,ECXIEN,ECXERR
 D BMES^XPDUTL(">>> Adding new CHAR4 code(s) to the NATIONAL CLINIC file (#728.441)...")
 ;
 F ECXI=1:1 S ECXREC=$P($T(ADDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
 . S ECXNM=$P(ECXREC,U)     ;Name
 . S ECXCODE=$P(ECXREC,U,2) ;Code
 . ; check if new code already exists in file 728.441
 . S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ECXERR")
 . ; quit if error
 . I $D(ECXERR) D  Q
 . . D BMES^XPDUTL("       >> ... Unable to add CHAR4 code "_ECXCODE_" - "_ECXNM_" to file.")
 . . D MES^XPDUTL("        >> ... "_$G(ECXERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("        >> ... Please contact support for assistance...")
 . . K ECXERR
 . ; if code already exists, quit
 . I ECXIEN D  Q
 . . D BMES^XPDUTL("    >> CHAR4 code "_ECXCODE_" - "_ECXNM_" already exists.")
 . ; if code does not exist, add new entry
 . ; set field values of new entry
 . K ECXFDA
 . S ECXFDA(728.441,"+1,",.01)=ECXCODE
 . S ECXFDA(728.441,"+1,",1)=ECXNM
 . ; add new entry
 . D UPDATE^DIE("E","ECXFDA","","ECXERR")
 . ; check if error
 . I '$D(ECXERR) D
 . . D BMES^XPDUTL("    >> CHAR4 Code "_ECXCODE_" - "_ECXNM_" added to file.")
 . I $D(ECXERR) D
 . . D BMES^XPDUTL("    >> ... Unable to add CHAR4 code "_ECXCODE_" "_ECXNM_" to file.")
 . . D MES^XPDUTL("    >> ... "_$G(ECXERR("DIERR",1,"TEXT",1))_".")
 . . D MES^XPDUTL("    >> ... Please contact support for assistance.")
 . . ; clean out error array b4 processing next code
 . . K ECXERR
 ;
 D BMES^XPDUTL(">>> Add new CHAR4 code(s) complete.")
 D MES^XPDUTL("")
 Q
 ;
UPDATE ;changing short description of existing entries
 ;ECXREC is in format: code^short description
 ;
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI,ECXREC,ECXERR
 ;
 D BMES^XPDUTL(">>> Updating entries in the NATIONAL CLINIC (728.441) file...")
 ;
 F ECXI=1:1 S ECXREC=$P($T(UPDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
  .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
  .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ECXERR")
  .I 'ECXIEN D  Q
  ..D BMES^XPDUTL(">>>....Unable to find code: "_ECXCODE_".")
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
  .K FDA
  .S FDA(728.441,ECXIEN_",",1)=ECXDESC
  .D FILE^DIE(,"FDA","ECXERR")
  .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_" - "_$P(ECXREC,U,2)_" updated")
  .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to update code "_ECXCODE_".") D
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
 ;
 Q
 ;
ADDCLIN ;Add new code
 ;;QUIT
 ;
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;CGEC^CRH Environmental Registry
 ;;CGLC^Long COVID Care
 ;;CGTC^Care Coordination Review Team (CCRT)
 ;;COLL^Primary Care MH Integration CoCM
 ;;DEAC^Inpatient Pharmacist Anticoagulation Clinic
 ;;DEBC^CRH Long COVID
 ;;DEDC^CRH Low Vision OD
 ;;DEEC^CRH BROS/CATIS
 ;;DEFC^CRH BRS
 ;;DEGC^Inpatient Geriatrics Pharmacist
 ;;DELC^CRH VIST
 ;;DEMC^CRH Registered Dietician
 ;;DENC^CRH Registered Audiologist
 ;;DEPC^PACT Pharmacy Clinics
 ;;HDMC^Telemental Health Home Hospice
 ;;HDPC^Inpatient Mental Health Pharmacist
 ;;IDEC^Inpatient Pharmacist Antimicrobial Stewardship
 ;;IDFC^Inpatient Pharmacist Cardiology Clinic
 ;;IDGC^Inpatient Pharmacist Critical Care Clinic
 ;;IDJC^Inpatient Pharmacist General MTM Services Clinic
 ;;IDKC^Inpatient Pharmacist Infectious Disease Clinic
 ;;IDLC^Inpatient Pharmacist Internal Medicine Clinic
 ;;IDPC^Inpatient Meds Reconciliation/Discharge Counseling
 ;;IDQC^Inpatient Pharmacist Nutrition Support Clinic
 ;;IDRC^Inpatient Pharmacist Oncology Clinic
 ;;IDUC^Inpatient Pharmacist Pharmacokinetics
 ;;IDVC^Inpatient Pharmacist Spinal Cord Injury Clinic
 ;;IDWC^Inpatient Pharmacist Surgery Clinic
 ;;MPAX^Monkey Pox Vaccination Clinics
 ;;POPP^Mental Health Integration CoCM
 ;;XYEL^Integrated Mental Health for Specialty Clinics
 ;;QUIT
