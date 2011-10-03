RORHDT04 ;HCIOFO/SG - HISTORICAL DATA EXTRACTION PROCESS ;1/22/06 8:18pm
 ;;1.5;CLINICAL CASE REGISTRIES;**10**;Feb 17, 2006;Build 32
 ;
 ; This routine uses the following IAs:
 ;
 ; #2320  CLOSE^ZISH (supported)
 ; #2053  FILE^DIE (supported)
 ; #2055  $$ROOT^DILFD (supported)
 Q
 ;
 ;***** DATA EXTRACTION PROCESS
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as subscripts and registry IENs as values
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ;
 ; FAM           File Access Mode
 ;
 ; Return Values:
 ;       <0  Error code
 ;      >=0  Statistics
 ;             ^1: Total number of processed patients
 ;             ^2: Number of patients processed with errors
 ;
EXTRACT(REGLST,HDEIEN,TASKIEN,FAM) ;
 N ROREXT        ; Data extraction descriptor
 N RORHL         ; HL7 variables
 N RORLRC        ; List of codes of Lab results to be extracted
 ;
 N CNT           ; Number of processed registry records
 N ECNT          ; Number of records processed with errors
 N FILE          ; Name of the output file
 N OUTDIR        ; Name of the output directory
 ;
 N BDT,EDT,NEXT,POP,RC,REGIEN,REGNAME,RGIENLST,RRBIEN,RREIEN,STOP,TMP
 K ^TMP("RORHDT",$J,"PR"),^TMP("HLS",$J),^TMP("RORPTF",$J)
 S (CNT,ECNT,STOP)=0,RORHDT("BHS")=1
 ;--- Prepare the list of registry IENs
 S REGNAME="",REGIEN=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:REGIEN<0
 . S REGIEN=+REGLST(REGNAME)
 . S:REGIEN'>0 REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . S:REGIEN>0 RGIENLST(REGIEN)=""
 Q:REGIEN<0 REGIEN
 ;
 ;=== Load parameters
 S RC=$$HDEPARM^RORHDT05(HDEIEN,.BDT,.EDT,.OUTDIR)
 Q:RC<0 RC
 S RC=$$TASKPARM^RORHDT05(HDEIEN,TASKIEN,.RRBIEN,.RREIEN,.FILE)
 Q:RC<0 RC
 ;
 ;=== Prepare data extraction rules
 S RC=$$PREPARE^ROREXPR(.REGLST,BDT,EDT)
 Q:RC<0 $$ERROR^RORERR(-22)
 ;--- Load and process historical data extraction parameters
 S RC=$$PREPARE^RORHDT06(HDEIEN)  Q:RC<0 RC
 K ROREXT("MAXHL7SIZE")  ; Do not limit the size
 ;
 ;=== Initialize the HL7 environment
 S RC=$$INIT^RORHL7()  Q:RC<0 RC
 ;
 ;=== Delete the old output host file(s)
 S TMP=$$DELFILES^RORHDT05(OUTDIR,FILE)
 ;
 D
 . N COMMIT,IENS,NODE,NRTC,PTIEN
 . S NRTC=100 ; Number of records to commit
 . ;
 . ;=== Try to re-extract the erroneous records
 . S NODE=$$ROOT^DILFD(799.641,","_(+TASKIEN)_","_(+HDEIEN)_",",1)
 . S NODE=$NA(@NODE@("B"))
 . S PTIEN=0,RC=0
 . F  D  Q:RC!STOP!(PTIEN'>0)
 . . K ^TMP("HLS",$J)
 . . F  S PTIEN=$O(@NODE@(PTIEN))  Q:PTIEN'>0  D  Q:RC!'((CNT-ECNT)#NRTC)
 . . . S RC=$$LOOP^RORTSK01()
 . . . I RC<0  S:RC=-42 STOP=1  Q
 . . . S RC=$$PROCREC(PTIEN,.RGIENLST),CNT=CNT+1
 . . . S ^TMP("RORHDT",$J,"PR",PTIEN)=RC
 . . . I RC'<0  S RC=0  Q
 . . . ;--- Process the error
 . . . S RC=$$ERROR^RORERR(-15,,,PTIEN),ECNT=ECNT+1
 . . . S:$G(RORPARM("DEBUG"))<3 RC=0
 . . I RC<0  Q:'STOP
 . . ;--- Commit the data
 . . S TMP=$$COMMIT^RORHDT05(OUTDIR,FILE)
 . . S:TMP<0 RC=TMP
 . Q:STOP!(RC=-34)
 . ;
 . ;=== Extract the remaining registry data
 . S PTIEN=$S(RRBIEN>0:+$O(^RORDATA(798,"KEY",RRBIEN),-1),1:0)
 . S RC=0
 . F  D  Q:RC!STOP!(PTIEN'>0)
 . . K ^TMP("HLS",$J)  S COMMIT=0
 . . F  S PTIEN=$$NEXTPAT(PTIEN,.RGIENLST)  Q:PTIEN'>0  D  Q:RC!COMMIT
 . . . S RC=$$LOOP^RORTSK01()
 . . . I RC<0  S:RC=-42 STOP=1  Q
 . . . I RREIEN>0,PTIEN'<RREIEN  S PTIEN="",RC=1  Q
 . . . Q:$D(^TMP("RORHDT",$J,"PR",PTIEN))
 . . . S RC=$$PROCREC(PTIEN,.RGIENLST),CNT=CNT+1
 . . . I RC'<0  S COMMIT='((CNT-ECNT)#NRTC),RC=0  Q
 . . . ;--- Process the error
 . . . S RC=$$ERROR^RORERR(-15,,,PTIEN),ECNT=ECNT+1
 . . . S:$G(RORPARM("DEBUG"))<3 RC=0
 . . . S TMP=$$ADDERR^RORHDT05(HDEIEN,TASKIEN,PTIEN)
 . . . S:TMP<0 RC=TMP
 . . I RC<0  Q:'STOP
 . . ;--- Commit the data
 . . S NEXT=$S(COMMIT:$$NEXTPAT(PTIEN,.RGIENLST),1:PTIEN)
 . . S TMP=$$COMMIT^RORHDT05(OUTDIR,FILE)
 . . S:TMP<0 RC=TMP
 ;
 ;--- The $$COMMIT^RORHDT05 returns -34 if it was not able to create
 ;--- the output file (wrong directory name, protection error, etc.).
 D:RC'=-34
 . N NODE,RORFDA,RORMSG
 . ;
 . ;=== Write the batch trailer segment and close the file if
 . ;=== the batch is not empty. Otherwise, record a warning.
 . I '$G(RORHDT("BHS"))  D
 . . S TMP=$S(ECNT!(RC<0):"Completed with errors",STOP:"Stopped",1:"")
 . . U IO  W $$BTS^RORHL7A($$MSGCNT^RORHL7,TMP),$C(13)
 . . D CLOSE^%ZISH("HL7FILE")
 . E  D ERROR^RORERR(-89)
 . ;
 . ;=== Update the NEXT RECORD IEN field in the task record
 . I $D(NEXT)  D:NEXT'>0
 . . ;--- If the task completed successfully, the NEXT RECORD IEN
 . . ;    field is set to an empty string. If the task is restarted
 . . ;--- afterwards, it will re-extract all data again.
 . . I 'ECNT  S NEXT=""  Q
 . . ;--- If completed with errors, use IEN of the last record
 . . ;--- processed by the task incremented by 1.
 . . I RREIEN>0  S NEXT=RREIEN+1  Q
 . . ;--- Or the IEN of the last patient record incremented by 1
 . . ;--- (in case of the last/single task).
 . . S NEXT=$O(^RORDATA(798,"KEY",""),-1)+1
 . . ;--- When the task is restarted, it will try to re-extract only
 . . ;    erroneous records and will not process already extracted
 . . ;    data (the PTIEN will not be less than the RREIEN or the
 . . ;--- $ORDER function will not return a value greater than zero).
 . E  Q:(RC<0)!ECNT!STOP  S NEXT=""
 . ;
 . ;=== Update the task record
 . S IENS=(+TASKIEN)_","_(+HDEIEN)_","
 . S RORFDA(799.64,IENS,.04)=NEXT
 . D FILE^DIE("K","RORFDA","RORMSG")
 . S TMP=$$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 ;
 ;=== Cleanup
 K ^TMP("RORPTF",$J)
 S:RC'<0 RC=$$CLRERRS^RORHDT05(HDEIEN,TASKIEN)
 Q $S(RC<0:RC,1:CNT_U_ECNT)
 ;
 ;***** RETURNS THE NEXT PATIENT FOR DATA EXTRACTION
 ;
 ; PTIEN         Patient IEN (DFN)
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
 N CNT,IEN,REGIEN
 S CNT=0
 F  S PTIEN=$O(^RORDATA(798,"KEY",PTIEN))  Q:PTIEN'>0  D  Q:CNT
 . S REGIEN=0
 . F  S REGIEN=$O(RGIENLST(REGIEN))  Q:REGIEN'>0  D
 . . S RGIENLST(REGIEN)=0
 . . S IEN=+$O(^RORDATA(798,"KEY",PTIEN,REGIEN,""))
 . . Q:IEN'>0
 . . ;************************************************************
 . . ; Patch 10: also include pending patients
 . . ;--- Skip inactive records (pending and marked for deletion)
 . . ;Q:'$$ACTIVE^RORDD(IEN)
 . . ;************************************************************
 . . ;--- skip patients marked for deletion
 . . I $$DEL^RORDD(IEN) Q
 . . ;--- Skip records tagged as "DON'T SEND" and skip test patients
 . . I (($P($G(^RORDATA(798,IEN,2)),U,4))!($$TESTPAT^RORUTL01(PTIEN))) Q
 . . ;--- Consider the record
 . . S RGIENLST(REGIEN)=IEN,CNT=CNT+1
 Q $S(PTIEN>0:PTIEN,1:0)
 ;
 ;***** PROCESSES A RECORD IN THE REGISTRY
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
 ; .RGIENLST     Reference to a local array containing registry
 ;               IENs as subscripts and IENs of the corresponding
 ;               patient's registry records as values.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;        1  Nothing has been extracted
 ;
PROCREC(PTIEN,RGIENLST) ;
 N RORERRDL      ; Default error location
 ;
 N BATCHID,CNT,DXDTS,IEN,MSHPTR,RC,REGIEN,RORMSH,TMP
 D CLEAR^RORERR("PROCREC^RORHDT04")
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
 ;---
 Q RC
