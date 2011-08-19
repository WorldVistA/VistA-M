ONCXERR ;HCIOFO/SG - HTTP AND WEB SERVICES (ERRORS)  ; 6/21/04 2:35pm
 ;;2.11;ONCOLOGY;**40**;Mar 07, 1995
 ;
 Q
 ;
 ;***** GENERATES THE ERROR MESSAGE
 ;
 ; ERRCODE       Error code
 ;
 ; [[.]INFO]     reserved
 ;
 ; [ARG1-ARG5]   Optional parameters as for $$MSG^ONCXERR
 ;
 ; Return Values:
 ;       <0  Error code^Message Text^Label+Offset^Routine
 ;        0  Ok (if ERRCOCE'<0)
 ;
ERROR(ERRCODE,INFO,ARG1,ARG2,ARG3,ARG4,ARG5) ;
 Q:ERRCODE'<0 0
 N PLACE,SL
 S SL=$STACK(-1)-1
 F  Q:SL'>0  D  Q:'(PLACE["^ONCXERR")  S SL=SL-1
 . S PLACE=$P($STACK(SL,"PLACE")," ")
 S:PLACE'[U PLACE=U
 Q ERRCODE_U_$$MSG(ERRCODE,,.ARG1,.ARG2,.ARG3,.ARG4,.ARG5)_U_PLACE
 ;
 ;***** RETURNS THE TEXT OF THE MESSAGE
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
 ;***** RETURNS TYPE OF THE MESSAGE
 ;
 ; ERRCODE       Error code
 ;
TYPE(ERRCODE) ;
 Q:ERRCODE'<0 0
 N I,TYPE  S I=-ERRCODE
 S I=$P($T(MSGLIST+I),";;",2),TYPE=+$TR($P(I,U,2)," ")
 Q $S(TYPE>0:TYPE,1:6)
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
 ;;  -1 ^ 6 ^ Missing host name: '|1|'
 ;;  -2 ^ 6 ^ Cannot resolve the host name: '|1|'
 ;;  -3 ^ 6 ^ Cannot connect to host(s): '|1|'
 ;;  -4 ^ 6 ^ Missing redirection URL
 ;;  -5 ^ 6 ^ Too many redirections
 ;;  -6 ^ 6 ^ Error during transaction (see Error Trap log)
 ;;  -7 ^ 6 ^ Timeout
