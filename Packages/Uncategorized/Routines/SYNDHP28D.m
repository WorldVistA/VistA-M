SYNDHP28D ; HC/art - HealthConcourse - continuation of get Patient Prescription data ;08/19/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
RXCONT4 ; continuation of GET1PATRX^SYNDHP28 - get Patient Prescription data
 ;
 N IENS12 S IENS12=""
 F  S IENS12=$O(PATRXARR(FNBR12,IENS12)) QUIT:IENS12=""  D
 . N COPAY S COPAY=$NA(PATRX("Patrx","copayActivityLogs","copayActivityLog",+IENS12))
 . S @COPAY@("copayActivityLog")=$G(PATRXARR(FNBR12,IENS12,.01,"E"))
 . S @COPAY@("copayActivityLogFM")=$G(PATRXARR(FNBR12,IENS12,.01,"I"))
 . S @COPAY@("copayActivityLogHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR12,IENS12,.01,"I")))
 . S @COPAY@("copayActivityLogFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR12,IENS12,.01,"I")))
 . S @COPAY@("reason")=$G(PATRXARR(FNBR12,IENS12,1,"E"))
 . S @COPAY@("reasonCd")=$G(PATRXARR(FNBR12,IENS12,1,"I"))
 . S @COPAY@("initiatorOfCopayActivity")=$G(PATRXARR(FNBR12,IENS12,2,"E"))
 . S @COPAY@("initiatorOfCopayActivityId")=$G(PATRXARR(FNBR12,IENS12,2,"I"))
 . S @COPAY@("rxReference")=$G(PATRXARR(FNBR12,IENS12,3,"E"))
 . S @COPAY@("comment")=$G(PATRXARR(FNBR12,IENS12,4,"E"))
 . S @COPAY@("oldValue")=$G(PATRXARR(FNBR12,IENS12,5,"E"))
 . S @COPAY@("newValue")=$G(PATRXARR(FNBR12,IENS12,6,"E"))
 . S @COPAY@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATRXIEN,FNBR12_U_+IENS12)
 ;
 N IENS13 S IENS13=""
 F  S IENS13=$O(PATRXARR(FNBR13,IENS13)) QUIT:IENS13=""  D
 . N INSTRUCT S INSTRUCT=$NA(PATRX("Patrx","medicationInstructionss","medicationInstructions",+IENS13))
 . S @INSTRUCT@("dosageOrdered")=$G(PATRXARR(FNBR13,IENS13,.01,"E"))
 . S @INSTRUCT@("dispenseUnitsPerDose")=$G(PATRXARR(FNBR13,IENS13,1,"E"))
 . S @INSTRUCT@("units")=$G(PATRXARR(FNBR13,IENS13,2,"E"))
 . S @INSTRUCT@("unitsId")=$G(PATRXARR(FNBR13,IENS13,2,"I"))
 . S @INSTRUCT@("noun")=$G(PATRXARR(FNBR13,IENS13,3,"E"))
 . S @INSTRUCT@("duration")=$G(PATRXARR(FNBR13,IENS13,4,"E"))
 . S @INSTRUCT@("conjunction")=$G(PATRXARR(FNBR13,IENS13,5,"E"))
 . S @INSTRUCT@("conjunctionCd")=$G(PATRXARR(FNBR13,IENS13,5,"I"))
 . S @INSTRUCT@("route")=$G(PATRXARR(FNBR13,IENS13,6,"E"))
 . S @INSTRUCT@("routeId")=$G(PATRXARR(FNBR13,IENS13,6,"I"))
 . S @INSTRUCT@("schedule")=$G(PATRXARR(FNBR13,IENS13,7,"E"))
 . S @INSTRUCT@("verb")=$G(PATRXARR(FNBR13,IENS13,8,"E"))
 . S @INSTRUCT@("otherLanguageDosage")=$G(PATRXARR(FNBR13,IENS13,9,"E"))
 . S @INSTRUCT@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATRXIEN,FNBR13_U_+IENS13)
 ;
 N IENS14 S IENS14=""
 F  S IENS14=$O(PATRXARR(FNBR14,IENS14)) QUIT:IENS14=""  D
 . N CMOP S CMOP=$NA(PATRX("Patrx","cmopEvents","cmopEvent",+IENS14))
 . S @CMOP@("transmissionNumber")=$G(PATRXARR(FNBR14,IENS14,.01,"E"))
 . S @CMOP@("transmissionNumberId")=$G(PATRXARR(FNBR14,IENS14,.01,"I"))
 . S @CMOP@("sequence")=$G(PATRXARR(FNBR14,IENS14,1,"E"))
 . S @CMOP@("rxIndicator")=$G(PATRXARR(FNBR14,IENS14,2,"E"))
 . S @CMOP@("status")=$G(PATRXARR(FNBR14,IENS14,3,"E"))
 . S @CMOP@("statusCd")=$G(PATRXARR(FNBR14,IENS14,3,"I"))
 . S @CMOP@("ndcReceived")=$G(PATRXARR(FNBR14,IENS14,4,"E"))
 . S @CMOP@("cancelledDateTime")=$G(PATRXARR(FNBR14,IENS14,5,"E"))
 . S @CMOP@("cancelledDateTimeFM")=$G(PATRXARR(FNBR14,IENS14,5,"I"))
 . S @CMOP@("cancelledDateTimeHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR14,IENS14,5,"I")))
 . S @CMOP@("cancelledDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR14,IENS14,5,"I")))
 . S @CMOP@("resubmitStatus")=$G(PATRXARR(FNBR14,IENS14,6,"E"))
 . S @CMOP@("resubmitStatusCd")=$G(PATRXARR(FNBR14,IENS14,6,"I"))
 . S @CMOP@("cancelledReason")=$G(PATRXARR(FNBR14,IENS14,8,"E"))
 . S @CMOP@("dateShipped")=$G(PATRXARR(FNBR14,IENS14,9,"E"))
 . S @CMOP@("dateShippedFM")=$G(PATRXARR(FNBR14,IENS14,9,"I"))
 . S @CMOP@("dateShippedHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR14,IENS14,9,"I")))
 . S @CMOP@("dateShippedFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR14,IENS14,9,"I")))
 . S @CMOP@("carrier")=$G(PATRXARR(FNBR14,IENS14,10,"E"))
 . S @CMOP@("packageId")=$G(PATRXARR(FNBR14,IENS14,11,"E"))
 . S @CMOP@("ndcSent")=$G(PATRXARR(FNBR14,IENS14,12,"E"))
 . S @CMOP@("fdaMedGuideFilename")=$G(PATRXARR(FNBR14,IENS14,35,"E"))
 . S @CMOP@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATRXIEN,FNBR14_U_+IENS14)
 ;
 N IENS15 S IENS15=""
 F  S IENS15=$O(PATRXARR(FNBR15,IENS15)) QUIT:IENS15=""  D
 . N ICD S ICD=$NA(PATRX("Patrx","icdDiagnosiss","icdDiagnosis",+IENS15))
 . S @ICD@("icdDiagnosis")=$G(PATRXARR(FNBR15,IENS15,.01,"E"))
 . S @ICD@("icdDiagnosisId")=$G(PATRXARR(FNBR15,IENS15,.01,"I"))
 . S @ICD@("icdDiagnosisDesc")=""
 . I @ICD@("icdDiagnosis")'="" S @ICD@("icdDiagnosisDesc")=$P($$ICDDX^ICDEX(@ICD@("icdDiagnosis")),U,4)
 . S @ICD@("agentOrange")=$G(PATRXARR(FNBR15,IENS15,1,"E"))
 . S @ICD@("agentOrangeCd")=$G(PATRXARR(FNBR15,IENS15,1,"I"))
 . S @ICD@("ionizingRadiation")=$G(PATRXARR(FNBR15,IENS15,2,"E"))
 . S @ICD@("ionizingRadiationCd")=$G(PATRXARR(FNBR15,IENS15,2,"I"))
 . S @ICD@("serviceConnection")=$G(PATRXARR(FNBR15,IENS15,3,"E"))
 . S @ICD@("serviceConnectionCd")=$G(PATRXARR(FNBR15,IENS15,3,"I"))
 . S @ICD@("southwestAsiaConditions")=$G(PATRXARR(FNBR15,IENS15,4,"E"))
 . S @ICD@("southwestAsiaConditionsCd")=$G(PATRXARR(FNBR15,IENS15,4,"I"))
 . S @ICD@("militarySexualTrauma")=$G(PATRXARR(FNBR15,IENS15,5,"E"))
 . S @ICD@("militarySexualTraumaCd")=$G(PATRXARR(FNBR15,IENS15,5,"I"))
 . S @ICD@("headAndOrNeckCancer")=$G(PATRXARR(FNBR15,IENS15,6,"E"))
 . S @ICD@("headAndOrNeckCancerCd")=$G(PATRXARR(FNBR15,IENS15,6,"I"))
 . S @ICD@("combatVeteran")=$G(PATRXARR(FNBR15,IENS15,7,"E"))
 . S @ICD@("combatVeteranCd")=$G(PATRXARR(FNBR15,IENS15,7,"I"))
 . S @ICD@("proj112Shad")=$G(PATRXARR(FNBR15,IENS15,8,"E"))
 . S @ICD@("proj112ShadCd")=$G(PATRXARR(FNBR15,IENS15,8,"I"))
 . S @ICD@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATRXIEN,FNBR15_U_+IENS15)
 .;
 . ;get SCT code
 . S @ICD@("icdDiagnosisSCT")=""
 . I @ICD@("icdDiagnosis")'="" D
 . . N MAPPING S MAPPING=$S(PATRX("Patrx","issueDateFM")>3150930:"sct2icd",1:"sct2icdnine")
 . . N SNOMED S SNOMED=$$MAP^SYNDHPMP(MAPPING,@ICD@("icdDiagnosis"),"I")
 . . S @ICD@("icdDiagnosisSCT")=$S(+SNOMED=-1:"",1:$P(SNOMED,U,2))
 ;
 QUIT
 ;
