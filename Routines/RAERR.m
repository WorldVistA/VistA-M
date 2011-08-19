RAERR ;HCIOFO/SG - ERROR HANDLING ; 4/10/08 4:46pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; * Error codes are negative numbers.
 ;
 ; * The corresponding error messages are stored in the DIALOG file
 ;   (#.84). Dialog numbers are calculated as follows:
 ;
 ;         Dialog# = 700000 - (ErrorCode / 1000).
 ;
 ;   For example, dialog number for the error code -9 is 700000.009.
 ;
 ; * A message itself is stored in the second "^"-piece of the dialog 
 ;   text line. The first piece determines the problem type:
 ;
 ;     I - Information. No actions are required.
 ;
 ;         The $$ERROR^RAERR does not store this kind of messages in
 ;         the RAERROR stack. However, they can be explicitly stored
 ;         there using the PUSH^RAERR.
 ;
 ;     W - Warning. There was a problem but the code was able to
 ;         ignore/recover and continue. It would be a good idea
 ;         to review the problem and fix it if/when possible.
 ;
 ;     E - Error. The code encountered a major problem and could
 ;         not continue. Data, code, or both should be fixed!
 ;
 Q
 ;
 ;***** INITIALIZES THE ERROR STACK
 ;
 ; [ENABLE]      Enable error stack (0|1). If the stack is enabled,
 ;               the $$ERROR function stores all error descriptors
 ;               there. Otherwise, only the latest error descriptor
 ;               is accessible (the result value of the $$ERROR
 ;               function).
 ;
CLEAR(ENABLE) ;
 S:$G(ENABLE)="" ENABLE=+$G(RAERROR("ES"))
 K RAERROR("ES")  D:ENABLE ENABLE(1)
 D CLEAN^DILF
 Q
 ;
 ;***** CHECKS THE ERRORS AFTER A FILEMAN DBS CALL
 ;
 ; RA8MSG        Closed reference of the error message array
 ;               (from DBS calls). If this parameter is empty,
 ;               then ^TMP("DIERR",$J) is assumed.
 ;
 ; [ERRCODE]     Error code to assign (see dialogs #700000.*).
 ;
 ; [FILE]        File number used in the DBS call.
 ; [IENS]        IENS used in the DBS call.
 ;
 ; This function checks the DIERR and @RA8MSG variables for
 ; errors after a FileMan DBS call.
 ; 
 ; Return Values:
 ;
 ; If there are no errors found, it returns an empty string.
 ; In case of errors, the result depends on value of the
 ; parameter:
 ;
 ; If ERRCODE is omitted or equals 0, the function returns a string
 ; containing the list of FileMan error codes separated by comma.
 ; 
 ; If ERRCODE is not zero, the $$ERROR^RAERR function is called
 ; and its result is returned.
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D DBS^RAERR(...) if you do not need its return value.
 ;
DBS(RA8MSG,ERRCODE,FILE,IENS) ;
 I '$G(DIERR)  Q:$QUIT ""  Q
 N ERRLST,ERRNODE,I,MSGTEXT
 S ERRNODE=$S($G(RA8MSG)'="":$NA(@RA8MSG@("DIERR")),1:$NA(^TMP("DIERR",$J)))
 I $D(@ERRNODE)<10  Q:$QUIT ""  Q
 ;--- Return a list of errors
 I '$G(ERRCODE)  D  Q:$QUIT $P(ERRLST,",",2,999)  Q
 . S ERRLST="",I=0
 . F  S I=$O(@ERRNODE@("E",I))  Q:'I  S ERRLST=ERRLST_","_I
 . D CLEAN^DILF
 ;--- Record the error message
 D MSG^DIALOG("AE",.MSGTEXT,,,$G(RA8MSG)),CLEAN^DILF
 S I=$S($G(FILE):"; File #"_FILE,1:"")
 S:$G(IENS)'="" I=I_"; IENS: """_IENS_""""
 S I=$$ERROR(ERRCODE,.MSGTEXT,I)
 Q:$QUIT I  Q
 ;
 ;***** ENABLES/DISABLES THE ERROR STACK
 ;
 ; ENABLE        Enable (1) or disable (0) the error stack.
 ;               Content of the stack is not affected.
 ; 
 ; Return Values:
 ;
 ; Previous state of the stack: 1 - enabled, 0 - disabled.
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D ENABLE^RAERR(...) if you do not need its return value.
 ;
ENABLE(ENABLE) ;
 N OLD
 S OLD=+$G(RAERROR("ES"))
 S RAERROR("ES")=+ENABLE
 Q:$QUIT OLD  Q
 ;
 ;***** GENERATES THE ERROR MESSAGE
 ;
 ; ERRCODE       Error code (see dialogs #700000.*).
 ;
 ; [[.]RAINFO]   Optional additional information: either a string or
 ;               a reference to a local array that contains strings
 ;               prepared for storing in a word processing field
 ;               (first level nodes; no 0-nodes).
 ;
 ; [ARG1-ARG5]   Optional parameters for $$MSG^RAERR01.
 ;
 ; Return Values:
 ;       <0  Error code^Message text^Error location^Type
 ;        0  Ok (if ERRCODE'<0)
 ;
 ; NOTE: "^" is replaced with "~" in the error location stored
 ;       in the 3rd piece of the error descriptor.
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D ERROR^RAERR(...) if you do not need its return value.
 ;
ERROR(ERRCODE,RAINFO,ARG1,ARG2,ARG3,ARG4,ARG5) ;
 I ERRCODE'<0  Q:$QUIT 0  Q
 N IEN,MSG,PLACE,SL,TMP,TYPE
 ;--- Get the error location
 S SL=$STACK(-1)-1,PLACE=""
 F  Q:SL'>0  D  Q:'(PLACE[$T(+0))  S SL=SL-1
 . S PLACE=$P($STACK(SL,"PLACE")," ")
 ;--- Prepare the additional information
 I $D(RAINFO)=1  S TMP=RAINFO  K RAINFO  S RAINFO(1)=TMP
 ;--- Prepare the message descriptor
 S MSG=$$MSG^RAERR01(ERRCODE,.TYPE,.ARG1,.ARG2,.ARG3,.ARG4,.ARG5)
 S MSG=(+ERRCODE)_U_MSG_U_$TR(PLACE,U,"~")_U_TYPE
 ;--- Store the descriptor
 D:TYPE'="I" PUSH(MSG,.RAINFO)
 ;--- Display the error if debug mode is on
 I $G(RAPARAMS("DEBUG"))>1  U $G(IO(0),0)  D  U $G(IO,0)
 . D PRTERRS^RAERR01(MSG,.RAINFO)
 ;---
 Q:$QUIT MSG  Q
 ;
 ;***** GENERATES THE 'INVALID PARAMETER VALUE' ERROR
 ;
 ; RA8NAME       Name of the parameter
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D IPVE^RAERR(...) if you do not need its return value.
 ;
IPVE(RA8NAME) ;
 N RA8RC
 S RA8RC=$S($D(@RA8NAME)#10:"'"_@RA8NAME_"'",1:"<UNDEFINED>")
 S RA8RC=$$ERROR(-3,RA8NAME_"="_RA8RC,RA8NAME)
 Q:$QUIT RA8RC  Q
 ;
 ;***** PROCESSES THE ERROR DESCRIPTOR RETURNED BY $$LOCKFM^RALOCK
 ;
 ; ERROR         Error descriptor
 ;
 ; OBJNAME       Name of the object that the $$LOCKFM^RALOCK tried
 ;               to lock when it returned the error descriptor.
 ;
LOCKERR(ERROR,OBJNAME) ;
 Q $S(ERROR>0:$$ERROR(-15,$$TEXT^RALOCK(ERROR),OBJNAME),1:ERROR)
 ;
 ;***** PUSHES THE ERROR INTO THE ERROR STACK
 ;
 ; ERROR         Error descriptor
 ;
 ; [.RAINFO]     Reference to a local array with additional
 ;               information
 ;
PUSH(ERROR,RAINFO) ;
 Q:'$G(RAERROR("ES"))
 N IEN
 ;--- Store the descriptor
 S IEN=$O(RAERROR("ES"," "),-1)+1
 S RAERROR("ES",IEN,0)=ERROR
 M RAERROR("ES",IEN,1)=RAINFO
 Q
 ;
 ;***** ASSIGNS THE DEFAULT ERROR HANDLER
 ;
 ; [RCVNAME]     Name of a variable for the error code
 ;
 ;               See the RTEHNDLR^RAERR01 for more details.
 ;
SETDEFEH(RCVNAME) ;
 S $ECODE="",$ETRAP="D RTEHNDLR^"_$NA(RAERR01($G(RCVNAME),$STACK(-1)-2))
 Q
