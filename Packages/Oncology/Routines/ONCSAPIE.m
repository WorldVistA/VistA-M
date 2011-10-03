ONCSAPIE ;Hines OIFO/SG - COLLABORATIVE STAGING (ERRORS)  ; 10/27/06 8:59am
 ;;2.11;ONCOLOGY;**40,47,51**;Mar 07, 1995;Build 65
 ;;
 ;
 Q
 ;
 ;***** INITIALIZES THE ERROR STACK
 ;
 ; [ENABLE]      Enable error stack (0/1)
 ;
CLEAR(ENABLE) ;
 S:'$D(ENABLE) ENABLE=$D(ONCSAPI("MSG"))#10
 K ONCSAPI("MSG")  S:ENABLE ONCSAPI("MSG")=""
 D CLEAN^DILF
 Q
 ;
 ;***** CHECKS THE ERRORS AFTER A FILEMAN DBS CALL
 ;
 ; ONC8MSG       Closed reference of the error messages array
 ;               (from DBS calls)
 ; [ERRCODE]     Error code to assign
 ; [FILE]        File number used in the DBS call
 ; [IENS]        IENS used in the DBS call
 ;
 ; The $$DBS^ONCSAPIE function checks the DIERR and @ONC8MSG
 ; variables for errors after a FileMan DBS call.
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
 ; If ERRCODE is not zero, the $$ERROR^ONCSAPIE function is called
 ; and its return value is returned.
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D DBS^ONCSAPIE(...) if you do not need its return value.
 ;
DBS(ONC8MSG,ERRCODE,FILE,IENS) ;
 I '$G(DIERR)  Q:$QUIT ""  Q
 N ERRLST,ERRNODE,I,ONCMSGTEXT
 S ERRNODE=$S($G(ONC8MSG)'="":$NA(@ONC8MSG@("DIERR")),1:$NA(^TMP("DIERR",$J)))
 I $D(@ERRNODE)<10  Q:$QUIT ""  Q
 ;--- Return a list of errors
 I '$G(ERRCODE)  D  Q:$QUIT $P(ERRLST,",",2,99)  Q
 . S ERRLST="",I=0
 . F  S I=$O(@ERRNODE@("E",I))  Q:'I  S ERRLST=ERRLST_","_I
 . D CLEAN^DILF
 ;--- Record the error message
 D MSG^DIALOG("AE",.ONCMSGTEXT,,,$G(ONC8MSG)),CLEAN^DILF
 S I=$S($G(FILE):"; File #"_FILE,1:"")
 S:$G(IENS)'="" I=I_"; IENS: """_IENS_""""
 S I=$$ERROR(ERRCODE,.ONCMSGTEXT,I)
 Q:$QUIT I  Q
 ;
 ;***** GENERATES THE ERROR MESSAGE
 ;
 ; ERRCODE       Error code.
 ;               If the 'S' suffix is appended to the code, the error 
 ;               descriptor will not be stored into the error stack.
 ;
 ; [[.]ONCINFO]  Optional additional information (either a string or
 ;               a reference to a local array that contains strings
 ;               prepared for storing in a word processing field)
 ;
 ; [ARG1-ARG5]   Optional parameters as for $$MSG^ONCSAPIE
 ;
 ; Return Values:
 ;       <0  Error code^Message Text^Label+Offset^Routine
 ;        0  Ok (if ERRCOCE'<0)
 ;
 ; NOTE: This entry point can also be called as a procedure:
 ;       D ERROR^ONCSAPIE(...) if you do not need its return value.
 ;
ERROR(ERRCODE,ONCINFO,ARG1,ARG2,ARG3,ARG4,ARG5) ;
 I ERRCODE'<0  Q:$QUIT 0  Q
 N IEN,MSG,PLACE,SL,TMP
 ;--- Get the error location
 S SL=$STACK(-1)-1
 F  Q:SL'>0  D  Q:'(PLACE["^ONCSAPIE")  S SL=SL-1
 . S PLACE=$P($STACK(SL,"PLACE")," ")
 S:$G(PLACE)'[U PLACE=U
 ;--- Prepare the additional information
 I $D(ONCINFO)=1  S TMP=ONCINFO  K ONCINFO  S ONCINFO(1)=TMP
 ;--- Prepare and store the message descriptor
 S MSG=$$MSG(ERRCODE,,.ARG1,.ARG2,.ARG3,.ARG4,.ARG5)
 S MSG=(+ERRCODE)_U_MSG_U_PLACE
 D:ERRCODE'["S" STORE(MSG,"ONCINFO")
 ;---
 Q:$QUIT MSG  Q
 ;
 ;***** RETURNS THE TEXT AND TYPE OF THE MESSAGE
 ;
 ; ERRCODE       Error code
 ;
 ; [.TYPE]       Type of the error
 ;
 ; [ARG1-ARG5]   Optional parameters that substitute the |n| "windows"
 ;               in the text of the message (for example, the |2| will
 ;               be substituted by the value of the ARG2).
 ;
 ; NOTE: The "^" is replaced with the "~" in the resulting message.
 ;
MSG(ERRCODE,TYPE,ARG1,ARG2,ARG3,ARG4,ARG5) ;
 S TYPE=6  Q:ERRCODE'<0 ""
 N ARG,I1,I2,MSG
 ;--- Get a descriptor of the message
 S I1=-ERRCODE,MSG=$P($T(MSGLIST+I1),";;",2)
 S I1=+$TR($P(MSG,U,2)," "),MSG=$P(MSG,U,3,999)
 S:I1>0 TYPE=I1
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
 ; [ERROR]       Descriptor of a single error to be displayed
 ;
PRTERRS(ERROR) ;
 Q:'$G(ERROR)&($D(ONCSAPI("MSG"))<10)
 N EXIT,IMSG,INFONODE,ONCMNL
 S ONCMNL=$S($G(IOSL)>3:IOSL-3,1:20),$Y=0
 ;--- Print table header
 D EN^DDIOL("Code",,"!"),EN^DDIOL("Description",,"?6")
 D EN^DDIOL("Additional Information",,"!?6")
 D EN^DDIOL("Type",,"!?6"),EN^DDIOL("Location",,"?22")
 D EN^DDIOL("----",,"!"),EN^DDIOL($$REPEAT^XLFSTR("-",IOM-7),,"?6")
 ;--- Print a single error message
 I $G(ERROR)  S EXIT=$$PRT1ERR(ERROR)  Q
 ;--- Print the error stack (most recent messages first)
 S IMSG=" ",EXIT=0
 F  S IMSG=$O(ONCSAPI("MSG",IMSG),-1)  Q:IMSG'>0  D  Q:EXIT
 . S INFONODE=$NA(ONCSAPI("MSG",IMSG,1))
 . S EXIT=$$PRT1ERR(ONCSAPI("MSG",IMSG,0),INFONODE)
 Q
 ;
PRT1ERR(ERR,ONC8INFO) ;
 N EXIT,I,LOC,TYPE
 S LOC=$S($P(ERR,U,4)'="":$P(ERR,U,3,4),1:$P(ERR,U,3))
 S I=$$TYPE(+ERR,.TYPE)
 ;---
 S EXIT=0  D
 . D EN^DDIOL($J(+ERR,4),,"!"),EN^DDIOL($E($P(ERR,U,2),1,IOM-7),,"?6")
 . I $Y'<ONCMNL  S EXIT=$$PAGE^ONCSAPIU()  Q:EXIT
 . ;---
 . I $G(ONC8INFO)'="",$D(@ONC8INFO)>1  S I=""  D
 ..;Error text formatting
 ..I ONC8INFO="ONCSAPI(""MSG"",1,1)" D
 ...N LINECNT,LINE,LINE1,LINE2,SUB
 ...S LINECNT=0
 ...S SUB=0 F  S SUB=$O(ONCSAPI("MSG","1",1,SUB)) Q:SUB'>0  S LINE=ONCSAPI("MSG","1",1,SUB) D
 ....S LINECNT=LINECNT+1
 ....S LINE1=$P(LINE,".",1)
 ....S LINE2=$P(LINE,".",2)
 ....S ONCSAPI("NEWMSG","1",1,LINECNT)=LINE1_"."
 ....I LINE2'="" S LINECNT=LINECNT+1 S ONCSAPI("NEWMSG","1",1,LINECNT)=LINE2_"."
 ...M ONCSAPI("MSG")=ONCSAPI("NEWMSG")
 . . F  S I=$O(@ONC8INFO@(I))  Q:I=""  D  Q:EXIT
 . . . D EN^DDIOL($E(@ONC8INFO@(I),1,IOM-7),,"!?6")
 . . . S:$Y'<ONCMNL EXIT=$$PAGE^ONCSAPIU()
 . Q:EXIT
 . ;---
 . D EN^DDIOL(TYPE,,"!?6"),EN^DDIOL(LOC,,"?22"):LOC'?.1"^"
 . I $Y'<ONCMNL  S EXIT=$$PAGE^ONCSAPIU()  Q:EXIT
 ;---
 D EN^DDIOL(" ")
 Q EXIT
 ;
 ;***** STORES THE MESSAGE INTO THE ERROR STACK
 ;
 ; ERROR         Error descriptor (see ^ONCSAPI)
 ;
 ; [ONC8INFO]    Closed root of the variable that contains
 ;               additional information related to the error
 ;
STORE(ERROR,ONC8INFO) ;
 Q:'$D(ONCSAPI("MSG"))!($G(ERROR)'<0)
 N IEN
 S IEN=$O(ONCSAPI("MSG"," "),-1)+1
 S ONCSAPI("MSG",IEN,0)=ERROR
 M:$G(ONC8INFO)'="" ONCSAPI("MSG",IEN,1)=@ONC8INFO
 S ONCSAPI("MSG","E",+ERROR,IEN)=""
 Q
 ;
 ;***** RETURNS TYPE OF THE MESSAGE
 ;
 ; ERRCODE       Error code
 ;
 ; [.DESCR]      Reference to a local variable where the type
 ;               description is returned to
 ;
TYPE(ERRCODE,DESCR) ;
 I ERRCODE'<0  S DESCR=""  Q 0
 N I,TYPE  S I=-ERRCODE
 S I=$P($T(MSGLIST+I),";;",2),TYPE=+$TR($P(I,U,2)," ")
 S:TYPE'>0 TYPE=6
 S DESCR=$P("Debug^Information^Data Quality^Warning^Database Error^Error",U,TYPE)
 Q TYPE
 ;
 ;***** LIST OF THE MESSAGES (THERE SHOULD BE NOTHING AFTER THE LIST!)
 ;
 ; The error codes are provided in the table only for clarity.
 ; Text of the messages are extracted using the $TEXT function and
 ; absolute values of the ERRCODE parameter.
 ;
 ; Message Type:
 ;               1  Debug          4  Warning
 ;               2  Information    5  Database Error
 ;               3  Data Quality   6  Error
 ;
MSGLIST ; Code Type  Message Text
 ;;  -1 ^ 6 ^ Missing input parameters
 ;;  -2 ^ 6 ^ Errors returned by the Oncology web-service
 ;;  -3 ^ 4 ^ XML parsing warning
 ;;  -4 ^ 6 ^ XML parsing error
 ;;  -5 ^ 6 ^ Error(s) during parsing of the result XML
 ;;  -6 ^ 6 ^ Parameter '|1|' has an invalid value: '|2|'
 ;;  -7 ^ 2 ^ Oncology web-service temporary moved to '|1|'
 ;;  -8 ^ 2 ^ Oncology web-service permanently moved to '|1|'
 ;;  -9 ^ 6 ^ FileMan DBS call error(s)|2|
 ;; -10 ^ 6 ^ HTTP client error(s)
 ;; -11 ^ 6 ^ Invalid URL of the Oncology web-service
 ;; -12 ^ 6 ^ Too many redirections (|1|)
 ;; -13 ^ 6 ^ Cannot get the CS version number
 ;; -14 ^ 6 ^ Cannot get the schema number and name
 ;; -15 ^ 6 ^ Cannot lock the |1|
 ;; -16 ^ 6 ^ Invalid combination of input parameters: |1|
 ;; -17 ^ 6 ^ Cannot update the Oncology web-service URL in file #160.1
 ;; -18 ^ 6 ^ Missing redirection URL
 ;; -19 ^ 2 ^ Unfortunately, the extended help is unavailable now.
 ;; -20 ^ 2 ^ Unfortunately, input value cannot be validated.
 ;; -21 ^ 2 ^ Unfortunately, the code description is unavailable now.
 ;; -22 ^ 6 ^ Cannot get the URL of the Oncology web-service
 ;; -23 ^ 6 ^ Cannot get the EDITS metafile version number
 ;
CLEANUP ;Cleanup
 K DIERR,ONCSAPI
