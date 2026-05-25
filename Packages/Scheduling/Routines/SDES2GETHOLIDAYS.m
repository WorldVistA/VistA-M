SDES2GETHOLIDAYS ;ALB/BWF,JHC - SDES2 GET HOLIDAYS ;FEBRUARY 28, 2025
 ;;5.3;Scheduling;**853,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 Q
 ; SDCONTEXT("ACHERON AUDIT ID") = 36 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action on the calling application.
 ; SDCONTEXT("USER NAME") = The name of the user taking action on the calling application.
 ; SDCONTEXT("PATIENT DFN") = The name of the patient taking action on the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the patient taking action on the calling application.
 ;
 ; PARAMS("START DATE") - START DATE IN ISO FORMAT  (OPTIONAL - DEFAULTS TO TODAY)
 ; PARAMS("END DATE")   - END DATE IN ISO FORMAT    (OPTIONAL - DEFAULTS TO 9999999)
 ;
GETHOLIDAYS(RES,SDCONTEXT,PARAMS) ;
 N IEN,RESULT,STRTDTISO,ENDDTISO,STRTDT,ENDDT,CNT,ENDDT,ERRORS,FMDATES
 ; validate context array, quit if errors
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("Holiday",1)="" D BUILDJSON^SDES2JSON(.RES,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ; get the start and end date. Strip off time because we do not need it.
 S STRTDTISO=$P($G(PARAMS("START DATE")),"T")
 S ENDDTISO=$P($G(PARAMS("END DATE")),"T")
 ; start date passed, but no end date - validate start date alone
 I STRTDTISO'="",(ENDDTISO="") S FMDATES=$$VALISODTTM^SDES2VALISODTTM(.ERRORS,STRTDTISO,,,498,499)
 ; start date is not passed, but end date is passed
 I STRTDTISO="",(ENDDTISO'="") S $P(FMDATES,U,2)=$$VALISODTTM^SDES2VALISODTTM(.ERRORS,ENDDTISO,,,501,502)
 ; both dates are passed in, validate the range
 I STRTDTISO'="",(ENDDTISO'="") S FMDATES=$$VALISODATERANGE^SDES2VALISODTTM(.ERRORS,STRTDTISO,ENDDTISO)
 I $D(ERRORS) S ERRORS("Holiday",1)="" D BUILDJSON^SDES2JSON(.RES,.ERRORS) Q
 I $G(FMDATES)'="" S STRTDT=$P($G(FMDATES),U),ENDDT=$P($G(FMDATES),U,2)
 I '$G(STRTDT) S STRTDT=DT
 I '$G(ENDDT) S ENDDT=9999999
 I ENDDT<STRTDT D ERRLOG^SDES2JSON(.ERRORS,13)
 I $D(ERRORS) S ERRORS("Holiday",1)="" D BUILDJSON^SDES2JSON(.RES,.ERRORS) Q
 S CNT=0
 S STRTDT=$$FMADD^XLFDT(STRTDT,-1)
 F  S STRTDT=$O(^HOLIDAY(STRTDT)) Q:'STRTDT!(STRTDT>ENDDT)  D
 .S CNT=CNT+1
 .S RESULT("Holiday",CNT,"Date")=$$FMTISO^SDAMUTDT($$GET1^DIQ(40.5,STRTDT,.01,"I"))
 .S RESULT("Holiday",CNT,"Name")=$$GET1^DIQ(40.5,STRTDT,2,"E")
 I '$D(RESULT) S RESULT("Holiday",1)=""
 D BUILDJSON^SDES2JSON(.RES,.RESULT)
 Q
