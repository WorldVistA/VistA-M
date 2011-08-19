DGENEGT3 ;ALB/KCL/RGL - PROCESS INCOMING MFN HL7 MSGS; 04-MAY-1999 ; 7/23/03 4:49pm
 ;;5.3;Registration;**232,306,417,451**;Aug 13, 1993
 ;
 ;
MFI ; Description: This procedure parses the MFI segment type.
 ;
 ;  Input: 
 ;     SEG - array containing the HL7 segment
 ;   MSGID - message control id of HL7 msg in the MSH segment
 ;
 ; Output:
 ;  DGMFI - array containing needed fields of MFI segment
 ;  ERROR - flag set if an error is encountered during parse
 ;
 S DGMFI("MASTERID")=$$CONVERT^DGENUPL1(SEG(1))
 S DGMFI("EVENT")=$$CONVERT^DGENUPL1(SEG(3))
 ;
 Q
 ;
 ;
MFE ; Description: This procedure parses the MFE segment.
 ;
 ;  Input: 
 ;     SEG - array containing the HL7 segment
 ;   MSGID - message control id of HL7 msg in the MSH segment
 ;
 ; Output:
 ;  DGMFE - array containing needed fields of MFE segment
 ;  ERROR - flag set if an error is encountered during parse
 ;
 S DGMFE("RECEVNT")=$$CONVERT^DGENUPL1(SEG(1))
 S DGMFE("CNTRLNUM")=$$CONVERT^DGENUPL1(SEG(2))
 S DGEGT("PRIMKEY")=$$CONVERT^DGENUPL1(SEG(4))
 ;
 Q
 ;
 ;
ZEG ; Description: This procedure parses the ZEG segment.
 ;
 ;  Input: 
 ;     SEG - array containing the HL7 segment
 ;   MSGID - message control id of HL7 msg in the MSH segment
 ;   DGMFE - array containing fields of MFE segment needed for MFK
 ;   DGMFI - array containing fields of MFI segment needed for MFK
 ;
 ; Output:
 ;  DGEGT - array containing the EGT record in FileMan format
 ;  ERROR - flag set if an error is encountered during parse
 ;
 N SUB
 ;
 S DGEGT("EFFDATE")=$$CONVERT^DGENUPL1(SEG(2),"DATE",.ERROR)
 I ERROR D  Q
 .D ADDERROR^DGENEGT2(MSGID,"BAD VALUE, ZEG SEGMENT SEQ 2",.ERRCOUNT,.DGMFI,.DGMFE) Q
 S DGEGT("PRIORITY")=$$CONVERT^DGENUPL1(+SEG(1))
 S DGEGT("SUBGRP")=$$CONVERT^DGENUPL1($P(SEG(7),$E(HLECH)))
 S DGEGT("TYPE")=$$CONVERT^DGENUPL1(+SEG(3))
 S DGEGT("FEDDATE")=$$CONVERT^DGENUPL1(SEG(6),"DATE",.ERROR)
 I ERROR D  Q
 .D ADDERROR^DGENEGT2(MSGID,"BAD VALUE, ZEG SEGMENT SEQ 6",.ERRCOUNT,.DGMFI,.DGMFE) Q
 S DGEGT("REMARKS")=$$CONVERT^DGENUPL1(SEG(4))
 ;
 ; convert '@' to null values in DGEGT() array
 S SUB=""
 F  S SUB=$O(DGEGT(SUB)) Q:(SUB="")  I ($G(DGEGT(SUB))="@") S DGEGT(SUB)=""
 ;
 Q
 ;
UPLDEGT(DGEGT,ERROR) ;
 ; Description: This procedure is used to upload the Enrollment Group
 ; Threshold (EGT) received from the HEC.  The validation/consitency
 ; checks should already have been completed.
 ;
 ;  Inputs:
 ;      DGEGT - array containing the EGT record (pass by reference)
 ;
 ; Outputs: None
 ;
 ; Store EGT from HEC and quit.
 ;
 I $$STORE^DGENEGT(.DGEGT,,1)
 ;
 ;  Old code removed per DG*5.3*451
 ;;
 ;N CURIEN
 ;;
 ;; is there a current EGT setting?
 ;S CURIEN=$$FINDCUR^DGENEGT()
 ;;
 ;; if there is no current EGT, store EGT from HEC and quit
 ;I 'CURIEN D  Q
 ;.I $$STORE^DGENEGT(.DGEGT,,1)
 ;;
 ;; if there is a current EGT, delete current, and store EGT from HEC
 ;I $$DELETE^DGENEGT(CURIEN) D
 ;.I $$STORE^DGENEGT(.DGEGT,,1)
 ;
 Q
