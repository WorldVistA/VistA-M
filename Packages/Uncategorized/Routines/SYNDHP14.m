SYNDHP14 ; HC/art - HealthConcourse - get visit data ;08/27/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1VSCODE(VSCODE,VSCODEIEN,RETJSON,VSCODEJ) ;get one V Standard Codes record
 ;inputs: VSCODEIEN - V Standard Codes IEN
 ;        RETJSON - J = Return JSON
 ;output: VSCODE  - array of V Standard Codes data, by reference
 ;        VSCODEJ - JSON structure of V Standard Codes data, by reference
 ;
 I $G(DEBUG) W !,"V Standard Codes",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=9000010.71 ;V STANDARD CODES
 N IENS1 S IENS1=VSCODEIEN_","
 ;
 N VSCODEARR,VSCODEERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","VSCODEARR","VSCODEERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VSCODEARR")
 I $G(DEBUG),$D(VSCODEERR) W ">>ERROR<<",! W $$ZW^SYNDHPUTL("VSCODEERR")
 I $D(VSCODEERR) S VSCODE("Vscode","ERROR")=VSCODEIEN QUIT
 I $D(VSCODEERR) D  QUIT
 . S VSCODE("Vscode","ERROR")=VSCODEIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VSCODE,.VSCODEJ)
 S VSCODE("Vscode","vscodeIen")=VSCODEIEN
 S VSCODE("Vscode","resourceType")="Procedure"
 S VSCODE("Vscode","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VSCODEIEN)
 S VSCODE("Vscode","code")=$G(VSCODEARR(FNBR1,IENS1,.01,"E"))
 S VSCODE("Vscode","patientName")=$G(VSCODEARR(FNBR1,IENS1,.02,"E"))
 S VSCODE("Vscode","patientNameId")=$G(VSCODEARR(FNBR1,IENS1,.02,"I"))
 S VSCODE("Vscode","patientICN")=$$GET1^DIQ(2,VSCODE("Vscode","patientNameId")_",",991.1)
 S VSCODE("Vscode","visit")=$G(VSCODEARR(FNBR1,IENS1,.03,"E"))
 S VSCODE("Vscode","visitId")=$G(VSCODEARR(FNBR1,IENS1,.03,"I"))
 S VSCODE("Vscode","visitFM")=$$GET1^DIQ(9000010,VSCODE("Vscode","visitId")_",",.01,"I")
 S VSCODE("Vscode","visitHL7")=$$FMTHL7^XLFDT(VSCODE("Vscode","visitFM"))
 S VSCODE("Vscode","visitFHIR")=$$FMTFHIR^SYNDHPUTL(VSCODE("Vscode","visitFM"))
 S VSCODE("Vscode","visitResId")=$$RESID^SYNDHP69("V",SITE,9000010,VSCODE("Vscode","visitId"))
 S VSCODE("Vscode","codingSystem")=$G(VSCODEARR(FNBR1,IENS1,.05,"E"))
 S VSCODE("Vscode","problemListEntry")=$G(VSCODEARR(FNBR1,IENS1,.06,"E"))
 S VSCODE("Vscode","problemListEntryId")=$G(VSCODEARR(FNBR1,IENS1,.06,"I"))
 S VSCODE("Vscode","magnitude")=$G(VSCODEARR(FNBR1,IENS1,220,"E"))
 S VSCODE("Vscode","ucumCode")=$G(VSCODEARR(FNBR1,IENS1,221,"E"))
 S VSCODE("Vscode","ucumCodeId")=$G(VSCODEARR(FNBR1,IENS1,221,"I"))
 S VSCODE("Vscode","mappedSource")=$G(VSCODEARR(FNBR1,IENS1,300,"E"))
 S VSCODE("Vscode","eventDateAndTime")=$G(VSCODEARR(FNBR1,IENS1,1201,"E"))
 S VSCODE("Vscode","eventDateAndTimeFM")=$G(VSCODEARR(FNBR1,IENS1,1201,"I"))
 S VSCODE("Vscode","eventDateAndTimeHL7")=$$FMTHL7^XLFDT($G(VSCODEARR(FNBR1,IENS1,1201,"I")))
 S VSCODE("Vscode","eventDateAndTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(VSCODEARR(FNBR1,IENS1,1201,"I")))
 S VSCODE("Vscode","orderingProvider")=$G(VSCODEARR(FNBR1,IENS1,1202,"E"))
 S VSCODE("Vscode","orderingProviderId")=$G(VSCODEARR(FNBR1,IENS1,1202,"I"))
 S VSCODE("Vscode","orderingProviderNPI")=$$GET1^DIQ(200,VSCODE("Vscode","orderingProviderId")_",",41.99) ;NPI
 S VSCODE("Vscode","orderingProviderResId")=$$RESID^SYNDHP69("V",SITE,200,VSCODE("Vscode","orderingProviderId"))
 S VSCODE("Vscode","encounterProvider")=$G(VSCODEARR(FNBR1,IENS1,1204,"E"))
 S VSCODE("Vscode","encounterProviderId")=$G(VSCODEARR(FNBR1,IENS1,1204,"I"))
 S VSCODE("Vscode","encounterProviderNPI")=$$GET1^DIQ(200,VSCODE("Vscode","encounterProviderId")_",",41.99) ;NPI
 S VSCODE("Vscode","encounterProviderResId")=$$RESID^SYNDHP69("V",SITE,200,VSCODE("Vscode","encounterProviderId"))
 S VSCODE("Vscode","editedFlag")=$G(VSCODEARR(FNBR1,IENS1,80101,"E"))
 S VSCODE("Vscode","editedFlagCd")=$G(VSCODEARR(FNBR1,IENS1,80101,"I"))
 S VSCODE("Vscode","auditTrail")=$G(VSCODEARR(FNBR1,IENS1,80102,"E"))
 S VSCODE("Vscode","comments")=$G(VSCODEARR(FNBR1,IENS1,81101,"E"))
 S VSCODE("Vscode","verified")=$G(VSCODEARR(FNBR1,IENS1,81201,"E"))
 S VSCODE("Vscode","verifiedCd")=$G(VSCODEARR(FNBR1,IENS1,81201,"I"))
 S VSCODE("Vscode","package")=$G(VSCODEARR(FNBR1,IENS1,81202,"E"))
 S VSCODE("Vscode","packageId")=$G(VSCODEARR(FNBR1,IENS1,81202,"I"))
 S VSCODE("Vscode","dataSource")=$G(VSCODEARR(FNBR1,IENS1,81203,"E"))
 S VSCODE("Vscode","dataSourceId")=$G(VSCODEARR(FNBR1,IENS1,81203,"I"))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VSCODE")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VSCODE,.VSCODEJ)
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1VCPT(VCPT,VCPTIEN,RETJSON,VCPTJ) ;get one V CPT record
 ;inputs: VCPTIEN - V CPT IEN
 ;        RETJSON - J = Return JSON
 ;output: VCPT  - array of V CPT data, by reference
 ;        VCPTJ - JSON structure of V CPT data, by reference
 ;
 I $G(DEBUG) W !,"V CPT",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=9000010.18 ;V CPT
 N FNBR2 S FNBR2=9000010.181 ;CPT MODIFIER
 N IENS1 S IENS1=VCPTIEN_","
 ;
 N VCPTARR,VCPTERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","VCPTARR","VCPTERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VCPTARR")
 I $G(DEBUG),$D(VCPTERR) W ">>ERROR<<",! W $$ZW^SYNDHPUTL("VCPTERR")
 I $D(VCPTERR) D  QUIT
 . S VCPT("Vcpt","ERROR")=VCPTIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VCPT,.VCPTJ)
 S VCPT("Vcpt","vcptIen")=VCPTIEN
 S VCPT("Vcpt","resourceType")="Procedure"
 S VCPT("Vcpt","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VCPTIEN)
 S VCPT("Vcpt","cpt")=$G(VCPTARR(FNBR1,IENS1,.01,"E"))
 S VCPT("Vcpt","cptId")=$G(VCPTARR(FNBR1,IENS1,.01,"I"))
 S VCPT("Vcpt","cptName")=$$GET1^DIQ(81,VCPT("Vcpt","cptId")_",",2)
 S VCPT("Vcpt","patientName")=$G(VCPTARR(FNBR1,IENS1,.02,"E"))
 S VCPT("Vcpt","patientNameId")=$G(VCPTARR(FNBR1,IENS1,.02,"I"))
 S VCPT("Vcpt","patientICN")=$$GET1^DIQ(2,VCPT("Vcpt","patientNameId")_",",991.1)
 S VCPT("Vcpt","visit")=$G(VCPTARR(FNBR1,IENS1,.03,"E"))
 S VCPT("Vcpt","visitId")=$G(VCPTARR(FNBR1,IENS1,.03,"I"))
 S VCPT("Vcpt","visitFM")=$$GET1^DIQ(9000010,VCPT("Vcpt","visitId")_",",.01,"I")
 S VCPT("Vcpt","visitHL7")=$$FMTHL7^XLFDT(VCPT("Vcpt","visitFM"))
 S VCPT("Vcpt","visitFHIR")=$$FMTFHIR^SYNDHPUTL(VCPT("Vcpt","visitFM"))
 S VCPT("Vcpt","visitResId")=$$RESID^SYNDHP69("V",SITE,9000010,VCPT("Vcpt","visitId"))
 S VCPT("Vcpt","providerNarrative")=$G(VCPTARR(FNBR1,IENS1,.04,"E"))
 S VCPT("Vcpt","providerNarrativeId")=$G(VCPTARR(FNBR1,IENS1,.04,"I"))
 S VCPT("Vcpt","diagnosis")=$G(VCPTARR(FNBR1,IENS1,.05,"E"))
 S VCPT("Vcpt","diagnosisId")=$G(VCPTARR(FNBR1,IENS1,.05,"I"))
 S VCPT("Vcpt","principalProcedure")=$G(VCPTARR(FNBR1,IENS1,.07,"E"))
 S VCPT("Vcpt","principalProcedureCd")=$G(VCPTARR(FNBR1,IENS1,.07,"I"))
 S VCPT("Vcpt","diagnosis2")=$G(VCPTARR(FNBR1,IENS1,.09,"E"))
 S VCPT("Vcpt","diagnosis2Id")=$G(VCPTARR(FNBR1,IENS1,.09,"I"))
 S VCPT("Vcpt","diagnosis3")=$G(VCPTARR(FNBR1,IENS1,.1,"E"))
 S VCPT("Vcpt","diagnosis3Id")=$G(VCPTARR(FNBR1,IENS1,.1,"I"))
 S VCPT("Vcpt","diagnosis4")=$G(VCPTARR(FNBR1,IENS1,.11,"E"))
 S VCPT("Vcpt","diagnosis4Id")=$G(VCPTARR(FNBR1,IENS1,.11,"I"))
 S VCPT("Vcpt","diagnosis5")=$G(VCPTARR(FNBR1,IENS1,.12,"E"))
 S VCPT("Vcpt","diagnosis5Id")=$G(VCPTARR(FNBR1,IENS1,.12,"I"))
 S VCPT("Vcpt","diagnosis6")=$G(VCPTARR(FNBR1,IENS1,.13,"E"))
 S VCPT("Vcpt","diagnosis6Id")=$G(VCPTARR(FNBR1,IENS1,.13,"I"))
 S VCPT("Vcpt","diagnosis7")=$G(VCPTARR(FNBR1,IENS1,.14,"E"))
 S VCPT("Vcpt","diagnosis7Id")=$G(VCPTARR(FNBR1,IENS1,.14,"I"))
 S VCPT("Vcpt","diagnosis8")=$G(VCPTARR(FNBR1,IENS1,.15,"E"))
 S VCPT("Vcpt","diagnosis8Id")=$G(VCPTARR(FNBR1,IENS1,.15,"I"))
 S VCPT("Vcpt","quantity")=$G(VCPTARR(FNBR1,IENS1,.16,"E"))
 S VCPT("Vcpt","orderReference")=$G(VCPTARR(FNBR1,IENS1,.17,"E"))
 S VCPT("Vcpt","orderReferenceId")=$G(VCPTARR(FNBR1,IENS1,.17,"I"))
 S VCPT("Vcpt","departmentCode")=$G(VCPTARR(FNBR1,IENS1,.19,"E"))
 S VCPT("Vcpt","pfssChargeId")=$G(VCPTARR(FNBR1,IENS1,.2,"E"))
 S VCPT("Vcpt","mappedSource")=$G(VCPTARR(FNBR1,IENS1,300,"E"))
 S VCPT("Vcpt","eventDateAndTime")=$G(VCPTARR(FNBR1,IENS1,1201,"E"))
 S VCPT("Vcpt","eventDateAndTimeFM")=$G(VCPTARR(FNBR1,IENS1,1201,"I"))
 S VCPT("Vcpt","eventDateAndTimeHL7")=$$FMTHL7^XLFDT($G(VCPTARR(FNBR1,IENS1,1201,"I")))
 S VCPT("Vcpt","eventDateAndTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(VCPTARR(FNBR1,IENS1,1201,"I")))
 S VCPT("Vcpt","orderingProvider")=$G(VCPTARR(FNBR1,IENS1,1202,"E"))
 S VCPT("Vcpt","orderingProviderId")=$G(VCPTARR(FNBR1,IENS1,1202,"I"))
 S VCPT("Vcpt","orderingProviderNPI")=$$GET1^DIQ(200,VCPT("Vcpt","orderingProviderId")_",",41.99) ;NPI
 S VCPT("Vcpt","orderingProviderResId")=$$RESID^SYNDHP69("V",SITE,200,VCPT("Vcpt","orderingProviderId"))
 S VCPT("Vcpt","encounterProvider")=$G(VCPTARR(FNBR1,IENS1,1204,"E"))
 S VCPT("Vcpt","encounterProviderId")=$G(VCPTARR(FNBR1,IENS1,1204,"I"))
 S VCPT("Vcpt","encounterProviderNPI")=$$GET1^DIQ(200,VCPT("Vcpt","encounterProviderId")_",",41.99) ;NPI
 S VCPT("Vcpt","encounterProviderResId")=$$RESID^SYNDHP69("V",SITE,200,VCPT("Vcpt","encounterProviderId"))
 S VCPT("Vcpt","editedFlag")=$G(VCPTARR(FNBR1,IENS1,80101,"E"))
 S VCPT("Vcpt","editedFlagCd")=$G(VCPTARR(FNBR1,IENS1,80101,"I"))
 S VCPT("Vcpt","auditTrail")=$G(VCPTARR(FNBR1,IENS1,80102,"E"))
 S VCPT("Vcpt","providerNarrativeCategory")=$G(VCPTARR(FNBR1,IENS1,80201,"E"))
 S VCPT("Vcpt","providerNarrativeCategoryId")=$G(VCPTARR(FNBR1,IENS1,80201,"I"))
 S VCPT("Vcpt","comments")=$G(VCPTARR(FNBR1,IENS1,81101,"E"))
 S VCPT("Vcpt","verified")=$G(VCPTARR(FNBR1,IENS1,81201,"E"))
 S VCPT("Vcpt","verifiedCd")=$G(VCPTARR(FNBR1,IENS1,81201,"I"))
 S VCPT("Vcpt","package")=$G(VCPTARR(FNBR1,IENS1,81202,"E"))
 S VCPT("Vcpt","packageId")=$G(VCPTARR(FNBR1,IENS1,81202,"I"))
 S VCPT("Vcpt","dataSource")=$G(VCPTARR(FNBR1,IENS1,81203,"E"))
 S VCPT("Vcpt","dataSourceId")=$G(VCPTARR(FNBR1,IENS1,81203,"I"))
 N CPTMOD
 N IENS2 S IENS2=""
 F  S IENS2=$O(VCPTARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . S CPTMOD=$NA(VCPT("Vcpt","cptModifiers","cptModifier",+IENS2))
 . S @CPTMOD@("cptModifier")=$G(VCPTARR(FNBR2,IENS2,.01,"E"))
 . S @CPTMOD@("cptModifierId")=$G(VCPTARR(FNBR2,IENS2,.01,"I"))
 . S @CPTMOD@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VCPTIEN,FNBR2_U_+IENS2)
 ;
 ;LOOKUP SNOMED(sct) - cpt, os5
 S SCT=""
 ;map cpt to snomed (currently uses very small map)
 I VCPT("Vcpt","cpt")'="" D
 . S SCT=$$MAP^SYNDHPMP("sct2cpt",VCPT("Vcpt","cpt"),"I")
 . S SCT=$S(+SCT=-1:"",1:$P(SCT,U,2))
 ;if no cpt hit, map os5 to snomed
 I SCT="",VCPT("Vcpt","cpt")'="" D
 . S SCT=$$MAP^SYNDHPMP("sct2os5",VCPT("Vcpt","cpt"),"I")
 . S SCT=$S(+SCT=-1:"",1:$P(SCT,U,2))
 S VCPT("Vcpt","sct")=SCT
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VCPT")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VCPT,.VCPTJ)
 ;
 QUIT
 ;
