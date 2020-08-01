SYNDHP22 ; HC/art - HealthConcourse - get hospital location data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;-------------------------------------------------------------
 ;
GETHLOC(HOSPLOC,HLOCIEN,RETJSON,HOSPLOCJ) ;get one Hospital Location record
 ; This API does not return all Hospital Location fields. In general, fields related to appointments are omitted
 ;inputs: HLOCIEN - Hospital Location IEN
 ;        RETJSON - J = Return JSON
 ;output: HOSPLOC  - array of Hospital Location data, by reference
 ;        HOSPLOCJ - JSON structure of Hospital Location data, by reference
 ;
 I $G(DEBUG) W !,"--------------------------- Hospital Location -----------------------------",!
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=44 ;HOSPITAL LOCATION
 N FNBR2 S FNBR2=44.01 ;SYNONYM
 N FNBR3 S FNBR3=44.101 ;ASSOCIATED LOCATION TYPES
 N FNBR4 S FNBR4=44.1 ;PROVIDER
 N IENS1 S IENS1=HLOCIEN_","
 N FIELDS S FIELDS=".01:4;7:10;13*;14:16;23;42;99;99.1;101*;1916;1920.9;2502;2503:2506;2600*"
 ;
 N HOSPLOCARR,HOSPLOCERR
 D GETS^DIQ(FNBR1,IENS1,FIELDS,"EI","HOSPLOCARR","HOSPLOCERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("HOSPLOCARR")
 I $G(DEBUG),$D(HOSPLOCERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("HOSPLOCERR")
 I $D(HOSPLOCERR) D  QUIT
 . S HOSPLOC("Hosploc","ERROR")=HLOCIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.HOSPLOC,.HOSPLOCJ)
 N HLOC S HLOC=$NA(HOSPLOC("Hosploc"))
 S @HLOC@("hosplocIen")=HLOCIEN
 S @HLOC@("resourceType")="Organization"
 S @HLOC@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,HLOCIEN)
 S @HLOC@("name")=$G(HOSPLOCARR(FNBR1,IENS1,.01,"E"))
 S @HLOC@("abbreviation")=$G(HOSPLOCARR(FNBR1,IENS1,1,"E"))
 S @HLOC@("type")=$G(HOSPLOCARR(FNBR1,IENS1,2,"E"))
 S @HLOC@("typeCd")=$G(HOSPLOCARR(FNBR1,IENS1,2,"I"))
 S @HLOC@("typeExtension")=$G(HOSPLOCARR(FNBR1,IENS1,2.1,"E"))
 S @HLOC@("typeExtensionId")=$G(HOSPLOCARR(FNBR1,IENS1,2.1,"I"))
 S @HLOC@("institution")=$G(HOSPLOCARR(FNBR1,IENS1,3,"E"))
 S @HLOC@("institutionId")=$G(HOSPLOCARR(FNBR1,IENS1,3,"I"))
 S @HLOC@("division")=$G(HOSPLOCARR(FNBR1,IENS1,3.5,"E"))
 S @HLOC@("divisionId")=$G(HOSPLOCARR(FNBR1,IENS1,3.5,"I"))
 S @HLOC@("module")=$G(HOSPLOCARR(FNBR1,IENS1,4,"E"))
 S @HLOC@("moduleId")=$G(HOSPLOCARR(FNBR1,IENS1,4,"I"))
 S @HLOC@("visitLocation")=$G(HOSPLOCARR(FNBR1,IENS1,7,"E"))
 S @HLOC@("stopCodeNumber")=$G(HOSPLOCARR(FNBR1,IENS1,8,"E"))
 S @HLOC@("stopCodeNumberId")=$G(HOSPLOCARR(FNBR1,IENS1,8,"I"))
 S @HLOC@("prvYearStopCode")=$G(HOSPLOCARR(FNBR1,IENS1,8.1,"E"))
 S @HLOC@("prvYearStopCodeId")=$G(HOSPLOCARR(FNBR1,IENS1,8.1,"I"))
 S @HLOC@("service")=$G(HOSPLOCARR(FNBR1,IENS1,9,"E"))
 S @HLOC@("serviceCd")=$G(HOSPLOCARR(FNBR1,IENS1,9,"I"))
 S @HLOC@("treatingSpecialty")=$G(HOSPLOCARR(FNBR1,IENS1,9.5,"E"))
 S @HLOC@("treatingSpecialtyId")=$G(HOSPLOCARR(FNBR1,IENS1,9.5,"I"))
 S @HLOC@("physicalLocation")=$G(HOSPLOCARR(FNBR1,IENS1,10,"E"))
 S @HLOC@("specialAmisStop")=$G(HOSPLOCARR(FNBR1,IENS1,14,"E"))
 S @HLOC@("specialAmisStopCd")=$G(HOSPLOCARR(FNBR1,IENS1,14,"I"))
 S @HLOC@("categoryOfVisit")=$G(HOSPLOCARR(FNBR1,IENS1,15,"E"))
 S @HLOC@("defaultProvider")=$G(HOSPLOCARR(FNBR1,IENS1,16,"E"))
 S @HLOC@("defaultProviderId")=$G(HOSPLOCARR(FNBR1,IENS1,16,"I"))
 S @HLOC@("defaultProviderNPI")=$$GET1^DIQ(200,@HLOC@("defaultProviderId")_",",41.99) ;NPI
 S @HLOC@("agency")=$G(HOSPLOCARR(FNBR1,IENS1,23,"E"))
 S @HLOC@("agencyId")=$G(HOSPLOCARR(FNBR1,IENS1,23,"I"))
 S @HLOC@("wardLocationFilePointer")=$G(HOSPLOCARR(FNBR1,IENS1,42,"E"))
 S @HLOC@("wardLocationFilePointerId")=$G(HOSPLOCARR(FNBR1,IENS1,42,"I"))
 S @HLOC@("telephone")=$G(HOSPLOCARR(FNBR1,IENS1,99,"E"))
 S @HLOC@("telephoneExtension")=$G(HOSPLOCARR(FNBR1,IENS1,99.1,"E"))
 S @HLOC@("principalClinic")=$G(HOSPLOCARR(FNBR1,IENS1,1916,"E"))
 S @HLOC@("principalClinicId")=$G(HOSPLOCARR(FNBR1,IENS1,1916,"I"))
 S @HLOC@("availabilityFlag")=$G(HOSPLOCARR(FNBR1,IENS1,1920.9,"E"))
 S @HLOC@("availabilityFlagFM")=$G(HOSPLOCARR(FNBR1,IENS1,1920.9,"I"))
 S @HLOC@("availabilityFlagHL7")=$$FMTHL7^XLFDT($G(HOSPLOCARR(FNBR1,IENS1,1920.9,"I")))
 S @HLOC@("availabilityFlagFHIR")=$$FMTFHIR^SYNDHPUTL($G(HOSPLOCARR(FNBR1,IENS1,1920.9,"I")))
 S @HLOC@("nonCountClinicYOrN")=$G(HOSPLOCARR(FNBR1,IENS1,2502,"E"))
 S @HLOC@("nonCountClinicYOrNCd")=$G(HOSPLOCARR(FNBR1,IENS1,2502,"I"))
 S @HLOC@("creditStopCode")=$G(HOSPLOCARR(FNBR1,IENS1,2503,"E"))
 S @HLOC@("creditStopCodeId")=$G(HOSPLOCARR(FNBR1,IENS1,2503,"I"))
 S @HLOC@("prvYearCreditStopCode")=$G(HOSPLOCARR(FNBR1,IENS1,2503.1,"E"))
 S @HLOC@("prvYearCreditStopCodeId")=$G(HOSPLOCARR(FNBR1,IENS1,2503.1,"I"))
 S @HLOC@("clinicMeetsAtThisFacility")=$G(HOSPLOCARR(FNBR1,IENS1,2504,"E"))
 S @HLOC@("clinicMeetsAtThisFacilityCd")=$G(HOSPLOCARR(FNBR1,IENS1,2504,"I"))
 S @HLOC@("inactivateDate")=$G(HOSPLOCARR(FNBR1,IENS1,2505,"E"))
 S @HLOC@("inactivateDateFM")=$G(HOSPLOCARR(FNBR1,IENS1,2505,"I"))
 S @HLOC@("inactivateDateHL7")=$$FMTHL7^XLFDT($G(HOSPLOCARR(FNBR1,IENS1,2505,"I")))
 S @HLOC@("inactivateDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(HOSPLOCARR(FNBR1,IENS1,2505,"I")))
 S @HLOC@("reactivateDate")=$G(HOSPLOCARR(FNBR1,IENS1,2506,"E"))
 S @HLOC@("reactivateDateFM")=$G(HOSPLOCARR(FNBR1,IENS1,2506,"I"))
 S @HLOC@("reactivateDateHL7")=$$FMTHL7^XLFDT($G(HOSPLOCARR(FNBR1,IENS1,2506,"I")))
 S @HLOC@("reactivateDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(HOSPLOCARR(FNBR1,IENS1,2506,"I")))
 N IENS2 S IENS2=""
 F  S IENS2=$O(HOSPLOCARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . N SYNONYM S SYNONYM=$NA(HOSPLOC("Hosploc","synonyms","synonym",+IENS2))
 . S @SYNONYM@("synonym")=$G(HOSPLOCARR(FNBR2,IENS2,.01,"E"))
 . S @SYNONYM@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,HLOCIEN,FNBR2_U_+IENS2)
 N IENS3 S IENS3=""
 F  S IENS3=$O(HOSPLOCARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . N ASSLOCTP S ASSLOCTP=$NA(HOSPLOC("Hosploc","associatedLocationTypess","associatedLocationTypes",+IENS3))
 . S @ASSLOCTP@("associatedLocationTypes")=$G(HOSPLOCARR(FNBR3,IENS3,.01,"E"))
 . S @ASSLOCTP@("associatedLocationTypesId")=$G(HOSPLOCARR(FNBR3,IENS3,.01,"I"))
 . S @ASSLOCTP@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,HLOCIEN,FNBR3_U_+IENS3)
 N IENS4 S IENS4=""
 F  S IENS4=$O(HOSPLOCARR(FNBR4,IENS4)) QUIT:IENS4=""  D
 . N PROVIDER S PROVIDER=$NA(HOSPLOC("Hosploc","providers","provider",+IENS4))
 . S @PROVIDER@("provider")=$G(HOSPLOCARR(FNBR4,IENS4,.01,"E"))
 . S @PROVIDER@("providerId")=$G(HOSPLOCARR(FNBR4,IENS4,.01,"I"))
 . S @PROVIDER@("providerNPI")=$$GET1^DIQ(200,@PROVIDER@("providerId")_",",41.99) ;NPI
 . S @PROVIDER@("providerResId")=$$RESID^SYNDHP69("V",SITE,200,@PROVIDER@("providerId"))
 . S @PROVIDER@("defaultProvider")=$G(HOSPLOCARR(FNBR4,IENS4,.02,"E"))
 . S @PROVIDER@("defaultProviderCd")=$G(HOSPLOCARR(FNBR4,IENS4,.02,"I"))
 . S @PROVIDER@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,HLOCIEN,FNBR4_U_+IENS4)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("HOSPLOC")
 ;
 D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.HOSPLOC,.HOSPLOCJ)
 ;
 QUIT
 ;
