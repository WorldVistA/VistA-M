ROREXT01 ;HCIOFO/SG - EXTRACTION & TRANSMISSION PROCESS ;1/22/06 12:40pm
 ;;1.5;CLINICAL CASE REGISTRIES;**10**;Feb 17, 2006;Build 32
 ;
 ; This routine uses the following IAs:
 ;
 ; #10063  $$S^%ZTLOAD (supported)
 ; #10103  $$FMDIFF^XLFDT (supported)
 ; #10103  $$NOW^XLFDT (supported)
 Q
 ;
 ;***** INTERNAL ENTRY POINT FOR DATA EXTRACTION
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as subscripts and registry IENs as values
 ;
 ; [RORTASK]     Task Number (if the data extraction is performed
 ;               by a separate process)
 ;
 ; Return Values:
 ;       <0  Error code (see MSGLIST^RORERR20)
 ;        0  Ok
 ;
 ; NOTE: The ROREXT and RORPARM local arrays must be properly
 ;       initialized before calling this function.
 ;
INTEXT(REGLST,RORTASK) ;
 N RORHL         ; HL7 variables
 N RORLOG        ; Log subsystem constants & variables
 N RORLRC        ; List of codes of Lab results to be extracted
 ;
 N COUNTERS,DXBEG,DXEND,HDTIEN,MID,RC,TMP
 D INIT^RORUTL01("ROREXT")
 S DXBEG=$G(ROREXT("DXBEG")),DXEND="",HDTIEN=0
 K ^TMP("RORPTF",$J)
 ;--- Open a new log
 S TMP=$$SETUP^RORLOG(.REGLST)
 S TMP=$S($G(RORTASK)'="":" TASK #"_RORTASK,1:"")
 S TMP=$$OPEN^RORLOG(.REGLST,2,"DATA EXTRACTION"_TMP_" STARTED")
 D
 . ;--- Check the list of registries
 . I $D(REGLST)<10  D  Q
 . . S RC=$$ERROR^RORERR(-28,,,,"extract data")
 . ;--- Lock parameters of the registries being processed
 . S RC=$$LOCKREG^RORUTL02(.REGLST,1,,"DATA EXTRACTION")  Q:RC<0
 . I 'RC  D  Q
 . . S RC=$$ERROR^RORERR(-11,,,,"registries being processed")
 . ;--- Check for pending historical data extraction
 . I DXBEG'>0  D  I HDTIEN<0  S RC=+HDTIEN  Q
 . . S HDTIEN=$$FIND^RORHDT06(.REGLST,.DXBEG,.DXEND)
 . ;--- Load and process data extraction rules
 . S RC=$$PREPARE^ROREXPR(.REGLST,DXBEG,DXEND)
 . I RC<0  S RC=$$ERROR^RORERR(-22)  Q
 . ;--- Load and process the historical data extraction parameters
 . I HDTIEN>0  D  Q:RC<0
 . . S RC=$$PREPARE^RORHDT06(HDTIEN)
 . ;--- Reference the historical data extraction definition
 . S RC=$$REGREF^RORHDT06(.REGLST,HDTIEN)  Q:RC<0
 . ;--- Display the debug information
 . D:$G(RORPARM("DEBUG"))>1 DEBUG^ROREXTUT
 . ;--- Extract and send the data
 . S RC=$$PROCESS(.REGLST)  Q:RC<0
 . S COUNTERS=RC,RC=0
 . ;--- Update registry parameters
 . S TMP=$$TMSTMP^ROREXTUT(.REGLST)
 ;--- Unlock parameters of processed registries
 S TMP=$$LOCKREG^RORUTL02(.REGLST,0)
 ;
 ;--- Statistics & Cleanup
 S TMP="DATA EXTRACTION "_$S(RC<0:"ABORTED",1:"COMPLETED")
 D CLOSE^RORLOG(TMP,$G(COUNTERS))
 D:'$G(RORPARM("DEBUG")) INIT^RORUTL01("ROREXT")
 K ^TMP("RORPTF",$J)
 ;---
 Q $S($G(RC)<0:RC,1:0)
 ;
 ;***** RETURNS THE NEXT PATIENT FOR DATA EXTRACTION
 ;
 ; PTIEN         Patient IEN (DFN in file #2)
 ;
 ; .RGIENLST     Reference to a local array containing registry
 ;               IENs as subscripts. The IENs of the corresponding
 ;               patient's registry records are returned as values.
 ;
 ; Return Values:
 ;        0  No more patients
 ;       >0  IEN (DFN) of the next patient who belongs to at least
 ;           one of the registries defined by the RGIENLST parameter.
 ;
NEXTPAT(PTIEN,RGIENLST) ;
 N CNT,IEN,REGIEN,STATUS
 S CNT=0
 F  S PTIEN=$O(^RORDATA(798,"KEY",PTIEN))  Q:PTIEN'>0  D  Q:CNT
 . S REGIEN=0
 . F  S REGIEN=$O(RGIENLST(REGIEN))  Q:REGIEN'>0  D
 . . S RGIENLST(REGIEN)=0
 . . S IEN=+$O(^RORDATA(798,"KEY",PTIEN,REGIEN,""))
 . . Q:IEN'>0
 . . ;With patch 10, status is irrelevant
 . . ;I '$$ACTIVE^RORDD(IEN,,.STATUS)  Q:STATUS'=5
 . . ;--- Skip a record tagged as "DON'T SEND" or if test patient
 . . I (($P($G(^RORDATA(798,IEN,2)),U,4))!($$TESTPAT^RORUTL01(PTIEN))) Q
 . . ;--- Consider the record
 . . S RGIENLST(REGIEN)=IEN,CNT=CNT+1
 Q $S(PTIEN>0:PTIEN,1:0)
 ;
 ;***** SCANS THE REGISTRY AND EXTRACTS THE DATA
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as subscripts and registry IENs as values
 ;
 ; Return Values:
 ;       <0  Error Code
 ;      >=0  Statistics
 ;             ^1: Total number of processed patients
 ;             ^2: Number of patients processed with errors
 ;
 ; In normal mode this function processes all patients and returns
 ; total number of patients and number of patients processed with
 ; errors.
 ;
 ; However, in debug mode 3 the function stops after the first
 ; patient processed with error and returns an error code.
 ;
PROCESS(REGLST) ;
 N CNT,DTNEXT,ECNT,PTIEN,RC,REGIEN,REGNAME,RGIENLST,RORBUF,RORMSG,TH,TMP
 ;--- Prepare the list of registry IENs
 S REGNAME="",REGIEN=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:REGIEN<0
 . S REGIEN=+REGLST(REGNAME)
 . S:REGIEN'>0 REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . S:REGIEN>0 RGIENLST(REGIEN)=""
 Q:REGIEN<0 REGIEN
 ;--- Initialize environment variables
 S RC=$$INIT^RORHL7()  Q:RC<0 RC
 ;
 ;--- Generate the registry state message
 S RC=$$CREATE^RORHL7()  Q:RC<0 RC
 S REGIEN=0
 F  S REGIEN=$O(RGIENLST(REGIEN))  Q:REGIEN'>0  D  Q:RC<0
 . S RC=$$REGSTATE^ROREXT03(REGIEN)
 Q:RC<0 RC
 ;
 ;--- Loop through the patients of the registries
 S (CNT,ECNT,PTIEN,RC)=0
 F  S PTIEN=$$NEXTPAT(PTIEN,.RGIENLST)  Q:PTIEN'>0  D  Q:RC
 . ;--- For a queued task only
 . I $D(ZTQUEUED)  S RC=0  D  Q:RC<0
 . . ;--- Check if task stop has been requested
 . . I $$S^%ZTLOAD  S RC=$$ERROR^RORERR(-42)  Q
 . . ;--- Check if the task should be suspended
 . . Q:'$G(ROREXT("SUSPEND"))
 . . Q:$$NOW^XLFDT<$G(DTNEXT)
 . . Q:'$$SUSPEND(.DTNEXT)
 . . ;--- Suspend the task during the peak hours
 . . F  D  Q:'TH!(RC<0)
 . . . S TH=$$FMDIFF^XLFDT(DTNEXT,$$NOW^XLFDT,2)
 . . . I TH<60  S TH=0  Q       ; Do not HANG for less than a
 . . . H $S(TH>3600:3600,1:TH)  ; minute and more than an hour
 . . . ;--- Check if task stop has been requested
 . . . S:$$S^%ZTLOAD RC=$$ERROR^RORERR(-42)
 . ;--- Process the patient's records
 . S CNT=CNT+1
 . I $G(RORPARM("DEBUG"))>1  W:$E($G(IOST),1,2)="C-" *13,CNT
 . S RC=$$PROCPAT(PTIEN,.RGIENLST)
 . ;--- Process the error (if any)
 . I RC<0  D  S:$G(RORPARM("DEBUG"))<3 RC=0  Q
 . . S ECNT=ECNT+1,RC=$$ERROR^RORERR(-15,,,$G(PTIEN))
 . ;--- Send the batch HL7 message when the maximum size is reached
 . S:$$ISMAXSZ^RORHL7() RC=$$SEND^ROREXT03(.RGIENLST)
 Q:RC<0 RC
 ;
 ;--- Send the remaining data (flush the buffer)
 S RC=$$SEND^ROREXT03(.RGIENLST)  Q:RC<0 RC
 ;
 ;--- Return number of processed patients and number of errors
 Q CNT_U_ECNT
 ;
 ;***** PROCESS THE PATIENT'S REGISTRY RECORDS
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
 ; .RGIENLST     Reference to a local array containing registry
 ;               IENs as subscripts and IENs of the corresponding
 ;               patient's registry records as values.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
PROCPAT(PTIEN,RGIENLST) ;
 N RORERRDL      ; Default error location
 ;
 N BATCHID,CNT,DXDTS,IEN,MSHPTR,RC,REGIEN,RORMSH,TMP
 D CLEAR^RORERR("PROCPAT^ROREXT01")
 ;
 ;--- Compile the data extraction time frames
 S (CNT,RC,REGIEN)=0
 F  S REGIEN=$O(RGIENLST(REGIEN))  Q:REGIEN'>0  D  Q:RC<0
 . S IEN=+RGIENLST(REGIEN)  Q:IEN'>0
 . S RC=$$DXPERIOD^ROREXTUT(.DXDTS,IEN,PTIEN)
 . S:'RC CNT=CNT+1
 . S:RC>0 RGIENLST(REGIEN)=0
 Q:RC<0 RC
 ;--- If the patient should be skipped in all registries
 ;    that are being processed, then do not perform the data
 ;--- extraction for this patient at all.
 I 'CNT  D:$G(RORPARM("DEBUG"))  Q 0
 . D LOG^RORLOG(4,"There is no data to extract.",PTIEN)
 ;
 ;--- Create an HL7 message for the patient
 S MSHPTR=$$CREATE^RORHL7(.RORMSH)  Q:MSHPTR<0 MSHPTR
 S RC=$$MESSAGE^ROREXT02(PTIEN,.RGIENLST,.DXDTS,$G(ROREXT("HDTIEN")))
 ;
 ;--- Delete the unfinished message from the ^TMP("HLS",$J)
 ;    if there is no data to send (RC>0) or there was an error
 ;    during the data extraction (RC<0). Return the error code
 ;--- in the latter case.
 I RC!($O(^TMP("HLS",$J,""),-1)=MSHPTR)  D  Q:RC<0 RC
 . D ROLLBACK^RORHL7(MSHPTR)  S:'RC RC=1
 ;
 ;--- Do not change state of the record(s) during the
 ;--- historical data extraction
 I $G(ROREXT("HDTIEN"))'>0  D  Q:RC<0 RC
 . S TMP=$S('RC:$P(RORMSH,$E(RORMSH,4),10),1:"")
 . S RC=$$UPDRECS^ROREXT03(PTIEN,.RGIENLST,TMP,$P(DXDTS,U,2))
 ;---
 Q 0
 ;
 ;***** CHECKS IF THE TASK SHOULD BE SUSPENDED
 ;
 ; .DTNEXT       Date/Time of the next event (suspend/resume)
 ;               is returned via this parameter
 ;
 ; Return Values:
 ;        0  Continue/Resume
 ;        1  Suspend
 ;
SUSPEND(DTNEXT) ;
 N DATE,NOW,SUSPEND,TIME,TS,TR
 S TS=$P(ROREXT("SUSPEND"),U,1)
 S TR=$P(ROREXT("SUSPEND"),U,2)
 S NOW=$$NOW^XLFDT,DATE=NOW\1
 ;--- A work day
 I $$WDCHK^RORUTL01(DATE)  D  Q SUSPEND
 . S TIME=NOW-DATE,SUSPEND=0
 . I TIME<TS   S DTNEXT=DATE+TS  Q
 . I TIME'<TR  S DTNEXT=$$WDNEXT^RORUTL01(DATE)+TS  Q
 . S DTNEXT=DATE+TR,SUSPEND=1
 ;--- Saturday, Sunday or Holiday
 S DTNEXT=$$WDNEXT^RORUTL01(DATE)+TS
 Q 0
