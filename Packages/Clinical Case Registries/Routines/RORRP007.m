RORRP007 ;HCIOFO/SG - RPC: LOGS & MESSAGES ; 11/4/05 8:56am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** LOADS THE LOG INFORMATION INTO THE BUFFER
 ;
 ; IEN           Log IEN
 ;
 ; ROR8DST       Closed root of the destination buffer
 ;
 ; [[.]OFFSET]   Offset in the buffer (modified by the function
 ;               if passed by reference)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Skip the log
 ;
LOAD(IEN,ROR8DST,OFFSET) ;
 N BUF,IENS,IENS1,RORBUF,RORMSG
 S IENS=IEN_","  K RORBUF
 D GETS^DIQ(798.7,IENS,RORFLDS,"EI","RORBUF","RORMSG")
 Q:$G(DIERR) 1
 ;--- Skip the 'Access Violation' activities
 Q:$G(RORBUF(798.7,IENS,1,"I"))=6 2
 S BUF="L^"_IEN
 ;--- Activity (external)
 S $P(BUF,"^",3)=$G(RORBUF(798.7,IENS,1,"E"))
 ;--- Activity (internal)
 S $P(BUF,"^",4)=$G(RORBUF(798.7,IENS,1,"I"))
 ;--- Start Date/Time
 S $P(BUF,"^",5)=$G(RORBUF(798.7,IENS,.01,"E"))
 ;--- Contains messages
 S $P(BUF,"^",6)=($O(^RORDATA(798.7,IEN,2,0))>0)
 ;--- Job Number
 S $P(BUF,"^",7)=$G(RORBUF(798.7,IENS,2,"E"))
 ;--- End Date/Time
 S $P(BUF,"^",8)=$G(RORBUF(798.7,IENS,5,"E"))
 ;--- Number of Processed Patients
 S $P(BUF,"^",9)=$G(RORBUF(798.7,IENS,6.01,"E"))
 ;--- Number of Patients with Errors
 S $P(BUF,"^",10)=$G(RORBUF(798.7,IENS,6.02,"E"))
 ;--- Processing Rate
 S $P(BUF,"^",11)=$G(RORBUF(798.7,IENS,6.03,"E"))
 ;--- Task Number
 S $P(BUF,"^",12)=$G(RORBUF(798.7,IENS,8,"I"))
 ;--- Add the log descriptor to the output
 S OFFSET=$G(OFFSET)+1,@ROR8DST@(OFFSET)=BUF
 ;--- Load the list of registries
 S IENS1=""
 F  S IENS1=$O(RORBUF(798.73,IENS1))  Q:IENS1=""  D
 . S BUF="R^"_$G(RORBUF(798.73,IENS1,.01,"I"))
 . S $P(BUF,"^",3)=$G(RORBUF(798.73,IENS1,.01,"E"))
 . ;--- Add the registry descriptor to the output
 . S OFFSET=OFFSET+1,@ROR8DST@(OFFSET)=BUF
 ;---Add the 'End of log' marker
 S OFFSET=OFFSET+1,@ROR8DST@(OFFSET)="L^END"
 Q 0
 ;
 ;***** RETURNS THE LOG INFORMATION
 ; RPC: [ROR LOG INFO]
 ;
 ; .RORRES       Reference to a local variable where the results
 ;               are returned to.
 ;
 ; LOGIEN        Log IEN
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RORRES(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, either 0 (the log does not exist) or 1 is returned
 ; in the RORRES(0) and the subsequent nodes of the RORRES array
 ; contain the log information.
 ; 
 ; RORRES(0)             0 or 1
 ;
 ; RORRES(i)             See description of the LOGLIST^RORRP007
 ;
LOGINFO(RORRES,LOGIEN) ;
 N RC,RORFLDS
 ;--- Initialize the variables
 K RORRES  S RORRES(0)=0
 S RORFLDS=".01;1;2;3*;5;6.01;6.02;6.03;8"
 ;--- Check the parameters
 S LOGIEN=+$G(LOGIEN)  Q:LOGIEN'>0
 Q:'$D(^RORDATA(798.7,LOGIEN,0))
 ;--- Load the log information
 S RC=$$LOAD(LOGIEN,"RORRES")
 ;--- Check for the errors
 I 'RC  S RORRES(0)=1
 E  D:RC<0 RPCSTK^RORERR(.RORRES,RC)
 Q
 ;
 ;***** RETURNS THE LIST OF LOGS
 ; RPC: [ROR LOG GET LIST]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; [STDT]        Start date (by default, from the earliest log)
 ; [ENDT]        End date (by default, to the latest log)
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, number of logs is returned in the @RESULTS@(0) and the
 ; subsequent nodes of the RESULTS array contain the logs.
 ; 
 ; @RESULTS@(0)          Number of logs
 ;
 ; @RESULTS@(i)          Log descriptor
 ;                         ^01: "L"
 ;                         ^02: Log IEN
 ;                         ^03: Activity (external)
 ;                         ^04: Activity (internal)
 ;                         ^05: Start Date/Time (external)
 ;                         ^06: Contains messages (0/1)
 ;                         ^07: Job Number
 ;                         ^08: End Date/Time (external)
 ;                         ^09: Number of Processed Patients
 ;                         ^10: Number of Patients with Errors
 ;                         ^11: Processing Rate
 ;                         ^12: Task Number (optional)
 ;
 ; @RESULTS@(...)        Registry descriptor (optional)
 ;                         ^01: "R"
 ;                         ^02: Registry IEN
 ;                         ^03: Registry Name
 ;
 ; @RESULTS@(i+n)        'End of log' marker
 ;                         ^01: "L"
 ;                         ^02: "END"
 ;
LOGLIST(RESULTS,REGIEN,STDT,ENDT) ;
 N CNT,DATE,IEN,RORFLDS,RC,XREF
 D CLEAR^RORERR("LOGLIST^RORRP007",1)
 S RORFLDS=".01;1;2;3*;5;6.01;6.02;6.03;8"
 ;--- Check the parameters
 I $G(REGIEN)'>0  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 S REGIEN=+REGIEN,STDT=$G(STDT)\1,ENDT=$G(ENDT)\1
 S ENDT=$S(ENDT>0:$$FMADD^XLFDT(ENDT,1),1:9999999)
 ;--- Initialize the variables
 S XREF=$NA(^RORDATA(798.7,"ARD",REGIEN)),CNT=0
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 ;--- Browse through the logs
 S CNT("L")=0,DATE=ENDT
 F  S DATE=$O(@XREF@(DATE),-1)  Q:DATE=""  Q:DATE<STDT  D
 . S IEN=""
 . F  S IEN=$O(@XREF@(DATE,IEN),-1)  Q:IEN=""  D
 . . S RC=$$LOAD(IEN,RESULTS,.CNT)
 . . S:'RC CNT("L")=CNT("L")+1
 ;--- Number of logs
 S @RESULTS@(0)=CNT("L")
 Q
 ;
 ;***** RETURNS THE LIST OF MESSAGES
 ; RPC: [ROR LOG GET MESSAGES]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; LOGIEN        IEN of the log
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, number of messages is returned in the RESULTS(0) and
 ; the subsequent nodes of the RESULTS array contain the messages.
 ;
 ; @RESULTS@(0)          Number of messages
 ;
 ; @RESULTS@(i)          Message descriptor
 ;                         ^01: "M"
 ;                         ^02: Message IENS
 ;                         ^03: Type (external)
 ;                         ^04: Type (internal)
 ;                         ^05: Date/Time (external)
 ;                         ^06: Has Additional Info (0/1)
 ;                         ^07: Patient Name
 ;                         ^08: Patient IEN (DFN)
 ;
 ; @RESULTS@(i+1)        Message
 ;                         ^01: "T"
 ;                         ^02: Message Text
 ;
 ; @RESULTS@(...)        Line of the ADDITIONAL INFO text
 ;                         ^01: "A"
 ;                         ^02: Text
 ;                         
 ; @RESULTS@(i+n)        'End of message' marker
 ;                         ^01: "M"
 ;                         ^02: "END"
 ;
MSGLIST(RESULTS,LOGIEN) ;
 N CNT,I,IEN,IENS,RC,ROOT,RORBUF,RORMSG
 D CLEAR^RORERR("MESSAGE^RORRP007",1)
 ;--- Check the parameters
 I $G(LOGIEN)'>0  D  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . S RC=$$ERROR^RORERR(-88,,,,"LOGIEN",$G(LOGIEN))
 S LOGIEN=+LOGIEN
 ;--- Initialize the variables
 S ROOT=$$ROOT^DILFD(798.7,,1),CNT=0
 K RESULTS  S RESULTS=$$ALLOC^RORTMP()
 ;--- Browse through the messages
 S (CNT("M"),IEN)=0
 F  S IEN=$O(@ROOT@(LOGIEN,2,IEN))  Q:IEN'>0  D
 . S IENS=IEN_","_LOGIEN_","  K RORBUF
 . ;--- Load the message details
 . D GETS^DIQ(798.74,IENS,".01;1;2;3;4","EI","RORBUF","RORMSG")
 . Q:$G(DIERR)
 . S BUF="M^"_IENS
 . ;--- Type (external)
 . S $P(BUF,"^",3)=$G(RORBUF(798.74,IENS,1,"E"))
 . ;--- Type (Internal)
 . S $P(BUF,"^",4)=$G(RORBUF(798.74,IENS,1,"I"))
 . ;--- Date/Time
 . S $P(BUF,"^",5)=$G(RORBUF(798.74,IENS,.01,"E"))
 . ;--- Has Additional Info
 . S $P(BUF,"^",6)=($D(RORBUF(798.74,IENS,4))>1)
 . ;--- Patient Name
 . S $P(BUF,"^",7)=$G(RORBUF(798.74,IENS,3,"E"))
 . ;--- Patient IEN (DFN)
 . S $P(BUF,"^",8)=$G(RORBUF(798.74,IENS,3,"I"))
 . ;--- Add the descriptor to the output
 . S CNT=CNT+1,@RESULTS@(CNT)=BUF
 . ;--- Add the message text to the output
 . S CNT=CNT+1,@RESULTS@(CNT)="T^"_$G(RORBUF(798.74,IENS,2,"E"))
 . ;--- Append the ADDITIONAL INFO
 . S I=0
 . F  S I=$O(RORBUF(798.74,IENS,4,I))  Q:'I  D
 . . S CNT=CNT+1,@RESULTS@(CNT)="A^"_RORBUF(798.74,IENS,4,I)
 . ;---Add the 'End of message' marker
 . S CNT=CNT+1,@RESULTS@(CNT)="M^END"
 . S CNT("M")=CNT("M")+1
 ;--- Number of messages
 S @RESULTS@(0)=CNT("M")
 Q
