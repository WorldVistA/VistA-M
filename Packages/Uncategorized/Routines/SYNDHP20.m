SYNDHP20 ; HC/art - HealthConcourse - get patient demographic data ;07/08/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GETPATIENT(PATIENT,PATIENTIEN,RETJSON,PATIENTJ) ;get one Patient record
 ; This API does not include all data in the Patient file. Only select patient demographic data are included.
 ;inputs: PATIENTIEN - Patient IEN
 ;        RETJSON - J = Return JSON
 ;output: PATIENT  - array of Patient Demographic data, by reference
 ;        PATIENTJ - JSON structure of Patient Demographic data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Patient Demographic -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=2 ;PATIENT
 N FNBR2 S FNBR2=2.141 ;CONFIDENTIAL ADDRESS CATEGORY
 N FNBR3 S FNBR3=2.01 ;ALIAS
 N FNBR4 S FNBR4=2.02 ;RACE INFORMATION
 N FNBR5 S FNBR5=2.06 ;ETHNICITY INFORMATION
 N IENS1 S IENS1=PATIENTIEN_","
 ;
 N PATIENTARR,PATIENTERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","PATIENTARR","PATIENTERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PATIENTARR")
 I $G(DEBUG),$D(PATIENTERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("PATIENTERR")
 I $D(PATIENTERR) D  QUIT
 . S PATIENT("Patient","ERROR")=PATIENTIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PATIENT,.PATIENTJ)
 S PATIENT("Patient","patientIen")=PATIENTIEN
 S PATIENT("Patient","resourceType")="Patient"
 S PATIENT("Patient","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATIENTIEN)
 S PATIENT("Patient","name")=$G(PATIENTARR(FNBR1,IENS1,.01,"E"))
 S PATIENT("Patient","nameFirst")=$P($P(PATIENT("Patient","name"),",",2)," ",1)
 S PATIENT("Patient","nameLast")=$P(PATIENT("Patient","name"),",",1)
 S PATIENT("Patient","nameMiddle")=$P($P(PATIENT("Patient","name"),",",2)," ",2)
 S PATIENT("Patient","sex")=$G(PATIENTARR(FNBR1,IENS1,.02,"E"))
 S PATIENT("Patient","sexCd")=$G(PATIENTARR(FNBR1,IENS1,.02,"I"))
 S PATIENT("Patient","selfIdentifiedGender")=$G(PATIENTARR(FNBR1,IENS1,.024,"E"))
 S PATIENT("Patient","selfIdentifiedGenderCd")=$G(PATIENTARR(FNBR1,IENS1,.024,"I"))
 S PATIENT("Patient","dateOfBirth")=$G(PATIENTARR(FNBR1,IENS1,.03,"E"))
 S PATIENT("Patient","dateOfBirthFM")=$G(PATIENTARR(FNBR1,IENS1,.03,"I"))
 S PATIENT("Patient","dateOfBirthHL7")=$$FMTHL7^XLFDT($G(PATIENTARR(FNBR1,IENS1,.03,"I")))
 S PATIENT("Patient","dateOfBirthFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATIENTARR(FNBR1,IENS1,.03,"I")))
 S PATIENT("Patient","age")=$G(PATIENTARR(FNBR1,IENS1,.033,"E"))
 S PATIENT("Patient","maritalStatus")=$G(PATIENTARR(FNBR1,IENS1,.05,"E"))
 S PATIENT("Patient","maritalStatusId")=$G(PATIENTARR(FNBR1,IENS1,.05,"I"))
 S PATIENT("Patient","race")=$G(PATIENTARR(FNBR1,IENS1,.06,"E"))
 S PATIENT("Patient","raceId")=$G(PATIENTARR(FNBR1,IENS1,.06,"I"))
 S PATIENT("Patient","occupation")=$G(PATIENTARR(FNBR1,IENS1,.07,"E"))
 S PATIENT("Patient","religiousPreference")=$G(PATIENTARR(FNBR1,IENS1,.08,"E"))
 S PATIENT("Patient","socialSecurityNumber")=$G(PATIENTARR(FNBR1,IENS1,.09,"E"))
 S PATIENT("Patient","terminalDigitOfSsn")=$G(PATIENTARR(FNBR1,IENS1,.0901,"E"))
 S PATIENT("Patient","initlast4")=$G(PATIENTARR(FNBR1,IENS1,.0905,"E"))
 S PATIENT("Patient","remarks")=$G(PATIENTARR(FNBR1,IENS1,.091,"E"))
 S PATIENT("Patient","placeOfBirthCity")=$G(PATIENTARR(FNBR1,IENS1,.092,"E"))
 S PATIENT("Patient","placeOfBirthState")=$G(PATIENTARR(FNBR1,IENS1,.093,"E"))
 S PATIENT("Patient","placeOfBirthStateId")=$G(PATIENTARR(FNBR1,IENS1,.093,"I"))
 S PATIENT("Patient","streetAddressLine1")=$G(PATIENTARR(FNBR1,IENS1,.111,"E"))
 S PATIENT("Patient","streetAddressLine2")=$G(PATIENTARR(FNBR1,IENS1,.112,"E"))
 S PATIENT("Patient","streetAddressLine3")=$G(PATIENTARR(FNBR1,IENS1,.113,"E"))
 S PATIENT("Patient","city")=$G(PATIENTARR(FNBR1,IENS1,.114,"E"))
 S PATIENT("Patient","state")=$G(PATIENTARR(FNBR1,IENS1,.115,"E"))
 S PATIENT("Patient","stateId")=$G(PATIENTARR(FNBR1,IENS1,.115,"I"))
 S PATIENT("Patient","zipCode")=$G(PATIENTARR(FNBR1,IENS1,.116,"E"))
 S PATIENT("Patient","zip4")=$G(PATIENTARR(FNBR1,IENS1,.1112,"E"))
 S PATIENT("Patient","county")=$G(PATIENTARR(FNBR1,IENS1,.117,"E"))
 S PATIENT("Patient","province")=$G(PATIENTARR(FNBR1,IENS1,.1171,"E"))
 S PATIENT("Patient","postalCode")=$G(PATIENTARR(FNBR1,IENS1,.1172,"E"))
 S PATIENT("Patient","country")=$G(PATIENTARR(FNBR1,IENS1,.1173,"E"))
 S PATIENT("Patient","countryId")=$G(PATIENTARR(FNBR1,IENS1,.1173,"I"))
 S PATIENT("Patient","phoneNumberResidence")=$G(PATIENTARR(FNBR1,IENS1,.131,"E"))
 S PATIENT("Patient","phoneNumberWork")=$G(PATIENTARR(FNBR1,IENS1,.132,"E"))
 S PATIENT("Patient","emailAddress")=$G(PATIENTARR(FNBR1,IENS1,.133,"E"))
 S PATIENT("Patient","phoneNumberCellular")=$G(PATIENTARR(FNBR1,IENS1,.134,"E"))
 S PATIENT("Patient","pagerNumber")=$G(PATIENTARR(FNBR1,IENS1,.135,"E"))
 S PATIENT("Patient","tempAddressActive")=$G(PATIENTARR(FNBR1,IENS1,.12105,"E"))
 S PATIENT("Patient","tempAddressActiveCd")=$G(PATIENTARR(FNBR1,IENS1,.12105,"I"))
 S PATIENT("Patient","tempStreetLine1")=$G(PATIENTARR(FNBR1,IENS1,.1211,"E"))
 S PATIENT("Patient","tempStreetLine2")=$G(PATIENTARR(FNBR1,IENS1,.1212,"E"))
 S PATIENT("Patient","tempStreetLine3")=$G(PATIENTARR(FNBR1,IENS1,.1213,"E"))
 S PATIENT("Patient","tempCity")=$G(PATIENTARR(FNBR1,IENS1,.1214,"E"))
 S PATIENT("Patient","tempState")=$G(PATIENTARR(FNBR1,IENS1,.1215,"E"))
 S PATIENT("Patient","tempStateId")=$G(PATIENTARR(FNBR1,IENS1,.1215,"I"))
 S PATIENT("Patient","tempZipCode")=$G(PATIENTARR(FNBR1,IENS1,.1216,"E"))
 S PATIENT("Patient","tempZip4")=$G(PATIENTARR(FNBR1,IENS1,.12112,"E"))
 S PATIENT("Patient","tempAddressCounty")=$G(PATIENTARR(FNBR1,IENS1,.12111,"E"))
 S PATIENT("Patient","tempAddressProvince")=$G(PATIENTARR(FNBR1,IENS1,.1221,"E"))
 S PATIENT("Patient","tempAddressPostalCode")=$G(PATIENTARR(FNBR1,IENS1,.1222,"E"))
 S PATIENT("Patient","tempAddressCountry")=$G(PATIENTARR(FNBR1,IENS1,.1223,"E"))
 S PATIENT("Patient","tempAddressCountryId")=$G(PATIENTARR(FNBR1,IENS1,.1223,"I"))
 S PATIENT("Patient","tempPhoneNumber")=$G(PATIENTARR(FNBR1,IENS1,.1219,"E"))
 S PATIENT("Patient","tempAddressStartDate")=$G(PATIENTARR(FNBR1,IENS1,.1217,"E"))
 S PATIENT("Patient","tempAddressStartDateFM")=$G(PATIENTARR(FNBR1,IENS1,.1217,"I"))
 S PATIENT("Patient","tempAddressStartDateHL7")=$$FMTHL7^XLFDT($G(PATIENTARR(FNBR1,IENS1,.1217,"I")))
 S PATIENT("Patient","tempAddressStartDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATIENTARR(FNBR1,IENS1,.1217,"I")))
 S PATIENT("Patient","tempAddressEndDate")=$G(PATIENTARR(FNBR1,IENS1,.1218,"E"))
 S PATIENT("Patient","tempAddressEndDateFM")=$G(PATIENTARR(FNBR1,IENS1,.1218,"I"))
 S PATIENT("Patient","tempAddressEndDateHL7")=$$FMTHL7^XLFDT($G(PATIENTARR(FNBR1,IENS1,.1218,"I")))
 S PATIENT("Patient","tempAddressEndDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATIENTARR(FNBR1,IENS1,.1218,"I")))
 S PATIENT("Patient","emergencyResponseIndicator")=$G(PATIENTARR(FNBR1,IENS1,.181,"E"))
 S PATIENT("Patient","emergencyResponseIndicatorCd")=$G(PATIENTARR(FNBR1,IENS1,.181,"I"))
 S PATIENT("Patient","kNameOfPrimaryNok")=$G(PATIENTARR(FNBR1,IENS1,.211,"E"))
 S PATIENT("Patient","kRelationshipToPatient")=$G(PATIENTARR(FNBR1,IENS1,.212,"E"))
 S PATIENT("Patient","kAddressSameAsPatientS")=$G(PATIENTARR(FNBR1,IENS1,.2125,"E"))
 S PATIENT("Patient","kAddressSameAsPatientSCd")=$G(PATIENTARR(FNBR1,IENS1,.2125,"I"))
 S PATIENT("Patient","kStreetAddressLine1")=$G(PATIENTARR(FNBR1,IENS1,.213,"E"))
 S PATIENT("Patient","kStreetAddressLine2")=$G(PATIENTARR(FNBR1,IENS1,.214,"E"))
 S PATIENT("Patient","kStreetAddressLine3")=$G(PATIENTARR(FNBR1,IENS1,.215,"E"))
 S PATIENT("Patient","kCity")=$G(PATIENTARR(FNBR1,IENS1,.216,"E"))
 S PATIENT("Patient","kState")=$G(PATIENTARR(FNBR1,IENS1,.217,"E"))
 S PATIENT("Patient","kStateId")=$G(PATIENTARR(FNBR1,IENS1,.217,"I"))
 S PATIENT("Patient","kZipCode")=$G(PATIENTARR(FNBR1,IENS1,.218,"E"))
 S PATIENT("Patient","kZip4")=$G(PATIENTARR(FNBR1,IENS1,.2207,"E"))
 S PATIENT("Patient","kPhoneNumber")=$G(PATIENTARR(FNBR1,IENS1,.219,"E"))
 S PATIENT("Patient","kWorkPhoneNumber")=$G(PATIENTARR(FNBR1,IENS1,.21011,"E"))
 S PATIENT("Patient","fatherSName")=$G(PATIENTARR(FNBR1,IENS1,.2401,"E"))
 S PATIENT("Patient","motherSName")=$G(PATIENTARR(FNBR1,IENS1,.2402,"E"))
 S PATIENT("Patient","motherSMaidenName")=$G(PATIENTARR(FNBR1,IENS1,.2403,"E"))
 S PATIENT("Patient","employerName")=$G(PATIENTARR(FNBR1,IENS1,.3111,"E"))
 S PATIENT("Patient","employmentStatus")=$G(PATIENTARR(FNBR1,IENS1,.31115,"E"))
 S PATIENT("Patient","employmentStatusCd")=$G(PATIENTARR(FNBR1,IENS1,.31115,"I"))
 S PATIENT("Patient","governmentAgency")=$G(PATIENTARR(FNBR1,IENS1,.3112,"E"))
 S PATIENT("Patient","governmentAgencyCd")=$G(PATIENTARR(FNBR1,IENS1,.3112,"I"))
 S PATIENT("Patient","employerStreetLine1")=$G(PATIENTARR(FNBR1,IENS1,.3113,"E"))
 S PATIENT("Patient","employerStreetLine2")=$G(PATIENTARR(FNBR1,IENS1,.3114,"E"))
 S PATIENT("Patient","employerStreetLine3")=$G(PATIENTARR(FNBR1,IENS1,.3115,"E"))
 S PATIENT("Patient","employerCity")=$G(PATIENTARR(FNBR1,IENS1,.3116,"E"))
 S PATIENT("Patient","employerState")=$G(PATIENTARR(FNBR1,IENS1,.3117,"E"))
 S PATIENT("Patient","employerStateId")=$G(PATIENTARR(FNBR1,IENS1,.3117,"I"))
 S PATIENT("Patient","employerZipCode")=$G(PATIENTARR(FNBR1,IENS1,.3118,"E"))
 S PATIENT("Patient","employerZip4")=$G(PATIENTARR(FNBR1,IENS1,.2205,"E"))
 S PATIENT("Patient","employerPhoneNumber")=$G(PATIENTARR(FNBR1,IENS1,.3119,"E"))
 S PATIENT("Patient","emrContactSameAsNok")=$G(PATIENTARR(FNBR1,IENS1,.3305,"E"))
 S PATIENT("Patient","emrContactSameAsNokCd")=$G(PATIENTARR(FNBR1,IENS1,.3305,"I"))
 S PATIENT("Patient","emrName")=$G(PATIENTARR(FNBR1,IENS1,.331,"E"))
 S PATIENT("Patient","emrRelationshipToPatient")=$G(PATIENTARR(FNBR1,IENS1,.332,"E"))
 S PATIENT("Patient","emrStreetAddressLine1")=$G(PATIENTARR(FNBR1,IENS1,.333,"E"))
 S PATIENT("Patient","emrStreetAddressLine2")=$G(PATIENTARR(FNBR1,IENS1,.334,"E"))
 S PATIENT("Patient","emrStreetAddressLine3")=$G(PATIENTARR(FNBR1,IENS1,.335,"E"))
 S PATIENT("Patient","emrCity")=$G(PATIENTARR(FNBR1,IENS1,.336,"E"))
 S PATIENT("Patient","emrState")=$G(PATIENTARR(FNBR1,IENS1,.337,"E"))
 S PATIENT("Patient","emrStateId")=$G(PATIENTARR(FNBR1,IENS1,.337,"I"))
 S PATIENT("Patient","emrZipCode")=$G(PATIENTARR(FNBR1,IENS1,.338,"E"))
 S PATIENT("Patient","emrZip4")=$G(PATIENTARR(FNBR1,IENS1,.2201,"E"))
 S PATIENT("Patient","emrPhoneNumber")=$G(PATIENTARR(FNBR1,IENS1,.339,"E"))
 S PATIENT("Patient","emrWorkPhoneNumber")=$G(PATIENTARR(FNBR1,IENS1,.33011,"E"))
 S PATIENT("Patient","dateOfDeath")=$G(PATIENTARR(FNBR1,IENS1,.351,"E"))
 S PATIENT("Patient","dateOfDeathFM")=$G(PATIENTARR(FNBR1,IENS1,.351,"I"))
 S PATIENT("Patient","dateOfDeathHL7")=$$FMTHL7^XLFDT($G(PATIENTARR(FNBR1,IENS1,.351,"I")))
 S PATIENT("Patient","dateOfDeathFHIR")=$$FMTFHIR^SYNDHPUTL($G(PATIENTARR(FNBR1,IENS1,.351,"I")))
 S PATIENT("Patient","deathEnteredBy")=$G(PATIENTARR(FNBR1,IENS1,.352,"E"))
 S PATIENT("Patient","deathEnteredById")=$G(PATIENTARR(FNBR1,IENS1,.352,"I"))
 S PATIENT("Patient","testPatientIndicator")=$G(PATIENTARR(FNBR1,IENS1,.6,"E"))
 S PATIENT("Patient","testPatientIndicatorCd")=$G(PATIENTARR(FNBR1,IENS1,.6,"I"))
 S PATIENT("Patient","preferredFacility")=$G(PATIENTARR(FNBR1,IENS1,27.02,"E"))
 S PATIENT("Patient","preferredFacilityId")=$G(PATIENTARR(FNBR1,IENS1,27.02,"I"))
 S PATIENT("Patient","integrationControlNumber")=$G(PATIENTARR(FNBR1,IENS1,991.01,"E"))
 S PATIENT("Patient","icnChecksum")=$G(PATIENTARR(FNBR1,IENS1,991.02,"E"))
 S PATIENT("Patient","fullICN")=$G(PATIENTARR(FNBR1,IENS1,991.1,"E"))
 S PATIENT("Patient","multipleBirthIndicator")=$G(PATIENTARR(FNBR1,IENS1,994,"E"))
 S PATIENT("Patient","multipleBirthIndicatorCd")=$G(PATIENTARR(FNBR1,IENS1,994,"I"))
 S PATIENT("Patient","veteranYN")=$G(PATIENTARR(FNBR1,IENS1,1901,"E"))
 S PATIENT("Patient","veteranYNCd")=$G(PATIENTARR(FNBR1,IENS1,1901,"I"))
 N IENS2 S IENS2=""
 F  S IENS2=$O(PATIENTARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N CONFADRS S CONFADRS=$NA(PATIENT("Patient","confidentialAddressCategorys","confidentialAddressCategory",+IENS2))
 . S @CONFADRS@("confidentialAddressCategory")=$G(PATIENTARR(FNBR2,IENS2,.01,"E"))
 . S @CONFADRS@("confidentialAddressCategoryCd")=$G(PATIENTARR(FNBR2,IENS2,.01,"I"))
 . S @CONFADRS@("confidentialCategoryActive")=$G(PATIENTARR(FNBR2,IENS2,1,"E"))
 . S @CONFADRS@("confidentialCategoryActiveCd")=$G(PATIENTARR(FNBR2,IENS2,1,"I"))
 . S @CONFADRS@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATIENTIEN,FNBR2_U_+IENS2)
 N IENS3 S IENS3=""
 F  S IENS3=$O(PATIENTARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . N ALIAS S ALIAS=$NA(PATIENT("Patient","aliass","alias",+IENS3))
 . S @ALIAS@("alias")=$G(PATIENTARR(FNBR3,IENS3,.01,"E"))
 . S @ALIAS@("aliasSsn")=$G(PATIENTARR(FNBR3,IENS3,1,"E"))
 . S @ALIAS@("aliasComponents")=$G(PATIENTARR(FNBR3,IENS3,100.03,"E"))
 . S @ALIAS@("aliasComponentsId")=$G(PATIENTARR(FNBR3,IENS3,100.03,"I"))
 . S @ALIAS@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATIENTIEN,FNBR3_U_+IENS3)
 N IENS4 S IENS4=""
 F  S IENS4=$O(PATIENTARR(FNBR4,IENS4)) QUIT:IENS4=""  D
 . N RACE S RACE=$NA(PATIENT("Patient","raceInformations","raceInformation",+IENS4))
 . S @RACE@("raceInformation")=$G(PATIENTARR(FNBR4,IENS4,.01,"E"))
 . S @RACE@("raceInformationId")=$G(PATIENTARR(FNBR4,IENS4,.01,"I"))
 . S @RACE@("methodOfCollection")=$G(PATIENTARR(FNBR4,IENS4,.02,"E"))
 . S @RACE@("methodOfCollectionId")=$G(PATIENTARR(FNBR4,IENS4,.02,"I"))
 . S @RACE@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATIENTIEN,FNBR4_U_+IENS4)
 N IENS5 S IENS5=""
 F  S IENS5=$O(PATIENTARR(FNBR5,IENS5)) QUIT:IENS5=""  D
 . N ETHNIC S ETHNIC=$NA(PATIENT("Patient","ethnicityInformations","ethnicityInformation",+IENS5))
 . S @ETHNIC@("ethnicityInformation")=$G(PATIENTARR(FNBR5,IENS5,.01,"E"))
 . S @ETHNIC@("ethnicityInformationId")=$G(PATIENTARR(FNBR5,IENS5,.01,"I"))
 . S @ETHNIC@("methodOfCollection")=$G(PATIENTARR(FNBR5,IENS5,.02,"E"))
 . S @ETHNIC@("methodOfCollectionId")=$G(PATIENTARR(FNBR5,IENS5,.02,"I"))
 . S @ETHNIC@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PATIENTIEN,FNBR5_U_+IENS5)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PATIENT")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PATIENT,.PATIENTJ)
 ;
 QUIT
 ;
