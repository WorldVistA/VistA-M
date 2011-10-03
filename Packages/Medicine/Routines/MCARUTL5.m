MCARUTL5 ;HOIFO/WAA-UTILITY FOR VALIDATING ENTRY ;04/13/01  12:00
 ;;2.3;Medicine;**33**;09/13/1996
 ; 
 ; VALID Validation function
 ; 
 ; MC*2.3*33 this is a new module to validate the entry
 ; is for the stated patient and matched the one on the "AC"
 ; The subroutine will work out the "AC" from the procedure.
 ; This will ensure that "AC" that the main program is using
 ; and the "AC" that I am building are one and the same.
 ; if they don't match I will not validate it.
 ;
 ;Input:
 ; ROOT = The root Global Reference for the entry.
 ; IEN = The Internal entry number for the procedure being checked
 ; DFN = The Patient DFN with in the Medicine Patient file.
 ;
 ;Outout:
 ; VALID = 1 or 0
 ;         1 = The entry is a procedure for the indicated Patient
 ;         0 = The entry is not a procedure for the indicated Patient
 ;
VALID(ROOT,IEN,DFN) ; Main entry point for this function
 N VALID,LINE,FN
 S VALID=0 ; Init VALID to 0
 S FN=$P(ROOT,"(",2) ; parce out the internal entry number
 S LINE=$G(^MCAR(FN,IEN,0)) ; validate that the entry exists
 I LINE'="" D
 . N IEN697,PL,PRODFN,PRODT
 . S IEN697=$O(^MCAR(697.2,"C",ROOT,0)) Q:IEN697<1  ; get the procedure info
 . S PL=$P(^MCAR(697.2,IEN697,0),U,12) Q:PL=""  ; get the location if the pat DFN within the procedure
 . S PRODFN=$$GET1^DIQ(FN,IEN,PL,"I") Q:PRODFN<1  ; get the pat DFN
 . Q:PRODFN'=DFN  ; compare the pat DFN from the procedure with the passed DFN
 . S PRODT=9999999.9999-$P(LINE,U) ; get the Procedure date and invert it
 . I '$D(^MCAR(690,"AC",PRODFN,PRODT,ROOT,IEN)) Q  ; check to see if the entry is in the a valid entry within 690 "AC" Xref
 . S VALID=1 ; Valid entry
 . Q
 Q VALID
