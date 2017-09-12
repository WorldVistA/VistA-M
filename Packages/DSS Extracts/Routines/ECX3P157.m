ECX3P157 ;ALB/DE - ECX*3.0*152 Post-Init RTN;04/06/15
 ;;3.0;DSS EXTRACTS;**157**;Dec 22, 1997;Build 1
 ;
 ;Post-init routine updating current entries in
 ;the NATIONAL CLINIC (#728.441) file
 ;
 Q
 ;
EN ;routine entry point
 D UPDATE ;change name of existing Clinic codes
 Q
 ;
UPDATE ;changing short description of existing clinic
 N ECXCODE,ECXDESC,ECXIEN,DIE,DA,DR,ECXI,ECXREC
 D BMES^XPDUTL(">>>Updating entry in the NATIONAL CLINIC (728.441) file..")
 F ECXI=1:1 S ECXREC=$P($T(UPDCLIN+ECXI),";;",2) Q:ECXREC="QUIT"  D
  .S ECXCODE=$P(ECXREC,"^"),ECXDESC=$P(ECXREC,"^",2)
  .S ECXIEN=$$FIND1^DIC(728.441,"","X",ECXCODE,"","","ERR")
  .I 'ECXIEN D  Q
  ..D BMES^XPDUTL(">>>...Unable to update "_ECXCODE_" - "_$P(ECXREC,U,2)_".")
  ..D BMES^XPDUTL(">>>...Contact support for assistance")
  .N FDA
  .S FDA(728.441,ECXIEN_",",1)=ECXDESC
  .D FILE^DIE(,"FDA","ECXERR")
  .D BMES^XPDUTL(">>>..."_ECXCODE_" - "_$P(ECXREC,U,2)_" updated")
 I '$D(ECXERR) D BMES^XPDUTL("Update complete") Q  ;quit here if update was successful
 D BMES^XPDUTL("***Errors occurred during install. Please check ECXERR(""DIERR"") for errors***")
 Q  ;quit here if errors occurred during update
 ;
UPDCLIN ;Contains the NATIONAL CLINIC entry description to be updated
 ;;HTTC^Home Sleep Study Pat Educ
 ;;MICM^MHICM Program
 ;;NDTR^CBT for Non-epileptic Seizures
 ;;RNNX^Range Program
 ;;RNNY^E-Range Program
 ;;SCTC^CWT Supported Education
 ;;SCUC^CWT Self-Employment
 ;;QUIT
