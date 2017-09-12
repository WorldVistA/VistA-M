ECX133PT ;ALB/BP - PATCH ECX*3.0*133 Post-Init Rtn ; 11/24/09 2:11pm
 ;;3.0;DSS EXTRACTS;**133**;Dec 22, 1997;Build 6
 ;
 ;Post-init routine to add new entries to:
 ;       
 ;           NATIONAL CLINIC file (#728.441)
 ;
 ;
 Q
EN D POST1 ;Add new Clinic codes
 D POST2 ;Change short description of existing clinic code
 Q
 ;
 ;
POST1 ;- Add new entry to file 728.441
 ;      ECXREC is in format: code^short description
 ;
 ;
 N ECXFDA,ECXERR,ECXCODE,ECXREC,I
 D BMES^XPDUTL(">>> Adding entry to the NATIONAL CLINIC (#728.441) file...")
 ;
 ;- Get NATIONAL CLINIC record
 F I=1:1 S ECXREC=$P($T(NATCLIN+I),";;",2) Q:ECXREC="QUIT"  D
 .;
 .;- National Clinic code
 .S ECXCODE=$P(ECXREC,"^")
 .;
 .;- Quit w/error message if entry already exists in file #728.441
 .I $$FIND1^DIC(728.441,"","X",ECXCODE) D  Q
 ..D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_"  not added, entry already exists.")
 ..D BMES^XPDUTL(">>> Delete entries and reinstall patch if entries were not created by a")
 ..D MES^XPDUTL(">>> previous installation of this patch.")
 .;
 .;- Setup field values of new entry
 .S ECXFDA(728.441,"+1,",.01)=ECXCODE
 .S ECXFDA(728.441,"+1,",1)=$P(ECXREC,"^",2)
 .;
 .;- Add new entry to file #728.441
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_"  added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_"  "_$P(ECXREC,U,2)_" to file.")
 ;
 Q
 ;
POST2 ;
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR
 S ECXCODE="CGRP",ECXDESC="Caregiver Support Program"
 S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ERR")
 S DIE="^ECX(728.441,",DA=ECXIEN,DR="1///^S X=ECXDESC"
 D ^DIE
 ;
NATCLIN ;- Contains the NATIONAL CLINIC entry to be added
 ;;CCPH^Critical Care Pharmacist
 ;;CDED^Cardiac Disease Education (CHF, etc)
 ;;CRRC^Cardiovascular Risk Reduction Pharmacist
 ;;DRPH^Dermatology Pharmacist
 ;;EDPH^Emergency Department Pharmacist
 ;;ESPH^ESA Pharmacist
 ;;HEPC^Hepatitis C Pharmacist
 ;;HIVD^HIV Pharmacist
 ;;IMPH^Internal Medicine Pharmacist
 ;;MREC^Medication Reconciliation Pharmacist
 ;;MTMP^Medication Therapy Management Pharmacist
 ;;NEUR^Neurology Pharmacist
 ;;NFPA^Non-Formulary/Prior Approval Pharmacist
 ;;NSPH^Nutritional Support Pharmacist
 ;;NUCL^Nuclear Medicine Pharmacist
 ;;ONCO^Oncology Pharmacist
 ;;OPTH^Ophthalmology Pharmacist
 ;;PACP^Patient Aligned Care Team Pharmacist
 ;;PACT^Patient Aligned Care Team
 ;;PGEN^Pharmacogenomics Pharmacist
 ;;PKPH^Pharmacokinetics Pharmacist
 ;;PTPH^Polytrauma Pharmacist
 ;;RHUM^Rheumatology Pharmacist
 ;;SPCH^Specialty Care Pharmacist
 ;;SUPH^Surgery/Anesthesia/OR Pharmacist
 ;;WMPH^Women's Health Pharmacist
 ;;QUIT
