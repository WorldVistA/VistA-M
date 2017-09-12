ECX386PT ;ALB/JAM - PATCH ECX*3.0*86 Post-Init Rtn ; 07/13/05
 ;;3.0;DSS EXTRACTS;**86**;Dec 22, 1997
 ;
 ;Post-init routine to add new entries to:
 ;           NATIONAL CLINIC file (#728.441)
 ;
EN ;
 ;- Add new entry to file 728.441
 ;      ECXREC is in format: code^short description
 ;
 ;
 N ECXFDA,ECXERR,ECXCODE,ECXREC,I,CNT0,CNT1
 D BMES^XPDUTL(">>> Adding entry to the NATIONAL CLINIC (#728.441) file...")
 D MES^XPDUTL(" ")
 S (CNT0,CNT1)=0
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
 ..S CNT1=CNT1+1
 .;- Setup field values of new entry
 .S ECXFDA(728.441,"+1,",.01)=ECXCODE
 .S ECXFDA(728.441,"+1,",1)=$P(ECXREC,"^",2)
 .;
 .;- Add new entry to file #728.441
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D  Q
 ..D BMES^XPDUTL(">>>...."_ECXCODE_"  "_$P(ECXREC,U,2)_"  added to file.")
 ..S CNT0=CNT0+1
 .D BMES^XPDUTL(">>>....Unable to add "_ECXCODE_"  "_$P(ECXREC,U,2)_" to file.")
 .S CNT1=CNT1+1
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Done... Update to NATIONAL CLINIC File (#728.441).")
 D MES^XPDUTL("            "_$J(CNT0,3)_" new entries added.")
 D MES^XPDUTL("            "_$J(CNT1,3)_" were not added, already exist.")
 D MES^XPDUTL(" ")
 ;
 Q
 ;
NATCLIN ;- Contains the NATIONAL CLINIC entry to be added
 ;;MICM^MH INTENSIVE CASE MGMT
 ;;QUIT
