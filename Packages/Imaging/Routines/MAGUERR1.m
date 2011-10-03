MAGUERR1 ;WOIFO/SG - ERROR HANDLING UTILITIES ; 3/9/09 12:53pm
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
 Q
 ;
 ;***** PRINTS THE DUMP OF THE ERROR STORAGE
DUMP() ;
 Q:$D(^TMP("MAG-ERRROR-STORAGE",$J))<10
 N EPTR,I,NODE,TMP
 S NODE=$NA(^TMP("MAG-ERRROR-STORAGE",$J))
 ;=== Print the header
 D DUMPL("Code  Message Text",1)
 D DUMPL("      Additional info")
 ;=== Print the errors
 S EPTR=""
 F  S EPTR=$O(@NODE@(EPTR))  Q:EPTR=""  D
 . ;--- Print the error descriptor
 . S TMP=@NODE@(EPTR,0)
 . D DUMPL($J(+TMP,4)_"  "_$P(TMP,U,2),1)
 . S TMP=$P(TMP,U,3)
 . D:TMP'="" DUMPL("      Location: "_TMP)
 . ;--- Print the optional text
 . S I=""
 . F  S I=$O(@NODE@(EPTR,1,I))  Q:I=""  D
 . . D DUMPL("      "_@NODE@(EPTR,1,I))
 . . Q
 . Q
 ;===
 Q
 ;
DUMPL(MSG,SKIP) ;
 I '$D(XPDNM)  W:$G(SKIP) !  W MSG,!  Q
 I $G(SKIP)  D BMES^XPDUTL(MSG)  Q
 D MES^XPDUTL(MSG)
 Q
 ;
 ;##### RETURNS A LIST OF ERROR CODES FROM THE ERROR STORAGE
 ;
 ; [ENCLOSE]     Enclose the list in commas.
 ;
 ; Return Values
 ; =============
 ;           ""  No errors
 ;          ...  List of error codes (in reverse chronological
 ;               order) separated by commas.
 ;
ERRLST(ENCLOSE) ;
 N I,LST
 S I=" ",LST=""
 F  S I=$O(^TMP("MAG-ERRROR-STORAGE",$J,I),-1)  Q:I'>0  D
 . S LST=LST_","_$P(^TMP("MAG-ERRROR-STORAGE",$J,I,0),U)
 . Q
 Q $S(LST="":"",$G(ENCLOSE):LST_",",1:$P(LST,",",2,9999))
 ;
 ;##### RETURNS DESCRIPTOR OF THE FIRST ERROR FROM THE ERROR STORAGE
 ;
 ; [.INFO]       Reference to a local array where additional text
 ;               associated with the error message is returned to
 ;               (first level nodes; no 0-nodes). If there is no
 ;               such text, this parameter will be undefined after
 ;               the call.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;           ""  Error storage is empty or it has not been
 ;               enabled (see the CLEAR^MAGUERR)
 ;
FIRSTERR(INFO) ;
 N I  K INFO
 S I=$O(^TMP("MAG-ERRROR-STORAGE",$J,0))  Q:I'>0 ""
 M INFO=^TMP("MAG-ERRROR-STORAGE",$J,I,1)
 Q $G(^TMP("MAG-ERRROR-STORAGE",$J,I,0))
 ;
 ;##### RETURNS DESCRIPTOR OF THE LAST ERROR FROM THE ERROR STORAGE
 ;
 ; [.INFO]       Reference to a local array where additional text
 ;               associated with the error message is returned to
 ;               (first level nodes; no 0-nodes). If there is no
 ;               such text, this parameter will be undefined after
 ;               the call.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;           ""  Error storage is empty or it has not been
 ;               enabled (see the CLEAR^MAGUERR)
 ;
LASTERR(INFO) ;
 N I  K INFO
 S I=$O(^TMP("MAG-ERRROR-STORAGE",$J," "),-1)  Q:I'>0 ""
 M INFO=^TMP("MAG-ERRROR-STORAGE",$J,I,1)
 Q $G(^TMP("MAG-ERRROR-STORAGE",$J,I,0))
 ;
 ;##### RETURNS ERRORS FROM A REMOTE PROCEDURE
 ;
 ; .RESULTS      Reference to the first parameter (RPC result) of the
 ;               entry point that implements the remote procedure.
 ;
 ;               If the type of the remote procedure result is GLOBAL 
 ;               ARRAY or GLOBAL INSTANCE and the RESULTS stores a
 ;               valid name of a node in the ^TMP global, then errors 
 ;               are returned "under" this node.
 ;
 ;               Otherwise, the RPC result type is changed to ARRAY
 ;               and errors are returned in the RESULTS array.
 ;
 ; [ERR]         Error descriptor of the main problem (from the RPC's
 ;               point of view ;-). Only the 2nd piece is used: the
 ;               message is returned as the 2nd piece of the result
 ;               descriptor (for compatibility with the old code).
 ;               By default, a generic message is used.
 ;
 ; Return Values
 ; =============
 ;
 ;   @MAG8RES@(0)        Result descriptor
 ;                         ^01: 0
 ;                         ^02: Message (2nd piece of the ERR)
 ;
 ;   @MAG8RES@(i)        Error descriptor (see the $$ERROR^MAGUERR)
 ;                         ^01: Error code
 ;                         ^02: Message
 ;                         ^03: Error location
 ;                         ^04: Message type
 ;
 ;   @MAG8RES@(j)        Line of the additional info
 ;                         ^01: ""
 ;                         ^02: Text
 ;
 ; The MAG8RES value is either the value of the RESULTS parameter
 ; (global node) or the parameter's name ("RESULTS").
 ;
 ; Error descriptors are returned in reverse chronological order
 ; (most recent first).
 ; 
 ; Notes
 ; =====
 ;
 ; In order to use this functionality, the error storage must be
 ; enabled and initialized in the beginning of the code that
 ; implements the remote procedure (see the CLEAR^MAGUERR). See the
 ; MAGGA0* routines for usage examples.
 ;
RPCERRS(RESULTS,ERR) ;
 N CNT,EPTR,I,MAGLOBAL,MAG8RES,TMP
 ;=== Re-initialize the result array
 D:$G(RESULTS)?1"^TMP("1.E1")"
 . N $ESTACK,$ETRAP
 . S $ETRAP="S (MAG8RES,$ECODE)="""""
 . ;--- Check if the node name is valid
 . S MAG8RES=$NA(@RESULTS)
 . Q
 I $G(MAG8RES)=""  D  S MAG8RES="RESULTS"
 . ;--- Change type of the RPC result
 . S TMP=$$RTRNFMT^XWBLIB("ARRAY",1)
 . Q
 ;--- Clear the buffer
 K @MAG8RES
 ;
 ;=== Format the result descriptor (backward compatible)
 S TMP=$$TRIM^XLFSTR($P($G(ERR),U,2))
 S @MAG8RES@(0)="0"_U_$S(TMP'="":TMP,1:"RPC encountered error(s).")
 Q:$D(^TMP("MAG-ERRROR-STORAGE",$J))<10
 ;
 ;=== Get errors from the temporary storage
 S EPTR="",CNT=0
 F  S EPTR=$O(^TMP("MAG-ERRROR-STORAGE",$J,EPTR),-1)  Q:EPTR=""  D
 . S TMP=$G(^TMP("MAG-ERRROR-STORAGE",$J,EPTR,0))  Q:'TMP
 . S CNT=CNT+1,@MAG8RES@(CNT)=TMP
 . S I=0
 . F  S I=$O(^TMP("MAG-ERRROR-STORAGE",$J,EPTR,1,I))  Q:I'>0  D
 . . S CNT=CNT+1
 . . S $P(@MAG8RES@(CNT),U,2)=^TMP("MAG-ERRROR-STORAGE",$J,EPTR,1,I)
 . . Q
 . Q
 ;
 ;=== Cleanup
 D CLEAR^MAGUERR(0)   ; Error storage
 K ^TMP("DILIST",$J)  ; Default FileMan buffer
 Q
 ;
 ;+++++ DEFAULT RUN-TIME ERROR HANDLER
 ;
 ; MAGZZRCV      Name of a variable that the error descriptor
 ;               (-20) is assigned to.
 ;
RTEHNDLR(MAGZZRCV) ;
 N MAGZZERR,MAGZZRC
 ;--- Record the error
 S MAGZZERR=$$EC^%ZOSV  D ^%ZTER  S $ECODE=""
 S MAGZZRC=$$ERROR^MAGUERR(-20,,MAGZZERR)
 ;--- Unwind the stack and assign/return the error descriptor
 S $ETRAP="S:$ESTACK'>0 $ECODE="""""
 S:MAGZZRCV'="" $ETRAP=$ETRAP_","_MAGZZRCV_"="_$$DDQ^MAGUTL05(MAGZZRC)
 S $ETRAP=$ETRAP_" Q:$QUIT "_$$DDQ^MAGUTL05(MAGZZRC)_" Q"
 S $ECODE=",U1,"
 Q:$QUIT MAGZZRC  Q
