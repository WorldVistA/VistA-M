SYNDHP18 ; HC/art - HealthConcourse - get care team data ;08/27/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 ;The authoratative source for VA care team data is PCMM Web. (currently no connection is available.)
 ; PCMM Web updates VistA files on a regular basis.
 ;
 QUIT
 ;
GET1TEAM(TEAM,TEAMIEN,RETJSON,TEAMJ) ;get one care team
 ;inputs: TEAMIEN - team IEN
 ;        RETJSON - J = Return JSON
 ;                  null or any other value = Return array (default)
 ;output: TEAM    - array of team data, by reference
 ;        TEAMJ   - JSON structure of team data, by reference
 ;
 N FNBR1 S FNBR1=404.51 ;TEAM
 N FNBR2 S FNBR2=404.58 ;TEAM HISTORY
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N IENS S IENS=TEAMIEN_","
 N TMARR,TMERR
 D GETS^DIQ(FNBR1,IENS,"**","EI","TMARR","TMERR")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TMARR")
 I $G(DEBUG),$D(TMERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("TMERR")
 I $D(TMERR) D  QUIT
 . S TEAM("Team","ERROR")=TEAMIEN
 . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.TEAM,.TEAMJ)
 S TEAM("Team","resourceType")="CareTeam"
 S TEAM("Team","resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,TEAMIEN)
 S TEAM("Team","teamName")=$G(TMARR(FNBR1,IENS,.01,"E"))
 S TEAM("Team","fhirTeamType")="longitudinal"
 S TEAM("Team","teamPhone")=$G(TMARR(FNBR1,IENS,.02,"E"))
 S TEAM("Team","teamPurposeId")=$G(TMARR(FNBR1,IENS,.03,"I"))
 S TEAM("Team","teamPurpose")=$G(TMARR(FNBR1,IENS,.03,"E"))
 S TEAM("Team","teamPrinterId")=$G(TMARR(FNBR1,IENS,.04,"I"))
 S TEAM("Team","teamPrinter")=$G(TMARR(FNBR1,IENS,.04,"E"))
 S TEAM("Team","canBePcCd")=$G(TMARR(FNBR1,IENS,.05,"I"))
 S TEAM("Team","canBePC")=$G(TMARR(FNBR1,IENS,.05,"E"))
 S TEAM("Team","serviceDeptId")=$G(TMARR(FNBR1,IENS,.06,"I"))
 S TEAM("Team","serviceDept")=$G(TMARR(FNBR1,IENS,.06,"E"))
 S TEAM("Team","institutionId")=$G(TMARR(FNBR1,IENS,.07,"I"))
 S TEAM("Team","institution")=$G(TMARR(FNBR1,IENS,.07,"E"))
 S TEAM("Team","maxPatients")=$G(TMARR(FNBR1,IENS,.08,"E"))
 S TEAM("Team","max%PCPatients")=$G(TMARR(FNBR1,IENS,.09,"E"))
 S TEAM("Team","closeToFutureAssignId")=$G(TMARR(FNBR1,IENS,.1,"I"))
 S TEAM("Team","closeToFutureAssign")=$G(TMARR(FNBR1,IENS,.1,"E"))
 S TEAM("Team","autoAssignId")=$G(TMARR(FNBR1,IENS,.11,"I"))
 S TEAM("Team","autoAssign")=$G(TMARR(FNBR1,IENS,.11,"E"))
 S TEAM("Team","autoDischargeId")=$G(TMARR(FNBR1,IENS,.12,"I"))
 S TEAM("Team","autoDischarge")=$G(TMARR(FNBR1,IENS,.12,"E"))
 S TEAM("Team","restrictConsultsId")=$G(TMARR(FNBR1,IENS,.13,"I"))
 S TEAM("Team","restrictConsults")=$G(TMARR(FNBR1,IENS,.13,"E"))
 S TEAM("Team","description")=$G(TMARR(FNBR1,IENS,50,1))_$G(TMARR(FNBR1,IENS,50,2)) ;<<<
 S TEAM("Team","current#PatientsC")=$G(TMARR(FNBR1,IENS,201,"E"))
 S TEAM("Team","currentStatusC")=$G(TMARR(FNBR1,IENS,202,"E"))
 S TEAM("Team","currentEffectiveDateC")=$G(TMARR(FNBR1,IENS,203,"E"))
 S TEAM("Team","currentEffectiveDateCFM")=$$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,203,"E")))
 S TEAM("Team","currentEffectiveDateCHL7")=$$FMTHL7^XLFDT($$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,203,"E"))))
 S TEAM("Team","currentEffectiveDateCFHIR")=$$FMTFHIR^SYNDHPUTL($$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,203,"E"))))
 S TEAM("Team","currentActivationDateC")=$G(TMARR(FNBR1,IENS,204,"E"))
 S TEAM("Team","currentActivationDateCFM")=$$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,204,"E")))
 S TEAM("Team","currentActivationDateCHL7")=$$FMTHL7^XLFDT($$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,204,"E"))))
 S TEAM("Team","currentActivationDateCFHIR")=$$FMTFHIR^SYNDHPUTL($$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,204,"E"))))
 S TEAM("Team","currentInactivationDateC")=$G(TMARR(FNBR1,IENS,205,"E"))
 S TEAM("Team","currentInactivationDateCFM")=$$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,205,"E")))
 S TEAM("Team","currentInactivationDateCHL7")=$$FMTHL7^XLFDT($$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,205,"E"))))
 S TEAM("Team","currentInactivationDateCFHIR")=$$FMTFHIR^SYNDHPUTL($$DATECNVT^SYNDHPUTL($G(TMARR(FNBR1,IENS,205,"E"))))
 ;
 N STATIEN S STATIEN=0
 F  S STATIEN=$O(^SCTM(FNBR2,"B",TEAMIEN,STATIEN)) QUIT:+STATIEN=0  D
 . N IENS2 S IENS2=STATIEN_","
 . N STATARR,STATERR
 . D GETS^DIQ(FNBR2,IENS2,"**","EI","STATARR","STATERR")
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("STATARR")
 . I $G(DEBUG),$D(STATERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("STATERR")
 . I $D(STATERR) D  QUIT
 . . S TEAM("Team","teamStatus","status",STATIEN,"ERROR")=STATIEN
 . . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.TEAM,.TEAMJ)
 . N TEAMSTAT S TEAMSTAT=$NA(TEAM("Team","teamStatus","status",STATIEN))
 . S @TEAMSTAT@("statusCd")=$G(STATARR(FNBR2,IENS2,.03,"I"))
 . S @TEAMSTAT@("status")=$G(STATARR(FNBR2,IENS2,.03,"E"))
 . S @TEAMSTAT@("effectiveDate")=$G(STATARR(FNBR2,IENS2,.02,"E"))
 . S @TEAMSTAT@("effectiveDateFM")=$G(STATARR(FNBR2,IENS2,.02,"I"))
 . S @TEAMSTAT@("effectiveDateHL7")=$$FMTHL7^XLFDT($G(STATARR(FNBR2,IENS2,.02,"I")))
 . S @TEAMSTAT@("effectiveDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(STATARR(FNBR2,IENS2,.02,"I")))
 . S @TEAMSTAT@("statusReasonId")=$G(STATARR(FNBR2,IENS2,.04,"I"))
 . S @TEAMSTAT@("statusReason")=$G(STATARR(FNBR2,IENS2,.04,"E"))
 . S @TEAMSTAT@("statusRecordId")=$$RESID^SYNDHP69("V",SITE,FNBR2,STATIEN)
 ;
 N POSITION
 D TEAMPOS(.POSITION,TEAMIEN,0)
 M TEAM("Team","positions")=POSITION
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TEAM")
 ;
 I $G(RETJSON)="J" D
 . N TEAMS M TEAMS("Teams",TEAMIEN)=TEAM
 . D TOJASON^SYNDHPUTL(.TEAMS,.TEAMJ)
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TEAM")
 ;
 QUIT
 ;
TEAMPOS(POSITION,TEAMIEN,RETJSON,POSITIONJ) ;get team positions
 ;inputs: TEAMIEN - team IEN
 ;        RETJSON - J = Return JSON
 ;                  null or any other value = Return array (default)
 ;Output: POSITION - an array of position data, by reference
 ;        POSITIONJ - JSON structure, by reference
 ;
 N FNBR1 S FNBR1=404.57 ;TEAM POSITION
 N FNBR2 S FNBR2=404.575 ;TEAM POSITION:ASSOCIATED CLINICS
 N FNBR3 S FNBR3=404.59 ;TEAM POSITION HISTORY
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N POSIEN S POSIEN=0
 F  S POSIEN=$O(^SCTM(FNBR1,"C",TEAMIEN,POSIEN)) QUIT:+POSIEN=0  D
 . N IENS S IENS=POSIEN_","
 . N POSARR,POSERR
 . D GETS^DIQ(FNBR1,IENS,"**","EI","POSARR","POSERR")
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("POSARR")
 . I $G(DEBUG),$D(POSERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("POSERR")
 . I $D(POSERR) D  QUIT
 . . S POSITION("position",POSIEN,"ERROR")=POSIEN
 . . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.POSITION,.POSITIONJ)
 . N TEAMPOS S TEAMPOS=$NA(POSITION("position",POSIEN))
 . S @TEAMPOS@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,POSIEN)
 . S @TEAMPOS@("positionIen")=POSIEN
 . S @TEAMPOS@("positionName")=$G(POSARR(FNBR1,IENS,.01,"E"))
 . S @TEAMPOS@("teamId")=$G(POSARR(FNBR1,IENS,.02,"I"))
 . S @TEAMPOS@("team")=$G(POSARR(FNBR1,IENS,.02,"E"))
 . S @TEAMPOS@("standRoleNameId")=$G(POSARR(FNBR1,IENS,.03,"I"))
 . S @TEAMPOS@("standRoleName")=$G(POSARR(FNBR1,IENS,.03,"E"))
 . N SCT S SCT=$$MAP^SYNDHPMP("ctpos2sct",@TEAMPOS@("standRoleName"),"D")
 . S @TEAMPOS@("standRoleSct")=$S(+SCT=-1:"",1:$P(SCT,U,2))
 . S @TEAMPOS@("possPrimPractId")=$G(POSARR(FNBR1,IENS,.04,"I"))
 . S @TEAMPOS@("possPrimPract")=$G(POSARR(FNBR1,IENS,.04,"E"))
 . S @TEAMPOS@("max#patients")=$G(POSARR(FNBR1,IENS,.08,"E"))
 . ;S @TEAMPOS@("NAassocClinic")=$G(POSARR(FNBR1,IENS,.09,"E")) ;field is no longer used
 . S @TEAMPOS@("beeperNbr")=$G(POSARR(FNBR1,IENS,.11,"E"))
 . S @TEAMPOS@("canBePreceptor")=$G(POSARR(FNBR1,IENS,.12,"E"))
 . S @TEAMPOS@("userClass")=$G(POSARR(FNBR1,IENS,.13,"E"))
 . S @TEAMPOS@("description")=""
 . N Z S Z=""
 . F  S Z=$O(POSARR(FNBR1,IENS,1,Z)) QUIT:'+Z  D
 . . S @TEAMPOS@("description")=@TEAMPOS@("description")_$G(POSARR(FNBR1,IENS,1,Z))_" "
 . S @TEAMPOS@("deathMsg")=$G(POSARR(FNBR1,IENS,2.01,"E"))
 . S @TEAMPOS@("inpatientMsg")=$G(POSARR(FNBR1,IENS,2.02,"E"))
 . S @TEAMPOS@("teamMsg")=$G(POSARR(FNBR1,IENS,2.03,"E"))
 . S @TEAMPOS@("consultMsg")=$G(POSARR(FNBR1,IENS,2.04,"E"))
 . S @TEAMPOS@("precepDeathMsg")=$G(POSARR(FNBR1,IENS,2.05,"E"))
 . S @TEAMPOS@("precepInpatientMsg")=$G(POSARR(FNBR1,IENS,2.06,"E"))
 . S @TEAMPOS@("precepTeamMsg")=$G(POSARR(FNBR1,IENS,2.07,"E"))
 . S @TEAMPOS@("precepConsultMsg")=$G(POSARR(FNBR1,IENS,2.08,"E"))
 . S @TEAMPOS@("autoInactMsg")=$G(POSARR(FNBR1,IENS,2.09,"E"))
 . S @TEAMPOS@("precepInactMsg")=$G(POSARR(FNBR1,IENS,2.1,"E"))
 . S @TEAMPOS@("curr#PCpatsC")=$G(POSARR(FNBR1,IENS,200,"E"))
 . S @TEAMPOS@("curr#PatientsC")=$G(POSARR(FNBR1,IENS,201,"E"))
 . S @TEAMPOS@("future#PCpatsC")=$G(POSARR(FNBR1,IENS,202,"E"))
 . S @TEAMPOS@("future#PatientsC")=$G(POSARR(FNBR1,IENS,203,"E"))
 . S @TEAMPOS@("currStatusC")=$G(POSARR(FNBR1,IENS,300,"E"))
 . S @TEAMPOS@("currEffectDateC")=$G(POSARR(FNBR1,IENS,301,"E"))
 . S @TEAMPOS@("currEffectDateCFM")=$$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,301,"E")))
 . S @TEAMPOS@("currEffectDateCHL7")=$$FMTHL7^XLFDT($$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,301,"E"))))
 . S @TEAMPOS@("currEffectDateCFHIR")=$$FMTFHIR^SYNDHPUTL($$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,301,"E"))))
 . S @TEAMPOS@("currActDateC")=$G(POSARR(FNBR1,IENS,302,"E"))
 . S @TEAMPOS@("currActDateCFM")=$$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,302,"E")))
 . S @TEAMPOS@("currActDateCHL7")=$$FMTHL7^XLFDT($$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,302,"E"))))
 . S @TEAMPOS@("currActDateCFHIR")=$$FMTFHIR^SYNDHPUTL($$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,302,"E"))))
 . S @TEAMPOS@("currInactDateC")=$G(POSARR(FNBR1,IENS,303,"E"))
 . S @TEAMPOS@("currInactDateCFM")=$$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,303,"E")))
 . S @TEAMPOS@("currInactDateCHL7")=$$FMTHL7^XLFDT($$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,303,"E"))))
 . S @TEAMPOS@("currInactDateFHIR")=$$FMTFHIR^SYNDHPUTL($$DATECNVT^SYNDHPUTL($G(POSARR(FNBR1,IENS,303,"E"))))
 . S @TEAMPOS@("currPractitionerC")=$G(POSARR(FNBR1,IENS,304,"E"))
 . S @TEAMPOS@("currPrecptorPosC")=$G(POSARR(FNBR1,IENS,305,"E"))
 . S @TEAMPOS@("currPreceptorC")=$G(POSARR(FNBR1,IENS,306,"E"))
 . S @TEAMPOS@("activePreceptsC")=$G(POSARR(FNBR1,IENS,307,"E"))
 . S @TEAMPOS@("allowPreceptedChngC")=$G(POSARR(FNBR1,IENS,400,"E"))
 . S @TEAMPOS@("allowPreceptorChngC")=$G(POSARR(FNBR1,IENS,401,"E"))
 . S @TEAMPOS@("inconsistentReasonC")=$G(POSARR(FNBR1,IENS,402,"E"))
 . ;
 . ;position assignment history
 . N ASGNHIST,ASGNHISTJ
 . ;D ASGNHIST^SYNDHP19(.ASGNHIST,TEAMIEN,0)
 . D ASGNHIST^SYNDHP19(.ASGNHIST,POSIEN,0)
 . M POSITION("position",POSIEN,"positionAssignmentHistory")=ASGNHIST
 . ;
 . ;preceptor assignment history
 . N PRECHIST,PRECHISTJ
 . D PRECHIST^SYNDHP19(.PRECHIST,POSIEN,0)
 . M POSITION("position",POSIEN,"preceptorAssignmentHistory")=PRECHIST
 . ;
 . N IENS2 S IENS2=""
 . F  S IENS2=$O(POSARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . . N TEAMCLIN S TEAMCLIN=$NA(POSITION("position",POSIEN,"associatedClinics","clinic",+IENS2))
 . . S @TEAMCLIN@("assocClincId")=$G(POSARR(FNBR2,IENS2,.01,"I"))
 . . S @TEAMCLIN@("assocClinc")=$G(POSARR(FNBR2,IENS2,.01,"E"))
 . . S @TEAMCLIN@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,POSIEN,FNBR2_U_+IENS2)
 . ;team position history
 . N STATIEN S STATIEN=0
 . F  S STATIEN=$O(^SCTM(FNBR3,"B",POSIEN,STATIEN)) QUIT:+STATIEN=0  D
 . . N IENS3 S IENS3=STATIEN_","
 . . N STATARR,STATERR
 . . D GETS^DIQ(FNBR3,IENS3,"**","EI","STATARR","STATERR")
 . . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("STATARR")
 . . I $G(DEBUG),$D(STATERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("STATERR")
 . . I $D(STATERR) S POSITION("position",POSIEN,"positionStatus","status",STATIEN,"ERROR")=STATIEN QUIT
 . . N POSSTAT S POSSTAT=$NA(POSITION("position",POSIEN,"positionStatus","status",STATIEN))
 . . S @POSSTAT@("statusCd")=$G(STATARR(FNBR3,IENS3,.03,"I"))
 . . S @POSSTAT@("status")=$G(STATARR(FNBR3,IENS3,.03,"E"))
 . . S @POSSTAT@("effectiveDate")=$G(STATARR(FNBR3,IENS3,.02,"E"))
 . . S @POSSTAT@("effectiveDateFM")=$G(STATARR(FNBR3,IENS3,.02,"I"))
 . . S @POSSTAT@("effectiveDateHL7")=$$FMTHL7^XLFDT($G(STATARR(FNBR3,IENS3,.02,"I")))
 . . S @POSSTAT@("effectiveDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(STATARR(FNBR3,IENS3,.02,"I")))
 . . S @POSSTAT@("statusReasonId")=$G(STATARR(FNBR3,IENS3,.04,"I"))
 . . S @POSSTAT@("statusReason")=$G(STATARR(FNBR3,IENS3,.04,"E"))
 . . S @POSSTAT@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR3,STATIEN)
 . . ;
 . . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("POSITION")
 ;
 I $G(RETJSON)="J" D
 . N POSITIONS M POSITIONS("TeamPositions")=POSITION
 . D TOJASON^SYNDHPUTL(.POSITIONS,.POSITIONJ)
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("POSITIONSJ")
 ;
 QUIT
 ;
