SYNDHP11 ; HC/art - HealthConcourse - get problem record ;2019-10-25  12:21 PM
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 ; (c) 2017-2019 Perspecta
 ; (c) 2019 OSEHRA
 ; 
 ; Licensed under the Apache License, Version 2.0 (the "License");
 ; you may not use this file except in compliance with the License.
 ; You may obtain a copy of the License at
 ; 
 ; http://www.apache.org/licenses/LICENSE-2.0
 ; 
 ; Unless required by applicable law or agreed to in writing, software
 ; distributed under the License is distributed on an "AS IS" BASIS,
 ; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ; See the License for the specific language governing permissions and
 ; limitations under the License.
 ;
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1PROB(PROBLEM,PROBIEN,RETJSON,PROBLEMJ) ;get one Patient Problem (Condition) record
 ;inputs: PROBIEN - Problem IEN
 ;        RETJSON - J = Return JSON
 ;output: PROBLEM  - array of problem data, by reference
 ;        PROBLEMJ - JSON structure of problem data, by reference
 ;
 I $G(DEBUG) W !,"----------------------------- Problem -----------------------------",!
 N FNBR1 S FNBR1=9000011 ;PROBLEM
 N FNBR2 S FNBR2=9000011.11 ;PROBLEM:NOTE FACILITY
 N FNBR3 S FNBR3=9000011.1111 ;PROBLEM:NOTE FACILITY:NOTE
 N FNBR4 S FNBR4=9000011.803 ;PROBLEM:MAPPING TARGETS
 N S S S="_"
 N C S C=","
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N IENS S IENS=PROBIEN_","
 N PROBARR,PROBERR
 D GETS^DIQ(FNBR1,IENS,"**","EI","PROBARR","PROBERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PROBARR")
 I $G(DEBUG),$D(PROBERR) W ">>ERROR<<",! W $$ZW^SYNDHPUTL("PROBERR")
 I $D(PROBERR) D  QUIT
 . S PROBLEM("Problem","ERROR")=PROBIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PROBLEM,.PROBLEMJ)
 N PROBCOND S PROBCOND=$NA(PROBLEM("Problem"))
 S @PROBCOND@("problemIen")=PROBIEN
 S @PROBCOND@("resourceType")="Condition"
 S @PROBCOND@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PROBIEN)
 S @PROBCOND@("diagnosisId")=$G(PROBARR(FNBR1,IENS,.01,"I"))
 S @PROBCOND@("diagnosis")=$G(PROBARR(FNBR1,IENS,.01,"E"))
 S @PROBCOND@("diagnosisText")=$G(^ICD9(@PROBCOND@("diagnosisId"),68,1,1))
 S @PROBCOND@("patientNameId")=$G(PROBARR(FNBR1,IENS,.02,"I"))
 S @PROBCOND@("patientName")=$G(PROBARR(FNBR1,IENS,.02,"E"))
 S @PROBCOND@("patientICN")=$$GET1^DIQ(2,@PROBCOND@("patientNameId")_",",991.1)
 S @PROBCOND@("dateLastModified")=$G(PROBARR(FNBR1,IENS,.03,"E"))
 S @PROBCOND@("dateLastModifiedFM")=$G(PROBARR(FNBR1,IENS,.03,"I"))
 S @PROBCOND@("dateLastModifiedHL7")=$$FMTHL7^XLFDT($G(PROBARR(FNBR1,IENS,.03,"I")))
 S @PROBCOND@("dateLastModifiedFHIR")=$$FMTFHIR^SYNDHPUTL($G(PROBARR(FNBR1,IENS,.03,"I")))
 S @PROBCOND@("classCd")=$G(PROBARR(FNBR1,IENS,.04,"I"))
 S @PROBCOND@("class")=$G(PROBARR(FNBR1,IENS,.04,"E"))
 S @PROBCOND@("providerNarativeId")=$G(PROBARR(FNBR1,IENS,.05,"I"))
 S @PROBCOND@("providerNarative")=$G(PROBARR(FNBR1,IENS,.05,"E"))
 S @PROBCOND@("facilityId")=$G(PROBARR(FNBR1,IENS,.06,"I"))
 S @PROBCOND@("facility")=$G(PROBARR(FNBR1,IENS,.06,"E"))
 S @PROBCOND@("nmbr")=$G(PROBARR(FNBR1,IENS,.07,"E"))
 S @PROBCOND@("dateEntered")=$G(PROBARR(FNBR1,IENS,.08,"E"))
 S @PROBCOND@("dateEnteredFM")=$G(PROBARR(FNBR1,IENS,.08,"I"))
 S @PROBCOND@("dateEnteredHL7")=$$FMTHL7^XLFDT($G(PROBARR(FNBR1,IENS,.08,"I")))
 S @PROBCOND@("dateEnteredFHIR")=$$FMTFHIR^SYNDHPUTL($G(PROBARR(FNBR1,IENS,.08,"I")))
 S @PROBCOND@("statusCd")=$G(PROBARR(FNBR1,IENS,.12,"I"))
 S @PROBCOND@("status")=$G(PROBARR(FNBR1,IENS,.12,"E"))
 S @PROBCOND@("dateOfOnset")=$G(PROBARR(FNBR1,IENS,.13,"E"))
 S @PROBCOND@("dateOfOnsetFM")=$G(PROBARR(FNBR1,IENS,.13,"I")) ; date of onset may be imprecise
 N ADJDATE S ADJDATE=@PROBCOND@("dateOfOnsetFM")
 S:$E(@PROBCOND@("dateOfOnsetFM"),4,5)="00" $E(ADJDATE,4,5)="01"
 S:$E(@PROBCOND@("dateOfOnsetFM"),6,7)="00" $E(ADJDATE,6,7)="01"
 S @PROBCOND@("dateOfOnsetHL7")=$$FMTHL7^XLFDT(ADJDATE)
 S @PROBCOND@("dateOfOnsetFHIR")=$$FMTFHIR^SYNDHPUTL(ADJDATE)
 S @PROBCOND@("problemId")=$G(PROBARR(FNBR1,IENS,1.01,"I"))
 S @PROBCOND@("problem")=$G(PROBARR(FNBR1,IENS,1.01,"E"))
 S @PROBCOND@("conditionCd")=$G(PROBARR(FNBR1,IENS,1.02,"I"))
 S @PROBCOND@("condition")=$G(PROBARR(FNBR1,IENS,1.02,"E"))
 S @PROBCOND@("enteredById")=$G(PROBARR(FNBR1,IENS,1.03,"I"))
 S @PROBCOND@("enteredBy")=$G(PROBARR(FNBR1,IENS,1.03,"E"))
 S @PROBCOND@("recordingProviderId")=$G(PROBARR(FNBR1,IENS,1.04,"I"))
 S @PROBCOND@("recordingProvider")=$G(PROBARR(FNBR1,IENS,1.04,"E"))
 S @PROBCOND@("recordingProviderNPI")=$$GET1^DIQ(200,@PROBCOND@("recordingProviderId")_",",41.99) ;NPI
 S @PROBCOND@("recordingProviderResId")=$$RESID^SYNDHP69("V",SITE,200,@PROBCOND@("recordingProviderId"))
 S @PROBCOND@("responsibleProviderId")=$G(PROBARR(FNBR1,IENS,1.05,"I"))
 S @PROBCOND@("responsibleProvider")=$G(PROBARR(FNBR1,IENS,1.05,"E"))
 S @PROBCOND@("responsibleProviderNPI")=$$GET1^DIQ(200,@PROBCOND@("responsibleProviderId")_",",41.99) ;NPI
 S @PROBCOND@("responsibleProviderResId")=$$RESID^SYNDHP69("V",SITE,200,@PROBCOND@("responsibleProviderId"))
 S @PROBCOND@("serviceId")=$G(PROBARR(FNBR1,IENS,1.06,"I"))
 S @PROBCOND@("service")=$G(PROBARR(FNBR1,IENS,1.06,"E"))
 S @PROBCOND@("dateResolved")=$G(PROBARR(FNBR1,IENS,1.07,"E"))
 S @PROBCOND@("dateResolvedFM")=$G(PROBARR(FNBR1,IENS,1.07,"I"))
 ; If onset and resolution dates are the same, delete resolution dates
 I @PROBCOND@("dateResolvedFM")>@PROBCOND@("dateOfOnsetFM") D
 . S @PROBCOND@("dateResolvedHL7")=$$FMTHL7^XLFDT(@PROBCOND@("dateResolvedFM"))
 . S @PROBCOND@("dateResolvedFHIR")=$$FMTFHIR^SYNDHPUTL(@PROBCOND@("dateResolvedFM"))
 E  D
 . S @PROBCOND@("dateResolved")=""
 . S @PROBCOND@("dateResolvedFM")=""
 . S @PROBCOND@("dateResolvedHL7")=""
 . S @PROBCOND@("dateResolvedFHIR")=""
 S @PROBCOND@("clinicId")=$G(PROBARR(FNBR1,IENS,1.08,"I"))
 S @PROBCOND@("clinic")=$G(PROBARR(FNBR1,IENS,1.08,"E"))
 S @PROBCOND@("dateRecorded")=$G(PROBARR(FNBR1,IENS,1.09,"E"))
 S @PROBCOND@("dateRecordedFM")=$G(PROBARR(FNBR1,IENS,1.09,"I"))
 S @PROBCOND@("dateRecordedHL7")=$$FMTHL7^XLFDT($G(PROBARR(FNBR1,IENS,1.09,"I")))
 S @PROBCOND@("dateRecordedFHIR")=$$FMTFHIR^SYNDHPUTL($G(PROBARR(FNBR1,IENS,1.09,"I")))
 S @PROBCOND@("serviceConnectedCd")=$G(PROBARR(FNBR1,IENS,1.1,"I"))
 S @PROBCOND@("serviceConnected")=$G(PROBARR(FNBR1,IENS,1.1,"E"))
 S @PROBCOND@("agentOrangeExposureCd")=$G(PROBARR(FNBR1,IENS,1.11,"I"))
 S @PROBCOND@("agentOrangeExposure")=$G(PROBARR(FNBR1,IENS,1.11,"E"))
 S @PROBCOND@("ionizingRadiationExposureCd")=$G(PROBARR(FNBR1,IENS,1.12,"I"))
 S @PROBCOND@("ionizingRadiationExposure")=$G(PROBARR(FNBR1,IENS,1.12,"E"))
 S @PROBCOND@("persianGulfExposureCd")=$G(PROBARR(FNBR1,IENS,1.13,"I"))
 S @PROBCOND@("persianGulfExposure")=$G(PROBARR(FNBR1,IENS,1.13,"E"))
 S @PROBCOND@("priorityCd")=$G(PROBARR(FNBR1,IENS,1.14,"I"))
 S @PROBCOND@("priority")=$G(PROBARR(FNBR1,IENS,1.14,"E"))
 S @PROBCOND@("headAndOrNeckCancerCd")=$G(PROBARR(FNBR1,IENS,1.15,"I"))
 S @PROBCOND@("headAndOrNeckCancer")=$G(PROBARR(FNBR1,IENS,1.15,"E"))
 S @PROBCOND@("militarySexualTraumaCd")=$G(PROBARR(FNBR1,IENS,1.16,"I"))
 S @PROBCOND@("militarySexualTrauma")=$G(PROBARR(FNBR1,IENS,1.16,"E"))
 S @PROBCOND@("combatVeteranCd")=$G(PROBARR(FNBR1,IENS,1.17,"I"))
 S @PROBCOND@("combatVeteran")=$G(PROBARR(FNBR1,IENS,1.17,"E"))
 S @PROBCOND@("shipboardHazardDefenseCd")=$G(PROBARR(FNBR1,IENS,1.18,"I"))
 S @PROBCOND@("shipboardHazardDefense")=$G(PROBARR(FNBR1,IENS,1.18,"E"))
 S @PROBCOND@("snomedCTconceptCode")=$G(PROBARR(FNBR1,IENS,80001,"E"))
 S @PROBCOND@("snomedCTconceptCodeText")=""
 S:@PROBCOND@("snomedCTconceptCode")'="" @PROBCOND@("snomedCTconceptCodeText")=$$USCTPT^SYNDHPUTL(@PROBCOND@("snomedCTconceptCode"))
 S @PROBCOND@("snomedCTdesignationCode")=$G(PROBARR(FNBR1,IENS,80002,"E"))
 S @PROBCOND@("snomedCTdesignationCodeText")=""
 S:@PROBCOND@("snomedCTdesignationCode")'="" @PROBCOND@("snomedCTdesignationCodeText")=$$USCTPT^SYNDHPUTL(@PROBCOND@("snomedCTdesignationCode"))
 S @PROBCOND@("vhatConceptVuid")=$G(PROBARR(FNBR1,IENS,80003,"E"))
 S @PROBCOND@("vhatDesignationVuid")=$G(PROBARR(FNBR1,IENS,80004,"E"))
 S @PROBCOND@("snomedCtToIcdMapStatusCd")=$G(PROBARR(FNBR1,IENS,80005,"E"))
 S @PROBCOND@("snomedCtToIcdMapStatus")=$G(PROBARR(FNBR1,IENS,80005,"E"))
 S @PROBCOND@("uniqueNewTermRequestedCd")=$G(PROBARR(FNBR1,IENS,80101,"E"))
 S @PROBCOND@("uniqueNewTermRequested")=$G(PROBARR(FNBR1,IENS,80101,"E"))
 S @PROBCOND@("uniqueTermRequestComment")=$G(PROBARR(FNBR1,IENS,80102,"E"))
 S @PROBCOND@("dateOfInterest")=$G(PROBARR(FNBR1,IENS,80201,"E"))
 S @PROBCOND@("dateOfInterestFM")=$G(PROBARR(FNBR1,IENS,80201,"I"))
 S @PROBCOND@("dateOfInterestHL7")=$$FMTHL7^XLFDT($G(PROBARR(FNBR1,IENS,80201,"I")))
 S @PROBCOND@("dateOfInterestFHIR")=$$FMTFHIR^SYNDHPUTL($G(PROBARR(FNBR1,IENS,80201,"I")))
 S @PROBCOND@("codingSystem")=$G(PROBARR(FNBR1,IENS,80202,"E"))
 ;
 ;icd -> snomed
 N MAPPING S MAPPING=$S(@PROBCOND@("dateEnteredFM")>3150930:"sct2icd",1:"sct2icdnine")
 N SNOMED S SNOMED=$$MAP^SYNDHPMP(MAPPING,@PROBCOND@("diagnosis"),"I")
 S @PROBCOND@("diagnosisSCT")=$S(+SNOMED=-1:"",1:$P(SNOMED,U,2))
 ;
 N IENS2 S IENS2=""
 F  S IENS2=$O(PROBARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N FACNOTE S FACNOTE=$NA(PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2))
 . S @FACNOTE@("noteFacilityId")=$G(PROBARR(FNBR2,IENS2,.01,"I"))
 . S @FACNOTE@("noteFacility")=$G(PROBARR(FNBR2,IENS2,.01,"E"))
 . S @FACNOTE@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PROBIEN,FNBR2_U_+IENS2)
 ;
 N IENS3 S IENS3=""
 F  S IENS3=$O(PROBARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . N NOTE S NOTE=$NA(PROBLEM("Problem","noteFacilitys","noteFacility",$P(IENS3,C,2),"notes","note",+IENS3))
 . S @NOTE@("noteNmbr")=$G(PROBARR(FNBR3,IENS3,.01,"E"))
 . S @NOTE@("noteNarrative")=$G(PROBARR(FNBR3,IENS3,.03,"E"))
 . S @NOTE@("statusCd")=$G(PROBARR(FNBR3,IENS3,.04,"I"))
 . S @NOTE@("status")=$G(PROBARR(FNBR3,IENS3,.04,"E"))
 . S @NOTE@("dateNoteAdded")=$G(PROBARR(FNBR3,IENS3,.05,"E"))
 . S @NOTE@("dateNoteAddedFM")=$G(PROBARR(FNBR3,IENS3,.05,"I"))
 . S @NOTE@("dateNoteAddedHL7")=$$FMTHL7^XLFDT($G(PROBARR(FNBR3,IENS3,.05,"I")))
 . S @NOTE@("dateNoteAddedFHIR")=$$FMTFHIR^SYNDHPUTL($G(PROBARR(FNBR3,IENS3,.05,"I")))
 . S @NOTE@("authorId")=$G(PROBARR(FNBR3,IENS3,.06,"I"))
 . S @NOTE@("author")=$G(PROBARR(FNBR3,IENS3,.06,"E"))
 . S @NOTE@("authorNPI")=$$GET1^DIQ(200,@NOTE@("authorId")_",",41.99) ;NPI
 . S @NOTE@("authorResId")=$$RESID^SYNDHP69("V",SITE,200,@NOTE@("authorId"))
 . S @NOTE@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PROBIEN,FNBR2_U_$P(IENS3,C,2)_U_FNBR3_U_+IENS3)
 ;
 N IENS4 S IENS4=""
 F  S IENS4=$O(PROBARR(FNBR4,IENS4)) QUIT:IENS4=""  D
 . N MAPTARG S MAPTARG=$NA(PROBLEM("Problem","mappingTargets","mappingTarget",+IENS4))
 . S @MAPTARG@("code")=$G(PROBARR(FNBR4,IENS4,.01,"E"))
 . S @MAPTARG@("codingSystem")=$G(PROBARR(FNBR4,IENS4,.02,"E"))
 . S @MAPTARG@("codeDate")=$G(PROBARR(FNBR4,IENS4,.03,"E"))
 . S @MAPTARG@("codeDateFM")=$G(PROBARR(FNBR4,IENS4,.03,"I"))
 . S @MAPTARG@("codeDateHL7")=$$FMTHL7^XLFDT($G(PROBARR(FNBR4,IENS4,.03,"I")))
 . S @MAPTARG@("codeDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PROBARR(FNBR4,IENS4,.03,"I")))
 . S @MAPTARG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PROBIEN,FNBR4_U_+IENS4)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PROBLEM")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PROBLEM,.PROBLEMJ)
 ;
 QUIT
 ;
