ECX3P180 ;ALB/TXH - NATIONAL CLINIC (#728.441) File Update; Feb 02, 2021@13:47
 ;;3.0;DSS EXTRACTS;**180**;Dec 22, 1997;Build 5
 ;
 ;Post-init routine updating entries in the NATIONAL CLINIC (#728.441) file.
 ;
 ; Reference to $$FIND1^DIC supported by ICR# 2051
 ; Reference to FILE^DIE supported by ICR# 2053
 ; Reference to BMES^XPDUTL supported by ICR# 10141
 ;
 Q
 ;
EN ;routine entry point
 D UPDATE ;change short description of existing clinic codes
 D BMES^XPDUTL("Update complete.")
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
 ;;CGRP^CAREGIVER SUPPORT PROGRAM - PCAFC
 ;;CGSC^CAREGIVER SUPPORT PROGRAM - PGCSS
 ;;CGVC^CAREGIVER SUPPORT PROGRAM - VISN CEAT
 ;;DEPS^CRH Chaplain
 ;;DEQC^CRH Dental DDS and DMD
 ;;DERC^CRH Occupational Therapist
 ;;DESC^CRH Prosthetist
 ;;DETC^CRH Speech Therapist
 ;;DEVC^CRH Physical Therapist
 ;;DEWC^CRH Medical Instrument Technologist
 ;;DMBC^CRH Respiratory Therapist
 ;;DMVC^CRH Optometrist
 ;;HDEC^Headache Centers of Excellence (HCoE)
 ;;QUIT
