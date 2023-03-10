SDESPATIENTDATA ;;ALB/TAW - VISTA Patient data getter ;May 26, 2021@15:22
 ;;5.3;Scheduling;**788**;Aug 13, 1993;Build 6
 Q
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to ^DPT(         In ICRs #7030,7029,1476,10035
 ;
 ; The intention of this rtn is to return a unique set of data from the Patient
 ;File (2) for a specifc IEN.
 ;
 ; It is assumed by getting here all business logic and validation has been performed.
 ;
 ; This routine should only be used for retrieving data from the Patient file.
 Q
PATIENTIDADDDON(RETURN,DFN) ;
  ;Returns a basic set of data for a specific appointment
 ;
 ; Input
 ;  IEN - Specific appointment IEN
 ; Return
 ;  APPTDATA - Array of field names and the data for the field based on the IEN
 ;
 N FN,IENS,PATDATA,SDMSG
 K RETURN
 S FN=2,IENS=DFN_","
 D GETS^DIQ(FN,DFN,".01;.02;.03;.09;.361","IE","PATDATA","SDMSG")
 S RETURN("DFN")=DFN
 S RETURN("Name")=$G(PATDATA(FN,IENS,.01,"E"))
 S RETURN("Gender")=$G(PATDATA(FN,IENS,.02,"E"))
 S RETURN("DOBI")=$G(PATDATA(FN,IENS,.03,"I"))
 S RETURN("DOBE")=$G(PATDATA(FN,IENS,.03,"E"))
 S RETURN("SSN")=$G(PATDATA(FN,IENS,.09,"E"))
 S RETURN("EligibilityE")=$G(PATDATA(FN,IENS,.361,"E"))
 S RETURN("EligibilityI")=$G(PATDATA(FN,IENS,.361,"I"))
 Q
