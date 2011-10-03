RORERR ;HCIOFO/SG - ERROR PROCESSING  ; 11/7/05 10:29am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** INITIALIZES THE ERROR STACK
 ;
 ; [DEFLOC]      Default error location
 ; [ENABLE]      Enable extended error processing
 ; 
 ; Do not forget to NEW the RORERRDL variable before calling
 ; this procedure!
 ;
CLEAR(DEFLOC,ENABLE) ;
 S:$D(ENABLE) RORPARM("ERR")=+$G(ENABLE)
 I $G(RORPARM("ERR"))  K RORERROR("ES")  S:$D(DEFLOC) RORERRDL=DEFLOC
 D CLEAN^DILF
 Q
 ;
 ;***** CHECKS THE ERRORS AFTER A FILEMAN DBS CALL
 ;
 ; ROR8MSG       Closed reference of the error messages array
 ;               (from DBS calls)
 ; [ERRCODE]     Error code to assign
 ; [PLACE]       Location of the error (see the $$ERROR)
 ; [PATIEN]      Patient IEN
 ; [FILE]        File number used in the DBS call
 ; [IENS]        IENS used in the DBS call
 ;
 ; The $$DBS^RORERR function checks the DIERR and @ROR8MSG variables
 ; for errors after a FileMan DBS call.
 ; 
 ; Return Values:
 ;
 ; If there are no errors found, it returns an empty string.
 ; In case of errors, the result depends on value of the ERRCODE
 ; parameter:
 ;
 ; If ERRCODE is omitted or equals 0, the function returns a string
 ; containing the list of error codes separated by comma.
 ; 
 ; If ERRCODE is not zero, the $$ERROR^RORERR function is called and
 ; its return value is returned.
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D DBS^RORERR(...) if you do not need its return value.
 ;
DBS(ROR8MSG,ERRCODE,PLACE,PATIEN,FILE,IENS) ;
 K RORERROR("DBS")
 I '$G(DIERR)  Q:$QUIT ""  Q
 N ERRLST,ERRNODE,I,MSGTEXT
 S ERRNODE=$S($G(ROR8MSG)'="":$NA(@ROR8MSG@("DIERR")),1:$NA(^TMP("DIERR",$J)))
 I $D(@ERRNODE)<10  Q:$QUIT ""  Q
 ;--- Get a list of errors
 S I=0
 F  S I=$O(@ERRNODE@("E",I))  Q:'I  S RORERROR("DBS",I)=""
 ;--- Return a list of errors
 I '$G(ERRCODE)  D  Q:$QUIT $P(ERRLST,",",2,99)  Q
 . S ERRLST="",I=0
 . F  S I=$O(RORERROR("DBS",I))  Q:'I  S ERRLST=ERRLST_","_I
 . D CLEAN^DILF
 ;--- Record/display the error message
 D MSG^DIALOG("AE",.MSGTEXT,,,$G(ROR8MSG)),CLEAN^DILF
 S I=$S($G(FILE):"; File #"_FILE,1:"")
 S:$G(IENS)'="" I=I_"; IENS: """_IENS_""""
 S I=$$ERROR(ERRCODE,.PLACE,.MSGTEXT,.PATIEN,I)
 Q:$QUIT I  Q
 ;
 ;***** SETS DEFAULT ERROR LOCATION
 ;
 ; DEFLOC        Default error location
 ; 
 ; Do not forget to NEW the RORERRDL variable before calling
 ; this procedure!
 ;
DFLTLOC(DEFLOC) ;
 I $G(RORPARM("ERR"))  S RORERRDL=DEFLOC
 D CLEAN^DILF
 Q
 ;
 ;***** DISPLAYS CONTENT OF THE ERROR STACK
DSPSTK() ;
 Q:'$G(RORPARM("ERR"))!($D(RORERROR("ES"))<10)
 N EPTR,I,TMP
 D DSPSTKL("Err   Message Text",1)
 D DSPSTKL("      Additional info")
 S EPTR=""
 F  S EPTR=$O(RORERROR("ES",EPTR))  Q:EPTR=""  D
 . S TMP=RORERROR("ES",EPTR)
 . D DSPSTKL($J(+TMP,4)_"  "_$P(TMP,U,2),1)
 . S TMP=$G(RORERROR("ES",EPTR,1))
 . D:TMP'="" DSPSTKL("      Location: "_TMP)
 . S I=""
 . F  S I=$O(RORERROR("ES",EPTR,2,I))  Q:I=""  D
 . . D DSPSTKL("      "_RORERROR("ES",EPTR,2,I))
 Q
 ;
 ; MSG           Message to display
 ; [SKIP]        Skip a line before the output
 ;
DSPSTKL(MSG,SKIP) ;
 I '$G(RORPARM("KIDS"))  W:$G(SKIP) !  W MSG,!  Q
 I $G(SKIP)  D BMES^XPDUTL(MSG)  Q
 D MES^XPDUTL(MSG)
 Q
 ;
 ;***** PUTS THE ERROR IN THE ERROR STACK AND LOG FILE
 ;
 ; ERRCODE       Error code. Debug messages, information messages,
 ;               data quality warnings and warnings are not placed
 ;               into the stack. However, they are logged and
 ;               displayed if this is enabled.
 ;
 ; [PLACE]       Location of the error (TAG^ROUTINE).
 ;
 ;               If the parameter is undefined then the location is
 ;               extracted from the stack (see description of the
 ;               $STACK function for more details).
 ;
 ;               If an empty string is used as a value of the
 ;               parameter then the default location is used
 ;               (that has been set by CLEAR or DFLTLOC).
 ;
 ; [[.]RORINFO]  Optional additional information (either a string or
 ;               a reference to a local array that contains strings
 ;               prepared for storing in a word processing field)
 ;
 ; [PATIEN]      Patient IEN
 ;
 ; [ARG2-ARG5]   Optional parameters as for $$MSG^RORERR20
 ;               (|1| is substituted by the value of the PATIEN)
 ;
 ; Return Values:
 ;       <0  Error code (value of the ERRCODE)
 ;        0  Ok (if ERRCOCE'<0)
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D ERROR^RORERR(...) if you do not need its return value.
 ;
ERROR(ERRCODE,PLACE,RORINFO,PATIEN,ARG2,ARG3,ARG4,ARG5) ;
 I ERRCODE'<0  Q:$QUIT 0  Q
 N IR,SL,MSG,TOP,TYPE
 D:'$D(PLACE)
 . S SL=$STACK(-1)-1
 . F  Q:SL'>0  D  Q:'(PLACE["^RORERR")  S SL=SL-1
 . . S PLACE=$P($STACK(SL,"PLACE")," ")
 S:$G(PLACE)="" PLACE=$G(RORERRDL)
 I $D(RORINFO)=1  S IR=RORINFO  K RORINFO  S RORINFO(1)=IR,IR=1
 E  S IR=$O(RORINFO(""),-1)
 S MSG=$$MSG^RORERR20(+ERRCODE,.TYPE,.PATIEN,.ARG2,.ARG3,.ARG4,.ARG5)
 ;--- Put the error to the error stack
 D:$G(RORPARM("ERR"))&(TYPE>4)
 . S (RORERROR("ES"),TOP)=$G(RORERROR("ES"))+1
 . S RORERROR("ES",TOP)=+ERRCODE_U_MSG
 . S RORERROR("ES",TOP,1)=PLACE
 . M:$D(RORINFO) RORERROR("ES",TOP,2)=RORINFO
 ;--- Log the message
 S:PLACE'="" IR=IR+1,RORINFO(IR)="Location: "_PLACE
 D LOG^RORLOG(TYPE,MSG,$G(PATIEN),.RORINFO),CLEAN^DILF
 Q:$QUIT ERRCODE  Q
 ;
 ;***** CHECKS FOR INVALID POINTER ERROR
 ;
 ; FILE          Number of the 'pointed from' file
 ; IENS          IENS of the record of the file
 ; FIELD         Number of the pointer field
 ; [PLACE]       Location of the error (see the $$ERROR)
 ; [PATIEN]      Patient IEN
 ; [ERRCODE]     Error code to assign (-79 by default)
 ;
 ; The $$INVLDPTR^RORERR function checks the list of latest FileMan
 ; DBS error codes for the pointer errors.
 ; 
 ; Return Values:
 ;
 ; If there are no pointer errors found, the function returns zero.
 ; Otherwise, the $$ERROR^RORERR function is called and its value
 ; is returned (a negative value of the ERRCODE or -79 by default).
 ;
INVLDPTR(FILE,IENS,FIELD,PLACE,PATIEN,ERRCODE) ;
 Q:$D(RORERROR("DBS"))<10 0
 N EC,TMP
 F EC=601,0  Q:$D(RORERROR("DBS",EC))
 Q:'EC 0
 S TMP="File #"_FILE_"; IENS: """_IENS_"""; Field: "_FIELD
 Q $$ERROR($S($G(ERRCODE)<0:ERRCODE,1:-79),$G(PLACE),.TMP,.PATIEN)
 ;
 ;***** RECORDS THE ERROR MESSAGE INTO THE LOG FILE
 ;
 ; ERRCODE       Error code.
 ;
 ; [[.]RORINFO]  Optional additional information (either a string or
 ;               a reference to a local array that contains strings
 ;               prepared for storing in a word processing field)
 ;
 ; [PATIEN]      Patient IEN
 ;
 ; [ARG2-ARG5]   Optional parameters as for $$MSG^RORERR20
 ;               (|1| is substituted by the value of the PATIEN)
 ;
LOG(ERRCODE,RORINFO,PATIEN,ARG2,ARG3,ARG4,ARG5) ;
 Q:ERRCODE'<0
 N MSG,TYPE
 S MSG=$$MSG^RORERR20(+ERRCODE,.TYPE,.PATIEN,.ARG2,.ARG3,.ARG4,.ARG5)
 D LOG^RORLOG(TYPE,MSG,$G(PATIEN),.RORINFO)
 Q
 ;
 ;***** RETURNS THE ERROR STACK FOR A REMOTE PROCEDURE
 ;
 ; .RESULT       Reference to a local variable where the error
 ;               descriptors are returned to.
 ;
 ; LASTERR       The last error code
 ;
 ; Return Values:
 ;
 ; RESULT(0)             Result descriptor
 ;                         ^01: The last error code (LASTERR)
 ;                         ^02: Number of the error descriptors
 ;
 ; RESULT(i)             Error descriptor
 ;                         ^01: Error code
 ;                         ^02: Message
 ;                         ^03: Place of the error
 ; RESULT(j)             Line of the additional info
 ;                         ^01: ""
 ;                         ^02: Text
 ;
 ; Error descriptors are returned in reverse chronological order
 ; (most recent first).
 ; 
RPCSTK(RESULT,LASTERR) ;
 N CNT,ECNT,EPTR,I,TMP
 K RESULT  S RESULT(0)=(+LASTERR)_U_"0"
 S TMP=$$RTRNFMT^XWBLIB(2,1)
 Q:$D(RORERROR("ES"))<10
 ;
 S EPTR="",(CNT,ECNT)=0
 F  S EPTR=$O(RORERROR("ES",EPTR),-1)  Q:EPTR=""  D
 . S TMP=$G(RORERROR("ES",EPTR)),CNT=CNT+1,ECNT=ECNT+1
 . S RESULT(CNT)=(+TMP)_U_$TR($P(TMP,U,2,999),U,"~")
 . S TMP=$G(RORERROR("ES",EPTR,1))
 . S $P(RESULT(CNT),U,3)=$TR(TMP,U,"~")
 . S I=0
 . F  S I=$O(RORERROR("ES",EPTR,2,I))  Q:I'>0  D
 . . S CNT=CNT+1,$P(RESULT(CNT),U,2)=RORERROR("ES",EPTR,2,I)
 ;
 S $P(RESULT(0),U,2)=ECNT
 K ^TMP("DILIST",$J)
 Q
 ;
 ;***** DUMPS LOCAL VARIABLES INTO THE LOG
 ;
 ; M1S2G         Message code.
 ;
 ; V1A2R3S       List of local variables separated by commas
 ;
VARDUMP(M1S2G,V1A2R3S) ;
 Q
