ROR ;HCIOFO/SG - CLINICAL CASE REGISTRIES ; 1/26/07 4:54pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,3**;Feb 17, 2006;Build 7
 ;
 ; LOCAL VARIABLE ------ DESCRIPTION
 ;
 ; RORCACHE              In-memory cache
 ; RORERRDL              Default error location
 ; RORERROR              Error processing data
 ; RORPARM               Task-wide constants and variables
 ;
 ; See the source code of the ^ROR02 routine for more details.
 ;
 ; ROREXT                Regular data extraction    (See ^ROREXT)
 ; RORHDT                Historical data extraction (See ^RORHDT)
 ; RORLOG                Log subsystem data         (See ^RORLOG)
 ; RORUPD                Registry update parameters (See ^RORUPD)
 ;
 ; TEMPORARY NODE ------ DESCRIPTION
 ;
 ; ^TMP("RORHDT")        Control data of historical data extraction
 ; ^TMP("RORTMP")        Temporary storage
 ; ^TMP("RORUPD")        Registry update temporary data
 ;
 ; ^TMP(rtn_name)        Temporary storage used by the rtn_name
 ;                       routine (mostly, the RPC's)
 ;
 ; ^TMP($J,"RORTMP-"_)   Generic temporary storage used by ^RORTMP
 ;
 ; ^XTMP("RORHDT")       Control data of historical data extraction
 ; ^XTMP("RORUPDJ")      Registry update temporary data (multitask)
 ; ^XTMP("RORUPDR")      Registry update temporary data (installation)
 ;
 ; See detailed description of the temporary global nodes in
 ; the source code of the ^ROR01 routine.
 ;
 ; NAMESPACE ----------- DESCRIPTION
 ;
 ; RORAPI*               Supported APIs
 ; RORDD*                Routines used by the Data Dictionary
 ; RORERR*               Error processing
 ; ROREVT*               Event protocols
 ; ROREX*                Regular data extraction & transmission
 ; RORHDT*               Historical data extraction
 ; RORHIV*               HIV registry-specific routines
 ; RORHL*                HL7 utilities
 ; RORKIDS*              Low-level installation utilities (KIDS)
 ; RORLOCK*              Locks and transactions
 ; RORLOG*               Error recording
 ;
 ; RORPnnn*               Patch installation routines (KIDS)
 ;                         nnn - patch number
 ; RORPUT*               High-level installation utilities
 ;
 ; RORREP*               Roll-and-scroll reports
 ; RORRP*                Remote procedures
 ; RORSET*               Registry setup routines
 ; RORTXT*               Text resource routines
 ; RORUP*                Registry update
 ; RORUTL*               Utilities
 ; RORVM*                Entry points for VistA menu options
 ; RORXnnn*              XML reports (nnn - report code)
 ; RORXU*                Utilities for XML reports
 ;
 ; DIALOG -------------- DESCRIPTION
 ;
 ; 7980000.*             Various messages and templates
 ; 7981???.*             Report templates (XSL)
 ;
 ; MENU OPTION --------- DESCRIPTION
 ;
 ; [ROR TASK]            Registry update and data extraction option
 ;                       (must be scheduled; do not run it directly)
 ; [ROR SETUP]           Registry Setup
 ; [RORHDT MAIN]         Historical data extraction menu
 ; [RORMNT MAIN]         Maintenance menu
 ;
 ; SPECIAL ENTRY POINT - DESCRIPTION
 ;
 ;         ^RORUTL06     Menu for developer's utilities
 ; DISTPREP^RORUTL06     Prepares registry for KIDS distribution
 ;   PRTMDE^RORUTL06     Prints the data element metadata
 ;   VERIFY^RORUTL06     Checks the registry definition
 ;
 ;  EXTRACT^RORUTL07     Data extraction & transmission in debug mode
 ;   UPDATE^RORUTL07     Registry update in debug mode
 ;
 ; INITIALS ------------ DEVELOPER
 ;
 ; BH                    Brent Hicks
 ; CRT                   Cameron Taylor
 ; SG                    Sergey Gavrilov
 ;
 Q
 ;
 ;***** RETURNS THE TEST BUILD NUMBER FOR THE DATA EXTRACTION
BUILD() ;
 Q 1
 ;
 ;***** REGISTRY UPDATE AND DATA EXTRACTION TASK
 ;
 ; ZTQPARAM      String that contains a list of registry names
 ;               separated by commas. You must define the list as
 ;               a value of the TASK PARAMETERS field during
 ;               scheduling of the [ROR TASK] option that uses
 ;               this entry point.
 ;
 ; The following task parameters are optional. They can be defined
 ; on the second page of the option scheduling form as the pairs of
 ; variable names and values. See description of the ROR TASK option
 ; for more details regarding these parameters.
 ;
 ; [RORFLCLR]    Clear flags to control processing (default: "").
 ; [RORFLSET]    Set flags to control processing (default: "EX").
 ;
 ;                 D  Run the task(s) in Debug Mode #1
 ;
 ;                 E  Use the event references (file #798.3)
 ;
 ;                 M  Disable data extraction and HL7 messaging
 ;
 ;                 S  Run the data extraction in single-task mode
 ;
 ;                 X  Suspend the data extraction task in the
 ;                    same way as the registry update
 ;
 ; [RORMNTSK]    Maximum number of the registry update subtasks.
 ;               The default value of the parameter is "2-3-AUTO".
 ;
 ; [RORSUSP]     Suspension parameters of the registry update and
 ;               data extraction subtasks. The subtasks are not
 ;               suspended by default.
 ;
TASK ;
 N RORERROR      ; Error processing data
 N RORLOG        ; Log subsystem constants & variables
 N RORPARM       ; Application parameters
 ;
 N CNT,FLAGS,I,RC,REGLST,REGNAME,RORERRDL  K ZTREQ
 ;--- Initialize constants and variables
 D INIT^RORUTL01("ROR",1)
 D CLEAR^RORERR("TASK^ROR",1)
 ;--- Open a new log
 S RC=$$SETUP^RORLOG()
 S RC=$$OPEN^RORLOG(,7,"ROR TASK STARTED")
 ;
 ;--- Check and log the task parameters and force the <UNDEF>
 ;--- error in case of a missing/invalid critical value
 I $$TASKPRMS^ROR10(.REGLST)<0  K ZTQPARAM  S RC=ZTQPARAM
 ;--- Clear/Set the flags (override the default value)
 S FLAGS=$TR("EX",RORFLCLR_RORFLSET)_RORFLSET
 ;--- Associate the log with the registries
 S RC=$$SETRGLST^RORLOG(.REGLST)
 ;--- Enable debug mode if requested
 S:FLAGS["D" RORPARM("DEBUG")=1
 ;
 ;--- Rebuild the "ACL" cross-reference
 S RC=$$RNDXACL^RORUTL11()
 ;--- Remove inactive registries from the list
 S RC=$$ARLST^RORUTL02(.REGLST)  G:RC<0 ABORT
 ;--- Check the status of last HL7 message(s)
 I FLAGS'["M"  D  G:RC<0 ABORT
 . S RC=$$CHECKMSG^ROR10(.REGLST)
 ;
 ;--- Update the registries
 S RC=$$UPDATE^RORUPD(.REGLST,RORMNTSK,RORSUSP,FLAGS)
 ;--- Process the errors
 I RC<0  D  G:RC<0 ABORT
 . ;--- Quit if stop is requested (via the TaskMan User option)
 . I RC=-42  D ALERT^RORUTL01(.REGLST,-42)  S ZTSTOP=1  Q
 . ;--- Do not send the alert for some warnings
 . I RC=-28  S RC=0  Q
 . ;--- Send the alert in case of other errors/warnings
 . D ALERT^RORUTL01(.REGLST,-43,,,,"registry update")
 . S RC=0
 ;
 ;--- Mark registry records 1 month after the installation so that
 ;    the local registry data and demographic data will be resent
 ;--- to restore the data overwritten with the historical data
 S RC=$$REMARK^RORUTL05(.REGLST,31)
 ;
 ;--- Perform the data extraction
 S RC=$S(FLAGS'["M":$$EXTRACT^ROREXT(.REGLST,,RORSUSP,FLAGS),1:0)
 ;--- Process the errors
 I RC<0  D  G:RC<0 ABORT
 . ;--- Quit if stop is requested (via the TaskMan User option)
 . I RC=-42  D ALERT^RORUTL01(.REGLST,-42)  S ZTSTOP=1  Q
 . ;--- Do not send the alert for some warnings
 . I RC=-28  S RC=0  Q
 . ;--- Send the alert in case of other errors/warnings
 . D ALERT^RORUTL01(.REGLST,-43,,,,"data extraction")
 . S RC=0
 ;
 ;--- Purge the old tasks
 S RC=$$PURGE^RORTSK02(14)
 ;--- Purge the old logs
 S RC=$$PURGE^RORLOG01(31)
 ;--- Purge the old event references
 S RC=$$EPDATE^RORUTL05()
 S:RC>0 RC=$$PURGE^RORUPP02(RC)
 ;---
 S ZTREQ="@"
ABORT ;
 S I=$S($G(ZTREQ)="@":"COMPLETED",1:"ABORTED")
 D CLOSE^RORLOG("ROR TASK "_I)
 Q
