MAGNU002 ;WOIFO/NST - Utilities for RPC calls ; 02 May 2017 4:16 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;
OK() Q 0   ; Success status
 ;
FAILED() Q -1   ; Failure status
 ;
RESDEL() Q "^"  ; Result delimiter
 ;
RESDATA() Q 3  ; Returns the piece number where the result data value is stored in MAGRY
 ;
ISOK(MAGRY) ; Returns 0 (failed) or 1 (success): Checks if first piece of MAGRY is success
 Q +MAGRY=$$OK()
 ;
GETVAL(MAGRY) ; Returns data value in MAGRY
 Q $P(MAGRY,$$RESDEL(),$$RESDATA())
 ;
SETVAL(MAGRY,VAL) ; set VAL in RY data piece
 S $P(MAGRY,$$RESDEL(),$$RESDATA())=VAL
 Q
 ;
SETOKVAL(VAL) ; set OK result and value
 N RY
 S RY=$$OK()
 D SETVAL(.RY,VAL)
 Q RY
 ;
SETERROR(VAL) ; set Error result and value
 Q $$FAILED()_$$RESDEL()_VAL
 ;
 ;
 ; Input Parameters
 ; ================
 ;  MSG = VA FileMan error array 
 ;  
 ; Return Values
 ; =============
 ; MAGRY(0) = Success status
 ; MAGRY(0) = Failure status^Error Message
 ;
 ; Return 1 = error in MSG array
 ;        0 = no error in MSG array
ISERROR(MAGRY,MSG)   ; Check for error message
 I '$D(MSG("DIERR")) S MAGRY(0)=$$OK() Q 0  ; No error
 ;
 N MAGRESA
 D MSG^DIALOG("A",.MAGRESA,245,5,"MSG")
 S MAGRY(0)=$$SETERROR(MAGRESA(1))
 Q 1
