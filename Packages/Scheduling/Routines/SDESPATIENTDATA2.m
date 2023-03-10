SDESPATIENTDATA2 ;ALB/LAB,RRM - VISTA Patient data  version 2; JUL 29, 2022@15:22
 ;;5.3;Scheduling;**823,824,827**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
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
 N FN,IENS,PATDATA,SDMSG,INSRETURN,FUGRET,SENSRET,LOCRET,REGIEN,DATEEDITED,FUGRETIEN,LOCALFLAGIEN,COUNT
 K RETURN
 S FN=2,IENS=DFN_","
 D GETS^DIQ(FN,DFN,".01;.02;.03;.09;.361","IE","PATDATA","SDMSG")
 S RETURN("DFN")=DFN
 S RETURN("ICN")=$$GETPATICN^SDESINPUTVALUTL(DFN) ;VSE-3648
 S RETURN("Name")=$G(PATDATA(FN,IENS,.01,"E"))
 S RETURN("Gender")=$G(PATDATA(FN,IENS,.02,"E"))
 S RETURN("DOBI")=$G(PATDATA(FN,IENS,.03,"I"))
 ;S RETURN("DOBE")=$G(PATDATA(FN,IENS,.03,"E")) - vse 2097 - DG*5.3*804
 S RETURN("DOBE")=$$FMTGMT^SDAMUTDT($G(PATDATA(FN,IENS,.03,"I")))
 S RETURN("SSN")=$$LAST4SSN^SDESINPUTVALUTL(DFN)
 S RETURN("EligibilityE")=$G(PATDATA(FN,IENS,.361,"E"))
 S RETURN("EligibilityI")=$G(PATDATA(FN,IENS,.361,"I"))
 ; insurance
 D INSURVERIFYREQ^SDESPATRPC(.INSRETURN,DFN)
 S RETURN("InsuranceVerification")=$G(INSRETURN(1))
 ; sensitive record
 D PTSEC^DGSEC4(.SENSRET,DFN)
 S RETURN("SensitiveRecord")=$G(SENSRET(1))
 ; registration
 I $D(^DGS(41.41,"B",DFN)) D 
 .S REGIEN=0
 .S REGIEN=$O(^DGS(41.41,"B",DFN,REGIEN))
 .S DATEEDITED=$$FMTISO^SDAMUTDT($$GET1^DIQ(41.41,REGIEN,1,"I"))
 S RETURN("RegistrationEditDate")=$G(DATEEDITED)
 ; fugitive national flag
 N PRFDATA,DFNERROR,DFNERRORS,FN,RESNUM,PRFCNT,FIEN,FPTR,PRFARRY,NARR,FDATA
 S FN=26.15
 S RETURN("FugitiveFelonFlag")=$S($$GET1^DIQ(2,DFN,1100.01,"I"):"YES",1:"NO")
 D LIST^DIC(26.15,,,"E",,,,,,,"FDATA","ERR")
 S (RESNUM,PRFCNT)=0
 F  S RESNUM=$O(FDATA("DILIST",2,RESNUM)) Q:'RESNUM  D
 .S FIEN=$G(FDATA("DILIST",2,RESNUM))
 .S FPTR=FIEN_";"_$P($$ROOT^DILFD(26.15),U,2)
 .K PRFDATA
 .D GETINF^DGPFAPIH(DFN,FPTR,,,"PRFDATA") Q:'$D(PRFDATA)
 .S PRFCNT=PRFCNT+1
 .S RETURN("NationalFlag",PRFCNT,"Name")=$P($G(PRFDATA("FLAG")),U,2)
 .S RETURN("NationalFlag",PRFCNT,"Type")=$P($G(PRFDATA("FLAGTYPE")),U,2)
 .S RETURN("NationalFlag",PRFCNT,"Category")=$P($G(PRFDATA("CATEGORY")),U)
 .S RETURN("NationalFlag",PRFCNT,"AssignedDate")=$$FMTISO^SDAMUTDT($P($G(PRFDATA("ASSIGNDT")),U,1))
 .S RETURN("NationalFlag",PRFCNT,"OwnerSiteID")=$P($G(PRFDATA("OWNER")),U)
 .S RETURN("NationalFlag",PRFCNT,"OwnerSiteName")=$P($G(PRFDATA("OWNER")),U,2)
 .S RETURN("NationalFlag",PRFCNT,"OriginatingSiteID")=$P($G(PRFDATA("ORIGSITE")),U)
 .S RETURN("NationalFlag",PRFCNT,"OriginatingSiteName")=$P($G(PRFDATA("ORIGSITE")),U,2)
 .S RETURN("NationalFlag",PRFCNT,"ReviewDate")=$$FMTISO^SDAMUTDT($P($G(PRFDATA("REVIEWDT")),U))
 .S NARR=0 F  S NARR=$O(PRFDATA("NARR",NARR)) Q:'NARR  D
 ..S RETURN("NationalFlag",PRFCNT,"Narrative",NARR)=$G(PRFDATA("NARR",NARR,0))
 I '$D(RETURN("NationalFlag")) S RETURN("NationalFlag",1)=""
 ;
 ; local flags
 N PRFDATA,DFNERROR,DFNERRORS,FN,RESNUM,PRFCNT,FIEN,FPTR,PRFARRY,NARR,FDATA
 S FN=26.11
 D LIST^DIC(26.11,,,"E",,,,,,,"FDATA","ERR")
 S (RESNUM,PRFCNT)=0
 F  S RESNUM=$O(FDATA("DILIST",2,RESNUM)) Q:'RESNUM  D
 .S FIEN=$G(FDATA("DILIST",2,RESNUM))
 .S FPTR=FIEN_";"_$P($$ROOT^DILFD(26.11),U,2)
 .K PRFDATA
 .D GETINF^DGPFAPIH(DFN,FPTR,,,"PRFDATA") Q:'$D(PRFDATA)
 .S PRFCNT=PRFCNT+1
 .S RETURN("LocalFlag",PRFCNT,"Name")=$P($G(PRFDATA("FLAG")),U,2)
 .S RETURN("LocalFlag",PRFCNT,"Type")=$P($G(PRFDATA("FLAGTYPE")),U,2)
 .S RETURN("LocalFlag",PRFCNT,"Category")=$P($G(PRFDATA("CATEGORY")),U)
 .S RETURN("LocalFlag",PRFCNT,"AssignedDate")=$$FMTISO^SDAMUTDT($P($G(PRFDATA("ASSIGNDT")),U,1))
 .S RETURN("LocalFlag",PRFCNT,"OwnerSiteID")=$P($G(PRFDATA("OWNER")),U)
 .S RETURN("LocalFlag",PRFCNT,"OwnerSiteName")=$P($G(PRFDATA("OWNER")),U,2)
 .S RETURN("LocalFlag",PRFCNT,"OriginatingSiteID")=$P($G(PRFDATA("ORIGSITE")),U)
 .S RETURN("LocalFlag",PRFCNT,"OriginatingSiteName")=$P($G(PRFDATA("ORIGSITE")),U,2)
 .S RETURN("LocalFlag",PRFCNT,"ReviewDate")=$$FMTISO^SDAMUTDT($P($G(PRFDATA("REVIEWDT")),U))
 .S NARR=0 F  S NARR=$O(PRFDATA("NARR",NARR)) Q:'NARR  D
 ..S RETURN("LocalFlag",PRFCNT,"Narrative",NARR)=$G(PRFDATA("NARR",NARR,0))
 I '$D(RETURN("LocalFlag")) S RETURN("LocalFlag",1)=""
 Q
 ;
