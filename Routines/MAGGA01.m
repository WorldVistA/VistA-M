MAGGA01 ;WOIFO/SG - REMOTE PROCEDURES FOR REASONS ; 5/13/09 10:12am
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
 ;+++++ APPENDS THE REASONS TO THE RESULT ARRAY
 ;
 ; RESULTS       Closed reference to the RPC result buffer.
 ;
 ; .MAGBUF       Reference to a local array with records of the
 ;               MAG REASON file (#2005.88) loaded by the LIST^DIC.
 ;
 ; FLAGS         Flags that control execution.
 ; 
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;
 ; Notes
 ; =====
 ;
 ; This is an internal entry point. Do not call it from outside of
 ; this routine.
 ;
APNDRSNS(RESULTS,MAGBUF,FLAGS) ;
 N I,IENS,IMB,IRES,MAGTXT,RC
 S RC=0,IRES=+$O(@RESULTS@(" "),-1)
 ;---
 S IMB=0
 F  S IMB=$O(MAGBUF("DILIST",IMB))  Q:IMB'>0  D  Q:RC<0
 . S IRES=IRES+1,@RESULTS@(IRES)=MAGBUF("DILIST",IMB,0)
 . ;--- Check if full details are requested
 . Q:FLAGS'["F"
 . ;--- Load the description
 . K MAGTXT  S IENS=$P(MAGBUF("DILIST",IMB,0),U)_","
 . D GETS^DIQ(2005.88,IENS,"1",,"MAGTXT","MAGMSG")
 . I $G(DIERR)  S RC=$$DBS^MAGUERR("MAGMSG",2005.88,IENS)  Q
 . ;--- Append the description to the result array
 . S I=0
 . F  S I=$O(MAGTXT(2005.88,IENS,1,I))  Q:I'>0  D
 . . S IRES=IRES+1,@RESULTS@(IRES)="D"_U_MAGTXT(2005.88,IENS,1,I)
 . . Q
 . Q
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS THE REASON PROPERTIES
 ; RPC: MAGG REASON GET PROPERTIES
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; RSNID         Identifier of the reason: Internal Entry Number of
 ;               the record in the MAG REASON file (#2005.88) or the
 ;               reason code (see the FLAGS parameter).
 ;
 ; [FLAGS]       Flags that control execution (can be combined):
 ;
 ;                 C  By default, value of the RSNID parameter is
 ;                    treated as the reason IEN. If this flag is
 ;                    provided, then the reason code should be passed 
 ;                    as the value of the RSNID.
 ;
 ;                 F  Include full details (description text).
 ;                    By default, only the summary data is returned.
 ; 
 ; Return Values
 ; =============
 ;
 ; Zero value of the first '^'-piece of the RESULTS(0) indicates
 ; that an error occurred during the execution of the procedure.
 ; In this case, the RESULTS array is formatted as described in the
 ; comments to the RPCERRS^MAGUERR1 procedure.
 ;  
 ; Otherwise, the RESULTS(0) contains '1^OK' and the reason summary
 ; and description are returned in the subsequent elements of the
 ; RESULTS array as follows:
 ;  
 ; RESULTS(1)            Reason summary
 ;                         ^01: IEN of the reason in file #2005.88
 ;                         ^02: Text of the reason
 ;                         ^03: Types of the reason (combination of
 ;                              "C", "D", "P", and/or "S")
 ;                         ^04: Date of inactivation (FileMan)
 ;                         ^05: Unique code of the reason
 ;   
 ; RESULTS(1+i)          Line of the description of the reason
 ;                         ^01: "D"
 ;                         ^02: Text line
 ;  
 ;                       The description text is returned only if the
 ;                       value of the FLAGS parameter contains "F" and
 ;                       the DESCRIPTION field (1) of the MAG REASON
 ;                       file (#2005.88) is not empty.
 ;
GET(RESULTS,RSNID,FLAGS) ;RPC [MAGG REASON GET PROPERTIES]
 N RC  K RESULTS
 S RESULTS(0)="1^Ok",RC=0
 D CLEAR^MAGUERR(1)
 ;
 D
 . N DESCR,I,REASON
 . S REASON=$$GETRSN^MAGUTL10(RSNID,$G(FLAGS),.DESCR)
 . I REASON<0  S RC=REASON  Q
 . ;
 . ;--- Append the summary to the result array
 . S IRES=1,RESULTS(IRES)=REASON
 . Q:FLAGS'["F"
 . ;
 . ;--- Append the description to the result array
 . S I=0
 . F  S I=$O(DESCR(I))  Q:I'>0  D
 . . S IRES=IRES+1,RESULTS(IRES)="D"_U_DESCR(I)
 . . Q
 . Q
 ;
 ;=== Error handling and cleanup
 D:RC<0 RPCERRS^MAGUERR1(.RESULTS,RC)
 Q
 ;
 ;***** RETURNS THE LIST OF REASONS
 ; RPC: MAGG REASON LIST
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; MAGTYPE       Type(s) of returned reasons (can be combined):
 ;
 ;                 C  Reasons for copying images
 ;                 D  Reasons for deleting images
 ;                 P  Reasons for printing images
 ;                 S  Reasons for changing image status
 ;
 ; [FLAGS]       Flags that control execution (can be combined):
 ;
 ;                 F  Include full details (description text, etc.)
 ;                 I  Include inactivated reasons
 ;
 ;               By default ($G(FLAGS)=""), only the summary data
 ;               for currently active reasons is returned.
 ;
 ; [PART]        The partial match restriction (case sensitive).
 ;               For example, a PART value of "ZZ" would restrict
 ;               the list to those entries starting with the
 ;               letters "ZZ".
 ;
 ;               By default ($G(PART)=""), no text restrictions are
 ;               applied.
 ; 
 ; Return Values
 ; =============
 ;
 ; Zero value of the first '^'-piece of the @RESULTS@(0) indicates
 ; that an error occurred during the execution of the procedure.
 ; In this case, the @RESULTS array is formatted as described in the
 ; comments to the RPCERRS^MAGUERR1 procedure.
 ;  
 ; Otherwise, the @RESULTS@(0) contains '1^OK' and the list of reasons
 ; is returned in the subsequent elements of the @RESULTS array as
 ; follows:
 ;  
 ; @RESULTS@(i)          Reason summary
 ;                         ^01: IEN of the reason in file #2005.88
 ;                         ^02: Text of the reason
 ;                         ^03: Types of the reason (combination of
 ;                              "C", "D", "P", and/or "S")
 ;                         ^04: Date of inactivation (FileMan).
 ;                              This piece is always empty if the
 ;                              value of the FLAGS parameter does not
 ;                              contain "I". Otherwise, a date in
 ;                              internal FileMan format is returned
 ;                              here for inactivated reasons.
 ;                         ^05: Unique code of the reason
 ;   
 ; @RESULTS@(i+j)        Line of the description of the reason
 ;                         ^01: "D"
 ;                         ^02: Text line
 ;  
 ;                       The description text is returned only if the
 ;                       value of the FLAGS parameter contains "F" and
 ;                       the DESCRIPTION field (1) of the MAG REASON
 ;                       file (#2005.88) is not empty.
 ;
 ; The reasons are sorted alphabetically (case sensitive).
 ;
 ; Notes
 ; =====
 ;
 ; The ^TMP($J,"MAGGA01") global node is used by this procedure.
 ;
LSTRSNS(RESULTS,MAGTYPE,FLAGS,PART) ;RPC [MAGG REASON LIST]
 N RC
 D CLEAR^MAGUERR(1)
 S DT=$$DT^XLFDT  ; Ensure the current date value
 S RC=0
 ;
 ;=== Initialize the result array
 K RESULTS   S RESULTS=$NA(^TMP("MAGGA01",$J))
 K @RESULTS  S @RESULTS@(0)="1^Ok"
 ;
 D
 . N FLDS,MAGBUF,MAGMSG,SCR
 . ;=== Validate parameters
 . S FLAGS=$G(FLAGS),PART=$G(PART)
 . ;--- Type is not defined
 . I $G(MAGTYPE)=""  S RC=$$ERROR^MAGUERR(-8,,"MAGTYPE")  Q
 . ;--- Invalid type code(s)
 . I $TR(MAGTYPE,"CDPS")'=""  S RC=$$IPVE^MAGUERR("MAGTYPE")  Q
 . ;--- Invalid flag(s)
 . I $TR(FLAGS,"FI")'=""  S RC=$$IPVE^MAGUERR("FLAGS")  Q
 . ;
 . ;=== Prepare the search parameters
 . S FLDS="@;.01;.02I;.03I;.04"
 . S SCR="N MAG0 S MAG0=$G(^(0)) I $TR(MAGTYPE,$P(MAG0,U,2))'=MAGTYPE"
 . S:FLAGS'["I" SCR=SCR_",($P(MAG0,U,3)'>0)!($P(MAG0,U,3)>DT)"
 . ;
 . ;=== Search for reasons
 . D LIST^DIC(2005.88,,FLDS,"P",,,PART,"B",SCR,,"MAGBUF","MAGMSG")
 . I $G(DIERR)  S RC=$$DBS^MAGUERR("MAGMSG",2005.88)  Q
 . Q:$G(MAGBUF("DILIST",0))'>0  ; Nothing has been found
 . ;
 . ;--- Append the reasons to the result array
 . S RC=$$APNDRSNS(RESULTS,.MAGBUF,FLAGS)
 . Q
 ;
 ;=== Error handling and cleanup
 D:RC<0 RPCERRS^MAGUERR1(.RESULTS,RC)
 Q
