RORRP010 ;HCIOFO/SG - RPC: TASK MANAGER ; 10/5/05 11:12am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** DELETES THE TASK
 ; RPC: [ROR TASK DELETE]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; TASK          Task number
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, zero is returned.
 ;
DELTASK(RESULTS,TASK) ;
 N RORERRDL  K RESULTS
 D CLEAR^RORERR("DELTASK^RORRP010",1)
 S RESULTS=$$DEQUEUE^RORTSK(TASK,1)
 D:RESULTS<0 RPCSTK^RORERR(.RESULTS,RESULTS)
 Q
 ;
 ;***** SCHEDULES THE REPORT
 ; RPC: [ROR REPORT SCHEDULE]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; RPTCODE       Code of the report
 ;
 ; [REGIEN]      Registry IEN (if $G(REGIEN)'>0 the task will not
 ;               be associated with any particular registry).
 ;
 ; [ZTDTH]       Date/time to start the task (FileMan). By default
 ;               (if $G(ZDTH)'>0) the task will be scheduled to run
 ;               immediately (see the $$CREATE^RORTSK for details).
 ;
 ; [SCHCODE]     Rescheduling code for the task. By default (if
 ;               $G(SCHCODE)=""), the task is executed once. See
 ;               description of the $$SCH^XLFDT function for
 ;               possible values of the parameter).
 ;
 ; [.PARAMS]     Reference to a local variable that contains report
 ;               parameters in XML format.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, the task descriptor is returned in the RESULTS array
 ; (see the TASKINFO^RORRP010 entry point for details).
 ;
SCHEDREP(RESULTS,RPTCODE,REGIEN,ZTDTH,SCHCODE,PARAMS) ;
 N RORERRDL,RPINFO,TASK,TMP,TSKPRM
 N ZTCPU,ZTDESC,ZTIO,ZTKIL,ZTPRI,ZTSAVE,ZTSYNC,ZTUCI
 D CLEAR^RORERR("SCHEDREP^RORRP010",1)
 S REGIEN=+$G(REGIEN),SCHCODE=$G(SCHCODE)
 ;--- Get the report descriptor
 S RC=$$RPINFO^RORUTL08(RPTCODE,.RPINFO)
 I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 ;--- Parse the report parameters
 S RC=$$PARSEPRM^RORTSK13(.PARAMS,.TSKPRM)
 ;--- Create the task
 S TASK=$$CREATE^RORTSK(2,RPINFO(9),,REGIEN,RPTCODE,SCHCODE,.TSKPRM)
 I TASK<0  D RPCSTK^RORERR(.RESULTS,TASK)  Q
 ;--- Get the status
 D TASKINFO(.RESULTS,TASK)
 Q
 ;
 ;***** RETURNS THE TASK INFORMATION
 ; RPC: [ROR TASK INFO]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; TASK          Task number
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, the task descriptor is returned in the RESULTS array
 ; (see the $$TASKINFO^RORTSK02 function for more details).
 ;
 ; RESULTS(0)            Result Descriptor
 ;                         ^1: 1
 ;                         ^2: Number of nodes that make a single
 ;                             task descriptor (TIN)
 ;
 ; RESULTS(1)            Task Number
 ; RESULTS(2)            Task Type           (internal^external)
 ; RESULTS(3)            Registry            (IEN^Name)
 ; RESULTS(4)            Report              (Code^Name)
 ; RESULTS(5)            Description
 ; RESULTS(6)            Task Status         (internal^external)
 ; RESULTS(7)            Creation Time       (internal)
 ; RESULTS(8)            User                (DUZ^Name)
 ; RESULTS(9)            Completion Time     (internal)
 ; RESULTS(10)           Progress Percentage
 ; RESULTS(11)           Scheduled to Run at (internal)
 ; RESULTS(12)           Task Log IEN
 ; RESULTS(13)           Job Number
 ;
TASKINFO(RESULTS,TASK) ;
 N RC,RORERRDL
 D CLEAR^RORERR("TASKINFO^RORRP010",1)
 S RC=$$TASKINFO^RORTSK02(TASK,.RESULTS,"EI")
 I RC'<0  S RESULTS(0)="1^"_$$TIN^RORTSK02
 E  D RPCSTK^RORERR(.RESULTS,RC)
 Q
 ;
 ;***** RETURNS A LIST OF USER'S TASKS
 ; RPC: [ROR TASK LIST]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; [REGIEN]      Registry IEN (all registries by default)
 ; [TYPE]        Task Type (all types by default)
 ; [USER]        User IEN (DUZ by default)
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, the task descriptors are returned in the RESULTS array
 ; (see the TASKINFO^RORRP010 entry point for details).
 ;
 ; @RESULTS@(0)          Result Descriptor
 ;                         ^01: Number of task descriptors returned
 ;                              in the RESULTS array (NTSK)
 ;                         ^02: Number of nodes that make a single
 ;                              task descriptor (TIN)
 ;
 ; @RESULTS@(i)          Value returned by the $$TASKINFO^RORTSK02
 ;                       function. You can calculate the subscript
 ;                       of the item TI (from 1 to TIN) of the task
 ;                       TN (from 1 to NTSK) using the following
 ;                       formula: i = (TN-1)*TIN+TI.
 ;
 ; For example, if number of nodes returned by the $$TASKINFO^RORTSK02
 ; function for each task is 13 and the RESULTS array contains
 ; information about 3 tasks, the following nodes will be defined:
 ;
 ;   @RESULTS@(0)  = "3^13"
 ;
 ;   @RESULTS@(1)  = Task Number 1
 ;   @RESULTS@(2)  = Task Type 1 (internal^external)
 ;   ...
 ;   @RESULTS@(13) = Job Number 1
 ;
 ;   @RESULTS@(14) = Task Number 2
 ;   @RESULTS@(15) = Task Type 2 (internal^external)
 ;   ...
 ;   @RESULTS@(26) = Job Number 2
 ;
 ;   @RESULTS@(27) = Task Number 3
 ;   @RESULTS@(28) = Task Type 3 (internal^external)
 ;   ...
 ;   @RESULTS@(39) = Job Number 3
 ;
TASKLIST(RESULTS,REGIEN,TYPE,USER) ;
 N INFO,NTSK,RC,RORERRDL,TASK,TASKLIST,TIN
 D CLEAR^RORERR("TASKLIST^RORRP010",1)
 ;--- Initialize the variables
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 S TIN=$$TIN^RORTSK02
 ;--- Get the list of task numbers
 S RC=$$LIST^RORTSK02(.TASKLIST,$G(REGIEN),$G(TYPE),,,$G(USER))
 I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 ;--- Generate the output list
 S TASK="",NTSK=0
 F  S TASK=$O(TASKLIST(TASK))  Q:TASK=""  D
 . K INFO
 . S RC=$$TASKINFO^RORTSK02(TASK,.INFO,"EI",NTSK*TIN)  Q:RC<0
 . M @RESULTS=INFO  S NTSK=NTSK+1
 S @RESULTS@(0)=NTSK_U_TIN
 Q
