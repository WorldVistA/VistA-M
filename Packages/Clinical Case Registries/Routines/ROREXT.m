ROREXT ;HCIOFO/SG - DATA EXTRACTION & TRANSMISSION ; 11/1/05 3:08pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; ROREXT -------------- DATA EXTRACTION DESCRIPTOR
 ;
 ; ROREXT("DTAR",        Data is extracted only in those areas that
 ;                       are listed here. If a data area time frame
 ;                       is provided, then it is merged with the
 ;                       regular time frame(s) for that area.
 ;   DataArea)           "" or Data Area Time Frame
 ;                         ^01: Start Date (FileMan)
 ;                         ^02: End Date   (FileMan)
 ;
 ; ROREXT("DXBEG")       Start date of the data extraction (opt'l)
 ;                       If this node is defined and greater than
 ;                       zero, data extraction starts from this date
 ;                       (instead of individual start date for each
 ;                       patient in the registry).
 ;
 ; ROREXT("DXEND")       End date of the data extraction
 ;                       (these nodes are set by $$PREPARE^ROREXPR).
 ;
 ; ROREXT("EXTRDAYS")    Extraction period for a new patient
 ;
 ; ROREXT("FLAGS")       Flags to control processing (see the
 ;                       TASK^ROR for possible values).
 ;
 ; ROREXT("HDTIEN")      When a historical data extraction is
 ;                       performed, this node stores IEN of
 ;                       the record of the ROR HISTORICAL DATA
 ;                       EXTRACTION file (#799.6).
 ;
 ; ROREXT("HL7BUF")      Closed root of the buffer where the HL7
 ;                       message is constructed. By default, the
 ;                       ^TMP("HLS",$J) is used.
 ;
 ; ROREXT("HL7CNT")      Counter of the messages in the batch
 ; ROREXT("HL7DT")       Date of the batch message creation (FileMan)
 ; ROREXT("HL7MID")      Message ID of the "stub" message
 ; ROREXT("HL7MTIEN")    IEN in the File #772 for the "stub" message
 ; ROREXT("HL7PROT")     Name of the event driver protocol
 ;
 ; ROREXT("HL7PTR")      Subscript of the last occupied sub-node of
 ;                       the message buffer (see the "HL7BUF").
 ;                       Value of the variable is incremented before
 ;                       storing the segment.
 ;
 ; ROREXT("HL7SID",
 ;   SegName)            The next value of the Set ID for this kind
 ;                       of segments. The $$CREATE^RORHL7 function
 ;                       resets the Set ID's to 1 for all supported
 ;                       segments.
 ;
 ; ROREXT("HL7SIZE")     Current size of the HL7 batch
 ;                         ^1: Current size (in bytes)
 ;                         ^2: 1 if maximum size has been reached
 ;
 ; ROREXT("LD",
 ;   1)                  Number of lag days for the data extraction
 ;
 ; ROREXT("MAXHL7SIZE")  Maximum size (in bytes) of an HL7 message
 ;
 ; ROREXT("MSGBLD",
 ;   RegIEN)             Message builder call-back entry point (opt'l)
 ;
 ; ROREXT("NBM")         Number of batch messages generated for
 ;                       the current protocol
 ;
 ; ROREXT("PATCH",
 ;   PatchName)          Defined if the patch is installed
 ;
 ; ROREXT("SUSPEND")     DATA EXTRACTION SUSPENSION PARAMETERS
 ;                         ^1: Suspension start time (FileMan)
 ;                         ^2: Suspension end time (FileMan)
 ;
 ;                       For example, to suspend the data extraction
 ;                       from 7:00 until 18:00 this node should have
 ;                       the following value: ".07^.18".
 ;
 ; ROREXT("VERSION")     ROR version/patch installed at the site
 ;                         ^1: Version number (e.g. 1.0)
 ;                         ^2: Latest patch number (e.g. 5)
 ;                         ^3: Patch installation date (FileMan)
 ;
 ; RORHL --------------- HL7 ENVIRONMENT VARIABLES
 ;
 ; RORHL                 This local array contains HL7 environment
 ;                       variables initialized by INIT^HLFNC2 ("FS",
 ;                       "ECH" and others).
 ;
 ; RORLRC -------------- LIST OF EXTRACTED LAB RESULTS
 ;
 ; RORLRC(               Either a list of codes of a Lab results to
 ;                       extract or "*" for all results (see the LA7SC
 ;                       parameter of the GCPR^LA7QRY entry point)
 ;   Seq#)               Lab result code
 ;                         ^1: Result code
 ;                         ^2: Coding system ("LN" or "NLT")
 ;
 Q
 ;
 ;***** PERFORMS THE DATA EXTRACTION
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as subscripts and registry IENs as values
 ;
 ; [DXBEG]       Data extraction start date (individual start
 ;               date for each patient by default).
 ;               Time part of the parameter value is ignored.
 ;
 ; [SUSPEND]     Subtask suspension parameters:
 ;               See description of the ROREXT("SUSPEND") node
 ;               for details.
 ;
 ; [FLAGS]       Flags to control processing.
 ;               See description of the TASK^ROR for
 ;               possible values of the flags.
 ;
 ; Return Values:
 ;       <0  Error code (see MSGLIST^RORERR20)
 ;        0  Ok
 ;
EXTRACT(REGLST,DXBEG,SUSPEND,FLAGS) ;
 N ROREXT        ; Data extraction descriptor
 N ROREXTSV      ; Backup copy of the descriptor
 ;
 N CNT,ERRCNT,PGRLST,RC,REGIEN,REGNAME,RORGLST,RORMSG,RORPROT,TMP,ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 D CLEAR^RORERR("EXTRACT^ROREXT")
 S (ERRCNT,RC)=0
 ;
 ;=== Prepare the common parameters
 S:$G(DXBEG)>0 ROREXT("DXBEG")=DXBEG
 S ROREXT("FLAGS")=$$UP^XLFSTR($G(FLAGS))
 ;--- Enable task suspension if requested
 I $G(SUSPEND)>0  S:ROREXT("FLAGS")["X" ROREXT("SUSPEND")=SUSPEND
 ;
 ;=== Group the registries by the HL7 protocol name
 S REGNAME=""
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D
 . ;--- Get the registry IEN
 . S REGIEN=+REGLST(REGNAME)
 . I REGIEN'>0  D  Q:REGIEN'>0
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . ;--- Get the HL7 protocol name
 . S RORPROT=$$GET1^DIQ(798.1,REGIEN_",",13,"E",,"RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,798.1,REGIEN_",")
 . I RORPROT=""  D  S ERRCNT=ERRCNT+1  Q
 . . D ERROR^RORERR(-25,,REGNAME)
 . ;--- Create the reference
 . S PGRLST(RORPROT,REGNAME)=REGIEN
 ;
 ;=== Data extraction
 M ROREXTSV=ROREXT
 S RORPROT="",RC=0
 F CNT=1:1  S RORPROT=$O(PGRLST(RORPROT))  Q:RORPROT=""  D  Q:RC<0
 . ;--- Prepare the task-specific parameters
 . K RORGLST  M RORGLST=PGRLST(RORPROT)
 . S ROREXT("HL7PROT")=RORPROT
 . ;--- Single-task data extraction (if requested)
 . I ROREXT("FLAGS")["S"  D  Q
 . . S TMP=$$INTEXT^ROREXT01(.RORGLST)
 . . I TMP<0  S:TMP=-42 RC=TMP  S ERRCNT=ERRCNT+1
 . . K ROREXT  M ROREXT=ROREXTSV
 . ;--- Otherwise, start a separate task
 . S ZTRTN="TASK^ROREXT",ZTIO=""
 . S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,,(CNT-1)*30)
 . S ZTDESC="CCR Data Extraction ("_RORPROT_")"
 . F TMP="ROREXT(","RORGLST(","RORPARM("  S ZTSAVE(TMP)=""
 . D ^%ZTLOAD
 . ;--- Log the action
 . D LOG^RORERR(-94,,,ZTSK)
 ;
 ;=== Error processing
 Q $S(RC<0:RC,ERRCNT>0:-43,1:0)
 ;
 ;***** ENTRY POINT FOR DATA EXTRACTION TASK
 ;
 ; ROREXT        Data extraction descriptor
 ; RORGLST       List of registry names and IENs
 ; RORPARM       Task-wide constants and variables
 ;
TASK ;
 N RORERRDL      ; Default error location
 N RORERROR      ; Error processing data
 ;
 N RC,TMP  K ZTREQ
 ;--- Initialize the variables
 D CLEAR^RORERR("TASK^ROREXT",1)
 ;--- Disable debug output (task has no output device)
 S:$G(RORPARM("DEBUG"))>1 RORPARM("DEBUG")=1
 ;--- Data extraction
 S RC=$$INTEXT^ROREXT01(.RORGLST,ZTSK)
 ;--- Error processing and notifications
 S:RC<0 ZTSTOP=1
 I RC=-42  D ALERT^RORUTL01(.RORGLST,-42)  Q
 D:RC<0 ALERT^RORUTL01(.RORGLST,-43,,,,"data extraction")
 S ZTREQ="@"
 Q
