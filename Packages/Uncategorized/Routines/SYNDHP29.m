SYNDHP29 ; HC/art - HealthConcourse - get radiology report record ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1RADRPT(RADRPT,RADRPTIEN,RETJSON,RADRPTJ) ;get one Patient Radiology Report record
 ;inputs: RADRPTIEN - Patient Radiology Report IEN
 ;        RETJSON - J = Return JSON
 ;output: RADRPT  - array of Patient Radiology Report data, by reference
 ;        RADRPTJ - JSON structure of Patient Radiology Report data, by reference
 ;
 I $G(DEBUG) W !,"----------------------- Patient Radiology Report -------------------------",!
 N S S S="_"
 N C S C=","
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=74 ;RAD/NUC MED REPORTS
 N FNBR2 S FNBR2=74.05 ;OTHER CASE#
 N FNBR3 S FNBR3=74.01 ;ACTIVITY LOG
 N FNBR4 S FNBR4=74.06 ;ERROR REPORTS
 N FNBR5 S FNBR5=74.02005 ;IMAGE
 N FNBR6 S FNBR6=74.16 ;BEFORE DELETION SEC. DX CODE
 N FNBR7 S FNBR7=74.18 ;BEFORE DELETION SEC. STAFF
 N FNBR8 S FNBR8=74.19 ;BEFORE DELETION SEC. RESIDENT
 N IENS1 S IENS1=RADRPTIEN_","
 ;
 N RADRPTARR,RADRPTERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","RADRPTARR","RADRPTERR")
 I $G(DEBUG) W !,$$ZW^SYNDHPUTL("RADRPTARR")
 I $G(DEBUG),$D(RADRPTERR) W !,">>ERROR<<" W !,$$ZW^SYNDHPUTL("RADRPTERR")
 I $D(RADRPTERR) D  QUIT
 . S RADRPT("Radrpt","ERROR")=RADRPTIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.RADRPT,.RADRPTJ)
 S RADRPT("Radrpt","radrptIen")=RADRPTIEN
 S RADRPT("Radrpt","resourceType")="RadiologyReport"
 S RADRPT("Radrpt","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADRPTIEN)
 S RADRPT("Radrpt","dayCase")=$G(RADRPTARR(FNBR1,IENS1,.01,"E"))
 S RADRPT("Radrpt","patientName")=$G(RADRPTARR(FNBR1,IENS1,2,"E"))
 S RADRPT("Radrpt","patientNameId")=$G(RADRPTARR(FNBR1,IENS1,2,"I"))
 S RADRPT("Radrpt","patientICN")=$$GET1^DIQ(2,RADRPT("Radrpt","patientNameId")_",",991.1)
 S RADRPT("Radrpt","examDateTime")=$G(RADRPTARR(FNBR1,IENS1,3,"E"))
 S RADRPT("Radrpt","examDateTimeFM")=$G(RADRPTARR(FNBR1,IENS1,3,"I"))
 S RADRPT("Radrpt","examDateTimeHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR1,IENS1,3,"I")))
 S RADRPT("Radrpt","examDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR1,IENS1,3,"I")))
 S RADRPT("Radrpt","caseNumber")=$G(RADRPTARR(FNBR1,IENS1,4,"E"))
 S RADRPT("Radrpt","reportStatus")=$G(RADRPTARR(FNBR1,IENS1,5,"E"))
 S RADRPT("Radrpt","reportStatusCd")=$G(RADRPTARR(FNBR1,IENS1,5,"I"))
 S RADRPT("Radrpt","dateReportEntered")=$G(RADRPTARR(FNBR1,IENS1,6,"E"))
 S RADRPT("Radrpt","dateReportEnteredFM")=$G(RADRPTARR(FNBR1,IENS1,6,"I"))
 S RADRPT("Radrpt","dateReportEnteredHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR1,IENS1,6,"I")))
 S RADRPT("Radrpt","dateReportEnteredFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR1,IENS1,6,"I")))
 S RADRPT("Radrpt","verifiedDate")=$G(RADRPTARR(FNBR1,IENS1,7,"E"))
 S RADRPT("Radrpt","verifiedDateFM")=$G(RADRPTARR(FNBR1,IENS1,7,"I"))
 S RADRPT("Radrpt","verifiedDateHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR1,IENS1,7,"I")))
 S RADRPT("Radrpt","verifiedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR1,IENS1,7,"I")))
 S RADRPT("Radrpt","reportedDate")=$G(RADRPTARR(FNBR1,IENS1,8,"E"))
 S RADRPT("Radrpt","reportedDateFM")=$G(RADRPTARR(FNBR1,IENS1,8,"I"))
 S RADRPT("Radrpt","reportedDateHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR1,IENS1,8,"I")))
 S RADRPT("Radrpt","reportedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR1,IENS1,8,"I")))
 S RADRPT("Radrpt","verifyingPhysician")=$G(RADRPTARR(FNBR1,IENS1,9,"E"))
 S RADRPT("Radrpt","verifyingPhysicianId")=$G(RADRPTARR(FNBR1,IENS1,9,"I"))
 S RADRPT("Radrpt","verifyingPhysicianNPI")=$$GET1^DIQ(200,RADRPT("Radrpt","verifyingPhysicianId")_",",41.99) ;NPI
 S RADRPT("Radrpt","verifyingPhysicianResId")=$$RESID^SYNDHP69("V",SITE,200,RADRPT("Radrpt","verifyingPhysicianId"))
 S RADRPT("Radrpt","teleradiologyPhysicianName")=$G(RADRPTARR(FNBR1,IENS1,9.1,"E"))
 S RADRPT("Radrpt","teleradiologyPhysicianNPI")=$G(RADRPTARR(FNBR1,IENS1,9.2,"E"))
 S RADRPT("Radrpt","reportVerifiedByCotsApp")=$G(RADRPTARR(FNBR1,IENS1,9.3,"E"))
 S RADRPT("Radrpt","reportVerifiedByCotsAppId")=$G(RADRPTARR(FNBR1,IENS1,9.3,"I"))
 ;S RADRPT("Radrpt","electronicSignatureCodeId")=$G(RADRPTARR(FNBR1,IENS1,10,"I"))
 S RADRPT("Radrpt","electronicSignatureCode")=$G(RADRPTARR(FNBR1,IENS1,10,"E"))
 S RADRPT("Radrpt","transcriptionist")=$G(RADRPTARR(FNBR1,IENS1,11,"E"))
 S RADRPT("Radrpt","transcriptionistId")=$G(RADRPTARR(FNBR1,IENS1,11,"I"))
 S RADRPT("Radrpt","transcriptionistNPI")=$$GET1^DIQ(200,RADRPT("Radrpt","transcriptionistId")_",",41.99) ;NPI
 S RADRPT("Radrpt","transcriptionistResId")=$$RESID^SYNDHP69("V",SITE,200,RADRPT("Radrpt","transcriptionistId"))
 S RADRPT("Radrpt","dateReportPrinted")=$G(RADRPTARR(FNBR1,IENS1,13,"E"))
 S RADRPT("Radrpt","dateReportPrintedFM")=$G(RADRPTARR(FNBR1,IENS1,13,"I"))
 S RADRPT("Radrpt","dateReportPrintedHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR1,IENS1,13,"I")))
 S RADRPT("Radrpt","dateReportPrintedFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR1,IENS1,13,"I")))
 S RADRPT("Radrpt","preVerificationDateTime")=$G(RADRPTARR(FNBR1,IENS1,14,"E"))
 S RADRPT("Radrpt","preVerificationDateTimeFM")=$G(RADRPTARR(FNBR1,IENS1,14,"I"))
 S RADRPT("Radrpt","preVerificationDateTimeHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR1,IENS1,14,"I")))
 S RADRPT("Radrpt","preVerificationDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR1,IENS1,14,"I")))
 S RADRPT("Radrpt","preVerificationUser")=$G(RADRPTARR(FNBR1,IENS1,15,"E"))
 S RADRPT("Radrpt","preVerificationUserId")=$G(RADRPTARR(FNBR1,IENS1,15,"I"))
 S RADRPT("Radrpt","preVerificationUserResId")=$$RESID^SYNDHP69("V",SITE,200,RADRPT("Radrpt","preVerificationUserId"))
 S RADRPT("Radrpt","preVerificationESig")=$G(RADRPTARR(FNBR1,IENS1,16,"E"))
 S RADRPT("Radrpt","statusChangedToVerifiedBy")=$G(RADRPTARR(FNBR1,IENS1,17,"E"))
 S RADRPT("Radrpt","statusChangedToVerifiedById")=$G(RADRPTARR(FNBR1,IENS1,17,"I"))
 S RADRPT("Radrpt","dateInitialOutsideRptEntry")=$G(RADRPTARR(FNBR1,IENS1,18,"E"))
 S RADRPT("Radrpt","dateInitialOutsideRptEntryFM")=$G(RADRPTARR(FNBR1,IENS1,18,"I"))
 S RADRPT("Radrpt","dateInitialOutsideRptEntryHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR1,IENS1,18,"I")))
 S RADRPT("Radrpt","dateInitialOutsideRptEntryFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR1,IENS1,18,"I")))
 S RADRPT("Radrpt","problemStatement")=$G(RADRPTARR(FNBR1,IENS1,25,"E"))
 S RADRPT("Radrpt","purgedDate")=$G(RADRPTARR(FNBR1,IENS1,40,"E"))
 S RADRPT("Radrpt","purgedDateFM")=$G(RADRPTARR(FNBR1,IENS1,40,"I"))
 S RADRPT("Radrpt","purgedDateHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR1,IENS1,40,"I")))
 S RADRPT("Radrpt","purgedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR1,IENS1,40,"I")))
 S RADRPT("Radrpt","noPurgeIndicator")=$G(RADRPTARR(FNBR1,IENS1,45,"E"))
 S RADRPT("Radrpt","noPurgeIndicatorCd")=$G(RADRPTARR(FNBR1,IENS1,45,"I"))
 S RADRPT("Radrpt","hospitalDivisionC")=$G(RADRPTARR(FNBR1,IENS1,53,"E"))
 S RADRPT("Radrpt","imagingLocationC")=$G(RADRPTARR(FNBR1,IENS1,54,"E"))
 S RADRPT("Radrpt","interpretingImagingLocation")=$G(RADRPTARR(FNBR1,IENS1,86,"E"))
 S RADRPT("Radrpt","interpretingImagingLocationId")=$G(RADRPTARR(FNBR1,IENS1,86,"I"))
 S RADRPT("Radrpt","procedureC")=$G(RADRPTARR(FNBR1,IENS1,102,"E"))
 S RADRPT("Radrpt","examStatusC")=$G(RADRPTARR(FNBR1,IENS1,103,"E"))
 S RADRPT("Radrpt","categoryOfExamC")=$G(RADRPTARR(FNBR1,IENS1,104,"E"))
 S RADRPT("Radrpt","wardC")=$G(RADRPTARR(FNBR1,IENS1,106,"E"))
 S RADRPT("Radrpt","serviceC")=$G(RADRPTARR(FNBR1,IENS1,107,"E"))
 S RADRPT("Radrpt","principalClinicC")=$G(RADRPTARR(FNBR1,IENS1,108,"E"))
 S RADRPT("Radrpt","contractSharingSourceC")=$G(RADRPTARR(FNBR1,IENS1,109,"E"))
 S RADRPT("Radrpt","researchSourceC")=$G(RADRPTARR(FNBR1,IENS1,109.5,"E"))
 S RADRPT("Radrpt","primaryInterpretingResidentC")=$G(RADRPTARR(FNBR1,IENS1,112,"E"))
 S RADRPT("Radrpt","primaryDiagnosticCodeC")=$G(RADRPTARR(FNBR1,IENS1,113,"E"))
 S RADRPT("Radrpt","requestingPhysicianC")=$G(RADRPTARR(FNBR1,IENS1,114,"E"))
 S RADRPT("Radrpt","primaryInterpretingStaffC")=$G(RADRPTARR(FNBR1,IENS1,115,"E"))
 S RADRPT("Radrpt","complicationC")=$G(RADRPTARR(FNBR1,IENS1,116,"E"))
 S RADRPT("Radrpt","primaryCameraEquipRmC")=$G(RADRPTARR(FNBR1,IENS1,118,"E"))
 S RADRPT("Radrpt","bedsectionC")=$G(RADRPTARR(FNBR1,IENS1,119,"E"))
 ;
 S RADRPT("Radrpt","reportText")=""
 N Z S Z=""
 F  S Z=$O(RADRPTARR(FNBR1,IENS1,200,Z)) QUIT:'+Z  D
 . S RADRPT("Radrpt","reportText")=RADRPT("Radrpt","reportText")_$G(RADRPTARR(FNBR1,IENS1,200,Z))
 ;
 S RADRPT("Radrpt","impressionText")=""
 N Z S Z=""
 F  S Z=$O(RADRPTARR(FNBR1,IENS1,300,Z)) QUIT:'+Z  D
 . S RADRPT("Radrpt","impressionText")=RADRPT("Radrpt","impressionText")_$G(RADRPTARR(FNBR1,IENS1,300,Z))
 ;
 S RADRPT("Radrpt","additionalClinicalHistory")=""
 N Z S Z=""
 F  S Z=$O(RADRPTARR(FNBR1,IENS1,400,Z)) QUIT:'+Z  D
 . S RADRPT("Radrpt","additionalClinicalHistory")=RADRPT("Radrpt","additionalClinicalHistory")_$G(RADRPTARR(FNBR1,IENS1,400,Z))
 ;
 N IENS2 S IENS2=""
 F  S IENS2=$O(RADRPTARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N OTHER S OTHER=$NA(RADRPT("Radrpt","otherCases","otherCase",+IENS2))
 . S @OTHER@("otherCaseNbr")=$G(RADRPTARR(FNBR2,IENS2,.01,"E"))
 . S @OTHER@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADRPTIEN,FNBR2_U_+IENS2)
 ;
 N IENS3 S IENS3=""
 F  S IENS3=$O(RADRPTARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . N ALOG S ALOG=$NA(RADRPT("Radrpt","activityLogs","activityLog",+IENS3))
 . S @ALOG@("logDate")=$G(RADRPTARR(FNBR3,IENS3,.01,"E"))
 . S @ALOG@("logDateFM")=$G(RADRPTARR(FNBR3,IENS3,.01,"I"))
 . S @ALOG@("logDateHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR3,IENS3,.01,"I")))
 . S @ALOG@("logDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR3,IENS3,.01,"I")))
 . S @ALOG@("typeOfAction")=$G(RADRPTARR(FNBR3,IENS3,2,"E"))
 . S @ALOG@("typeOfActionCd")=$G(RADRPTARR(FNBR3,IENS3,2,"I"))
 . S @ALOG@("computerUser")=$G(RADRPTARR(FNBR3,IENS3,3,"E"))
 . S @ALOG@("computerUserId")=$G(RADRPTARR(FNBR3,IENS3,3,"I"))
 . S @ALOG@("beforeDeletionReportStatus")=$G(RADRPTARR(FNBR3,IENS3,4,"E"))
 . S @ALOG@("beforeDeletionReportStatusCd")=$G(RADRPTARR(FNBR3,IENS3,4,"I"))
 . S @ALOG@("beforeDeletionPrimDxCode")=$G(RADRPTARR(FNBR3,IENS3,5,"E"))
 . S @ALOG@("beforeDeletionPrimDxCodeId")=$G(RADRPTARR(FNBR3,IENS3,5,"I"))
 . S @ALOG@("beforeDeletionSecDxCode")=$G(RADRPTARR(FNBR3,IENS3,6,"E"))
 . S @ALOG@("beforeDeletionPrimStaff")=$G(RADRPTARR(FNBR3,IENS3,7,"E"))
 . S @ALOG@("beforeDeletionPrimStaffId")=$G(RADRPTARR(FNBR3,IENS3,7,"I"))
 . S @ALOG@("beforeDeletionPrimStaffResId")=$$RESID^SYNDHP69("V",SITE,200,@ALOG@("beforeDeletionPrimStaffId"))
 . S @ALOG@("beforeDeletionSecStaff")=$G(RADRPTARR(FNBR3,IENS3,8,"E"))
 . S @ALOG@("beforeDeletionPrimResident")=$G(RADRPTARR(FNBR3,IENS3,9,"E"))
 . S @ALOG@("beforeDeletionPrimResidentId")=$G(RADRPTARR(FNBR3,IENS3,9,"I"))
 . S @ALOG@("beforeDeletionPrimResidentResId")=$$RESID^SYNDHP69("V",SITE,200,@ALOG@("beforeDeletionPrimResidentId"))
 . S @ALOG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADRPTIEN,FNBR3_U_+IENS3)
 ;
 N IENS4 S IENS4=""
 F  S IENS4=$O(RADRPTARR(FNBR4,IENS4)) QUIT:IENS4=""  D
 . N ERRRPT S ERRRPT=$NA(RADRPT("Radrpt","errorReportss","errorReports",+IENS4))
 . S @ERRRPT@("dateTimeOfRptSave")=$G(RADRPTARR(FNBR4,IENS4,.01,"E"))
 . S @ERRRPT@("dateTimeOfRptSaveFM")=$G(RADRPTARR(FNBR4,IENS4,.01,"I"))
 . S @ERRRPT@("dateTimeOfRptSaveHL7")=$$FMTHL7^XLFDT($G(RADRPTARR(FNBR4,IENS4,.01,"I")))
 . S @ERRRPT@("dateTimeOfRptSaveFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADRPTARR(FNBR4,IENS4,.01,"I")))
 . S @ERRRPT@("erroneousReport")=""
 . N Z S Z=""
 . F  S Z=$O(RADRPTARR(FNBR4,IENS4,2,Z)) QUIT:'+Z  D
 . . S @ERRRPT@("erroneousReport")=@ERRRPT@("erroneousReport")_$$ESC^XLFJSON($G(RADRPTARR(FNBR4,IENS4,2,Z)))_"\n"
 . S @ERRRPT@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADRPTIEN,FNBR4_U_+IENS4)
 ;
 N IENS5 S IENS5=""
 F  S IENS5=$O(RADRPTARR(FNBR5,IENS5)) QUIT:IENS5=""  D
 . N IMAGE S IMAGE=$NA(RADRPT("Radrpt","images","image",+IENS5))
 . S @IMAGE@("image")=$G(RADRPTARR(FNBR5,IENS5,.01,"E"))
 . S @IMAGE@("imageId")=$G(RADRPTARR(FNBR5,IENS5,.01,"I"))
 . S @IMAGE@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADRPTIEN,FNBR5_U_+IENS5)
 ;
 N IENS6 S IENS6=""
 F  S IENS6=$O(RADRPTARR(FNBR6,IENS6)) QUIT:IENS6=""  D
 . N DX S DX=$NA(RADRPT("Radrpt","activityLogs","activityLog",$P(IENS6,C,2),"beforeDeletionSecDxCodes","beforeDeletionSecDxCode",+IENS6))
 . S @DX@("beforeDeletionSecDxCode")=$G(RADRPTARR(FNBR6,IENS6,.01,"E"))
 . S @DX@("beforeDeletionSecDxCodeId")=$G(RADRPTARR(FNBR6,IENS6,.01,"I"))
 . S @DX@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADRPTIEN,FNBR3,$P(IENS6,C,2),FNBR6_U_+IENS6)
 ;
 N IENS7 S IENS7=""
 F  S IENS7=$O(RADRPTARR(FNBR7,IENS7)) QUIT:IENS7=""  D
 . N STAFF S STAFF=$NA(RADRPT("Radrpt","activityLogs","activityLog",$P(IENS7,C,2),"beforeDeletionSecStaffs","beforeDeletionSecStaff",+IENS7))
 . S @STAFF@("beforeDeletionSecStaff")=$G(RADRPTARR(FNBR7,IENS7,.01,"E"))
 . S @STAFF@("beforeDeletionSecStaffId")=$G(RADRPTARR(FNBR7,IENS7,.01,"I"))
 . S @STAFF@("beforeDeletionSecStaffResId")=$$RESID^SYNDHP69("V",SITE,200,@STAFF@("beforeDeletionSecStaffId"))
 . S @STAFF@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADRPTIEN,FNBR3,$P(IENS7,C,2),FNBR7_U_+IENS7)
 ;
 N IENS8 S IENS8=""
 F  S IENS8=$O(RADRPTARR(FNBR8,IENS8)) QUIT:IENS8=""  D
 . N RES S RES=$NA(RADRPT("Radrpt","activityLogs","activityLog",$P(IENS8,C,2),"beforeDeletionSecResidents","beforeDeletionSecResident",+IENS8))
 . S @RES@("beforeDeletionSecResident")=$G(RADRPTARR(FNBR8,IENS8,.01,"E"))
 . S @RES@("beforeDeletionSecResidentId")=$G(RADRPTARR(FNBR8,IENS8,.01,"I"))
 . S @RES@("beforeDeletionSecResidentResId")=$$RESID^SYNDHP69("V",SITE,200,@RES@("beforeDeletionSecResidentId"))
 . S @RES@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADRPTIEN,FNBR3,$P(IENS8,C,2),FNBR8_U_+IENS8)
 ;
 I $G(DEBUG) W !,$$ZW^SYNDHPUTL("RADRPT")
 ;
 I $G(RETJSON)="J" D
 . D TOJASON^SYNDHPUTL(.RADRPT,.RADRPTJ)
 . S RADRPTJ=$$UES^XLFJSON(RADRPTJ) ;change \\n to \n
 ;
 QUIT
 ;
