SYNDHP30D ; HC/art - HealthConcourse - continuation of get Pharmacy Patient data ;08/29/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
PHCONT4 ;
 ;
 N IENS14 S IENS14=""
 F  S IENS14=$O(PHPATARR(FNBR14,IENS14)) QUIT:IENS14=""  D
 . N IACTLOG S IACTLOG=$NA(PHPAT("Phpat","ivs","iv",$P(IENS14,C,2),"activityLogs","activityLog",+IENS14))
 . S @IACTLOG@("activityLog")=$G(PHPATARR(FNBR14,IENS14,.01,"E"))
 . S @IACTLOG@("typeOfActivity")=$G(PHPATARR(FNBR14,IENS14,.02,"E"))
 . S @IACTLOG@("typeOfActivityCd")=$G(PHPATARR(FNBR14,IENS14,.02,"I"))
 . S @IACTLOG@("entryCode")=$G(PHPATARR(FNBR14,IENS14,.03,"E"))
 . S @IACTLOG@("reasonForActivity")=$G(PHPATARR(FNBR14,IENS14,.04,"E"))
 . S @IACTLOG@("activityDate")=$G(PHPATARR(FNBR14,IENS14,.05,"E"))
 . S @IACTLOG@("activityDateFM")=$G(PHPATARR(FNBR14,IENS14,.05,"I"))
 . S @IACTLOG@("activityDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR14,IENS14,.05,"I")))
 . S @IACTLOG@("activityDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR14,IENS14,.05,"I")))
 . S @IACTLOG@("user")=$G(PHPATARR(FNBR14,IENS14,.06,"E"))
 . S @IACTLOG@("userId")=$G(PHPATARR(FNBR14,IENS14,.06,"I"))
 . S @IACTLOG@("fieldChanged")=$G(PHPATARR(FNBR14,IENS14,1,"E"))
 . S @IACTLOG@("otherPrintInfoOldValue")=""
 . N Z S Z=""
 . F  S Z=$O(PHPATARR(FNBR14,IENS14,2,Z)) QUIT:'+Z  D
 . . S @IACTLOG@("otherPrintInfoOldValue")=@IACTLOG@("otherPrintInfoOldValue")_$G(PHPATARR(FNBR14,IENS14,2,Z))
 . S @IACTLOG@("otherPrintInfoNewValue")=""
 . N Z S Z=""
 . F  S Z=$O(PHPATARR(FNBR14,IENS14,3,Z)) QUIT:'+Z  D
 . . S @IACTLOG@("otherPrintInfoNewValue")=@IACTLOG@("otherPrintInfoNewValue")_$G(PHPATARR(FNBR14,IENS14,3,Z))
 . S @IACTLOG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR11_U_$P(IENS14,C,2)_U_FNBR14_U_+IENS14)
 ;
 N IENS16 S IENS16=""
 F  S IENS16=$O(PHPATARR(FNBR16,IENS16)) QUIT:IENS16=""  D
 . N FLDCHG S FLDCHG=$NA(PHPAT("Phpat","ivs","iv",$P(IENS16,C,3),"activityLogs","activityLog",$P(IENS16,C,2),"fieldChangeds","fieldChanged",+IENS16))
 . S @FLDCHG@("fieldChanged")=$G(PHPATARR(FNBR16,IENS16,.01,"E"))
 . S @FLDCHG@("from")=$G(PHPATARR(FNBR16,IENS16,1,"E"))
 . S @FLDCHG@("to")=$G(PHPATARR(FNBR16,IENS16,2,"E"))
 . S @FLDCHG@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR11_U_$P(IENS16,C,3)_U_FNBR14_U_$P(IENS16,C,2)_U_FNBR16_U_+IENS16)
 ;
 N IENS17 S IENS17=""
 F  S IENS17=$O(PHPATARR(FNBR17,IENS17)) QUIT:IENS17=""  D
 . N ILABEL S ILABEL=$NA(PHPAT("Phpat","ivs","iv",$P(IENS17,C,2),"labelTrackings","labelTracking",+IENS17))
 . S @ILABEL@("labelTracking")=$G(PHPATARR(FNBR17,IENS17,.01,"E"))
 . S @ILABEL@("date")=$G(PHPATARR(FNBR17,IENS17,1,"E"))
 . S @ILABEL@("dateFM")=$G(PHPATARR(FNBR17,IENS17,1,"I"))
 . S @ILABEL@("dateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR17,IENS17,1,"I")))
 . S @ILABEL@("dateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR17,IENS17,1,"I")))
 . S @ILABEL@("action")=$G(PHPATARR(FNBR17,IENS17,2,"E"))
 . S @ILABEL@("actionCd")=$G(PHPATARR(FNBR17,IENS17,2,"I"))
 . S @ILABEL@("user")=$G(PHPATARR(FNBR17,IENS17,3,"E"))
 . S @ILABEL@("labels")=$G(PHPATARR(FNBR17,IENS17,4,"E"))
 . S @ILABEL@("track")=$G(PHPATARR(FNBR17,IENS17,5,"E"))
 . S @ILABEL@("trackCd")=$G(PHPATARR(FNBR17,IENS17,5,"I"))
 . S @ILABEL@("dailyUsage")=$G(PHPATARR(FNBR17,IENS17,6,"E"))
 . S @ILABEL@("dailyUsageCd")=$G(PHPATARR(FNBR17,IENS17,6,"I"))
 . S @ILABEL@("error")=$G(PHPATARR(FNBR17,IENS17,7,"E"))
 . S @ILABEL@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR11_U_$P(IENS17,C,2)_U_FNBR17_U_+IENS17)
 ;
 N IENS18 S IENS18=""
 F  S IENS18=$O(PHPATARR(FNBR18,IENS18)) QUIT:IENS18=""  D
 . N ILAST S ILAST=$NA(PHPAT("Phpat","ivs","iv",$P(IENS18,C,2),"lastRenews","lastRenew",+IENS18))
 . S @ILAST@("lastRenew")=$G(PHPATARR(FNBR18,IENS18,.01,"E"))
 . S @ILAST@("lastRenewFM")=$G(PHPATARR(FNBR18,IENS18,.01,"I"))
 . S @ILAST@("lastRenewHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR18,IENS18,.01,"I")))
 . S @ILAST@("lastRenewFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR18,IENS18,.01,"I")))
 . S @ILAST@("renewedBy")=$G(PHPATARR(FNBR18,IENS18,1,"E"))
 . S @ILAST@("renewedById")=$G(PHPATARR(FNBR18,IENS18,1,"I"))
 . S @ILAST@("renewedByNPI")=$$GET1^DIQ(200,@ILAST@("renewedById")_",",41.99) ;NPI
 . S @ILAST@("renewedByResId")=$$RESID^SYNDHP69("V",SITE,200,@ILAST@("renewedById"))
 . S @ILAST@("previousProvider")=$G(PHPATARR(FNBR18,IENS18,2,"E"))
 . S @ILAST@("previousProviderId")=$G(PHPATARR(FNBR18,IENS18,2,"I"))
 . S @ILAST@("previousProviderNPI")=$$GET1^DIQ(200,@ILAST@("previousProviderId")_",",41.99) ;NPI
 . S @ILAST@("previousStopDateTime")=$G(PHPATARR(FNBR18,IENS18,3,"E"))
 . S @ILAST@("previousStopDateTimeFM")=$G(PHPATARR(FNBR18,IENS18,3,"I"))
 . S @ILAST@("previousStopDateTimeHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR18,IENS18,3,"I")))
 . S @ILAST@("previousStopDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR18,IENS18,3,"I")))
 . S @ILAST@("previousOrdersFileEntry")=$G(PHPATARR(FNBR18,IENS18,4,"E"))
 . S @ILAST@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR11_U_$P(IENS18,C,2)_U_FNBR18_U_+IENS18)
 ;
 N IENS19 S IENS19=""
 F  S IENS19=$O(PHPATARR(FNBR19,IENS19)) QUIT:IENS19=""  D
 . N IINTR S IINTR=$NA(PHPAT("Phpat","ivs","iv",$P(IENS19,C,2),"interventions","intervention",+IENS19))
 . S @IINTR@("intervention")=$G(PHPATARR(FNBR19,IENS19,.01,"E"))
 . S @IINTR@("interventionId")=$G(PHPATARR(FNBR19,IENS19,.01,"I"))
 . S @IINTR@("interventionDateTime")=$G(PHPATARR(FNBR19,IENS19,1,"E"))
 . S @IINTR@("interventionDateTimeFM")=$G(PHPATARR(FNBR19,IENS19,1,"I"))
 . S @IINTR@("interventionDateTimeHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR19,IENS19,1,"I")))
 . S @IINTR@("interventionDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR19,IENS19,1,"I")))
 . S @IINTR@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR11_U_$P(IENS19,C,2)_U_FNBR19_U_+IENS19)
 ;
 N IENS20 S IENS20=""
 F  S IENS20=$O(PHPATARR(FNBR20,IENS20)) QUIT:IENS20=""  D
 . N ARCHDT S ARCHDT=$NA(PHPAT("Phpat","archiveDates","archiveDate",+IENS20))
 . S @ARCHDT@("archiveDate")=$G(PHPATARR(FNBR20,IENS20,.01,"E"))
 . S @ARCHDT@("archiveDateFM")=$G(PHPATARR(FNBR20,IENS20,.01,"I"))
 . S @ARCHDT@("archiveDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR20,IENS20,.01,"I")))
 . S @ARCHDT@("archiveDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR20,IENS20,.01,"I")))
 . S @ARCHDT@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR20_U_+IENS20)
 ;
 N IENS21 S IENS21=""
 F  S IENS21=$O(PHPATARR(FNBR21,IENS21)) QUIT:IENS21=""  D
 . N RXLIST S RXLIST=$NA(PHPAT("Phpat","archiveDates","archiveDate",$P(IENS21,C,2),"rxLists","rxList",+IENS21))
 . S @RXLIST@("rxList")=$G(PHPATARR(FNBR21,IENS21,.01,"E"))
 . S @RXLIST@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR20_U_$P(IENS21,C,2)_U_FNBR21_U_+IENS21)
 ;
 N IENS22 S IENS22=""
 F  S IENS22=$O(PHPATARR(FNBR22,IENS22)) QUIT:IENS22=""  D
 . N BCMA S BCMA=$NA(PHPAT("Phpat","bcmaIds","bcmaId",+IENS22))
 . S @BCMA@("bcmaId")=$G(PHPATARR(FNBR22,IENS22,.01,"E"))
 . S @BCMA@("on")=$G(PHPATARR(FNBR22,IENS22,.02,"E"))
 . S @BCMA@("bcmaStatusDateTime")=$G(PHPATARR(FNBR22,IENS22,1,"E"))
 . S @BCMA@("bcmaStatusDateTimeFM")=$G(PHPATARR(FNBR22,IENS22,1,"I"))
 . S @BCMA@("bcmaStatusDateTimeHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR22,IENS22,1,"I")))
 . S @BCMA@("bcmaStatusDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR22,IENS22,1,"I")))
 . S @BCMA@("bcmaStatus")=$G(PHPATARR(FNBR22,IENS22,2,"E"))
 . S @BCMA@("bcmaStatusCd")=$G(PHPATARR(FNBR22,IENS22,2,"I"))
 . S @BCMA@("usageCount")=$G(PHPATARR(FNBR22,IENS22,3,"E"))
 . S @BCMA@("usageCountCd")=$G(PHPATARR(FNBR22,IENS22,3,"I"))
 . S @BCMA@("labelDate")=$G(PHPATARR(FNBR22,IENS22,4,"E"))
 . S @BCMA@("labelDateFM")=$G(PHPATARR(FNBR22,IENS22,4,"I"))
 . S @BCMA@("labelDateHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR22,IENS22,4,"I")))
 . S @BCMA@("labelDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR22,IENS22,4,"I")))
 . S @BCMA@("labelStatus")=$G(PHPATARR(FNBR22,IENS22,5,"E"))
 . S @BCMA@("labelStatusCd")=$G(PHPATARR(FNBR22,IENS22,5,"I"))
 . S @BCMA@("bag")=$G(PHPATARR(FNBR22,IENS22,6,"E"))
 . S @BCMA@("invalidDateTime")=$G(PHPATARR(FNBR22,IENS22,9,"E"))
 . S @BCMA@("invalidDateTimeFM")=$G(PHPATARR(FNBR22,IENS22,9,"I"))
 . S @BCMA@("invalidDateTimeHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR22,IENS22,9,"I")))
 . S @BCMA@("invalidDateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR22,IENS22,9,"I")))
 . S @BCMA@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR22_U_+IENS22)
 ;
 N IENS23 S IENS23=""
 F  S IENS23=$O(PHPATARR(FNBR23,IENS23)) QUIT:IENS23=""  D
 . N BADD S BADD=$NA(PHPAT("Phpat","bcmaIds","bcmaId",$P(IENS23,C,2),"additives","additive",+IENS23))
 . S @BADD@("additive")=$G(PHPATARR(FNBR23,IENS23,.01,"E"))
 . S @BADD@("additiveId")=$G(PHPATARR(FNBR23,IENS23,.01,"I"))
 . S @BADD@("additiveGenericName")=$$GET1^DIQ(52.6,@BADD@("additiveId")_",",1)
 . S @BADD@("additiveGenericNameId")=$$GET1^DIQ(52.6,@BADD@("additiveId")_",",1,"I")
 . S @BADD@("additiveRxNorm")=$$GETRXN^SYNDHPUTL(@BADD@("additiveGenericNameId"))
 . S @BADD@("strength")=$G(PHPATARR(FNBR23,IENS23,1,"E"))
 . S @BADD@("bottle")=$G(PHPATARR(FNBR23,IENS23,2,"E"))
 . S @BADD@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR22_U_$P(IENS23,C,2)_U_FNBR23_U_+IENS23)
 ;
 N IENS24 S IENS24=""
 F  S IENS24=$O(PHPATARR(FNBR24,IENS24)) QUIT:IENS24=""  D
 . N BSOL S BSOL=$NA(PHPAT("Phpat","bcmaIds","bcmaId",$P(IENS24,C,2),"solutions","solution",+IENS24))
 . S @BSOL@("solution")=$G(PHPATARR(FNBR24,IENS24,.01,"E"))
 . S @BSOL@("solutionId")=$G(PHPATARR(FNBR24,IENS24,.01,"I"))
 . S @BSOL@("solutionGenericName")=$$GET1^DIQ(52.7,@BSOL@("solutionId")_",",1)
 . S @BSOL@("solutionGenericNameId")=$$GET1^DIQ(52.7,@BSOL@("solutionId")_",",1,"I")
 . S @BSOL@("solutionRxNorm")=$$GETRXN^SYNDHPUTL(@BSOL@("solutionGenericNameId"))
 . S @BSOL@("volume")=$G(PHPATARR(FNBR24,IENS24,1,"E"))
 . S @BSOL@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR22_U_$P(IENS24,C,2)_U_FNBR24_U_+IENS24)
 ;
 N IENS25 S IENS25=""
 F  S IENS25=$O(PHPATARR(FNBR25,IENS25)) QUIT:IENS25=""  D
 . N TALK S TALK=$NA(PHPAT("Phpat","scriptalkEnrollmentActivitys","scriptalkEnrollmentActivity",+IENS25))
 . S @TALK@("scriptalkEnrollmentActivity")=$G(PHPATARR(FNBR25,IENS25,.01,"E"))
 . S @TALK@("scriptalkEnrollmentActivityFM")=$G(PHPATARR(FNBR25,IENS25,.01,"I"))
 . S @TALK@("scriptalkEnrollmentActivityHL7")=$$FMTHL7^XLFDT($G(PHPATARR(FNBR25,IENS25,.01,"I")))
 . S @TALK@("scriptalkEnrollmentActivityFHIR")=$$FMTFHIR^SYNDHPUTL($G(PHPATARR(FNBR25,IENS25,.01,"I")))
 . S @TALK@("scriptalkPatient")=$G(PHPATARR(FNBR25,IENS25,1,"E"))
 . S @TALK@("scriptalkPatientCd")=$G(PHPATARR(FNBR25,IENS25,1,"I"))
 . S @TALK@("indication")=$G(PHPATARR(FNBR25,IENS25,2,"E"))
 . S @TALK@("indicationCd")=$G(PHPATARR(FNBR25,IENS25,2,"I"))
 . S @TALK@("user")=$G(PHPATARR(FNBR25,IENS25,3,"E"))
 . S @TALK@("userId")=$G(PHPATARR(FNBR25,IENS25,3,"I"))
 . S @TALK@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PHPATIEN,FNBR25_U_+IENS25)
 ;
 QUIT
 ;
