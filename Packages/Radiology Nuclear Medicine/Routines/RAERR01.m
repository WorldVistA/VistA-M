RAERR01 ;HCIOFO/SG - ERROR HANDLING UTILITIES ; 1/18/08 4:27pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** RETURNS A LIST OF ERROR CODES FROM THE STACK
 ;
 ; [ENCLOSE]     Enclose the list in commas.
 ;
 ; Return Values:
 ;       ""  No errors
 ;      ...  List of error codes (in reverse chronological order)
 ;           separated by commas.
 ;
ERRLST(ENCLOSE) ;
 N I,LST
 S I=" ",LST=""
 F  S I=$O(RAERROR("ES",I),-1)  Q:I'>0  D
 . S LST=LST_","_$P(RAERROR("ES",I,0),U)
 Q $S(LST="":"",$G(ENCLOSE):LST_",",1:$P(LST,",",2,999999))
 ;
 ;***** RETURNS THE TEXT AND TYPE OF THE MESSAGE
 ;
 ; ERRCODE       Error code
 ;
 ; [.TYPE]       Reference to a local variable where the problem
 ;               type is returned ("I" -  Information, "W" - warning, 
 ;               "E" - error).
 ;
 ; [ARG1-ARG5]   Optional parameters that substitute the |n| "windows"
 ;               in the text of the message (for example, the |2| will
 ;               be substituted by the value of the ARG2).
 ;
 ; NOTE: The "^" is replaced with the "~" in the resulting message.
 ;
MSG(ERRCODE,TYPE,ARG1,ARG2,ARG3,ARG4,ARG5) ;
 Q:ERRCODE'<0 ""
 N ARG,I1,I2,MSG
 ;--- Get a descriptor of the message
 S MSG=$$EZBLD^DIALOG(700000-(ERRCODE/1000))
 ;--- Parse and validate the descriptor
 S TYPE=$E(MSG),MSG=$P(MSG,U,2,999)
 S:("IWE"'[TYPE)!(TYPE="") TYPE="E"
 Q:MSG?." " "Unknown error ("_ERRCODE_")"
 ;--- Substitute parameters
 S I1=2
 F  S I1=$F(MSG,"|",I1-1)  Q:'I1  D
 . S I2=$F(MSG,"|",I1)  Q:'I2
 . X "S ARG=$G(ARG"_+$TR($E(MSG,I1,I2-2)," ")_")"
 . S $E(MSG,I1-1,I2-1)=ARG
 Q $TR($$TRIM^XLFSTR(MSG),U,"~")
 ;
 ;***** DISPLAYS THE ERROR STACK OR A SINGLE ERROR MESSAGE
 ;
 ; [ERROR]       Descriptor of a single error to be displayed.
 ;
 ; [.RAINFO]     Reference to a local array with additional
 ;               information for a single error.
 ;
PRTERRS(ERROR,RAINFO) ;
 Q:($G(ERROR)'<0)&($D(RAERROR("ES"))<10)
 N EXIT,IMSG
 ;--- Print table header
 Q:$$PAGE^RAUTL22(3)<0
 D W^RAUTL22("Code  Message")
 D W^RAUTL22("      Additional Information")
 D W^RAUTL22("      Location")
 D W^RAUTL22("----  "_$$REPEAT^XLFSTR("-",IOM-7))
 ;--- Print a single error message
 I $G(ERROR)<0  S EXIT=$$PRT1ERR(ERROR,"RAINFO")  Q
 ;--- Print the error stack (most recent messages first)
 S IMSG=" "  K EXIT
 F  S IMSG=$O(RAERROR("ES",IMSG),-1)  Q:IMSG'>0  D  Q:$G(EXIT)
 . D:$D(EXIT) W^RAUTL22(" ")
 . S EXIT=$$PRT1ERR(RAERROR("ES",IMSG,0),$NA(RAERROR("ES",IMSG,1)))
 Q
 ;
PRT1ERR(ERR,RA8INFO) ;
 N I,RC,SP6
 S RC=0,SP6="      "
 ;===
 D
 . S RC=$$PAGE^RAUTL22  Q:RC<0
 . D W^RAUTL22($J(+ERR,4)_"  "_$$TRUNC^RAUTL22($P(ERR,U,2),IOM-7))
 . ;--- Display the additional information
 . I $G(RA8INFO)'="",$D(@RA8INFO)>1  S I=""  D
 . . F  S I=$O(@RA8INFO@(I))  Q:I=""  D  Q:RC<0
 . . . S RC=$$PAGE^RAUTL22  Q:RC<0
 . . . D W^RAUTL22(SP6_$$TRUNC^RAUTL22(@RA8INFO@(I),IOM-7))
 . Q:RC<0
 . ;--- Display the location
 . S I=$TR($P(ERR,U,3),"~","^")
 . I I'=""  S RC=$$PAGE^RAUTL22  D:RC'<0 W^RAUTL22(SP6_I)
 Q:RC<0 RC
 ;===
 S RC=$$PAGE^RAUTL22
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS THE ERROR STACK FROM A REMOTE PROCEDURE
 ;
 ; .RESULT       Reference to a local variable where the error
 ;               descriptors are returned to.
 ;
 ; LASTERR       The last error code.
 ;
 ; Return Values:
 ;
 ; RESULT(0)             Result descriptor
 ;                         ^01: The last error code (LASTERR)
 ;                         ^02: Number of error descriptors
 ;
 ; RESULT(i)             Error descriptor
 ;                         ^01: Error code
 ;                         ^02: Message
 ;                         ^03: Error location
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
 Q:$D(RAERROR("ES"))<10
 ;
 S EPTR="",(CNT,ECNT)=0
 F  S EPTR=$O(RAERROR("ES",EPTR),-1)  Q:EPTR=""  D
 . S TMP=$G(RAERROR("ES",EPTR,0))  Q:'TMP
 . S CNT=CNT+1,ECNT=ECNT+1,RESULT(CNT)=TMP
 . S I=0
 . F  S I=$O(RAERROR("ES",EPTR,1,I))  Q:I'>0  D
 . . S CNT=CNT+1,$P(RESULT(CNT),U,2)=RAERROR("ES",EPTR,1,I)
 ;
 S $P(RESULT(0),U,2)=ECNT
 K ^TMP("DILIST",$J)
 Q
 ;
 ;+++++ DEFAULT RUN-TIME ERROR HANDLER
 ;
 ; RAZZRCV       Name of a variable that the error code
 ;               (-1, -2, or -4) is assigned to.
 ;
 ; RAZZSTL       Stack level (value of the $STACK special variable)
 ;               where execution control is returned to.
 ;
RTEHNDLR(RAZZRCV,RAZZSTL) ;
 N RAZZERR,RAZZRC
 S RAZZERR=$$EC^%ZOSV
 S:$ECODE=",UTIMEOUT," RAZZRC=-2
 S:$ECODE=",UCANCEL," RAZZRC=-1
 ;--- Record the error if this is not user "^" or timeout
 I '$G(RAZZRC)  D ^%ZTER  S RAZZRC=+$$ERROR^RAERR(-4,,RAZZERR)
 ;--- Unwind the stack and assign/return the error code
 S $ECODE="",RAZZSTL=RAZZSTL+1
 I RAZZSTL>0,$STACK(-1)>RAZZSTL  D
 . S $ETRAP="S:$ESTACK'>0 $ECODE="""""
 . S:RAZZRCV'="" $ETRAP=$ETRAP_","_RAZZRCV_"="_RAZZRC
 . S $ETRAP=$ETRAP_" Q:$QUIT "_RAZZRC_" Q"
 . S $ECODE=",U1,"
 E  S:RAZZRCV'="" @RAZZRCV=RAZZRC
 Q:$QUIT RAZZRC  Q
