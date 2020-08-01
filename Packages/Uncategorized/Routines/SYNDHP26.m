SYNDHP26 ; HC/art - HealthConcourse - get MH Administrations record ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1MHADM(MHADM,MHADMIEN,RETJSON,MHADMJ) ;get one MH Administration record
 ;inputs: MHADMIEN - MH Administration IEN
 ;        RETJSON - J = Return JSON
 ;output: MHADM  - array of MH Administration data, by reference
 ;        MHADMJ - JSON structure of MH Administration data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- MH Administration -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=601.84 ;MH ADMINISTRATIONS
 N FNBR2 S FNBR2=601.841 ;COMMENTS
 N IENS1 S IENS1=MHADMIEN_","
 ;
 N MHADMARR,MHADMERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","MHADMARR","MHADMERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("MHADMARR")
 I $G(DEBUG),$D(MHADMERR) W !,">>ERROR<<" W ! W $$ZW^SYNDHPUTL("MHADMERR")
 I $D(MHADMERR) D  QUIT
 . S MHADM("Mhadm","ERROR")=MHADMIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.MHADM,.MHADMJ)
 S MHADM("Mhadm","mhadmIen")=MHADMIEN
 S MHADM("Mhadm","resourceType")="Observation"
 S MHADM("Mhadm","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,MHADMIEN)
 S MHADM("Mhadm","administrationNumber")=$G(MHADMARR(FNBR1,IENS1,.01,"E"))
 S MHADM("Mhadm","patient")=$G(MHADMARR(FNBR1,IENS1,1,"E"))
 S MHADM("Mhadm","patientId")=$G(MHADMARR(FNBR1,IENS1,1,"I"))
 S MHADM("Mhadm","patientICN")=$$GET1^DIQ(2,MHADM("Mhadm","patientId")_",",991.1)
 S MHADM("Mhadm","instrumentName")=$G(MHADMARR(FNBR1,IENS1,2,"E"))
 S MHADM("Mhadm","instrumentNameId")=$G(MHADMARR(FNBR1,IENS1,2,"I"))
 S MHADM("Mhadm","dateGiven")=$G(MHADMARR(FNBR1,IENS1,3,"E"))
 S MHADM("Mhadm","dateGivenFM")=$G(MHADMARR(FNBR1,IENS1,3,"I"))
 S MHADM("Mhadm","dateGivenHL7")=$$FMTHL7^XLFDT($G(MHADMARR(FNBR1,IENS1,3,"I")))
 S MHADM("Mhadm","dateGivenFHIR")=$$FMTFHIR^SYNDHPUTL($G(MHADMARR(FNBR1,IENS1,3,"I")))
 S MHADM("Mhadm","dateSaved")=$G(MHADMARR(FNBR1,IENS1,4,"E"))
 S MHADM("Mhadm","dateSavedFM")=$G(MHADMARR(FNBR1,IENS1,4,"I"))
 S MHADM("Mhadm","dateSavedHL7")=$$FMTHL7^XLFDT($G(MHADMARR(FNBR1,IENS1,4,"I")))
 S MHADM("Mhadm","dateSavedFHIR")=$$FMTFHIR^SYNDHPUTL($G(MHADMARR(FNBR1,IENS1,4,"I")))
 S MHADM("Mhadm","orderedBy")=$G(MHADMARR(FNBR1,IENS1,5,"E"))
 S MHADM("Mhadm","orderedById")=$G(MHADMARR(FNBR1,IENS1,5,"I"))
 S MHADM("Mhadm","orderedByNPI")=$$GET1^DIQ(200,MHADM("Mhadm","orderedById")_",",41.99) ;NPI
 S MHADM("Mhadm","orderedByResId")=$$RESID^SYNDHP69("V",SITE,FNBR1,MHADM("Mhadm","orderedById"))
 S MHADM("Mhadm","administeredBy")=$G(MHADMARR(FNBR1,IENS1,6,"E"))
 S MHADM("Mhadm","administeredById")=$G(MHADMARR(FNBR1,IENS1,6,"I"))
 S MHADM("Mhadm","administeredByNPI")=$$GET1^DIQ(200,MHADM("Mhadm","administeredById")_",",41.99) ;NPI
 S MHADM("Mhadm","administeredByResId")=$$RESID^SYNDHP69("V",SITE,FNBR1,MHADM("Mhadm","administeredById"))
 S MHADM("Mhadm","signed")=$G(MHADMARR(FNBR1,IENS1,7,"E"))
 S MHADM("Mhadm","signedCd")=$G(MHADMARR(FNBR1,IENS1,7,"I"))
 S MHADM("Mhadm","isComplete")=$G(MHADMARR(FNBR1,IENS1,8,"E"))
 S MHADM("Mhadm","isCompleteCd")=$G(MHADMARR(FNBR1,IENS1,8,"I"))
 S MHADM("Mhadm","numberOfQuestionsAnswered")=$G(MHADMARR(FNBR1,IENS1,9,"E"))
 S MHADM("Mhadm","comments")=""
 N Z S Z=""
 F  S Z=$O(MHADMARR(FNBR1,IENS1,10,Z)) QUIT:'+Z  D
 . S MHADM("Mhadm","comments")=MHADM("Mhadm","comments")_$G(MHADMARR(FNBR1,IENS1,10,Z))_" "
 S MHADM("Mhadm","transmissionStatus")=$G(MHADMARR(FNBR1,IENS1,11,"E"))
 S MHADM("Mhadm","transmissionStatusCd")=$G(MHADMARR(FNBR1,IENS1,11,"I"))
 S MHADM("Mhadm","transmissionTime")=$G(MHADMARR(FNBR1,IENS1,12,"E"))
 S MHADM("Mhadm","transmissionTimeFM")=$G(MHADMARR(FNBR1,IENS1,12,"I"))
 S MHADM("Mhadm","transmissionTimeHL7")=$$FMTHL7^XLFDT($G(MHADMARR(FNBR1,IENS1,12,"I")))
 S MHADM("Mhadm","transmissionTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(MHADMARR(FNBR1,IENS1,12,"I")))
 S MHADM("Mhadm","location")=$G(MHADMARR(FNBR1,IENS1,13,"E"))
 S MHADM("Mhadm","locationId")=$G(MHADMARR(FNBR1,IENS1,13,"I"))
 ;
 ; get LOINC and/or SNOMED
 N LOINC S LOINC=""
 I MHADM("Mhadm","instrumentNameId")'="" D
 . S LOINC=$$MAP^SYNDHPMP("mh2loinc",MHADM("Mhadm","instrumentNameId"),"D")
 . S LOINC=$S(+LOINC=-1:"",1:$P(LOINC,U,2))
 I LOINC="",MHADM("Mhadm","instrumentName")'="" D
 . S LOINC=$$MAP^SYNDHPMP("mh2loinc",MHADM("Mhadm","instrumentName"),"D")
 . S LOINC=$S(+LOINC=-1:"",1:$P(LOINC,U,2))
 N SCT S SCT=""
 I MHADM("Mhadm","instrumentNameId")'="" D
 . S SCT=$$MAP^SYNDHPMP("mh2sct",MHADM("Mhadm","instrumentNameId"),"D")
 . S SCT=$S(+SCT=-1:"",1:$P(SCT,U,2))
 I SCT="",MHADM("Mhadm","instrumentName")'="" D
 . S SCT=$$MAP^SYNDHPMP("mh2sct",MHADM("Mhadm","instrumentName"),"D")
 . S SCT=$S(+SCT=-1:"",1:$P(SCT,U,2))
 S MHADM("Mhadm","loincCode")=LOINC
 S MHADM("Mhadm","snomedCode")=SCT
 S MHADM("Mhadm","sctPreferredTerm")=$$USCTPT^SYNDHPUTL(SCT)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("MHADM")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.MHADM,.MHADMJ)
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1MHANS(MHANS,MHANSIEN,RETJSON,MHANSJ) ;get one MH Answers record
 ;inputs: MHANSIEN - MH Answers IEN
 ;        RETJSON - J = Return JSON
 ;output: MHANS  - array of MH Answers data, by reference
 ;        MHANSJ - JSON structure of MH Answers data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- MH Answers -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=601.85 ;MH ANSWERS
 N FNBR2 S FNBR2=601.853 ;ANSWERS
 N IENS1 S IENS1=MHANSIEN_","
 ;
 N MHANSARR,MHANSERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","MHANSARR","MHANSERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("MHANSARR")
 I $G(DEBUG),$D(MHANSERR) W !,">>ERROR<<" W ! W $$ZW^SYNDHPUTL("MHANSERR")
 I $D(MHANSERR) D  QUIT
 . S MHANS("Mhans","ERROR")=MHANSIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.MHANS,.MHANSJ)
 S MHANS("Mhans","mhansIen")=MHANSIEN
 S MHANS("Mhans","resourceType")="Observation"
 S MHANS("Mhans","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,MHANSIEN)
 S MHANS("Mhans","answerId")=$G(MHANSARR(FNBR1,IENS1,.01,"E"))
 S MHANS("Mhans","administrationId")=$G(MHANSARR(FNBR1,IENS1,1,"E"))
 S MHANS("Mhans","questionId")=$G(MHANSARR(FNBR1,IENS1,2,"E"))
 S MHANS("Mhans","question")=""
 N QUEST
 N Q S Q=$$GET1^DIQ(601.72,MHANS("Mhans","questionId")_",",1,"","QUEST")
 N Z S Z=""
 F  S Z=$O(QUEST(Z)) QUIT:Z=""  D
 . S MHANS("Mhans","question")=MHANS("Mhans","question")_QUEST(Z)
 S MHANS("Mhans","answers")=""
 N Z S Z=""
 F  S Z=$O(MHANSARR(FNBR1,IENS1,3,Z)) QUIT:Z=""  D
 . S MHANS("Mhans","answers")=MHANS("Mhans","answers")_$G(MHANSARR(FNBR1,IENS1,3,Z))
 S MHANS("Mhans","choiceId")=$G(MHANSARR(FNBR1,IENS1,4,"E"))
 S MHANS("Mhans","choice")=$$GET1^DIQ(601.75,MHANS("Mhans","choiceId")_",",3)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("MHANS")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.MHANS,.MHANSJ)
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1MHRES(MHRES,MHRESIEN,RETJSON,MHRESJ) ;get one MH Results record
 ;inputs: MHRESIEN - MH Results IEN
 ;        RETJSON - J = Return JSON
 ;output: MHRES  - array of MH Results data, by reference
 ;        MHRESJ - JSON structure of MH Results data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- MH Results -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=601.92 ;MH RESULTS
 N IENS1 S IENS1=MHRESIEN_","
 ;
 N MHRESARR,MHRESERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","MHRESARR","MHRESERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("MHRESARR")
 I $G(DEBUG),$D(MHRESERR) W !,">>ERROR<<" W ! W $$ZW^SYNDHPUTL("MHRESERR")
 I $D(MHRESERR) D  QUIT
 . S MHRES("Mhres","ERROR")=MHRESIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.MHRES,.MHRESJ)
 S MHRES("Mhres","mhresIen")=MHRESIEN
 S MHRES("Mhres","resourceType")="Observation"
 S MHRES("Mhres","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,MHRESIEN)
 S MHRES("Mhres","resultId")=$G(MHRESARR(FNBR1,IENS1,.01,"E"))
 S MHRES("Mhres","administration")=$G(MHRESARR(FNBR1,IENS1,1,"E"))
 S MHRES("Mhres","administrationId")=$G(MHRESARR(FNBR1,IENS1,1,"I"))
 S MHRES("Mhres","scale")=$G(MHRESARR(FNBR1,IENS1,2,"E"))
 S MHRES("Mhres","rawScore")=$G(MHRESARR(FNBR1,IENS1,3,"E"))
 S MHRES("Mhres","transformedScore1")=$G(MHRESARR(FNBR1,IENS1,4,"E"))
 S MHRES("Mhres","transformedScore2")=$G(MHRESARR(FNBR1,IENS1,5,"E"))
 S MHRES("Mhres","transformedScore3")=$G(MHRESARR(FNBR1,IENS1,6,"E"))
 S MHRES("Mhres","instrument")=$G(MHRESARR(FNBR1,IENS1,7,"E"))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("MHRES")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.MHRES,.MHRESJ)
 ;
 QUIT
 ;
 
