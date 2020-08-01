SYNDHP28 ; HC/art - HealthConcourse - get Patient Prescription data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1PATRX(PATRX,PATRXIEN,RETJSON,PATRXJ) ;get Patient Prescription record
 ;inputs: PATRXIEN - Patient Prescription IEN
 ;        RETJSON - J = Return JSON
 ;output: PATRX  - array of Patient Prescription data, by reference
 ;        PATRXJ - JSON structure of Patient Prescription data, by reference
 ;
 I $G(DEBUG) W !,"------------------------ Patient Prescription --------------------------",!
 N S S S="_"
 N C S C=","
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=52 ;PRESCRIPTION
 N FNBR2 S FNBR2=52.4 ;RX VERIFY
 N FNBR3 S FNBR3=52.032 ;LABEL DATE/TIME
 N FNBR4 S FNBR4=52.03 ;DRUG ALLERGY INGREDIENTS
 N FNBR5 S FNBR5=52.037 ;MEDICATION ROUTES
 N FNBR6 S FNBR6=52.038 ;SCHEDULES
 N FNBR7 S FNBR7=52.3 ;ACTIVITY LOG
 N FNBR8 S FNBR8=52.1 ;REFILL
 N FNBR9 S FNBR9=52.25 ;REJECT INFO
 N FNBR10 S FNBR10=52.2 ;PARTIAL DATE
 N FNBR11 S FNBR11=52.07 ;RETURN TO STOCK LOG
 N FNBR12 S FNBR12=52.0107 ;COPAY ACTIVITY LOG
 N FNBR13 S FNBR13=52.0113 ;MEDICATION INSTRUCTIONS
 N FNBR14 S FNBR14=52.01 ;CMOP EVENT
 N FNBR15 S FNBR15=52.052311 ;ICD DIAGNOSIS
 N FNBR16 S FNBR16=52.34 ;ACTIVITY LOG:OTHER COMMENTS
 N FNBR17 S FNBR17=52.2551 ;REJECT INFO:COMMENTS
 N IENS1 S IENS1=PATRXIEN_","
 ;
 N PATRXARR,PATRXERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","PATRXARR","PATRXERR")
 I $G(DEBUG) W $$ZW^SYNDHPUTL("PATRXARR")
 I $G(DEBUG),$D(PATRXERR) W !,">>ERROR<<" W !,$$ZW^SYNDHPUTL("PATRXERR")
 I $D(PATRXERR) D  QUIT
 . S PATRX("Patrx","ERROR")=PATRXIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PATRX,.PATRXJ)
 S PATRX("Patrx","patrxIen")=PATRXIEN
 S PATRX("Patrx","resourceType")="PatientPrescription"
 S PATRX("Patrx","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATRXIEN)
 S PATRX("Patrx","rx")=$G(PATRXARR(FNBR1,IENS1,.01,"E"))
 S PATRX("Patrx","issueDate")=$G(PATRXARR(FNBR1,IENS1,1,"E"))
 S PATRX("Patrx","issueDateFM")=$G(PATRXARR(FNBR1,IENS1,1,"I"))
 S PATRX("Patrx","issueDateHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,1,"I")))
 S PATRX("Patrx","issueDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,1,"I")))
 S PATRX("Patrx","patient")=$G(PATRXARR(FNBR1,IENS1,2,"E"))
 S PATRX("Patrx","patientId")=$G(PATRXARR(FNBR1,IENS1,2,"I"))
 S PATRX("Patrx","patientICN")=$$GET1^DIQ(2,PATRX("Patrx","patientId")_",",991.1)
 S PATRX("Patrx","patientStatus")=$G(PATRXARR(FNBR1,IENS1,3,"E"))
 S PATRX("Patrx","patientStatusId")=$G(PATRXARR(FNBR1,IENS1,3,"I"))
 S PATRX("Patrx","provider")=$G(PATRXARR(FNBR1,IENS1,4,"E"))
 S PATRX("Patrx","providerId")=$G(PATRXARR(FNBR1,IENS1,4,"I"))
 S PATRX("Patrx","providerNPI")=$$GET1^DIQ(200,PATRX("Patrx","providerId")_",",41.99) ;NPI
 S PATRX("Patrx","providerResId")=$$RESID^SYNDHP69("V",SITE,200,PATRX("Patrx","providerId"))
 S PATRX("Patrx","clinic")=$G(PATRXARR(FNBR1,IENS1,5,"E"))
 S PATRX("Patrx","clinicId")=$G(PATRXARR(FNBR1,IENS1,5,"I"))
 S PATRX("Patrx","drug")=$G(PATRXARR(FNBR1,IENS1,6,"E"))
 S PATRX("Patrx","drugId")=$G(PATRXARR(FNBR1,IENS1,6,"I"))
 S PATRX("Patrx","rxnorm")=$$GETRXN^SYNDHPUTL(PATRX("Patrx","drugId"))
 S PATRX("Patrx","tradeName")=$G(PATRXARR(FNBR1,IENS1,6.5,"E"))
 S PATRX("Patrx","qty")=$G(PATRXARR(FNBR1,IENS1,7,"E"))
 S PATRX("Patrx","daysSupply")=$G(PATRXARR(FNBR1,IENS1,8,"E"))
 S PATRX("Patrx","nbrOfRefills")=$G(PATRXARR(FNBR1,IENS1,9,"E"))
 S PATRX("Patrx","sig")=$G(PATRXARR(FNBR1,IENS1,10,"E"))
 S PATRX("Patrx","oerrSig")=$G(PATRXARR(FNBR1,IENS1,10.1,"E"))
 S PATRX("Patrx","oerrSigCd")=$G(PATRXARR(FNBR1,IENS1,10.1,"I"))
 S PATRX("Patrx","orderConverted")=$G(PATRXARR(FNBR1,IENS1,10.3,"E"))
 S PATRX("Patrx","orderConvertedCd")=$G(PATRXARR(FNBR1,IENS1,10.3,"I"))
 S PATRX("Patrx","copies")=$G(PATRXARR(FNBR1,IENS1,10.6,"E"))
 S PATRX("Patrx","mailWindow")=$G(PATRXARR(FNBR1,IENS1,11,"E"))
 S PATRX("Patrx","mailWindowCd")=$G(PATRXARR(FNBR1,IENS1,11,"I"))
 S PATRX("Patrx","remarks")=$G(PATRXARR(FNBR1,IENS1,12,"E"))
 S PATRX("Patrx","administeredInClinic")=$G(PATRXARR(FNBR1,IENS1,14,"E"))
 S PATRX("Patrx","administeredInClinicCd")=$G(PATRXARR(FNBR1,IENS1,14,"I"))
 S PATRX("Patrx","enteredBy")=$G(PATRXARR(FNBR1,IENS1,16,"E"))
 S PATRX("Patrx","enteredById")=$G(PATRXARR(FNBR1,IENS1,16,"I"))
 S PATRX("Patrx","unitPriceOfDrug")=$G(PATRXARR(FNBR1,IENS1,17,"E"))
 S PATRX("Patrx","division")=$G(PATRXARR(FNBR1,IENS1,20,"E"))
 S PATRX("Patrx","divisionId")=$G(PATRXARR(FNBR1,IENS1,20,"I"))
 S PATRX("Patrx","loginDate")=$G(PATRXARR(FNBR1,IENS1,21,"E"))
 S PATRX("Patrx","loginDateFM")=$G(PATRXARR(FNBR1,IENS1,21,"I"))
 S PATRX("Patrx","loginDateHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,21,"I")))
 S PATRX("Patrx","loginDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,21,"I")))
 S PATRX("Patrx","fillDate")=$G(PATRXARR(FNBR1,IENS1,22,"E"))
 S PATRX("Patrx","fillDateFM")=$G(PATRXARR(FNBR1,IENS1,22,"I"))
 S PATRX("Patrx","fillDateHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,22,"I")))
 S PATRX("Patrx","fillDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,22,"I")))
 S PATRX("Patrx","pharmacist")=$G(PATRXARR(FNBR1,IENS1,23,"E"))
 S PATRX("Patrx","pharmacistId")=$G(PATRXARR(FNBR1,IENS1,23,"I"))
 S PATRX("Patrx","pharmacistResId")=$$RESID^SYNDHP69("V",SITE,200,PATRX("Patrx","pharmacistId"))
 S PATRX("Patrx","lot")=$G(PATRXARR(FNBR1,IENS1,24,"E"))
 S PATRX("Patrx","dispensedDate")=$G(PATRXARR(FNBR1,IENS1,25,"E"))
 S PATRX("Patrx","dispensedDateFM")=$G(PATRXARR(FNBR1,IENS1,25,"I"))
 S PATRX("Patrx","dispensedDateHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,25,"I")))
 S PATRX("Patrx","dispensedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,25,"I")))
 S PATRX("Patrx","expirationDate")=$G(PATRXARR(FNBR1,IENS1,26,"E"))
 S PATRX("Patrx","expirationDateFM")=$G(PATRXARR(FNBR1,IENS1,26,"I"))
 S PATRX("Patrx","expirationDateHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,26,"I")))
 S PATRX("Patrx","expirationDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,26,"I")))
 S PATRX("Patrx","cancelDate")=$G(PATRXARR(FNBR1,IENS1,26.1,"E"))
 S PATRX("Patrx","cancelDateFM")=$G(PATRXARR(FNBR1,IENS1,26.1,"I"))
 S PATRX("Patrx","cancelDateHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,26.1,"I")))
 S PATRX("Patrx","cancelDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,26.1,"I")))
 S PATRX("Patrx","ndc")=$G(PATRXARR(FNBR1,IENS1,27,"E"))
 S PATRX("Patrx","manufacturer")=$G(PATRXARR(FNBR1,IENS1,28,"E"))
 S PATRX("Patrx","drugExpirationDate")=$G(PATRXARR(FNBR1,IENS1,29,"E"))
 S PATRX("Patrx","drugExpirationDateFM")=$G(PATRXARR(FNBR1,IENS1,29,"I"))
 S PATRX("Patrx","drugExpirationDateHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,29,"I")))
 S PATRX("Patrx","drugExpirationDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,29,"I")))
 S PATRX("Patrx","genericProvider")=$G(PATRXARR(FNBR1,IENS1,30,"E"))
 S PATRX("Patrx","releasedDateTime")=$G(PATRXARR(FNBR1,IENS1,31,"E"))
 S PATRX("Patrx","releasedDateTimeFM")=$G(PATRXARR(FNBR1,IENS1,31,"I"))
 S PATRX("Patrx","releasedDateTimeHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,31,"I")))
 S PATRX("Patrx","releasedDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,31,"I")))
 S PATRX("Patrx","returnedToStock")=$G(PATRXARR(FNBR1,IENS1,32.1,"E"))
 S PATRX("Patrx","returnedToStockFM")=$G(PATRXARR(FNBR1,IENS1,32.1,"I"))
 S PATRX("Patrx","returnedToStockHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,32.1,"I")))
 S PATRX("Patrx","returnedToStockFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,32.1,"I")))
 S PATRX("Patrx","reprint")=$G(PATRXARR(FNBR1,IENS1,32.2,"E"))
 S PATRX("Patrx","reprintCd")=$G(PATRXARR(FNBR1,IENS1,32.2,"I"))
 S PATRX("Patrx","bingoWaitTime")=$G(PATRXARR(FNBR1,IENS1,32.3,"E"))
 S PATRX("Patrx","severity")=$G(PATRXARR(FNBR1,IENS1,33,"E"))
 S PATRX("Patrx","affectedMedication")=$G(PATRXARR(FNBR1,IENS1,34,"E"))
 S PATRX("Patrx","drugAllergyIndication")=$G(PATRXARR(FNBR1,IENS1,34.1,"E"))
 S PATRX("Patrx","drugAllergyIndicationCd")=$G(PATRXARR(FNBR1,IENS1,34.1,"I"))
 S PATRX("Patrx","methodOfPickUp")=$G(PATRXARR(FNBR1,IENS1,35,"E"))
 S PATRX("Patrx","archived")=$G(PATRXARR(FNBR1,IENS1,36,"E"))
 S PATRX("Patrx","archivedCd")=$G(PATRXARR(FNBR1,IENS1,36,"I"))
 S PATRX("Patrx","finishingPerson")=$G(PATRXARR(FNBR1,IENS1,38,"E"))
 S PATRX("Patrx","finishingPersonId")=$G(PATRXARR(FNBR1,IENS1,38,"I"))
 S PATRX("Patrx","fillingPerson")=$G(PATRXARR(FNBR1,IENS1,38.1,"E"))
 S PATRX("Patrx","fillingPersonId")=$G(PATRXARR(FNBR1,IENS1,38.1,"I"))
 S PATRX("Patrx","checkingPharmacist")=$G(PATRXARR(FNBR1,IENS1,38.2,"E"))
 S PATRX("Patrx","checkingPharmacistId")=$G(PATRXARR(FNBR1,IENS1,38.2,"I"))
 S PATRX("Patrx","checkingPharmacistResId")=$$RESID^SYNDHP69("V",SITE,200,PATRX("Patrx","checkingPharmacistId"))
 S PATRX("Patrx","finishDateTime")=$G(PATRXARR(FNBR1,IENS1,38.3,"E"))
 S PATRX("Patrx","finishDateTimeFM")=$G(PATRXARR(FNBR1,IENS1,38.3,"I"))
 S PATRX("Patrx","finishDateTimeHL7")=$$FMTHL7^XLFDT($G(PATRXARR(FNBR1,IENS1,38.3,"I")))
 S PATRX("Patrx","finishDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATRXARR(FNBR1,IENS1,38.3,"I")))
 S PATRX("Patrx","providerComments")=""
 N Z S Z=""
 F  S Z=$O(PATRXARR(FNBR1,IENS1,39,Z)) QUIT:'+Z  D
 . S PATRX("Patrx","providerComments")=PATRX("Patrx","providerComments")_$G(PATRXARR(FNBR1,IENS1,39,Z))
 S PATRX("Patrx","pharmacyInstructions")=""
 N Z S Z=""
 F  S Z=$O(PATRXARR(FNBR1,IENS1,39.1,Z)) QUIT:'+Z  D
 . S PATRX("Patrx","pharmacyInstructions")=PATRX("Patrx","pharmacyInstructions")_$G(PATRXARR(FNBR1,IENS1,39.1,Z))
 ;
 D RXCONT1^SYNDHP28A
 D RXCONT2^SYNDHP28B
 D RXCONT3^SYNDHP28C
 D RXCONT4^SYNDHP28D
 ;
 I $G(DEBUG) W !,$$ZW^SYNDHPUTL("PATRX")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PATRX,.PATRXJ)
 ;
 QUIT
 ;
