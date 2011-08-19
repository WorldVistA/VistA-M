MCARUTL3 ;HOIFO/WAA-Utility Routine #3;11/29/00  09:55
 ;;2.3;Medicine;**30**;09/13/1996
 ;;
 ;;This API is referenced in DBIA 3280
 ;
MEDLKUP(ARRAY,FN,IEN) ; This sub-routine will return the following information
 ; Input:
 ;    ARRAY = the array for the return array
 ;    FN = the medicine file number
 ;    IEN = the Internal Entry Number
 ; Output:
 ;    piece 1 =0 (failure) or 1 (success, 2nd piece is message text.)
 ;    piece 2     = Medicine file
 ;    piece 3     = Medicine ien
 ;    piece 4 & 5 =Medicine patient (internal ^ external)
 ;    piece 6 & 7 =Medicine date/time   (internal ^ external)
 ;    piece 8 & 9 =Medicine Procedure (internal ^ external)
 ;    piece 10 & 11 =i~_Image (Med,2005,IEN) ^ external pointer to 2005)
 N LINE,PDATE,EDATE,DFN,PATNAM,PROC,PROCN,IMG,IMAGE,DILN,%,I,DISYS
 S ARRAY=0
 S FN=$G(FN) I FN="" S ARRAY="0^No File indicated." Q
 I FN=690 S ARRAY="0^Cannot look-up on MEDICAL PATIENT File." Q
 I FN<690!(FN>701) S ARRAY="0^Non-Medicine File indicated." Q 
 I FN=697.2 S ARRAY="0^Cannot look-up on PROCEDURE/SUBSPECIALTY File." Q
 I ($O(^MCAR(697.2,"C","MCAR("_FN,0)))<1 S ARRAY="0^"_FN_" is not a procedure file." Q
 S IEN=$G(IEN) I IEN="" S ARRAY="0^No IEN indicated." Q 
 S LINE=$G(^MCAR(FN,IEN,0))
 I LINE="" S ARRAY="0^Entry "_IEN_" in file "_FN_" not found." Q
 S PDATE=$P(LINE,U,1) ; Procedure Date
 I PDATE<1 S ARRAY="0^Incomplete data, NO Procedure Date in entry "_IEN_" for file "_FN Q
 S EDATE=$$FMTE^XLFDT(PDATE,8) ; External Date
 S DFN=$P(LINE,U,2) ; Get Patient
 I DFN<1 S ARRAY="0^Incomplete data, NO Patient in entry "_IEN_" for file "_FN Q
 S PATNAM=$$GET1^DIQ(2,DFN_",",.01,"I") ; Patient Name
 S PROC="" ; setup for getting indicated procedure
 I FN=699 S PROC=$P(LINE,U,12) ; Screening
 I FN=699.5 S PROC=$P(LINE,U,6) ; Screening
 I FN=694 S PROC=$P(LINE,U,3) ; Screening
 I PROC="" S PROC=$O(^MCAR(697.2,"C","MCAR("_FN,0)) ; Verify the procedure
 I PROC<1 S ARRAY="0^No Procedure indicated." Q  ; Bad Procedure
 S PROCN=$P($G(^MCAR(697.2,PROC,0)),U) ; get procedure number
 I PROCN="" S ARRAY="0^No Procedure Name indicated." Q  ; again Bad
 S ARRAY="1"_U_FN_U_IEN_U_DFN_U_PATNAM_U_PDATE_U_EDATE_U_PROC_U_PROCN
 S IMG=+$P($G(^MCAR(FN,IEN,2005,0)),U,3) I IMG D
 . S IMAGE=+$P($G(^MCAR(FN,IEN,2005,IMG,0)),U)
 . S ARRAY=ARRAY_U_IMG_U_IMAGE
 . Q
 ; Getting Image and passing back
 Q
