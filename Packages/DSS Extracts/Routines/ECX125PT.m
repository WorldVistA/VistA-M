ECX125PT ;ALB/CO - PATCH ECX*3.0*125 Post-Init Rtn ; 11/24/09 2:11pm
 ;;3.0;DSS EXTRACTS;**125**;Dec 22, 1997;Build 4
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
 ;;MVMD^MOVE PHYSICIAN
 ;;MVPY^MOVE PSYCHOLOGIST
 ;;MVRD^MOVE REGISTERED DIETITIAN
 ;;MVDT^MOVE DIETARY TECHNICIAN
 ;;MVPA^MOVE PHYSICIAN ASSISTANT
 ;;MVNP^MOVE NURSE PRACTITIONER
 ;;MVRN^MOVE REGISTERED NURSE
 ;;MVLP^MOVE LICENSED PRACTICAL NURSE
 ;;MVPT^MOVE PHYSICAL THERAPIST
 ;;MVRT^MOVE RECREATION THERAPIST
 ;;MVKT^MOVE KINESIOTHERAPIST
 ;;MVOT^MOVE OCCUPATIONAL THERAPIST
 ;;MVPH^MOVE PHARMACIST
 ;;MVSW^MOVE SOCIAL WORKER
 ;;MVOO^MOVE NON-SPECIFIED PROVIDER
 ;;QUIT
