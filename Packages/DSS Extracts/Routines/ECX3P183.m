ECX3P183 ;MNT/TXH - NATIONAL CLINIC (#728.441) File Update; OCT 18, 2021@14:42
 ;;3.0;DSS EXTRACTS;**183**;Dec 22, 1997;Build 3
 ;
 ; Post-init routine updating entries in the NATIONAL CLINIC (#728.441)
 ; file for FY22 Mid-Year.
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
 ;;Sexual Orientation and Gender Identity^SOGI^^
 ;;VET HOME^VTHM^^
 ;;QUIT
 ;
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;CDQC^COVID-19 VACCINATION CLINIC
 ;;CDDC^CCC Pharmacist
 ;;CDLC^CCC NP
 ;;CDMC^CCC MD/DO
 ;;CDPC^CCC PA
 ;;CDRC^CCC RN
 ;;CNSP^Suicide Prevention Clinical Telehealth HUB
 ;;NASP^Suicide Prevention Clinical Telehealth SPOKE
 ;;DEHC^Environmental Health Registry Exams
 ;;IDMC^INTERMEDIATE CARE TECHNICIAN
 ;;NASO^National Tele-Neurology Program (NTNP)
 ;;NASZ^National Tele-Oncology (NTO)
 ;;PLCH^Hospice Pharmacist
 ;;PLMT^Surgical/Orthopedics Pain Pharmacist
 ;;PLPS^Polytrauma Psychiatrist
 ;;PNFC^Pain Team Conference
 ;;PNRD^Pain Management MD
 ;;PNSW^PAIN MANAGEMENT BEHAVIORAL HEALTH
 ;;PNWC^Pain Opioid Management
 ;;MBSR^Mindfulness Based Interventions
 ;;MDTN^Meditation (non-mindfulness-based intervention)
 ;;STUD^Student Provider
 ;;MPAK^Mobile Prosthetic and Orthotic Care (MoPOC)
 ;;AGTO^CHAR4 COUNCIL
 ;;EXPX^CHAR4 COUNCIL
 ;;GULF^CHAR4 COUNCIL
 ;;QUIT
