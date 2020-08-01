SYNDHP16 ; HC/art - HealthConcourse - get Allergy, Vitals, data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1ALLERGY(ALLERGY,ALLERGYIEN,RETJSON,ALLERGYJ) ;get one Allergy record
 ;inputs: ALLERGYIEN - Allergy IEN
 ;        RETJSON - J = Return JSON
 ;output: ALLERGY  - array of Allergy data, by reference
 ;        ALLERGYJ - JSON structure of Allergy data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Allergy -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=120.8 ;PATIENT ALLERGIES
 N FNBR2 S FNBR2=120.81 ;REACTIONS
 N FNBR3 S FNBR3=120.813 ;CHART MARKED
 N FNBR4 S FNBR4=120.814 ;ID BAND MARKED
 N FNBR5 S FNBR5=120.826 ;COMMENTS
 N IENS1 S IENS1=ALLERGYIEN_","
 ;
 N ALLERGYARR,ALLERGYERR,ALLERGYN
 D GETS^DIQ(FNBR1,IENS1,"**","EI","ALLERGYARR","ALLERGYERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("ALLERGYARR")
 I $G(DEBUG),$D(ALLERGYERR) W ">>ERROR<<",! W $$ZW^SYNDHPUTL("ALLERGYERR")
 I $D(ALLERGYERR) D  QUIT
 . S ALLERGY("Allergy","ERROR")=ALLERGYIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.ALLERGY,.ALLERGYJ)
 S ALLERGYN=$NA(ALLERGY("Allergy"))
 S @ALLERGYN@("allergyIen")=ALLERGYIEN
 S @ALLERGYN@("resourceType")="AllergyIntolerance"
 S @ALLERGYN@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,ALLERGYIEN)
 S @ALLERGYN@("patient")=$G(ALLERGYARR(FNBR1,IENS1,.01,"E"))
 S @ALLERGYN@("patientId")=$G(ALLERGYARR(FNBR1,IENS1,.01,"I"))
 S @ALLERGYN@("patientICN")=$$GET1^DIQ(2,@ALLERGYN@("patientId")_",",991.1)
 S @ALLERGYN@("reactant")=$G(ALLERGYARR(FNBR1,IENS1,.02,"E"))
 S @ALLERGYN@("reactantSCT")=$$MAPR^SYNDHPMP(@ALLERGYN@("reactant"),"T","A")
 S @ALLERGYN@("gmrAllergy")=$G(ALLERGYARR(FNBR1,IENS1,1,"E"))
 S @ALLERGYN@("gmrAllergyId")=$G(ALLERGYARR(FNBR1,IENS1,1,"I"))
 S @ALLERGYN@("allergyType")=$G(ALLERGYARR(FNBR1,IENS1,3.1,"E"))
 S @ALLERGYN@("allergyTypeFHIR")=$$CNVTTYPE(@ALLERGYN@("allergyType"))
 S @ALLERGYN@("originationDateTime")=$G(ALLERGYARR(FNBR1,IENS1,4,"E"))
 S @ALLERGYN@("originationDateTimeFM")=$G(ALLERGYARR(FNBR1,IENS1,4,"I"))
 S @ALLERGYN@("originationDateTimeHL7")=$$FMTHL7^XLFDT($G(ALLERGYARR(FNBR1,IENS1,4,"I")))
 S @ALLERGYN@("originationDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(ALLERGYARR(FNBR1,IENS1,4,"I")))
 S @ALLERGYN@("originator")=$G(ALLERGYARR(FNBR1,IENS1,5,"E"))
 S @ALLERGYN@("originatorId")=$G(ALLERGYARR(FNBR1,IENS1,5,"I"))
 S @ALLERGYN@("observedHistorical")=$G(ALLERGYARR(FNBR1,IENS1,6,"E"))
 S @ALLERGYN@("observedHistoricalCd")=$G(ALLERGYARR(FNBR1,IENS1,6,"I"))
 S @ALLERGYN@("reportable")=$G(ALLERGYARR(FNBR1,IENS1,7,"E"))
 S @ALLERGYN@("reportableCd")=$G(ALLERGYARR(FNBR1,IENS1,7,"I"))
 S @ALLERGYN@("originatorSignOff")=$G(ALLERGYARR(FNBR1,IENS1,15,"E"))
 S @ALLERGYN@("originatorSignOffCd")=$G(ALLERGYARR(FNBR1,IENS1,15,"I"))
 S @ALLERGYN@("mechanism")=$G(ALLERGYARR(FNBR1,IENS1,17,"E"))
 S @ALLERGYN@("mechanismCd")=$G(ALLERGYARR(FNBR1,IENS1,17,"I"))
 S @ALLERGYN@("verified")=$G(ALLERGYARR(FNBR1,IENS1,19,"E"))
 S @ALLERGYN@("verifiedCd")=$G(ALLERGYARR(FNBR1,IENS1,19,"I"))
 S @ALLERGYN@("verificationDateTime")=$G(ALLERGYARR(FNBR1,IENS1,20,"E"))
 S @ALLERGYN@("verificationDateTimeFM")=$G(ALLERGYARR(FNBR1,IENS1,20,"I"))
 S @ALLERGYN@("verificationDateTimeHL7")=$$FMTHL7^XLFDT($G(ALLERGYARR(FNBR1,IENS1,20,"I")))
 S @ALLERGYN@("verificationDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(ALLERGYARR(FNBR1,IENS1,20,"I")))
 S @ALLERGYN@("verifier")=$G(ALLERGYARR(FNBR1,IENS1,21,"E"))
 S @ALLERGYN@("verifierId")=$G(ALLERGYARR(FNBR1,IENS1,21,"I"))
 S @ALLERGYN@("verifierNPI")=$$GET1^DIQ(200,@ALLERGYN@("verifierId")_",",41.99) ;NPI
 S @ALLERGYN@("enteredInError")=$G(ALLERGYARR(FNBR1,IENS1,22,"E"))
 S @ALLERGYN@("enteredInErrorCd")=$G(ALLERGYARR(FNBR1,IENS1,22,"I"))
 S @ALLERGYN@("dateTimeEnteredInError")=$G(ALLERGYARR(FNBR1,IENS1,23,"E"))
 S @ALLERGYN@("dateTimeEnteredInErrorFM")=$G(ALLERGYARR(FNBR1,IENS1,23,"I"))
 S @ALLERGYN@("dateTimeEnteredInErrorHL7")=$$FMTHL7^XLFDT($G(ALLERGYARR(FNBR1,IENS1,23,"I")))
 S @ALLERGYN@("dateTimeEnteredInErrorFHIR")=$$FMTFHIR^SYNDHPUTL($G(ALLERGYARR(FNBR1,IENS1,23,"I")))
 S @ALLERGYN@("userEnteringInError")=$G(ALLERGYARR(FNBR1,IENS1,24,"E"))
 S @ALLERGYN@("userEnteringInErrorId")=$G(ALLERGYARR(FNBR1,IENS1,24,"I"))
 S @ALLERGYN@("userEnteringInErrorNPI")=$$GET1^DIQ(200,@ALLERGYN@("userEnteringInErrorId")_",",41.99) ;NPI
 S @ALLERGYN@("userEnteringInErrorResId")=$$RESID^SYNDHP69("V",SITE,200,@ALLERGYN@("userEnteringInErrorId"))
 N REACTION
 N IENS2 S IENS2=""
 F  S IENS2=$O(ALLERGYARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . S REACTION=$NA(ALLERGY("Allergy","reactionss","reactions",+IENS2))
 . S @REACTION@("reaction")=$G(ALLERGYARR(FNBR2,IENS2,.01,"E"))
 . S @REACTION@("reactionId")=$G(ALLERGYARR(FNBR2,IENS2,.01,"I"))
 . S @REACTION@("reactionSCT")=$$MAPR^SYNDHPMP($G(ALLERGYARR(FNBR2,IENS2,.01,"E")),"T","R")
 . S @REACTION@("otherReaction")=$G(ALLERGYARR(FNBR2,IENS2,1,"E"))
 . S @REACTION@("enteredBy")=$G(ALLERGYARR(FNBR2,IENS2,2,"E"))
 . S @REACTION@("enteredById")=$G(ALLERGYARR(FNBR2,IENS2,2,"I"))
 . S @REACTION@("enteredByNPI")=$$GET1^DIQ(200,@REACTION@("enteredById")_",",41.99) ;NPI
 . S @REACTION@("enteredByResId")=$$RESID^SYNDHP69("V",SITE,200,@REACTION@("enteredById"))
 . S @REACTION@("dateEntered")=$G(ALLERGYARR(FNBR2,IENS2,3,"E"))
 . S @REACTION@("dateEnteredFM")=$G(ALLERGYARR(FNBR2,IENS2,3,"I"))
 . S @REACTION@("dateEnteredHL7")=$$FMTHL7^XLFDT($G(ALLERGYARR(FNBR2,IENS2,3,"I")))
 . S @REACTION@("dateEnteredFHIR")=$$FMTFHIR^SYNDHPUTL($G(ALLERGYARR(FNBR2,IENS2,3,"I")))
 . S @REACTION@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,ALLERGYIEN,FNBR2_U_+IENS2)
 N CHART
 N IENS3 S IENS3=""
 F  S IENS3=$O(ALLERGYARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . S CHART=$NA(ALLERGY("Allergy","chartMarkeds","chartMarked",+IENS3))
 . S @CHART@("dateTime")=$G(ALLERGYARR(FNBR3,IENS3,.01,"E"))
 . S @CHART@("dateTimeFM")=$G(ALLERGYARR(FNBR3,IENS3,.01,"I"))
 . S @CHART@("dateTimeHL7")=$$FMTHL7^XLFDT($G(ALLERGYARR(FNBR3,IENS3,.01,"I")))
 . S @CHART@("dateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(ALLERGYARR(FNBR3,IENS3,.01,"I")))
 . S @CHART@("userEntering")=$G(ALLERGYARR(FNBR3,IENS3,1,"E"))
 . S @CHART@("userEnteringId")=$G(ALLERGYARR(FNBR3,IENS3,1,"I"))
 . S @CHART@("userEnteringNPI")=$$GET1^DIQ(200,@CHART@("userEnteringId")_",",41.99) ;NPI
 . S @CHART@("userEnteringResId")=$$RESID^SYNDHP69("V",SITE,200,@CHART@("userEnteringId"))
 . S @CHART@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,ALLERGYIEN,FNBR3_U_+IENS3)
 N IDBAND
 N IENS4 S IENS4=""
 F  S IENS4=$O(ALLERGYARR(FNBR4,IENS4)) QUIT:IENS4=""  D
 . S IDBAND=$NA(ALLERGY("Allergy","idBandMarkeds","idBandMarked",+IENS4))
 . S @IDBAND@("dateTime")=$G(ALLERGYARR(FNBR4,IENS4,.01,"E"))
 . S @IDBAND@("dateTimeFM")=$G(ALLERGYARR(FNBR4,IENS4,.01,"I"))
 . S @IDBAND@("dateTimeHL7")=$$FMTHL7^XLFDT($G(ALLERGYARR(FNBR4,IENS4,.01,"I")))
 . S @IDBAND@("dateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(ALLERGYARR(FNBR4,IENS4,.01,"I")))
 . S @IDBAND@("userEntering")=$G(ALLERGYARR(FNBR4,IENS4,1,"E"))
 . S @IDBAND@("userEnteringId")=$G(ALLERGYARR(FNBR4,IENS4,1,"I"))
 . S @IDBAND@("userEnteringNPI")=$$GET1^DIQ(200,@IDBAND@("userEnteringId")_",",41.99) ;NPI
 . S @IDBAND@("userEnteringResId")=$$RESID^SYNDHP69("V",SITE,200,@IDBAND@("userEnteringId"))
 . S @IDBAND@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,ALLERGYIEN,FNBR4_U_+IENS4)
 N COMMENTS
 N IENS5 S IENS5=""
 F  S IENS5=$O(ALLERGYARR(FNBR5,IENS5)) QUIT:IENS5=""  D
 . S COMMENTS=$NA(ALLERGY("Allergy","commentss","comments",+IENS5))
 . S @COMMENTS@("dateTimeCommentEntered")=$G(ALLERGYARR(FNBR5,IENS5,.01,"E"))
 . S @COMMENTS@("dateTimeCommentEnteredFM")=$G(ALLERGYARR(FNBR5,IENS5,.01,"I"))
 . S @COMMENTS@("dateTimeCommentEnteredHL7")=$$FMTHL7^XLFDT($G(ALLERGYARR(FNBR5,IENS5,.01,"I")))
 . S @COMMENTS@("dateTimeCommentEnteredFHIR")=$$FMTFHIR^SYNDHPUTL($G(ALLERGYARR(FNBR5,IENS5,.01,"I")))
 . S @COMMENTS@("userEntering")=$G(ALLERGYARR(FNBR5,IENS5,1,"E"))
 . S @COMMENTS@("userEnteringId")=$G(ALLERGYARR(FNBR5,IENS5,1,"I"))
 . S @COMMENTS@("userEnteringNPI")=$$GET1^DIQ(200,@COMMENTS@("userEnteringId")_",",41.99) ;NPI
 . S @COMMENTS@("userEnteringResId")=$$RESID^SYNDHP69("V",SITE,200,@COMMENTS@("userEnteringId"))
 . S @COMMENTS@("commentType")=$G(ALLERGYARR(FNBR5,IENS5,1.5,"E"))
 . S @COMMENTS@("commentTypeCd")=$G(ALLERGYARR(FNBR5,IENS5,1.5,"I"))
 . S @COMMENTS@("comments")=$G(ALLERGYARR(FNBR5,IENS5,2,"E"))
 . S @COMMENTS@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,ALLERGYIEN,FNBR5_U_+IENS5)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("ALLERGY") W !
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.ALLERGY,.ALLERGYJ)
 ;
 QUIT
 ;
CNVTTYPE(TYPE) ;convert allery type to fhir values
 ;input: TYPE - VistA allergy type
 ;returns: FHIR allery type
 ;
 N IDX,TYPES,ALLTYPES
 F IDX=1:1 S TYPES=$P($T(TYPES+IDX),";;",2) QUIT:TYPES="zzzzz"  D
 . S ALLTYPES($P(TYPES,U,1))=$P(TYPES,U,2)
 ;
 I $G(TYPE)="" QUIT ""
 I $D(ALLTYPES(TYPE)) QUIT ALLTYPES(TYPE)
 QUIT ""
 ;
TYPES ;
  ;;FOOD^food
  ;;DRUG^medication
  ;;OTHER^environment
  ;;FOOD, DRUG^food:medication
  ;;DRUG, FOOD^medication:food
  ;;FOOD, OTHER^food:environment
  ;;DRUG, OTHER^medication:environment
  ;;FOOD, DRUG, OTHER^food:medication:environment
  ;;DRUG, FOOD, OTHER^medication:food:environment
  ;;F^food
  ;;D^medication
  ;;O^environment
  ;;FD^food:medication
  ;;DF^medication:food
  ;;FO^food:environment
  ;;DO^medication:environment
  ;;FDO^food:medication:environment
  ;;DFO^medication:food:environment
  ;;zzzzz
 ;
GET1VITALS(VITALS,VITALSIEN,RETJSON,VITALSJ) ;get one Vitals record
 ;inputs: VITALSIEN - Vitals IEN
 ;        RETJSON - J = Return JSON
 ;output: VITALS  - array of Vitals data, by reference
 ;        VITALSJ - JSON structure of Vitals data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Vitals -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=120.5 ;GMRV VITAL MEASUREMENT
 N FNBR2 S FNBR2=120.506 ;REASON ENTERED IN ERROR
 N FNBR3 S FNBR3=120.505 ;QUALIFIER
 N IENS1 S IENS1=VITALSIEN_","
 ;
 N VITALSARR,VITALSERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","VITALSARR","VITALSERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VITALSARR")
 I $G(DEBUG),$D(VITALSERR) W ">>ERROR<<" W $$ZW^SYNDHPUTL("VITALSERR")
 I $D(VITALSERR) D  QUIT
 . S VITALS("Vitals","ERROR")=VITALSIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VITALS,.VITALSJ)
 S VITALS("Vitals","vitalsIen")=VITALSIEN
 S VITALS("Vitals","resourceType")="Observation"
 S VITALS("Vitals","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VITALSIEN)
 S VITALS("Vitals","dateTimeVitalsTaken")=$G(VITALSARR(FNBR1,IENS1,.01,"E"))
 S VITALS("Vitals","dateTimeVitalsTakenFM")=$G(VITALSARR(FNBR1,IENS1,.01,"I"))
 S VITALS("Vitals","dateTimeVitalsTakenHL7")=$$FMTHL7^XLFDT($G(VITALSARR(FNBR1,IENS1,.01,"I")))
 S VITALS("Vitals","dateTimeVitalsTakenFHIR")=$$FMTFHIR^SYNDHPUTL($G(VITALSARR(FNBR1,IENS1,.01,"I")))
 S VITALS("Vitals","patient")=$G(VITALSARR(FNBR1,IENS1,.02,"E"))
 S VITALS("Vitals","patientId")=$G(VITALSARR(FNBR1,IENS1,.02,"I"))
 S VITALS("Vitals","patientICN")=$$GET1^DIQ(2,VITALS("Vitals","patientId")_",",991.1)
 S VITALS("Vitals","vitalType")=$G(VITALSARR(FNBR1,IENS1,.03,"E"))
 S VITALS("Vitals","vitalTypeSc")=$$SENTENCE^XLFSTR(VITALS("Vitals","vitalType"))
 S VITALS("Vitals","vitalTypeId")=$G(VITALSARR(FNBR1,IENS1,.03,"I"))
 S VITALS("Vitals","dateTimeVitalsEntered")=$G(VITALSARR(FNBR1,IENS1,.04,"E"))
 S VITALS("Vitals","dateTimeVitalsEnteredFM")=$G(VITALSARR(FNBR1,IENS1,.04,"I"))
 S VITALS("Vitals","dateTimeVitalsEnteredHL7")=$$FMTHL7^XLFDT($G(VITALSARR(FNBR1,IENS1,.04,"I")))
 S VITALS("Vitals","dateTimeVitalsEnteredFHIR")=$$FMTFHIR^SYNDHPUTL($G(VITALSARR(FNBR1,IENS1,.04,"I")))
 S VITALS("Vitals","hospitalLocation")=$G(VITALSARR(FNBR1,IENS1,.05,"E"))
 S VITALS("Vitals","hospitalLocationId")=$G(VITALSARR(FNBR1,IENS1,.05,"I"))
 S VITALS("Vitals","enteredBy")=$G(VITALSARR(FNBR1,IENS1,.06,"E"))
 S VITALS("Vitals","enteredById")=$G(VITALSARR(FNBR1,IENS1,.06,"I"))
 S VITALS("Vitals","enteredByNPI")=$$GET1^DIQ(200,VITALS("Vitals","enteredById")_",",41.99) ;NPI
 S VITALS("Vitals","enteredByResId")=$$RESID^SYNDHP69("V",SITE,200,VITALS("Vitals","enteredById"))
 S VITALS("Vitals","rate")=$G(VITALSARR(FNBR1,IENS1,1.2,"E"))
 S VITALS("Vitals","supplementalO2")=$G(VITALSARR(FNBR1,IENS1,1.4,"E"))
 S VITALS("Vitals","enteredInError")=$G(VITALSARR(FNBR1,IENS1,2,"E"))
 S VITALS("Vitals","enteredInErrorCd")=$G(VITALSARR(FNBR1,IENS1,2,"I"))
 S VITALS("Vitals","errorEnteredBy")=$G(VITALSARR(FNBR1,IENS1,3,"E"))
 S VITALS("Vitals","errorEnteredById")=$G(VITALSARR(FNBR1,IENS1,3,"I"))
 S VITALS("Vitals","errorEnteredByNPI")=$$GET1^DIQ(200,VITALS("Vitals","errorEnteredById")_",",41.99) ;NPI
 N REASERR
 N IENS2 S IENS2=""
 F  S IENS2=$O(VITALSARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . S REASERR=$NA(VITALS("Vitals","reasonEnteredInErrors","reasonEnteredInError",+IENS2))
 . S @REASERR@("reasonEnteredInError")=$G(VITALSARR(FNBR2,IENS2,.01,"E"))
 . S @REASERR@("reasonEnteredInErrorCd")=$G(VITALSARR(FNBR2,IENS2,.01,"I"))
 . S @REASERR@("dateReasonEnteredInError")=$G(VITALSARR(FNBR2,IENS2,.02,"E"))
 . S @REASERR@("dateReasonEnteredInErrorFM")=$G(VITALSARR(FNBR2,IENS2,.02,"I"))
 . S @REASERR@("dateReasonEnteredInErrorHL7")=$$FMTHL7^XLFDT($G(VITALSARR(FNBR2,IENS2,.02,"I")))
 . S @REASERR@("dateReasonEnteredInErrorFHIR")=$$FMTFHIR^SYNDHPUTL($G(VITALSARR(FNBR2,IENS2,.02,"I")))
 . S @REASERR@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VITALSIEN,FNBR2_U_+IENS2)
 N QUALIFY
 N IENS3 S IENS3=""
 F  S IENS3=$O(VITALSARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . S QUALIFY=$NA(VITALS("Vitals","qualifiers","qualifier",+IENS3))
 . S @QUALIFY@("qualifier")=$G(VITALSARR(FNBR3,IENS3,.01,"E"))
 . S @QUALIFY@("qualifierId")=$G(VITALSARR(FNBR3,IENS3,.01,"I"))
 . S @QUALIFY@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,VITALSIEN,FNBR3_U_+IENS3)
 ;
 ;get snomed
 N SCT S SCT=""
 S SCT=$$MAP^SYNDHPMP("sct2vit",VITALS("Vitals","vitalTypeId"),"I")
 S VITALS("Vitals","vitalTypeSCT")=$S(+SCT=-1:"",1:$P(SCT,U,2))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("VITALS")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.VITALS,.VITALSJ)
 ;
 QUIT
 ;
