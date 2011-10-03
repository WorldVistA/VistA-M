RORHDT05 ;HCIOFO/SG - HISTORICAL DATA EXTRACTION FUNCTIONS ; 1/22/06 12:01pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** ADDS A RECORD TO THE 'ERROR' MULTIPLE OF THE TASK RECORD
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ; PTIEN         Patient IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ADDERR(HDEIEN,TASKIEN,PTIEN) ;
 N IENS,RC,RORFDA,RORIEN,RORMSG
 S IENS="+1,"_(+TASKIEN)_","_(+HDEIEN)_",",RORIEN(1)=+PTIEN
 S RORFDA(799.641,IENS,.01)=+PTIEN
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 Q $$DBS^RORERR("RORMSG",-9,,,799.641,IENS)
 ;
 ;***** DELETES RECORDS FROM THE 'ERROR' MULTIPLE OF THE TASK RECORD
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ;
 ; This functions deletes all erroneous records from the ERROR
 ; multiple of the task record that have been re-extracted without
 ; errors. So, there is no reason to keep them anymore.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
CLRERRS(HDEIEN,TASKIEN) ;
 N I,IEN,RC,RORFDA,RORMSG,SFI
 S SFI=","_(+TASKIEN)_","_(+HDEIEN)_",",RC=0
 S IEN=""
 F  D  Q:(RC<0)!(IEN="")
 . F I=1:1:10  S IEN=$O(^TMP("RORHDT",$J,"PR",IEN))  Q:IEN=""  D
 . . S:^TMP("RORHDT",$J,"PR",IEN)'<0 RORFDA(799.641,IEN_SFI,.01)="@"
 . Q:$D(RORFDA)<10
 . D FILE^DIE(,"RORFDA","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,799.641)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** COMMITS HL7 DATA TO THE OUTPUT FILE
 ;
 ; OUTDIR        Output directory
 ; FILE          Output file name
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
COMMIT(OUTDIR,FILE) ;
 N CR,I,J,POP,RC
 Q:$D(^TMP("HLS",$J))<10 0
 S CR=$C(13),RC=0
 ;--- Create the file and write the BHS segment (if necessary)
 I $G(RORHDT("BHS"))  D  Q:RC<0 RC  K RORHDT("BHS")
 . D OPEN^%ZISH("HL7FILE",OUTDIR,FILE,"WB")
 . I $G(POP)  S RC=$$ERROR^RORERR(-34,,OUTDIR_FILE)  Q
 . S I=$G(ROREXT("HL7DT"))  U IO
 . W $$BHS^RORHL7A($G(ROREXT("HL7MID")),I,"HISTORICAL DATA"),$C(13)
 ;--- Write the segments
 S I=0
 F  S I=$O(^TMP("HLS",$J,I))  Q:I=""  D
 . W ^TMP("HLS",$J,I)  S J=""
 . F  S J=$O(^TMP("HLS",$J,I,J))  Q:J=""  W ^(J)
 . W CR
 Q 0
 ;
 ;***** DELETES THE OLD OUTPUT HOST FILE(S)
 ;
 ; OUTDIR        Output directory
 ; FILE          Output file name
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
DELFILES(OUTDIR,FILE) ;
 N RC,RORDST,RORSRC  Q:FILE="" 0
 S RORSRC(FILE_"*")=""
 Q:'$$LIST^%ZISH(OUTDIR,"RORSRC","RORDST") 0
 I '$$DEL^%ZISH(OUTDIR,"RORDST")  D  Q RC
 . S RC=$$ERROR^RORERR(-56,,,,0,"$$DEL^%ZISH")
 Q 0
 ;
 ;***** LOADS DATA EXTRACTION PARAMETERS
 ;
 ; HDEIEN        Data Extract IEN
 ;
 ; [.BDT]        Start date of the data extract
 ; [.EDT]        End date of the data extract
 ; [.OUTDIR]     Output directory
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
HDEPARM(HDEIEN,BDT,EDT,OUTDIR) ;
 N IENS,RC,RORBUF,RORMSG,TMP
 S IENS=(+HDEIEN)_","
 ;--- Get data from the registry descriptor
 D GETS^DIQ(799.6,IENS,".03;.04;2","I","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.1,IENS)
 S BDT=$G(RORBUF(799.6,IENS,.03,"I"))
 S EDT=$G(RORBUF(799.6,IENS,.04,"I"))
 S OUTDIR=$G(RORBUF(799.6,IENS,2,"I"))
 I (BDT'>0)!(EDT'>0)!(BDT>EDT)  D  Q RC
 . S RC=$$ERROR^RORERR(-32,,,,BDT,EDT)
 Q 0
 ;
 ;***** LOADS TASK PARAMETERS
 ;
 ; HDEIEN        Data Extract IEN
 ; TASKIEN       Task IEN
 ;
 ; [.RBIEN]      Start record IEN
 ; [.REIEN]      End record IEN
 ; [.FILE]       File name
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TASKPARM(HDEIEN,TASKIEN,RBIEN,REIEN,FILE) ;
 N IENS,RC,ROOT,RORBUF,RORMSG,TMP
 ;--- Load data from the task record
 S IENS=(+TASKIEN)_","_(+HDEIEN)_","
 D GETS^DIQ(799.64,IENS,".01;.04;.05","I","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.64,IENS)
 S RBIEN=$G(RORBUF(799.64,IENS,.01,"I"))
 S FILE=$G(RORBUF(799.64,IENS,.05,"I"))
 ;--- Get the end record IEN from the next task record
 S ROOT=$$ROOT^DILFD(799.64,","_(+HDEIEN)_",",1)
 S REIEN=$O(@ROOT@("B",RBIEN))
 ;--- If an IEN of the record is available from the previous run,
 ;    use it as start record IEN
 S TMP=$G(RORBUF(799.64,IENS,.04,"I"))
 S:TMP>0 RBIEN=TMP
 Q 0
