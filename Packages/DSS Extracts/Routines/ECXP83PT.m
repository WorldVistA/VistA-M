ECXP83PT ;ALB/ESD - PATCH ECX*3.0*83 Post-Init Rtn ; 12/1/04 1:00pm
 ;;3.0;DSS EXTRACTS;**83**;Dec 22, 1997
 ;
 ;Post-init routine to add new entries to:
 ;       
 ;           NATIONAL CLINIC file (#728.441)
 ;
 ;
EN D POST1
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
NATCLIN ;- Contains the NATIONAL CLINIC entry to be added
 ;;573L^PROV L V08 573 N.FLA/S.GA HCS
 ;;573M^PROV M V08 573 N.FLA/S.GA HCS
 ;;573N^PROV N V08 573 N.FLA/S.GA HCS
 ;;573O^PROV O V08 573 N.FLA/S.GA HCS
 ;;573P^PROV P V08 573 N.FLA/S.GA HCS
 ;;573Q^PROV Q V08 573 N.FLA/S.GA HCS
 ;;573R^PROV R V08 573 N.FLA/S.GA HCS
 ;;573S^PROV S V08 573 N.FLA/S.GA HCS
 ;;573T^PROV T V08 573 N.FLA/S.GA HCS
 ;;573U^PROV U V08 573 N.FLA/S.GA HCS
 ;;573V^PROV V V08 573 N.FLA/S.GA HCS
 ;;573W^PROV W V08 573 N.FLA/S.GA HCS
 ;;573X^PROV X V08 573 N.FLA/S.GA HCS
 ;;573Y^PROV Y V08 573 N.FLA/S.GA HCS
 ;;573Z^PROV Z V08 573 N.FLA/S.GA HCS
 ;;RENL^RENAL
 ;;GERI^GERIATRICS
 ;;HBPC^HOME BASED PRIMARY CARE
 ;;QUIT
