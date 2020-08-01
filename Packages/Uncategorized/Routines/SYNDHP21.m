SYNDHP21 ; HC/art - HealthConcourse - get patient lab data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GETLABS(LABS,LABREF,RETJSON,LABSJ) ;get Patient Labs records
 ;inputs: LABREF - Labs IEN (patient LRDFN)
 ;        RETJSON - J = Return JSON
 ;output: LABS  - array of Labs data, by reference
 ;        LABSJ - JSON structure of Labs data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Labs -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=63 ;LAB DATA
 N FNBR2 S FNBR2=63.04 ;CHEM, HEM, TOX, RIA, SER, etc.
 N FNBR3 S FNBR3=63.07 ;ORDERED TEST
 N IENS1 S IENS1=LABREF_","
 ;
 N LABSARR,LABSERR,INVDT,RESULT,LOINC
 D GETS^DIQ(FNBR1,IENS1,"**","EI","LABSARR","LABSERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("LABSARR")
 I $G(DEBUG),$D(LABSERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("LABSERR")
 I $D(LABSERR) D  QUIT
 . S LABS("Lab","ERROR")=LABREF
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.LABS,.LABSJ)
 S LABS("Lab","labsIen")=LABREF
 S LABS("Lab","resourceType")="Laboratory"
 S LABS("Lab","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,LABREF)
 S LABS("Lab","lrDfn")=$G(LABSARR(FNBR1,IENS1,.01,"E"))
 S LABS("Lab","patientName")=$G(LABSARR(FNBR1,IENS1,.03,"E"))
 S LABS("Lab","patientNameId")=$G(LABSARR(FNBR1,IENS1,.03,"I"))
 S LABS("Lab","patientNameIcn")=$$ICN^SYNDHPUTL(LABS("Lab","patientNameId"))
 S LABS("Lab","doNotTransfuse")=$G(LABSARR(FNBR1,IENS1,.04,"E"))
 S LABS("Lab","doNotTransfuseCd")=$G(LABSARR(FNBR1,IENS1,.04,"I"))
 S LABS("Lab","aboGroup")=$G(LABSARR(FNBR1,IENS1,.05,"E"))
 S LABS("Lab","aboGroupCd")=$G(LABSARR(FNBR1,IENS1,.05,"I"))
 S LABS("Lab","rhType")=$G(LABSARR(FNBR1,IENS1,.06,"E"))
 S LABS("Lab","rhTypeCd")=$G(LABSARR(FNBR1,IENS1,.06,"I"))
 S LABS("Lab","hospitalId")=$G(LABSARR(FNBR1,IENS1,.09,"E"))
 N IENS2 S IENS2=""
 F  S IENS2=$O(LABSARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N CHEMLABS S CHEMLABS=$NA(LABS("Lab","chemHemToxRiaSerEtcs","chemHemToxRiaSerEtc",+IENS2))
 . S @CHEMLABS@("dateTimeSpecimenTaken")=$G(LABSARR(FNBR2,IENS2,.01,"E"))
 . S @CHEMLABS@("dateTimeSpecimenTakenFM")=$G(LABSARR(FNBR2,IENS2,.01,"I"))
 . S @CHEMLABS@("dateTimeSpecimenTakenHL7")=$$FMTHL7^XLFDT($G(LABSARR(FNBR2,IENS2,.01,"I")))
 . S @CHEMLABS@("dateTimeSpecimenTakenFHIR")=$$FMTFHIR^SYNDHPUTL($G(LABSARR(FNBR2,IENS2,.01,"I")))
 . S @CHEMLABS@("dateTimeObtainedInexact")=$G(LABSARR(FNBR2,IENS2,.02,"E"))
 . S @CHEMLABS@("dateTimeObtainedInexactCd")=$G(LABSARR(FNBR2,IENS2,.02,"I"))
 . S @CHEMLABS@("dateReportCompleted")=$G(LABSARR(FNBR2,IENS2,.03,"E"))
 . S @CHEMLABS@("dateReportCompletedFM")=$G(LABSARR(FNBR2,IENS2,.03,"I"))
 . S @CHEMLABS@("dateReportCompletedHL7")=$$FMTHL7^XLFDT($G(LABSARR(FNBR2,IENS2,.03,"I")))
 . S @CHEMLABS@("dateReportCompletedFHIR")=$$FMTFHIR^SYNDHPUTL($G(LABSARR(FNBR2,IENS2,.03,"I")))
 . S @CHEMLABS@("verifyPerson")=$G(LABSARR(FNBR2,IENS2,.04,"E"))
 . S @CHEMLABS@("verifyPersonId")=$G(LABSARR(FNBR2,IENS2,.04,"I"))
 . S @CHEMLABS@("verifyPersonNPI")=$$GET1^DIQ(200,@CHEMLABS@("verifyPersonId")_",",41.99) ;NPI
 . S @CHEMLABS@("verifyPersonResId")=$$RESID^SYNDHP69("V",SITE,200,@CHEMLABS@("verifyPersonId"))
 . S @CHEMLABS@("specimenType")=$G(LABSARR(FNBR2,IENS2,.05,"E"))
 . S @CHEMLABS@("specimenTypeId")=$G(LABSARR(FNBR2,IENS2,.05,"I"))
 . S @CHEMLABS@("accession")=$G(LABSARR(FNBR2,IENS2,.06,"E"))
 . S @CHEMLABS@("volume")=$G(LABSARR(FNBR2,IENS2,.07,"E"))
 . S @CHEMLABS@("methodOrSite")=$G(LABSARR(FNBR2,IENS2,.08,"E"))
 . S @CHEMLABS@("sumReportNum")=$G(LABSARR(FNBR2,IENS2,.09,"E"))
 . S @CHEMLABS@("requestingPerson")=$G(LABSARR(FNBR2,IENS2,.1,"E"))
 . S @CHEMLABS@("requestingPersonId")=$G(LABSARR(FNBR2,IENS2,.1,"I"))
 . S @CHEMLABS@("requestingPersonNPI")=$$GET1^DIQ(200,@CHEMLABS@("requestingPersonId")_",",41.99) ;NPI
 . S @CHEMLABS@("requestingPersonResId")=$$RESID^SYNDHP69("V",SITE,200,@CHEMLABS@("requestingPersonId"))
 . S @CHEMLABS@("requestingLocation")=$G(LABSARR(FNBR2,IENS2,.11,"E"))
 . S @CHEMLABS@("requestingLocDiv")=$G(LABSARR(FNBR2,IENS2,.111,"E"))
 . S @CHEMLABS@("requestingLocDivId")=$G(LABSARR(FNBR2,IENS2,.111,"I"))
 . S @CHEMLABS@("accessioningInstitution")=$G(LABSARR(FNBR2,IENS2,.112,"E"))
 . S @CHEMLABS@("accessioningInstitutionId")=$G(LABSARR(FNBR2,IENS2,.112,"I"))
 . S @CHEMLABS@("uid")=$G(LABSARR(FNBR2,IENS2,.31,"E"))
 . S @CHEMLABS@("orderingSite")=$G(LABSARR(FNBR2,IENS2,.32,"E"))
 . S @CHEMLABS@("orderingSiteId")=$G(LABSARR(FNBR2,IENS2,.32,"I"))
 . S @CHEMLABS@("collectingSite")=$G(LABSARR(FNBR2,IENS2,.33,"E"))
 . S @CHEMLABS@("collectingSiteId")=$G(LABSARR(FNBR2,IENS2,.33,"I"))
 . S @CHEMLABS@("hostUid")=$G(LABSARR(FNBR2,IENS2,.34,"E"))
 . S @CHEMLABS@("orderingSiteUid")=$G(LABSARR(FNBR2,IENS2,.342,"E"))
 . S @CHEMLABS@("releasingSite")=$G(LABSARR(FNBR2,IENS2,.345,"E"))
 . S @CHEMLABS@("releasingSiteId")=$G(LABSARR(FNBR2,IENS2,.345,"I"))
 . S @CHEMLABS@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,LABREF,FNBR2_U_+IENS2)
 . ;"secret" data in the results field
 . S INVDT=9999999-@CHEMLABS@("dateTimeSpecimenTakenFM")
 . N RESULT
 . D GETRESLT(LABREF,INVDT,.RESULT)
 . S @CHEMLABS@("labTestId")=$G(RESULT("labTestId"))
 . S @CHEMLABS@("labTestName")=$G(RESULT("labTestName"))
 . S @CHEMLABS@("result")=$G(RESULT("result"))
 . S @CHEMLABS@("flag")=$G(RESULT("flag"))
 . S @CHEMLABS@("referenceHigh")=$G(RESULT("referenceHigh"))
 . S @CHEMLABS@("referenceLow")=$G(RESULT("referenceLow"))
 . S @CHEMLABS@("criticalHigh")=$G(RESULT("criticalHigh"))
 . S @CHEMLABS@("criticalLow")=$G(RESULT("criticalLow"))
 . S @CHEMLABS@("units")=$G(RESULT("units"))
 . S @CHEMLABS@("typographyId")=$G(RESULT("typographyId"))
 . S @CHEMLABS@("typography")=$G(RESULT("typography"))
 . S @CHEMLABS@("workloadCd")=$G(RESULT("workloadCd"))
 . S @CHEMLABS@("workloadProcedure")=$G(RESULT("workloadProcedure"))
 . ;get loinc
 . I @CHEMLABS@("labTestId")'="",@CHEMLABS@("labTestName")'="",@CHEMLABS@("typographyId")'="" D
 . . S LOINC=$$GETLOINC(@CHEMLABS@("labTestId"),@CHEMLABS@("labTestName"),@CHEMLABS@("typographyId"))
 . . S @CHEMLABS@("loincCode")=$P(LOINC,U,1)
 . . S @CHEMLABS@("loincName")=$P(LOINC,U,2)
 . E  D
 . . S @CHEMLABS@("loincCode")=""
 . . S @CHEMLABS@("loincName")=""
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("LABS")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.LABS,.LABSJ)
 ;
 QUIT
 ;
GETRESLT(lrDfn,invDate,ret) ;get chem lab test result
 quit:('$get(lrDfn))!('$get(invDate))
 ;
 new node
 new fieldnbr set fieldnbr=$order(^LR(lrDfn,"CH",invDate,1))
 if fieldnbr'="",$data(^LR(lrDfn,"CH",invDate,fieldnbr)) do
 . set ret("resultFor")=$piece($get(^DD(63.04,fieldnbr,0)),U,1)
 . set node=^LR(lrDfn,"CH",invDate,fieldnbr)
 . set ret("result")=$piece(node,U,1)
 . set ret("flag")=$piece(node,U,2)
 . set ret("workloadCd")=$piece($piece(node,U,3),"!",1)
 . if ret("workloadCd")'="" set ret("workloadProcedure")=$$GET1^DIQ(64,$order(^LAM("C",ret("workloadCd")_" ",""))_",",.01)
 . set ret("labTestId")=$piece($piece(node,U,3),"!",7)
 . set ret("labTestName")=$$GET1^DIQ(60,ret("labTestId")_",",.01)
 . set ret("verifyById")=$piece(node,U,4)
 . set ret("verifyBy")=$$GET1^DIQ(200,ret("verifyById")_",",.01)
 . set ret("typographyId")=$piece($piece(node,U,5),"!",1)
 . set ret("typography")=$$GET1^DIQ(61,ret("typographyId")_",",.01)
 . set ret("referenceLow")=$piece($piece(node,U,5),"!",2)
 . set ret("referenceHigh")=$piece($piece(node,U,5),"!",3)
 . set ret("criticalLow")=$piece($piece(node,U,5),"!",4)
 . set ret("criticalHigh")=$piece($piece(node,U,5),"!",5)
 . set ret("units")=$piece($piece(node,U,5),"!",7)
 . set ret("institutionId")=$piece(node,U,9)
 . set ret("institution")=$$GET1^DIQ(4,ret("institutionId")_",",.01)
 ;2)="110^^84330.0000!!!!!!175^1^72!60!110!50!300!!mg/dL!!!^^^^500"
 quit
 ;
GETLOINC(TESTIEN,TESTNAME,TYPE) ; get loinc code for test
 ;returns - loinc code ^ loinc code name (or test name)
 ;
 N IENS S IENS=TYPE_","_TESTIEN_","
 N LOINCCD S LOINCCD=$$GET1^DIQ(60.01,IENS,95.3) ;loinc code from laboratory test:site/specimen (60:100)
 N LOINCNM S LOINCNM=$$GET1^DIQ(95.3,+LOINCCD_",",80) ;loinc fully specified name
 ;if not found in Vista, then use SYNGRAPH below
 I LOINCCD="" D
 . S LOINCCD=$$graphmap^SYNGRAPH("loinc-lab-map",TESTNAME,"LOINC")
 . I +LOINCCD=-1 D
 . . S LOINCCD=""
 . . S LOINCNM=TESTNAME
 . E  D
 . . S LOINCNM=$$GET1^DIQ(95.3,+LOINCCD_",",80) ;loinc fully specified name
 ;
 QUIT LOINCCD_U_LOINCNM
 ;
