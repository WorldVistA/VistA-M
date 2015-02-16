DVBA187P ;ALB/GAK - PATCH DVBA*2.7*187 POST-INSTALL ROUTINE;08-OCT-2013
 ;;2.7;AMIE;**187**;Apr 10, 1995;Build 13
 Q
 ;
ENTER ;
 D AMIE
 D SECKEY
 Q
 ;
 ;
AMIE ;Update for the AMIE EXAM (#396.6) file
 ;
 ;Used to inactivate old entries and/or create new entries for designated worksheet updates
 ;
 D BMES^XPDUTL(" Update to AMIE EXAM (#396.6) file...")
 I '$D(^DVB(396.6)) D BMES^XPDUTL("Missing AMIE EXAM (#396.6) file") Q
 I $D(^DVB(396.6)) D
 . ;Add new SHA entry to AMIE EXAM file
 . D NEW
 .  ;Rename existing Medical Opinion 1 entry in AMIE EXAM file
 . D RENAMIE
 . ;Inactivate existing entires in AMIE EXAM file
 . D INACAMIE
 . ; Rename Medical Opinion PRINT NAME field
 . D RENMEDOP
 Q
 ;
 ;
NEW ;Add new exam entry
 ;
 N DVBAI,DVBLINE,DVBIEN,DVBEXM,DVBPNM,DVBBDY,DVBROU,DVBSTAT,DVBWKS
 ;
 D BMES^XPDUTL(" Adding new AMIE EXAM (#396.6) file entry...")
 F DVBAI=1:1 S DVBLINE=$P($T(AMIENEW+DVBAI),";;",2) Q:DVBLINE="QUIT"  D
 . N DVBAMSG
 . S DVBIEN=$P(DVBLINE,";",1)  ;ien
 . S DVBEXM=$P(DVBLINE,";",2)  ;exam name
 . S DVBPNM=$P(DVBLINE,";",3)  ;print name
 . S DVBBDY=$P(DVBLINE,";",4)  ;body system
 . S DVBROU=$P(DVBLINE,";",5)  ;routine name
 . S DVBSTAT=$P(DVBLINE,";",6) ;status
 . S DVBWKS=$P(DVBLINE,";",8)  ;worksheet number
 . D BMES^XPDUTL("  Attempting to add Entry #"_DVBIEN_"...")
 . D NEWEXAM^DVBAUTLP(DVBIEN,DVBEXM,DVBPNM,DVBBDY,DVBROU,DVBSTAT,DVBWKS,.DVBAMSG)
 . ; Display status message returned if any
 . D:$D(DVBAMSG)>0 MES^XPDUTL(.DVBAMSG)
 . D BMES^XPDUTL(" Completed adding new AMIE EXAM (#396.6) file entry...")
 Q
  ;
RENAMIE ;Rename existing DBQ exam file entries
 ;
 N DVBAI,DVBLINE,DVBIEN,DVBEXMO,DVBEXMN
 ;
 D BMES^XPDUTL("Renaming AMIE EXAM (#396.6) file entries...")
 F DVBAI=1:1 S DVBLINE=$P($T(EXOLDNEW+DVBAI),";;",2) Q:DVBLINE="QUIT"  D 
 . S DVBIEN=$P(DVBLINE,";",1)  ;ien
 . S DVBEXMO=$P(DVBLINE,";",2)  ;old exam name
 . S DVBEXMN=$P(DVBLINE,";",3)  ;new exam name
 . D RENEXAM
 D BMES^XPDUTL("Completed Renaming AMIE EXAM (#396.6) file entries...")
 K DVBEXMO,DVBEXMN
 Q
 ;
RENEXAM ;
 ;Quit if critical variables missing. For each EXOLDNEW entry, do this. 
 I $G(DVBIEN)'>0!($G(DVBEXMO)']"")!($G(DVBEXMN)']"") D  Q
 . D BMES^XPDUTL("Insufficient data to process change at #"_DVBIEN_")")
 ;
 ; Update existing entry
 ;
 N DVBAERR,DVBAFDA
 ;
 ; Check for existing entry 
 I $G(^DVB(396.6,DVBIEN,0))']"" D  Q
 . D BMES^XPDUTL("No entry found at #"_DVBIEN)
 ;
 ; Check for previous update
 I $P(^DVB(396.6,DVBIEN,0),"^",1)=DVBEXMN D  Q
 . D BMES^XPDUTL("Entry at ien #"_DVBIEN_" has previously been updated")
 ;
 ; Check for correct entry NAME to update
 I $P(^DVB(396.6,DVBIEN,0),"^",1)'=DVBEXMO D  Q
 . D BMES^XPDUTL("Entry at ien #"_DVBIEN_" does not match expected name "_DVBEXMO_" No updating will take place")
 ;
 ; Update entry
 S DVBAFDA(396.6,+DVBIEN_",",.01)=$G(DVBEXMN) D
 . D FILE^DIE("","DVBAFDA","DVBAERR")
 ;
 ; Report sucessful update
 ;
 I $D(DVBAERR("DIERR"))'>0 D  Q
 . D BMES^XPDUTL("Renamed entry #"_DVBIEN_" from "_DVBEXMO_" to "_DVBEXMN)
 ;
 ; Report update error
 ;
 I $D(DVBAERR("DIERR"))>0 D
 . D BMES^XPDUTL("   *** Warning - Unable to update entry #"_DVBIEN_" *** ")
 . D MSG^DIALOG()
 Q
 ;
INACAMIE   ;Inactivate exams
 ;
 N DVBAI,DVBLINE,DVBIEN,DVBEXM
 ;
 D BMES^XPDUTL(" Inactivating AMIE EXAM (#396.6) file entries...")
 D MES^XPDUTL("")
 F DVBAI=1:1 S DVBLINE=$P($T(AMIEOLD+DVBAI),";;",2) Q:DVBLINE="QUIT"  D
 . N DVBAMSG
 . S DVBIEN=$P(DVBLINE,";",1)
 . S DVBEXM=$P(DVBLINE,";",2)
 . ;D BMES^XPDUTL("Going to INACTEXM^DVBAUTLP with DVBIEN="_DVBIEN_", DVBEXM="_DVBEXM_", and the message array passed")
 . D INACTEXM^DVBAUTLP(DVBIEN,DVBEXM,.DVBAMSG)
 . ; Display status message returned, if any
 . D:$D(DVBAMSG)>0 MES^XPDUTL(.DVBAMSG)
 . D MES^XPDUTL("")
 D BMES^XPDUTL(" Completed Inactivating AMIE EXAM (#396.6) file entries...")
 Q
 ;
RENMEDOP ;
 D BMES^XPDUTL(" Changing PRINT NAME of DBQ Medical Opinion to DBQ MEDICAL OPINION")
 I $P($G(^DVB(396.6,437,0)),"^",1)'="DBQ Medical Opinion" D  Q
 . D BMES^XPDUTL(" Could not change PRINT NAME of DBQ Medical Opinion to DBQ MEDICAL OPINION")
 N DVBAERR
 S DVBAFDA(396.6,437_",",6)="DBQ MEDICAL OPINION" D FILE^DIE("","DVBAFDA","DVBAERR")
 I $D(DVBAERR("DIERR"))'>0 D
 . D BMES^XPDUTL("DBQ Medical Opinion print name changed to DBQ MEDICAL OPINION")
 I $D(DVBAERR("DIERR"))>0 D
 . D BMES^XPDUTL("Could not change DBQ Medical Opinion print name to DBQ MEDICAL OPINION")
 Q
 ;
SECKEY ;
 ;
 N XDUZ,KEYNUM,XIEN,XMNU,STOP1,ZTST,OPTIEN,PERDUZ,MSG,ERR,KEYIEN,PERSON,TODAY,X,ZZ
 ;
 S ZZ="" D OWNSKEY^XUSRB(.ZZ,"XUMGR",DUZ)
 I $G(ZZ(0))'=1 D  Q
 . D BMES^XPDUTL("NOTE: THE NEW SECURITY KEY 'DVBA CAPRI GETVBADOCS' DID NOT SUCCESSFULLY UPDATE WITH THE REQUIRED HOLDERS.")
 . D BMES^XPDUTL("THE USER RUNNING THIS POST INSTALL ROUTINE DOES NOT HAVE XUMGR KEY ASSIGNED TO THEM.")
 . D BMES^XPDUTL("PLEASE RUN SECKEY^DVBA187P AGAIN WITH USER WHO IS A HOLDER OF THE 'XUMGR' SECURITY KEY.")
 ;
 K ^TMP($J,"DVBA187P")
 ;
 D NOW^%DTC S TODAY=X
 ;
 ;FIND DVBA CAPRI GUI IN OPTION FILE (SHOULD ALWAYS BE 9510) BUT CHECKING JUST THE SAME
 S STOP1=0,OPTIEN=""
 S XIEN=0 F  S XIEN=$O(^DIC(19,XIEN)) Q:XIEN=""!('XIEN)!(STOP1=1)  D
 . S ZTST=$G(^DIC(19,XIEN,0),"")
 . S ZTST=$P(ZTST,"^",1)
 . I ZTST="DVBA CAPRI GUI" S STOP1=1,OPTIEN=XIEN
 I OPTIEN="" D BMES^XPDUTL("'DVBA CAPRI GUI' OPTION NOT FOUND IN OPTION FILE. USERS OF DVBA CAPRI GETVBADOCS COULD NOT BE SETUP") Q
 ;
 ;FIND PERSONS WITH DVBA CAPRI GUI OPTION
 I OPTIEN'="" D
 . S PERDUZ=0 F  S PERDUZ=$O(^VA(200,PERDUZ)) Q:PERDUZ=""!('PERDUZ)  D
 .. K MSG,ERR
 .. D GETS^DIQ(200,PERDUZ_",","9.2","I","MSG","ERR")
 .. I $G(MSG(200,PERDUZ_",",9.2,"I"))'="",($G(MSG(200,PERDUZ_",",9.2,"I"))<=TODAY) D  Q
 ... S ^TMP($J,"DVBA187P",PERDUZ,"TERMEDPERSON")=""
 .. ;
 .. I $G(^VA(200,PERDUZ,201)) I $P(^VA(200,PERDUZ,201),"^",1)=OPTIEN S ^TMP($J,"DVBA187P",PERDUZ,"USERSWITHOPTION")="" Q
 .. Q:'$D(^VA(200,PERDUZ,203))
 .. S STOP1=0
 .. S XMNU=0 F  S XMNU=$O(^VA(200,PERDUZ,203,XMNU)) Q:XMNU=""!('XMNU)!(STOP1=1)  D
 ... I $G(^VA(200,PERDUZ,203,XMNU,0)) I $P(^VA(200,PERDUZ,203,XMNU,0),"^",1)=OPTIEN S STOP1=1,^TMP($J,"DVBA187P",PERDUZ,"USERSWITHOPTION")=""
 ;
 ;DOES THE USER HAVE ACCESS TO THE CURRENT KEY
 S KEYNUM=$$LKUP^XPDKEY("DVBA CAPRI DENY_GETVBADOCS")
 I $G(KEYNUM)="" D BMES^XPDUTL("'DVBA CAPRI DENY_GETVBADOCS' SECURITY KEY HAS ALREADY BEEN DELETED. SECKEY^DVBA187P CAN NOT CONTINUE") Q
 S PERDUZ=0 F  S PERDUZ=$O(^VA(200,PERDUZ)) Q:PERDUZ=""!('PERDUZ)  D
 . I $D(^VA(200,PERDUZ,51,KEYNUM)) D  Q
 .. S ^TMP($J,"DVBA187P",PERDUZ,"DVBA CAPRI DENY_GETVBADOCS")=""
 .. I $D(^TMP($J,"DVBA187P",PERDUZ,"USERSWITHOPTION")) S ^TMP($J,"DVBA187P",PERDUZ,"USERSWITHOPTION")="DVBA CAPRI DENY_GETVBADOCS"
 ;
 ;ADD NEW SECURITY KEY TO ALL NON-TERMED PERSONS WHO DON'T HAVE OLD KEY
 S KEYNUM=$$LKUP^XPDKEY("DVBA CAPRI GETVBADOCS")
 I $G(KEYNUM)="" D BMES^XPDUTL("'DVBA CAPRI GETVBADOCS' SECURITY KEY HAS NOT BEEN INSTALLED ON SYSTEM. INSTALL AND RERUN SECKEY^DVBA187P") Q
 S PERDUZ=0 F  S PERDUZ=$O(^TMP($J,"DVBA187P",PERDUZ)) Q:PERDUZ=""!('PERDUZ)  D
 . Q:$D(^VA(200,PERDUZ,3,"B","VISITOR"))=10  ;DO NOT INCLUDE USERS WHO ARE VISITORS
 . Q:'$D(^TMP($J,"DVBA187P",PERDUZ,"USERSWITHOPTION"))
 . Q:$D(^TMP($J,"DVBA187P",PERDUZ,"TERMEDPERSON"))
 . Q:$D(^TMP($J,"DVBA187P",PERDUZ,"DVBA CAPRI DENY_GETVBADOCS"))
 . ;IF AFTER FIRST RUN THIS ROUTINE IS RUN AGAIN EXCLUDE PERSON WITH KEY FROM FIRST RUN
 . Q:$D(^XUSEC("DVBA CAPRI GETVBADOCS",PERDUZ))
 . K FDA,ERR,DIERR,KEYIEN
 . S FDA(200.051,"+1,"_PERDUZ_",",.01)=KEYNUM
 . S FDA(200.051,"+1,"_PERDUZ_",",1)=DUZ
 . S FDA(200.051,"+1,"_PERDUZ_",",2)=TODAY
 . S KEYIEN(1)=KEYNUM
 . D UPDATE^DIE("","FDA","KEYIEN","ERR")
 . S PERSON=$P(^VA(200,PERDUZ,0),"^",1)
 . I $D(DIERR) D BMES^XPDUTL("PERSON DUZ: "_PERDUZ_" ("_PERSON_") SHOULD BE ASSIGNED THE SECURITY KEY 'DVBA CAPRI GETVBADOCS' BUT COULD NOT IN THE DVBA*2.7*187 POST INSTALL ROUTINE. PLEASE SET THIS PERSON MANUALLY") Q
 . D BMES^XPDUTL("PERSON DUZ: "_PERDUZ_" ("_PERSON_") HAS BEEN ASSIGNED THE NEW SECURITY KEY 'DVBA CAPRI GETVBADOCS'")
 ;
 K ^TMP($J,"DVBA187P")
 D BMES^XPDUTL("OK to delete DVBA187P")
 Q
 ;
 ;***************************************************************************
 ; AMIE EXAM (#396.6) file exam(s) to activate (create or update).
 ; Data should be in internal format.
 ; format: ien;exam name (60 chars);print name;body system;routine;status;;wks#
 ;***************************************************************************
 ;
AMIENEW ;
 ;;463;DBQ Medical SHA;DBQ SEPRATN HEALTH ASMNT;1;DVBCQDRV;A; ; ;
 ;;QUIT
 ;
 Q
 ;
 ; **************************************************************************
 ; AMIE EXAM (#396.6) file exam(s) to rename. Data should be in internal format. 
 ; Format: ;;ien;"old" exam name(up to 60 chars);"new" exam name(up to 60 chars)
 ;
 ; **************************************************************************
EXOLDNEW ;
 ;;437;DBQ Medical Opinion 1;DBQ Medical Opinion
 ;;QUIT
 ;;
 Q
 ;***************************************************************************
 ; AMIE EXAM (#396.6) file exam(s) to deactivate. Data should be in
 ; internal format. 
 ; Format: ien;exam name (60 chars);
 ;***************************************************************************
 ;
AMIEOLD  ;
 ;;416;DBQ MUSC Flatfoot (pes planus);16;DVBCQDRV;I;;
 ;;433;DBQ CARDIO Ischemic heart disease;6;DVBCQDRV;I;;
 ;;438;DBQ Medical Opinion 2;17;DVBCQDRV;I;;
 ;;439;DBQ Medical Opinion 3;17;DVBCQDRV;I;;
 ;;440;DBQ Medical Opinion 4;17;DVBCQDRV;I;;
 ;;441;DBQ Medical Opinion 5;17;DVBCQDRV;I;;
 ;;QUIT
 ;
 Q
