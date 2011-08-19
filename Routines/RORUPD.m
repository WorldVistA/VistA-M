RORUPD ;HCIOFO/SG - REGISTRY UPDATE ; 7/21/05 10:28am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; RORLRC -------------- LIST OF LAB RESULT CODES TO CHECK
 ;
 ; RORLRC(Seq#)          Lab result code (see the LA7SC parameter of
 ;                       the GCPR^LA7QRY entry point)
 ;                         ^1: Result code
 ;                         ^2: Coding system ("LN" or "NLT")
 ;
 ; RORUPD -------------- REGISTRY UPDATE DESCRIPTOR
 ;
 ; RORUPD("DT")          Date/time when update process started
 ;
 ; RORUPD("DSBEG")       Start date of the data scan
 ; RORUPD("DSEND")       End date of the data scan
 ;                       (these nodes are set by $$PREPARE1^RORUPR)
 ;
 ; RORUPD("EETS")        Timestamp of the earliest event reference
 ;
 ; RORUPD("ERRCNT")      Counter of errors during processing of the
 ;                       current patient
 ;
 ; RORUPD("FLAGS")       Flags to control processing (see the
 ;                       TASK^ROR for possible values).
 ;
 ; RORUPD("JOB")         Job number of the main task. This node is
 ;                       defined only if the registry update is
 ;                       running in the multitask mode.
 ;
 ; RORUPD("LD",          Instead of checking data in the interval
 ;                       from start date till end date, update process
 ;                       starts checks from the start date minus
 ;                       appropriate number of lag days. Thus, data
 ;                       entered retrospectively will not be missed.
 ;   1)                  Lag days for data examination
 ;
 ; RORUPD("LM",          Loop control mode. It defines when to stop
 ;                       looping through records of the patient:
 ;                         0  always loop through all records
 ;                         1  all top level rules have been triggered
 ;                            for the patient (default)
 ;                         2  patient has been marked for addition to
 ;                            all registries being processed
 ;   1,Rule Name)        Current list of names of top level rules
 ;   2,Registry#)        Current list of registry IENs
 ;
 ; RORUPD("LM1",         STATIC LIST OF TOP LEVEL RULES
 ;   Rule Name)
 ;
 ; RORUPD("LM2",         STATIC LIST OF REGISTRIES
 ;   Registry#)            ^1: 1 - if the current patient can be added
 ;                             to the registry; 0 - if the patient is
 ;                             already in the registry or he/she is
 ;                             an employee and should be skipped.
 ;                         ^2: 1 if the employees must not be added
 ;                             to the registry.
 ;
 ; RORUPD("MAXPPCNT")    When counters in the ROR PATIENT EVENTS
 ;                       file reach a value stored in this node, the
 ;                       corresponding patient will be skipped until
 ;                       someone fixes the error(s) and resets the
 ;                       counters to 1.
 ;
 ; RORUPD("ROOT",File#)  Closed root of the file
 ;
 ; RORUPD("SR",          PREPARED SELECTION RULES
 ;   File#,              This node is defined if the file should be
 ;                       processed
 ;
 ;     "A",              List of rules that should be applied after
 ;                       processing sub-files and linked files.
 ;     "B",              List of rules that should be applied before
 ;                       processing sub-files and linked files.
 ;       Seq#,             ^1: Selection Rule Name
 ;                         ^2: Rule# (Selection Rule IEN)
 ;                         ^3: 1 if registry should be updated if
 ;                             the expression evaluated as True
 ;                             (top-level seelction rule)
 ;         1)            MUMPS expression that implements the rule
 ;         2,Registry#)  List of IENs of affected registries
 ;
 ;     "F",              A list of data elements that should be loaded
 ;                       before applying selection rules is created
 ;                       under this node. The elements are grouped by
 ;                       the APIs used to load the values.
 ;       API#,           For API #1 (FileMan GETS^DIQ) this node
 ;                       contains a list of fields separated by ';'.
 ;         DataCode,     For data elements associated with the API #1
 ;                       this node stores the field number.
 ;           "E")        If an external value of the field should be
 ;                       loaded, a value of the field 4.1 of the
 ;                       subfile #799.22 is assigned to this node.
 ;           "I")        If an internal value of the field should be
 ;                       loaded, a value of the field 4.2 of the
 ;                       subfile #799.22 is assigned to this node.
 ;
 ; RORUPD("SUSPEND")     SUBTASKS SUSPENSION PARAMETERS
 ;                         ^1: Suspension start time (FileMan)
 ;                         ^2: Suspension end time (FileMan)
 ;
 ;                       For example, to suspend subtasks from
 ;                       7:00 until 18:00 this node should have
 ;                       the following value: ".07^.18".
 ;
 ; RORUPD("UPD",         CALL-BACK ENTRY POINTS
 ;   Registry#,1)        Entry point of a MUMPS external function
 ;                       that assign values of additional fields to
 ;                       the registry FDA before registry update
 ;                       (opt'l).
 ;   Registry#,2)        Entry point of a MUMPS external function
 ;                       that is called right after registry update
 ;                       (opt'l).
 ;
 ; RORUPDPI ------------ CLOSED ROOT OF THE TEMPORARY STORAGE
 ;                       (the ^TMP("RORUPD",$J), ^XTMP("RORUPDJ"_$J)
 ;                       or ^XTMP("RORUPDR"_Registry#) node)
 ;
 ; See also a description of ^XTMP("RORUPD"_) in the ^ROR01 routine.
 ;
 Q
 ;
 ;***** UPDATES THE REGISTRIES
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as subscripts and registry IENs as values
 ;
 ; [MAXNTSK]     Maximum number of the data processing subtasks.
 ;               See description of the $$PROCESS^RORUPD05 function
 ;               for details.
 ;
 ; [SUSPEND]     Subtask suspension parameters:
 ;               See description of the RORUPD("SUSPEND") node
 ;               for details.
 ;
 ; [FLAGS]       Flags to control processing.
 ;               See description of the TASK^ROR for
 ;               possible values of the flags).
 ;
 ; Return Values:
 ;       <0  Error code (see MSGLIST^RORERR20)
 ;        0  Ok
 ;
UPDATE(REGLST,MAXNTSK,SUSPEND,FLAGS) ;
 N RORERRDL      ; Default error location
 N RORLOG        ; Log subsystem constants & variables
 N RORLRC        ; List of Lab result codes to check
 N RORUPD        ; Update descriptor
 N RORUPDPI      ; Closed root of the temporary storage
 N RORVALS       ; Calculated values
 ;
 N COUNTERS,RC,TMP
 D INIT^RORUTL01("RORUPD")
 S RORUPD("FLAGS")=$$UP^XLFSTR($G(FLAGS))
 D CLEAR^RORERR("UPDATE^RORUPD")
 ;--- Value of the RORUPDPI variable is modified by the
 ;    $$PROCESS^RORUPD05 function if the registry update
 ;--- process runs in the multi-task mode.
 S RORUPDPI=$NA(^TMP("RORUPD",$J))
 ;--- Open a new log
 S TMP=$$SETUP^RORLOG(.REGLST)
 S TMP=$$OPEN^RORLOG(.REGLST,1,"REGISTRY UPDATE STARTED")
 D
 . ;--- Check a list of registries
 . I $D(REGLST)<10  D  Q
 . . S RC=$$ERROR^RORERR(-28,,,,"update")
 . ;--- Lock parameters of the registries being processed
 . S RC=$$LOCKREG^RORUTL02(.REGLST,1,,"REGISTRY UPDATE")  Q:RC<0
 . I 'RC  D  K REGLST  Q
 . . S RC=$$ERROR^RORERR(-11,,,,"registries being processed")
 . ;--- Prepare selection rules
 . S:$G(SUSPEND)>0 RORUPD("SUSPEND")=SUSPEND
 . S RC=$$PREPARE^RORUPR(.REGLST)
 . I RC<0  S RC=$$ERROR^RORERR(-14)  Q
 . ;--- Display the debug information
 . D:$G(RORPARM("DEBUG"))>1 DEBUG^RORUPDUT
 . ;--- Look for new patients and update the registries
 . S RC=$$PROCESS^RORUPD05($G(MAXNTSK))  Q:RC<0
 . S COUNTERS=RC
 . ;--- Update registry parameters
 . S TMP=$$TMSTMP^RORUPD01(.REGLST)
 . ;--- Update demographic data
 . D LOG^RORLOG(,"Demographic Update")
 . S RC=$$UPDDEM^RORUPD51(.REGLST)
 ;
 ;--- Unlock parameters of processed registries
 S TMP=$$LOCKREG^RORUTL02(.REGLST,0)
 ;--- Statistics & Cleanup
 S TMP="REGISTRY UPDATE "_$S(RC<0:"ABORTED",1:"COMPLETED")
 D CLOSE^RORLOG(TMP,$G(COUNTERS))
 D:'$G(RORPARM("DEBUG"))
 . D INIT^RORUTL01("RORUPD")
 . ;--- Do not kill the list of processed patients ("U" subnode)
 . ;    in case of an error or crash during the initial registry
 . ;--- population (registry setup).
 . K:'$G(RORPARM("SETUP"))!(RC'<0) @RORUPDPI
 Q $S(RC<0:RC,1:0)
