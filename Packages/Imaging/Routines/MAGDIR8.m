MAGDIR8 ;WOIFO/PMK - Read a DICOM image file ; 08 Feb 2008 11:27 AM
 ;;3.0;IMAGING;**11,51,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; M2MB server
 ;
 ; This routine is invoked by the M2M Broker RPC to process an image.
 ; It extracts each item from the REQUEST list and transfers control
 ; to the appropriate routine to process it.  These routines, in turn,
 ; add items to the RESULT list for processing back on the gateway.
 ;
ENTRY(RESULT,REQUEST) ; RPC = MAG DICOM IMAGE PROCESSING
 N ARGS ; ---- argument string of the REQUEST item
 N DATETIME ;- fileman date/time of the study
 N DCMPID ;--- DICOM patient id
 N DFN ;------ VistA's internal patient identifier
 N ERRCODE ;-- code for an error, if encountered
 N IREQUEST ;- pointer to item in REQUEST array
 N MSG ; ----- error message array
 N OPCODE ;--- operation code of the REQUEST item
 N RETURN ;--- intermediate return code
 ;
 ; pass the request list and determine what has to be done
 F IREQUEST=2:1:$G(REQUEST(1)) D
 . S OPCODE=$P(REQUEST(IREQUEST),"|")
 . S ARGS=$P(REQUEST(IREQUEST),"|",2,999)
 . I OPCODE="STORE1"          D ENTRY^MAGDIR81     Q
 . I OPCODE="ACQUIRED"        D ACQUIRED^MAGDIR82  Q
 . I OPCODE="PROCESSED"       D POSTPROC^MAGDIR82  Q
 . I OPCODE="CORRECT"         D ENTRY^MAGDIR83     Q
 . I OPCODE="PATIENT SAFETY"  D ENTRY^MAGDIR84     Q
 . I OPCODE="ROLLBACK"        D ENTRY^MAGDIR85     Q
 . I OPCODE="CRASH"           D                    Q
 . . S I=1/0 ; generate an error on the server to test error trapping
 . . Q
 . Q
 Q
 ;
ERROR(OPCODE,ERRCODE,MSG,ROUTINE) ; build the RESULT array for the error
 ; this must be called after ^MAGDIRVE is invoked to put the message
 ; into the RESULT array - otherwise the message will be lost
 N I,OK,X
 S X=ERRCODE_"|"_$G(MSG("TITLE"))_"|"_ROUTINE_"|"_$G(MSG("CRITICAL"))
 D RESULT^MAGDIR8(OPCODE,X)
 S OK=0,I="" F  S I=$O(MSG(I)) Q:'I  D
 . I MSG(I)?1"Problem detected by routine".E  D
 . . ; add error code to the message
 . . S MSG(I)=MSG(I)_"  Error Code: "_ERRCODE
 . . Q
 . S OK=1 D RESULT^MAGDIR8("MSG","|"_MSG(I))
 . Q
 D:'OK RESULT^MAGDIR8("MSG","|--no details specified--")
 S $P(RESULT(RESULT(1)),"|",2)="END"
 Q
 ;
RESULT(OPCODE,ARGS) ; add an item to the RESULT list
 S RESULT(1)=$G(RESULT(1),1)+1 ; first element in array is counter
 S RESULT(RESULT(1))=OPCODE_"|"_ARGS
 Q
