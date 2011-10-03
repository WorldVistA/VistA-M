RORTSK03 ;HCIOFO/SG - TASK MANAGER OVERFLOW CODE ; 8/30/05 8:34am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** PREPARE THE TASK PARAMETERS
 ;
 ; .PARAMS       Reference to a local array that contains
 ;               the task parameters
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PARAMS(PARAMS) ;
 N I,NAME,NODE,SUBS,TMP
 S I=""
 F  S I=$O(PARAMS(I))  Q:I=""  D
 . S NAME=$TR($P(PARAMS(I),"=")," ")  Q:NAME=""
 . S TMP=$P(NAME,"(")  Q:TMP=""
 . S NODE="RORTSK(""PARAMS"","""_TMP_""""
 . S TMP=$P(NAME,"(",2,999)
 . S NODE=$S(TMP'="":NODE_","_TMP,1:NODE_")")
 . S @NODE=$$TRIM^XLFSTR($P(PARAMS(I),"=",2,999))
 Q 0
 ;
 ;***** FORMATS THE TASK INFORMATION FOR $$TASKINFO^RORTSK02
 ;
 ; OFFSET        Offset for the subscripts
 ; .INFO         Reference to a local variable (output):
 ; IENS          The second subscript in the RORBUF array
 ; .RORBUF       Referrence to a local variable containing output
 ;               of the GETS^DIQ procedure
 ; FLAGS         Characters controlling behavior of the function
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
FRMTI(OFFSET,INFO,IENS,RORBUF,FLAGS) ;
 N I,TMP,ZTCPU,ZTSK
 ;--- Task Type
 I $G(RORBUF(798.8,IENS,.02,"I"))'=""  D
 . S I=OFFSET+2,INFO(I)=RORBUF(798.8,IENS,.02,"I")
 . S:FLAGS["E" $P(INFO(I),U,2)=$G(RORBUF(798.8,IENS,.02,"E"))
 ;--- Registry
 I $G(RORBUF(798.8,IENS,.03,"I"))'=""  D
 . S I=OFFSET+3,INFO(I)=RORBUF(798.8,IENS,.03,"I")
 . S:FLAGS["E" $P(INFO(I),U,2)=$G(RORBUF(798.8,IENS,.03,"E"))
 ;--- Report
 S TMP=+$G(RORBUF(798.8,IENS,.04,"I"))
 I TMP>0  S TMP=$$RPCODE^RORUTL08(TMP)  I TMP'=""  D
 . S I=OFFSET+4,INFO(I)=TMP
 . S:FLAGS["E" $P(INFO(I),U,2)=$G(RORBUF(798.8,IENS,.04,"E"))
 ;--- Description
 S INFO(OFFSET+5)=$G(RORBUF(798.8,IENS,.05,"I"))
 ;--- Creation Time
 I $G(RORBUF(798.8,IENS,.07,"I"))'=""  D
 . S INFO(OFFSET+7)=RORBUF(798.8,IENS,.07,"I")
 ;--- User
 I $G(RORBUF(798.8,IENS,.08,"I"))'=""  D
 . S I=OFFSET+8,INFO(I)=RORBUF(798.8,IENS,.08,"I")
 . S:FLAGS["E" $P(INFO(I),U,2)=$G(RORBUF(798.8,IENS,.08,"E"))
 ;--- Completion Time
 I $G(RORBUF(798.8,IENS,2.02,"I"))'=""  D
 . S INFO(OFFSET+9)=RORBUF(798.8,IENS,2.02,"I")
 ;--- Progress Percentage
 S TMP=$G(RORBUF(798.8,IENS,4,"I"))
 S INFO(OFFSET+10)=$S(TMP'="":$J(TMP,0,2),1:"")
 ;--- Scheduled to Run at
 S ZTSK=TASK  D ISQED^%ZTLOAD
 I $G(ZTSK(0)),$D(ZTSK("D"))#10  D
 . S INFO(OFFSET+11)=$$HTFM^XLFDT(ZTSK("D"))
 ;--- Task Log
 S INFO(OFFSET+12)=$G(RORBUF(798.8,IENS,2.03,"I"))
 ;--- Job Number
 S INFO(OFFSET+13)=$G(RORBUF(798.8,IENS,2.04,"I"))
 ;--- User Comment
 S INFO(OFFSET+14)=$G(RORBUF(798.8,IENS,1.01,"I"))
 Q 0
