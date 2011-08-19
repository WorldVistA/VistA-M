RORTSK02 ;HCIOFO/SG - TASK MANAGER UTILITIES ; 1/23/06 8:11am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS A LIST OF USER'S TASKS
 ;
 ; .TASKLIST     Reference to a local array that the task
 ;               list is returned to
 ;
 ; [REGIEN]      Registry IEN
 ;
 ; [TYPE]        Type of the task (1 - Generic, 2 - Report)
 ;
 ; [.FROM]       Where to start/continue the list generation.
 ;               By defualt (if $G(FROM)'>0), the extraction starts
 ;               from the beginning of the user's task list.
 ;
 ;               NOTE: The task, which number is passed via this
 ;               parameter, is not included in the report.
 ;
 ;               After the call, this parameter contains the last
 ;               extracted task number or an empty string if there
 ;               are no more tasks.
 ;
 ; [NUMBER]      Maximum number of tasks returned by the function.
 ;               By default (if $G(NUMBER)'>0), all task numbers
 ;               (starting from the point indicated by the FROM
 ;               parameter if it is defined) are retrieved.
 ;
 ; [USER]        A user IEN (DUZ). By default (if $G(USER)'>0),
 ;               the curent user's DUZ is used.
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  No tasks have been found
 ;       >0  Number of tasks
 ;
LIST(TASKLIST,REGIEN,TYPE,FROM,NUMBER,USER) ;
 N DIR,NTSK,RC,ROOT,RORBUF,SCR,TASK  K TASKLIST
 S ROOT=$$ROOT^DILFD(798.8,,1)
 S USER=$S($G(USER)>0:+USER,1:+$G(DUZ))
 S DIR=$S($$UP^XLFSTR($G(NUMBER))["B":-1,1:1)
 S NUMBER=$S($G(NUMBER)>0:+NUMBER,1:999999)
 ;--- Generate a screen logic
 S SCR="I 1"
 S:$G(REGIEN)>0 SCR=SCR_","_"$P(RORBUF,U,3)="_(+REGIEN)
 S:$G(TYPE)>0 SCR=SCR_","_"$P(RORBUF,U,2)="_(+TYPE)
 ;--- Generate the output list
 S TASK=$S($G(FROM)>0:FROM,1:""),NTSK=0
 F  S TASK=$O(@ROOT@("U",USER,TASK),DIR)  Q:TASK=""  D  Q:NTSK'<NUMBER
 . S RORBUF=$G(@ROOT@(TASK,0))  X SCR  E  Q
 . S NTSK=NTSK+1,TASKLIST(TASK)=""
 S FROM=TASK
 Q NTSK
 ;
 ;***** PURGES THE OLD TASKS
 ;
 ; [DKEEP]       Days to keep the old tasks (by default = 15)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PURGE(DKEEP) ;
 N DA,DATE,DIK,FROM,RC,STATUS,TASK,TASKINFO
 S ROOT=$$ROOT^DILFD(798.8,,1),DIK=$$OREF^DILF(ROOT)
 S FROM=$$FMADD^XLFDT($$DT^XLFDT,1-$G(DKEEP,15))
 ;---
 S DATE=FROM,RC=0
 F  S DATE=$O(@ROOT@("ACDT",DATE),-1)  Q:DATE=""  D
 . S TASK=""
 . F  S TASK=$O(@ROOT@("ACDT",DATE,TASK),-1)  Q:TASK=""  D
 . . Q:$$TASKINFO(TASK,.TASKINFO)<0
 . . S STATUS=+TASKINFO(6)
 . . ;--- Do not delete pending, running and suspended tasks
 . . Q:(STATUS=1)!(STATUS=2)!(STATUS=102)
 . . ;--- If task is completed, use its completion
 . . ;--- date instead of the creation date
 . . I TASKINFO(9)>DATE  Q:TASKINFO(9)'<FROM
 . . ;--- Delete the record
 . . S DA=TASK  D ^DIK
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS STATUS OF THE TASK
 ;
 ; TASK          Task number
 ; [LTO]         LOCK timeout (0 by default)
 ; [UNDEF83]     Return the error -83 if there is no task record.
 ;               By default (if +$G(UNDEF83)=0), zero is returned.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Undefined task/Unknown Status
 ;       >0  Status (Code^Description)
 ;
 ;               1  Active: Pending
 ;               2  Active: Running
 ;               3  Inactive: Finished
 ;               4  Inactive: Available
 ;               5  Inactive: Interrupted
 ;
 ;             100  Inactive: Crashed
 ;             101  Inactive: Errors
 ;             102  Active: Suspended
 ;             103  Active: Stopping
 ;
STATUS(TASK,LTO,UNDEF83) ;
 N ACTION,IENS,RORBUF,RORMSG,STATUS,TASKNODE,TMS,ZTSK
 Q:TASK'>0 $$ERROR^RORERR(-85,,,,TASK)
 S TASKNODE=$NA(^RORDATA(798.8,TASK))
 Q:'$D(@TASKNODE) $S($G(UNDEF83):-83,1:0)
 ;--- Get internal value of the STATUS field (2.01)
 S STATUS=+$G(@TASKNODE@(2))
 ;--- Lock the record and check if the task is running
 L +@TASKNODE@("T",0):$G(LTO,0)
 E  S TMS=""  D  Q:TMS'="" TMS
 . S ACTION=+$G(@TASKNODE@("A"))
 . I ACTION=2    S TMS="103^Active: Stopping"   Q
 . I STATUS=100  S TMS="2^Active: Running"      Q
 . I STATUS=102  S TMS="102^Active: Suspended"  Q
 D
 . ;--- Try to get status from the Taskman
 . S ZTSK=TASK  D STAT^%ZTLOAD
 . S TMS=$S($G(ZTSK(0)):+$G(ZTSK(1)),1:0)
 . ;--- Pending or Available
 . I (TMS=1)!(TMS=4)  S STATUS=TMS_U_$G(ZTSK(2))  Q
 . ;--- Running (actually, crashed ;-)
 . I TMS=2  S STATUS=100  Q
 . ;--- Finished, Interrupted or Undefined
 . I 'STATUS  S:TMS STATUS=TMS_U_$G(ZTSK(2))  Q
 . ;--- If the task record is not locked and the STATUS field shows
 . ;    'Suspended' (102) then the task probably crashed while it
 . ;--- was in the suspended state
 . S:STATUS=102 STATUS=100
 ;--- Get the external value of the STATUS field (if necessary)
 I STATUS>0  D:$P(STATUS,U,2)=""
 . S $P(STATUS,U,2)=$$EXTERNAL^DILFD(798.8,2.01,,STATUS,"RORMSG")
 . S:$G(DIERR) STATUS=$$DBS^RORERR("RORMSG",-9,,,798.8)
 ;
 ;--- Unlock the task record
 L -@TASKNODE@("T",0)
 Q $TR(STATUS,">",":")
 ;
 ;***** RETURNS THE TASK INFORMATION
 ;
 ; TASK          Task number
 ;
 ; .INFO         Reference to a local variable (output):
 ;
 ; INFO(
 ;   OFFSET+1)           Task Number
 ;   OFFSET+2)           Task Type           (internal^external)
 ;   OFFSET+3)           Registry            (IEN^Name)
 ;   OFFSET+4)           Report              (Code^Name)
 ;   OFFSET+5)           Description
 ;   OFFSET+6)           Task Status         (internal^external)
 ;   OFFSET+7)           Creation Time       (internal)
 ;   OFFSET+8)           User                (DUZ^Name)
 ;   OFFSET+9)           Completion Time     (internal)
 ;   OFFSET+10)          Progress Percentage
 ;   OFFSET+11)          Scheduled to Run at (internal)
 ;   OFFSET+12)          Task Log IEN
 ;   OFFSET+13)          Job Number
 ;   OFFSET+14)          User Comment
 ;
 ; [FLAGS]       Characters controlling behavior of the function
 ;               (they can be combined):
 ;                 E  Return external values also (when applicable)
 ;
 ; [OFFSET]      A number that is added to all subscripts in the
 ;               destination array (by default, it is zero).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TASKINFO(TASK,INFO,FLAGS,OFFSET) ;
 N I,IENS,RORBUF,RORMSG,TMP
 S FLAGS=$$UP^XLFSTR($G(FLAGS))
 S OFFSET=$S($G(OFFSET)>0:+OFFSET,1:0)
 ;--- Clear the output array
 K:'OFFSET INFO  S TMP=$$TIN
 F I=1:1:TMP  S INFO(OFFSET+I)=""
 ;--- Get the task status
 S TMP=$$STATUS(TASK,,1)  Q:TMP<0 TMP
 S INFO(OFFSET+1)=TASK
 S INFO(OFFSET+6)=$S(FLAGS["E":TMP,1:+TMP)
 ;--- Load the task record
 S IENS=TASK_",",I=$S(FLAGS["E":"EIN",1:"IN")
 S TMP=".02;.03;.04;.05;.07;.08;1.01;2.02;2.03;2.04;4"
 D GETS^DIQ(798.8,IENS,TMP,I,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.8,IENS)
 ;--- Format the output array
 Q $$FRMTI^RORTSK03(OFFSET,.INFO,IENS,.RORBUF,FLAGS)
 ;
 ;***** RETURNS NUMBER OF NODES IN THE TASK INFORMATION ARRAY
TIN() Q 14
