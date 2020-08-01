SYNDHP13 ; HC/art - HealthConcourse - get visit and pov data ;08/27/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1VISIT(VISIT,VISITIEN,RETJSON,VISITJ) ;get one Visit record
 ;inputs: VISITIEN - Visit IEN
 ;        RETJSON - J = Return JSON
 ;output: VISIT  - array of Visit data, by reference
 ;        VISITJ - JSON structure of Visit data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Visit -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=9000010 ;VISIT
 N IENS1 S IENS1=VISITIEN_","
 N VISITARR,VISITERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","VISITARR","VISITERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VISITARR")
 I $G(DEBUG),$D(VISITERR) W ">>ERROR<<",! W $$ZW^SYNDHPUTL("VISITERR")
 I $D(VISITERR) D  QUIT
 . S VISIT("Visit","ERROR")=VISITIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VISIT,.VISITJ)
 S VISIT("Visit","visitIen")=VISITIEN
 S VISIT("Visit","resourceType")="Encounter"
 S VISIT("Visit","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VISITIEN)
 S VISIT("Visit","visitAdmitDateTime")=$G(VISITARR(FNBR1,IENS1,.01,"E"))
 S VISIT("Visit","visitAdmitDateTimeFM")=$G(VISITARR(FNBR1,IENS1,.01,"I"))
 S VISIT("Visit","visitAdmitDateTimeHL7")=$$FMTHL7^XLFDT($G(VISITARR(FNBR1,IENS1,.01,"I")))
 S VISIT("Visit","visitAdmitDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(VISITARR(FNBR1,IENS1,.01,"I")))
 S VISIT("Visit","dateVisitCreated")=$G(VISITARR(FNBR1,IENS1,.02,"E"))
 S VISIT("Visit","dateVisitCreatedFM")=$G(VISITARR(FNBR1,IENS1,.02,"I"))
 S VISIT("Visit","dateVisitCreatedHL7")=$$FMTHL7^XLFDT($G(VISITARR(FNBR1,IENS1,.02,"I")))
 S VISIT("Visit","dateVisitCreatedFHIR")=$$FMTFHIR^SYNDHPUTL($G(VISITARR(FNBR1,IENS1,.02,"I")))
 S VISIT("Visit","type")=$G(VISITARR(FNBR1,IENS1,.03,"E"))
 S VISIT("Visit","typeCd")=$G(VISITARR(FNBR1,IENS1,.03,"I"))
 S VISIT("Visit","patientName")=$G(VISITARR(FNBR1,IENS1,.05,"E"))
 S VISIT("Visit","patientNameId")=$G(VISITARR(FNBR1,IENS1,.05,"I"))
 S VISIT("Visit","patientICN")=$$GET1^DIQ(2,VISIT("Visit","patientNameId")_",",991.1)
 S VISIT("Visit","locOfEncounter")=$G(VISITARR(FNBR1,IENS1,.06,"E"))
 S VISIT("Visit","locOfEncounterId")=$G(VISITARR(FNBR1,IENS1,.06,"I"))
 S VISIT("Visit","serviceCategory")=$G(VISITARR(FNBR1,IENS1,.07,"E"))
 S VISIT("Visit","serviceCategoryCd")=$G(VISITARR(FNBR1,IENS1,.07,"I"))
 S VISIT("Visit","dssId")=$G(VISITARR(FNBR1,IENS1,.08,"E"))
 S VISIT("Visit","dssIdId")=$G(VISITARR(FNBR1,IENS1,.08,"I"))
 S VISIT("Visit","dependentEntryCount")=$G(VISITARR(FNBR1,IENS1,.09,"E"))
 S VISIT("Visit","deleteFlag")=$G(VISITARR(FNBR1,IENS1,.11,"E"))
 S VISIT("Visit","deleteFlagCd")=$G(VISITARR(FNBR1,IENS1,.11,"I"))
 S VISIT("Visit","parentVisitLink")=$G(VISITARR(FNBR1,IENS1,.12,"E"))
 S VISIT("Visit","parentVisitLinkId")=$G(VISITARR(FNBR1,IENS1,.12,"I"))
 S VISIT("Visit","dateLastModified")=$G(VISITARR(FNBR1,IENS1,.13,"E"))
 S VISIT("Visit","dateLastModifiedFM")=$G(VISITARR(FNBR1,IENS1,.13,"I"))
 S VISIT("Visit","dateLastModifiedHL7")=$$FMTHL7^XLFDT($G(VISITARR(FNBR1,IENS1,.13,"I")))
 S VISIT("Visit","dateLastModifiedFHIR")=$$FMTFHIR^SYNDHPUTL($G(VISITARR(FNBR1,IENS1,.13,"I")))
 S VISIT("Visit","checkOutDateTime")=$G(VISITARR(FNBR1,IENS1,.18,"E"))
 S VISIT("Visit","checkOutDateTimeFM")=$G(VISITARR(FNBR1,IENS1,.18,"I"))
 S VISIT("Visit","checkOutDateTimeHL7")=$$FMTHL7^XLFDT($G(VISITARR(FNBR1,IENS1,.18,"I")))
 S VISIT("Visit","checkOutDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(VISITARR(FNBR1,IENS1,.18,"I")))
 S VISIT("Visit","eligibility")=$G(VISITARR(FNBR1,IENS1,.21,"E"))
 S VISIT("Visit","eligibilityId")=$G(VISITARR(FNBR1,IENS1,.21,"I"))
 S VISIT("Visit","hospitalLocation")=$G(VISITARR(FNBR1,IENS1,.22,"E"))
 S VISIT("Visit","hospitalLocationId")=$G(VISITARR(FNBR1,IENS1,.22,"I"))
 S VISIT("Visit","createdByUser")=$G(VISITARR(FNBR1,IENS1,.23,"E"))
 S VISIT("Visit","createdByUserId")=$G(VISITARR(FNBR1,IENS1,.23,"I"))
 S VISIT("Visit","optionUsedToCreate")=$G(VISITARR(FNBR1,IENS1,.24,"E"))
 S VISIT("Visit","optionUsedToCreateId")=$G(VISITARR(FNBR1,IENS1,.24,"I"))
 S VISIT("Visit","protocol")=$G(VISITARR(FNBR1,IENS1,.25,"E"))
 S VISIT("Visit","protocolId")=$G(VISITARR(FNBR1,IENS1,.25,"I"))
 S VISIT("Visit","pfssAccountReference")=$G(VISITARR(FNBR1,IENS1,.26,"E"))
 S VISIT("Visit","pfssAccountReferenceId")=$G(VISITARR(FNBR1,IENS1,.26,"I"))
 S VISIT("Visit","outsideLocation")=$G(VISITARR(FNBR1,IENS1,2101,"E"))
 S VISIT("Visit","visitId")=$G(VISITARR(FNBR1,IENS1,15001,"E"))
 S VISIT("Visit","patientStatusInOut")=$G(VISITARR(FNBR1,IENS1,15002,"E"))
 S VISIT("Visit","patientStatusInOutCd")=$G(VISITARR(FNBR1,IENS1,15002,"I"))
 S VISIT("Visit","encounterType")=$G(VISITARR(FNBR1,IENS1,15003,"E"))
 S VISIT("Visit","encounterTypeCd")=$G(VISITARR(FNBR1,IENS1,15003,"I"))
 S VISIT("Visit","serviceConnected")=$G(VISITARR(FNBR1,IENS1,80001,"E"))
 S VISIT("Visit","serviceConnectedCd")=$G(VISITARR(FNBR1,IENS1,80001,"I"))
 S VISIT("Visit","agentOrangeExposure")=$G(VISITARR(FNBR1,IENS1,80002,"E"))
 S VISIT("Visit","agentOrangeExposureCd")=$G(VISITARR(FNBR1,IENS1,80002,"I"))
 S VISIT("Visit","ionizingRadiationExposure")=$G(VISITARR(FNBR1,IENS1,80003,"E"))
 S VISIT("Visit","ionizingRadiationExposureCd")=$G(VISITARR(FNBR1,IENS1,80003,"I"))
 S VISIT("Visit","swAsiaConditions")=$G(VISITARR(FNBR1,IENS1,80004,"E"))
 S VISIT("Visit","swAsiaConditionsCd")=$G(VISITARR(FNBR1,IENS1,80004,"I"))
 S VISIT("Visit","militarySexualTrauma")=$G(VISITARR(FNBR1,IENS1,80005,"E"))
 S VISIT("Visit","militarySexualTraumaCd")=$G(VISITARR(FNBR1,IENS1,80005,"I"))
 S VISIT("Visit","headAndOrNeckCancer")=$G(VISITARR(FNBR1,IENS1,80006,"E"))
 S VISIT("Visit","headAndOrNeckCancerCd")=$G(VISITARR(FNBR1,IENS1,80006,"I"))
 S VISIT("Visit","combatVeteran")=$G(VISITARR(FNBR1,IENS1,80007,"E"))
 S VISIT("Visit","combatVeteranCd")=$G(VISITARR(FNBR1,IENS1,80007,"I"))
 S VISIT("Visit","proj112Shad")=$G(VISITARR(FNBR1,IENS1,80008,"E"))
 S VISIT("Visit","proj112ShadCd")=$G(VISITARR(FNBR1,IENS1,80008,"I"))
 S VISIT("Visit","serviceConnectionEditFlag")=$G(VISITARR(FNBR1,IENS1,80011,"E"))
 S VISIT("Visit","serviceConnectionEditFlagCd")=$G(VISITARR(FNBR1,IENS1,80011,"I"))
 S VISIT("Visit","agentOrangeEditFlag")=$G(VISITARR(FNBR1,IENS1,80012,"E"))
 S VISIT("Visit","agentOrangeEditFlagCd")=$G(VISITARR(FNBR1,IENS1,80012,"I"))
 S VISIT("Visit","ionizingRadiationEditFlag")=$G(VISITARR(FNBR1,IENS1,80013,"E"))
 S VISIT("Visit","ionizingRadiationEditFlagCd")=$G(VISITARR(FNBR1,IENS1,80013,"I"))
 S VISIT("Visit","swAsiaConditionsEditFlag")=$G(VISITARR(FNBR1,IENS1,80014,"E"))
 S VISIT("Visit","swAsiaConditionsEditFlagCd")=$G(VISITARR(FNBR1,IENS1,80014,"I"))
 S VISIT("Visit","mstEditFlag")=$G(VISITARR(FNBR1,IENS1,80015,"E"))
 S VISIT("Visit","mstEditFlagCd")=$G(VISITARR(FNBR1,IENS1,80015,"I"))
 S VISIT("Visit","headAndNeckCancerEditFlag")=$G(VISITARR(FNBR1,IENS1,80016,"E"))
 S VISIT("Visit","headAndNeckCancerEditFlagCd")=$G(VISITARR(FNBR1,IENS1,80016,"I"))
 S VISIT("Visit","combatVeteranEditFlag")=$G(VISITARR(FNBR1,IENS1,80017,"E"))
 S VISIT("Visit","combatVeteranEditFlagCd")=$G(VISITARR(FNBR1,IENS1,80017,"I"))
 S VISIT("Visit","proj112ShadEditFlag")=$G(VISITARR(FNBR1,IENS1,80018,"E"))
 S VISIT("Visit","proj112ShadEditFlagCd")=$G(VISITARR(FNBR1,IENS1,80018,"I"))
 S VISIT("Visit","comments")=$G(VISITARR(FNBR1,IENS1,81101,"E"))
 S VISIT("Visit","package")=$G(VISITARR(FNBR1,IENS1,81202,"E"))
 S VISIT("Visit","packageId")=$G(VISITARR(FNBR1,IENS1,81202,"I"))
 S VISIT("Visit","dataSource")=$G(VISITARR(FNBR1,IENS1,81203,"E"))
 S VISIT("Visit","dataSourceId")=$G(VISITARR(FNBR1,IENS1,81203,"I"))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VISIT")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VISIT,.VISITJ)
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1VPOV(VPOV,VPOVIEN,RETJSON,VPOVJ) ;get one V POV record
 ;inputs: VPOVIEN - Vpov IEN
 ;        RETJSON - J = Return JSON
 ;output: VPOV  - array of V POV data, by reference
 ;        VPOVJ - JSON structure of V POV data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- V POV -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=9000010.07 ;V POV
 N IENS1 S IENS1=VPOVIEN_","
 N VPOVARR,VPOVERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","VPOVARR","VPOVERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VPOVARR")
 I $G(DEBUG),$D(VPOVERR) W ">>ERROR<<",! W $$ZW^SYNDHPUTL("VPOVERR")
 I $D(VPOVERR) D  QUIT
 . S VPOV("V POV","ERROR")=VPOVIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VPOV,.VPOVJ)
 S VPOV("V POV","vpovIen")=VPOVIEN
 S VPOV("V POV","resourceType")="Encounter"
 S VPOV("V POV","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VPOVIEN)
 S VPOV("V POV","pov")=$G(VPOVARR(FNBR1,IENS1,.01,"E"))
 S VPOV("V POV","povId")=$G(VPOVARR(FNBR1,IENS1,.01,"I"))
 S VPOV("V POV","povDesc")=$P($$ICDDX^ICDEX(VPOV("V POV","pov")),U,4)
 S VPOV("V POV","icdNarrative")=$G(VPOVARR(FNBR1,IENS1,.019,"E"))
 S VPOV("V POV","patientName")=$G(VPOVARR(FNBR1,IENS1,.02,"E"))
 S VPOV("V POV","patientNameId")=$G(VPOVARR(FNBR1,IENS1,.02,"I"))
 S VPOV("V POV","patientICN")=$$GET1^DIQ(2,VPOV("V POV","patientNameId")_",",991.1)
 S VPOV("V POV","visit")=$G(VPOVARR(FNBR1,IENS1,.03,"E"))
 S VPOV("V POV","visitId")=$G(VPOVARR(FNBR1,IENS1,.03,"I"))
 S VPOV("V POV","visitFM")=$$GET1^DIQ(9000010,VPOV("V POV","visitId")_",",.01,"I")
 S VPOV("V POV","visitHL7")=$$FMTHL7^XLFDT(VPOV("V POV","visitFM"))
 S VPOV("V POV","visitFHIR")=$$FMTFHIR^SYNDHPUTL(VPOV("V POV","visitFM"))
 S VPOV("V POV","visitResId")=$$RESID^SYNDHP69("V",SITE,9000010,VPOV("V POV","visitId"))
 S VPOV("V POV","providerNarrative")=$G(VPOVARR(FNBR1,IENS1,.04,"E"))
 S VPOV("V POV","providerNarrativeId")=$G(VPOVARR(FNBR1,IENS1,.04,"I"))
 S VPOV("V POV","modifier")=$G(VPOVARR(FNBR1,IENS1,.06,"E"))
 S VPOV("V POV","modifierCd")=$G(VPOVARR(FNBR1,IENS1,.06,"I"))
 S VPOV("V POV","primarySecondary")=$G(VPOVARR(FNBR1,IENS1,.12,"E"))
 S VPOV("V POV","primarySecondaryCd")=$G(VPOVARR(FNBR1,IENS1,.12,"I"))
 S VPOV("V POV","dateOfInjury")=$G(VPOVARR(FNBR1,IENS1,.13,"E"))
 S VPOV("V POV","dateOfInjuryFM")=$G(VPOVARR(FNBR1,IENS1,.13,"I"))
 S VPOV("V POV","dateOfInjuryHL7")=$$FMTHL7^XLFDT($G(VPOVARR(FNBR1,IENS1,.13,"I")))
 S VPOV("V POV","dateOfInjuryFHIR")=$$FMTFHIR^SYNDHPUTL($G(VPOVARR(FNBR1,IENS1,.13,"I")))
 S VPOV("V POV","clinicalTerm")=$G(VPOVARR(FNBR1,IENS1,.15,"E"))
 S VPOV("V POV","clinicalTermId")=$G(VPOVARR(FNBR1,IENS1,.15,"I"))
 S VPOV("V POV","problemListEntry")=$G(VPOVARR(FNBR1,IENS1,.16,"E"))
 S VPOV("V POV","problemListEntryId")=$G(VPOVARR(FNBR1,IENS1,.16,"I"))
 S VPOV("V POV","orderingResulting")=$G(VPOVARR(FNBR1,IENS1,.17,"E"))
 S VPOV("V POV","orderingResultingCd")=$G(VPOVARR(FNBR1,IENS1,.17,"I"))
 S VPOV("V POV","mappedSource")=$G(VPOVARR(FNBR1,IENS1,300,"E"))
 S VPOV("V POV","eventDateAndTime")=$G(VPOVARR(FNBR1,IENS1,1201,"E"))
 S VPOV("V POV","eventDateAndTimeFM")=$G(VPOVARR(FNBR1,IENS1,1201,"I"))
 S VPOV("V POV","eventDateAndTimeHL7")=$$FMTHL7^XLFDT($G(VPOVARR(FNBR1,IENS1,1201,"I")))
 S VPOV("V POV","eventDateAndTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(VPOVARR(FNBR1,IENS1,1201,"I")))
 S VPOV("V POV","orderingProvider")=$G(VPOVARR(FNBR1,IENS1,1202,"E"))
 S VPOV("V POV","orderingProviderId")=$G(VPOVARR(FNBR1,IENS1,1202,"I"))
 S VPOV("V POV","orderingProviderNPI")=$$GET1^DIQ(200,VPOV("V POV","orderingProviderId")_",",41.99) ;NPI
 S VPOV("V POV","orderingProviderResId")=$$RESID^SYNDHP69("V",SITE,200,VPOV("V POV","orderingProviderId"))
 S VPOV("V POV","encounterProvider")=$G(VPOVARR(FNBR1,IENS1,1204,"E"))
 S VPOV("V POV","encounterProviderId")=$G(VPOVARR(FNBR1,IENS1,1204,"I"))
 S VPOV("V POV","encounterProviderNPI")=$$GET1^DIQ(200,VPOV("V POV","encounterProviderId")_",",41.99) ;NPI
 S VPOV("V POV","encounterProviderResId")=$$RESID^SYNDHP69("V",SITE,200,VPOV("V POV","encounterProviderId"))
 S VPOV("V POV","serviceConnected")=$G(VPOVARR(FNBR1,IENS1,80001,"E"))
 S VPOV("V POV","serviceConnectedCd")=$G(VPOVARR(FNBR1,IENS1,80001,"I"))
 S VPOV("V POV","agentOrangeExposure")=$G(VPOVARR(FNBR1,IENS1,80002,"E"))
 S VPOV("V POV","agentOrangeExposureCd")=$G(VPOVARR(FNBR1,IENS1,80002,"I"))
 S VPOV("V POV","ionizingRadiationExposure")=$G(VPOVARR(FNBR1,IENS1,80003,"E"))
 S VPOV("V POV","ionizingRadiationExposureCd")=$G(VPOVARR(FNBR1,IENS1,80003,"I"))
 S VPOV("V POV","swAsiaConditions")=$G(VPOVARR(FNBR1,IENS1,80004,"E"))
 S VPOV("V POV","swAsiaConditionsCd")=$G(VPOVARR(FNBR1,IENS1,80004,"I"))
 S VPOV("V POV","militarySexualTrauma")=$G(VPOVARR(FNBR1,IENS1,80005,"E"))
 S VPOV("V POV","militarySexualTraumaCd")=$G(VPOVARR(FNBR1,IENS1,80005,"I"))
 S VPOV("V POV","headAndOrNeckCancer")=$G(VPOVARR(FNBR1,IENS1,80006,"E"))
 S VPOV("V POV","headAndOrNeckCancerCd")=$G(VPOVARR(FNBR1,IENS1,80006,"I"))
 S VPOV("V POV","combatVeteran")=$G(VPOVARR(FNBR1,IENS1,80007,"E"))
 S VPOV("V POV","combatVeteranCd")=$G(VPOVARR(FNBR1,IENS1,80007,"I"))
 S VPOV("V POV","proj112Shad")=$G(VPOVARR(FNBR1,IENS1,80008,"E"))
 S VPOV("V POV","proj112ShadCd")=$G(VPOVARR(FNBR1,IENS1,80008,"I"))
 S VPOV("V POV","editedFlag")=$G(VPOVARR(FNBR1,IENS1,80101,"E"))
 S VPOV("V POV","editedFlagCd")=$G(VPOVARR(FNBR1,IENS1,80101,"I"))
 S VPOV("V POV","auditTrail")=$G(VPOVARR(FNBR1,IENS1,80102,"E"))
 S VPOV("V POV","providerNarrativeCategory")=$G(VPOVARR(FNBR1,IENS1,80201,"E"))
 S VPOV("V POV","providerNarrativeCategoryId")=$G(VPOVARR(FNBR1,IENS1,80201,"I"))
 S VPOV("V POV","comments")=$G(VPOVARR(FNBR1,IENS1,81101,"E"))
 S VPOV("V POV","verified")=$G(VPOVARR(FNBR1,IENS1,81201,"E"))
 S VPOV("V POV","verifiedCd")=$G(VPOVARR(FNBR1,IENS1,81201,"I"))
 S VPOV("V POV","package")=$G(VPOVARR(FNBR1,IENS1,81202,"E"))
 S VPOV("V POV","packageId")=$G(VPOVARR(FNBR1,IENS1,81202,"I"))
 S VPOV("V POV","dataSource")=$G(VPOVARR(FNBR1,IENS1,81203,"E"))
 S VPOV("V POV","dataSourceId")=$G(VPOVARR(FNBR1,IENS1,81203,"I"))
 ;
 ;get SCT code
 N MAPPING S MAPPING=$S(VPOV("V POV","visitFM")>3150930:"sct2icd",1:"sct2icdnine")
 N SNOMED S SNOMED=$$MAP^SYNDHPMP(MAPPING,VPOV("V POV","pov"),"I")
 S VPOV("V POV","povSCT")=$S(+SNOMED=-1:"",1:$P(SNOMED,U,2))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VPOV")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VPOV,.VPOVJ)
 ;
 QUIT
 ;
