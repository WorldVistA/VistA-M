RORUTL17 ;HCIOFO/SG - REGISTRY INFORMATION UTILITIES ; 8/25/05 1:44pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** ADDS THE PENDING PATIENT TO THE LIST
 ;
 ; REGIEN        Registry IEN
 ; IEN           IEN of the registry record
 ; PATIEN        Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ADDPP(REGIEN,IEN,PATIEN) ;
 N BUF,I,NODE,IEN1,TMP,VA,VADM
 D VADEM^RORUTL05(PATIEN)
 S @ROR8DST@("PPL",PATIEN)=IEN_U_$$XOR^RORUTL03($P($G(VADM(2)),U))
 ;--- Dates of selection rules
 S NODE=$$ROOT^DILFD(798.01,","_IEN_",",1),BUF=""
 S IEN1=0
 F  S IEN1=$O(@NODE@(IEN1))  Q:IEN1'>0  D
 . S TMP=$G(@NODE@(IEN1,0)),I=+$G(RORSRL(+TMP))
 . S:I>0 $P(BUF,U,I)=$P(TMP,U,2)
 S @ROR8DST@("PPL",PATIEN,1)=BUF
 Q 0
 ;
 ;***** FORMATS THE DATE
DATE(DATE) ;
 Q $S(DATE>1:$$FMTE^XLFDT(DATE\1,"5Z"),1:"")
 ;
 ;***** LOADS THE LIST OF SELECTION RULES
 ;
 ; REGIEN        Registry IEN
 ; .SRLST        Reference to a local variable for the
 ;               list of selection rules
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LOADSRL(REGIEN,SRLST) ;
 N IEN,NAME,NODE
 S NODE=$$ROOT^DILFD(798.2,,1)
 S IEN=0
 F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D
 . S NAME=$P($G(@NODE@(IEN,0)),U)  Q:NAME=""
 . I NAME?1"VA"1.E1"LAB".E      S SRLST(IEN)="1^LAB"      Q
 . I NAME?1"VA"1.E1"PROBLEM".E  S SRLST(IEN)="2^PROBLEM"  Q
 . I NAME?1"VA"1.E1"PTF".E      S SRLST(IEN)="3^PTF"      Q
 . I NAME?1"VA"1.E1"VPOV".E     S SRLST(IEN)="4^VISIT"    Q
 . I NAME?1"VA"1.E1"VISIT".E    S SRLST(IEN)="4^VISIT"    Q
 Q 0
 ;
 ;***** COUNTS PATIENTS WITH ERRORS
 ;
 ; REGIEN        Registry IEN
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of patients with errors
 ;
PTERR(REGIEN,SPI) ;
 N CNT,IEN,NODE,RC,TMP
 W:SPI !,"Counting patients with errors",!
 S NODE=$$ROOT^DILFD(798.3,,1),(CNT,RC)=0
 S IEN=0
 F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D
 . W:SPI "."
 . S:$D(@NODE@(IEN,1,"B",REGIEN)) CNT=CNT+1
 Q $S(RC<0:RC,1:CNT)
 ;
 ;***** GATHERS THE INFORMATION ABOUT THE REGISTRY
 ;
 ; REGIEN        Registry IEN
 ;
 ; ROR8DST       Closed root of the destination array
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 E  Count patients with errors in the
 ;                    ROR PATIENT EVENTS file
 ;                 P  Include list of pending patients
 ;                 S  Show the progress indicator
 ;
 ; @ROR8DST@(
 ;   "DTACKMAX")         The latest and the earliest dates by which
 ;   "DTACKMIN")         patient data transmissions are acknowledged
 ;
 ;   "NPA")              Number of active patients
 ;   "NPE")              Number of patients with errors in the
 ;                       ROR PATIENT EVENTS file
 ;   "NPP")              Number of pending patients
 ;   "NPT")              Total number of patients in the registry
 ;                       (including pending)
 ;
 ;   "PPL",
 ;     0,1)              Map of the corresponding data subnode
 ;                       (field names separated by ^)
 ;     DFN)              Pending patient
 ;                         ^01: IEN of the registry record
 ;                         ^02: Coded SSN
 ;     DFN,1)
 ;                       Dates of the selection rules
 ;                         ^01: LAB
 ;                         ^02: PROBLEM
 ;                         ^03: PTF
 ;                         ^04: VISIT
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of ignored errors
 ;
REGINFO(REGIEN,ROR8DST,FLAGS) ;
 N RORECNT       ; Number of errors
 N RORSRL        ; List of selection rules
 ;
 N COUNTS,CPPL,DTACKMIN,DTACKMAX,IEN,IENS,NODE,PTSTAT,RC,RORBUF,RORMSG,SPI,TMP
 S FLAGS=$G(FLAGS),SPI=(FLAGS["S"),CPPL=(FLAGS["P")
 S DTACKMIN=999999999,DTACKMAX=0
 K @ROR8DST  S (RC,RORECNT)=0
 ;
 ;--- Load the list of selection rules
 I CPPL  S RC=$$LOADSRL(REGIEN,.RORSRL)  Q:RC<0 RC
 ;
 ;--- Examine registry records
 W:SPI !,"Examining registry records",!
 S NODE=$$ROOT^DILFD(798,,1)
 S IEN=0
 F  S IEN=$O(@NODE@("AC",REGIEN,IEN))  Q:IEN'>0  D
 . W:SPI "."
 . S COUNTS("NPT")=$G(COUNTS("NPT"))+1  ; Total number of patients
 . ;--- Load the data
 . S IENS=IEN_","  K RORBUF
 . D GETS^DIQ(798,IENS,".01;3;9.1","I","RORBUF","RORMSG")
 . I $G(DIERR)  D  S RORECNT=RORECNT+1  Q
 . . D DBS^RORERR("RORMSG",-9,,,798,IENS)
 . S PTSTAT=+$G(RORBUF(798,IENS,3,"I"))
 . ;--- Number of active patients
 . D:$$ACTIVE^RORDD(IEN)
 . . S COUNTS("NPA")=$G(COUNTS("NPA"))+1
 . . S TMP=+$G(RORBUF(798,IENS,9.1,"I"))
 . . I TMP>0  S:TMP<DTACKMIN DTACKMIN=TMP  S:TMP>DTACKMAX DTACKMAX=TMP
 . ;--- Add a pending patient to the list
 . I PTSTAT=4  D:CPPL  S COUNTS("NPP")=$G(COUNTS("NPP"))+1
 . . S TMP=$$ADDPP(REGIEN,IEN,+RORBUF(798,IENS,.01,"I"))
 ;
 ;--- Count patients with errors
 I FLAGS["E"  D  Q:RC<0 RC  S @ROR8DST@("NPE")=RC
 . S RC=$$PTERR(REGIEN,SPI)
 ;
 ;--- Success
 I DTACKMAX>0  D
 . S @ROR8DST@("DTACKMIN")=DTACKMIN
 . S @ROR8DST@("DTACKMAX")=DTACKMAX
 E  F TMP="MIN","MAX"  S @ROR8DST@("DTACK"_TMP)=""
 I CPPL  D:$G(COUNTS("NPP"))>0
 . S RORBUF="",TMP=0
 . F  S TMP=$O(RORSRL(TMP))  Q:TMP'>0  D
 . . S $P(RORBUF,U,+RORSRL(TMP))=$P(RORSRL(TMP),U,2)
 . S @ROR8DST@("PPL",0,1)=RORBUF
 F TMP="NPA","NPP","NPT"  S @ROR8DST@(TMP)=+$G(COUNTS(TMP))
 Q RORECNT
 ;
 ;***** E-MAILS THE INFORMATION ABOUT THE REGISTRY
 ;
 ; REGIEN        Registry IEN
 ;
 ; [EMAIL]       E-mail address where the data will be sent to
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;                 E  Count patients with errors in the
 ;                    ROR PATIENT EVENTS file
 ;                 P  Include list of pending patients
 ;                 S  Show the progress indicator
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
SENDINFO(REGIEN,EMAIL,FLAGS) ;
 Q:'$$CCRNTFY^RORUTL05(REGIEN) 0
 N DATE,IENS,INFO,MSGBUF,PARAMS,RC,RORBUF,RORMSG,TMP
 S FLAGS=$G(FLAGS)
 S INFO=$$ALLOC^RORTMP(),RC=0
 S MSGBUF=$$ALLOC^RORTMP()
 S PARAMS("DATE")=$$DATE($$DT^XLFDT)
 ;
 ;--- Gather the information
 S RC=$$REGINFO(REGIEN,INFO,FLAGS)
 ;
 D:RC'<0
 . N I,MBI,NF,PATIEN,XMCHAN,XMDUZ,XMLOC,XMSUB,XMTEXT,XMY,XMZ
 . S IENS=REGIEN_","  K @MSGBUF
 . ;
 . ;--- Load the registry parameters
 . D GETS^DIQ(798.1,IENS,".01;1;2;13.3;19.3","I","RORBUF","RORMSG")
 . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,798.1,IENS)  Q
 . I $G(EMAIL)=""  S EMAIL=$G(RORBUF(798.1,IENS,13.3,"I"))  Q:EMAIL=""
 . ;
 . ;--- Header of the message body
 . S TMP=$$SITE^RORUTL03()
 . S PARAMS("STNAME")=$P(TMP,U,2)
 . S PARAMS("STNUM")=$P(TMP,U)
 . ;---
 . F I="DTACKMAX","DTACKMIN"  D
 . . S PARAMS(I)=$$DATE(+$G(@INFO@(I)))
 . F I="NPA","NPP","NPT"  D
 . . S PARAMS(I)=+$G(@INFO@(I))
 . ;---
 . S PARAMS("REGISTRY")=$G(RORBUF(798.1,IENS,.01,"I"))
 . S PARAMS("RETRIES")=+$G(RORBUF(798.1,IENS,19.3,"I"))
 . S PARAMS("UPDATED_UNTIL")=$$DATE($G(RORBUF(798.1,IENS,1,"I")))
 . S PARAMS("EXTRACTED_UNTIL")=$$DATE($G(RORBUF(798.1,IENS,2,"I")))
 . D BLD^DIALOG(7980000.021,.PARAMS,,MSGBUF,"S")
 . S MBI=+$O(@MSGBUF@(""),-1)
 . ;
 . ;--- Number of patients with errors
 . D:FLAGS["E"
 . . S MBI=MBI+1,@MSGBUF@(MBI)="<NPE>"_$G(@INFO@("NPE"))_"</NPE>"
 . ;
 . ;--- List of pending patients
 . D:FLAGS["P"
 . . S RORBUF=$G(@INFO@("PPL",0,1))
 . . F NF=1:1  Q:$P(RORBUF,U,NF)=""
 . . S NF=NF-1
 . . S MBI=MBI+1,@MSGBUF@(MBI)="<PPLIST>"
 . . S MBI=MBI+1,@MSGBUF@(MBI)="CSSN,"_$TR(RORBUF,U,",")
 . . S PATIEN=0
 . . F  S PATIEN=$O(@INFO@("PPL",PATIEN))  Q:PATIEN'>0  D
 . . . S RORBUF=$G(@INFO@("PPL",PATIEN,1))
 . . . F I=1:1:NF  S $P(RORBUF,U,I)=$$DATE(+$P(RORBUF,U,I))
 . . . S TMP=$P(@INFO@("PPL",PATIEN),U,2)
 . . . S MBI=MBI+1,@MSGBUF@(MBI)=TMP_","_$TR(RORBUF,U,",")
 . . S MBI=MBI+1,@MSGBUF@(MBI)="</PPLIST>"
 . ;
 . ;--- Footer of the message body
 . D BLD^DIALOG(7980000.022,.PARAMS,,MSGBUF,"S")
 . ;
 . ;--- Send the message
 . S XMDUZ=.5,XMY(EMAIL)=""
 . S XMSUB="ROR: REGISTRY INFO"
 . S XMTEXT=$$OREF^DILF(MSGBUF)
 . D ^XMD
 ;
 ;--- Cleanup
 D FREE^RORTMP(INFO),FREE^RORTMP(MSGBUF)
 Q $S(RC<0:RC,1:0)
