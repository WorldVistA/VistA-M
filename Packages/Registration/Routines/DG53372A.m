DG53372A ;ALB/PDJ - Convert Eligibility codes ; 03/29/2001
 ;;5.3;Registration;**372**;Aug 13, 1993
 ;
 ;  
 ;
EN N DATA,ERRMSG,FILERR,LFDATE,DFN,I,X,X1,X2,%,CLNOK,NSTD,STDCDS,IEN,TEXT
 N XTERR,XTPAT,XTENC,NAME
 S CLNOK=0
 ;
 S STDCDS(3)=$O(^DIC(8,"B","SC LESS THAN 50%",""))
 S STDCDS(5)=$O(^DIC(8,"B","NSC",""))
 ;**** TEST CODE
 ; S STDCDS(3)=3
 ; S STDCDS(5)=100 ; or STDCDS(5)=2
 ;**** TEST CODE
 I STDCDS(3)=3,STDCDS(5)=5 D  Q  ; Quit, because cleanup not needed
 . S CLNOK=1
 . D BMES^XPDUTL(" ")
 . D BMES^XPDUTL(" ")
 . D BMES^XPDUTL("   Your Site uses standard eligibility codes for NSC and")
 . D BMES^XPDUTL(" SC LESS THAN 50% veterans, therefore no cleanup is needed. ")
 . D BMES^XPDUTL(" ")
 . D MAIL^DG53372M
 ;
 ; Are 3 and 5 currently in use?
 ;
 F IEN=3,5 D
 . S NSTD(IEN)=0
 . I '$D(^DIC(8,IEN,0)) D  Q
 . . S NSTD(IEN)=1
 . . D BMES^XPDUTL(" ")
 . . D BMES^XPDUTL("   Your Site is using ELIGIBILITY CODE "_STDCDS(IEN)_" for "_$S(IEN=3:"SC LESS THAN 50%.",1:"NSC"))
 . . D BMES^XPDUTL(" The post-install will now identify all PATIENT and PATIENT ENCOUNTER")
 . . D BMES^XPDUTL(" records that are corrupted.  You will receive a Mailman message ")
 . . D BMES^XPDUTL(" listing the records that have been updated to use your local IEN.")
 . . D BMES^XPDUTL(" Please review the mailman message as needed.")
 . . D BMES^XPDUTL(" ")
 . ;
 . I STDCDS(IEN)'=IEN D
 . . S NSTD(IEN)=2
 . . D BMES^XPDUTL(" ")
 . . D BMES^XPDUTL("   Your Site is currently using ELIGIBILITY CODE "_IEN_" for "_$P(^DIC(8,IEN,0),"^",1)_".")
 . . D BMES^XPDUTL(" This is non-standard, as this code should be used for "_$S(IEN=3:"SC LESS THAN 50%.",1:"NSC."))
 . . D BMES^XPDUTL(" The post-install will now identify all PATIENT and PATIENT ENCOUNTER")
 . . D BMES^XPDUTL(" records that may be corrupted.  You will receive a Mailman message ")
 . . D BMES^XPDUTL(" listing the records. Please review the records and update manually as")
 . . D BMES^XPDUTL(" needed.")
 . . D BMES^XPDUTL(" ")
 ;
 S (ERRMSG,FILERR)=""
 ;
 I $D(XPDNM) D
 . I $$VERCP^XPDUTL("DFN")'>0 D
 . . S %=$$NEWCP^XPDUTL("DFN","","0")
 ;
 F I="PATREC","ENCREC","SRCERR" D
 . I $D(^XTMP("DG*5.3*372-"_I)) Q
 . S X1=DT
 . S X2=30
 . D C^%DTC
 . S TEXT=X_"^"_$$DT^XLFDT_"^DG*5.3*372 POST-INSTALL "
 . S TEXT=TEXT_$S(I="PATREC":"Patient Records",I="ENCREC":"Encounter Records",1:"filing errors")
 . S ^XTMP("DG*5.3*372-"_I,0)=TEXT
 ;
 S XTPAT="DG*5.3*372-PATREC"
 S XTENC="DG*5.3*372-ENCREC"
 S XTERR="DG*5.3*372-SRCERR"
 ;
 I '$D(XPDNM) D
 . S ^XTMP(XTPAT,1)=0
 . S ^XTMP(XTENC,1)=0
 I $D(XPDNM)&'$D(^XTMP(XTPAT,1)) S ^XTMP(XTPAT,1)=0
 I $D(XPDNM)&'$D(^XTMP(XTENC,1)) S ^XTMP(XTENC,1)=0
 I $D(XPDNM)&'$D(^XTMP(XTERR,1)) S ^XTMP(XTERR,1)=0
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DFN")
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
 ;
EN1 I '$D(XPDNM) S DFN=0
 I $D(XPDNM) S DFN=$$PARCP^XPDUTL("DFN")
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . ;
 . ; Identify Records
 . ;
 . S NAME=$P($G(^DPT(DFN,0)),"^",1)
 . D PROCENC
 . D PROCELG
 . D PROCSELG
 . I $D(XPDNM) S %=$$UPCP^XPDUTL("DFN",DFN)
 ;
 D MAIL^DG53372M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("DFN")
 D BMES^XPDUTL(" Cleanup of Eligibility Code is complete.")
 Q
 ;
PROCENC ; Process PATIENT ENCOUNTER file
 N DATA,ELIGCD,ERROR,SCEDT,SCEIEN
 ; Set beginning date as release date for DG*5.3*327
 S SCEDT=3010214.99999999,SCEIEN=""
 ;
 ; Loop through all OUTPATIENT ENCOUNTERS for this PATIENT
 ;   since DG*5.3*327 was released to NVS
 ;
 F  S SCEDT=$O(^SCE("ADFN",DFN,SCEDT)) Q:'SCEDT  D
 . F  S SCEIEN=$O(^SCE("ADFN",DFN,SCEDT,SCEIEN)) Q:'SCEIEN  D
 . . S ELIGCD=$P(^SCE(SCEIEN,0),"^",13) Q:ELIGCD=""
 . . I ",3,5,"'[ELIGCD Q  ; Quit, if not code 3 or 5
 . . I NSTD(ELIGCD)=0 Q  ; Quit, if the site uses the standard code
 . . ;
 . . ; Add entry to Temp File for list or auto-correct
 . . ;
 . . S ^XTMP(XTENC,ELIGCD,DFN,SCEIEN)=NAME_"^"_SCEDT
 . . S ^XTMP(XTENC,1)=^XTMP(XTENC,1)+1
 . . ;
 . . ; Auto-update the Eligibility code to the site code
 . . ;
 . . I NSTD(ELIGCD)=1 D
 . . . S DATA(.13)=STDCDS(ELIGCD)
 . . . I '$$UPD^DGENDBS(409.68,SCEIEN,.DATA,.ERROR) D
 . . . . S ^XTMP(XTERR,409.68,ELIGCD,DFN,SCEIEN)=NAME_"^"_SCEDT_"^"_$G(ERROR)
 Q
 ;
PROCELG ; Process PATIENT file
 N DA,DATA,ELIGCD,ERROR
 S ELIGCD=$P($G(^DPT(DFN,.36)),"^",1) Q:ELIGCD=""  ; Quit,if null
 I ",3,5,"'[ELIGCD Q  ; Quit, if not code 3 or 5
 I NSTD(ELIGCD)=0 Q  ; Quit, if the site uses the standard code
 ;
 ; Add entry to Temp File for list or auto-correct
 ;
 S ^XTMP(XTPAT,ELIGCD,DFN,0)=NAME_"^"
 S ^XTMP(XTPAT,1)=^XTMP(XTPAT,1)+1
 ;
 ; Auto-update the Eligibility code to the site code
 ;
 I NSTD(ELIGCD)=1 D
 . S DATA(.361)=STDCDS(ELIGCD)
 . I '$$UPD^DGENDBS(2,DFN,.DATA,.ERROR) D
 . . S ^XTMP(XTERR,2,ELIGCD,DFN,0)=NAME_"^^"_$G(ERROR)
 Q
 ;
PROCSELG ; Process secondary eligibility codes
 N DA,DATA,SIEN,NODE,FDAIEN,NEWIEN,DIK
 S SIEN=0
 F  S SIEN=$O(^DPT(DFN,"E",SIEN)) Q:'SIEN  D
 . S NODE=$G(^DPT(DFN,"E",SIEN,0))
 . S ELIGCD=$P(NODE,"^",1) Q:ELIGCD=""  ; Quit, if null
 . I ",3,5,"'[ELIGCD Q  ; Quit, if not code 3 or 5
 . I NSTD(ELIGCD)=0 Q  ;Quit, if the site uses the standard code
 . ;
 . ; Add entry to Temp File for list or auto-correct
 . ;
 . S ^XTMP(XTPAT,ELIGCD,DFN,SIEN)=NAME_"^"_ELIGCD
 . S ^XTMP(XTPAT,1,1)=$G(^XTMP(XTPAT,1,1))+1
 . ;
 . ; Update entry for auto-correct
 . ;
 . I NSTD(ELIGCD)=1 D
 . . I '$D(^DPT(DFN,"E",STDCDS(ELIGCD))) D
 . . . K DATA,FDAIEN,NEWIEN,ERROR
 . . . S NEWIEN="+1,"_DFN_","
 . . . S DATA(2.0361,NEWIEN,.01)=STDCDS(ELIGCD)
 . . . S DATA(2.0361,NEWIEN,.03)=$P(NODE,"^",3)
 . . . S DATA(2.0361,NEWIEN,.04)=$P(NODE,"^",4)
 . . . S FDAIEN(1)=STDCDS(ELIGCD)
 . . . D UPDATE^DIE("","DATA","FDAIEN","ERROR")
 . . . I $D(ERROR) D  Q
 . . . . S ^XTMP(XTERR,2.0361,ELIGCD,DFN,SIEN)=NAME_"^"_SIEN_"^"_$G(ERROR)
 . . ; Delete old entry if add successful.
 . . K DA,DATA
 . . S DA(1)=DFN,DA=ELIGCD,DIK="^DPT("_DA(1)_",""E"","
 . . D ^DIK
 Q
 ;
CLEANUP ; Used to cleanup XTMP global for testing only
 S XTPAT="DG*5.3*372-PATREC"
 S XTENC="DG*5.3*372-ENCREC"
 S XTERR="DG*5.3*372-SRCERR"
 ;
 K ^XTMP(XTPAT)
 K ^XTMP(XTENC)
 K ^XTMP(XTERR)
 Q
