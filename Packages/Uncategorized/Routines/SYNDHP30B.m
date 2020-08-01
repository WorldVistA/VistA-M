SYNDHP30B ; HC/art - HealthConcourse - continuation of get Pharmacy Patient data ;08/28/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
PHCONT2 ;
 ;
 N IENS3 S IENS3=""
 F  S IENS3=$O(PHPATARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . N NONVA S NONVA=$NA(PHPAT("Phpat","nonVaMedss","nonVaMeds",+IENS3))
 . S @NONVA@("orderableItem")=$G(PHPATARR(FNBR3,IENS3,.01,"E"))
 . S @NONVA@("orderableItemId")=$G(PHPATARR(FNBR3,IENS3,.01,"I"))
 . S @NONVA@("dispenseDrug")=$G(PHPATARR(FNBR3,IENS3,1,"E"))
 . S @NONVA@("dispenseDrugId")=$G(PHPATARR(FNBR3,IENS3,1,"I"))
 . S @NONVA@("dispenseDrugName")=$$GET1^DIQ(50,@NONVA@("dispenseDrugId")_",",20)
 . S @NONVA@("dispenseDrugNameId")=$$GET1^DIQ(50,@NONVA@("dispenseDrugId")_",",20,"I")
 . S @NONVA@("dispenseDrugRxNorm")=$$GETRXN^SYNDHPUTL(@NONVA@("dispenseDrugId"))
 . S @NONVA@("dosage")=$G(PHPATARR(FNBR3,IENS3,2,"E"))
 . S @NONVA@("medicationRoute")=$G(PHPATARR(FNBR3,IENS3,3,"E"))
 . S @NONVA@("schedule")=$G(PHPATARR(FNBR3,IENS3,4,"E"))
 . S @NONVA@("status")=$G(PHPATARR(FNBR3,IENS3,5,"E"))
 . S @NONVA@("statusCd")=$G(PHPATARR(FNBR3,IENS3,5,"I"))
 . S @NONVA@("discontinuedDate")=$G(PHPATARR(FNBR3,IENS3,6,"E"))
 . S @NONVA@("discontinuedDateFM")=$G(PHPATARR(FNBR3,IENS3,6,"I"))
 . S @NONVA@("discontinuedDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR3,IENS3,6,"I")))
 . S @NONVA@("discontinuedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR3,IENS3,6,"I")))
 . S @NONVA@("orderNumber")=$G(PHPATARR(FNBR3,IENS3,7,"E"))
 . S @NONVA@("orderNumberId")=$G(PHPATARR(FNBR3,IENS3,7,"I"))
 . S @NONVA@("startDate")=$G(PHPATARR(FNBR3,IENS3,8,"E"))
 . S @NONVA@("startDateFM")=$G(PHPATARR(FNBR3,IENS3,8,"I"))
 . S @NONVA@("startDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR3,IENS3,8,"I")))
 . S @NONVA@("startDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR3,IENS3,8,"I")))
 . S @NONVA@("disclaimer")=""
 . N Z S Z=""
 . F  S Z=$O(PHPATARR(FNBR3,IENS3,10,Z)) QUIT:'+Z  D
 . . S @NONVA@("disclaimer")=@NONVA@("disclaimer")_$G(PHPATARR(FNBR3,IENS3,10,Z))
 . S @NONVA@("documentedDate")=$G(PHPATARR(FNBR3,IENS3,11,"E"))
 . S @NONVA@("documentedDateFM")=$G(PHPATARR(FNBR3,IENS3,11,"I"))
 . S @NONVA@("documentedDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR3,IENS3,11,"I")))
 . S @NONVA@("documentedDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR3,IENS3,11,"I")))
 . S @NONVA@("documentedBy")=$G(PHPATARR(FNBR3,IENS3,12,"E"))
 . S @NONVA@("documentedById")=$G(PHPATARR(FNBR3,IENS3,12,"I"))
 . S @NONVA@("documentedByResId")=$$RESID^SYNDHP69("V",SITE,200,@NONVA@("documentedById"))
 . S @NONVA@("clinic")=$G(PHPATARR(FNBR3,IENS3,13,"E"))
 . S @NONVA@("clinicId")=$G(PHPATARR(FNBR3,IENS3,13,"I"))
 . S @NONVA@("comments")=""
 . N Z S Z=""
 . F  S Z=$O(PHPATARR(FNBR3,IENS3,14,Z)) QUIT:'+Z  D
 . . S @NONVA@("comments")=@NONVA@("comments")_$G(PHPATARR(FNBR3,IENS3,14,Z))
 . S @NONVA@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR3_U_+IENS3)
 ;
 N IENS4 S IENS4=""
 F  S IENS4=$O(PHPATARR(FNBR4,IENS4)) QUIT:IENS4=""  D
 . N ORDCHK S ORDCHK=$NA(PHPAT("Phpat","nonVaMedss","nonVaMeds",$P(IENS4,C,2),"orderCheckss","orderChecks",+IENS4))
 . S @ORDCHK@("orderCheckNarrative")=$G(PHPATARR(FNBR4,IENS4,.01,"E"))
 . S @ORDCHK@("overridingProvider")=$G(PHPATARR(FNBR4,IENS4,1,"E"))
 . S @ORDCHK@("overridingProviderId")=$G(PHPATARR(FNBR4,IENS4,1,"I"))
 . S @ORDCHK@("overridingProviderNPI")=$$GET1^DIQ(200,@ORDCHK@("overridingProviderId")_",",41.99) ;NPI
 . S @ORDCHK@("overridingProviderResId")=$$RESID^SYNDHP69("V",SITE,200,@ORDCHK@("overridingProviderId"))
 . S @ORDCHK@("overridingReason")=""
 . N Z S Z=""
 . F  S Z=$O(PHPATARR(FNBR4,IENS4,2,Z)) QUIT:'+Z  D
 . . S @ORDCHK@("overridingReason")=@ORDCHK@("overridingReason")_$G(PHPATARR(FNBR4,IENS4,2,Z))
 . S @ORDCHK@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR3_U_$P(IENS4,C,2)_U_FNBR4_U_+IENS4)
 ;
 N IENS6 S IENS6=""
 F  S IENS6=$O(PHPATARR(FNBR6,IENS6)) QUIT:IENS6=""  D
 . N DISPDR S DISPDR=$NA(PHPAT("Phpat","unitDoses","unitDose",$P(IENS6,C,2),"dispenseDrugs","dispenseDrug",+IENS6))
 . S @DISPDR@("dispenseDrug")=$G(PHPATARR(FNBR6,IENS6,.01,"E"))
 . S @DISPDR@("dispenseDrugId")=$G(PHPATARR(FNBR6,IENS6,.01,"I"))
 . S @DISPDR@("dispenseDrugName")=$$GET1^DIQ(50,@DISPDR@("dispenseDrugId")_",",20)
 . S @DISPDR@("dispenseDrugNameId")=$$GET1^DIQ(50,@DISPDR@("dispenseDrugId")_",",20,"I")
 . S @DISPDR@("dispenseDrugRxNorm")=$$GETRXN^SYNDHPUTL(@DISPDR@("dispenseDrugId"))
 . S @DISPDR@("unitsPerDose")=$G(PHPATARR(FNBR6,IENS6,.02,"E"))
 . S @DISPDR@("inactiveDate")=$G(PHPATARR(FNBR6,IENS6,.03,"E"))
 . S @DISPDR@("inactiveDateFM")=$G(PHPATARR(FNBR6,IENS6,.03,"I"))
 . S @DISPDR@("inactiveDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR6,IENS6,.03,"I")))
 . S @DISPDR@("inactiveDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR6,IENS6,.03,"I")))
 . S @DISPDR@("totalUnitsDispensedC")=$G(PHPATARR(FNBR6,IENS6,.04,"E"))
 . S @DISPDR@("unitsCalledFor")=$G(PHPATARR(FNBR6,IENS6,.05,"E"))
 . S @DISPDR@("unitsActuallyDispensed")=$G(PHPATARR(FNBR6,IENS6,.06,"E"))
 . S @DISPDR@("totalReturns")=$G(PHPATARR(FNBR6,IENS6,.07,"E"))
 . S @DISPDR@("returns")=$G(PHPATARR(FNBR6,IENS6,.08,"E"))
 . S @DISPDR@("preExchangeUnits")=$G(PHPATARR(FNBR6,IENS6,.09,"E"))
 . S @DISPDR@("totalExtraUnitsDispensed")=$G(PHPATARR(FNBR6,IENS6,.1,"E"))
 . S @DISPDR@("extraUnitsDispensed")=$G(PHPATARR(FNBR6,IENS6,.11,"E"))
 . S @DISPDR@("totalPreExchangeUnits")=$G(PHPATARR(FNBR6,IENS6,.12,"E"))
 . S @DISPDR@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR5_U_$P(IENS6,C,2)_U_FNBR6_U_+IENS6)
 ;
 N IENS7 S IENS7=""
 F  S IENS7=$O(PHPATARR(FNBR7,IENS7)) QUIT:IENS7=""  D
 . N UACTLOG S UACTLOG=$NA(PHPAT("Phpat","unitDoses","unitDose",$P(IENS7,C,2),"activityLogs","activityLog",+IENS7))
 . S @UACTLOG@("date")=$G(PHPATARR(FNBR7,IENS7,.01,"E"))
 . S @UACTLOG@("dateFM")=$G(PHPATARR(FNBR7,IENS7,.01,"I"))
 . S @UACTLOG@("dateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR7,IENS7,.01,"I")))
 . S @UACTLOG@("dateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR7,IENS7,.01,"I")))
 . S @UACTLOG@("user")=$G(PHPATARR(FNBR7,IENS7,1,"E"))
 . S @UACTLOG@("action")=$G(PHPATARR(FNBR7,IENS7,2,"E"))
 . S @UACTLOG@("actionId")=$G(PHPATARR(FNBR7,IENS7,2,"I"))
 . S @UACTLOG@("field")=$G(PHPATARR(FNBR7,IENS7,3,"E"))
 . S @UACTLOG@("oldData")=$G(PHPATARR(FNBR7,IENS7,4,"E"))
 . S @UACTLOG@("oldDataWordProcessing")=""
 . N Z S Z=""
 . F  S Z=$O(PHPATARR(FNBR7,IENS7,5,Z)) QUIT:'+Z  D
 . . S @UACTLOG@("oldDataWordProcessing")=@UACTLOG@("oldDataWordProcessing")_$G(PHPATARR(FNBR7,IENS7,5,Z))
 . S @UACTLOG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR5_U_$P(IENS7,C,2)_U_FNBR7_U_+IENS7)
 ;
 N IENS8 S IENS8=""
 F  S IENS8=$O(PHPATARR(FNBR8,IENS8)) QUIT:IENS8=""  D
 . N UDSPLOG S UDSPLOG=$NA(PHPAT("Phpat","unitDoses","unitDose",$P(IENS8,C,2),"dispenseLogs","dispenseLog",+IENS8))
 . S @UDSPLOG@("dispenseDateTime")=$G(PHPATARR(FNBR8,IENS8,.01,"E"))
 . S @UDSPLOG@("dispenseDateTimeFM")=$G(PHPATARR(FNBR8,IENS8,.01,"I"))
 . S @UDSPLOG@("dispenseDateTimeHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR8,IENS8,.01,"I")))
 . S @UDSPLOG@("dispenseDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR8,IENS8,.01,"I")))
 . S @UDSPLOG@("dispenseDrug")=$G(PHPATARR(FNBR8,IENS8,.02,"E"))
 . S @UDSPLOG@("dispenseDrugId")=$G(PHPATARR(FNBR8,IENS8,.02,"I"))
 . S @UDSPLOG@("amount")=$G(PHPATARR(FNBR8,IENS8,.03,"E"))
 . S @UDSPLOG@("cost")=$G(PHPATARR(FNBR8,IENS8,.04,"E"))
 . S @UDSPLOG@("how")=$G(PHPATARR(FNBR8,IENS8,.05,"E"))
 . S @UDSPLOG@("howCd")=$G(PHPATARR(FNBR8,IENS8,.05,"I"))
 . S @UDSPLOG@("user")=$G(PHPATARR(FNBR8,IENS8,.06,"E"))
 . S @UDSPLOG@("userId")=$G(PHPATARR(FNBR8,IENS8,.06,"I"))
 . S @UDSPLOG@("ward")=$G(PHPATARR(FNBR8,IENS8,.07,"E"))
 . S @UDSPLOG@("wardId")=$G(PHPATARR(FNBR8,IENS8,.07,"I"))
 . S @UDSPLOG@("provider")=$G(PHPATARR(FNBR8,IENS8,.08,"E"))
 . S @UDSPLOG@("providerId")=$G(PHPATARR(FNBR8,IENS8,.08,"I"))
 . S @UDSPLOG@("providerNPI")=$$GET1^DIQ(200,@UDSPLOG@("providerId")_",",41.99) ;NPI
 . S @UDSPLOG@("providerResId")=$$RESID^SYNDHP69("V",SITE,200,@UDSPLOG@("providerId"))
 . S @UDSPLOG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR5_U_$P(IENS8,C,2)_U_FNBR8_U_+IENS8)
 ;
 N IENS9 S IENS9=""
 F  S IENS9=$O(PHPATARR(FNBR9,IENS9)) QUIT:IENS9=""  D
 . N ULAST S ULAST=$NA(PHPAT("Phpat","unitDoses","unitDose",$P(IENS9,C,2),"lastRenews","lastRenew",+IENS9))
 . S @ULAST@("lastRenew")=$G(PHPATARR(FNBR9,IENS9,.01,"E"))
 . S @ULAST@("lastRenewFM")=$G(PHPATARR(FNBR9,IENS9,.01,"I"))
 . S @ULAST@("lastRenewHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR9,IENS9,.01,"I")))
 . S @ULAST@("lastRenewFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR9,IENS9,.01,"I")))
 . S @ULAST@("renewedBy")=$G(PHPATARR(FNBR9,IENS9,1,"E"))
 . S @ULAST@("renewedById")=$G(PHPATARR(FNBR9,IENS9,1,"I"))
 . S @ULAST@("renewedByNPI")=$$GET1^DIQ(200,@ULAST@("renewedById")_",",41.99) ;NPI
 . S @ULAST@("renewedByResId")=$$RESID^SYNDHP69("V",SITE,200,@ULAST@("renewedById"))
 . S @ULAST@("previousProvider")=$G(PHPATARR(FNBR9,IENS9,2,"E"))
 . S @ULAST@("previousProviderId")=$G(PHPATARR(FNBR9,IENS9,2,"I"))
 . S @ULAST@("previousProviderNPI")=$$GET1^DIQ(200,@ULAST@("previousProviderId")_",",41.99) ;NPI
 . S @ULAST@("previousProviderResId")=$$RESID^SYNDHP69("V",SITE,200,@ULAST@("previousProviderId"))
 . S @ULAST@("previousStopDateTime")=$G(PHPATARR(FNBR9,IENS9,3,"E"))
 . S @ULAST@("previousStopDateTimeFM")=$G(PHPATARR(FNBR9,IENS9,3,"I"))
 . S @ULAST@("previousStopDateTimeHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR9,IENS9,3,"I")))
 . S @ULAST@("previousStopDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR9,IENS9,3,"I")))
 . S @ULAST@("previousOrdersFileEntry")=$G(PHPATARR(FNBR9,IENS9,4,"E"))
 . S @ULAST@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR5_U_$P(IENS9,C,2)_U_FNBR9_U_+IENS9)
 ;
 N IENS10 S IENS10=""
 F  S IENS10=$O(PHPATARR(FNBR10,IENS10)) QUIT:IENS10=""  D
 . N UINTR S UINTR=$NA(PHPAT("Phpat","unitDoses","unitDose",$P(IENS10,C,2),"interventions","intervention",+IENS10))
 . S @UINTR@("intervention")=$G(PHPATARR(FNBR10,IENS10,.01,"E"))
 . S @UINTR@("interventionId")=$G(PHPATARR(FNBR10,IENS10,.01,"I"))
 . S @UINTR@("interventionDateTime")=$G(PHPATARR(FNBR10,IENS10,1,"E"))
 . S @UINTR@("interventionDateTimeFM")=$G(PHPATARR(FNBR10,IENS10,1,"I"))
 . S @UINTR@("interventionDateTimeHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR10,IENS10,1,"I")))
 . S @UINTR@("interventionDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR10,IENS10,1,"I")))
 . S @UINTR@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR5_U_$P(IENS10,C,2)_U_FNBR10_U_+IENS10)
 ;
 QUIT
 ;
