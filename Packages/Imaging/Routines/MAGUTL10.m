MAGUTL10 ;WOIFO/SG - UTILITIES FOR REASONS ; 5/4/09 11:54am
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
 ;##### RETURNS THE REASON PROPERTIES
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
 ; [.DESCR]      Reference to a local array where the description is
 ;               returned if the F flag is provided.
 ; 
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;           >0  Reason summary
 ;                 ^01: IEN of the reason in file #2005.88
 ;                 ^02: Text of the reason
 ;                 ^03: Types of the reason (combination of
 ;                      "C", "D", "P", and/or "S")
 ;                 ^04: Date of inactivation (FileMan)
 ;                 ^05: Unique code of the reason
 ;
GETRSN(RSNID,FLAGS,DESCR) ;
 N FLDS,I,IEN,IENS,IRES,MAGBUF,MAGMSG,RC,REASON
 D CLEAR^MAGUERR(1)
 S RC=0,REASON=""  K DESCR
 ;
 ;=== Validate parameters
 S FLAGS=$G(FLAGS)
 ;--- Check for invalid flag(s)
 Q:$TR(FLAGS,"CF")'="" $$IPVE^MAGUERR("FLAGS")
 ;--- Validate the reason identifier
 I FLAGS["C"  D  Q:RC<0 RC
 . S IEN=$$FIND1^DIC(2005.88,,"X",RSNID,"C",,"MAGMSG")
 . I $G(DIERR)  S RC=$$DBS^MAGUERR("MAGMSG",2005.88)  Q
 . I IEN'>0  S RC=$$ERROR^MAGUERR(-49,,RSNID)  Q
 . Q
 E  S IEN=RSNID  Q:(IEN'>0)!(+IEN'=IEN) $$IPVE^MAGUERR("RSNID")
 S IENS=IEN_","
 ;
 ;=== Load the data
 S FLDS=".01;.02;.03;.04"_$S(FLAGS["F":";1",1:"")
 D GETS^DIQ(2005.88,IENS,FLDS,"EI","MAGBUF","MAGMSG")
 Q:$G(DIERR) $$DBS^MAGUERR("MAGMSG",2005.88,IENS)
 ;
 ;=== Compile the reason summary
 S REASON=IEN_U_MAGBUF(2005.88,IENS,.01,"E")
 S $P(REASON,U,3)=$G(MAGBUF(2005.88,IENS,.02,"I"))
 S $P(REASON,U,4)=$G(MAGBUF(2005.88,IENS,.03,"I"))
 S $P(REASON,U,5)=$G(MAGBUF(2005.88,IENS,.04,"I"))
 ;
 ;=== Copy the description to the output parameter
 I FLAGS["F"  M DESCR=MAGBUF(2005.88,IENS,1)  K DESCR("E"),DESCR("I")
 ;
 ;=== Success
 Q REASON
