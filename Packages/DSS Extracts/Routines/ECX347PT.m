ECX347PT ;ALB/ESD - PATCH ECX*3.0*47 Post-Init Rtn ; 11/7/02 1:00pm
 ;;3.0;DSS EXTRACTS;**47**;Dec 22, 1997
 ;
 ;Post-init routine to add new entries to:
 ;           DSS LAB TESTS file   (#727.2)
 ;           NATIONAL CLINIC file (#728.441)
 ;
 ;
EN D ADD7272,POST1
 Q
 ;
 ;
ADD7272 ;- Add new entries to file #727.2
 ;      ECXX is in format: ien;test^source
 ;
 N ECX,ECXDA,ECXX,DA,DIC,DINUM,DIE,DR,X,Y,TEST,SOURCE,CNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(">>> Adding entries to DSS LAB TESTS File (#727.2)...")
 D MES^XPDUTL(" ")
 S $P(^DD(727.21,.01,0),U,5)="",CNT=0
 F ECX=1:1 S ECXX=$P($T(NEW7272+ECX),";;",2) Q:ECXX="QUIT"  D
 .S ECXDA=$P(ECXX,";",1),ECXX=$P(ECXX,";",2)
 .Q:'$D(^ECX(727.2,1))
 .I $D(^ECX(727.2,1,1,0)),'$D(^ECX(727.2,1,1,ECXDA,0)) D
 ..S CNT=CNT+1
 ..S TEST=$P(ECXX,U,1),SOURCE=$P(ECXX,U,2)
 ..S DA(1)=1,DIC("P")=$P(^DD(727.2,1,0),U,2),DINUM=ECXDA
 ..S X=TEST,DIC="^ECX(727.2,1,1,",DLAYGO=727.21,DIC(0)="LX",DIC("DR")="2///^S X=SOURCE"
 ..K DD,DO D FILE^DICN K DLAYGO
 ..D MES^XPDUTL(" ")
 ..D MES^XPDUTL(">>>...."_TEST_" added to file as entry #"_ECXDA_".")
 ..D MES^XPDUTL(" ")
 I CNT=0 D
 .D MES^XPDUTL(">>>....Entries already exist -- nothing added.")
 .D MES^XPDUTL(" ")
 S $P(^DD(727.21,.01,0),U,5)="K X"
 Q
 ;
NEW7272 ;- New records for file #727.2
 ;;51;PARTIAL THROMBOPLASTIN TIME (PTT)^B
 ;;52;INR (INTERNATIONAL NORMALIZED RATIO)^B
 ;;53;VITAMIN B6^B
 ;;54;HOMOCYSTEINE^B
 ;;55;OCCULT BLOOD (FECAL)^B
 ;;56;MICROALBUMIN/CREATININE RATIO^U
 ;;QUIT
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
 ;;CLNS^Clinical Nurse Specialist
 ;;QUIT
