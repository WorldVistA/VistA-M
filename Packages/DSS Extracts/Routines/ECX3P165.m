ECX3P165 ;ALB/DE - NATIONAL CLINIC (#728.441) File Update;09/13/16
 ;;3.0;DSS EXTRACTS;**165**;Dec 22, 1997;Build 1
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
 ;;CDTC^Expressive Arts
 ;;CGQC^Qi Gong
 ;;DEMC^Eye Mvmnt Desensitiz&Reprocess
 ;;HTFC^Whole Health Partner
 ;;IACT^BFA Technique (not regular Acupuncture)
 ;;IDHC^Integrative Health Consult
 ;;MMMT^Mindfulness other than MBSR
 ;;MPAT^Movement Therapy
 ;;PNTC^Animal-Assisted Therapy
 ;;WCHC^Whole Health Coaching
 ;;QUIT
