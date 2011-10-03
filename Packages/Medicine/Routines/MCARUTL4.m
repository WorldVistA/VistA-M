MCARUTL4 ;HOIFO/WAA-Utility Routine #3;03/06/01  15:00
 ;;2.3;Medicine;**32**;09/13/1996
 ;;
RPTAGE(FN,IEN) ; This function will return the age of the patient
 ;  at the time of the report and pass it back.
 N RPTAGE,ERROR
 S RPTAGE="",ERROR=0
 S FN=$G(FN) I FN="" S ERROR=1 ; Ensure that the FN is defined
 S IEN=$G(IEN) I IEN="" S ERROR=1 ; Ensure that the IEN is defined
 I FN=690 S ERROR=1 ; Keep from looking up on Medical patient file
 I FN<690!(FN>701) S ERROR=1 ; Make sure that the lookup is within range 
 I FN=697.2 S ERROR=1 ; Keep from looking up on procedure file
 I ERROR G QT ; there was an error so quit
 E  S LN=$G(^MCAR(FN,IEN,0)) ; Ensure that there is an entry in the file
 I LN'="" D
 .N DFN,BDATE,RDATE
 .S DFN=$P(LN,U,2) ; Ensure that the entry has a Patient
 .Q:DFN<1
 .S DFN=$G(^MCAR(690,DFN,0)) ; Ensure that patient is Medicine Patient
 .Q:DFN<1
 .S BDATE=$$GET1^DIQ(2,DFN,.03,"I") ; Get the Bdate from DPT
 .Q:BDATE<1
 .S RDATE=$P(LN,U) Q:RDATE<1
 .S RDATE=$P(RDATE,".") ; Strip off time
 .S RPTAGE=($E(RDATE,1,3)-$E(BDATE,1,3))-($E(RDATE,4,7)<$E(BDATE,4,7))
 .; ^^^ Calculate age at the time of the report
 .Q
QT Q RPTAGE
