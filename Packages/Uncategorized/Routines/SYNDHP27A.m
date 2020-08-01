SYNDHP27A ; HC/art - HealthConcourse - continuation of get Rad/Nuc Med Patient data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
RADCONT1 ;continuation of GET1RADPAT^SYNDHP27 - get Rad/Nuc Med Patient record
 ;
 ;70.14 ;SECONDARY DIAGNOSTIC CODE
 N IENS5 S IENS5=""
 F  S IENS5=$O(RADPATARR(FNBR5,IENS5)) QUIT:IENS5=""  D
 . N SECDX S SECDX=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS5,C,3),"examinationss","examinations",$P(IENS5,C,2),"secondaryDiagnosticCodes","secondaryDiagnosticCode",+IENS5))
 . S @SECDX@("secondaryDiagnosticCode")=$G(RADPATARR(FNBR5,IENS5,.01,"E"))
 . S @SECDX@("secondaryDiagnosticCodeId")=$G(RADPATARR(FNBR5,IENS5,.01,"I"))
 . S @SECDX@("secondaryDxPrintDate")=$G(RADPATARR(FNBR5,IENS5,1,"E"))
 . S @SECDX@("secondaryDxPrintDateFM")=$G(RADPATARR(FNBR5,IENS5,1,"I"))
 . S @SECDX@("secondaryDxPrintDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR5,IENS5,1,"I")))
 . S @SECDX@("secondaryDxPrintDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR5,IENS5,1,"I")))
 . S @SECDX@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS5,",",3)_U_FNBR4_U_$P(IENS5,C,2)_U_FNBR5_U_+IENS5)
 ;70.346 ;REASON FOR NOT PURGING
 N IENS6 S IENS6=""
 F  S IENS6=$O(RADPATARR(FNBR6,IENS6)) QUIT:IENS6=""  D
 . N NOTPURG S NOTPURG=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS6,C,3),"examinationss","examinations",$P(IENS6,C,2),"reasonForNotPurgings","reasonForNotPurging",+IENS6))
 . S @NOTPURG@("reasonForNotPurging")=$G(RADPATARR(FNBR6,IENS6,.01,"E"))
 . S @NOTPURG@("reasonForNotPurgingCd")=$G(RADPATARR(FNBR6,IENS6,.01,"I"))
 . S @NOTPURG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS6,C,3)_U_FNBR4_U_$P(IENS6,C,2)_U_FNBR6_U_+IENS6)
 ;70.04 ;FILM SIZE
 N IENS7 S IENS7=""
 F  S IENS7=$O(RADPATARR(FNBR7,IENS7)) QUIT:IENS7=""  D
 . N FILMSIZE S FILMSIZE=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS7,C,3),"examinationss","examinations",$P(IENS7,C,2),"filmSizes","filmSize",+IENS7))
 . S @FILMSIZE@("filmSize")=$G(RADPATARR(FNBR7,IENS7,.01,"E"))
 . S @FILMSIZE@("filmSizeId")=$G(RADPATARR(FNBR7,IENS7,.01,"I"))
 . S @FILMSIZE@("amountFilmsOrCineFt")=$G(RADPATARR(FNBR7,IENS7,2,"E"))
 . S @FILMSIZE@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS7,C,3)_U_FNBR4_U_$P(IENS7,C,2)_U_FNBR7_U_+IENS7)
 ;70.11 ;SECONDARY INTERPRETING STAFF
 N IENS8 S IENS8=""
 F  S IENS8=$O(RADPATARR(FNBR8,IENS8)) QUIT:IENS8=""  D
 . N SECINTS S SECINTS=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS8,C,3),"examinationss","examinations",$P(IENS8,C,2),"secondaryInterpretingStaffs","secondaryInterpretingStaff",+IENS8))
 . S @SECINTS@("secondaryInterpretingStaff")=$G(RADPATARR(FNBR8,IENS8,.01,"E"))
 . S @SECINTS@("secondaryInterpretingStaffId")=$G(RADPATARR(FNBR8,IENS8,.01,"I"))
 . S @SECINTS@("secondaryInterpretingStaffNPI")=$$GET1^DIQ(200,@SECINTS@("secondaryInterpretingStaffId")_",",41.99) ;NPI
 . S @SECINTS@("secondaryInterpretingStaffResId")=$$RESID^SYNDHP69("V",SITE,200,@SECINTS@("secondaryInterpretingStaffId"))
 . S @SECINTS@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS8,C,3)_U_FNBR4_U_$P(IENS8,C,2)_U_FNBR8_U_+IENS8)
 ;70.09 ;SECONDARY INTERPRET'G RESIDENT
 N IENS9 S IENS9=""
 F  S IENS9=$O(RADPATARR(FNBR9,IENS9)) QUIT:IENS9=""  D
 . N SECINTR S SECINTR=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS9,C,3),"examinationss","examinations",$P(IENS9,C,2),"secondaryInterpretGResidents","secondaryInterpretGResident",+IENS9))
 . S @SECINTR@("secondaryInterpretGResident")=$G(RADPATARR(FNBR9,IENS9,.01,"E"))
 . S @SECINTR@("secondaryInterpretGResidentId")=$G(RADPATARR(FNBR9,IENS9,.01,"I"))
 . S @SECINTR@("secondaryInterpretGResidentNPI")=$$GET1^DIQ(200,@SECINTR@("secondaryInterpretGResidentId")_",",41.99) ;NPI
 . S @SECINTR@("secondaryInterpretGResidentResId")=$$RESID^SYNDHP69("V",SITE,200,@SECINTR@("secondaryInterpretGResidentId"))
 . S @SECINTR@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS9,C,3)_U_FNBR4_U_$P(IENS9,C,2)_U_FNBR9_U_+IENS9)
 ;70.05 ;EXAM STATUS TIMES
 N IENS10 S IENS10=""
 F  S IENS10=$O(RADPATARR(FNBR10,IENS10)) QUIT:IENS10=""  D
 . N EXSTATTM S EXSTATTM=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS10,C,3),"examinationss","examinations",$P(IENS10,C,2),"examStatusTimess","examStatusTimes",+IENS10))
 . S @EXSTATTM@("statusChangeDateTime")=$G(RADPATARR(FNBR10,IENS10,.01,"E"))
 . S @EXSTATTM@("statusChangeDateTimeFM")=$G(RADPATARR(FNBR10,IENS10,.01,"I"))
 . S @EXSTATTM@("statusChangeDateTimeHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR10,IENS10,.01,"I")))
 . S @EXSTATTM@("statusChangeDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR10,IENS10,.01,"I")))
 . S @EXSTATTM@("newStatus")=$G(RADPATARR(FNBR10,IENS10,2,"E"))
 . S @EXSTATTM@("newStatusId")=$G(RADPATARR(FNBR10,IENS10,2,"I"))
 . S @EXSTATTM@("computerUser")=$G(RADPATARR(FNBR10,IENS10,3,"E"))
 . S @EXSTATTM@("computerUserId")=$G(RADPATARR(FNBR10,IENS10,3,"I"))
 . S @EXSTATTM@("computerUserNPI")=$$GET1^DIQ(200,@EXSTATTM@("computerUserId")_",",41.99) ;NPI
 . S @EXSTATTM@("computerUserResId")=$$RESID^SYNDHP69("V",SITE,200,@EXSTATTM@("computerUserId"))
 . S @EXSTATTM@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS10,C,3)_U_FNBR4_U_$P(IENS10,C,2)_U_FNBR10_U_+IENS10)
 ;70.07 ;ACTIVITY LOG
 N IENS11 S IENS11=""
 F  S IENS11=$O(RADPATARR(FNBR11,IENS11)) QUIT:IENS11=""  D
 . N EXACTLOG S EXACTLOG=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS11,C,3),"examinationss","examinations",$P(IENS11,C,2),"activityLogs","activityLog",+IENS11))
 . S @EXACTLOG@("logDate")=$G(RADPATARR(FNBR11,IENS11,.01,"E"))
 . S @EXACTLOG@("logDateFM")=$G(RADPATARR(FNBR11,IENS11,.01,"I"))
 . S @EXACTLOG@("logDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR11,IENS11,.01,"I")))
 . S @EXACTLOG@("logDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR11,IENS11,.01,"I")))
 . S @EXACTLOG@("typeOfAction")=$G(RADPATARR(FNBR11,IENS11,2,"E"))
 . S @EXACTLOG@("typeOfActionCd")=$G(RADPATARR(FNBR11,IENS11,2,"I"))
 . S @EXACTLOG@("computerUser")=$G(RADPATARR(FNBR11,IENS11,3,"E"))
 . S @EXACTLOG@("computerUserId")=$G(RADPATARR(FNBR11,IENS11,3,"I"))
 . S @EXACTLOG@("computerUserNPI")=$$GET1^DIQ(200,@EXACTLOG@("computerUserId")_",",41.99) ;NPI
 . S @EXACTLOG@("computerUserResId")=$$RESID^SYNDHP69("V",SITE,200,@EXACTLOG@("computerUserId"))
 . S @EXACTLOG@("technologistComment")=$G(RADPATARR(FNBR11,IENS11,4,"E"))
 . S @EXACTLOG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS11,C,3)_U_FNBR4_U_$P(IENS11,C,2)_U_FNBR11_U_+IENS11)
 ;70.1 ;PROCEDURE MODIFIERS
 N IENS12 S IENS12=""
 F  S IENS12=$O(RADPATARR(FNBR12,IENS12)) QUIT:IENS12=""  D
 . N PROCMOD S PROCMOD=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS12,C,3),"examinationss","examinations",$P(IENS12,C,2),"procedureModifierss","procedureModifiers",+IENS12))
 . S @PROCMOD@("procedureModifiers")=$G(RADPATARR(FNBR12,IENS12,.01,"E"))
 . S @PROCMOD@("procedureModifiersId")=$G(RADPATARR(FNBR12,IENS12,.01,"I"))
 . S @PROCMOD@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS12,C,3)_U_FNBR4_U_$P(IENS12,C,2)_U_FNBR12_U_+IENS12)
 ;70.3135 ;CPT MODIFIERS
 N IENS13 S IENS13=""
 F  S IENS13=$O(RADPATARR(FNBR13,IENS13)) QUIT:IENS13=""  D
 . N CPTMOD S CPTMOD=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS13,C,3),"examinationss","examinations",$P(IENS13,C,2),"cptModifierss","cptModifiers",+IENS13))
 . S @CPTMOD@("cptModifiers")=$G(RADPATARR(FNBR13,IENS13,.01,"E"))
 . S @CPTMOD@("cptModifiersId")=$G(RADPATARR(FNBR13,IENS13,.01,"I"))
 . S @CPTMOD@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS13,C,3)_U_FNBR4_U_$P(IENS13,C,2)_U_FNBR13_U_+IENS13)
 ;70.12 ;TECHNOLOGIST
 N IENS14 S IENS14=""
 F  S IENS14=$O(RADPATARR(FNBR14,IENS14)) QUIT:IENS14=""  D
 . N TECH S TECH=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS14,C,3),"examinationss","examinations",$P(IENS14,C,2),"technologists","technologist",+IENS14))
 . S @TECH@("technologist")=$G(RADPATARR(FNBR14,IENS14,.01,"E"))
 . S @TECH@("technologistId")=$G(RADPATARR(FNBR14,IENS14,.01,"I"))
 . S @TECH@("technologistNPI")=$$GET1^DIQ(200,@TECH@("technologistId")_",",41.99) ;NPI
 . S @TECH@("technologistResId")=$$RESID^SYNDHP69("V",SITE,200,@TECH@("technologistId"))
 . S @TECH@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS14,C,3)_U_FNBR4_U_$P(IENS14,C,2)_U_FNBR14_U_+IENS14)
 ;70.15 ;MEDICATIONS
 N IENS15 S IENS15=""
 F  S IENS15=$O(RADPATARR(FNBR15,IENS15)) QUIT:IENS15=""  D
 . N MEDS S MEDS=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS15,C,3),"examinationss","examinations",$P(IENS15,C,2),"medicationss","medications",+IENS15))
 . S @MEDS@("medAdministered")=$G(RADPATARR(FNBR15,IENS15,.01,"E"))
 . S @MEDS@("medAdministeredId")=$G(RADPATARR(FNBR15,IENS15,.01,"I"))
 . S @MEDS@("medDose")=$G(RADPATARR(FNBR15,IENS15,2,"E"))
 . S @MEDS@("dateTimeMedAdministered")=$G(RADPATARR(FNBR15,IENS15,3,"E"))
 . S @MEDS@("dateTimeMedAdministeredFM")=$G(RADPATARR(FNBR15,IENS15,3,"I"))
 . S @MEDS@("dateTimeMedAdministeredHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR15,IENS15,3,"I")))
 . S @MEDS@("dateTimeMedAdministeredFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR15,IENS15,3,"I")))
 . S @MEDS@("personWhoAdministeredMed")=$G(RADPATARR(FNBR15,IENS15,4,"E"))
 . S @MEDS@("personWhoAdministeredMedId")=$G(RADPATARR(FNBR15,IENS15,4,"I"))
 . S @MEDS@("personWhoAdministeredMedNPI")=$$GET1^DIQ(200,@MEDS@("personWhoAdministeredMedId")_",",41.99) ;NPI
 . S @MEDS@("personWhoAdministeredMedResId")=$$RESID^SYNDHP69("V",SITE,200,@MEDS@("personWhoAdministeredMedId"))
 . S @MEDS@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS15,C,3)_U_FNBR4_U_$P(IENS15,C,2)_U_FNBR15_U_+IENS15)
 ;70.3225 ;CONTRAST MEDIA
 N IENS16 S IENS16=""
 F  S IENS16=$O(RADPATARR(FNBR16,IENS16)) QUIT:IENS16=""  D
 . N CONTMED S CONTMED=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS16,C,3),"examinationss","examinations",$P(IENS16,C,2),"contrastMedias","contrastMedia",+IENS16))
 . S @CONTMED@("contrastMedia")=$G(RADPATARR(FNBR16,IENS16,.01,"E"))
 . S @CONTMED@("contrastMediaCd")=$G(RADPATARR(FNBR16,IENS16,.01,"I"))
 . S @CONTMED@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS16,C,3)_U_FNBR4_U_$P(IENS16,C,2)_U_FNBR16_U_+IENS16)
 ;70.16 ;CONTRAST MEDIA ACTIVITY LOG
 N IENS17 S IENS17=""
 F  S IENS17=$O(RADPATARR(FNBR17,IENS17)) QUIT:IENS17=""  D
 . N CONTLOG S CONTLOG=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS17,C,3),"examinationss","examinations",$P(IENS17,C,2),"contrastMediaActivityLogs","contrastMediaActivityLog",+IENS17))
 . S @CONTLOG@("dateTimeEdited")=$G(RADPATARR(FNBR17,IENS17,.01,"E"))
 . S @CONTLOG@("dateTimeEditedFM")=$G(RADPATARR(FNBR17,IENS17,.01,"I"))
 . S @CONTLOG@("dateTimeEditedHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR17,IENS17,.01,"I")))
 . S @CONTLOG@("dateTimeEditedFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR17,IENS17,.01,"I")))
 . S @CONTLOG@("priorContrastMediaValue")=$G(RADPATARR(FNBR17,IENS17,2,"E"))
 . S @CONTLOG@("userWhoEditedContrast")=$G(RADPATARR(FNBR17,IENS17,3,"E"))
 . S @CONTLOG@("userWhoEditedContrastId")=$G(RADPATARR(FNBR17,IENS17,3,"I"))
 . S @CONTLOG@("userWhoEditedContrastNPI")=$$GET1^DIQ(200,@CONTLOG@("userWhoEditedContrastId")_",",41.99) ;NPI
 . S @CONTLOG@("userWhoEditedContrastResId")=$$RESID^SYNDHP69("V",SITE,200,@CONTLOG@("userWhoEditedContrastId"))
 . S @CONTLOG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS17,C,3)_U_FNBR4_U_$P(IENS17,C,2)_U_FNBR17_U_+IENS17)
 ;70.06 ;OUTSIDE FILMS REGISTRY
 N IENS3 S IENS3=""
 F  S IENS3=$O(RADPATARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . N OUTREG S OUTREG=$NA(RADPAT("Radpat","outsideFilmsRegistrys","outsideFilmsRegistry",+IENS3))
 . S @OUTREG@("outsideFilmsRegisterDate")=$G(RADPATARR(FNBR3,IENS3,.01,"E"))
 . S @OUTREG@("outsideFilmsRegisterDateFM")=$G(RADPATARR(FNBR3,IENS3,.01,"I"))
 . S @OUTREG@("outsideFilmsRegisterDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR3,IENS3,.01,"I")))
 . S @OUTREG@("outsideFilmsRegisterDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR3,IENS3,.01,"I")))
 . S @OUTREG@("neededBackDate")=$G(RADPATARR(FNBR3,IENS3,2,"E"))
 . S @OUTREG@("neededBackDateFM")=$G(RADPATARR(FNBR3,IENS3,2,"I"))
 . S @OUTREG@("neededBackDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR3,IENS3,2,"I")))
 . S @OUTREG@("neededBackDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR3,IENS3,2,"I")))
 . S @OUTREG@("returnedDate")=$G(RADPATARR(FNBR3,IENS3,3,"E"))
 . S @OUTREG@("returnedDateFM")=$G(RADPATARR(FNBR3,IENS3,3,"I"))
 . S @OUTREG@("returnedDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR3,IENS3,3,"I")))
 . S @OUTREG@("returnedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR3,IENS3,3,"I")))
 . S @OUTREG@("sourceOfFilms")=$G(RADPATARR(FNBR3,IENS3,4,"E"))
 . S @OUTREG@("askForOkBeforeReturning")=$G(RADPATARR(FNBR3,IENS3,5,"E"))
 . S @OUTREG@("askForOkBeforeReturningCd")=$G(RADPATARR(FNBR3,IENS3,5,"I"))
 . S @OUTREG@("hasReturnBeenOkEd")=$G(RADPATARR(FNBR3,IENS3,6,"E"))
 . S @OUTREG@("hasReturnBeenOkEdCd")=$G(RADPATARR(FNBR3,IENS3,6,"I"))
 . S @OUTREG@("remarks")=$G(RADPATARR(FNBR3,IENS3,20,"E"))
 . S @OUTREG@("activityLog")=$G(RADPATARR(FNBR3,IENS3,100,"E"))
 . S @OUTREG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR3_U_+IENS3)
 ;70.08 ;ACTIVITY LOG
 N IENS18 S IENS18=""
 F  S IENS18=$O(RADPATARR(FNBR18,IENS18)) QUIT:IENS18=""  D
 . N ACTLOG S ACTLOG=$NA(RADPAT("Radpat","outsideFilmsRegistrys","outsideFilmsRegistry",$P(IENS18,C,2),"activityLogs","activityLog",+IENS18))
 . S @ACTLOG@("logDate")=$G(RADPATARR(FNBR18,IENS18,.01,"E"))
 . S @ACTLOG@("logDateFM")=$G(RADPATARR(FNBR18,IENS18,.01,"I"))
 . S @ACTLOG@("logDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR18,IENS18,.01,"I")))
 . S @ACTLOG@("logDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR18,IENS18,.01,"I")))
 . S @ACTLOG@("typeOfAction")=$G(RADPATARR(FNBR18,IENS18,2,"E"))
 . S @ACTLOG@("typeOfActionCd")=$G(RADPATARR(FNBR18,IENS18,2,"I"))
 . S @ACTLOG@("computerUser")=$G(RADPATARR(FNBR18,IENS18,3,"E"))
 . S @ACTLOG@("computerUserId")=$G(RADPATARR(FNBR18,IENS18,3,"I"))
 . S @ACTLOG@("computerUserNPI")=$$GET1^DIQ(200,@ACTLOG@("computerUserId")_",",41.99) ;NPI
 . S @ACTLOG@("computerUserResId")=$$RESID^SYNDHP69("V",SITE,200,@ACTLOG@("computerUserId"))
 . S @ACTLOG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR3_U_$P(IENS18,C,2)_U_FNBR18_U_+IENS18)
 ;
 QUIT
 ;
