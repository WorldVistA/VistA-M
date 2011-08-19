RORLOG ;HCIOFO/SG - LOG FILE MANAGEMENT ; 1/17/06 10:10am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; RORLOG -------------- CONSTANT & VARIABLES OF THE LOG SUSBSYSTEM
 ;
 ; RORLOG("IEN")         IEN of the main record in the ROR LOG file
 ;
 ; This routine uses the following IAs:
 ;
 ; #10060        Read-only (DBS API) access to the NEW PERSON file
 ;
 Q
 ;
 ;***** RECORDS THE ACCESS VIOLATION EVENT
 ;
 ; MSG           Either a negative code of the message or a message
 ;               text that will be recorded in the log.
 ;
 ; [REGISTRY]    Either a registry name or a registry IEN
 ;               (the log will be associated with this registry)
 ;
 ; [ARG2-ARG5]   Optional parameters as for $$MSG^RORERR20
 ;
ACVIOLTN(MSG,REGISTRY,ARG2,ARG3,ARG4,ARG5) ;
 N INFO,RORLOG,RORMSG,RORPARM
 S REGISTRY=$G(REGISTRY)
 ;--- Make sure that event recording is enabled
 S RORPARM("LOG")=1
 ;--- Get the registry name
 I (+REGISTRY)=REGISTRY  D:REGISTRY>0
 . S REGISTRY=$P($G(^ROR(798.1,+REGISTRY,0)),U)
 ;--- Get the text of the message (if a code is provided)
 S:(+MSG)=MSG MSG=$$MSG^RORERR20(+MSG,,,.ARG2,.ARG3,.ARG4,.ARG5)
 ;--- Send an alert to the registry coordinators
 D:REGISTRY'=""
 . S INFO=$G(DUZ)_U_$$NOW^XLFDT
 . D ALERT^RORUTL01(REGISTRY,MSG,"ACLRTN^RORLOG01",INFO)
 ;--- Create a new log and record the message
 I $$OPEN(REGISTRY,6)'<0  D  D CLOSE()
 . D:$G(DUZ)>0
 . . S INFO="Violator: "_$$GET1^DIQ(200,DUZ_",",.01,,,"RORMSG")
 . . S INFO=INFO_" (DUZ="_DUZ_")"
 . D LOG(6,MSG,,.INFO)
 Q
 ;
 ;***** CLOSES THE CURRENT LOG
 ;
 ; [MESSAGE]     Text of the final message
 ; [COUNTERS]    Statistic counters
 ;                 ^1: Total number of processed patients
 ;                 ^2: Number of patients processed with errors
 ;
CLOSE(MESSAGE,COUNTERS) ;
 Q:$G(RORLOG("IEN"))'>0
 N BDT,EDT,IENS,RATE,RORFDA,RORINFO,RORMSG,TMP
 S EDT=$$NOW^XLFDT
 S IENS=RORLOG("IEN")_","
 ;--- Prepare statistic data
 D:$G(COUNTERS)>0
 . S RORINFO(1)="Patients:     "_+$P(COUNTERS,U)
 . S RORINFO(2)="Errors:       "_+$P(COUNTERS,U,2)
 . S BDT=$$GET1^DIQ(798.7,IENS,.01,"I",,"RORMSG")
 . Q:$G(BDT)'>0
 . S TMP=$$FMDIFF^XLFDT(EDT,BDT,2)
 . S RATE=$S(TMP>0:$J(COUNTERS/TMP,0,3),1:"")
 . S RORINFO(3)="Time (sec):   "_TMP
 . S:RATE RORINFO(4)="Patients/sec: "_RATE
 . ;--- Data for the log header
 . S RORFDA(798.7,IENS,6.01)=$P(COUNTERS,U,1)
 . S RORFDA(798.7,IENS,6.02)=$P(COUNTERS,U,2)
 . S:RATE RORFDA(798.7,IENS,6.03)=RATE
 ;--- Store data in the header and log the final message
 S RORFDA(798.7,IENS,5)=EDT
 D FILE^DIE("K","RORFDA","RORMSG")
 D:$G(MESSAGE)'="" LOG^RORLOG(,MESSAGE,,.RORINFO)
 K RORLOG
 Q
 ;
 ;***** PUTS MESSAGE IN THE LOG
 ;
 ; [TYPE]        Type of the event:
 ;                 1  Debug
 ;                 2  Information
 ;                 3  Data quality
 ;                 4  Warning
 ;                 5  Database error
 ;                 6  Error
 ;
 ;       If value of the parameter is omitted or equals 0, the message
 ;       is logged as "information" (if log is enabled). This mode is
 ;       intended for log headers and separators.
 ;
 ; MESSAGE       Message text
 ; [PATIEN]      Patient IEN
 ;
 ; [[.]RORINFO]  Optional additional information (either a string or
 ;               a reference to a local array that contains strings
 ;               prepared for storing in a word processing field)
 ;
LOG(TYPE,MESSAGE,PATIEN,RORINFO) ;
 ;--- Do not do anything if log is disabled
 Q:'$G(RORPARM("LOG"))
 ;--- Check if collection of this kind of event is enabled.
 ;    Debug messages could be enabled only explicitly.
 I '$G(TYPE)  S TYPE=2
 E  I ($D(RORPARM("LOG"))>1)!(TYPE=1)  Q:'$G(RORPARM("LOG",+TYPE))
 ;---
 N CURRIO,DATETIME,I,IENS,RC,RORFDA,RORMSG,TMP
 I $D(RORINFO)=1  S TMP=RORINFO  K RORINFO  S RORINFO(1)=TMP  K TMP
 S DATETIME=$$NOW^XLFDT
 ;--- Add a new record to the log (if it has been open)
 D:$G(RORLOG("IEN"))>0
 . S IENS="+1,"_RORLOG("IEN")_","
 . S RORFDA(798.74,IENS,.01)=DATETIME
 . S RORFDA(798.74,IENS,1)=+TYPE
 . S RORFDA(798.74,IENS,2)=$E(MESSAGE,1,70)
 . S:$G(PATIEN) RORFDA(798.74,IENS,3)=+PATIEN
 . S:$D(RORINFO)>1 RORFDA(798.74,IENS,4)="RORINFO"
 . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 ;--- Display message (if debug mode 2 is enabled)
 I $G(RORPARM("DEBUG"))>1  U $G(IO(0))  D  U IO
 . W !,$P($$FMTE^XLFDT(DATETIME,"2FS"),"@",2)_" "_$E(MESSAGE,1,70),!
 . S I=""
 . F  S I=$O(RORINFO(I))  Q:I=""  D  W ?9,TMP,!
 . . S TMP=$G(RORINFO(I))  S:TMP="" TMP=$G(RORINFO(I,0))
 . W:$G(PATIEN) ?9,"Patient IEN: "_PATIEN,!
 Q
 ;
 ;***** RETURNS AN IEN OF THE CURRENT LOG
LOGIEN() ;
 Q +$G(RORLOG("IEN"))
 ;
 ;***** OPENS A NEW LOG
 ;
 ; [[.]REGLST]   Either name of the registry or reference to a local
 ;               array containing registry names as subscripts and
 ;               optional registry IENs as values
 ;
 ; [ACTIVITY]    Type of the activity:
 ;                 0  Other (default)
 ;                 1  Registry update
 ;                 2  Data Extract
 ;                 3  Acknowledgement
 ;                 4  Hist. Extraction
 ;                 5  Report
 ;                 6  Access Violation
 ;                 7  ROR TASK
 ;                 8  Registry Setup
 ;
 ; [MESSAGE]     Text of the first message
 ;
 ; [[.]ADDINFO]  Optional additional information (either a string or
 ;               a reference to a local array that contains strings
 ;               prepared for storing in a word processing field).
 ;               This text is appended after the list of registries
 ;               associated with the log.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
OPEN(REGLST,ACTIVITY,MESSAGE,ADDINFO) ;
 Q:'$G(RORPARM("LOG")) 0
 N I,IENS,IPTR,RC,REGIEN,REGNAME,RORFDA,RORIEN,RORINFO,RORMSG,TMP
 K RORLOG
 ;=== Prepare the list of registries
 I $D(REGLST)=1  S:REGLST'="" REGLST(REGLST)=""
 S REGNAME="",(IPTR,RC)=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . S REGIEN=+$G(REGLST(REGNAME))
 . I REGIEN'>0  D  I REGIEN'>0  S RC=REGIEN  Q
 . . S REGIEN=$$REGIEN^RORUTL02(REGNAME)
 . S IPTR=IPTR+1,RORINFO(IPTR)=REGNAME
 . S RORFDA(798.73,"+"_(IPTR+10)_",+1,",.01)=REGIEN
 . S RORIEN(IPTR+10)=REGIEN
 Q:RC<0 RC
 ;=== Create a log header (main record) in the ROR LOG file
 S IENS="+1,"
 S RORFDA(798.7,IENS,.01)=$$NOW^XLFDT
 S:$G(ACTIVITY)>0 RORFDA(798.7,IENS,1)=ACTIVITY
 S RORFDA(798.7,IENS,2)=$J
 S RORFDA(798.7,IENS,7)=$S($G(DUZ)>0:+DUZ,1:"")
 S TMP=$S($D(ZTQUEUED):+$G(ZTSK),1:0)
 S RORFDA(798.7,IENS,8)=$S(TMP>0:TMP,1:"")
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0 RC
 S RORLOG("IEN")=RORIEN(1)
 ;=== Add the header message (if any)
 D:$G(MESSAGE)'=""
 . ;--- Append the additional text to list of registries
 . I $D(ADDINFO)=1  D
 . . S IPTR=IPTR+1,RORINFO(IPTR)=ADDINFO
 . E  S I=""  D
 . . F  S I=$O(ADDINFO(I))  Q:I=""  D
 . . . S TMP=$G(ADDINFO(I)),IPTR=IPTR+1
 . . . S RORINFO(IPTR)=$S(TMP'="":TMP,1:$G(ADDINFO(I,0)))
 . ;---
 . D LOG(,MESSAGE,,.RORINFO)
 ;=== Success
 Q 0
 ;
 ;***** REPLACES LIST OF REGISTRIES ASSOCIATED WITH THE CURRENT LOG
 ;
 ; [.]REGLST     Either name of the registry or a reference to a local
 ;               array containing registry names as subscripts and
 ;               optional registry IENs as values.
 ;
 ; [NOLP]        If this parameter is defined and non-zero, the log
 ;               subsystem parameters will not be updated according
 ;               to the new list of associated registries.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
SETRGLST(REGLST,NOLP) ;
 N I,IENS,RC,REGIEN,RILST,RORBUF,RORFDA,RORIEN,RORMSG
 S IENS=$$LOGIEN()_","
 Q:'$G(RORPARM("LOG"))!(IENS'>0) 0
 ;--- Compile a list of registry IENs (as subscripts)
 S:$D(REGLST)=1 REGLST(REGLST)=""
 S I="",RC=0
 F  S I=$O(REGLST(I))  Q:I=""  D  Q:RC<0
 . S REGIEN=+$G(REGLST(I))
 . I REGIEN'>0  D  I REGIEN'>0  S RC=REGIEN  Q
 . . S REGIEN=$$REGIEN^RORUTL02(I)
 . S RILST(REGIEN)=""
 Q:RC<0 RC
 ;--- Delete old registries from the multiple of the log record
 D LIST^DIC(798.73,","_IENS,"@;.01I","U",,,,"B",,,"RORBUF","RORMSG")
 S RC=$$DBS^RORERR("RORMSG",-9)  Q:RC<0 RC
 S I=""
 F  S I=$O(RORBUF("DILIST",2,I))  Q:I=""  D
 . S REGIEN=RORBUF("DILIST","ID",I,.01)
 . I $D(RILST(REGIEN))  K RILST(REGIEN)  Q
 . S RORFDA(798.73,RORBUF("DILIST",2,I)_","_IENS,.01)="@"
 I $D(RORFDA)>1  D  Q:RC<0 RC
 . D FILE^DIE("K","RORFDA","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9)
 ;--- Add new registries to the multiple
 S REGIEN=""
 F I=1:1  S REGIEN=$O(RILST(REGIEN))  Q:REGIEN=""  D
 . S RORFDA(798.73,"+"_I_","_IENS,.01)=REGIEN
 . S RORIEN(I)=REGIEN
 I $D(RORFDA)>1  D  Q:RC<0 RC
 . D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 . S RC=$$DBS^RORERR("RORMSG",-9)
 ;--- Reload parameters (if necessary)
 I '$G(NOLP)  D  Q:RC<0 RC
 . K RORPARM("LOG")  S RC=$$PARAMS^RORLOG01(.REGLST)
 Q 0
 ;
 ;***** INITIALIZES THE LOG SUBSYSTEM
 ;
 ; [[.]REGLST]   Either a reference to a local array containing names
 ;               of the registries to process (as subscripts) or a
 ;               string that contains a name of the single registry.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
SETUP(REGLST) ;
 K RORPARM("LOG"),RORLOG
 S:$D(REGLST)=1 REGLST(REGLST)=""
 Q $$PARAMS^RORLOG01(.REGLST)
