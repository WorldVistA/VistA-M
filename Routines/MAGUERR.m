MAGUERR ;WOIFO/SG - ERROR HANDLING UTILITIES ; 3/9/09 12:53pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; * Error codes are negative numbers.
 ;
 ; * The corresponding error messages are stored in the DIALOG file
 ;   (#.84). Dialog numbers are calculated as follows:
 ;
 ;         Dialog# = 20050000 - (ErrorCode / 1000).
 ;
 ;   For example, dialog number for the error code -9 is 20050000.009.
 ;
 ; * A message itself is stored in the second "^"-piece of the dialog
 ;   text line. The first piece determines the problem type:
 ;
 ;     I - Information. No actions are required.
 ;
 ;     W - Warning. There was a problem but the code was/will be
 ;         able to ignore/recover and continue. User input errors
 ;         have this type as well.
 ;
 ;     E - Error. The code encountered a major problem and could
 ;         not continue. Data, code, or both should be fixed!
 ;
 ; TEMPORARY ERROR STORAGE
 ; =======================
 ;
 ; ^TMP("MAG-ERRROR-STORAGE",$J,
 ;   Seq#,
 ;     0)                Error Descriptor (see the $$ERROR^MAGUERR)
 ;                         ^01: Error code
 ;                         ^02: Error message
 ;                         ^03: Error location (TAG~ROUTINE)
 ;                         ^04: Type ("W" - warning, "E" - error)
 ;     1,Seq#)           Error details text (optional)
 ;
 ; Information messages (the "I" type) are never stored regardless
 ; of the mode set by the CLEAR^MAGUERR.
 ;
 Q
 ;
 ;##### INITIALIZES THE ERROR STORAGE
 ;
 ; [ENABLE]      Enable/disable error storage (0|1). If the storage
 ;               enabled, the $$ERROR function stores the error
 ;               descriptors there. Otherwise, only the latest
 ;               error descriptor is accessible (the result value
 ;               of the $$ERROR or $$DBS functions).
 ;
 ; This procedure also clears the error storage (regardless of the
 ; value of the ENABLE parameter).
 ;
CLEAR(ENABLE) ;
 S:'($D(ENABLE)#10) ENABLE=$D(^TMP("MAG-ERRROR-STORAGE",$J))#10
 K ^TMP("MAG-ERRROR-STORAGE",$J)
 S:ENABLE ^TMP("MAG-ERRROR-STORAGE",$J)=""
 D CLEAN^DILF
 Q
 ;
 ;##### CHECKS THE ERRORS AFTER A FILEMAN DBS CALL
 ;
 ; MAG8MSG       Closed reference of the error message array
 ;               (from a DBS call). If this parameter is empty,
 ;               then the ^TMP("DIERR",$J) is assumed.
 ;
 ; [FILE]        File number used in the DBS call.
 ; [IENS]        IENS used in the DBS call.
 ;
 ; This function checks the DIERR and @MAG8MSG variables after
 ; a FileMan DBS call and returns the error descriptor in case of
 ; error(s).
 ; 
 ; Return Values
 ; =============
 ;           <0  -9^Message text^Error location^Message type
 ;            0  No errors
 ;
 ; Notes
 ; =====
 ;
 ; If the error storage is enabled (see the CLEAR^MAGUERR), the
 ; messages returned by the FileMan call are recorded along with
 ; the error descriptor.  Otherwise, they are discarded.
 ; 
 ; This entry point can also be called as a procedure:
 ; D DBS^MAGUERR(...) if you do not need its return value.
 ;
DBS(MAG8MSG,FILE,IENS) ;
 I '$G(DIERR)  Q:$QUIT 0  Q
 N MSGTEXT,TMP
 ;--- Format the FileMan error messages
 D MSG^DIALOG("AE",.MSGTEXT,,,$G(MAG8MSG)),CLEAN^DILF
 ;--- Record the error message
 S TMP=$S($G(FILE):"; File #"_FILE,1:"")
 S:$G(IENS)'="" TMP=TMP_"; IENS: """_IENS_""""
 S TMP=$$ERROR(-9,.MSGTEXT,TMP)
 Q:$QUIT TMP  Q
 ;
 ;##### GENERATES THE ERROR MESSAGE
 ;
 ; ERRCODE       Error code (negative number).
 ;
 ;               If the error code has the 'S' suffix (e.g. "-3S"),
 ;               then the error info is NOT stored regardless of the
 ;               storage mode set by the CLEAR^MAGUERR.
 ;
 ; [[.]MAGINFO]  Optional additional information: either a string or
 ;               a reference to a local array that contains strings
 ;               prepared for storage in a word processing field
 ;               (first level nodes; no 0-nodes).
 ;
 ; [ARG1-ARG5]   Optional parameters for $$MSG^MAGUERR.
 ;
 ; Return Values
 ; =============
 ;           <0  Error code^Message text^Error location^Message type
 ;            0  Ok (if ERRCODE'<0)
 ;
 ; Notes
 ; =====
 ;
 ; "^" is replaced with "~" in the error location stored in the 3rd
 ; piece of the error descriptor.
 ;
 ; If error storage is enabled by the CLEAR^MAGUERR and type is other 
 ; than information (I), then this procedure saves the message info
 ; to the temporary error storage.
 ;
 ; This entry point can also be called as a procedure:
 ; D ERROR^MAGUERR(...) if you do not need its return value.
 ;
ERROR(ERRCODE,MAGINFO,ARG1,ARG2,ARG3,ARG4,ARG5) ;
 I ERRCODE'<0  Q:$QUIT 0  Q
 N MSG,PLACE,SL,TYPE
 ;--- Get the error location
 S SL=$STACK(-1)-1,PLACE=""
 F  Q:SL'>0  D  Q:'(PLACE[$T(+0))  S SL=SL-1
 . S PLACE=$P($STACK(SL,"PLACE")," ")
 . Q
 ;--- Prepare the additional information
 I $D(MAGINFO)=1  S MSG=MAGINFO  K MAGINFO  S MAGINFO(1)=MSG
 ;--- Prepare the message descriptor
 S MSG=$$MSG(+ERRCODE,.TYPE,.ARG1,.ARG2,.ARG3,.ARG4,.ARG5)
 S MSG=(+ERRCODE)_U_MSG_U_$TR(PLACE,U,"~")_U_TYPE
 ;--- Store the error info
 I TYPE'="I",ERRCODE'["S"  D STORE(MSG,.MAGINFO)
 ;---
 Q:$QUIT MSG  Q
 ;
 ;##### GENERATES THE 'INVALID PARAMETER VALUE' ERROR
 ;
 ; MAG8NAME      Closed reference to the variable/node
 ;
 ; [DSPNAME]     Display name of the parameter. If this parameter is
 ;               defined and not empty, its value is used as the
 ;               parameter name in the error message (instead of the
 ;               name passed in the MAG8NAME parameter).
 ;
 ; Return Values
 ; =============
 ;               -3^Message text^Error location^Message type
 ;
 ; Notes
 ; =====
 ;
 ; This entry point can also be called as a procedure:
 ; D IPVE^MAGUERR(...) if you do not need its return value.
 ;
IPVE(MAG8NAME,DSPNAME) ;
 N MAG8RC
 S MAG8RC=$S($D(@MAG8NAME)#2:"'"_@MAG8NAME_"'",1:"<UNDEFINED>")
 S MAG8RC=$$ERROR(-3,,$S($G(DSPNAME)'="":DSPNAME,1:MAG8NAME),MAG8RC)
 Q:$QUIT MAG8RC  Q
 ;
 ;##### RETURNS THE TEXT AND TYPE OF THE MESSAGE
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
 ; Return Values
 ; =============
 ;               Text of the error message
 ;
 ; Notes
 ; =====
 ;
 ; The "^" is replaced with the "~" in the message text.
 ;
MSG(ERRCODE,TYPE,ARG1,ARG2,ARG3,ARG4,ARG5) ;
 Q:ERRCODE'<0 ""
 N ARG,I1,I2,MSG
 ;--- Get a descriptor of the message
 S MSG=$$EZBLD^DIALOG(20050000-(ERRCODE/1000))
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
 . Q
 Q $TR($$TRIM^XLFSTR(MSG),U,"~")
 ;
 ;##### ASSIGNS THE DEFAULT ERROR HANDLER
 ;
 ; [RCVNAME]     Name of a variable for the error code
 ;
 ;               See the RTEHNDLR^MAGUERR1 for more details and the
 ;               SETPROPS^MAGGA02 for a usage example.
 ;
SETDEFEH(RCVNAME) ;
 S $ECODE=""
 S $ETRAP="D RTEHNDLR^MAGUERR1("_$$DDQ^MAGUTL05($G(RCVNAME))_")"
 Q
 ;
 ;##### STORES THE ERROR INFO
 ;
 ; ERROR         Error descriptor
 ;
 ; [.MAGINFO]    Reference to a local array with additional
 ;               information
 ;
STORE(ERROR,MAGINFO) ;
 Q:'$D(^TMP("MAG-ERRROR-STORAGE",$J))
 N IEN
 S IEN=$O(^TMP("MAG-ERRROR-STORAGE",$J," "),-1)+1
 S ^TMP("MAG-ERRROR-STORAGE",$J,IEN,0)=ERROR
 M ^TMP("MAG-ERRROR-STORAGE",$J,IEN,1)=MAGINFO
 Q
