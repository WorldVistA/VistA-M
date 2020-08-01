SYNDHP27 ; HC/art - HealthConcourse - get Rad/Nuc Med Patient data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1RADPAT(RADPAT,RADPATIEN,RETJSON,RADPATJ) ;get one Rad/Nuc Med Patient record
 ;inputs: RADPATIEN - Rad/Nuc Med Patient IEN
 ;        RETJSON - J = Return JSON
 ;output: RADPAT  - array of Rad/Nuc Med Patient data, by reference
 ;        RADPATJ - JSON structure of Rad/Nuc Med Patient data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Rad/Nuc Med Patient -----------------------------",!
 N S S S="_"
 N C S C=","
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=70 ;RAD/NUC MED PATIENT
 N FNBR2 S FNBR2=70.02 ;REGISTERED EXAMS
 N FNBR3 S FNBR3=70.06 ;OUTSIDE FILMS REGISTRY
 N FNBR4 S FNBR4=70.03 ;EXAMINATIONS
 N FNBR5 S FNBR5=70.14 ;SECONDARY DIAGNOSTIC CODE
 N FNBR6 S FNBR6=70.346 ;REASON FOR NOT PURGING
 N FNBR7 S FNBR7=70.04 ;FILM SIZE
 N FNBR8 S FNBR8=70.11 ;SECONDARY INTERPRETING STAFF
 N FNBR9 S FNBR9=70.09 ;SECONDARY INTERPRET'G RESIDENT
 N FNBR10 S FNBR10=70.05 ;EXAM STATUS TIMES
 N FNBR11 S FNBR11=70.07 ;ACTIVITY LOG
 N FNBR12 S FNBR12=70.1 ;PROCEDURE MODIFIERS
 N FNBR13 S FNBR13=70.3135 ;CPT MODIFIERS
 N FNBR14 S FNBR14=70.12 ;TECHNOLOGIST
 N FNBR15 S FNBR15=70.15 ;MEDICATIONS
 N FNBR16 S FNBR16=70.3225 ;CONTRAST MEDIA
 N FNBR17 S FNBR17=70.16 ;CONTRAST MEDIA ACTIVITY LOG
 N FNBR18 S FNBR18=70.08 ;ACTIVITY LOG
 N IENS1 S IENS1=RADPATIEN_","
 ;
 N RADPATARR,RADPATERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","RADPATARR","RADPATERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("RADPATARR")
 I $G(DEBUG),$D(RADPATERR) W !,">>ERROR<<" W ! W $$ZW^SYNDHPUTL("RADPATERR")
 I $D(RADPATERR) D  QUIT
 . S RADPAT("Radpat","ERROR")=RADPATIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.RADPAT,.RADPATJ)
 ;70 ;RAD/NUC MED PATIENT
 S RADPAT("Radpat","radpatIen")=RADPATIEN
 S RADPAT("Radpat","resourceType")="Procedure"
 S RADPAT("Radpat","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN)
 S RADPAT("Radpat","patientName")=$G(RADPATARR(FNBR1,IENS1,.01,"E"))
 S RADPAT("Radpat","patientNameId")=$G(RADPATARR(FNBR1,IENS1,.01,"I"))
 S RADPAT("Radpat","patientNameICN")=$$GET1^DIQ(2,RADPAT("Radpat","patientNameId")_",",991.1)
 S RADPAT("Radpat","dateOfBirth")=$G(RADPATARR(FNBR1,IENS1,.03,"E"))
 S RADPAT("Radpat","dateOfBirthFM")=$G(RADPATARR(FNBR1,IENS1,.03,"I"))
 S RADPAT("Radpat","dateOfBirthHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR1,IENS1,.03,"I")))
 S RADPAT("Radpat","dateOfBirthFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR1,IENS1,.03,"I")))
 S RADPAT("Radpat","age")=$G(RADPATARR(FNBR1,IENS1,.033,"E"))
 S RADPAT("Radpat","usualCategory")=$G(RADPATARR(FNBR1,IENS1,.04,"E"))
 S RADPAT("Radpat","usualCategoryCd")=$G(RADPATARR(FNBR1,IENS1,.04,"I"))
 S RADPAT("Radpat","userWhoEnteredPatient")=$G(RADPATARR(FNBR1,IENS1,.06,"E"))
 S RADPAT("Radpat","userWhoEnteredPatientId")=$G(RADPATARR(FNBR1,IENS1,.06,"I"))
 S RADPAT("Radpat","userWhoEnteredPatientNPI")=$$GET1^DIQ(200,RADPAT("Radpat","userWhoEnteredPatientId")_",",41.99) ;NPI
 S RADPAT("Radpat","userWhoEnteredPatientResId")=$$RESID^SYNDHP69("V",SITE,200,RADPAT("Radpat","userWhoEnteredPatientId"))
 S RADPAT("Radpat","patientSSN")=$G(RADPATARR(FNBR1,IENS1,.09,"E"))
 S RADPAT("Radpat","eligibilityCode")=$G(RADPATARR(FNBR1,IENS1,.361,"E"))
 S RADPAT("Radpat","narrative")=$G(RADPATARR(FNBR1,IENS1,1,"E"))
 S RADPAT("Radpat","isPatientAVeteran")=$G(RADPATARR(FNBR1,IENS1,1901,"E"))
 S RADPAT("Radpat","isPatientDiabetic")=$G(RADPATARR(FNBR1,IENS1,500001,"E"))
 S RADPAT("Radpat","isPatientDiabeticCd")=$G(RADPATARR(FNBR1,IENS1,500001,"I"))
 ;70.02 ;REGISTERED EXAMS
 N IENS2 S IENS2=""
 F  S IENS2=$O(RADPATARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N REGEXAM S REGEXAM=$NA(RADPAT("Radpat","registeredExamss","registeredExams",+IENS2))
 . S @REGEXAM@("examDate")=$G(RADPATARR(FNBR2,IENS2,.01,"E"))
 . S @REGEXAM@("examDateFM")=$G(RADPATARR(FNBR2,IENS2,.01,"I"))
 . S @REGEXAM@("examDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR2,IENS2,.01,"I")))
 . S @REGEXAM@("examDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR2,IENS2,.01,"I")))
 . S @REGEXAM@("typeOfImaging")=$G(RADPATARR(FNBR2,IENS2,2,"E"))
 . S @REGEXAM@("typeOfImagingId")=$G(RADPATARR(FNBR2,IENS2,2,"I"))
 . S @REGEXAM@("hospitalDivision")=$G(RADPATARR(FNBR2,IENS2,3,"E"))
 . S @REGEXAM@("hospitalDivisionId")=$G(RADPATARR(FNBR2,IENS2,3,"I"))
 . S @REGEXAM@("imagingLocation")=$G(RADPATARR(FNBR2,IENS2,4,"E"))
 . S @REGEXAM@("imagingLocationId")=$G(RADPATARR(FNBR2,IENS2,4,"I"))
 . S @REGEXAM@("examSet")=$G(RADPATARR(FNBR2,IENS2,5,"E"))
 . S @REGEXAM@("examSetCd")=$G(RADPATARR(FNBR2,IENS2,5,"I"))
 . S @REGEXAM@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_+IENS2)
 ;70.03 ;EXAMINATIONS
 N IENS4 S IENS4=""
 F  S IENS4=$O(RADPATARR(FNBR4,IENS4)) QUIT:IENS4=""  D
 . N EXAM S EXAM=$NA(RADPAT("Radpat","registeredExamss","registeredExams",$P(IENS4,C,2),"examinationss","examinations",+IENS4))
 . S @EXAM@("caseNumber")=$G(RADPATARR(FNBR4,IENS4,.01,"E"))
 . S @EXAM@("procedure")=$G(RADPATARR(FNBR4,IENS4,2,"E"))
 . S @EXAM@("procedureId")=$G(RADPATARR(FNBR4,IENS4,2,"I"))
 . S @EXAM@("examStatus")=$G(RADPATARR(FNBR4,IENS4,3,"E"))
 . S @EXAM@("examStatusId")=$G(RADPATARR(FNBR4,IENS4,3,"I"))
 . S @EXAM@("reasonForCancellation")=$G(RADPATARR(FNBR4,IENS4,3.5,"E"))
 . S @EXAM@("reasonForCancellationId")=$G(RADPATARR(FNBR4,IENS4,3.5,"I"))
 . S @EXAM@("categoryOfExam")=$G(RADPATARR(FNBR4,IENS4,4,"E"))
 . S @EXAM@("categoryOfExamCd")=$G(RADPATARR(FNBR4,IENS4,4,"I"))
 . S @EXAM@("ward")=$G(RADPATARR(FNBR4,IENS4,6,"E"))
 . S @EXAM@("wardId")=$G(RADPATARR(FNBR4,IENS4,6,"I"))
 . S @EXAM@("service")=$G(RADPATARR(FNBR4,IENS4,7,"E"))
 . S @EXAM@("serviceId")=$G(RADPATARR(FNBR4,IENS4,7,"I"))
 . S @EXAM@("principalClinic")=$G(RADPATARR(FNBR4,IENS4,8,"E"))
 . S @EXAM@("principalClinicId")=$G(RADPATARR(FNBR4,IENS4,8,"I"))
 . S @EXAM@("contractSharingSource")=$G(RADPATARR(FNBR4,IENS4,9,"E"))
 . S @EXAM@("contractSharingSourceId")=$G(RADPATARR(FNBR4,IENS4,9,"I"))
 . S @EXAM@("researchSource")=$G(RADPATARR(FNBR4,IENS4,9.5,"E"))
 . S @EXAM@("contrastMediaUsed")=$G(RADPATARR(FNBR4,IENS4,10,"E"))
 . S @EXAM@("contrastMediaUsedCd")=$G(RADPATARR(FNBR4,IENS4,10,"I"))
 . S @EXAM@("imagingOrder")=$G(RADPATARR(FNBR4,IENS4,11,"E"))
 . S @EXAM@("imagingOrderId")=$G(RADPATARR(FNBR4,IENS4,11,"I"))
 . S @EXAM@("primaryInterpretingResident")=$G(RADPATARR(FNBR4,IENS4,12,"E"))
 . S @EXAM@("primaryInterpretingResidentId")=$G(RADPATARR(FNBR4,IENS4,12,"I"))
 . S @EXAM@("primaryInterpretingResidentNPI")=$$GET1^DIQ(200,@EXAM@("primaryInterpretingResidentId")_",",41.99) ;NPI
 . S @EXAM@("primaryInterpretingResidentResId")=$$RESID^SYNDHP69("V",SITE,200,@EXAM@("primaryInterpretingResidentId"))
 . S @EXAM@("primaryDiagnosticCode")=$G(RADPATARR(FNBR4,IENS4,13,"E"))
 . S @EXAM@("primaryDiagnosticCodeId")=$G(RADPATARR(FNBR4,IENS4,13,"I"))
 . S @EXAM@("requestingPhysician")=$G(RADPATARR(FNBR4,IENS4,14,"E"))
 . S @EXAM@("requestingPhysicianId")=$G(RADPATARR(FNBR4,IENS4,14,"I"))
 . S @EXAM@("requestingPhysicianNPI")=$$GET1^DIQ(200,@EXAM@("requestingPhysicianId")_",",41.99) ;NPI
 . S @EXAM@("requestingPhysicianResId")=$$RESID^SYNDHP69("V",SITE,200,@EXAM@("requestingPhysicianId"))
 . S @EXAM@("primaryInterpretingStaff")=$G(RADPATARR(FNBR4,IENS4,15,"E"))
 . S @EXAM@("primaryInterpretingStaffId")=$G(RADPATARR(FNBR4,IENS4,15,"I"))
 . S @EXAM@("primaryInterpretingStaffNPI")=$$GET1^DIQ(200,@EXAM@("primaryInterpretingStaffId")_",",41.99) ;NPI
 . S @EXAM@("primaryInterpretingStaffResId")=$$RESID^SYNDHP69("V",SITE,200,@EXAM@("primaryInterpretingStaffId"))
 . S @EXAM@("complication")=$G(RADPATARR(FNBR4,IENS4,16,"E"))
 . S @EXAM@("complicationId")=$G(RADPATARR(FNBR4,IENS4,16,"I"))
 . S @EXAM@("complicationText")=$G(RADPATARR(FNBR4,IENS4,16.5,"E"))
 . S @EXAM@("reportText")=$G(RADPATARR(FNBR4,IENS4,17,"E"))
 . S @EXAM@("reportTextId")=$G(RADPATARR(FNBR4,IENS4,17,"I"))
 . S @EXAM@("primaryCameraEquipRm")=$G(RADPATARR(FNBR4,IENS4,18,"E"))
 . S @EXAM@("primaryCameraEquipRmId")=$G(RADPATARR(FNBR4,IENS4,18,"I"))
 . S @EXAM@("bedsection")=$G(RADPATARR(FNBR4,IENS4,19,"E"))
 . S @EXAM@("bedsectionId")=$G(RADPATARR(FNBR4,IENS4,19,"I"))
 . S @EXAM@("diagnosticPrintDate")=$G(RADPATARR(FNBR4,IENS4,20,"E"))
 . S @EXAM@("diagnosticPrintDateFM")=$G(RADPATARR(FNBR4,IENS4,20,"I"))
 . S @EXAM@("diagnosticPrintDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR4,IENS4,20,"I")))
 . S @EXAM@("diagnosticPrintDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR4,IENS4,20,"I")))
 . S @EXAM@("requestedDate")=$G(RADPATARR(FNBR4,IENS4,21,"E"))
 . S @EXAM@("requestedDateFM")=$G(RADPATARR(FNBR4,IENS4,21,"I"))
 . S @EXAM@("requestedDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR4,IENS4,21,"I")))
 . S @EXAM@("requestedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR4,IENS4,21,"I")))
 . S @EXAM@("requestingLocation")=$G(RADPATARR(FNBR4,IENS4,22,"E"))
 . S @EXAM@("requestingLocationId")=$G(RADPATARR(FNBR4,IENS4,22,"I"))
 . S @EXAM@("clinicStopRecorded")=$G(RADPATARR(FNBR4,IENS4,23,"E"))
 . S @EXAM@("clinicStopRecordedCd")=$G(RADPATARR(FNBR4,IENS4,23,"I"))
 . S @EXAM@("memberOfSet")=$G(RADPATARR(FNBR4,IENS4,25,"E"))
 . S @EXAM@("memberOfSetCd")=$G(RADPATARR(FNBR4,IENS4,25,"I"))
 . S @EXAM@("creditMethod")=$G(RADPATARR(FNBR4,IENS4,26,"E"))
 . S @EXAM@("creditMethodCd")=$G(RADPATARR(FNBR4,IENS4,26,"I"))
 . S @EXAM@("visit")=$G(RADPATARR(FNBR4,IENS4,27,"E"))
 . S @EXAM@("visitId")=$G(RADPATARR(FNBR4,IENS4,27,"I"))
 . S @EXAM@("visitFM")=$$GET1^DIQ(9000010,@EXAM@("visitId")_",",.01,"I")
 . S @EXAM@("visitHL7")=$$FMTHL7^XLFDT(@EXAM@("visitFM"))
 . S @EXAM@("visitFHIR")=$$FMTFHIR^SYNDHPUTL(@EXAM@("visitFM"))
 . S @EXAM@("visitResId")=$$RESID^SYNDHP69("V",SITE,9000010,@EXAM@("visitId"))
 . S @EXAM@("dosageTicketPrinted")=$G(RADPATARR(FNBR4,IENS4,29,"E"))
 . S @EXAM@("dosageTicketPrintedCd")=$G(RADPATARR(FNBR4,IENS4,29,"I"))
 . S @EXAM@("hl7ExaminedMsgSent")=$G(RADPATARR(FNBR4,IENS4,30,"E"))
 . S @EXAM@("hl7ExaminedMsgSentCd")=$G(RADPATARR(FNBR4,IENS4,30,"I"))
 . S @EXAM@("siteAccessionNumber")=$G(RADPATARR(FNBR4,IENS4,31,"E"))
 . S @EXAM@("pregnancyScreen")=$G(RADPATARR(FNBR4,IENS4,32,"E"))
 . S @EXAM@("pregnancyScreenCd")=$G(RADPATARR(FNBR4,IENS4,32,"I"))
 . S @EXAM@("purgedDate")=$G(RADPATARR(FNBR4,IENS4,40,"E"))
 . S @EXAM@("purgedDateFM")=$G(RADPATARR(FNBR4,IENS4,40,"I"))
 . S @EXAM@("purgedDateHL7")=$$FMTHL7^XLFDT($G(RADPATARR(FNBR4,IENS4,40,"I")))
 . S @EXAM@("purgedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(RADPATARR(FNBR4,IENS4,40,"I")))
 . S @EXAM@("preventPurge")=$G(RADPATARR(FNBR4,IENS4,45,"E"))
 . S @EXAM@("preventPurgeCd")=$G(RADPATARR(FNBR4,IENS4,45,"I"))
 . S @EXAM@("pregnancyScreenComment")=$G(RADPATARR(FNBR4,IENS4,80,"E"))
 . S @EXAM@("studyInstanceUid")=$G(RADPATARR(FNBR4,IENS4,81,"E"))
 . S @EXAM@("clinicalHistoryForExam")=""
 . N Z S Z=""
 . F  S Z=$O(RADPATARR(FNBR4,IENS4,400,Z)) QUIT:'+Z  D
 . . S @EXAM@("clinicalHistoryForExam")=@EXAM@("clinicalHistoryForExam")_$G(RADPATARR(FNBR4,IENS4,400,Z))
 . . W "IENS4: ",IENS4,"  text("_Z_"): ",$G(RADPATARR(FNBR4,IENS4,400,Z)),!
 . S @EXAM@("nuclearMedData")=$G(RADPATARR(FNBR4,IENS4,500,"E"))
 . S @EXAM@("nuclearMedDataId")=$G(RADPATARR(FNBR4,IENS4,500,"I"))
 . S @EXAM@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,RADPATIEN,FNBR2_U_$P(IENS4,C,2)_U_FNBR4_U_+IENS4)
 ;
 D RADCONT1^SYNDHP27A
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("RADPAT")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.RADPAT,.RADPATJ)
 ;
 QUIT
 ;
