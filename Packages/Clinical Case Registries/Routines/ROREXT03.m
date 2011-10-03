ROREXT03 ;HCIOFO/SG - REGISTRY DATA EXTRACTION (OVERFLOW) ; 11/29/05 4:13pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;*****REGISTRY STATE CSR SEGMENT
CSR(REGIEN) ;
 N CS,RC,RORINFO,RORSEG,RPTSTATS,TMP
 D ECH^RORHL7(.CS)
 ;
 ;--- Get the registry information
 S RC=$$REGINFO^RORUTL17(REGIEN,"RORINFO")  Q:RC<0 RC
 S TMP=$$STATS^RORTSK12(REGIEN,.RPTSTATS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="CSR"
 ;
 ;--- CSR-1 - Name of the registry and version of the CCR
 S TMP=+$P(ROREXT("VERSION"),U)              ; Version
 S:$P(TMP,".",2)="" $P(TMP,".",2)="0"
 S $P(TMP,".",3)=+$P(ROREXT("VERSION"),U,2)  ; Patch Number
 S $P(TMP,".",4)=+$$BUILD^ROR                ; Build Number
 S RORSEG(1)=$$ESCAPE^RORHL7($P($$REGNAME^RORUTL01(REGIEN),U))_CS_TMP
 ;
 ;--- CSR-3 - Institution
 S RORSEG(3)=$$SITE^RORUTL03(CS)
 ;
 ;--- CSR-4 - Patient ID
 S TMP="0"_CS_CS_CS_CS_"U"
 S $P(TMP,CS,6)=+$G(RORINFO("NPP"))  ; Number of pending patients
 S $P(TMP,CS,7)=+$P(RPTSTATS,U)      ; Number of reports
 S RORSEG(4)=TMP
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q 0
 ;
 ;***** REGISTRY STATE PID SEGMENT
PID() ;
 N CS,RORSEG
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="PID"
 ;
 ;--- PID-3 DFN and Station Number
 S RORSEG(3)="0"_CS_CS_CS_CS_"U"
 ;
 ;--- PID-5 Patient Name
 S RORSEG(5)="PSEUDO"_CS_"PATIENT"
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q 0
 ;
 ;***** GENERATES THE REGISTRY STATE HL7 MESSAGE
 ;
 ; REGIEN        Registry IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of ignored errors
 ;
REGSTATE(REGIEN) ;
 N RC
 ;--- Output pseudo-patient's segments
 S RC=$$PID()            Q:RC<0 RC
 S RC=$$CSR(REGIEN)      Q:RC<0 RC
 ;---
 Q 0
 ;
 ;***** SENDS THE CURRENT HL7 BATCH
 ;
 ; .RGIENLST     Reference to a local array containing registry
 ;               IENs as subscripts and IENs of the corresponding
 ;               patient's registry records as values.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
SEND(RGIENLST) ;
 N IENS,MID,RC,REGIEN,RORFDA,RORMSG,TMP
 W:$G(RORPARM("DEBUG"))>1 !,"HL7 Batch ID: ",$G(ROREXT("HL7MID"))
 S RC=$$SEND^RORHL7(.MID)  Q:RC<0 RC
 I 'RC,$G(MID)'=""  D
 . S ROREXT("NBM")=$G(ROREXT("NBM"))+1
 . S TMP="HL7 batch message "_MID_" has been generated"
 . D LOG^RORLOG(2,TMP)
 . ;--- Add message reference to the LAST BATCH CONTROL ID
 . ;--- multiples of the registries that are being processed
 . S (RC,REGIEN)=0
 . F  S REGIEN=$O(RGIENLST(REGIEN))  Q:REGIEN'>0  D  Q:RC<0
 . . K RORFDA,RORMSG  S IENS="+1,"_REGIEN_","
 . . ;--- LAST BATCH CONTROL ID
 . . S RORFDA(798.122,IENS,.01)=MID
 . . ;--- INTERNAL BATCH ID
 . . S RORFDA(798.122,IENS,.02)=$G(ROREXT("HL7MID"))
 . . ;--- Batch Date/Time
 . . S TMP=+$G(ROREXT("HL7DT"))
 . . S RORFDA(798.122,IENS,.03)=$S(TMP>0:TMP,1:$$NOW^XLFDT)
 . . ;--- Create the record
 . . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798.122,IENS)
 Q 0
 ;
 ;***** UPDATES THE REGISTRY RECORDS AFTER THE DATA EXTRACTION
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
 ; .RGIENLST     Reference to a local array containing registry
 ;               IENs as subscripts and IENs of the corresponding
 ;               patient's registry records as values.
 ;
 ; BATCHID
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
UPDRECS(PTIEN,RGIENLST,BATCHID,ENDT) ;
 N FS,IEN,IENS,RC,REGIEN,RORFDA,RORMSG
 S (RC,REGIEN)=0
 F  S REGIEN=$O(RGIENLST(REGIEN))  Q:REGIEN'>0  D  Q:RC<0
 . K RORFDA,RORMSG
 . S IEN=+RGIENLST(REGIEN)  Q:IEN'>0
 . S IENS=IEN_","
 . ;--- Store the Message ID in the registry
 . S:BATCHID'="" RORFDA(798,IENS,10)=BATCHID
 . ;--- Otherwise, populate the MESSAGE ID field with a fake ID.
 . ;    This will force the message status checkup process to
 . ;    update the DATA ACKNOWLEDGED UNTIL field so that the next
 . ;    data extraction process will not browse through the data
 . ;--- already processed by the previous one.
 . S:BATCHID="" RORFDA(798,IENS,10)=ROREXT("HL7MID")_"-0"
 . ;--- Always update the DATA EXTRACTED UNTIL field
 . S RORFDA(798,IENS,9.2)=ENDT
 . ;--- Update the registry record
 . D FILE^DIE(,"RORFDA","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,PTIEN,798,IENS)
 ;---
 Q $S(RC<0:RC,1:0)
