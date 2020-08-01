SYNDHP10 ; HC/art - HealthConcourse - get institution data ;06/24/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GET1SITE(SITE,SITEIEN,RETJSON,SITEJ) ;get one Institution record
 ;inputs: SITEIEN - Institution IEN
 ;        RETJSON - J = Return JSON
 ;output: SITE  - array of Institution data, by reference
 ;        SITEJ - JSON structure of Institution data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Institution -----------------------------",!
 N S S S="_"
 N SITEID S SITEID=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=4 ;INSTITUTION
 N FNBR2 S FNBR2=4.03 ;CONTACT
 N FNBR3 S FNBR3=4.014 ;ASSOCIATIONS
 N FNBR4 S FNBR4=4.042 ;EFFECTIVE DATE/TIME
 N FNBR5 S FNBR5=4.043 ;TAXONOMY CODE
 N FNBR6 S FNBR6=4.999 ;HISTORY
 N FNBR7 S FNBR7=4.05 ;INSTITUTION ASSOCIATION TYPES
 N FNBR8 S FNBR8=4.9999 ;IDENTIFIER
 N IENS1 S IENS1=SITEIEN_","
 ;
 N SITEARR,SITEERR
 D GETS^DIQ(FNBR1,IENS1,"**","EI","SITEARR","SITEERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SITEARR")
 I $G(DEBUG),$D(SITEERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("SITEERR")
 I $D(SITEERR) D  QUIT
 . S SITE("Site","ERROR")=SITEIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.SITE,.SITEJ)
 S SITE("Site","siteIen")=SITEIEN
 S SITE("Site","resourceType")="Organization"
 S SITE("Site","resourceId")=$$RESID^SYNDHP69("V",SITEID,FNBR1,SITEIEN)
 S SITE("Site","siteName")=$G(SITEARR(FNBR1,IENS1,.01,"E"))
 S SITE("Site","state")=$G(SITEARR(FNBR1,IENS1,.02,"E"))
 S SITE("Site","stateId")=$G(SITEARR(FNBR1,IENS1,.02,"I"))
 S SITE("Site","district")=$G(SITEARR(FNBR1,IENS1,.03,"E"))
 S SITE("Site","shortName")=$G(SITEARR(FNBR1,IENS1,.05,"E"))
 S SITE("Site","vaTypeCode")=$G(SITEARR(FNBR1,IENS1,.06,"E"))
 S SITE("Site","vaTypeCodeCd")=$G(SITEARR(FNBR1,IENS1,.06,"I"))
 S SITE("Site","region")=$G(SITEARR(FNBR1,IENS1,.07,"E"))
 S SITE("Site","streetAddr1")=$G(SITEARR(FNBR1,IENS1,1.01,"E"))
 S SITE("Site","streetAddr2")=$G(SITEARR(FNBR1,IENS1,1.02,"E"))
 S SITE("Site","city")=$G(SITEARR(FNBR1,IENS1,1.03,"E"))
 S SITE("Site","zip")=$G(SITEARR(FNBR1,IENS1,1.04,"E"))
 S SITE("Site","stAddr1Mailing")=$G(SITEARR(FNBR1,IENS1,4.01,"E"))
 S SITE("Site","stAddr2Mailing")=$G(SITEARR(FNBR1,IENS1,4.02,"E"))
 S SITE("Site","cityMailing")=$G(SITEARR(FNBR1,IENS1,4.03,"E"))
 S SITE("Site","stateMailing")=$G(SITEARR(FNBR1,IENS1,4.04,"E"))
 S SITE("Site","stateMailingId")=$G(SITEARR(FNBR1,IENS1,4.04,"I"))
 S SITE("Site","zipMailing")=$G(SITEARR(FNBR1,IENS1,4.05,"E"))
 S SITE("Site","multiDivisionFacility")=$G(SITEARR(FNBR1,IENS1,5,"E"))
 S SITE("Site","multiDivisionFacilityCd")=$G(SITEARR(FNBR1,IENS1,5,"I"))
 S SITE("Site","status")=$G(SITEARR(FNBR1,IENS1,11,"E"))
 S SITE("Site","statusCd")=$G(SITEARR(FNBR1,IENS1,11,"I"))
 S SITE("Site","facilityType")=$G(SITEARR(FNBR1,IENS1,13,"E"))
 S SITE("Site","facilityTypeId")=$G(SITEARR(FNBR1,IENS1,13,"I"))
 S SITE("Site","npi")=$G(SITEARR(FNBR1,IENS1,41.99,"E"))
 S SITE("Site","acosHospitalId")=$G(SITEARR(FNBR1,IENS1,51,"E"))
 S SITE("Site","facilityDeaNumber")=$G(SITEARR(FNBR1,IENS1,52,"E"))
 S SITE("Site","facilityDeaExpirationDate")=$G(SITEARR(FNBR1,IENS1,52.1,"E"))
 S SITE("Site","facilityDeaExpirationDateFM")=$G(SITEARR(FNBR1,IENS1,52.1,"I"))
 S SITE("Site","facilityDeaExpirationDateHL7")=$$FMTHL7^XLFDT($G(SITEARR(FNBR1,IENS1,52.1,"I")))
 S SITE("Site","facilityDeaExpirationDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(SITEARR(FNBR1,IENS1,52.1,"I")))
 S SITE("Site","domain")=$G(SITEARR(FNBR1,IENS1,60,"E"))
 S SITE("Site","domainId")=$G(SITEARR(FNBR1,IENS1,60,"I"))
 S SITE("Site","agencyCode")=$G(SITEARR(FNBR1,IENS1,95,"E"))
 S SITE("Site","agencyCodeCd")=$G(SITEARR(FNBR1,IENS1,95,"I"))
 S SITE("Site","reportingStation")=$G(SITEARR(FNBR1,IENS1,96,"E"))
 S SITE("Site","reportingStationId")=$G(SITEARR(FNBR1,IENS1,96,"I"))
 S SITE("Site","pointerToAgency")=$G(SITEARR(FNBR1,IENS1,97,"E"))
 S SITE("Site","pointerToAgencyId")=$G(SITEARR(FNBR1,IENS1,97,"I"))
 S SITE("Site","stationNumber")=$G(SITEARR(FNBR1,IENS1,99,"E"))
 S SITE("Site","officialVaName")=$G(SITEARR(FNBR1,IENS1,100,"E"))
 S SITE("Site","inactiveFacilityFlag")=$G(SITEARR(FNBR1,IENS1,101,"E"))
 S SITE("Site","inactiveFacilityFlagCd")=$G(SITEARR(FNBR1,IENS1,101,"I"))
 S SITE("Site","billingFacilityName")=$G(SITEARR(FNBR1,IENS1,200,"E"))
 S SITE("Site","currentLocation")=$G(SITEARR(FNBR1,IENS1,720,"E"))
 S SITE("Site","currentLocationCd")=$G(SITEARR(FNBR1,IENS1,720,"I"))
 S SITE("Site","locationTimezone")=$G(SITEARR(FNBR1,IENS1,800,"E"))
 S SITE("Site","locationTimezoneId")=$G(SITEARR(FNBR1,IENS1,800,"I"))
 S SITE("Site","country")=$G(SITEARR(FNBR1,IENS1,801,"E"))
 S SITE("Site","countryId")=$G(SITEARR(FNBR1,IENS1,801,"I"))
 S SITE("Site","timezoneException")=$G(SITEARR(FNBR1,IENS1,802,"E"))
 S SITE("Site","timezoneExceptionCd")=$G(SITEARR(FNBR1,IENS1,802,"I"))
 N IENS2 S IENS2=""
 F  S IENS2=$O(SITEARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N CONTACT S CONTACT=$NA(SITE("Site","contacts","contact",+IENS2))
 . S @CONTACT@("contact")=$G(SITEARR(FNBR2,IENS2,.01,"E"))
 . S @CONTACT@("area")=$G(SITEARR(FNBR2,IENS2,.02,"E"))
 . S @CONTACT@("areaId")=$G(SITEARR(FNBR2,IENS2,.02,"I"))
 . S @CONTACT@("phone")=$G(SITEARR(FNBR2,IENS2,.03,"E"))
 . S @CONTACT@("resourceId")=$$RESID^SYNDHP69("V",SITEID,FNBR1,SITEIEN,FNBR2_U_+IENS2)
 N IENS3 S IENS3=""
 F  S IENS3=$O(SITEARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . N ASSOC S ASSOC=$NA(SITE("Site","associationss","associations",+IENS3))
 . S @ASSOC@("associations")=$G(SITEARR(FNBR3,IENS3,.01,"E"))
 . S @ASSOC@("associationsId")=$G(SITEARR(FNBR3,IENS3,.01,"I"))
 . S @ASSOC@("parentOfAssociation")=$G(SITEARR(FNBR3,IENS3,1,"E"))
 . S @ASSOC@("parentOfAssociationId")=$G(SITEARR(FNBR3,IENS3,1,"I"))
 . S @ASSOC@("resourceId")=$$RESID^SYNDHP69("V",SITEID,FNBR1,SITEIEN,FNBR3_U_+IENS3)
 N IENS4 S IENS4=""
 F  S IENS4=$O(SITEARR(FNBR4,IENS4)) QUIT:IENS4=""  D
 . N EFFDATE S EFFDATE=$NA(SITE("Site","effectiveDateTimes","effectiveDateTime",+IENS4))
 . S @EFFDATE@("effectiveDateTime")=$G(SITEARR(FNBR4,IENS4,.01,"E"))
 . S @EFFDATE@("effectiveDateTimeFM")=$G(SITEARR(FNBR4,IENS4,.01,"I"))
 . S @EFFDATE@("effectiveDateTimeHL7")=$$FMTHL7^XLFDT($G(SITEARR(FNBR4,IENS4,.01,"I")))
 . S @EFFDATE@("effectiveDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(SITEARR(FNBR4,IENS4,.01,"I")))
 . S @EFFDATE@("status")=$G(SITEARR(FNBR4,IENS4,.02,"E"))
 . S @EFFDATE@("statusCd")=$G(SITEARR(FNBR4,IENS4,.02,"I"))
 . S @EFFDATE@("npi")=$G(SITEARR(FNBR4,IENS4,.03,"E"))
 . S @EFFDATE@("resourceId")=$$RESID^SYNDHP69("V",SITEID,FNBR1,SITEIEN,FNBR4_U_+IENS4)
 N IENS5 S IENS5=""
 F  S IENS5=$O(SITEARR(FNBR5,IENS5)) QUIT:IENS5=""  D
 . N TAXON S TAXON=$NA(SITE("Site","taxonomyCodes","taxonomyCode",+IENS5))
 . S @TAXON@("taxonomyCode")=$G(SITEARR(FNBR5,IENS5,.01,"E"))
 . S @TAXON@("taxonomyCodeId")=$G(SITEARR(FNBR5,IENS5,.01,"I"))
 . S @TAXON@("primaryCode")=$G(SITEARR(FNBR5,IENS5,.02,"E"))
 . S @TAXON@("primaryCodeCd")=$G(SITEARR(FNBR5,IENS5,.02,"I"))
 . S @TAXON@("status")=$G(SITEARR(FNBR5,IENS5,.03,"E"))
 . S @TAXON@("statusCd")=$G(SITEARR(FNBR5,IENS5,.03,"I"))
 . S @TAXON@("resourceId")=$$RESID^SYNDHP69("V",SITEID,FNBR1,SITEIEN,FNBR5_U_+IENS5)
 N IENS6 S IENS6=""
 F  S IENS6=$O(SITEARR(FNBR6,IENS6)) QUIT:IENS6=""  D
 . N HISTORY S HISTORY=$NA(SITE("Site","historys","history",+IENS6))
 . S @HISTORY@("effectiveDate")=$G(SITEARR(FNBR6,IENS6,.01,"E"))
 . S @HISTORY@("effectiveDateFM")=$G(SITEARR(FNBR6,IENS6,.01,"I"))
 . S @HISTORY@("effectiveDateHL7")=$$FMTHL7^XLFDT($G(SITEARR(FNBR6,IENS6,.01,"I")))
 . S @HISTORY@("effectiveDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(SITEARR(FNBR6,IENS6,.01,"I")))
 . S @HISTORY@("nameChangedFrom")=$G(SITEARR(FNBR6,IENS6,.02,"E"))
 . S @HISTORY@("officalVaNameChangedFrom")=$G(SITEARR(FNBR6,IENS6,.03,"E"))
 . S @HISTORY@("realignedTo")=$G(SITEARR(FNBR6,IENS6,.05,"E"))
 . S @HISTORY@("realignedToId")=$G(SITEARR(FNBR6,IENS6,.05,"I"))
 . S @HISTORY@("realignedFrom")=$G(SITEARR(FNBR6,IENS6,.06,"E"))
 . S @HISTORY@("realignedFromId")=$G(SITEARR(FNBR6,IENS6,.06,"I"))
 . S @HISTORY@("deactivatedFacilitySta")=$G(SITEARR(FNBR6,IENS6,.07,"E"))
 . S @HISTORY@("deactivatedFacilityStaCd")=$G(SITEARR(FNBR6,IENS6,.07,"I"))
 . S @HISTORY@("activatedFacility")=$G(SITEARR(FNBR6,IENS6,.08,"E"))
 . S @HISTORY@("activatedFacilityCd")=$G(SITEARR(FNBR6,IENS6,.08,"I"))
 . S @HISTORY@("resourceId")=$$RESID^SYNDHP69("V",SITEID,FNBR1,SITEIEN,FNBR6_U_+IENS6)
 N IENS7 S IENS7=""
 F  S IENS7=$O(SITEARR(FNBR7,IENS7)) QUIT:IENS7=""  D
 . N ASSTYPE S ASSTYPE=$NA(SITE("Site","institutionAssociationTypess","institutionAssociationTypes",+IENS7))
 . S @ASSTYPE@("number")=$G(SITEARR(FNBR7,IENS7,.001,"E"))
 . S @ASSTYPE@("name")=$G(SITEARR(FNBR7,IENS7,.01,"E"))
 . S @ASSTYPE@("resourceId")=$$RESID^SYNDHP69("V",SITEID,FNBR1,SITEIEN,FNBR7_U_+IENS7)
 N IENS8 S IENS8=""
 F  S IENS8=$O(SITEARR(FNBR8,IENS8)) QUIT:IENS8=""  D
 . N IDENT S IDENT=$NA(SITE("Site","identifiers","identifier",+IENS8))
 . S @IDENT@("codingSystem")=$G(SITEARR(FNBR8,IENS8,.01,"E"))
 . S @IDENT@("id")=$G(SITEARR(FNBR8,IENS8,.02,"E"))
 . S @IDENT@("effectiveDateTime")=$G(SITEARR(FNBR8,IENS8,.03,"E"))
 . S @IDENT@("effectiveDateTimeFM")=$G(SITEARR(FNBR8,IENS8,.03,"I"))
 . S @IDENT@("effectiveDateTimeHL7")=$$FMTHL7^XLFDT($G(SITEARR(FNBR8,IENS8,.03,"I")))
 . S @IDENT@("effectiveDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(SITEARR(FNBR8,IENS8,.03,"I")))
 . S @IDENT@("status")=$G(SITEARR(FNBR8,IENS8,.04,"E"))
 . S @IDENT@("statusCd")=$G(SITEARR(FNBR8,IENS8,.04,"I"))
 . S @IDENT@("resourceId")=$$RESID^SYNDHP69("V",SITEID,FNBR1,SITEIEN,FNBR8_U_+IENS8)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SITE")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.SITE,.SITEJ)
 ;
 QUIT
 ;
