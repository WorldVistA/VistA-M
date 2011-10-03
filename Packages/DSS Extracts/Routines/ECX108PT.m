ECX108PT ;ALB/ESD - PATCH ECX*3.0*108 Post-Init Rtn ; 06/27/07 1:00pm
 ;;3.0;DSS EXTRACTS;**108**;Dec 22, 1997;Build 1
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
 ;;649L^PROV L V18 649 PRESCOTT AZ
 ;;649M^PROV M V18 649 PRESCOTT AZ
 ;;649N^PROV N V18 649 PRESCOTT AZ
 ;;649O^PROV O V18 649 PRESCOTT AZ
 ;;649P^PROV P V18 649 PRESCOTT AZ
 ;;649Q^PROV Q V18 649 PRESCOTT AZ
 ;;649R^PROV R V18 649 PRESCOTT AZ
 ;;649S^PROV S V18 649 PRESCOTT AZ
 ;;649T^PROV T V18 649 PRESCOTT AZ
 ;;649U^PROV U V18 649 PRESCOTT AZ
 ;;649V^PROV V V18 649 PRESCOTT AZ
 ;;649W^PROV W V18 649 PRESCOTT AZ
 ;;649X^PROV X V18 649 PRESCOTT AZ
 ;;649Y^PROV Y V18 649 PRESCOTT AZ
 ;;649Z^PROV Z V18 649 PRESCOTT AZ
 ;;QUIT
