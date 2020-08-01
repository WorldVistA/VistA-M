SYNDHP24 ; HC/art - HealthConcourse - get TIU note data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1TIU(TIU,TIUIEN,RETJSON,TIUJ) ;get one TIU record
 ;inputs: TIUIEN - TIU IEN
 ;        RETJSON - J = Return JSON
 ;output: TIU  - array of TIU data, by reference
 ;        TIUJ - JSON structure of TIU data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- TIU -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=8925 ;TIU DOCUMENT
 N FNBR2 S FNBR2=8925.02 ;REPORT TEXT
 N IENS1 S IENS1=TIUIEN_","
 ;
 N TIUARR,TIUERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","TIUARR","TIUERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TIUARR")
 I $G(DEBUG),$D(TIUERR) W !,">>ERROR<<" W ! W $$ZW^SYNDHPUTL("TIUERR")
 I $D(TIUERR) D  QUIT
 . S TIU("Tiu","ERROR")=TIUIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.TIU,.TIUJ)
 S TIU("Tiu","tiuIen")=TIUIEN
 S TIU("Tiu","resourceType")="TiuNote"
 S TIU("Tiu","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,TIUIEN)
 S TIU("Tiu","documentType")=$G(TIUARR(FNBR1,IENS1,.01,"E"))
 S TIU("Tiu","documentTypeId")=$G(TIUARR(FNBR1,IENS1,.01,"I"))
 S TIU("Tiu","patient")=$G(TIUARR(FNBR1,IENS1,.02,"E"))
 S TIU("Tiu","patientId")=$G(TIUARR(FNBR1,IENS1,.02,"I"))
 S TIU("Tiu","patientICN")=$$GET1^DIQ(2,TIU("Tiu","patientId")_",",991.1)
 S TIU("Tiu","visit")=$G(TIUARR(FNBR1,IENS1,.03,"E"))
 S TIU("Tiu","visitId")=$G(TIUARR(FNBR1,IENS1,.03,"I"))
 S TIU("Tiu","visitFM")=$$GET1^DIQ(9000010,TIU("Tiu","visitId")_",",.01,"I")
 S TIU("Tiu","visitHL7")=$$FMTHL7^XLFDT(TIU("Tiu","visitFM"))
 S TIU("Tiu","visitFHIR")=$$FMTFHIR^SYNDHPUTL(TIU("Tiu","visitFM"))
 S TIU("Tiu","visitResId")=$$RESID^SYNDHP69("V",SITE,9000010,TIU("Tiu","visitId"))
 S TIU("Tiu","parentDocumentType")=$G(TIUARR(FNBR1,IENS1,.04,"E"))
 S TIU("Tiu","parentDocumentTypeId")=$G(TIUARR(FNBR1,IENS1,.04,"I"))
 S TIU("Tiu","status")=$G(TIUARR(FNBR1,IENS1,.05,"E"))
 S TIU("Tiu","statusId")=$G(TIUARR(FNBR1,IENS1,.05,"I"))
 S TIU("Tiu","statusFHIR")=$$NOTSTAT($$LOW^XLFSTR(TIU("Tiu","status")))
 S TIU("Tiu","parent")=$G(TIUARR(FNBR1,IENS1,.06,"E"))
 S TIU("Tiu","parentId")=$G(TIUARR(FNBR1,IENS1,.06,"I"))
 S TIU("Tiu","episodeBeginDateTime")=$G(TIUARR(FNBR1,IENS1,.07,"E"))
 S TIU("Tiu","episodeBeginDateTimeFM")=$G(TIUARR(FNBR1,IENS1,.07,"I"))
 S TIU("Tiu","episodeBeginDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,.07,"I")))
 S TIU("Tiu","episodeBeginDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,.07,"I")))
 S TIU("Tiu","episodeEndDateTime")=$G(TIUARR(FNBR1,IENS1,.08,"E"))
 S TIU("Tiu","episodeEndDateTimeFM")=$G(TIUARR(FNBR1,IENS1,.08,"I"))
 S TIU("Tiu","episodeEndDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,.08,"I")))
 S TIU("Tiu","episodeEndDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,.08,"I")))
 S TIU("Tiu","urgency")=$G(TIUARR(FNBR1,IENS1,.09,"E"))
 S TIU("Tiu","urgencyCd")=$G(TIUARR(FNBR1,IENS1,.09,"I"))
 S TIU("Tiu","lineCount")=$G(TIUARR(FNBR1,IENS1,.1,"E"))
 S TIU("Tiu","creditStopCodeOnCompletion")=$G(TIUARR(FNBR1,IENS1,.11,"E"))
 S TIU("Tiu","creditStopCodeOnCompletionCd")=$G(TIUARR(FNBR1,IENS1,.11,"I"))
 S TIU("Tiu","markDischDtForCorrection")=$G(TIUARR(FNBR1,IENS1,.12,"E"))
 S TIU("Tiu","markDischDtForCorrectionCd")=$G(TIUARR(FNBR1,IENS1,.12,"I"))
 S TIU("Tiu","visitType")=$G(TIUARR(FNBR1,IENS1,.13,"E"))
 S TIU("Tiu","reportText")=""
 N Z S Z=""
 F  S Z=$O(TIUARR(FNBR1,IENS1,2,Z)) QUIT:'+Z  D
 . S TIU("Tiu","reportText")=TIU("Tiu","reportText")_$$ESC^XLFJSON($G(TIUARR(FNBR1,IENS1,2,Z)))_"\n"
 S TIU("Tiu","entryDateTime")=$G(TIUARR(FNBR1,IENS1,1201,"E"))
 S TIU("Tiu","entryDateTimeFM")=$G(TIUARR(FNBR1,IENS1,1201,"I"))
 S TIU("Tiu","entryDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1201,"I")))
 S TIU("Tiu","entryDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1201,"I")))
 S TIU("Tiu","authorDictator")=$G(TIUARR(FNBR1,IENS1,1202,"E"))
 S TIU("Tiu","authorDictatorId")=$G(TIUARR(FNBR1,IENS1,1202,"I"))
 S TIU("Tiu","authorDictatorNPI")=$$GET1^DIQ(200,TIU("Tiu","authorDictatorId")_",",41.99) ;NPI
 S TIU("Tiu","authorDictatorResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","authorDictatorId"))
 S TIU("Tiu","clinic")=$G(TIUARR(FNBR1,IENS1,1203,"E"))
 S TIU("Tiu","clinicId")=$G(TIUARR(FNBR1,IENS1,1203,"I"))
 S TIU("Tiu","expectedSigner")=$G(TIUARR(FNBR1,IENS1,1204,"E"))
 S TIU("Tiu","expectedSignerId")=$G(TIUARR(FNBR1,IENS1,1204,"I"))
 S TIU("Tiu","expectedSignerNPI")=$$GET1^DIQ(200,TIU("Tiu","expectedSignerId")_",",41.99) ;NPI
 S TIU("Tiu","expectedSignerResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","expectedSignerId"))
 S TIU("Tiu","hospitalLocation")=$G(TIUARR(FNBR1,IENS1,1205,"E"))
 S TIU("Tiu","hospitalLocationId")=$G(TIUARR(FNBR1,IENS1,1205,"I"))
 S TIU("Tiu","serviceCreditStop")=$G(TIUARR(FNBR1,IENS1,1206,"E"))
 S TIU("Tiu","serviceCreditStopId")=$G(TIUARR(FNBR1,IENS1,1206,"I"))
 S TIU("Tiu","secondaryVisit")=$G(TIUARR(FNBR1,IENS1,1207,"E"))
 S TIU("Tiu","secondaryVisitId")=$G(TIUARR(FNBR1,IENS1,1207,"I"))
 S TIU("Tiu","expectedCosigner")=$G(TIUARR(FNBR1,IENS1,1208,"E"))
 S TIU("Tiu","expectedCosignerId")=$G(TIUARR(FNBR1,IENS1,1208,"I"))
 S TIU("Tiu","expectedCosignerNPI")=$$GET1^DIQ(200,TIU("Tiu","expectedCosignerId")_",",41.99) ;NPI
 S TIU("Tiu","expectedCosignerResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","expectedCosignerId"))
 S TIU("Tiu","attendingPhysician")=$G(TIUARR(FNBR1,IENS1,1209,"E"))
 S TIU("Tiu","attendingPhysicianId")=$G(TIUARR(FNBR1,IENS1,1209,"I"))
 S TIU("Tiu","attendingPhysicianNPI")=$$GET1^DIQ(200,TIU("Tiu","attendingPhysicianId")_",",41.99) ;NPI
 S TIU("Tiu","attendingPhysicianResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","attendingPhysicianId"))
 S TIU("Tiu","orderNumber")=$G(TIUARR(FNBR1,IENS1,1210,"E"))
 S TIU("Tiu","orderNumberId")=$G(TIUARR(FNBR1,IENS1,1210,"I"))
 S TIU("Tiu","visitLocation")=$G(TIUARR(FNBR1,IENS1,1211,"E"))
 S TIU("Tiu","visitLocationId")=$G(TIUARR(FNBR1,IENS1,1211,"I"))
 S TIU("Tiu","division")=$G(TIUARR(FNBR1,IENS1,1212,"E"))
 S TIU("Tiu","divisionId")=$G(TIUARR(FNBR1,IENS1,1212,"I"))
 S TIU("Tiu","referenceDate")=$G(TIUARR(FNBR1,IENS1,1301,"E"))
 S TIU("Tiu","referenceDateFM")=$G(TIUARR(FNBR1,IENS1,1301,"I"))
 S TIU("Tiu","referenceDateHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1301,"I")))
 S TIU("Tiu","referenceDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1301,"I")))
 S TIU("Tiu","enteredBy")=$G(TIUARR(FNBR1,IENS1,1302,"E"))
 S TIU("Tiu","enteredById")=$G(TIUARR(FNBR1,IENS1,1302,"I"))
 S TIU("Tiu","enteredByNPI")=$$GET1^DIQ(200,TIU("Tiu","enteredById")_",",41.99) ;NPI
 S TIU("Tiu","enteredByResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","enteredById"))
 S TIU("Tiu","captureMethod")=$G(TIUARR(FNBR1,IENS1,1303,"E"))
 S TIU("Tiu","captureMethodCd")=$G(TIUARR(FNBR1,IENS1,1303,"I"))
 S TIU("Tiu","releaseDateTime")=$G(TIUARR(FNBR1,IENS1,1304,"E"))
 S TIU("Tiu","releaseDateTimeFM")=$G(TIUARR(FNBR1,IENS1,1304,"I"))
 S TIU("Tiu","releaseDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1304,"I")))
 S TIU("Tiu","releaseDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1304,"I")))
 S TIU("Tiu","verificationDateTime")=$G(TIUARR(FNBR1,IENS1,1305,"E"))
 S TIU("Tiu","verificationDateTimeFM")=$G(TIUARR(FNBR1,IENS1,1305,"I"))
 S TIU("Tiu","verificationDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1305,"I")))
 S TIU("Tiu","verificationDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1305,"I")))
 S TIU("Tiu","verifiedBy")=$G(TIUARR(FNBR1,IENS1,1306,"E"))
 S TIU("Tiu","verifiedById")=$G(TIUARR(FNBR1,IENS1,1306,"I"))
 S TIU("Tiu","verifiedByNPI")=$$GET1^DIQ(200,TIU("Tiu","verifiedById")_",",41.99) ;NPI
 S TIU("Tiu","verifiedByResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","verifiedById"))
 S TIU("Tiu","dictationDate")=$G(TIUARR(FNBR1,IENS1,1307,"E"))
 S TIU("Tiu","dictationDateFM")=$G(TIUARR(FNBR1,IENS1,1307,"I"))
 S TIU("Tiu","dictationDateHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1307,"I")))
 S TIU("Tiu","dictationDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1307,"I")))
 S TIU("Tiu","suspenseDateTime")=$G(TIUARR(FNBR1,IENS1,1308,"E"))
 S TIU("Tiu","suspenseDateTimeFM")=$G(TIUARR(FNBR1,IENS1,1308,"I"))
 S TIU("Tiu","suspenseDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1308,"I")))
 S TIU("Tiu","suspenseDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1308,"I")))
 S TIU("Tiu","patientMovementRecord")=$G(TIUARR(FNBR1,IENS1,1401,"E"))
 S TIU("Tiu","patientMovementRecordId")=$G(TIUARR(FNBR1,IENS1,1401,"I"))
 S TIU("Tiu","treatingSpecialty")=$G(TIUARR(FNBR1,IENS1,1402,"E"))
 S TIU("Tiu","treatingSpecialtyId")=$G(TIUARR(FNBR1,IENS1,1402,"I"))
 S TIU("Tiu","irtRecord")=$G(TIUARR(FNBR1,IENS1,1403,"E"))
 S TIU("Tiu","irtRecordId")=$G(TIUARR(FNBR1,IENS1,1403,"I"))
 S TIU("Tiu","service")=$G(TIUARR(FNBR1,IENS1,1404,"E"))
 S TIU("Tiu","serviceId")=$G(TIUARR(FNBR1,IENS1,1404,"I"))
 S TIU("Tiu","requestingPackageReference")=$G(TIUARR(FNBR1,IENS1,1405,"E"))
 S TIU("Tiu","requestingPackageReferenceId")=$G(TIUARR(FNBR1,IENS1,1405,"I"))
 S TIU("Tiu","retractedOriginal")=$G(TIUARR(FNBR1,IENS1,1406,"E"))
 S TIU("Tiu","retractedOriginalId")=$G(TIUARR(FNBR1,IENS1,1406,"I"))
 S TIU("Tiu","prfFlagAction")=$G(TIUARR(FNBR1,IENS1,1407,"E"))
 S TIU("Tiu","signatureDateTime")=$G(TIUARR(FNBR1,IENS1,1501,"E"))
 S TIU("Tiu","signatureDateTimeFM")=$G(TIUARR(FNBR1,IENS1,1501,"I"))
 S TIU("Tiu","signatureDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1501,"I")))
 S TIU("Tiu","signatureDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1501,"I")))
 S TIU("Tiu","signedBy")=$G(TIUARR(FNBR1,IENS1,1502,"E"))
 S TIU("Tiu","signedById")=$G(TIUARR(FNBR1,IENS1,1502,"I"))
 S TIU("Tiu","signedByNPI")=$$GET1^DIQ(200,TIU("Tiu","signedById")_",",41.99) ;NPI
 S TIU("Tiu","signedByResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","signedById"))
 S TIU("Tiu","signatureBlockName")=$G(TIUARR(FNBR1,IENS1,1503,"E"))
 S TIU("Tiu","signatureBlockTitle")=$G(TIUARR(FNBR1,IENS1,1504,"E"))
 S TIU("Tiu","signatureMode")=$G(TIUARR(FNBR1,IENS1,1505,"E"))
 S TIU("Tiu","signatureModeCd")=$G(TIUARR(FNBR1,IENS1,1505,"I"))
 S TIU("Tiu","cosignatureNeeded")=$G(TIUARR(FNBR1,IENS1,1506,"E"))
 S TIU("Tiu","cosignatureNeededCd")=$G(TIUARR(FNBR1,IENS1,1506,"I"))
 S TIU("Tiu","cosignatureDateTime")=$G(TIUARR(FNBR1,IENS1,1507,"E"))
 S TIU("Tiu","cosignatureDateTimeFM")=$G(TIUARR(FNBR1,IENS1,1507,"I"))
 S TIU("Tiu","cosignatureDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1507,"I")))
 S TIU("Tiu","cosignatureDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1507,"I")))
 S TIU("Tiu","cosignedBy")=$G(TIUARR(FNBR1,IENS1,1508,"E"))
 S TIU("Tiu","cosignedById")=$G(TIUARR(FNBR1,IENS1,1508,"I"))
 S TIU("Tiu","cosignedByNPI")=$$GET1^DIQ(200,TIU("Tiu","cosignedById")_",",41.99) ;NPI
 S TIU("Tiu","cosignedByResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","cosignedById"))
 S TIU("Tiu","cosignatureBlockName")=$G(TIUARR(FNBR1,IENS1,1509,"E"))
 S TIU("Tiu","cosignatureBlockTitle")=$G(TIUARR(FNBR1,IENS1,1510,"E"))
 S TIU("Tiu","cosignatureMode")=$G(TIUARR(FNBR1,IENS1,1511,"E"))
 S TIU("Tiu","cosignatureModeCd")=$G(TIUARR(FNBR1,IENS1,1511,"I"))
 S TIU("Tiu","markedSignedOnChartBy")=$G(TIUARR(FNBR1,IENS1,1512,"E"))
 S TIU("Tiu","markedSignedOnChartById")=$G(TIUARR(FNBR1,IENS1,1512,"I"))
 S TIU("Tiu","markedSignedOnChartByNPI")=$$GET1^DIQ(200,TIU("Tiu","markedSignedOnChartById")_",",41.99) ;NPI
 S TIU("Tiu","markedSignedOnChartByResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","markedSignedOnChartById"))
 S TIU("Tiu","markedCosignedOnChartBy")=$G(TIUARR(FNBR1,IENS1,1513,"E"))
 S TIU("Tiu","markedCosignedOnChartById")=$G(TIUARR(FNBR1,IENS1,1513,"I"))
 S TIU("Tiu","markedCosignedOnChartByNPI")=$$GET1^DIQ(200,TIU("Tiu","markedCosignedOnChartById")_",",41.99) ;NPI
 S TIU("Tiu","markedCosignedOnChartByResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","markedCosignedOnChartById"))
 S TIU("Tiu","amendmentDateTime")=$G(TIUARR(FNBR1,IENS1,1601,"E"))
 S TIU("Tiu","amendmentDateTimeFM")=$G(TIUARR(FNBR1,IENS1,1601,"I"))
 S TIU("Tiu","amendmentDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1601,"I")))
 S TIU("Tiu","amendmentDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1601,"I")))
 S TIU("Tiu","amendedBy")=$G(TIUARR(FNBR1,IENS1,1602,"E"))
 S TIU("Tiu","amendedById")=$G(TIUARR(FNBR1,IENS1,1602,"I"))
 S TIU("Tiu","amendedByNPI")=$$GET1^DIQ(200,TIU("Tiu","amendedById")_",",41.99) ;NPI
 S TIU("Tiu","amendedByResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","amendedById"))
 S TIU("Tiu","amendmentSigned")=$G(TIUARR(FNBR1,IENS1,1603,"E"))
 S TIU("Tiu","amendmentSignedFM")=$G(TIUARR(FNBR1,IENS1,1603,"I"))
 S TIU("Tiu","amendmentSignedHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1603,"I")))
 S TIU("Tiu","amendmentSignedFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1603,"I")))
 S TIU("Tiu","amendmentSignBlockName")=$G(TIUARR(FNBR1,IENS1,1604,"E"))
 S TIU("Tiu","amendmentSignBlockTitle")=$G(TIUARR(FNBR1,IENS1,1605,"E"))
 S TIU("Tiu","administrativeClosureDate")=$G(TIUARR(FNBR1,IENS1,1606,"E"))
 S TIU("Tiu","administrativeClosureDateFM")=$G(TIUARR(FNBR1,IENS1,1606,"I"))
 S TIU("Tiu","administrativeClosureDateHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1606,"I")))
 S TIU("Tiu","administrativeClosureDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1606,"I")))
 S TIU("Tiu","adminClosureSigBlockName")=$G(TIUARR(FNBR1,IENS1,1607,"E"))
 S TIU("Tiu","adminClosureSigBlockTitle")=$G(TIUARR(FNBR1,IENS1,1608,"E"))
 S TIU("Tiu","archivePurgeDateTime")=$G(TIUARR(FNBR1,IENS1,1609,"E"))
 S TIU("Tiu","archivePurgeDateTimeFM")=$G(TIUARR(FNBR1,IENS1,1609,"I"))
 S TIU("Tiu","archivePurgeDateTimeHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1609,"I")))
 S TIU("Tiu","archivePurgeDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1609,"I")))
 S TIU("Tiu","deletedBy")=$G(TIUARR(FNBR1,IENS1,1610,"E"))
 S TIU("Tiu","deletedById")=$G(TIUARR(FNBR1,IENS1,1610,"I"))
 S TIU("Tiu","deletedByNPI")=$$GET1^DIQ(200,TIU("Tiu","deletedById")_",",41.99) ;NPI
 S TIU("Tiu","deletedByResId")=$$RESID^SYNDHP69("V",SITE,200,TIU("Tiu","deletedById"))
 S TIU("Tiu","deletionDate")=$G(TIUARR(FNBR1,IENS1,1611,"E"))
 S TIU("Tiu","deletionDateFM")=$G(TIUARR(FNBR1,IENS1,1611,"I"))
 S TIU("Tiu","deletionDateHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,1611,"I")))
 S TIU("Tiu","deletionDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,1611,"I")))
 S TIU("Tiu","reasonForDeletion")=$G(TIUARR(FNBR1,IENS1,1612,"E"))
 S TIU("Tiu","reasonForDeletionCd")=$G(TIUARR(FNBR1,IENS1,1612,"I"))
 S TIU("Tiu","administrativeClosureMode")=$G(TIUARR(FNBR1,IENS1,1613,"E"))
 S TIU("Tiu","administrativeClosureModeCd")=$G(TIUARR(FNBR1,IENS1,1613,"I"))
 S TIU("Tiu","subjectOptionalDescription")=$G(TIUARR(FNBR1,IENS1,1701,"E"))
 S TIU("Tiu","vbcLineCount")=$G(TIUARR(FNBR1,IENS1,1801,"E"))
 S TIU("Tiu","idParent")=$G(TIUARR(FNBR1,IENS1,2101,"E"))
 S TIU("Tiu","idParentId")=$G(TIUARR(FNBR1,IENS1,2101,"I"))
 S TIU("Tiu","visitId")=$G(TIUARR(FNBR1,IENS1,15001,"E"))
 S TIU("Tiu","procedureSummaryCode")=$G(TIUARR(FNBR1,IENS1,70201,"E"))
 S TIU("Tiu","procedureSummaryCodeCd")=$G(TIUARR(FNBR1,IENS1,70201,"I"))
 S TIU("Tiu","dateTimePerformed")=$G(TIUARR(FNBR1,IENS1,70202,"E"))
 S TIU("Tiu","dateTimePerformedFM")=$G(TIUARR(FNBR1,IENS1,70202,"I"))
 S TIU("Tiu","dateTimePerformedHL7")=$$FMTHL7^XLFDT($G(TIUARR(FNBR1,IENS1,70202,"I")))
 S TIU("Tiu","dateTimePerformedFHIR")=$$FMTFHIR^SYNDHPUTL($G(TIUARR(FNBR1,IENS1,70202,"I")))
 S TIU("Tiu","vhaEnterpriseStandardTitle")=$G(TIUARR(FNBR1,IENS1,89261,"E"))
 ;
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TIU")
 ;
 I $G(RETJSON)="J" D
 . D TOJASON^SYNDHPUTL(.TIU,.TIUJ)
 . S TIUJ=$$UES^XLFJSON(TIUJ) ;change \\n to \n
 ;
 QUIT
 ;
NOTSTAT(X) ; Note status mapping
 ; the VistA status must map to one of the following FHIR statii
 ;   preliminary | final | amended | entered-in-error
 ;
 ; X is External Status value (8925, .05) converted to lower case
 ;
 ;  statii from TIU(8925.6
 ;    1)="UNDICTATED^preliminary"
 ;    2)="UNTRANSCRIBED^preliminary"
 ;    3)="UNRELEASED^preliminary"
 ;    4)="UNVERIFIED^preliminary"
 ;    5)="UNSIGNED^preliminary"
 ;    6)="UNCOSIGNED^preliminary"
 ;    7)="COMPLETED^final"
 ;    8)="AMENDED^amended"
 ;    9)="PURGED^entered-in-error"
 ;    10)="TEST^entered-in-error"
 ;    11)="ACTIVE^preliminary"
 ;    13)="INACTIVE^preliminary"
 ;    14)="DELETED^enered-in-error"
 ;    15)="RETRACTED^entered-in-error"
 ;
 ; converted to values returned by TIU RPC
 ;
 N XNS
 S XNS("active")="preliminary"
 S XNS("amended")="amended"
 S XNS("completed")="final"
 S XNS("deleted")="enered-in-error"
 S XNS("inactive")="preliminary"
 S XNS("purged")="entered-in-error"
 S XNS("retracted")="entered-in-error"
 S XNS("test")="entered-in-error"
 S XNS("uncosigned")="preliminary"
 S XNS("undictated")="preliminary"
 S XNS("unreleased")="preliminary"
 S XNS("unsigned")="preliminary"
 S XNS("untranscribed")="preliminary"
 S XNS("unverified")="preliminary"
 ;
 QUIT:$D(XNS(X)) $P(XNS(X),U)
 QUIT "error - composition status not recognised"
 ;
