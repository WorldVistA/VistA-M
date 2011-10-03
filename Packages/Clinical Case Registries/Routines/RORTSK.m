RORTSK ;HCIOFO/SG - TASK MANAGER ; 1/22/06 6:26pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** CREATES AND SCHEDULES A TASK
 ;
 ; TYPE          Type of the task (1 - Generic, 2 - Report)
 ;
 ; ZTRTN         The entry point TaskMan will DO to start the task.
 ;
 ;               This parameter can also have the $$TAG^ROUTINE
 ;               format. In this case, the "proxy task" will be used.
 ;               The value of the parameter will be saved in the
 ;               RORTSK("EP") node and the "TASK^RORTSK01" will be
 ;               assigned to the ZTRTN variable. See the TASK^RORTSK01
 ;               for more details.
 ;
 ; [.PARAMS]     Reference to a local variable that contains a list
 ;               of name-value pairs of the task parameters.
 ;               The parameters are passed to the task as sub-nodes
 ;               of the "PARAMS" node of the RORTSK local variable.
 ;
 ;               Examples:
 ;
 ;                 PARAMS("NUM")=10    ==> RORTSK("PARAMS","NUM")=10
 ;                 PARAMS("A(10)")="B" ==> RORTSK("PARAMS","A",10)="B"
 ;
 ; [REGIEN]      Registry IEN (if $G(REGIEN)'>0 the task will not
 ;               be associated with any particular registry).
 ;
 ; [REPORT]      Code of the report (if the TYPE = 2).
 ;
 ; [SCHCODE]     Rescheduling code for the task. By default (if
 ;               $G(SCHCODE)=""), the task is executed once. See
 ;               description of the $$SCH^XLFDT function for
 ;               possible values of the parameter).
 ;
 ; [.RORTSKPP]   Reference to a local variable that contains a task
 ;               descriptor with already prepared task parameters
 ;               (under the "PARAMS" subscript). These parameters
 ;               are copied into the new task descriptor "as is".
 ;
 ; All other input variables used by the %ZTLOAD (except the ZTRTN)
 ; can be used to control the task. Modifications of the default
 ; behavior of some of those variables are described below.
 ;
 ; [ZTDESC]      Task description
 ;
 ; [ZTDTH]       Date/time to start the task (FileMan). By default
 ;               (if $G(ZTDTH)=""), the task is scheduled to run
 ;               with a 3 second delay.
 ;
 ; [ZTIO]        Output device. By default (if $G(ZTIO)=""), the
 ;               task is started without an output device.
 ;
 ; [ZTSAVE]      List of variables that should be passed to the task.
 ;               The CREATE^RORTSK function adds the "RORTSK(" item
 ;               to the list if the task proxy is requested (see the
 ;               ZTRTN parameter for details) or the PARAMS parameter
 ;               is defined.
 ;
 ; Return values:
 ;       <0  Error code
 ;       >0  Task Number
 ;
CREATE(TYPE,ZTRTN,PARAMS,REGIEN,REPORT,SCHCODE,RORTSKPP) ;
 N DESCR,IENS,RC,RORFDA,RORIEN,RORMSG,RORTSK,RPTIEN,TMP,ZTSK
 S (RC,RPTIEN)=0
 I $G(REGIEN)>0  D  Q:RC<0 RC
 . I TYPE=2  D  I RPTIEN<0  S RC=RPTIEN  Q
 . . S RPTIEN=$$RPIEN^RORUTL08(REPORT,.DESCR)
 E  S REGIEN=0
 ;--- Task parameters
 M RORTSK("PARAMS")=RORTSKPP("PARAMS")
 I $D(PARAMS)>1  D  Q:RC<0 RC
 . S RC=$$PARAMS^RORTSK03(.PARAMS)
 . ;--- If there is the TASK_DESCR parameter in
 . ;    the list use its value as the task description
 . ;--- (if the ZTDESC variable is not defined)
 . S TMP=$$PARAM^RORTSK01("TASK_DESCR")
 . S:TMP'="" DESCR=$E(TMP,1,200)
 ;--- Registry IEN
 D:'$D(RORTSK("PARAMS","REGIEN"))
 . S RORTSK("PARAMS","REGIEN")=+$G(REGIEN)
 ;--- Prepare the task description
 I $G(ZTDESC)=""  D  Q:RC<0 RC
 . I $G(DESCR)'=""  S ZTDESC=DESCR  Q
 . S DESCR=$$EXTERNAL^DILFD(798.8,.02,,TYPE,"RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.8)
 . S (DESCR,ZTDESC)=DESCR_" Task started from the GUI"
 E  S DESCR=ZTDESC
 S:$L(DESCR)>60 DESCR=$E(DESCR,1,57)_"..."
 ;--- Check if the task proxy should be used
 I $E(ZTRTN,1,2)="$$"  D  S ZTRTN="TASK^RORTSK01"
 . S RORTSK("EP")=ZTRTN  Q:$G(SCHCODE)=""
 . F TMP="TYPE","REGIEN","REPORT","SCHCODE"  D
 . . S RORTSK(TMP)=$G(@TMP)
 ;--- If the task is scheduled to run immediately, postpone the start
 ;--- for 3 seconds to make sure that the task record is created
 S TMP=$$NOW^XLFDT
 I $G(ZTDTH)>0,$$FMDIFF^XLFDT(ZTDTH,TMP,2)>3
 E  S ZTDTH=$$FMADD^XLFDT(TMP,,,,3)
 ;--- Schedule the task
 S:'($D(ZTIO)#10) ZTIO=""
 S ZTSAVE("RORTSK(")=""
 D ^%ZTLOAD
 Q:'$G(ZTSK) $$ERROR^RORERR(-82,,,,ZTRTN,ZTDTH)
 S RORTSK=ZTSK
 ;--- Prepare data for the record in the ROR TASK file
 S IENS="+1,"
 S (RORFDA(798.8,IENS,.01),RORIEN(1))=RORTSK    ; Task Number
 S RORFDA(798.8,IENS,.02)=+TYPE                 ; Type
 D:REGIEN>0
 . S RORFDA(798.8,IENS,.03)=+REGIEN             ; Registry
 . S:RPTIEN RORFDA(798.8,IENS,.04)=RPTIEN       ; IEN of report par.
 S RORFDA(798.8,IENS,.05)=DESCR                 ; Description
 S TMP=$$PARAM^RORTSK01("TASK_COMMENT")
 S:TMP'?." " RORFDA(798.8,IENS,1.01)=TMP        ; Comment
 ;--- Create the record
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.8,IENS)
 . ;--- Try to unschedule the task if the record has not been created
 . S ZTSK=RORTSK  D DQ^%ZTLOAD
 Q RORTSK
 ;
 ;***** DEQUEUES AND/OR DELETES THE TASK
 ;
 ; TASK          Task number
 ;
 ; [DELETE]      Delete the task from the Taskman and the task
 ;               record from the ROR TASK file (#798.8) if this
 ;               parameter has a non-zero value.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;        1  No responce from the task
 ;
DEQUEUE(TASK,DELETE) ;
 N DA,DIK,I,RC,STATUS,TASKNODE,ZTSK
 S STATUS=+$$STATUS^RORTSK02(TASK,,1)
 I STATUS<0  Q $S(STATUS=-83:0,1:STATUS)
 S TASKNODE=$NA(^RORDATA(798.8,TASK))
 ;--- Unschedule the task
 I STATUS=1  S ZTSK=TASK  D DQ^%ZTLOAD
 ;--- Stop the task if it is running
 S STATUS=+$$STATUS^RORTSK02(TASK)
 S:(STATUS=2)!(STATUS=102) @TASKNODE@("A")=2
 Q:'$G(DELETE) 0
 ;--- Wait for a response from the task
 S STATUS=+$$STATUS^RORTSK02(TASK,3)  Q:STATUS<0 STATUS
 Q:STATUS=103 1
 ;--- Kill the REPORT ELEMENT multiple to avoid delays in ^DIK
 K @TASKNODE@("RI")
 ;--- Delete the task record
 S DIK="^RORDATA(798.8,",DA=TASK  D ^DIK
 Q 0
 ;
 ;***** RESUMES THE TASK
 ;
 ; TASK          Task number
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RESUME(TASK) ;
 N STATUS
 S STATUS=+$$STATUS^RORTSK02(TASK,,1)  Q:STATUS<0 STATUS
 K ^RORDATA(798.8,TASK,"A")
 Q 0
 ;
 ;***** SUSPENDS THE TASK
 ;
 ; TASK          Task number
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
SUSPEND(TASK) ;
 N STATUS
 S STATUS=+$$STATUS^RORTSK02(TASK,,1)  Q:STATUS<0 STATUS
 S:(STATUS=1)!(STATUS=2) ^RORDATA(798.8,TASK,"A")=1
 Q 0
