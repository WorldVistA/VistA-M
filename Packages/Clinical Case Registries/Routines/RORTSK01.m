RORTSK01 ;HCIOFO/SG - (SUB)TASK UTILITIES ; 1/22/06 8:05pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; These utilities should be called only from the tasks and subtasks
 ; that are created and scheduled by the RORTSK API.
 ;
 ; The RORTSK local array is passed to the task. If the proxy task
 ; is used then it passes this array by reference into the entry
 ; point that implements the generic task or report.
 ;
 ; RORTSK(               Task Number
 ;
 ;   "PARAMS",...)       Report Parameters
 ;   "TPP-PREV")         Previous value of task progress percentage
 ;
 ; If the proxy task is used, additional nodes are created:
 ;
 ;   "EP")               Entry Point
 ;   "TYPE")             Type of the Task
 ;   "REGIEN")           Registry IEN
 ;   "REPORT")           Code of the Report
 ;   "SCHCODE")          Rescheduling Code
 ;
 ; See descriptions of the REPORT BUILDER field (10.01) of the
 ; ROR REPORT PARAMETERS file (#799.34) and the ROR REPORT SCHEDULE
 ; remote procedure for more details.
 ;
 Q
 ;
 ;***** DUMMY ENTRY POINT (TO AVOID CRASH DURING ALERT PROCESSING)
ALERTRTN Q
 ;
 ;***** (SUB)TASK CLEANUP
 ;
 ; ERRCODE       Error code of the task
 ; [PARENT]      Parent task for the subtask
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
EXIT(ERRCODE,PARENT) ;
 N IENS,RC,RORFDA,RORMSG,STATUS,TASKINFO,TASKNODE,TMP
 S RC=0,STATUS=$S(ERRCODE=-42:5,ERRCODE<0:101,1:3),ZTREQ="@"
 ;=== SUBTASK
 I $G(PARENT)  D  Q RC
 . ;--- Not implemented
 ;=== TASK
 S TASKNODE=$NA(^RORDATA(798.8,RORTSK))
 S TMP=$$TASKINFO^RORTSK02(RORTSK,.TASKINFO)
 ;--- Report statistics
 D:+$G(TASKINFO(2))=2
 . S TMP=+$G(TASKINFO(3))  ; Registry IEN
 . D:TMP>0 INC^RORTSK12(TMP,+$G(TASKINFO(4)))
 ;--- Send an alert to the user who has started the task
 S TMP=$G(TASKINFO(5))  ; Task Description
 D ORALERT^RORUTL18($$MSG^RORERR20(-101,,,RORTSK,TMP))
 ;--- Update the task record
 S IENS=RORTSK_","
 S RORFDA(798.8,IENS,2.01)=STATUS      ; Status
 S RORFDA(798.8,IENS,2.02)=$$NOW^XLFDT ; Completion Time
 S RORFDA(798.8,IENS,2.04)="@"         ; Job Number
 S RORFDA(798.8,IENS,4)="@"            ; Progress
 D FILE^DIE(,"RORFDA","RORMSG")
 S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.8,IENS)
 ;--- Cleanup
 K @TASKNODE@("A"),@TASKNODE@("T")
 L -@TASKNODE@("T",0)
 Q RC
 ;
 ;***** INITIALIZES THE (SUB)TASK
 ;
 ; TASK          Task number
 ; [LOG]         Log IEN (returned by the $$LOGIEN^RORLOG function)
 ; [PARENT]      Parent task for the subtask
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
INIT(TASK,LOG,PARENT) ;
 N I,RC,RORDTH,RORFDA,RORMSG,TASKNODE
 S RORDTH=$G(ZTDTH)  S:RORDTH'>0 RORDTH=$$NOW^XLFDT
 S RC=0,RORTSK=+TASK  K RORTSK("PREVTPP")
 ;=== SUBTASK
 I $G(PARENT)  S RC=0  D  Q RC
 . ;--- Not implemented
 ;=== TASK
 S TASKNODE=$NA(^RORDATA(798.8,RORTSK))
 ;--- Schedule the next instance of the task (if requested)
 D:$G(RORTSK("SCHCODE"))'=""
 . N EP,TYPE,REGIEN,REPORT,SCHCODE
 . N ZTCPU,ZTDTH,ZTIO,ZTKIL,ZTPRI,ZTSAVE,ZTSYNC,ZTUCI
 . F I="EP","TYPE","REGIEN","REPORT","SCHCODE"  S @I=$G(RORTSK(I))
 . Q:(TYPE'>0)!(EP="")
 . S ZTDTH=$$SCH^XLFDT(SCHCODE,RORDTH,1)
 . S TMP=$$CREATE^RORTSK(TYPE,EP,,REGIEN,REPORT,SCHCODE,.RORTSK)
 ;--- Wait until the task record is created
 S RC=$$TRWAIT(RORTSK)  Q:RC<0 RC
 ;--- Lock the task record
 L +@TASKNODE@("T",0):5
 E  Q $$ERROR^RORERR(-11,,,,"the ROR TASK file")
 ;--- Clear the list of subtasks
 K @TASKNODE@("T")
 ;--- Update the task record
 S IENS=RORTSK_","
 S RORFDA(798.8,IENS,2.01)=100         ; STATUS = 'Crashed'
 S RORFDA(798.8,IENS,2.03)=$G(LOG)     ; Log IEN
 S RORFDA(798.8,IENS,2.04)=$J          ; Job Number
 D FILE^DIE(,"RORFDA","RORMSG")
 S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.8,IENS)
 Q RC
 ;
 ;***** TASK CONTROL FUNCTION
 ;
 ; [TPP]         Task/Section progress (0-1)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOOP(TPP) ;
 N ACTION,OFFSET,RC
 ;--- Update the task progress percentage
 D:$G(TPP)'=""
 . I TPP'<0,TPP'>1  D  S TPP=+$J(TPP,0,2)
 . . S TPP=TPP*$G(RORTSK("TPP-BASE"),100)+$G(RORTSK("TPP-OFFS"))
 . E  S TPP=""
 . Q:TPP=$G(RORTSK("TPP-PREV"))
 . S (^RORDATA(798.8,RORTSK,"P"),RORTSK("TPP-PREV"))=TPP
 ;--- Requested action
 S ACTION=$S($$S^%ZTLOAD:2,1:+$G(^RORDATA(798.8,RORTSK,"A")))
 Q:'ACTION 0
 ;=== SUSPEND THE TASK
 I ACTION=1  S RC=0  D  Q RC
 . N IENS,RORFDA,RORMSG
 . S IENS=RORTSK_","
 . ;--- Update the task status
 . S RORFDA(798.8,IENS,2.01)=102      ; STATUS = 'Suspended'
 . D FILE^DIE(,"RORFDA","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.8,IENS)
 . ;--- Suspension cycle
 . F  H 60  D  Q:ACTION'=1
 . . S ACTION=$S($$S^%ZTLOAD:2,1:+$G(^RORDATA(798.8,RORTSK,"A")))
 . ;--- Restore the default task status
 . S RORFDA(798.8,IENS,2.01)=100      ; STATUS = 'Crashed'
 . D FILE^DIE(,"RORFDA","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.8,IENS)
 ;=== STOP THE TASK
 I ACTION=2  D  Q $$ERROR^RORERR(-42)
 . S ZTSTOP=1
 Q 0
 ;
 ;***** RETURNS THE VALUE/ATTRIBUTE OF THE TASK PARAMETER
PARAM(NAME,ATTR) ;
 Q:$G(ATTR)'="" $G(RORTSK("PARAMS",NAME,"A",ATTR))
 Q $G(RORTSK("PARAMS",NAME))
 ;
 ;***** TASK PROXY
 ;
 ; RORTSK("EP")  This node must contain name of the task entry point
 ;               ($$TAG^ROUTINE). The function should return either
 ;               a negative error code or zero.
 ;
TASK ;
 N RORCACHE      ; Cache of element and attribute names
 N RORLOG        ; Log subsystem constants & variables
 N RORPARM       ; Application parameters
 ;
 N ACTIVITY,I,INFO,RC,REGLST,RORERRDL,TASKINFO,TMP,TRC
 S RORTSK=ZTSK
 ;--- Initialize constants and variables
 D INIT^RORUTL01("ROR")
 ;S RORPARM("DEBUG")=1 ; Remove the first ';' to start in debug mode
 S RORPARM("ERR")=1    ; Enable enhanced error processing
 S RORPARM("LOG")=1    ; Enable error recording
 ;--- Wait until the task record is created
 S TMP=$$TRWAIT(RORTSK)
 ;--- Get the task information
 S TRC=$$TASKINFO^RORTSK02(RORTSK,.TASKINFO,"E")
 ;--- Open a task log
 S TMP=$P($G(TASKINFO(3)),U,2)  S:TMP'="" REGLST(TMP)=""
 S ACTIVITY=$S(+$G(TASKINFO(2))=2:5,1:0)
 S TMP=$$SETUP^RORLOG(.REGLST)
 S RC=$$OPEN^RORLOG(.REGLST,ACTIVITY,"TASK #"_RORTSK_" STARTED")
 ;--- Abort the task if task information was not available
 I TRC<0  D:RC'<0  Q
 . S TMP=$$ERROR^RORERR(-56,,,,TRC,"$$TASKINFO^RORTSK02")
 . D CLOSE^RORLOG("TASK #"_RORTSK_" ABORTED")
 D
 . ;--- Record the task information (if available)
 . S I=0,TMP=$G(TASKINFO(5))
 . S:TMP'="" I=I+1,INFO(I)="Description: '"_TMP_"'"
 . S TMP=$P($G(TASKINFO(8)),U,2)
 . S:TMP'="" I=I+1,INFO(I)="User:        '"_TMP_"'"
 . S TMP=$G(TASKINFO(14))
 . S:TMP'="" I=I+1,INFO(I)="Comment:     '"_TMP_"'"
 . D:I LOG^RORLOG(2,"Task Information",,.INFO)
 . ;--- Verify the entry point
 . S RC=$$VERIFYEP^RORUTL01($G(RORTSK("EP")),1)  Q:RC<0
 . ;--- Initialize the task
 . S RC=$$INIT(RORTSK,$$LOGIEN^RORLOG)  Q:RC<0
 . K ACTIVITY,INFO,REGLST,TASKINFO,TMP
 . ;--- Call the entry point
 . X "S TRC="_RORTSK("EP")_"(.RORTSK)"
 ;
 ;--- Post-processing
 S TMP=$$EXIT(TRC)
 ;--- Close the log
 S TMP="TASK #"_RORTSK_$S(TRC<0:" ABORTED",1:" COMPLETED")
 D CLOSE^RORLOG(TMP)
 Q
 ;
 ;***** SETS THE BASE VALUE FOR THE PROGRESS INDICATOR
 ;
 ; BASE          Base value for the progress indicator (0-100)
 ;
TPPSETUP(BASE) ;
 I $G(BASE)'>0  K RORTSK("TPP-BASE"),RORTSK("TPP-OFFS")  Q
 N TMP
 S RORTSK("TPP-OFFS")=$G(RORTSK("TPP-OFFS"))+$G(RORTSK("TPP-BASE"))
 S TMP=100-$G(RORTSK("TPP-OFFS"))
 S RORTSK("TPP-BASE")=$S(BASE<TMP:BASE,1:TMP)
 S TMP=$$LOOP(0)
 Q
 ;
 ;***** WAITS UNTIL THE TASK RECORD IS CREATED
 ;
 ; TASK          Task number
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TRWAIT(TASK) ;
 N I  F I=1:1:5  Q:$D(^RORDATA(798.8,TASK,0))  H 1
 Q $S($D(^RORDATA(798.8,TASK,0)):0,1:$$ERROR^RORERR(-83,,,,TASK))
