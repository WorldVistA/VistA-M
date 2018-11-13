RORSET02 ;BPIOFO/CLR - NEW REGISTRY SETUP FROM POST-INSTALL ;6/06/2012
 ;;1.5;CLINICAL CASE REGISTRIES;**18,21,26,33**;Feb 17, 2006;Build 81
 ; This routine uses the following IAs:
 ;
 ; #10063 ^%ZTLOAD            
 ; #10026 ^DIR
 ; #10103 ^XLFDT
 ; #10141 ^XPDUTL
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*21   NOV 2013   T KOPP       Added env check, pre/post install logic
 ;                                     Added new of ZTQUEUED variable
 ;                                     Added initialization of registry params
 ;                                      for new registries
 ;                                     Corrected max # of strings variable used
 ;                                      from MAXNTSK to RORMNTSK
 ;ROR*1.5*26   APR 2015   T KOPP       Corrected 'suspend' parameters to strip
 ;                                      date, leaving only time portions
 ;ROR*1.5*33   MAY 2018   F TRAXLER    ROR TASK scheduling changes
 ;******************************************************************************
 ;******************************************************************************
 ;
 N RORPARM,RORBUF,RORI,RORDIFF,ROROUT,RORMSG,RORSUSP,MAXNTSK
 N RC,REGNAME,RORMNTSK,RORSUSP,TMP,REGLST,RORINFO
 N ZTCPU,ZTDESC,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI,ZTREQ,ZTDTH
 N DIR,DIRUT,Y,DIERR,FLD,NODE,RORERRDL,RORQ,ZTQUEUED
 ;
 S RORPARM("ERR")=1         ; Enable error processing
 S RORPARM("LOG")=1         ; Enable event recording
 D INIT^RORUTL01("RORSET02")
 D CLEAR^RORERR("TASK^RORSET02")
 ;--- display all ACTIVE auto confirm registries that have not been initialized
 D BMES^XPDUTL("   *** Checking for registry(s) to be initialized")
 S RC=$$REGSEL^RORUTL01("UA")
 I RC<0 D BMES^XPDUTL($$MSG^RORERR20(RC,,," file #798.1")),BMES^XPDUTL("") Q
 I '$D(REGLST) D  Q
 . D BMES^XPDUTL(""),BMES^XPDUTL("     No active registries were found needing to be initialized.")
 . D BMES^XPDUTL(""),BMES^XPDUTL("")
 D BMES^XPDUTL(""),BMES^XPDUTL("")
 D BMES^XPDUTL("     The following registry(s) will be populated with new patients: ")
 S REGNAME="" F  S REGNAME=$O(REGLST(REGNAME)) Q:REGNAME=""  D
 . D MES^XPDUTL($J("",10)_REGNAME)
 D BMES^XPDUTL("")
 D BMES^XPDUTL("   *** Storing registry setup parameters")
 S RORMNTSK=$G(XPDQUES("POSQ1")),RORSUSP=$G(XPDQUES("POSQ2"))
 I RORSUSP S RORSUSP=($G(XPDQUES("POSQ3"))#1)_U_($G(XPDQUES("POSQ4"))#1)
 S RORQ=$G(XPDQUES("POSQ5"))
 I RORQ<$$NOW^XLFDT() S RORQ=$$NOW^XLFDT()
 D CONFTXT^RORSETU1(RORMNTSK,RORSUSP)
 ;log parameters in log
 D TP^ROR10(.RORINFO,"RORFLSET")
 D TP^ROR10(.RORINFO,"RORFLCLR")
 D TP^ROR10(.RORINFO,"RORMNTSK")
 D TP^ROR10(.RORINFO,"RORSUSP")
 D LOG^RORLOG(,"Task Parameters",,.RORINFO)
 ;--- Schedule the setup task
 I RORQ<$$NOW^XLFDT() S RORQ=$$NOW^XLFDT()
 S ZTRTN="TASK^RORSET02",ZTIO="",ZTDTH=$$FMTH^XLFDT(RORQ),ZTQUEUED=1
 S ZTDESC="Local Registries Initialization"
 F TMP="RORMNTSK","RORSUSP" S ZTSAVE(TMP)=""
 S ZTSAVE("REGLST(")=""
 D ^%ZTLOAD
 I $G(ZTSK) D  Q
 . D BMES^XPDUTL("The scheduled task number is "_ZTSK)
 D BMES^XPDUTL("")
 D BMES^XPDUTL("     ROR INITIALIZE task was not scheduled and is required")
 D BMES^XPDUTL("     to complete the patch"),BMES^XPDUTL("     Try restarting the install")
 D BMES^XPDUTL("     If this error continues, please enter a Remedy ticket")
 D BMES^XPDUTL("   *** Patch install aborted")
 Q
 ;
ERROR ;--- Display stack errors
 D DSPSTK^RORERR()
 Q
 ;
 ;***** ENTRY POINT OF THE REGISTRY SETUP TASK
 ;
 ; RORMNTSK      Maximum number of the registry update subtasks
 ; RORREG        RegistryIEN^RegistryName
 ; RORSUSP       Task suspension time frame (StartTime^EndTime)
 ;
TASK ;
 N RORERROR      ; Error processing data
 N RORLOG        ; Log subsystem constants & variables
 N RORPARM       ; Application parameters
 ;
 N RC,REGNAME,TMP,REGIEN
 N RORSCHEDDT,RORSCHEDINFO,RORSCHEDULE,RORTASKCHK,RORUNSCHEDULE
 S RORPARM("DEVELOPER")=1   ; Enable modifications
 S RORPARM("ERR")=1         ; Enable error processing
 S RORPARM("LOG")=1         ; Enable event recording
 S RORPARM("SETUP")=1       ; Registry setup indicator
 ;
 ;--- Check if ROR TASK option is running
 S RORTASKCHK=$$TASKCHK^RORUTL18("ROR TASK")
 I RORTASKCHK'=0 D  Q  ;stop if ROR TASK is running
 . S RC=$$ERROR^RORERR(-76,,,,"ROR TASK")
 ;--- Get ROR TASK schedule information
 S RORSCHEDINFO=$$GETSCHED^RORUTL18("ROR TASK")
 ;--- Unschedule ROR TASK option if it is scheduled
 I RORSCHEDINFO'="" S RORUNSCHEDULE=$$SETSCHED^RORUTL18("ROR TASK","@")
 ;--- Check list of registries
 I $D(REGLST)<10  D  Q
 . S RC=$$ERROR^RORERR(-28,,,," initialize")
 ;--- Populate the registry
 S RC=$$UPDATE^RORUPD(.REGLST,$G(RORMNTSK),$G(RORSUSP)) Q:RC<0
 ;--- Setup the registry
 S REGNAME="" F  S REGNAME=$O(REGLST(REGNAME)) Q:REGNAME=""  D
 . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . I REGIEN<0 S RC=$$ERROR^RORERR(-112,,,,REGNAME) Q
 . S RC=$$PREPARE^RORSETU2(REGIEN)
 . I RC<0 S RC=$$ERROR^RORERR(-112,,,,REGNAME) Q
 . ;--- Send the notification e-mail
 . S:RC'<0 TMP=$$SENDINFO^RORUTL17(+REGIEN,,"E")
 . ;--- Cleanup
 . I RC'<0 D  S ZTREQ="@"
 . . K ^XTMP("RORUPDR"_+REGIEN)
 ;--- reschedule ROR TASK option
 N XMY,XMSUB,XMTEXT
 S RORSCHEDINFO=$G(RORSCHEDINFO)
 I RORSCHEDINFO="" D  Q  ;ROR TASK is not currently in FILE 19.2
 . S XMY(DUZ)="" ;message recipient
 . S XMSUB="ROR TASK option must be scheduled"
 . S XMTEXT(1)="Please use the Schedule/Unschedule Options [XUTM SCHEDULE]"
 . S XMTEXT(2)="option to schedule the ROR TASK option to run as a regular"
 . S XMTEXT(3)="background job."
 . S XMTEXT(4)=" "
 . S XMTEXT(5)="Set the time of day to whatever you think best."
 . S XMTEXT(6)="Set the Rescheduling Frequency = 1D"
 . S XMTEXT(7)="Set the Task Parameters = VA HEPC, VA HIV"
 . S XMTEXT="XMTEXT("
 . D ^XMD
 S RORSCHEDDT=$$FMADD^XLFDT($$NOW^XLFDT(),,1) ;use 1 hour from now
 S RORSCHEDULE=$$SETSCHED^RORUTL18("ROR TASK",RORSCHEDDT,,"1D",,,1)
 ;Send MailMan message about ROR TASK option rescheduling success
 I RORSCHEDULE=1 D
 . S RORSCHEDINFO=$$GETSCHED^RORUTL18("ROR TASK")
 . S XMY(DUZ)="" ;message recipient
 . S XMSUB="ROR TASK option was rescheduled"
 . S XMTEXT(1)="The ROR TASK option was successfully rescheduled."
 . S XMTEXT(2)=" "
 . S XMTEXT(3)="You may wish to check/alter the scheduling conditions, but"
 . S XMTEXT(4)="please keep this option scheduled at all times unless a ROR"
 . S XMTEXT(5)="patch is being installed."
 . S XMTEXT(6)=" "
 . S XMTEXT(7)="Use Schedule/Unschedule Options [XUTM SCHEDULE] to check."
 . S XMTEXT="XMTEXT("
 I RORSCHEDULE'=1 D
 . S XMY(DUZ)="" ;message recipient
 . S XMSUB="ROR TASK option was not rescheduled"
 . S XMTEXT(1)="The ROR TASK option could not be rescheduled."
 . S XMTEXT(2)="Please reschedule it as soon as possible."
 . S XMTEXT(3)="ROR TASK should be scheduled to run daily unless a ROR"
 . S XMTEXT(4)="patch is being installed."
 . S XMTEXT(5)=" "
 . S XMTEXT(6)="Use the Schedule/Unschedule Options [XUTM SCHEDULE] option"
 . S XMTEXT(7)="to schedule ROR TASK."
 . S XMTEXT="XMTEXT("
 D ^XMD
 Q
