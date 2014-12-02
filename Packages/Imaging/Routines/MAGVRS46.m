MAGVRS46 ;WOIFO/DAC,MLH,NST - Utilities for RPC calls for DICOM file processing ; 29 Feb 2012 5:21 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ;  Called by MAGVRS41
 ;
 ;+++++  Add multi-keys to KEYFLD array
 ; Input Parameters
 ; ================
 ;  
 ;   FILE    - VA FileMan file number ( e.g. 2005.6)
 ;  .ATTNAMS - Array with field names and values
 ;  .KEYFLD  - Array with key field and values 
 ; 
 ; Return values
 ; =============
 ; 
 ; if error found during execution
 ;   OUT(1) = Negative number ` Error message
 ; if success
 ;    OUT(1)  is not set
 ;
ADDMKEYS(OUT,FILE,ATTNAMS,KEYFLD)  ; Set multi-keys
 N FIELD,NAM,VAL
 N SSEP
 S SSEP=$$STATSEP^MAGVRS41
 ; Add multi-keys for Patient and Procedure reference
 I (FILE=2005.6)!(FILE=2005.61) D
 . S FIELD=.01
 . F  S FIELD=$O(^DD(FILE,FIELD)) Q:(FIELD'>0)!(FIELD'<.05)  D  Q:$D(OUT(1))  ; Private IA (#5551)
 . . S NAM=$$GET1^DID(FILE,FIELD,,"LABEL")
 . . I '$D(ATTNAMS(NAM)) S OUT(1)="-61"_SSEP_"Expected attribute "_NAM_" not found" Q
 . . S KEYFLD(FIELD)=ATTNAMS(NAM)
 . . S KEYFLD(FIELD,"GSL")=$$GET1^DID(FILE,FIELD,,"GLOBAL SUBSCRIPT LOCATION")
 . . Q
 . Q:$D(OUT(1))
 . ; Resolve Creating Entity value
 . I '$D(ATTNAMS("CREATING ENTITY")) S OUT(1)="-62"_SSEP_"Expected attribute CREATING ENTITY not found" Q 
 . D SERVINST^MAGVRS44(ATTNAMS("CREATING ENTITY"),.VAL)
 . I VAL'>0 S OUT(1)="-65"_SSEP_"Cannot resolve Creating Entity value: "_ATTNAMS("CREATING ENTITY") Q
 . S KEYFLD(.05)=VAL
 . S KEYFLD(.05,"GSL")=$$GET1^DID(FILE,.05,,"GLOBAL SUBSCRIPT LOCATION")
 . Q
 Q
 ;
 ;+++++  Find a record by .01 field and key fields
 ; Input Parameters
 ; ================
 ;  
 ;   FILE - VA FileMan file number ( e.g. 2005.6)
 ;   UATT - Value to be found in "B" cross-reference
 ;   PIEN - Parent IEN (.e.g. Patient reference is a parent of Procedure reference)
 ;  .KEYFLD  - Array with key field and values 
 ; 
 ; Return values
 ; =============
 ;  If a record is not found it returns zero (0),
 ;  If a record is found it returns IEN of the record
 ;   
MATCH(FILE,UATT,PIEN,KEYFLD) ; Find match by keys
 N POS,HIT,IEN,R,I
 ;
 S FILE=+$G(FILE)
 S UATT=$G(UATT)
 S PIEN=$G(PIEN)
 ;
 I UATT="" Q 0  ; no record found
 ;
 S HIT=0
 S IEN=0
 F  S IEN=$O(^MAGV(FILE,"B",UATT,IEN)) Q:'IEN  D  Q:HIT
 . S R=$G(^MAGV(FILE,IEN,0))  ; The assumption is that all key fields are on "0" subscript
 . D:R'=""
 . . S HIT=1,I=0
 . . F  S I=$O(KEYFLD(I)) Q:'I  S POS=$P(KEYFLD(I,"GSL"),";",2) I $P(R,"^",POS)'=KEYFLD(I) S HIT=0 Q
 . . ; Check the parent for study and series
 . . I ((FILE=2005.62)!(FILE=2005.63)) D
 . . . I PIEN'=+$G(^MAGV(FILE,IEN,6)) S HIT=0
 . . . Q
 . . Q
 . Q
 Q IEN
