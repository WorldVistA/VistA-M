ECX110PT ;ALB/ESD - PATCH ECX*3.0*110 Post-Init Rtn ; 09/20/07 1:00pm
 ;;3.0;DSS EXTRACTS;**110**;Dec 22, 1997;Build 4
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
 ;;OEFN^OEF/OIF CSMG BY NURSE
 ;;OEFS^OEF/OIF CSMG BY SOCIAL WORKER
 ;;LVL1^LEVEL 1
 ;;LVL2^LEVEL 2
 ;;LVL3^LEVEL 3
 ;;LVL4^LEVEL 4
 ;;LVL5^LEVEL 5
 ;;RV15^RVU 15 MINUTES HIGHER THAN MATRIX
 ;;RV20^RVU 20 MINUTES HIGHER THAN MATRIX
 ;;RV30^RVU 30 MINUTES HIGHER THAN MATRIX
 ;;RV45^RVU 45 MINUTES HIGHER THAN MATRIX
 ;;RV60^RVU 60 MINUTES HIGHER THAN MATRIX
 ;;VL1A^VL CATEGORY 1 A
 ;;VL1B^VL CATEGORY 1 B
 ;;VL1C^VL CATEGORY 1 C
 ;;VL1D^VL CATEGORY 1 D
 ;;VL2A^VL CATEGORY 2 A
 ;;VL2B^VL CATEGORY 2 B
 ;;VL2C^VL CATEGORY 2 C
 ;;VL2D^VL CATEGORY 2 D
 ;;VL4A^VL CATEGORY 4 A
 ;;VL4B^VL CATEGORY 4 B
 ;;VL4C^VL CATEGORY 4 C
 ;;VL4D^VL CATEGORY 4 D
 ;;VL5A^VL CATEGORY 5 A
 ;;VL5B^VL CATEGORY 5 B
 ;;VL5C^VL CATEGORY 5 C
 ;;VL5D^VL CATEGORY 5 D
 ;;FDLA^VL CATEGORY 4 A
 ;;FDLB^VL CATEGORY 4 B
 ;;FDLC^VL CATEGORY 4 C
 ;;FDLD^VL CATEGORY 4 D
 ;;PSOA^PSYCHOLOGIST A
 ;;PSOB^PSYCHOLOGIST B
 ;;PSOC^PSYCHOLOGIST C
 ;;PSOD^PSYCHOLOGIST D
 ;;PSOE^PSYCHOLOGIST E
 ;;QUIT
