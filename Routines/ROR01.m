ROR01 ;HCIOFO/SG - CLINICAL CASE REGISTRIES (TEMP. GLOBALS) ; 4/23/07 3:18pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,3**;Feb 17, 2006;Build 7
 ;
 ; ^TMP($J,"RORTMP-"_) - TEMPORARY STORAGE (see the ^RORTMP routine)
 ;
 ; ^TMP($J,"RORTMP-0",   Indexes of allocated buffers
 ;   i)                  ""
 ;
 ; ^TMP($J,"RORTMP-"_i,  Allocated buffers
 ;   ...)
 ;
 ; ^TMP("RORACK") ------ CONTROL DATA OF ACKNOWLEDGEMENT PROCESSING
 ;
 ; ^TMP("RORACK",$J,
 ;   "PR",IEN)           List of IENs of registry records that
 ;                       acknowledgements have been processed for.
 ;
 ; ^TMP("RORHDT") ------ CONTROL DATA OF HISTORICAL DATA EXTRACTION
 ;
 ; ^TMP("RORHDT",$J,
 ;   "PR",               List of IENs of registry records processed
 ;                       in the re-extraction section of function
 ;                       $$EXTRACT^RORHDT04.
 ;     IEN)              Return code of the record processing. If this
 ;                       value is less than zero, data extraction was
 ;                       not successful again.
 ;
 ; ^TMP("RORPTF") ------ TEMPOPARY PTF INDEX FOR DATA EXTRACTION
 ;
 ; ^TMP("RORPTF",$J,
 ;   "DTF",              List of already indexed time frames of
 ;                       the PTF CLOSE OUT file (#45.84).
 ;     StartDate)        StartDate^EndDate
 ;   "PDI",              Temporary PTF index itself
 ;     DFN,PTFIEN)       ""
 ;
 ; ^TMP("RORTMP",$J) --- TEMPORARY STORAGE
 ;
 ; ^TMP("RORUPD") ------ REGISTRY UPDATE TEMPORARY DATA
 ;
 ; ^TMP("RORUPD",$J,
 ;
 ;   1,File#,
 ;     "S",Rule Name)    List of selection rules
 ;     "F",DataCode,     List of data elements to load
 ;       "E")            If expression implementing the selection
 ;                       rule references an external value of the
 ;                       element, the "E" sub-node will be defined.
 ;       "I")            If expression implementing the selection
 ;                       rule references an internal value of the
 ;                       element, the "I" sub-node will be defined.
 ;
 ;   2,Registry#)        Registry Name
 ;
 ;   3,Rule Name,        Selection rule descriptor
 ;                         ^1: Rule#
 ;                         ^2: File Number
 ;                         ^3: 1 if already processed, otherwise
 ;                             empty string
 ;                         ^4: 1 if registry should be updated (in
 ;                             case of matched condition, of course)
 ;     1)                MUMPS function entry point
 ;     2,Registry#)      List of affected registries
 ;     3,Rule Name)      List of rules that this rule depend on
 ;
 ;   4,LabSearch#)       List of Lab search IENs
 ;
 ;   "LS",
 ;     Result Code,
 ;       LabSearch#,
 ;         Seq#)         Condition to check the result
 ;                         ^1: Indicator
 ;                         ^2: Indicated Value
 ;
 ;   "U",Patient#,       This node is defined if the patient has been 
 ;                       processed
 ;     2,Registry#,      This node is defined if the registry should
 ;                       be updated
 ;       Rule#)          Reference to a top-level selection rule
 ;                         ^01: Trigger date of the rule
 ;                         ^02: Institution IEN
 ;
 ; ^XTMP("RORLOCK") ---- LIST OF LOCK DESCRIPTORS
 ;
 ; ^XTMP("RORLOCK",
 ;   NodeNdx)            Lock Descriptor (see ^RORLOCK for details)
 ;                         ^01: Date/Time (FileMan)
 ;                         ^02: User/Process name
 ;                         ^03: User IEN (DUZ)
 ;                         ^04: $JOB
 ;                         ^05: Task number
 ;                         ^06: Lock counter
 ;
 ; ^XTMP("RORTHREAD") -- RPC THREAD DESCRIPTORS
 ;
 ; ^XTMP("RORTHREAD",
 ;
 ;   0)                  Node descriptor
 ;                         ^1: Purge date  (FileMan)
 ;                         ^2: Create date (FileMan)
 ;                         ^3: Description
 ;
 ;   Task#,              Task number returned by the Taskman
 ;     "RESULTS",
 ;       i,              Line of thread results (i>0)
 ;         j)            Continuation of the line (j>0)
 ;
 ; ^XTMP("RORUPD"_) ---- REGISTRY UPDATE TEMPORARY DATA (MULTITASK)
 ;
 ;                       If the registry update starts in the
 ;                       multitask mode, all temporary data from the
 ;                       ^TMP("RORUPD",$J) node is merged to this
 ;                       node so that it will be available for all
 ;                       registry update subtasks.
 ;
 ; ^XTMP("RORUPDJ"_$J,
 ;                       If the regular registry update is run in the
 ;                       multitask mode, the ^XTMP("RORUPDJ"_$J) node
 ;                       is used. $J is the job number of the main
 ;                       registry update task.
 ;
 ; ^XTMP("RORUPDR"_Registry#,
 ;                       During the initial registry population
 ;                       (performed by the post-install routines),
 ;                       the ^XTMP("RORUPDR"_Registry#) node is used.
 ;                       The list of processed patients (the "U"
 ;                       subscript) is used to restart the process
 ;                       after an error or a crash.
 ;
 ;   0)                  Node descriptor
 ;                         ^1: purge date  (FileMan)
 ;                         ^2: create date (FileMan)
 ;                         ^3: description
 ;
 ;   "T",Task#)          This node is LOCKed while the (sub)task is
 ;                       running (subscript of the main task is 0).
 ;
 ;                       Otherwise, "S" means that the subtask has
 ;                       been scheduled but not started yet.
 ;
 ;                       A negative value of the non-locked node
 ;                       represents the error code (for example,
 ;                       -60 means that the subtask has crashed).
 ;
 ;                       Non-negative value of the node means that
 ;                       the subtask has been completed. The value
 ;                       has the following structure:
 ;                         ^1: Number of processed patients
 ;                         ^2: Number of patients processed with
 ;                             errors
 ;
 Q
