RORHDT03 ;HCIOFO/SG - MANIPULATIONS WITH EXTRACTION TASKS ; 1/23/06 8:40am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** STARTS THE DATA EXTRACTION TASK
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ; FAM           File Access Mode:
 ;                 "A"  Append new messages to the file
 ;                 "O"  Overwrite the file
 ;                 "N"  Modify file name and create a new file
 ; [ZTDTH]       Start date/time
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;        1  Start time has not been entered
 ;        2  Already running or pending
 ;
START(HDEIEN,TASKIEN,FAM,ZTDTH) ;
 N IENS,PARAMS,RC,RORFDA,RORMSG,STATUS,TASK,TMP
 N ZTCPU,ZTDESC,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI
 ;--- Check status of the task
 S STATUS=+$$TASKSTAT^RORHDTUT(HDEIEN,TASKIEN,3)
 Q:(STATUS=1)!(STATUS=2)!(STATUS=102) 2
 ;--- Start/schedule the task
 S PARAMS("PARAMS","HDEIEN")=HDEIEN
 S PARAMS("PARAMS","TASKIEN")=TASKIEN
 S PARAMS("PARAMS","FAM")=FAM
 S ZTDESC="CCR HDE Task #"_TASKIEN
 S TASK=$$CREATE^RORTSK(1,"TASK^RORHDT03",,,,,.PARAMS)
 Q:TASK<0 TASK
 W !,"Task #"_TASK_" has been scheduled."
 ;--- Update task number
 S IENS=(+TASKIEN)_","_(+HDEIEN)_","
 S RORFDA(799.64,IENS,.02)=TASK
 D FILE^DIE(,"RORFDA","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 ;--- Update the last known task status
 S TMP=$$TASKSTAT^RORHDTUT(HDEIEN,TASKIEN)
 ;--- Success
 Q 0
 ;
 ;***** STOPS THE DATA EXTRACTION TASK
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
STOP(HDEIEN,TASKIEN) ;
 N RC,STATUS,TASK,TMP
 ;--- Get status of the task
 S STATUS=+$$TASKSTAT^RORHDTUT(HDEIEN,TASKIEN)
 Q:STATUS<0 STATUS
 ;--- Stop the task if it is running, pending, or suspended
 I (STATUS=1)!(STATUS=2)!(STATUS=102)  D  Q:$G(RC)<0 RC
 . S TASK=$$TASKNUM^RORHDTUT(HDEIEN,TASKIEN)
 . I TASK<0  S RC=+TASK  Q
 . S RC=$$DEQUEUE^RORTSK(TASK)
 . W:'RC !,"The task #"_TASK_" has been stopped/unscheduled."
 . ;--- Update the last known task status
 . S STATUS=+$$TASKSTAT^RORHDTUT(HDEIEN,TASKIEN)
 ;--- Task is stopping
 D:STATUS=103
 . W !,"The task #"_TASK_" has not responded to the stop request yet."
 Q 0
 ;
 ;***** HISTORICAL DATA EXTRACTION TASK
 ;
 ; RORTSK        Task number and task parameters
 ;
TASK ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 N RORLOG        ; Log susbsystem data
 N RORPARM       ; Application parameters
 ;
 N BUF,COUNTERS,FAM,HDEIEN,I,IENS,INFO,RC,REGLST,REGNAME,RORBUF,RORMSG,TASKIEN,TMP
 S RORTSK=ZTSK
 S HDEIEN=+$$PARAM^RORTSK01("HDEIEN")
 S TASKIEN=+$$PARAM^RORTSK01("TASKIEN")
 ;--- Initialize constants and variables
 D INIT^RORUTL01("RORHDT"),CLEAR^RORERR("TASK^RORHDT03")
 ;S RORPARM("DEBUG")=1 ; Remove the first ';' to start in debug mode
 S RORPARM("ERR")=1    ; Enable enhanced error processing
 S RORPARM("LOG")=1    ; Enable error recording
 ;--- Wait until the task record is created
 S TMP=$$TRWAIT^RORTSK01(RORTSK)
 ;--- Open the task log
 S TMP=$$SETUP^RORLOG()
 S TMP=$$OPEN^RORLOG(,4,"HDE TASK #"_RORTSK_" STARTED")
 D
 . ;--- Initialize the task
 . S RC=$$INIT^RORTSK01(RORTSK,$$LOGIEN^RORLOG)  Q:RC<0
 . ;--- Load parameters of the data extraction
 . S IENS=(+HDEIEN)_","
 . D GETS^DIQ(799.6,IENS,"3*","I","RORBUF","RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,799.6,IENS)
 . ;--- Compile the list of registries
 . S I=""
 . F  S I=$O(RORBUF(799.63,I))  Q:I=""  D
 . . S REGNAME=$G(RORBUF(799.63,I,.01,"I"))  Q:REGNAME=""
 . . S TMP=$$REGIEN^RORUTL02(REGNAME)
 . . S:TMP>0 REGLST(REGNAME)=TMP
 . ;--- Associate the log with the registries
 . S RC=$$SETRGLST^RORLOG(.REGLST)
 . ;---
 . S TMP=$$PARAM^RORTSK01("FAM")
 . S RC=$$EXTRACT^RORHDT04(.REGLST,HDEIEN,TASKIEN,TMP)
 . S:RC'<0 COUNTERS=RC
 ;
 ;--- Post-processing
 S TMP=$$EXIT^RORTSK01(RC)
 ;--- Close the log
 S TMP="HDE TASK #"_RORTSK_$S(RC<0:" ABORTED",1:" COMPLETED")
 D CLOSE^RORLOG(TMP,$G(COUNTERS))
 D:'$G(RORPARM("DEBUG")) INIT^RORUTL01("RORHDT")
 Q
