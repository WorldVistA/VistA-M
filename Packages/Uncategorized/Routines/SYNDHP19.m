SYNDHP19 ; HC/art - HealthConcourse - get care team data ;08/27/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 ;The authoratative source for care team data is PCMM Web. (currently no connection is available.)
 ; PCMM Web updates VistA files on a regular basis.
 ;
 QUIT
 ;
ASGNHIST(ASGNHIST,POSIEN,RETJSON,ASGNHISTJ) ;get team position assignment history
 ;inputs: POSIEN - team position IEN
 ;        RETJSON - J = Return JSON
 ;                  null or any other value = Return array (default)
 ;Output: ASGNHIST - an array of position assignment history data, by reference
 ;        ASGNHISTJ - JSON structure, by reference
 ;
 N FNBR1 S FNBR1=404.52 ;POSITION ASSIGNMENT HISTORY
 N FNBR2 S FNBR2=404.521 ;POSITION ASSIGNMENT HISTORY:FTEE HISTORY
 N S S S="_"
 N C S C=","
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N HISTIEN S HISTIEN=0
 F  S HISTIEN=$O(^SCTM(FNBR1,"B",POSIEN,HISTIEN)) QUIT:+HISTIEN=0  D
 . N IENS S IENS=HISTIEN_","
 . N HISTARR,HISTERR
 . D GETS^DIQ(FNBR1,IENS,"**","EI","HISTARR","HISTERR")
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("HISTARR")
 . I $G(DEBUG),$D(HISTERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("HISTERR")
 . I $D(HISTERR) D  QUIT
 . . S ASGNHIST("posAssignHist",HISTIEN,"ERROR")=HISTIEN
 . . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.ASGNHIST,.ASGNHISTJ)
 . N AHIST S AHIST=$NA(ASGNHIST("posAssignHist",HISTIEN))
 . S @AHIST@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,HISTIEN)
 . S @AHIST@("assignHistIen")=HISTIEN
 . S @AHIST@("teamPositionId")=$G(HISTARR(FNBR1,IENS,.01,"I"))
 . S @AHIST@("teamPositionName")=$G(HISTARR(FNBR1,IENS,.01,"E"))
 . S @AHIST@("effectiveDate")=$G(HISTARR(FNBR1,IENS,.02,"E"))
 . S @AHIST@("effectiveDateFM")=$G(HISTARR(FNBR1,IENS,.02,"I"))
 . S @AHIST@("effectiveDateHL7")=$$FMTHL7^XLFDT($G(HISTARR(FNBR1,IENS,.02,"I")))
 . S @AHIST@("effectiveDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(HISTARR(FNBR1,IENS,.02,"I")))
 . S @AHIST@("practitionerId")=$G(HISTARR(FNBR1,IENS,.03,"I"))
 . S @AHIST@("practitioner")=$G(HISTARR(FNBR1,IENS,.03,"E"))
 . S @AHIST@("practitionerNPI")=$$GET1^DIQ(200,@AHIST@("practitionerId")_",",41.99) ;NPI
 . S @AHIST@("practitionerResId")=$$RESID^SYNDHP69("V",SITE,200,@AHIST@("practitionerId"))
 . S @AHIST@("statusCd")=$G(HISTARR(FNBR1,IENS,.04,"I"))
 . S @AHIST@("status")=$G(HISTARR(FNBR1,IENS,.04,"E"))
 . S @AHIST@("statusReasonId")=$G(HISTARR(FNBR1,IENS,.05,"I"))
 . S @AHIST@("statusReason")=$G(HISTARR(FNBR1,IENS,.05,"E"))
 . S @AHIST@("userEnteringId")=$G(HISTARR(FNBR1,IENS,.07,"I"))
 . S @AHIST@("userEntering")=$G(HISTARR(FNBR1,IENS,.07,"E"))
 . S @AHIST@("dateTimeEntered")=$G(HISTARR(FNBR1,IENS,.08,"E"))
 . S @AHIST@("dateTimeEnteredFM")=$G(HISTARR(FNBR1,IENS,.08,"I"))
 . S @AHIST@("dateTimeEnteredHL7")=$$FMTHL7^XLFDT($G(HISTARR(FNBR1,IENS,.08,"I")))
 . S @AHIST@("dateTimeEnteredFHIR")=$$FMTFHIR^SYNDHPUTL($G(HISTARR(FNBR1,IENS,.08,"I")))
 . S @AHIST@("fteeEquivalent")=$G(HISTARR(FNBR1,IENS,.09,"E"))
 . S @AHIST@("dateFlagedInactivation")=$G(HISTARR(FNBR1,IENS,.091,"E"))
 . S @AHIST@("dateFlagedInactivationFM")=$G(HISTARR(FNBR1,IENS,.091,"I"))
 . S @AHIST@("dateFlagedInactivationHL7")=$$FMTHL7^XLFDT($G(HISTARR(FNBR1,IENS,.091,"I")))
 . S @AHIST@("dateFlagedInactivationFHIR")=$$FMTFHIR^SYNDHPUTL($G(HISTARR(FNBR1,IENS,.091,"I")))
 . S @AHIST@("availablePositionsC")=$G(HISTARR(FNBR1,IENS,.096,"E"))
 . S @AHIST@("max#PatientsC")=$G(HISTARR(FNBR1,IENS,.097,"E"))
 . S @AHIST@("currActivePatientsC")=$G(HISTARR(FNBR1,IENS,.098,"E"))
 . S @AHIST@("adjustedPanelSizeC")=$G(HISTARR(FNBR1,IENS,.099,"E"))
 . S @AHIST@("inactivatedAutomaticlyCd")=$G(HISTARR(FNBR1,IENS,.011,"I"))
 . S @AHIST@("inactivatedAutomaticly")=$G(HISTARR(FNBR1,IENS,.011,"E"))
 . S @AHIST@("teamletPositionCd")=$G(HISTARR(FNBR1,IENS,.012,"I"))
 . S @AHIST@("teamletPosition")=$G(HISTARR(FNBR1,IENS,.012,"E"))
 . ;
 . N FTEE S FTEE=""
 . F  S FTEE=$O(HISTARR(FNBR2,FTEE)) QUIT:FTEE=""  D
 . . N FTEEHIST S FTEEHIST=$NA(ASGNHIST("posAssignHist",HISTIEN,"fteeHistory","fteeHist",+FTEE))
 . . S @FTEEHIST@("fteeHistoryDate")=$G(HISTARR(FNBR2,FTEE,.01,"E"))
 . . S @FTEEHIST@("fteeHistoryDateFM")=$G(HISTARR(FNBR2,FTEE,.01,"I"))
 . . S @FTEEHIST@("fteeHistoryDateHL7")=$$FMTHL7^XLFDT($G(HISTARR(FNBR2,FTEE,.01,"I")))
 . . S @FTEEHIST@("fteeHistoryDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(HISTARR(FNBR2,FTEE,.01,"I")))
 . . S @FTEEHIST@("value")=$G(HISTARR(FNBR2,FTEE,.02,"I"))
 . . S @FTEEHIST@("userId")=$G(HISTARR(FNBR2,FTEE,.03,"I"))
 . . S @FTEEHIST@("user")=$G(HISTARR(FNBR2,FTEE,.03,"E"))
 . . S @FTEEHIST@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,HISTIEN,FNBR2_U_+FTEE)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("ASGNHIST")
 ;
 I $G(RETJSON)="J" D
 . ;N ASGNHISTS M ASGNHISTS("TeamPositionAssignmentHistory")=ASGNHIST
 . D TOJASON^SYNDHPUTL(.ASGNHIST,.ASGNHISTJ)
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("ASGNHISTJ")
 ;
 QUIT
 ;
PRECHIST(PRECHIST,POSIEN,RETJSON,PRECHISTJ) ;get preceptor assignment history
 ;inputs: POSIEN - team position IEN
 ;        RETJSON - J = Return JSON
 ;                  null or any other value = Return array (default)
 ;Output: PRECHIST - an array of preceptor history data, by reference
 ;        PRECHISTJ - JSON structure, by reference
 ;
 ;   >>>>>>>>>>>>>>>>>>>>>> UNTESTED, NO DATA IN OUR VISTA <<<<<<<<<<<<<<<<<<<<<<<<<<<<
 ;
 N FNBR1 S FNBR1=404.53 ;PRECEPTOR ASSIGNMENT HISTORY
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N PRECIEN S PRECIEN=0
 F  S PRECIEN=$O(^SCTM(FNBR1,"B",POSIEN,PRECIEN)) QUIT:+PRECIEN=0  D
 . N IENS S IENS=PRECIEN_","
 . N HISTARR,HISTERR
 . D GETS^DIQ(FNBR1,IENS,"**","EI","HISTARR","HISTERR")
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("HISTARR")
 . I $G(DEBUG),$D(HISTERR) W !,">>ERROR<<" W $$ZW^SYNDHPUTL("HISTERR")
 . I $D(HISTERR) D  QUIT
 . . S PRECHIST("preceptorAssignHist",PRECIEN,"ERROR")=PRECIEN
 . . D:$G(RETJSON)="J" TOJASON^SYNDHPUTL(.PRECHIST,.PRECHISTJ)
 . N PHIST S PHIST=$NA(PRECHIST("preceptorAssignHist",PRECIEN))
 . S @PHIST@("resourceId")=$$RESID^SYNDHP69("V",SITE,FNBR1,PRECIEN)
 . S @PHIST@("preceptorHistoryIen")=PRECIEN
 . S @PHIST@("teamPositionId")=$G(HISTARR(FNBR1,IENS,.01,"I"))
 . S @PHIST@("teamPositionName")=$G(HISTARR(FNBR1,IENS,.01,"E"))
 . S @PHIST@("effectiveDate")=$G(HISTARR(FNBR1,IENS,.02,"E"))
 . S @PHIST@("effectiveDateFM")=$G(HISTARR(FNBR1,IENS,.02,"I"))
 . S @PHIST@("effectiveDateHL7")=$$FMTHL7^XLFDT($G(HISTARR(FNBR1,IENS,.02,"I")))
 . S @PHIST@("effectiveDateFHIR")=$$FMTFHIR^SYNDHPUTL($G(HISTARR(FNBR1,IENS,.02,"I")))
 . S @PHIST@("statusCd")=$G(HISTARR(FNBR1,IENS,.04,"I"))
 . S @PHIST@("statusReason")=$G(HISTARR(FNBR1,IENS,.05,"E"))
 . S @PHIST@("PreceptorTeamPositionId")=$G(HISTARR(FNBR1,IENS,.06,"I"))
 . S @PHIST@("PreceptorTeamPosition")=$G(HISTARR(FNBR1,IENS,.06,"E"))
 . S @PHIST@("userEnteringId")=$G(HISTARR(FNBR1,IENS,.07,"I"))
 . S @PHIST@("userEntering")=$G(HISTARR(FNBR1,IENS,.07,"E"))
 . S @PHIST@("dateTimeEntered")=$G(HISTARR(FNBR1,IENS,.08,"E"))
 . S @PHIST@("dateTimeEnteredFM")=$G(HISTARR(FNBR1,IENS,.08,"I"))
 . S @PHIST@("dateTimeEnteredHL7")=$$FMTHL7^XLFDT($G(HISTARR(FNBR1,IENS,.08,"I")))
 . S @PHIST@("dateTimeEnteredFHIR")=$$FMTFHIR^SYNDHPUTL($G(HISTARR(FNBR1,IENS,.08,"I")))
 . S @PHIST@("preceptorNameC")=$G(HISTARR(FNBR1,IENS,200,"E"))
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PRECHIST")
 ;
 I $G(RETJSON)="J" D
 . N PRECHISTS M PRECHISTS("TeamPreceptorHistory")=PRECHIST
 . D TOJASON^SYNDHPUTL(.PRECHISTS,.PRECHISTJ)
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PRECHISTSJ")
 ;
 QUIT
 ;
