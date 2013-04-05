RORSET02 ;BPIOFO/CLR - NEW REGISTRY SETUP  ;6/06/2012
 ;;1.5;CLINICAL CASE REGISTRIES;**18**;Feb 17, 2006;Build 25
 ; This routine uses the following IAs:
 ;
 ; #10063 ^%ZTLOAD            
 ; #2053  FILE^DIE
 ; #10013 ^DIK
 ; #2055  $$ROOT^DILFD
 ; #10026 ^DIR
 ;
 N RORPARM,RORBUF,RORI,RORDIFF,ROROUT,RORMSG
 N RC,REGNAME,RORMNTSK,RORSUSP,TMP,REGLST
 N ZTCPU,ZTDESC,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI,ZTREQ
 N DIR,DIRUT,Y,DIERR,FLD,NODE
 ;
 S RORPARM("ERR")=1         ; Enable error processing
 S RORPARM("LOG")=1         ; Enable event recording
 ;--- display all ACTIVE auto confirm registries that have not been initialized
 S RC=$$REGSEL^RORUTL01("UA")
 I RC<0 W !,$$MSG^RORERR20(RC,,," file #798.1"),! Q
 I '$D(REGLST) W !!?5,"All registries have been successfully initialized.",!! Q
 W !!?4,"The following registries will be populated with new patients: "
 S REGNAME="" F  S REGNAME=$O(REGLST(REGNAME)) Q:REGNAME=""  D
 . W !?10,REGNAME
 W !
 ;--- Check if ROR INITIALIZE is running
 S RC=0
 D RTN^%ZTLOAD("RORSET02","RORBUF")
 S ZTSK="" F  S ZTSK=$O(RORBUF(ZTSK)) Q:ZTSK=""  D  I $G(ZTSK(1))=2 S RC=-1 Q
 . D STAT^%ZTLOAD
 ;--- Display error message if option is running
 I RC<0  D  Q
 . W !?4,"ROR INITIALIZE is already running.",!
 ;--- Display last run of ROR TASK
 D LIST^DIC(798.7,,"@;.01IE;1;5IE","B",1,,,"B","I $P(^(0),U,3)=7",,"RORBUF","RORMSG")
 I '$D(DIERR) D
 . S NODE=$NA(RORBUF("DILIST","ID",1))
 . I @NODE@(5,"I")="" W !?4,"ROR TASK last started on "_@NODE@(.01,"E")_" and has not completed.",! Q
 . S RORDIFF=$$FMDIFF^XLFDT(@NODE@(5,"I"),@NODE@(.01,"I"),3)
 . I +RORDIFF=RORDIFF S ROROUT=+RORDIFF_"d 0h 0m 0s"
 . E  S ROROUT=(+$P(RORDIFF," ")_"d ")_(+$P(RORDIFF," ",2)_"h ")_(+$P(RORDIFF,":",2)_"m ")_(+$P(RORDIFF,":",3)_"s")
 . W !?4,"ROR TASK last ran on "_@NODE@(.01,"E")_" and took "_ROROUT,!
 ;--- Display schedule of ROR TASK
 S RC=$$CHKOPT^RORKIDS("ROR TASK")
 Q:RC<0
 ;--- prompt do you wish to continue
 S DIR("B")="NO",DIR(0)="Y",DIR("A")="Do you wish to continue"
 D ^DIR I $D(DIRUT) S Y=0
 Q:'+Y
 ;--- Request setup parameters
 S RC=$$ASKPARMS^RORSETU1(.RORMNTSK,.RORSUSP)
 I RC<0  Q:(RC=-71)!(RC=-72)  G ERROR
 ;--- Schedule the setup task
 S ZTRTN="TASK^RORSET02",ZTIO=""
 S ZTDESC="Local Registries Initialization"
 F TMP="RORMNTSK","RORSUSP"  S ZTSAVE(TMP)=""
 S ZTSAVE("REGLST(")=""
 D ^%ZTLOAD
 I $G(ZTSK) W !,"The scheduled task number is ",ZTSK
 Q
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
 . ;--- Send an alert to the originator of the task
 . D ALERT^RORKIDS(DUZ,"Initialization of registry "_$G(REGNAME)_" succeeded")
 . ;--- Cleanup
 . I RC'<0 D  S ZTREQ="@"
 . . K ^XTMP("RORUPDR"_+REGIEN)
 Q
 ;DEFINE ENTRY POINT TO CLEAR AND RESTART REGISTRY UPDATE
DEL(REGLST) ;
 ;Select new registry to delete
 ;delete any records in 798 for that registry
 ;delete enable protocols,hdt,registry updated until
 N REGNAME,REGIEN,IEN,DA,DIK,RORFDA,IENS,RORMSG,DIERR
 N FILE,ROOT,IX,RORPARM,FLD
 S (REGNAME,IEN)=""
 S RORPARM("DEVELOPER")=1
 F  S REGNAME=$O(REGLST(REGNAME)) Q:REGNAME=""  D
 . S REGIEN=$$REGIEN^RORUTL02(REGNAME) Q:REGIEN=""
 . S IENS=REGIEN_","
 . F FLD=6.1,6.2,7,10,13,13.1,19.1,19.2,19.3,21.01,21.04,21.05 D
 . . S RORFDA(798.1,IENS,FLD)="@"
 . S RORFDA(798.1,IENS,1)=2850101
 . D FILE^DIE(,"RORFDA","RORMSG")
 . I $G(DIERR) W !!,"<<ERROR - restoring "_REGNAME_" registry parameters>>" Q
 . F  S IEN=$O(^RORDATA(798,"AC",REGIEN,IEN)) Q:IEN=""  D
 . . N DA,DIK
 . . S DIK=$$ROOT^DILFD(798),DA=IEN  D ^DIK
 . . W !,"<< "_IEN_" >> Deleted"
 Q
 ;
