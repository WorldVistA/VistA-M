ECX3P159 ;ALB/DE - ECX*3.0*159 Post-Init RTN;09/18/15
 ;;3.0;DSS EXTRACTS;**159**;Dec 22, 1997;Build 2
 ;
 ;Post-init routine adding and updating entries in
 ;the NATIONAL CLINIC (#728.441) file
 ;
 Q
 ;
EN ;routine entry point
 D ADDNEW ;add new entries
 D UPDATE ;change short description of existing clinic codes
 D BMES^XPDUTL("Update complete")
 ;
 Q
 ;
ADDNEW ;Add new entries to file 728.441
 ;ECXREC is in format: code^short description
 ;
 N ECXFDA,ECXCODE,ECXREC,ECXI,ECXERR
 ;
 D BMES^XPDUTL(">>>Adding entries to the NATIONAL CLINIC (728.441) file..")
 ;
 ;-get National Clinic record
 F ECXI=1:1 S ECXREC=$P($T(ADDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
 .;
 .;-get National Clinic Code
 .S ECXCODE=$P(ECXREC,"^")
 .;
 .;-quit w/error message if entry already exists in file #728.441
 .I $$FIND1^DIC(728.441,"","X",ECXCODE) D  Q
 ..D BMES^XPDUTL(">>>..."_ECXCODE_" "_$P(ECXREC,U,2)_" not added, code already exists.")
 ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
 .;
 .;-setup field values of new entry
 .S ECXFDA(728.441,"+1,",.01)=ECXCODE
 .S ECXFDA(728.441,"+1,",1)=$P(ECXREC,"^",2)
 .;
 .;-add new entry to file #728.441
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_" - "_$P(ECXREC,U,2)_" added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_" to the file.") D
 ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
 ;
 Q
 ;
UPDATE ;changing short description of existing entries
 ;ECXREC is in format: code^short description
 ;
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI,ECXREC,ECXERR
 ;
 D BMES^XPDUTL(">>>Updating entries in the NATIONAL CLINIC (728.441) file..")
 ;
 F ECXI=1:1 S ECXREC=$P($T(UPDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
  .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
  .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ECXERR")
  .I 'ECXIEN D  Q
  ..D BMES^XPDUTL(">>>....Unable to find code: "_ECXCODE_".")
  ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
  .N FDA
  .S FDA(728.441,ECXIEN_",",1)=ECXDESC
  .D FILE^DIE(,"FDA","ECXERR")
  .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECXCODE_" - "_$P(ECXREC,U,2)_" updated")
  .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to update code "_ECXCODE_".") D
 ..D BMES^XPDUTL("*** Please contact support for assistance. ***")
 ;
 Q
 ;
ADDCLIN ;Contains the NATIONAL CLINIC entries to be added
 ;;LVL6^Mobile Medical Unit 6
 ;;LVL7^Mobile Medical Unit 7
 ;;LVL8^Mobile Medical Unit 8
 ;;LVL9^Mobile Medical Unit 9
 ;;QUIT
 ;
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;LVL1^Mobile Medical Unit 1
 ;;LVL2^Mobile Medical Unit 2
 ;;LVL3^Mobile Medical Unit 3
 ;;LVL4^Mobile Medical Unit 4
 ;;LVL5^Mobile Medical Unit 5
 ;;PNPC^PACT CVT-H Physician
 ;;PNQC^PACT CVT-H Physician Assistant
 ;;PNRC^PACT CVT-H Nurse Practitioner
 ;;PNSC^PACT CVT-H Nurse
 ;;RDNU^Radiology Oncology Clinic
 ;;SNRC^VA Provider & Pt at NonVAFacility
 ;;QUIT
