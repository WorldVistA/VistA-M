SYNDHP23 ; HC/art - HealthConcourse - get visit provider data ;08/30/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1VPROV(VPROV,VPROVIEN,RETJSON,VPROVJ) ;get one V Provider record
 ;inputs: VPROVIEN - V Provider IEN
 ;        RETJSON - J = Return JSON
 ;output: VPROV  - array of V Provider data, by reference
 ;        VPROVJ - JSON structure of V Provider data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- V Provider -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=9000010.06 ;V PROVIDER
 N IENS1 S IENS1=VPROVIEN_","
 ;
 N VPROVARR,VPROVERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","VPROVARR","VPROVERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VPROVARR")
 I $G(DEBUG),$D(VPROVERR) W ">>ERROR<<",! W $$ZW^SYNDHPUTL("VPROVERR")
 I $D(VPROVERR) D  QUIT
 . S VPROV("Vprov","ERROR")=VPROVIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VPROV,.VPROVJ)
 S VPROV("Vprov","vprovIen")=VPROVIEN
 S VPROV("Vprov","resourceType")="Encounter"
 S VPROV("Vprov","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VPROVIEN)
 S VPROV("Vprov","provider")=$G(VPROVARR(FNBR1,IENS1,.01,"E"))
 S VPROV("Vprov","providerId")=$G(VPROVARR(FNBR1,IENS1,.01,"I"))
 S VPROV("Vprov","providerNPI")=$$GET1^DIQ(200,VPROV("Vprov","providerId")_",",41.99) ;NPI
 S VPROV("Vprov","providerResId")=$$RESID^SYNDHP69("V",SITE,200,VPROV("Vprov","providerId"))
 S VPROV("Vprov","patientName")=$G(VPROVARR(FNBR1,IENS1,.02,"E"))
 S VPROV("Vprov","patientNameId")=$G(VPROVARR(FNBR1,IENS1,.02,"I"))
 S VPROV("Vprov","patientICN")=$$GET1^DIQ(2,VPROV("Vprov","patientNameId")_",",991.1)
 S VPROV("Vprov","visit")=$G(VPROVARR(FNBR1,IENS1,.03,"E"))
 S VPROV("Vprov","visitId")=$G(VPROVARR(FNBR1,IENS1,.03,"I"))
 S VPROV("Vprov","visitFM")=$$GET1^DIQ(9000010,VPROV("Vprov","visitId")_",",.01,"I")
 S VPROV("Vprov","visitHL7")=$$FMTHL7^XLFDT(VPROV("Vprov","visitFM"))
 S VPROV("Vprov","visitFHIR")=$$FMTFHIR^SYNDHPUTL(VPROV("Vprov","visitFM"))
 S VPROV("Vprov","visitResId")=$$RESID^SYNDHP69("V",SITE,9000010,VPROV("Vprov","visitId"))
 S VPROV("Vprov","primarySecondary")=$G(VPROVARR(FNBR1,IENS1,.04,"E"))
 S VPROV("Vprov","primarySecondaryCd")=$G(VPROVARR(FNBR1,IENS1,.04,"I"))
 S VPROV("Vprov","primarySecondarySc")=$$SENTENCE^XLFSTR(VPROV("Vprov","primarySecondary"))
 S VPROV("Vprov","operatingAttending")=$G(VPROVARR(FNBR1,IENS1,.05,"E"))
 S VPROV("Vprov","operatingAttendingCd")=$G(VPROVARR(FNBR1,IENS1,.05,"I"))
 S VPROV("Vprov","personClass")=$G(VPROVARR(FNBR1,IENS1,.06,"E"))
 S VPROV("Vprov","personClassId")=$G(VPROVARR(FNBR1,IENS1,.06,"I"))
 S VPROV("Vprov","eventDateAndTime")=$G(VPROVARR(FNBR1,IENS1,1201,"E"))
 S VPROV("Vprov","eventDateAndTimeFM")=$G(VPROVARR(FNBR1,IENS1,1201,"I"))
 S VPROV("Vprov","eventDateAndTimeHL7")=$$FMTHL7^XLFDT($G(VPROVARR(FNBR1,IENS1,1201,"I")))
 S VPROV("Vprov","eventDateAndTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(VPROVARR(FNBR1,IENS1,1201,"I")))
 S VPROV("Vprov","editedFlag")=$G(VPROVARR(FNBR1,IENS1,80101,"E"))
 S VPROV("Vprov","editedFlagCd")=$G(VPROVARR(FNBR1,IENS1,80101,"I"))
 S VPROV("Vprov","auditTrail")=$G(VPROVARR(FNBR1,IENS1,80102,"E"))
 S VPROV("Vprov","comments")=$G(VPROVARR(FNBR1,IENS1,81101,"E"))
 S VPROV("Vprov","verified")=$G(VPROVARR(FNBR1,IENS1,81201,"E"))
 S VPROV("Vprov","verifiedCd")=$G(VPROVARR(FNBR1,IENS1,81201,"I"))
 S VPROV("Vprov","package")=$G(VPROVARR(FNBR1,IENS1,81202,"E"))
 S VPROV("Vprov","packageId")=$G(VPROVARR(FNBR1,IENS1,81202,"I"))
 S VPROV("Vprov","dataSource")=$G(VPROVARR(FNBR1,IENS1,81203,"E"))
 S VPROV("Vprov","dataSourceId")=$G(VPROVARR(FNBR1,IENS1,81203,"I"))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VPROV")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VPROV,.VPROVJ)
 ;
 QUIT
 ;
