RORUPD05 ;HCIOFO/SG - REGISTRY UPDATE (MULTITASK) ; 7/6/06 11:09am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 Q
 ;
 ;***** MONITORS THE SUBTASKS
 ;
 ; Return Values:
 ;       <0  Error code
 ;      >=0  Combined statistics returned by the $$PROCESS^RORUPD01
 ;           function of each subtask
 ;
MONITOR() ;
 N CNT,ECNT,EXIT,RC,TASK,TIMEOUT,TSKCNT
 S (CNT,ECNT,EXIT)=0,TIMEOUT=600 ; 10hrs = 600*60
 F  H 60  D  Q:EXIT
 . ;--- Exit if all subtasks finished
 . I $D(@RORUPDPI@("T"))<10  S EXIT=1  Q
 . ;--- Abort if some of the subtasks have not started during
 . ;--- the predefined time frame.
 . I TIMEOUT'>0  S EXIT=$$ERROR^RORERR(-78)  Q
 . ;--- Check for a request to stop
 . I $D(ZTQUEUED),$$S^%ZTLOAD  S EXIT=$$ERROR^RORERR(-42)  Q
 . ;--- Browse through the list of subtasks
 . S (TASK,TSKCNT)=0
 . F  S TASK=$O(@RORUPDPI@("T",TASK))  Q:TASK=""  D
 . . S RC=@RORUPDPI@("T",TASK),TSKCNT=TSKCNT+1
 . . ;--- Skip a subtask that was scheduled but has not started yet
 . . I RC="S"  S TSKCNT=TSKCNT-1  Q
 . . ;--- Skip a running subtask
 . . L +@RORUPDPI@("T",TASK):1  E  Q
 . . L -@RORUPDPI@("T",TASK)
 . . ;--- The subtask has crashed
 . . I RC=-60  S EXIT=$$ERROR^RORERR(-60,,,,TASK)  Q
 . . ;--- Fatal error in the subtask
 . . I RC<0  S EXIT=+RC  D  Q
 . . . S RC=$$ERROR^RORERR(-56,,,,+RC,"subtask #"_TASK)
 . . ;--- The subtask is completed (accumulate the statistics)
 . . S CNT=CNT+$P(RC,U),ECNT=ECNT+$P(RC,U,2)
 . . K @RORUPDPI@("T",TASK)
 . ;--- Timeout timer is ticking only if no subtasks are running
 . S:TSKCNT'>0 TIMEOUT=TIMEOUT-1
 Q $S(EXIT<0:EXIT,1:CNT_U_ECNT)
 ;
 ;***** PROCESSES THE DATA (SINGLE TASK OR MULTITASK MODE)
 ;
 ; [MAXNTSK]     Maximum number of data processing subtasks.
 ;               If this parameter is less than 2, all patients
 ;               will be processed by the single main task.
 ;               Otherwise, all patients can be distributed among
 ;               several subtasks.
 ;
 ;               If "N^M^AUTO" is passed as a value of this parameter
 ;               and difference between the end and start dates is
 ;               more than M days then N subtasks will be created.
 ;
 ; Return Values:
 ;       <0  Error code
 ;      >=0  Statistics returned by the $$MONITOR function
 ;
 ; The main task will wait for completion of the subtasks. If one
 ; of them fails, all other (including the main one) will fail too.
 ;
PROCESS(MAXNTSK) ;
 N COUNTERS,NTSK,OLDPI,RC,SUBSCR,TASKTBL,TMP
 ;--- Calculate number of tasks and create the task table
 D:$G(MAXNTSK)["AUTO"
 . S TMP=$$FMDIFF^XLFDT(RORUPD("DSEND"),RORUPD("DSBEG"),1)
 . S MAXNTSK=$S(TMP>$P(MAXNTSK,U,2):+MAXNTSK,1:0)
 I $G(MAXNTSK)>1  D  Q:NTSK<0 NTSK
 . S NTSK=$$TASKTBL(MAXNTSK,.TASKTBL)
 ;--- Process all patients by the main task
 Q:$G(NTSK)<2 $$PROCESS^RORUPD01()
 ;
 S RORUPD("JOB")=$J,OLDPI=RORUPDPI
 ;--- Initialize the node in the ^XTMP global
 I $G(RORPARM("SETUP"))  D
 . S SUBSCR="RORUPDR"_+$O(RORUPD("LM2",""))
 . S RORUPDPI=$NA(^XTMP(SUBSCR)),I=0
 . F  S I=$O(@RORUPDPI@(I))  Q:I=""  K:I'="U" @RORUPDPI@(I)
 E  D
 . S SUBSCR="RORUPDJ"_$J
 . S RORUPDPI=$NA(^XTMP(SUBSCR))
 . K @RORUPDPI
 D XTMPHDR^RORUTL01(SUBSCR,30,"PROCESS-RORUPD05")
 M @RORUPDPI=@OLDPI
 ;--- Indicate that the main task is running
 L +@RORUPDPI@("T",0):7
 E  Q $$ERROR^RORERR(-61)
 ;
 ;--- Start the subtasks
 S RC=$$START(.TASKTBL)
 ;--- Monitor the subtasks
 S COUNTERS=$S(RC'<0:$$MONITOR(),1:RC)
 ;
 ;--- Clear "running" flag of the main task
 ;    (request all unfinished subtasks to stop)
 L -@RORUPDPI@("T",0)
 ;--- Cleanup
 I COUNTERS<0  D
 . N TASK,ZTSK
 . ;--- Dequeue subtasks that have not started yet
 . S TASK=0
 . F  S TASK=$O(@RORUPDPI@("T",TASK))  Q:TASK=""  D
 . . S ZTSK=TASK  D DQ^%ZTLOAD
 . ;--- Wait for all unfinished subtasks to stop
 . L +@RORUPDPI@("T"):300  L -@RORUPDPI@("T")
 K @RORUPDPI@("T")
 Q COUNTERS
 ;
 ;***** STARTS THE SUBTASKS
 ;
 ; .TASKTBL      Reference to a local variable containing the table
 ;               of subtask parameters. See the TASKSPLT and TASKTBL
 ;               entry points for details.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
START(TASKTBL) ;
 N CNT,I,ZTDESC,ZTDTH,ZTIO,ZTPRI,ZTRTN,ZTSAVE,ZTSK
 K @RORUPDPI@("T")
 ;--- Do not allow subtasks to proceed before everything is ready
 L +@RORUPDPI@("T"):7
 E  Q $$ERROR^RORERR(-61)
 ;--- Start the subtasks
 S I=""
 F CNT=1:1  S I=$O(TASKTBL(I))  Q:I=""  D
 . S ZTRTN="SUBTASK^RORUPD05",ZTIO=""
 . S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,,CNT*30)
 . S ZTDESC="Registry Update Subtask ("_$TR(TASKTBL(I),U,"-")_")"
 . S ZTSAVE("RORIENS")=TASKTBL(I)
 . S ZTSAVE("RORLRC(")=""
 . S ZTSAVE("RORPARM(")=""
 . S ZTSAVE("RORUPD(")=""
 . S ZTSAVE("RORUPDPI")=""
 . D ^%ZTLOAD
 . ;--- Indicate that the subtask has been scheduled
 . S @RORUPDPI@("T",ZTSK)="S"
 . D LOG^RORERR(-62,,,ZTSK)
 ;--- The subtasks may proceed now
 L -@RORUPDPI@("T")
 Q 0
 ;
 ;***** DATA PROCESSING SUBTASK
 ;
 ; RORIENS       Diapason of IENs in the 'PATIENT' file
 ;                 ^1: Start IEN
 ;                 ^2: End IEN
 ; RORLRC        List of Lab result codes to check
 ; RORPARM       Application parameters
 ; RORUPD        Registry update descriptor
 ; RORUPDPI      Closed root of the temporary storage
 ;
SUBTASK ;
 N RORERROR      ; Error processing data
 N RORLOG        ; Log subsystem constants & variables
 ;
 N RC,TASK,TMP
 S TASK=ZTSK
 ;--- We are not in the KIDS environment anymore
 K RORPARM("KIDS")
 ;--- Disable debug output (subtask has no device)
 S:$G(RORPARM("DEBUG"))>1 RORPARM("DEBUG")=1
 ;--- Indicate that the subtask is running
 L +@RORUPDPI@("T",TASK):180
 E  S RC=$$ERROR^RORERR(-61)  Q
 ;--- Check if the main task is running
 L +@RORUPDPI@("T",0):3
 I  D
 . ;--- Cleanup if the main task is not running
 . L -@RORUPDPI@("T",0)
 . K @RORUPDPI@("T",TASK)
 E  D
 . N REGIEN,REGLST
 . ;--- Error code that will be in effect if the subtask crashes
 . S @RORUPDPI@("T",TASK)=-60
 . ;--- Initialize the variables
 . D INIT^RORUTL01(),CLEAR^RORERR("SUBTASK^RORUPD05")
 . S REGIEN=""
 . F  S REGIEN=$O(@RORUPDPI@(2,REGIEN))  Q:REGIEN=""  D
 . . S TMP=$P(@RORUPDPI@(2,REGIEN),U)  S:TMP'="" REGLST(TMP)=REGIEN
 . S TMP="REGISTRY UPDATE SUBTASK #"_TASK_" STARTED"
 . S TMP=$$OPEN^RORLOG(.REGLST,1,TMP)
 . ;--- Process the patients from 'Start IEN' to 'End IEN'
 . S RC=$$PROCESS^RORUPD01($P(RORIENS,U),$P(RORIENS,U,2))
 . ;--- Set the error code returned by the registry update process
 . S @RORUPDPI@("T",TASK)=RC
 . ;--- Cleanup and error processing
 . S:RC=-42 ZTSTOP=1
 . S TMP="REGISTRY UPDATE SUBTASK "_$S(RC<0:"ABORTED",1:"COMPLETED")
 . D CLOSE^RORLOG(TMP,$S(RC'<0:RC,1:""))
 ;--- Clear "running" flag of the subtask
 L -@RORUPDPI@("T",TASK)
 S ZTREQ="@"
 Q
 ;
 ;***** CALCULATES TABLE OF SUBTASKS
 ;
 ; MAXNTSK       Maximum number of data processing subtasks
 ;
 ; .TASKTBL      Reference to a local variable where table of
 ;               subtask parameters is returned:
 ;
 ;               TASKTBL       Number of subtasks
 ;               TASKTBL(I)    Subtask parameters
 ;                               ^1: Start IEN
 ;                               ^2: End IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Process all data by the main task
 ;       >1  Number of subtasks
 ;
 ; If the PATIENT file contains more than 100,000 records, up to
 ; MAXNTSK data processing subtasks may be defined. Otherwise, the
 ; data should be processed by the main task.
 ;
TASKTBL(MAXNTSK,RORTBL) ;
 N I,IEN,INC,LST,NR,RORTMP
 K RORTBL
 ;--- Get number of records in the PATIENT file
 S NR=$$GET1^DID(2,,,"ENTRIES",,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9)
 Q:NR'>10000 0
 ;--- Generate IEN intervals (no more than 300)
 S RORTMP=$$ALLOC^RORTMP()
 S INC=NR\300,NR=0  S:INC<1 INC=1
 F IEN=0:INC  S IEN=$O(^DPT(IEN))  Q:IEN'>0  D
 . S NR=NR+1,@RORTMP@(NR)=IEN
 ;--- Generate the task table
 S IEN=1,INC=NR/MAXNTSK
 F RORTBL=1:1  D  Q:(RORTBL'<MAXNTSK)!(IEN'>0)
 . S RORTBL(RORTBL)=IEN
 . S I=$J(RORTBL*INC,0,0),IEN=$G(@RORTMP@(I))
 . S $P(RORTBL(RORTBL),U,2)=IEN
 D FREE^RORTMP(RORTMP)
 ;--- Analize the result
 I $G(RORTBL)<2  K RORTBL
 E  S $P(RORTBL(RORTBL),U,2)=$O(^DPT(" "),-1)
 Q +$G(RORTBL)
