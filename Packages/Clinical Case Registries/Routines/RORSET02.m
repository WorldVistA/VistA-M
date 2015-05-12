RORSET02 ;BPIOFO/CLR - NEW REGISTRY SETUP FROM POST-INSTALL ;6/06/2012
 ;;1.5;CLINICAL CASE REGISTRIES;**18,21**;Feb 17, 2006;Build 45
 ; This routine uses the following IAs:
 ;
 ; #10063 ^%ZTLOAD            
 ; #10026 ^DIR
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
 ;******************************************************************************
 ;******************************************************************************
 ;
 N RORPARM,RORBUF,RORI,RORDIFF,ROROUT,RORMSG,RORSUSP,MAXNTSK
 N RC,REGNAME,RORMNTSK,RORSUSP,TMP,REGLST,RORINFO
 N ZTCPU,ZTDESC,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI,ZTREQ
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
 I RORSUSP S RORSUSP=$G(XPDQUES("POSQ3"))_U_$G(XPDQUES("POSQ4"))
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
 S RORPARM("DEVELOPER")=1   ; Enable modifications
 S RORPARM("ERR")=1         ; Enable error processing
 S RORPARM("LOG")=1         ; Enable event recording
 S RORPARM("SETUP")=1       ; Registry setup indicator
 ;
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
 Q
 ;
