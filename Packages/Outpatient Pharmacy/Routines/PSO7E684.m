PSO7E684 ;WILM/BDB - Environment routine for patch PSO*7*684 ;4/22/2022
 ;;7.0;OUTPATIENT PHARMACY;**684**;DEC 1997;Build 57
 ;External reference to ^XOB(18.12 supported by DBIA 5813
 ;External reference to ^XOB(18.02 supported by DBIA 5814
 ;External reference to ^XUSRB1 is supported by DBIA 2240
 ;
 N HANDPSO,TITLE,LIFE,DEALABEL,DEARR
 S HANDPSO="PSO70684-INSTALL"
 S TITLE="REFRESH DOJ/DEA"
 S LIFE=7
 ;
 I $$P545CHK7(),$$PROD^XUPROD() Q  ; Don't auto-run migration after PSO*7*545 is installed
 ;
 D FIELD^DID(8991.9,.01,,"LABEL","DEALABEL","DEAERR") I $G(DEALABEL("LABEL"))'="DEA NUMBER" D  Q
 . S XPDABORT=1
 . D BMES^XPDUTL("The DEA NUMBERS file (#8991.9) is missing - please install XU*8.0*688")
 ;
 ; Ensure Web Service and Server exist and are configured/encrypted
 I '$$FIND1^DIC(18.12,,,"PSO DOJ/DEA WEB SERVER")!'$$FIND1^DIC(18.02,,,"PSO DOJ/DEA WEB SERVICE") D DEAWS
 ;
 L +^XTMP(HANDPSO):0 I '$T D  Q
 . S XPDABORT=1
 . D BMES^XPDUTL(TITLE_" job is already running.  Halting...")
 . D MES^XPDUTL("")
 D INITXTMP(HANDPSO,TITLE,LIFE)
 S ^XTMP(HANDPSO,"STATUS")="Start of Install"
 L -^XTMP(HANDPSO)
 Q
 ;
INITXTMP(HANDPSO,TITLE,LIFE)  ; -- Initialize ^XTMP according to SAC standards.
 N BEGDT,PURGDT
 S BEGDT=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGDT,LIFE)
 S ^XTMP(HANDPSO,0)=PURGDT_"^"_BEGDT_"^"_TITLE
 Q
 ;
P545CHK7() ; Have more than 7 days elapsed since PSO*7*545 was installed?
 N P545INST,P545X,P545LAST
 S P545INST=$$PATCH^XPDUTL("PSO*7.0*545")
 Q:'P545INST 0
 S P545X=$$INSTALDT^XPDUTL("PSO*7.0*545",.DATA)
 S P545LAST=$O(DATA($$NOW^XLFDT),-1)
 I $$FMDIFF^XLFDT($$DT^XLFDT(),P545LAST)>7 Q 1
 Q 0
 ;
DEAWS ; Install DEA Web Service
 ; 1st: Makes an entry/update to the WEB SERVICE FILE #18.02 in global ^XOB(18.02,
 ; 2nd: Makes an entry/update to the WEB SERVICE FILE #18.02 in global ^XOB(18.02,
 ; 3nd: Makes an entry/update to the WEB SERVER FILE #18.12 in global ^XOB(18.12,
 ;
 N FDA     ; -- FileMan Data Array
 N WEBVICE ; -- Web Service Internal Entry Number
 N WEBVER  ; -- Web Server Internal Entry Number
 N MULTIEN ; -- Web Service Multiple Internal Entry Number
 N WSTAT   ; -- Web Service Status
 N IENROOT,MSGROOT,IENROOT1,VICEIEN
 N PSODEAC,PSODEAMSG
 ;
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,SERVADD,X,Y,ENVRMT
 S ENVRMT="" I $$PROD^XUPROD S ENVRMT="P"
 ;
 S SERVADD=$S(ENVRMT="P":"prod.deals.vaec.domain.ext",1:"dev.deals.vaec.domain.ext")
 ;
 K FDA
 S FDA(18.02,"?+1,",.01)="PSO DOJ/DEA WEB SERVICE"                  ; NAME
 S FDA(18.02,"?+1,",.02)="REST"                                     ; TYPE
 S FDA(18.02,"?+1,",200)="/deaInfo/"                                ; CONTEXT ROOT
 S FDA(18.02,"?+1,",201)=""                                         ; AVAILABILITY RESOURCE
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 K IENROOT,MSGROOT,FDA
 ;
 S FDA(18.12,"?+1,",.01)="PSO DOJ/DEA WEB SERVER"                    ; NAME
 S FDA(18.12,"?+1,",.03)=443                                         ; PORT
 S FDA(18.12,"?+1,",.04)=SERVADD                                     ; SERVER
 S FDA(18.12,"?+1,",.06)="ENABLED"                                   ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,"?+1,",.07)=10                                          ; DEFAULT HTTP TIMEOUT
 S FDA(18.12,"?+1,",1.01)="YES"                                      ; LOGIN REQUIRED
 S FDA(18.12,"?+1,",3.01)="TRUE"                                     ; SSL ENABLED
 S FDA(18.12,"?+1,",3.02)="encrypt_only_tlsv12"                      ; SSL CONFIGURATION
 S FDA(18.12,"?+1,",3.03)=443                                        ; SSL PORT
 I ENVRMT="P" D
 . S FDA(18.12,"?+1,",200)="user"
 . S FDA(18.12,"?+1,",300)=$$ENCRYP^XUSRB1("hkttHhdfn6XK")
 I ENVRMT'="P" D
 . S FDA(18.12,"?+1,",200)="user"
 . S FDA(18.12,"?+1,",300)=$$ENCRYP^XUSRB1("pass")
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 ;
 S IENROOT1=$G(IENROOT(1)),MULTIEN=0
 ;
 S WEBVER=$S(IENROOT1:IENROOT1,1:WEBVER)
 K IENROOT,MSGROOT,FDA
 S VICEIEN=0 F  S VICEIEN=$O(^XOB(18.12,WEBVER,100,"B",VICEIEN)) Q:'VICEIEN  I $$GET1^DIQ(18.02,VICEIEN,.01)="PSO DOJ/DEA WEB SERVICE" S MULTIEN=VICEIEN Q
 S MULTIEN=$S(MULTIEN:MULTIEN,1:"+1")
 S FDA(18.121,MULTIEN_","_WEBVER_",",.01)="PSO DOJ/DEA WEB SERVICE"      ; WEB SERVICE
 S FDA(18.121,MULTIEN_","_WEBVER_",",.06)="ENABLED"                      ; STATUS 1-ENABLED / 0-DISABLED
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 Q
 ;
 ;
MSDTHLP ; Migration Start Date/Time Help
 W !,"Enter the scheduled date/time to queue the DEA migration."
 W !,"The migration may several hours to run."
 Q
 ;
MSHLP ; Migration Start Help Text
 W !," During the DEA migration, an attempt is made to migrate"
 W !," all DEA numbers from the NEW PERSON file (#200) to the"
 W !," DEA NUMBERS file (#8991.9). "
 W !
 W !," DEA numbers successfully validated by the DEA web service"
 W !," (PSO DOJ/DEA WEB SERVICE) are migrated and linked to the"
 W !," associated provider in the NEW PERSON file."
 W !
 W !," Providers that cannot be migrated are recorded in the "
 W !," DEA Migration Report [PSO DEA MIGRATION REPORT]."
 W !," Upon completion of the migration, a Mailman message is"
 W !," sent to holders of the PSDMGR key with the subject"
 W !," ""DEA Migration Complete MM/DD/YYYY"", where MM/DD/YYYY is"
 W !," the Date/Time the migration completed."
 W !
 Q
