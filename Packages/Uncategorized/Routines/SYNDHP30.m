SYNDHP30 ; HC/art - HealthConcourse - get Pharmacy Patient data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GETPHPAT(PHPAT,PHPATIEN,RETJSON,PHPATJ) ;get Pharmacy Patient record
 ;inputs: PHPATIEN - Pharmacy Patient IEN
 ;        RETJSON - J = Return JSON
 ;output: PHPAT  - array of Pharmacy Patient data, by reference
 ;        PHPATJ - JSON structure of Pharmacy Patient data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Pharmacy Patient -----------------------------",!
 N S S S="_"
 N C S C=","
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=55 ;PHARMACY PATIENT
 N FNBR2 S FNBR2=55.03 ;PRESCRIPTION PROFILE
 N FNBR3 S FNBR3=55.05 ;NON-VA MEDS
 N FNBR4 S FNBR4=55.051 ;ORDER CHECKS
 N FNBR5 S FNBR5=55.06 ;UNIT DOSE
 N FNBR6 S FNBR6=55.07 ;DISPENSE DRUG
 N FNBR7 S FNBR7=55.09 ;ACTIVITY LOG
 N FNBR8 S FNBR8=55.0611 ;DISPENSE LOG
 N FNBR9 S FNBR9=55.6114 ;LAST RENEW
 N FNBR10 S FNBR10=55.6132 ;INTERVENTION
 N FNBR11 S FNBR11=55.01 ;IV
 N FNBR12 S FNBR12=55.02 ;ADDITIVE
 N FNBR13 S FNBR13=55.11 ;SOLUTION
 N FNBR14 S FNBR14=55.04 ;ACTIVITY LOG
 N FNBR16 S FNBR16=55.15 ;FIELD CHANGED
 N FNBR17 S FNBR17=55.1111 ;LABEL TRACKING
 N FNBR18 S FNBR18=55.1138 ;LAST RENEW
 N FNBR19 S FNBR19=55.1153 ;INTERVENTION
 N FNBR20 S FNBR20=55.13 ;ARCHIVE DATE
 N FNBR21 S FNBR21=55.14 ;RX LIST
 N FNBR22 S FNBR22=55.0105 ;BCMA ID
 N FNBR23 S FNBR23=55.1057 ;ADDITIVE
 N FNBR24 S FNBR24=55.1058 ;SOLUTION
 N FNBR25 S FNBR25=55.0108 ;SCRIPTALK ENROLLMENT ACTIVITY
 N IENS1 S IENS1=PHPATIEN_","
 ;
 N PHPATARR,PHPATERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","PHPATARR","PHPATERR")
 I $G(DEBUG) W !,$$ZW^SYNDHPUTL("PHPATARR")
 I $G(DEBUG),$D(PHPATERR) W !,">>ERROR<<" W !,$$ZW^SYNDHPUTL("PHPATERR")
 I $D(PHPATERR),PHPATERR("DIERR",1)=601 D  QUIT
 . S PHPAT("Phpat","ERROR")=PHPATIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PHPAT,.PHPATJ)
 S PHPAT("Phpat","phpatIen")=PHPATIEN
 S PHPAT("Phpat","resourceType")="Medication"
 S PHPAT("Phpat","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN)
 S PHPAT("Phpat","number")=$G(PHPATARR(FNBR1,IENS1,.001,"E"))
 S PHPAT("Phpat","name")=$G(PHPATARR(FNBR1,IENS1,.01,"E"))
 S PHPAT("Phpat","nameId")=$G(PHPATARR(FNBR1,IENS1,.01,"I"))
 S PHPAT("Phpat","nameICN")=$$GET1^DIQ(2,PHPAT("Phpat","nameId")_",",991.1)
 S PHPAT("Phpat","cap")=$G(PHPATARR(FNBR1,IENS1,.02,"E"))
 S PHPAT("Phpat","capCd")=$G(PHPATARR(FNBR1,IENS1,.02,"I"))
 S PHPAT("Phpat","mail")=$G(PHPATARR(FNBR1,IENS1,.03,"E"))
 S PHPAT("Phpat","mailCd")=$G(PHPATARR(FNBR1,IENS1,.03,"I"))
 S PHPAT("Phpat","dialysisPatient")=$G(PHPATARR(FNBR1,IENS1,.04,"E"))
 S PHPAT("Phpat","dialysisPatientCd")=$G(PHPATARR(FNBR1,IENS1,.04,"I"))
 S PHPAT("Phpat","mailStatusExpirationDate")=$G(PHPATARR(FNBR1,IENS1,.05,"E"))
 S PHPAT("Phpat","mailStatusExpirationDateFM")=$G(PHPATARR(FNBR1,IENS1,.05,"I"))
 S PHPAT("Phpat","mailStatusExpirationDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,.05,"I")))
 S PHPAT("Phpat","mailStatusExpirationDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,.05,"I")))
 S PHPAT("Phpat","firstServiceDate")=$G(PHPATARR(FNBR1,IENS1,.07,"E"))
 S PHPAT("Phpat","firstServiceDateFM")=$G(PHPATARR(FNBR1,IENS1,.07,"I"))
 S PHPAT("Phpat","firstServiceDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,.07,"I")))
 S PHPAT("Phpat","firstServiceDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,.07,"I")))
 S PHPAT("Phpat","actualHistoricalFlag")=$G(PHPATARR(FNBR1,IENS1,.08,"E"))
 S PHPAT("Phpat","actualHistoricalFlagCd")=$G(PHPATARR(FNBR1,IENS1,.08,"I"))
 S PHPAT("Phpat","narrative")=$G(PHPATARR(FNBR1,IENS1,1,"E"))
 S PHPAT("Phpat","patientStatus")=$G(PHPATARR(FNBR1,IENS1,3,"E"))
 S PHPAT("Phpat","patientStatusId")=$G(PHPATARR(FNBR1,IENS1,3,"I"))
 S PHPAT("Phpat","communityNursingHome")=$G(PHPATARR(FNBR1,IENS1,40,"E"))
 S PHPAT("Phpat","communityNursingHomeCd")=$G(PHPATARR(FNBR1,IENS1,40,"I"))
 S PHPAT("Phpat","nursingHomeContract")=$G(PHPATARR(FNBR1,IENS1,40.1,"E"))
 S PHPAT("Phpat","nursingHomeContractCd")=$G(PHPATARR(FNBR1,IENS1,40.1,"I"))
 S PHPAT("Phpat","lastDateOfContract")=$G(PHPATARR(FNBR1,IENS1,40.2,"E"))
 S PHPAT("Phpat","lastDateOfContractFM")=$G(PHPATARR(FNBR1,IENS1,40.2,"I"))
 S PHPAT("Phpat","lastDateOfContractHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,40.2,"I")))
 S PHPAT("Phpat","lastDateOfContractFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,40.2,"I")))
 S PHPAT("Phpat","respitePatientStartDate")=$G(PHPATARR(FNBR1,IENS1,41,"E"))
 S PHPAT("Phpat","respitePatientStartDateFM")=$G(PHPATARR(FNBR1,IENS1,41,"I"))
 S PHPAT("Phpat","respitePatientStartDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,41,"I")))
 S PHPAT("Phpat","respitePatientStartDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,41,"I")))
 S PHPAT("Phpat","respitePatientEndDate")=$G(PHPATARR(FNBR1,IENS1,41.1,"E"))
 S PHPAT("Phpat","respitePatientEndDateFM")=$G(PHPATARR(FNBR1,IENS1,41.1,"I"))
 S PHPAT("Phpat","respitePatientEndDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,41.1,"I")))
 S PHPAT("Phpat","respitePatientEndDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,41.1,"I")))
 S PHPAT("Phpat","activeScriptsC")=$G(PHPATARR(FNBR1,IENS1,50,"E"))
 S PHPAT("Phpat","rxUpdate")=$G(PHPATARR(FNBR1,IENS1,52.1,"E"))
 S PHPAT("Phpat","rxUpdateCd")=$G(PHPATARR(FNBR1,IENS1,52.1,"I"))
 S PHPAT("Phpat","clozapineRegistrationNumber")=$G(PHPATARR(FNBR1,IENS1,53,"E"))
 S PHPAT("Phpat","clozapineStatus")=$G(PHPATARR(FNBR1,IENS1,54,"E"))
 S PHPAT("Phpat","clozapineStatusCd")=$G(PHPATARR(FNBR1,IENS1,54,"I"))
 S PHPAT("Phpat","dateOfLastClozapineRx")=$G(PHPATARR(FNBR1,IENS1,55,"E"))
 S PHPAT("Phpat","dateOfLastClozapineRxFM")=$G(PHPATARR(FNBR1,IENS1,55,"I"))
 S PHPAT("Phpat","dateOfLastClozapineRxHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,55,"I")))
 S PHPAT("Phpat","dateOfLastClozapineRxFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,55,"I")))
 S PHPAT("Phpat","demographicsSent")=$G(PHPATARR(FNBR1,IENS1,56,"E"))
 S PHPAT("Phpat","demographicsSentCd")=$G(PHPATARR(FNBR1,IENS1,56,"I"))
 S PHPAT("Phpat","responsibleProvider")=$G(PHPATARR(FNBR1,IENS1,57,"E"))
 S PHPAT("Phpat","responsibleProviderId")=$G(PHPATARR(FNBR1,IENS1,57,"I"))
 S PHPAT("Phpat","responsibleProviderNPI")=$$GET1^DIQ(200,PHPAT("Phpat","responsibleProviderId")_",",41.99) ;NPI
 S PHPAT("Phpat","responsibleProviderResId")=$$RESID^SYNDHP69("V",SITE,200,PHPAT("Phpat","responsibleProviderId"))
 S PHPAT("Phpat","registrationDate")=$G(PHPATARR(FNBR1,IENS1,58,"E"))
 S PHPAT("Phpat","registrationDateFM")=$G(PHPATARR(FNBR1,IENS1,58,"I"))
 S PHPAT("Phpat","registrationDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,58,"I")))
 S PHPAT("Phpat","registrationDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,58,"I")))
 S PHPAT("Phpat","udDefaultStopDateTime")=$G(PHPATARR(FNBR1,IENS1,62.01,"E"))
 S PHPAT("Phpat","udDefaultStopDateTimeFM")=$G(PHPATARR(FNBR1,IENS1,62.01,"I"))
 S PHPAT("Phpat","udDefaultStopDateTimeHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,62.01,"I")))
 S PHPAT("Phpat","udDefaultStopDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,62.01,"I")))
 S PHPAT("Phpat","udProvider")=$G(PHPATARR(FNBR1,IENS1,62.02,"E"))
 S PHPAT("Phpat","udProviderId")=$G(PHPATARR(FNBR1,IENS1,62.02,"I"))
 S PHPAT("Phpat","udProviderNPI")=$$GET1^DIQ(200,PHPAT("Phpat","udProviderId")_",",41.99) ;NPI
 S PHPAT("Phpat","udLastAdmissionDate")=$G(PHPATARR(FNBR1,IENS1,62.03,"E"))
 S PHPAT("Phpat","udLastAdmissionDateFM")=$G(PHPATARR(FNBR1,IENS1,62.03,"I"))
 S PHPAT("Phpat","udLastAdmissionDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,62.03,"I")))
 S PHPAT("Phpat","udLastAdmissionDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,62.03,"I")))
 S PHPAT("Phpat","udLastTransferDate")=$G(PHPATARR(FNBR1,IENS1,62.04,"E"))
 S PHPAT("Phpat","udLastTransferDateFM")=$G(PHPATARR(FNBR1,IENS1,62.04,"I"))
 S PHPAT("Phpat","udLastTransferDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,62.04,"I")))
 S PHPAT("Phpat","udLastTransferDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,62.04,"I")))
 S PHPAT("Phpat","udLastDischargeDate")=$G(PHPATARR(FNBR1,IENS1,62.05,"E"))
 S PHPAT("Phpat","udLastDischargeDateFM")=$G(PHPATARR(FNBR1,IENS1,62.05,"I"))
 S PHPAT("Phpat","udLastDischargeDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,62.05,"I")))
 S PHPAT("Phpat","udLastDischargeDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,62.05,"I")))
 S PHPAT("Phpat","udExpUpDate")=$G(PHPATARR(FNBR1,IENS1,62.06,"E"))
 S PHPAT("Phpat","udExpUpDateFM")=$G(PHPATARR(FNBR1,IENS1,62.06,"I"))
 S PHPAT("Phpat","udExpUpDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR1,IENS1,62.06,"I")))
 S PHPAT("Phpat","udExpUpDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR1,IENS1,62.06,"I")))
 S PHPAT("Phpat","udHoldFlag")=$G(PHPATARR(FNBR1,IENS1,62.07,"E"))
 S PHPAT("Phpat","udHoldFlagCd")=$G(PHPATARR(FNBR1,IENS1,62.07,"I"))
 S PHPAT("Phpat","udDischargeFlag")=$G(PHPATARR(FNBR1,IENS1,62.08,"E"))
 S PHPAT("Phpat","udDischargeFlagCd")=$G(PHPATARR(FNBR1,IENS1,62.08,"I"))
 S PHPAT("Phpat","comments")=""
 N Z S Z=""
 F  S Z=$O(PHPATARR(FNBR1,IENS1,62.1,Z)) QUIT:'+Z  D
 . S PHPAT("Phpat","comments")=PHPAT("Phpat","comments")_$G(PHPATARR(FNBR1,IENS1,62.1,Z))
 S PHPAT("Phpat","holdReason")=$G(PHPATARR(FNBR1,IENS1,62.11,"E"))
 S PHPAT("Phpat","inpatientNarrative")=$G(PHPATARR(FNBR1,IENS1,62.2,"E"))
 S PHPAT("Phpat","ConversionCompleted")=$G(PHPATARR(FNBR1,IENS1,104,"E"))
 S PHPAT("Phpat","ConversionCompletedCd")=$G(PHPATARR(FNBR1,IENS1,104,"I"))
 S PHPAT("Phpat","otherLanguagePreference")=$G(PHPATARR(FNBR1,IENS1,106,"E"))
 S PHPAT("Phpat","otherLanguagePreferenceCd")=$G(PHPATARR(FNBR1,IENS1,106,"I"))
 S PHPAT("Phpat","pmiLanguagePreference")=$G(PHPATARR(FNBR1,IENS1,106.1,"E"))
 S PHPAT("Phpat","pmiLanguagePreferenceCd")=$G(PHPATARR(FNBR1,IENS1,106.1,"I"))
 ;
 N IENS2 S IENS2=""
 F  S IENS2=$O(PHPATARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N RXPROF S RXPROF=$NA(PHPAT("Phpat","prescriptionProfiles","prescriptionProfile",+IENS2))
 . S @RXPROF@("prescriptionProfile")=$G(PHPATARR(FNBR2,IENS2,.01,"E"))
 . S @RXPROF@("prescriptionProfileId")=$G(PHPATARR(FNBR2,IENS2,.01,"I"))
 . S @RXPROF@("drugC")=$G(PHPATARR(FNBR2,IENS2,1,"E"))
 . S @RXPROF@("statusC")=$G(PHPATARR(FNBR2,IENS2,2,"E"))
 . S @RXPROF@("activeC")=$G(PHPATARR(FNBR2,IENS2,3,"E"))
 . S @RXPROF@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR2_U_+IENS2)
 ;
 D PHCONT1^SYNDHP30A
 D PHCONT2^SYNDHP30B
 D PHCONT3^SYNDHP30C
 D PHCONT4^SYNDHP30D
 ;
 I $G(DEBUG) W !,$$ZW^SYNDHPUTL("PHPAT")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PHPAT,.PHPATJ)
 ;
 QUIT
 ;
