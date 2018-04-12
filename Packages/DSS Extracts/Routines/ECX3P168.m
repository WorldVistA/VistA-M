ECX3P168 ;ALB/DE - NATIONAL CLINIC (#728.441) File Update;11/13/17
 ;;3.0;DSS EXTRACTS;**168**;Dec 22, 1997;Build 1
 ;
 ;Post-init routine updating entries in
 ;the NATIONAL CLINIC (#728.441) file
 ;
 Q
 ;
EN ;routine entry point
 D UPDATE ;change short description of existing clinic codes
 D BMES^XPDUTL("Update complete")
 ;
 Q
 ;
UPDATE ;changing short description of existing entries
 ;ECXREC is in format: code^short description
 ;
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI,ECXREC,ECXERR
 ;
 D BMES^XPDUTL(">>>Updating entries in the NATIONAL CLINIC (728.441) file...")
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
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;CBHT^CHAR4 COUNCIL
 ;;DEMC^CHAR4 COUNCIL
 ;;DMDC^V-IMPACT Psychologist
 ;;DMEC^V-IMPACT Social Worker
 ;;DMFC^V-IMPACT RN/LPN
 ;;DMGC^V-IMPACT Nurse Practitioner
 ;;DMJC^V-IMPACT Pharmacist
 ;;DMKC^V-IMPACT MD/DO
 ;;DMLC^V-IMPACT PA
 ;;DMPC^V-IMPACT Contract MD/DO
 ;;DMQC^V-IMPACT Contract NP
 ;;DMRC^V-IMPACT Spoke (Patient) Side
 ;;DMSC^V-IMPACT Other
 ;;HDQC^Homeless Vets Street Outreach
 ;;HTSC^HURRICANE IRMA CVT SERVICES
 ;;HTUC^HURRICANE HARVEY CVT SERVICES
 ;;PNJC^Open Access
 ;;RHVC^Traveling Vets Coordinator
 ;;WCEC^Whole Health Education Group
 ;;QUIT
