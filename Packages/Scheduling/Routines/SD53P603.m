SD53P603 ;ALB/ART - SD*5.3*603 Post Install ;02/27/2015
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 QUIT
 ;
 ;Public, Supported ICRs
 ; #2050 - Database Server (DBS) API: DIALOG Utilities
 ; #2051 - Database Server API: Lookup Utilities (DIC)
 ; #2053 - Data Base Server API: Editing Utilities (DIE)
 ; #2054 - Data Base Server API: Misc. Library Functions (DILF)
 ; #2916 - Data Base Server API: DD Modification Utilities (DDMOD)
 ; #5421 - XOBWLIB - Public APIs for HWSC
 ; #10013 - Classic FileMan API: Entry Deletion & File Reindexing (DIK)
 ; #10063 - %ZTLOAD
 ; #10070 - XMD - Mailman API
 ; #10075 - OPTION FILE
 ; #10103 - XLFDT - Supported APIs for date & time
 ; #10141 - XPDUTL - Public APIs for KIDS
 ;Subscription
 ; #4677 - Application Proxy (XUSAP)
 ;Private
 ; #6121 - REMOVE PCMM NIGHTLY TASKS FROM FILE #19.2
 ; #6168 - READ ACCESS TO DD(404.52
 ; #6171 - READ WRITE ACCESS TO WEB SERVER FILE
 ; #6172 - WRITE ACCESS TO WEB SERVER LOOKUP KEY FILE
 ; #6173 - READ ACCESS TO THE WEB SERVICE FILE
 ;
EN ;
 ;
 ;Add/update records in 18.02, 18.12, 18.13 for HWSC web service
 DO SETHWSC
 ;
 ;Create PCMMR Application Proxy User - user needs XUMGR security key
 DO ADDPROXY
 ;
 ; Convert Status (.12) in 404.43 from NA to IU
 DO CNVTSTAT
 ;
 ;Delete PCMM Nightly Task from Option Scheduling file (#19.2)
 DO DLNITTSK
 ;
 ;Disable Legacy PCMM Menus
 DO DISMENU
 ;
 ;add 2 records to Team Purpose (403.47)
 DO TEAMPURP
 ;
 ;Change New Person Records that have SCMC PCMM GUI WORKSTATION to SCMC PCMMR WEB USER MENU
 DO SECMENU
 ;
 ;Delete FTEE History trigger in 404.52
 DO DELTRIGR
 ;
 ;Build Patient Team Position Assignment File C cross reference
 DO BLDINDX2
 ;
 ;Build Oupatient Encounters ACOD index
 DO JOBINDEX
 ;
 ;Create Outpatient Encounters 'ACOD' index for child encounters
 DO ACOD
 ;
 QUIT
 ;
SETHWSC ;Add/update records in 18.02, 18.12, 18.13
 NEW SDSVC,SDROOT
 NEW SDSVRNM1,SDSVRNM2,SDADRS,SDPORT
 NEW SDI,SDKEYNM,SDKEYDSC,SDKEYIEN,SDSVR1,SDSVR2,SDREGIEN,SDFDA,SDFDAI,SDIENS,SDERR,DIERR
 NEW SDSVCIEN
 ; future-get these values from "config file"
 ; patient care info service
 SET SDSVC="PCMM-R GET PC INFO REST"
 SET SDROOT="pcmmr_web/ws/patientSummary"
 ;
 ; add/update web service record
 DO REGREST^XOBWLIB(SDSVC,SDROOT,"")
 ;
 ; add/update PCMMR production web server (1)
 SET SDSVRNM1="PCMMR"
 SET SDADRS="127.0.0.1"
 SET SDADRS="vaww-pcmm.cc.domain.ext"
 SET SDPORT=80
 SET SDSVR1=$$FILESRVR(SDSVRNM1,SDADRS,SDPORT)
 DO MES^XPDUTL(" o  WEB SERVER '"_SDSVRNM1_"' addition/update "_$SELECT(SDSVR1:"succeeded.",1:"failed."))
 DO MES^XPDUTL(" ")
 QUIT:'SDSVR1
 ;
 ; add web service to web server
 DO SERVICE(SDSVC,SDSVR1,SDSVRNM1)
 ;
 ; add/update PCMMR TEST web server (2)
 SET SDSVRNM2="PCMMR TEST"
 SET SDADRS="vaww-sqa-x.ciss.cc.domain.ext"
 SET SDADRS="127.0.0.1" ; remove this line when load balancer is back online <<<<<<<<<<<<<<<
 SET SDPORT=10100
 SET SDSVR2=$$FILESRVR(SDSVRNM2,SDADRS,SDPORT)
 DO MES^XPDUTL(" o  WEB SERVER '"_SDSVRNM2_"' addition/update "_$SELECT(SDSVR2:"succeeded.",1:"failed."))
 DO MES^XPDUTL(" ")
 QUIT:'SDSVR2
 ;
 ; add web service to web server
 DO SERVICE(SDSVC,SDSVR2,SDSVRNM2)
 ;
 ; add/update prod server lookup key
 SET SDKEYNM="PCMMR SERVER"
 SET SDKEYDSC="Web server for PCMMR transactions"
 SET SDKEYIEN=$$SKEYADD^XOBWLIB(SDKEYNM,SDKEYDSC)
 DO MES^XPDUTL(" o  WEB SERVER LOOKUP KEY '"_SDKEYNM_"' addition/update "_$SELECT(SDKEYIEN:"succeeded.",1:"failed."))
 DO MES^XPDUTL(" ")
 ;
 DO LKUPKEY(SDSVR1,SDKEYIEN,SDSVRNM1)
 ;
 ; add/update test server lookup key
 SET SDKEYNM="PCMMR TEST SERVER"
 SET SDKEYDSC="Web server (test system) for PCMMR transactions"
 SET SDKEYIEN=$$SKEYADD^XOBWLIB(SDKEYNM,SDKEYDSC)
 DO MES^XPDUTL(" o  WEB SERVER LOOKUP KEY '"_SDKEYNM_"' addition/update "_$SELECT(SDKEYIEN:"succeeded.",1:"failed."))
 DO MES^XPDUTL(" ")
 ;
 DO LKUPKEY(SDSVR2,SDKEYIEN,SDSVRNM2)
 ;
 QUIT
 ;
SERVICE(SDSVC,SDSVRIEN,SDSRVR) ; add web service to web server
 ; Input: SDSVC    - web service name
 ;        SDSVRIEN - web server ien
 ;        SDSRVR   - web server name
 ;
 NEW SDSVCIEN,SDIENS,SDFDA,SDFDAI,SDERR,DIERR
 ;
 SET SDSVCIEN=+$$FIND1^DIC(18.02,"","BX",SDSVC,"","","")
 IF '$DATA(^XOB(18.12,"AB",SDSVCIEN,SDSVRIEN)) DO
 . ;add sub rec
 . SET SDIENS="+1,"_SDSVRIEN_","
 . SET SDFDA(18.121,SDIENS,.01)=SDSVCIEN ;service ien
 . SET SDFDA(18.121,SDIENS,.06)=1 ;status
 . DO UPDATE^DIE("","SDFDA","SDFDAI","SDERR")
 . IF $DATA(DIERR) DO
 . . DO DISPERR($NAME(SDERR))
 . . DO MES^XPDUTL(" o  ERROR occurred registering WEB SERVICE '"_SDSVC_"' to WEB SERVER '"_SDSRVR_"'")
 . . DO MES^XPDUTL(" ")
 . ELSE  DO
 . . DO MES^XPDUTL(" o  WEB SERVICE '"_SDSVC_"' was registered to WEB SERVER '"_SDSRVR_"'")
 . . DO MES^XPDUTL(" ")
 . DO CLEAN^DILF
 ELSE  DO
 . DO MES^XPDUTL(" o  WEB SERVICE '"_SDSVC_"' already registered to WEB SERVER '"_SDSRVR_"'")
 . DO MES^XPDUTL(" ")
 ;
 QUIT
 ;
LKUPKEY(SDSVRIEN,SDKEYIEN,SDSRVR) ; point lookup key to server
 ; Input: SDSVRIEN - web server ien
 ;        SDKEYIEN - lookup key ien
 ;        SDSRVR   - web server name
 NEW SDFDA
 IF $GET(SDSVRIEN),$GET(SDKEYIEN) DO
 . SET SDIENS=SDKEYIEN_","
 . SET SDFDA(18.13,SDIENS,.03)=SDSVRIEN ;server ien
 . DO FILE^DIE("K","SDFDA","SDERR")
 . IF $DATA(DIERR) DO
 . . DO DISPERR($NAME(SDERR))
 . ELSE  DO
 . . DO MES^XPDUTL(" o  WEB SERVER LOOKUP KEY '"_SDKEYNM_"' pointed to WEB SERVER '"_SDSRVR_"'")
 . . DO MES^XPDUTL(" ")
 ELSE  DO
 . DO MES^XPDUTL(" o  WEB SERVER LOOKUP KEY not assigned because of previous errors.")
 . DO MES^XPDUTL(" ")
 ;
 QUIT
 ;
FILESRVR(SDSRVR,SDADRS,SDPORT) ; File a new record in file #18.12 or edit existing
 ; Input: SDSRVR - web server name
 ;        SDADRS - web server address
 ;        SDPORT - port number
 ; Output:
 ;    Function Value - Returns IEN of record on success, 0 on failure
 ;
 NEW SDFDA,SDFDAI,SDERR,SDIENS,SDIEN,DIERR
 ;
 SET SDIEN=+$$FIND1^DIC(18.12,"","BX",SDSRVR,"","","")
 ;
 ; If record doesn't already exist, create new
 IF SDIEN DO
 . SET SDIENS=SDIEN_","
 ELSE  DO
 . SET SDIENS="+1,"
 ;
 ; Set up FDA with field values
 SET SDFDA(18.12,SDIENS,.01)=$GET(SDSRVR) ;server name
 SET SDFDA(18.12,SDIENS,.03)=$GET(SDPORT) ;ws port nbr
 SET SDFDA(18.12,SDIENS,.04)=$GET(SDADRS) ;server address
 SET SDFDA(18.12,SDIENS,.06)=1 ;status
 SET SDFDA(18.12,SDIENS,.07)=30 ;timeout
 SET SDFDA(18.12,SDIENS,1.01)=0 ;login required
 SET SDFDA(18.12,SDIENS,3.01)=0 ;ssl enabled
 ;
 IF SDIEN DO  ;update current record
 . DO FILE^DIE("K","SDFDA","SDERR")
 . IF $DATA(DIERR) DO
 . . DO DISPERR($NAME(SDERR))
 . . SET SDIEN=0
 ELSE  DO  ;create new record
 . DO UPDATE^DIE("","SDFDA","SDFDAI","SDERR")
 . IF $DATA(DIERR) DO
 . . DO DISPERR($NAME(SDERR))
 . . SET SDIEN=0
 . ELSE  DO
 . . SET SDIEN=$GET(SDFDAI(1))
 ;
 QUIT $SELECT($GET(SDIEN)>0:SDIEN,1:0)
 ;
DISPERR(SDINARR) ; display error message
 NEW SDOUT,SDI
 WRITE !,"FM Database Server Error Information:"
 DO MSG^DIALOG("AE",.SDOUT,70,"",SDINARR)
 FOR SDI=1:1 QUIT:$D(SDOUT(SDI))=0  WRITE !,$GET(SDOUT(SDI))
 QUIT
 ;
ADDPROXY ;Create PCMMR Application Proxy User
 ;User needs XUMGR security key for this to work
 ; ICR 4677 - Application Proxy
 ;
 NEW SDOPT,SDRTN
 SET SDOPT("SCMC PCMMR APP PROXY MENU")=1
 SET SDRTN=$$CREATE^XUSAP("SCMC,APPLICATION PROXY","",.SDOPT)
 IF SDRTN DO  QUIT
 . DO MES^XPDUTL(" o  SCMC,APPLICATION PROXY user was created.")
 . DO MES^XPDUTL(" ")
 IF +SDRTN=0 DO
 . DO MES^XPDUTL(" o  SCMC,APPLICATION PROXY user already exists.")
 . DO MES^XPDUTL(" ")
 ELSE   DO
 . DO MES^XPDUTL(" o  Error creating SCMC,APPLICATION PROXY user ")
 . DO MES^XPDUTL(" ")
 QUIT
 ;
DISMENU ;Disable Legacy PCMM Menu Options
 ;
 DO OPTOUT^SCMCOPT
 DO MES^XPDUTL(" o  Legacy PCMM Menu Options have been placed Out of Order")
 DO MES^XPDUTL(" ")
 QUIT
 ;
SECMENU ;Change New Person Records that have SCMC PCMM GUI WORKSTATION to SCMC PCMMR WEB USER MENU
 ;
 DO SECMENU^SCMCOPT
 DO MES^XPDUTL(" o  New Person records with Secondary Menu Option SCMC PCMM GUI WORKSTATION changed to SCMC PCMMR WEB USER MENU")
 DO MES^XPDUTL(" ")
 QUIT
 ;
BLDINDEX ;Build Outpatient Encounters ACOD index
 ;
 ; #10141 - XPDUTL - Public APIs for KIDS
 ; #10013 - Classic Fileman API: Entry Deletion & File Reindexing (DIK)
 ; #10103 - XLFDT - Supported APIs for date & time
 ;
 IF $DATA(^SCE("ACOD")) DO  QUIT
 . DO MES^XPDUTL(" o  Outpatient Encounters ACOD index already exists.")
 . DO MES^XPDUTL(" ")
 ;
 DO MES^XPDUTL(" o  Building Outpatient Encounters ACOD index.")
 DO MES^XPDUTL(" o  This may take a while, there are "_$PIECE(^SCE(0),U,4)_" records.")
 DO MES^XPDUTL(" ")
 NEW DIK,SDSTART,SDEND
 SET SDSTART=$$NOW^XLFDT()
 SET DIK="^SCE("
 SET DIK(1)=".02^ACOD"
 DO ENALL^DIK
 SET SDEND=$$NOW^XLFDT()
 DO MES^XPDUTL(" o  Outpatient Encounters ACOD index completed.")
 DO MES^XPDUTL("      Elapsed time: "_$$FMDIFF^XLFDT(SDEND,SDSTART,3))
 DO MES^XPDUTL(" ")
 ;
 QUIT
 ;
JOBINDEX ;Build Outpatient Encounters ACOD index
 ;
 ; #10141 - XPDUTL - Public APIs for KIDS
 ; #10013 - Classic Fileman API: Entry Deletion & File Reindexing (DIK)
 ; #10103 - XLFDT - Supported APIs for date & time
 ;
 DO MES^XPDUTL(" o  Submitting Build Outpatient Encounters ACOD Index to Taskman.")
 DO MES^XPDUTL(" o  A Mailman message will be sent when it has completed.")
 DO MES^XPDUTL(" ")
 ;
 NEW SDDUZ,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTIO
 SET SDDUZ=DUZ
 SET ZTRTN="BLDACOD^SD53P603"
 SET ZTDESC="Build Outpatient Encounters ACOD Index"
 SET ZTDTH=$$NOW^XLFDT()
 SET ZTIO=""
 SET ZTSAVE("SDDUZ")=""
 ;Submit the job to Taskman
 DO ^%ZTLOAD
 ;
 QUIT
 ;
BLDACOD ;Build Outpatient Encounters ACOD index
 ;
 ; #10013 - Classic Fileman API: Entry Deletion & File Reindexing (DIK)
 ; #10070 - XMD - Mailman API
 ; #10103 - XLFDT - Supported APIs for date & time
 ;
 NEW DIK,SDSTART,SDEND,SDX,SDECDT,SDHIT,SDMSG,XMSUB
 SET SDSTART=$$NOW^XLFDT()
 SET SDHIT=0
 ;
 SET SDX=""
 FOR  SET SDX=$ORDER(^SCE("ACOD",SDX)) QUIT:SDX=""!(SDHIT)  DO
 . SET SDECDT=""
 . FOR  SET SDECDT=$ORDER(^SCE("ACOD",SDX,SDECDT)) QUIT:SDECDT=""!(SDHIT)  DO
 . . SET:+$$FMDIFF^XLFDT(SDSTART,SDECDT,1)>3 SDHIT=1
 IF SDHIT DO  QUIT
 . SET XMSUB="Outpatient Encounters ACOD Index Already Exists"
 . SET SDMSG(1)="The Outpatient Encounters ACOD index already exists."
 . DO SENDMAIL(XMSUB,.SDMSG)
 ;
 KILL ^SCE("ACOD")
 SET DIK="^SCE("
 SET DIK(1)=".02^ACOD"
 DO ENALL^DIK
 SET SDEND=$$NOW^XLFDT()
 ;
 ; send mail message
 SET XMSUB="Build Outpatient Encounters ACOD Index has Completed"
 SET SDMSG(1)="Building the Outpatient Encounters ACOD index has completed."
 SET SDMSG(2)="  There were "_$PIECE(^SCE(0),U,4)_" data records in the file."
 SET SDMSG(3)="  Elapsed time: "_$$FMDIFF^XLFDT(SDEND,SDSTART,3)
 DO SENDMAIL(XMSUB,.SDMSG)
 QUIT
 ;
SENDMAIL(XMSUB,SDMSG) ;send Mailman message
 ; Input: XMSUB - Mail message subject
 ;        SDMSG - Mail message text, by reference
 ;
 NEW XMDUZ,XMTEXT,XMY,XMZ,XMMG
 ;
 SET XMDUZ=.5 ;$GET(DUZ,.5)
 SET:$GET(SDDUZ)="" SDDUZ=DUZ
 SET XMY(SDDUZ)=""
 SET XMTEXT="SDMSG("
 DO ^XMD
 ;
 QUIT
 ;
BLDINDX2 ;Patient Team Position Assignment File (#404.43) C cross reference
 ;
 ; #10141 - XPDUTL - Public APIs for KIDS
 ; #10013 - Classic FileMan API: Entry Deletion & File Reindexing (DIK)
 ; #10103 - XLFDT - Supported APIs for date & time
 ;
 IF $DATA(^SCPT(404.43,"C")) DO  QUIT
 . DO MES^XPDUTL(" o  Patient Team Position Assignment C cross reference already exists.")
 . DO MES^XPDUTL(" ")
 ;
 DO MES^XPDUTL(" o  Patient Team Position Assignment C cross reference.")
 DO MES^XPDUTL(" o  There are "_$PIECE(^SCPT(404.43,0),U,4)_" records to cross reference.")
 DO MES^XPDUTL(" ")
 NEW DIK,SDSTART,SDEND
 SET SDSTART=$$NOW^XLFDT()
 SET DIK="^SCPT(404.43,"
 SET DIK(1)=".02^C"
 DO ENALL^DIK
 SET SDEND=$$NOW^XLFDT()
 DO MES^XPDUTL(" o  Patient Team Position Assignment C cross reference completed.")
 DO MES^XPDUTL("      Elapsed time: "_$$FMDIFF^XLFDT(SDEND,SDSTART,3))
 DO MES^XPDUTL(" ")
 ;
 QUIT
 ;
DLNITTSK ; Delete SCMC PCMM NIGHTLY TASK from the Scheduled Options file
 NEW TSKNAM,OPT,DA,DIK
 SET TSKNAM="SCMC PCMM NIGHTLY TASK"
 SET OPT=+$$FIND1^DIC(19,"","BX",TSKNAM,"","","")
 SET DA=""
 FOR  SET DA=$ORDER(^DIC(19.2,"B",OPT,DA)) QUIT:'+DA  DO
 . SET DIK="^DIC(19.2,"
 . DO ^DIK
 ;
 DO MES^XPDUTL(" o  SCMC PCMM NIGHTLY TASK deleted from the Scheduled Options file.")
 DO MES^XPDUTL(" ")
 QUIT
 ;
CNVTSTAT ; Convert Status (.12) in 404.43 from NA to IU
 ;
 NEW SDIEN,SDIENS,SDFDA,SDERR
 SET SDIEN=""
 FOR  SET SDIEN=$ORDER(^SCPT(404.43,"ASTATB","NA",SDIEN)) QUIT:SDIEN=""  DO
 . SET SDIENS=SDIEN_","
 . NEW SDFDA
 . SET SDFDA(404.43,SDIENS,.12)="IU" ;status name
 . DO FILE^DIE("K","SDFDA","SDERR")
 ;
 DO MES^XPDUTL(" o  Convert Status (.12) in Patient Team Position Assignment (404.43) from NA to IU has completed.")
 DO MES^XPDUTL(" ")
 ;
 QUIT
 ;
ACOD ;Create Outpatient Encounters 'ACOD' index for child encounters
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTIO,SDUZ
 D BMES^XPDUTL("Building Outpatient Encounters 'ACOD' index for child encounters.")
 D MES^XPDUTL("This job will be tasked to run in the background.")
 D MES^XPDUTL("A MailMan message will be sent to the installer upon completion.")
 D BMES^XPDUTL("")
 S SDUZ=DUZ
 S ZTRTN="ACODIND^SD53P603"
 S ZTDESC="Build missing child Outpatient Encounters 'ACOD' Index"
 S ZTDTH=$$NOW^XLFDT()
 S ZTIO=""
 S ZTSAVE("SDUZ")=""
 ;Submit the job to Taskman
 D ^%ZTLOAD
 ;D ACODIND
 Q
 ;
ACODIND ;Build missing ACOD index for child encounters checked out on or after 04/01/14
 N SDSTART,SDEND,SDDT,SD0,SDPE,CODT,SDFN,CNT,IEN,DA,DIK
 S SDSTART=$$NOW^XLFDT()
 S SDDT=3140331.9999
 S CNT=0
 S DIK="^SCE("
 F  S SDDT=$O(^SCE("B",SDDT)) Q:'SDDT  S IEN=0 D
 .F  S IEN=$O(^SCE("B",SDDT,IEN)) Q:'IEN  D
 ..S SD0=$G(^SCE(IEN,0)) Q:'SD0
 ..;check if parent encounter then quit
 ..S SDPE=$P(SD0,"^",6) I SDPE="" Q
 ..;if no DFN or check out process completion date then quit
 ..S SDFN=$P(SD0,"^",2),CODT=$P(SD0,"^",7) I (SDFN="")!(CODT="") Q
 ..;if parent encounter has no "ACOD" then quit, not checked out
 ..I '$D(^SCE("ACOD",SDFN,CODT,SDPE)) Q
 ..;if 'ACOD' index already exist for child then quit
 ..I $D(^SCE("ACOD",SDFN,CODT,IEN)) Q
 ..S DA=IEN,DIK(1)=".02^ACOD",CNT=CNT+1
 ..D EN1^DIK
 S SDEND=$$NOW^XLFDT()
 D MAIL
 Q
 ;
MAIL ;Generate MailMan message
 N XMDUZ,XMSUB,XMDUN,XMTEXT,XMY,XMZ,XMMG,SDMSG
 S XMDUZ=.5
 S XMY(SDUZ)=""
 S XMSUB="Build completed for missing 'ACOD' Index child Outpatient Encounters"
 S SDMSG(1)="Build of missing child Outpatient Encounters 'ACOD' index has been completed."
 S SDMSG(2)="  There were "_CNT_" 'ACOD' index added for child encounters in File (#409.68)."
 S SDMSG(3)="  Start time:   "_$$FMTE^XLFDT(SDSTART,"2F")
 S SDMSG(4)="  End time:     "_$$FMTE^XLFDT(SDEND,"2F")
 S SDMSG(5)="  Elapsed time: "_$$FMDIFF^XLFDT(SDEND,SDSTART,3)
 S XMTEXT="SDMSG("
 D ^XMD
 Q
 ;
DELTRIGR ;Delete FTEE History trigger in 404.52
 ;
 ;ICR 6168 - READ ACCESS TO DD(404.52
 ;
 NEW SDERR
 DO BMES^XPDUTL("Delete the FTEXR Trigger in 404.52/.09")
 ;
 IF $DATA(^DD(404.52,.09,1,2,0)),^DD(404.52,.09,1,2,0)["FTEXR" DO
 . DO DELIX^DDMOD(404.52,.09,2,"","SDERR")
 . IF '$DATA(SDERR) DO
 . . DO BMES^XPDUTL("The FTEXR trigger was deleted.")
 . ELSE  DO
 . . DO BMES^XPDUTL("ERROR encountered deleting the trigger.")
 ELSE  DO
 . DO BMES^XPDUTL("The FTEXR trigger does not exist - previously deleted.")
 QUIT
 ;
TEAMPURP ;add 2 records to Team Purpose (403.47)
 ;
 NEW SDNAME,SDDESC,SDI
 ;
 SET SDNAME(1)="PRIMARY CARE - NVCC"
 SET SDNAME(2)="PRIMARY CARE - HBPC"
 SET SDDESC(1)="Primary Care teams staffed by non-VA providers."
 SET SDDESC(2)="Primary Care teams providing Home Based Primary Care."
 ;
 FOR SDI=1:1:2 DO
 . NEW SDFDA,SDFDAI,SDERR,SDIEN,DIERR,SDWP
 . SET SDIEN=+$$FIND1^DIC(403.47,"","BX",SDNAME(SDI),"","","")
 . ; If record doesn't already exist, create new
 . IF 'SDIEN DO
 . . SET SDFDA(403.47,"+1,",.01)=SDNAME(SDI) ;name
 . . DO UPDATE^DIE("","SDFDA","SDFDAI","SDERR")
 . . IF $DATA(SDERR) DO  QUIT
 . . . DO TPERR($NAME(SDERR))
 . . SET SDWP(1,0)=SDDESC(SDI)
 . . DO WP^DIE(403.47,SDFDAI(1)_",",1,"K","SDWP")
 ;
 QUIT
 ;
TPERR(SDINARR) ; display error message
 NEW SDOUT,SDI
 WRITE !,"Create Team Purpose Error:"
 DO MSG^DIALOG("AE",.SDOUT,70,"",SDINARR)
 FOR SDI=1:1 QUIT:$D(SDOUT(SDI))=0  WRITE !,$GET(SDOUT(SDI))
 QUIT
 ;
