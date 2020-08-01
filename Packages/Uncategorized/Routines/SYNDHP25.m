SYNDHP25 ; HC/art - HealthConcourse - get patient appointment data ;06/25/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GETPATAPPT(PATAPPT,PATIEN,RETJSON,PATAPPTJ) ;get patient appointment records
 ;inputs: PATIEN - Patient IEN
 ;        RETJSON - J = Return JSON
 ;output: PATAPPT  - array of patient appointment data, by reference
 ;        PATAPPTJ - JSON structure of patient appointment data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- patient appointments -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=2 ;PATIENT
 N FNBR2 S FNBR2=2.98 ;APPOINTMENT
 N IENS1 S IENS1=PATIEN_","
 N FIELDS S FIELDS=".01:.03;.09;991.1;1900*"
 ;
 N PATAPPTARR,PATAPPTERR
 D GETS^DIQ(FNBR1,IENS1,FIELDS,"EI","PATAPPTARR","PATAPPTERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PATAPPTARR")
 I $G(DEBUG),$D(PATAPPTERR) W !,">>ERROR<<" W ! W $$ZW^SYNDHPUTL("PATAPPTERR")
 I $D(PATAPPTERR) D  QUIT
 . S PATAPPT("Patappt","ERROR")=PATIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PATAPPT,.PATAPPTJ)
 S PATAPPT("Patappt","patIen")=PATIEN
 S PATAPPT("Patappt","resourceType")="Appointment"
 S PATAPPT("Patappt","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATIEN)
 S PATAPPT("Patappt","name")=$G(PATAPPTARR(FNBR1,IENS1,.01,"E"))
 S PATAPPT("Patappt","sex")=$G(PATAPPTARR(FNBR1,IENS1,.02,"E"))
 S PATAPPT("Patappt","sexCd")=$G(PATAPPTARR(FNBR1,IENS1,.02,"I"))
 S PATAPPT("Patappt","genderFHIR")=$S(PATAPPT("Patappt","sexCd")="M":"male",PATAPPT("Patappt","sexCd")="F":"female",1:"unknown")
 S PATAPPT("Patappt","selfIdentifiedGender")=$G(PATAPPTARR(FNBR1,IENS1,.024,"E"))
 S PATAPPT("Patappt","selfIdentifiedGenderCd")=$G(PATAPPTARR(FNBR1,IENS1,.024,"I"))
 S PATAPPT("Patappt","dateOfBirth")=$G(PATAPPTARR(FNBR1,IENS1,.03,"E"))
 S PATAPPT("Patappt","dateOfBirthFM")=$G(PATAPPTARR(FNBR1,IENS1,.03,"I"))
 S PATAPPT("Patappt","dateOfBirthHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR1,IENS1,.03,"I")))
 S PATAPPT("Patappt","dateOfBirthFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR1,IENS1,.03,"I")))
 S PATAPPT("Patappt","socialSecurityNumber")=$G(PATAPPTARR(FNBR1,IENS1,.09,"E"))
 S PATAPPT("Patappt","fullIcn")=$G(PATAPPTARR(FNBR1,IENS1,991.1,"E"))
 N IENS2 S IENS2=""
 F  S IENS2=$O(PATAPPTARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N APPOINT S APPOINT=$NA(PATAPPT("Patappt","appointments","appointment",+IENS2))
 . S @APPOINT@("appointmentDateTime")=$G(PATAPPTARR(FNBR2,IENS2,.001,"E"))
 . S @APPOINT@("appointmentDateTimeFM")=$G(PATAPPTARR(FNBR2,IENS2,.001,"I"))
 . S @APPOINT@("appointmentDateTimeHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,.001,"I")))
 . S @APPOINT@("appointmentDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,.001,"I")))
 . S @APPOINT@("clinic")=$G(PATAPPTARR(FNBR2,IENS2,.01,"E"))
 . S @APPOINT@("clinicId")=$G(PATAPPTARR(FNBR2,IENS2,.01,"I"))
 . S @APPOINT@("telephoneOfClinic")=$G(PATAPPTARR(FNBR2,IENS2,.02,"E"))
 . S @APPOINT@("status")=$G(PATAPPTARR(FNBR2,IENS2,3,"E"))
 . S @APPOINT@("statusCd")=$G(PATAPPTARR(FNBR2,IENS2,3,"I"))
 . N STATUS S STATUS=$G(PATAPPTARR(FNBR2,IENS2,3,"I"))
 . S @APPOINT@("statusFHIR")=$S(STATUS="":"booked",STATUS["C":"cancelled",STATUS="I":"booked",STATUS="N":"noshow",STATUS="NA":"noshow",STATUS="NT":"booked",1:"entered-in-error")
 . S @APPOINT@("realAppointment")=$G(PATAPPTARR(FNBR2,IENS2,4,"E"))
 . S @APPOINT@("labDateTime")=$G(PATAPPTARR(FNBR2,IENS2,5,"E"))
 . S @APPOINT@("labDateTimeFM")=$G(PATAPPTARR(FNBR2,IENS2,5,"I"))
 . S @APPOINT@("labDateTimeHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,5,"I")))
 . S @APPOINT@("labDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,5,"I")))
 . S @APPOINT@("xRayDateTime")=$G(PATAPPTARR(FNBR2,IENS2,6,"E"))
 . S @APPOINT@("xRayDateTimeFM")=$G(PATAPPTARR(FNBR2,IENS2,6,"I"))
 . S @APPOINT@("xRayDateTimeHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,6,"I")))
 . S @APPOINT@("xRayDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,6,"I")))
 . S @APPOINT@("ekgDateTime")=$G(PATAPPTARR(FNBR2,IENS2,7,"E"))
 . S @APPOINT@("ekgDateTimeFM")=$G(PATAPPTARR(FNBR2,IENS2,7,"I"))
 . S @APPOINT@("ekgDateTimeHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,7,"I")))
 . S @APPOINT@("ekgDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,7,"I")))
 . S @APPOINT@("routingSlipPrinted")=$G(PATAPPTARR(FNBR2,IENS2,8,"E"))
 . S @APPOINT@("routingSlipPrintedCd")=$G(PATAPPTARR(FNBR2,IENS2,8,"I"))
 . S @APPOINT@("routingSlipPrintDate")=$G(PATAPPTARR(FNBR2,IENS2,8.5,"E"))
 . S @APPOINT@("routingSlipPrintDateFM")=$G(PATAPPTARR(FNBR2,IENS2,8.5,"I"))
 . S @APPOINT@("routingSlipPrintDateHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,8.5,"I")))
 . S @APPOINT@("routingSlipPrintDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,8.5,"I")))
 . S @APPOINT@("purposeOfVisit")=$G(PATAPPTARR(FNBR2,IENS2,9,"E"))
 . S @APPOINT@("purposeOfVisitCd")=$G(PATAPPTARR(FNBR2,IENS2,9,"I"))
 . N POV S POV=$G(PATAPPTARR(FNBR2,IENS2,9,"I"))
 . S @APPOINT@("appointmentTypeFHIR")=$S(POV="4":"WALKIN",1:"ROUTINE")
 . S @APPOINT@("appointmentType")=$G(PATAPPTARR(FNBR2,IENS2,9.5,"E"))
 . S @APPOINT@("appointmentTypeId")=$G(PATAPPTARR(FNBR2,IENS2,9.5,"I"))
 . S @APPOINT@("specialSurveyDisposition")=$G(PATAPPTARR(FNBR2,IENS2,10,"E"))
 . S @APPOINT@("numberOfCollateralSeen")=$G(PATAPPTARR(FNBR2,IENS2,11,"E"))
 . S @APPOINT@("autoRebookedApptDateTime")=$G(PATAPPTARR(FNBR2,IENS2,12,"E"))
 . S @APPOINT@("autoRebookedApptDateTimeFM")=$G(PATAPPTARR(FNBR2,IENS2,12,"I"))
 . S @APPOINT@("autoRebookedApptDateTimeHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,12,"I")))
 . S @APPOINT@("autoRebookedApptDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,12,"I")))
 . S @APPOINT@("collateralVisit")=$G(PATAPPTARR(FNBR2,IENS2,13,"E"))
 . S @APPOINT@("collateralVisitCd")=$G(PATAPPTARR(FNBR2,IENS2,13,"I"))
 . S @APPOINT@("noShowCancelledBy")=$G(PATAPPTARR(FNBR2,IENS2,14,"E"))
 . S @APPOINT@("noShowCancelledById")=$G(PATAPPTARR(FNBR2,IENS2,14,"I"))
 . S @APPOINT@("noShowCancelDateTime")=$G(PATAPPTARR(FNBR2,IENS2,15,"E"))
 . S @APPOINT@("noShowCancelDateTimeFM")=$G(PATAPPTARR(FNBR2,IENS2,15,"I"))
 . S @APPOINT@("noShowCancelDateTimeHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,15,"I")))
 . S @APPOINT@("noShowCancelDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,15,"I")))
 . S @APPOINT@("cancellationReason")=$G(PATAPPTARR(FNBR2,IENS2,16,"E"))
 . S @APPOINT@("cancellationReasonId")=$G(PATAPPTARR(FNBR2,IENS2,16,"I"))
 . S @APPOINT@("cancellationRemarks")=$G(PATAPPTARR(FNBR2,IENS2,17,"E"))
 . S @APPOINT@("apptCancelled")=$G(PATAPPTARR(FNBR2,IENS2,18,"E"))
 . S @APPOINT@("apptCancelledId")=$G(PATAPPTARR(FNBR2,IENS2,18,"I"))
 . S @APPOINT@("dataEntryClerk")=$G(PATAPPTARR(FNBR2,IENS2,19,"E"))
 . S @APPOINT@("dataEntryClerkId")=$G(PATAPPTARR(FNBR2,IENS2,19,"I"))
 . S @APPOINT@("dateApptMade")=$G(PATAPPTARR(FNBR2,IENS2,20,"E"))
 . S @APPOINT@("dateApptMadeFM")=$G(PATAPPTARR(FNBR2,IENS2,20,"I"))
 . S @APPOINT@("dateApptMadeHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,20,"I")))
 . S @APPOINT@("dateApptMadeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,20,"I")))
 . S @APPOINT@("outpatientEncounter")=$G(PATAPPTARR(FNBR2,IENS2,21,"E"))
 . S @APPOINT@("outpatientEncounterId")=$G(PATAPPTARR(FNBR2,IENS2,21,"I"))
 . S @APPOINT@("encounterFormsPrinted")=$G(PATAPPTARR(FNBR2,IENS2,22,"E"))
 . S @APPOINT@("encounterFormsPrintedCd")=$G(PATAPPTARR(FNBR2,IENS2,22,"I"))
 . S @APPOINT@("encounterFormsAsAddOns")=$G(PATAPPTARR(FNBR2,IENS2,23,"E"))
 . S @APPOINT@("encounterFormsAsAddOnsCd")=$G(PATAPPTARR(FNBR2,IENS2,23,"I"))
 . S @APPOINT@("encounterConversionStatus")=$G(PATAPPTARR(FNBR2,IENS2,23.1,"E"))
 . S @APPOINT@("encounterConversionStatusCd")=$G(PATAPPTARR(FNBR2,IENS2,23.1,"I"))
 . S @APPOINT@("appointmentTypeSubCategory")=$G(PATAPPTARR(FNBR2,IENS2,24,"E"))
 . S @APPOINT@("appointmentTypeSubCategoryId")=$G(PATAPPTARR(FNBR2,IENS2,24,"I"))
 . S @APPOINT@("schedulingRequestType")=$G(PATAPPTARR(FNBR2,IENS2,25,"E"))
 . S @APPOINT@("schedulingRequestTypeCd")=$G(PATAPPTARR(FNBR2,IENS2,25,"I"))
 . S @APPOINT@("nextAvaApptIndicator")=$G(PATAPPTARR(FNBR2,IENS2,26,"E"))
 . S @APPOINT@("nextAvaApptIndicatorCd")=$G(PATAPPTARR(FNBR2,IENS2,26,"I"))
 . S @APPOINT@("desiredDateOfAppointment")=$G(PATAPPTARR(FNBR2,IENS2,27,"E"))
 . S @APPOINT@("desiredDateOfAppointmentFM")=$G(PATAPPTARR(FNBR2,IENS2,27,"I"))
 . S @APPOINT@("desiredDateOfAppointmentHL7")=$$FMTHL7^XLFDT($G(PATAPPTARR(FNBR2,IENS2,27,"I")))
 . S @APPOINT@("desiredDateOfAppointmentFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATAPPTARR(FNBR2,IENS2,27,"I")))
 . S @APPOINT@("followUpVisit")=$G(PATAPPTARR(FNBR2,IENS2,28,"E"))
 . S @APPOINT@("followUpVisitCd")=$G(PATAPPTARR(FNBR2,IENS2,28,"I"))
 . S @APPOINT@("currentStatus")=$G(PATAPPTARR(FNBR2,IENS2,100,"E"))
 . S @APPOINT@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATIEN,FNBR2_U_+IENS2)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PATAPPT")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PATAPPT,.PATAPPTJ)
 ;
 QUIT
 ;
