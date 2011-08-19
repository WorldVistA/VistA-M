RORSET01 ;HCIOFO/SG - REGISTRY SETUP ROUTINE ; 1/27/06 11:00am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ;***** HEPC REGISTRY SETUP
 ;
 N RORERROR      ; Error processing data
 N RORLOG        ; Log subsystem constants & variables
 N RORPARM       ; Application parameters
 ;
 N LSNAME,RC,REGNAME,RORHDT,RORMNTSK,RORREG,RORSUSP,TMP
 N ZTCPU,ZTDESC,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI
 S RORPARM("ERR")=1         ; Enable error processing
 S RORPARM("SETUP")=1       ; Registry setup indicator
 ;
 ;--- IEN and name of the registry
 S RORREG=$$SELREG^RORUTL18(.REGNAME)  G:RORREG<0 ERROR
 Q:'RORREG
 S $P(RORREG,U,2)=REGNAME,LSNAME=REGNAME
 ;
 ;--- Check the Lab Search
 S RC=$$LABSRCH^RORSETU2(LSNAME)
 S RC=$S(RC=-55:$$LSCONF^RORSETU1(LSNAME),RC<0:RC,1:1)
 Q:'RC  G:RC<0 ERROR
 ;
 ;--- Request setup parameters
 S RC=$$ASKPARMS^RORSETU1(.RORMNTSK,.RORSUSP)
 I RC<0  Q:(RC=-71)!(RC=-72)  G ERROR
 ;
 ;--- Schedule the setup task
 S ZTRTN="TASK^RORSET01",ZTIO=""
 S ZTDESC="Registry Setup ("_$P(RORREG,U,2)_")"
 F TMP="RORMNTSK","RORREG","RORSUSP"  S ZTSAVE(TMP)=""
 D ^%ZTLOAD
 Q
ERROR ;--- Display the errors
 D DSPSTK^RORERR()
 Q
 ;
 ;***** REPLACES THE SELECTION RULES
 ;
 ; RORREG        Registry IEN and registry name separated by the '^'
 ;               (RegistryIEN^RegistryName).
 ; FROM,TO       Codes of the rule groups (1-regular, 2-historical)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RULES(RORREG,FROM,TO) ;
 ;;VA HEPC PTF^VA HEPC PTF HIST
 ;;VA HEPC VISIT^VA HEPC VISIT HIST
 ;
 N I,IEN,IENS,NAMES,RC,RORFDA,RORMSG
 S IENS=","_(+RORREG)_",",RC=0
 ;--- Replace the selection rules
 F I=1,2  D  Q:RC<0
 . S NAMES=$P($T(RULES+I),";;",2)  Q:NAMES?."^"
 . S IEN=$$FIND1^DIC(798.13,IENS,"UX",$P(NAMES,U,FROM),"B",,"RORMSG")
 . Q:IEN=0
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.13)
 . Q:RC<0
 . S RORFDA(798.13,IEN_IENS,.01)=$P(NAMES,U,TO)
 . D FILE^DIE(,"RORFDA","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.13,IEN_IENS)
 Q $S(RC<0:RC,1:0)
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
 N RC,REGLST,REGNAME,TMP
 S RORPARM("DEVELOPER")=1   ; Enable modifications
 S RORPARM("ERR")=1         ; Enable error processing
 S RORPARM("LOG")=1         ; Enable event recording
 S RORPARM("SETUP")=1       ; Registry setup indicator
 ;
 S REGNAME=$P(RORREG,U,2),REGLST(REGNAME)=+RORREG
 ;--- Open a new log
 S RC=$$OPEN^RORLOG(.REGLST,8,"REGISTRY SETUP STARTED")
 D
 . ;--- Replace the selection rules with historical ones
 . I REGNAME="VA HEPC"  S RC=$$RULES(RORREG,1,2)  Q:RC<0
 . ;--- Populate the registry
 . S RC=$$UPDATE^RORUPD(.REGLST,$G(RORMNTSK),$G(RORSUSP),"E")  Q:RC<0
 . D LOG^RORLOG(2,"The registry has been populated.")
 . ;--- Convert the ICR 2.1 records
 . I REGNAME="VA HIV"  D  Q:RC<0
 . . S RC=$$CONVERT^RORUPD62(RORREG)
 . . ;--- Update number of patients in registry parameters
 . . S TMP=$$UPDDEM^RORUPD51(.REGLST)
 . ;--- Setup the registry
 . S RC=$$PREPARE^RORSETU2(RORREG)  Q:RC<0
 ;
 ;--- Restore the regular selection rules
 D:REGNAME="VA HEPC"
 . S TMP=$$RULES(RORREG,2,1)  I TMP<0  S:RC'<0 RC=TMP
 ;--- Close the log
 S TMP="REGISTRY SETUP "_$S(RC<0:"ABORTED",1:"COMPLETED")
 D CLOSE^RORLOG(TMP)
 ;
 ;--- Send the notification e-mail
 S:RC'<0 TMP=$$SENDINFO^RORUTL17(+RORREG,,"EP")
 ;--- Send an alert to the originator of the task
 S TMP=$S(RC<0:-43,1:-41)
 D ALERT^RORKIDS(DUZ,TMP,$P(RORREG,U,2),,"registry setup")
 ;
 ;--- Cleanup
 I RC'<0  D  S ZTREQ="@"
 . K ^XTMP("RORUPDR"_+RORREG)
 Q
