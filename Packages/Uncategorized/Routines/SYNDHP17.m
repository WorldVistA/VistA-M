SYNDHP17 ; HC/art - HealthConcourse - get MH Diagnosis, Flags data ;08/27/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1MHDX(MHDX,MHDXIEN,RETJSON,MHDXJ) ;get one Mental Health Diagnosis record
 ;inputs: MHDXIEN - Mental Health Diagnosis IEN
 ;        RETJSON - J = Return JSON
 ;output: MHDX  - array of Mental Health Diagnosis data, by reference
 ;        MHDXJ - JSON structure of Mental Health Diagnosis data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Mental Health Diagnosis ----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=627.8 ;DIAGNOSTIC RESULTS - MENTAL HEALTH
 N FNBR2 S FNBR2=627.82 ;MODIFIERS
 N FNBR3 S FNBR3=627.81 ;COMMENT
 N IENS1 S IENS1=MHDXIEN_","
 ;
 N MHDXARR,MHDXERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","MHDXARR","MHDXERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("MHDXARR")
 I $G(DEBUG),$D(MHDXERR) W !,">>ERROR<<" W ! W $$ZW^SYNDHPUTL("MHDXERR")
 I $D(MHDXERR) D  QUIT
 . S MHDX("Mhdiag","ERROR")=MHDXIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.MHDX,.MHDXJ)
 S MHDX("Mhdiag","mhdiagIen")=MHDXIEN
 S MHDX("Mhdiag","resourceType")="Observation"
 S MHDX("Mhdiag","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,MHDXIEN)
 S MHDX("Mhdiag","fileEntryDate")=$G(MHDXARR(FNBR1,IENS1,.01,"E"))
 S MHDX("Mhdiag","fileEntryDateFM")=$G(MHDXARR(FNBR1,IENS1,.01,"I"))
 S MHDX("Mhdiag","fileEntryDateHL7")=$$FMTHL7^XLFDT($G(MHDXARR(FNBR1,IENS1,.01,"I")))
 S MHDX("Mhdiag","fileEntryDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(MHDXARR(FNBR1,IENS1,.01,"I")))
 S MHDX("Mhdiag","patientName")=$G(MHDXARR(FNBR1,IENS1,.02,"E"))
 S MHDX("Mhdiag","patientNameId")=$G(MHDXARR(FNBR1,IENS1,.02,"I"))
 S MHDX("Mhdiag","patientNameICN")=$$GET1^DIQ(2,MHDX("Mhdiag","patientNameId")_",",991.1)
 S MHDX("Mhdiag","dateTimeOfDiagnosis")=$G(MHDXARR(FNBR1,IENS1,.03,"E"))
 S MHDX("Mhdiag","dateTimeOfDiagnosisFM")=$G(MHDXARR(FNBR1,IENS1,.03,"I"))
 S MHDX("Mhdiag","dateTimeOfDiagnosisHL7")=$$FMTHL7^XLFDT($G(MHDXARR(FNBR1,IENS1,.03,"I")))
 S MHDX("Mhdiag","dateTimeOfDiagnosisFHIR")=$$FMTFHIR^SYNDHPUTL($G(MHDXARR(FNBR1,IENS1,.03,"I")))
 S MHDX("Mhdiag","diagnosisBy")=$G(MHDXARR(FNBR1,IENS1,.04,"E"))
 S MHDX("Mhdiag","diagnosisById")=$G(MHDXARR(FNBR1,IENS1,.04,"I"))
 S MHDX("Mhdiag","diagnosisByNPI")=$$GET1^DIQ(200,MHDX("Mhdiag","diagnosisById")_",",41.99) ;NPI
 S MHDX("Mhdiag","diagnosisByResId")=$$RESID^SYNDHP69("V",SITE,200,MHDX("Mhdiag","diagnosisById"))
 S MHDX("Mhdiag","transcriber")=$G(MHDXARR(FNBR1,IENS1,.05,"E"))
 S MHDX("Mhdiag","transcriberId")=$G(MHDXARR(FNBR1,IENS1,.05,"I"))
 S MHDX("Mhdiag","diagnosis")=$G(MHDXARR(FNBR1,IENS1,1,"E"))
 S MHDX("Mhdiag","diagnosisId")=$G(MHDXARR(FNBR1,IENS1,1,"I"))
 S MHDX("Mhdiag","statusVPRINRu")=$G(MHDXARR(FNBR1,IENS1,5,"E"))
 S MHDX("Mhdiag","statusVPRINRuCd")=$G(MHDXARR(FNBR1,IENS1,5,"I"))
 S MHDX("Mhdiag","condition")=$G(MHDXARR(FNBR1,IENS1,7,"E"))
 S MHDX("Mhdiag","conditionCd")=$G(MHDXARR(FNBR1,IENS1,7,"I"))
 S MHDX("Mhdiag","inactivatedDate")=$G(MHDXARR(FNBR1,IENS1,8,"E"))
 S MHDX("Mhdiag","inactivatedDateFM")=$G(MHDXARR(FNBR1,IENS1,8,"I"))
 S MHDX("Mhdiag","inactivatedDateHL7")=$$FMTHL7^XLFDT($G(MHDXARR(FNBR1,IENS1,8,"I")))
 S MHDX("Mhdiag","inactivatedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(MHDXARR(FNBR1,IENS1,8,"I")))
 S MHDX("Mhdiag","statusChanged")=$G(MHDXARR(FNBR1,IENS1,9,"E"))
 S MHDX("Mhdiag","statusChangedCd")=$G(MHDXARR(FNBR1,IENS1,9,"I"))
 S MHDX("Mhdiag","dxls")=$G(MHDXARR(FNBR1,IENS1,10,"E"))
 S MHDX("Mhdiag","dxlsCd")=$G(MHDXARR(FNBR1,IENS1,10,"I"))
 S MHDX("Mhdiag","psychosocialStressor")=$G(MHDXARR(FNBR1,IENS1,60,"E"))
 S MHDX("Mhdiag","severityCode")=$G(MHDXARR(FNBR1,IENS1,61,"E"))
 S MHDX("Mhdiag","severityCodeCd")=$G(MHDXARR(FNBR1,IENS1,61,"I"))
 S MHDX("Mhdiag","axis5-GAF")=$G(MHDXARR(FNBR1,IENS1,65,"E"))
 S MHDX("Mhdiag","patientType")=$G(MHDXARR(FNBR1,IENS1,66,"E"))
 S MHDX("Mhdiag","patientTypeCd")=$G(MHDXARR(FNBR1,IENS1,66,"I"))
 N IENS2 S IENS2=""
 F  S IENS2=$O(MHDXARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N MOD S MOD=$NA(MHDX("Mhdiag","modifierss","modifiers",+IENS2))
 . S @MOD@("modifier")=$G(MHDXARR(FNBR2,IENS2,.01,"E"))
 . S @MOD@("modifierId")=$G(MHDXARR(FNBR2,IENS2,.01,"I"))
 . S @MOD@("numberOfAnswer")=$G(MHDXARR(FNBR2,IENS2,1,"E"))
 . S @MOD@("standsFor")=$G(MHDXARR(FNBR2,IENS2,2,"E"))
 . S @MOD@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,MHDXIEN,FNBR2_U_+IENS2)
 N IENS3 S IENS3=""
 F  S IENS3=$O(MHDXARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . N COMMENT S COMMENT=$NA(MHDX("Mhdiag","comments","comment",+IENS3))
 . S @COMMENT@("comment")=$G(MHDXARR(FNBR3,IENS3,.01,"E"))
 . S @COMMENT@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,MHDXIEN,FNBR3_U_+IENS3)
 ;
 ;get SCT code
 S MHDX("Mhdiag","diagnosisSCT")=""
 I MHDX("Mhdiag","diagnosis")'="" D
 . N DATE S DATE=$S(MHDX("Mhdiag","dateTimeOfDiagnosisFM")'="":MHDX("Mhdiag","dateTimeOfDiagnosisFM"),1:MHDX("Mhdiag","fileEntryDateFM"))
 . N MAPPING S MAPPING=$S(DATE>3150930:"sct2icd",1:"sct2icdnine")
 . N SNOMED S SNOMED=$$MAP^SYNDHPMP(MAPPING,MHDX("Mhdiag","diagnosis"),"I")
 . S MHDX("Mhdiag","diagnosisSCT")=$S(+SNOMED=-1:"",1:$P(SNOMED,U,2))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("DXMH")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.MHDX,.MHDXJ)
 ;
 QUIT
 ;
GET1FLAG(FLAG,FLAGIEN,RETJSON,FLAGJ) ;get one Flag record
 ;inputs: FLAGIEN - Flag IEN
 ;        RETJSON - J = Return JSON
 ;output: FLAG  - array of Flag data, by reference
 ;        FLAGJ - JSON structure of Flag data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Flag -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=26.13 ;PRF ASSIGNMENT
 N FNBR2 S FNBR2=26.132 ;ASSIGNMENT NARRATIVE
 N IENS1 S IENS1=FLAGIEN_","
 ;
 N FLAGARR,FLAGERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","FLAGARR","FLAGERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("FLAGARR")
 I $G(DEBUG),$D(FLAGERR) W ">>ERROR<<" W $$ZW^SYNDHPUTL("FLAGERR")
 I $D(FLAGERR) D  QUIT
 . S FLAG("Flag","ERROR")=FLAGIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.FLAG,.FLAGJ)
 S FLAG("Flag","flagIen")=FLAGIEN
 S FLAG("Flag","resourceType")="Flag"
 S FLAG("Flag","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,FLAGIEN)
 S FLAG("Flag","number")=$G(FLAGARR(FNBR1,IENS1,.001,"E"))
 S FLAG("Flag","patientName")=$G(FLAGARR(FNBR1,IENS1,.01,"E"))
 S FLAG("Flag","patientNameId")=$G(FLAGARR(FNBR1,IENS1,.01,"I"))
 S FLAG("Flag","patientNameICN")=$$GET1^DIQ(2,FLAG("Flag","patientNameId")_",",991.1)
 S FLAG("Flag","flagName")=$G(FLAGARR(FNBR1,IENS1,.02,"E"))
 S FLAG("Flag","flagNameId")=$G(FLAGARR(FNBR1,IENS1,.02,"I"))
 S FLAG("Flag","status")=$G(FLAGARR(FNBR1,IENS1,.03,"E"))
 S FLAG("Flag","statusCd")=$G(FLAGARR(FNBR1,IENS1,.03,"I"))
 S FLAG("Flag","ownerSite")=$G(FLAGARR(FNBR1,IENS1,.04,"E"))
 S FLAG("Flag","ownerSiteId")=$G(FLAGARR(FNBR1,IENS1,.04,"I"))
 S FLAG("Flag","originatingSite")=$G(FLAGARR(FNBR1,IENS1,.05,"E"))
 S FLAG("Flag","originatingSiteId")=$G(FLAGARR(FNBR1,IENS1,.05,"I"))
 S FLAG("Flag","reviewDate")=$G(FLAGARR(FNBR1,IENS1,.06,"E"))
 S FLAG("Flag","reviewDateFM")=$G(FLAGARR(FNBR1,IENS1,.06,"I"))
 S FLAG("Flag","reviewDateHL7")=$$FMTHL7^XLFDT($G(FLAGARR(FNBR1,IENS1,.06,"I")))
 S FLAG("Flag","reviewDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(FLAGARR(FNBR1,IENS1,.06,"I")))
 S FLAG("Flag","assignmentNarrative")=""
 N Z S Z=""
 F  S Z=$O(FLAGARR(FNBR1,IENS1,1,Z)) QUIT:'+Z  D
 . S FLAG("Flag","assignmentNarrative")=FLAG("Flag","assignmentNarrative")_$G(FLAGARR(FNBR1,IENS1,1,Z))_" "
 ;
 ;get snomed
 N SCT
 S SCT=$$MAP^SYNDHPMP("flag2sct",FLAG("Flag","flagName"),"D")
 S FLAG("Flag","flagSCT")=$S(+SCT=-1:"",1:$P(SCT,U,2))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("FLAG")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.FLAG,.FLAGJ)
 ;
 QUIT
 ;
