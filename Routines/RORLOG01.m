RORLOG01 ;HCIOFO/SG - LOG FILE MANAGEMENT (UTILITIES) ; 1/17/06 10:09am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** PROCESSES AN ACCESS VIOLATION ALERT
ACLRTN ;
 N I,PARAMS,RORBUF
 ;--- Prepare the parameters
 S (PARAMS("DUZ"),I)=+$P(XQADATA,U)
 I I>0  D  K RORBUF
 . S PARAMS("USERNAME")=$$GET1^DIQ(200,I_",",.01,,,"RORBUF")
 S:$G(PARAMS("USERNAME"))="" PARAMS("USERNAME")="unknown user"
 S PARAMS("DATETIME")=$$FMTE^XLFDT($P(XQADATA,U,2))
 ;--- Generate the text of alert
 D BLD^DIALOG(7980000.015,.PARAMS,,"RORBUF","S")
 ;--- Display the alert details
 S I=0  W !
 F  S I=$O(RORBUF(I))  Q:I'>0  W !,RORBUF(I)
 Q
 ;
 ;***** LOADS THE LOG SUBSYSTEM PARAMETERS
 ;
 ; .RORLST       Reference to a local array containing names
 ;               of the registries to process (as subscripts).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PARAMS(RORLST) ;
 N ENABLE,IENS,IR,IRS,RC,RORBUF,RORMSG,RORSB,SCR,TYPE
 ;--- Load a list of parameters of active registries
 S SCR="I '$P(^(0),U,7),$D(RORLST($P(^(0),U)))"
 D LIST^DIC(798.1,,"@;8I","U","*",,,"B",SCR,,"RORBUF","RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0 RC
 I '$G(RORBUF("DILIST",0))  S RORPARM("LOG")=1  Q 0
 ;--- Process the list of log parameters
 S IR="",RC=0
 F  S IR=$O(RORBUF("DILIST","ID",IR))  Q:IR=""  D  Q:RC
 . ;--- Check if the log is enabled
 . Q:'$G(RORBUF("DILIST","ID",IR,8))
 . S ENABLE=1
 . ;--- Load a list of event types to log
 . S IRS=","_RORBUF("DILIST",2,IR)_","  K RORSB
 . D LIST^DIC(798.11,IRS,"@;.01I","U","*",,,"B",,,"RORSB","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0
 . ;--- If there are no event types, log all events
 . I '$G(RORSB("DILIST",0))  D  Q
 . . K RORPARM("LOG")  S RC=1
 . ;--- Process the list of event types
 . S IRS=""
 . F  S IRS=$O(RORSB("DILIST","ID",IRS))  Q:IRS=""  D
 . . S TYPE=+$G(RORSB("DILIST","ID",IRS,.01))
 . . S:TYPE RORPARM("LOG",TYPE)=1
 S:$G(ENABLE) RORPARM("LOG")=1
 ;--- If not all types of errors are recorded,
 ;    enable recording of the type "Error"
 S:$D(RORPARM("LOG"))>1 RORPARM("LOG",6)=1
 Q $S(RC<0:RC,1:0)
 ;
 ;***** PURGES THE OLD LOGS
 ;
 ; [DKEEP]       Days to keep logs in the file (by default = 31)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PURGE(DKEEP) ;
 N HDR,IEN,IR,RC,RORFDA,RORFROM,RORMSG
 S RORFROM=$$FMADD^XLFDT($$DT^XLFDT,-$G(DKEEP,31))+1
 S RC=0
 F  D  Q:'$P($G(HDR),U,3)!(RC<0)
 . K RORFDA,RORMSG
 . ;--- Get the next 10 records
 . D LIST^DIC(798.7,,"@","BU",10,.RORFROM,,"B",,,"RORFDA","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0
 . ;--- Stop if no records left
 . S HDR=$G(RORFDA("DILIST",0))  Q:'HDR
 . ;--- Prepare the data
 . S IR=""
 . F  S IR=$O(RORFDA("DILIST",2,IR),-1)  Q:IR=""  D
 . . S IEN=RORFDA("DILIST",2,IR)
 . . ;--- Check if the cross-reference entries are valid
 . . D XREFCHK(IEN)
 . . ;--- Delete the log only if it is not referenced
 . . S:'$D(^RORDATA(798.7,"AREF",IEN)) RORFDA(798.7,IEN_",",.01)="@"
 . K RORFDA("DILIST")
 . Q:$D(RORFDA)<10
 . ;--- Delete the records
 . D FILE^DIE(,"RORFDA","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9,,,798.7)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** CHECK IF THE LOG IS REALLY REFERENCED
 ;
 ; LOGIEN        IEN of the log
 ;
XREFCHK(LOGIEN) ;
 N FIELD,FILE,IENS,NODE,RORMSG,TMP
 S NODE=$NA(^RORDATA(798.7,"AREF",IEN))
 S FILE=""
 F  S FILE=$O(@NODE@(FILE))  Q:FILE=""  D
 . S IENS=""
 . F  S IENS=$O(@NODE@(FILE,IENS))  Q:IENS=""  D
 . . S FIELD=""
 . . F  S FIELD=$O(@NODE@(FILE,IENS,FIELD))  Q:FIELD=""  D
 . . . S TMP=+$$GET1^DIQ(FILE,IENS,FIELD,"I",,"RORMSG")
 . . . K:TMP'=LOGIEN @NODE@(FILE,IENS,FIELD)
 Q
