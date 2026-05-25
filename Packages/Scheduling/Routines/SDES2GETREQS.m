SDES2GETREQS ;ALB/BWF,JAS,LAB - VISTA SCHEDULING GET REQUEST RPCS ;NOV 24, 2024
 ;;5.3;Scheduling;**873,890,895,909**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 Q
 ; Input:
 ; SDCONTEXT
 ; SDINPUT("PATIENT IEN")=Patient DFN from the PATIENT file (#2)
 ;
GETREQLISTBYDFN(JSONRETURN,SDCONTEXT,SDINPUT) ;
 N ERRORS,REQUESTIEN,REQUEST,CONSULTIEN,CPRSSTATUS,IFCROLE,RECALLIEN,DFN,VRET
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("Request",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 D VALFILEIEN^SDES2VALUTIL(.VRET,.ERRORS,2,$G(SDINPUT("PATIENT IEN")),1,,1,2)
 I $D(ERRORS) S ERRORS("Request",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.ERRORS) Q
 ;
 S DFN=$G(SDINPUT("PATIENT IEN"))
 S REQUESTIEN=0
 F  S REQUESTIEN=$O(^SDEC(409.85,"B",DFN,REQUESTIEN)) Q:'REQUESTIEN  D
 .I $$GET1^DIQ(409.85,REQUESTIEN,23,"I")="C" Q
 .D GETREQUEST^SDES2GETAPPTREQ(.REQUEST,REQUESTIEN)
 ;
 S RECALLIEN=0
 F  S RECALLIEN=$O(^SD(403.5,"B",DFN,RECALLIEN)) Q:RECALLIEN=""  D
 .S DFN=$$GET1^DIQ(403.5,RECALLIEN,.01,"I")
 .D GETRECALL^SDES2GETRECALL(.REQUEST,RECALLIEN,DFN)
 ;
 S CONSULTIEN=0
 F  S CONSULTIEN=$O(^GMR(123,"F",DFN,CONSULTIEN)) Q:'CONSULTIEN  D
 .S CPRSSTATUS=$$GET1^DIQ(123,CONSULTIEN,8,"E"),IFCROLE=$$GET1^DIQ(123,CONSULTIEN,.125,"E")
 .I CPRSSTATUS'="PENDING",CPRSSTATUS'="ACTIVE" Q
 .I IFCROLE="PLACER" Q
 .D GETCONSULT^SDES2GETCONSULTS(.REQUEST,CONSULTIEN)
 ;
 I '$D(REQUEST) S REQUEST("Request",1)=""
 D BUILDJSON^SDES2JSON(.JSONRETURN,.REQUEST)
 Q
 ;
APPTREQUEST(REQUEST,NUM) ;
 ;
 S REQUEST("Request",NUM,"ApptType")=""
 S REQUEST("Request",NUM,"InstitutionIEN")=""
 S REQUEST("Request",NUM,"InstitutionName")=""
 S REQUEST("Request",NUM,"InstitutionNumber")=""
 S REQUEST("Request",NUM,"RequestSubType")=""
 S REQUEST("Request",NUM,"ChildRequestSequenceNumber")=""
 S REQUEST("Request",NUM,"ClinicStopCodeIEN")=""
 S REQUEST("Request",NUM,"ClinicStopCodeName")=""
 S REQUEST("Request",NUM,"ClinicSecondaryStopCodeIEN")=""
 S REQUEST("Request",NUM,"ClinicSecondaryStopCodeName")=""
 S REQUEST("Request",NUM,"DateTimeEntered")=""
 S REQUEST("Request",NUM,"Priority")=""
 S REQUEST("Request",NUM,"ByPatientOrProvider")=""
 S REQUEST("Request",NUM,"DateLinkedApptMade")=""
 S REQUEST("Request",NUM,"LinkedApptClinic")=""
 S REQUEST("Request",NUM,"LinkedApptStopCode")=""
 S REQUEST("Request",NUM,"LinkedApptCreditStopCode")=""
 S REQUEST("Request",NUM,"LinkedApptStationNumber")=""
 S REQUEST("Request",NUM,"LinkedApptEnteredBy")=""
 S REQUEST("Request",NUM,"LinkedApptStatus")=""
 S REQUEST("Request",NUM,"LinkedApptInstitutionName")=""
 S REQUEST("Request",NUM,"LinkedApptInstitutionNumber")=""
 S REQUEST("Request",NUM,"MRTCNeeded")=""
 S REQUEST("Request",NUM,"MRTCDaysBetweenAppts")=""
 S REQUEST("Request",NUM,"MRTCHowManyNeeded")=""
 S REQUEST("Request",NUM,"MRTCTotal")=""
 S REQUEST("Request",NUM,"ModalityCode")=""
 S REQUEST("Request",NUM,"ModalityName")=""
 I '$D(REQUEST("Request",NUM,"EASTrackingNumber")) S REQUEST("Request",NUM,"EASTrackingNumber")=""
 S REQUEST("Request",NUM,"DispositionedDate")=""
 S REQUEST("Request",NUM,"DispositionedBy")=""
 S REQUEST("Request",NUM,"DispositionReason")=""
 S REQUEST("Request",NUM,"ServiceConnectedPriority")=""
 S REQUEST("Request",NUM,"PatientStatus")=""
 S REQUEST("Request",NUM,"ParentRequestIEN")=""
 S REQUEST("Request",NUM,"Status")=""
 S REQUEST("Request",NUM,"MRTC",1)=""
 S REQUEST("Request",NUM,"PatientComment",1)=""
 S REQUEST("Request",NUM,"ScheduledDateOfAppt")=""
 S REQUEST("Request",NUM,"CPRSOrderID")=""
 S REQUEST("Request",NUM,"CPRSTimeSensitive")=""
 S REQUEST("Request",NUM,"CPRSPreRequisites",1)=""
 S REQUEST("Request",NUM,"ClinicSecondaryStopCodeAMIS")=""
 S REQUEST("Request",NUM,"ClinicStopCodeAMIS")=""
 I '$D(REQUEST("Request",NUM,"CommentMultiple")) S REQUEST("Request",NUM,"CommentMultiple",1)=""
 S REQUEST("Request",NUM,"RequestComments")=""
 S REQUEST("Request",NUM,"ServiceConnectedPercentage")=""
 S REQUEST("Request",NUM,"PIDChangeAllowed")=""
 S REQUEST("Request",NUM,"DispositionIEN")=""
 I '$D(REQUEST("Request",NUM,"DuplicateReason")) S REQUEST("Request",NUM,"DuplicateReason")=""
 Q
 ;
SDECONTACT(REQUEST,NUM) ;
 S REQUEST("Request",NUM,"SdecContactNumberOfCalls")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfEmailContact")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfTextContact")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfSecureMessage")=""
 S REQUEST("Request",NUM,"SdecContactDateOfLastLetterSent")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfLetters")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfContacts")=0
 Q
 ;
RECALL(REQUEST,NUM) ;
 ;
 S REQUEST("Request",NUM,"RecallAccessionNumber")=""
 S REQUEST("Request",NUM,"RecallComment")=""
 S REQUEST("Request",NUM,"RecallFastingNonFasting")=""
 S REQUEST("Request",NUM,"RecallProviderIEN")=""
 S REQUEST("Request",NUM,"RecallProviderName")=""
 S REQUEST("Request",NUM,"RecallAppointmentLength")=""
 S REQUEST("Request",NUM,"RecallProviderIndicatedDate")=""
 S REQUEST("Request",NUM,"RecallDateReminderSent")=""
 S REQUEST("Request",NUM,"RecallSecondPrint")=""
 S REQUEST("Request",NUM,"RecallGAFScore")=""
 S REQUEST("Request",NUM,"RecallSimilarPatientData")=""
 S REQUEST("Request",NUM,"RecallAppointmentType")=""
 S REQUEST("Request",NUM,"RecallProviderNewPersonIEN")=""
 S REQUEST("Request",NUM,"RecallProviderSecID")=""
 S REQUEST("Request",NUM,"RecallClinicStopCodeIEN")=""
 S REQUEST("Request",NUM,"RecallClinicStopCodeAMIS")=""
 S REQUEST("Request",NUM,"RecallClinicStopCodeName")=""
 S REQUEST("Request",NUM,"RecallClinicSecondaryStopCodeIEN")=""
 S REQUEST("Request",NUM,"RecallClinicSecondaryStopCodeAMIS")=""
 S REQUEST("Request",NUM,"RecallClinicSecondaryStopCodeName")=""
 S REQUEST("Request",NUM,"RecallEnteredBySecID")=""
 I '$D(REQUEST("Request",NUM,"DuplicateReason")) S REQUEST("Request",NUM,"DuplicateReason")=""
 I '$D(REQUEST("Request",NUM,"EASTrackingNumber")) S REQUEST("Request",NUM,"EASTrackingNumber")=""
 Q
 ;
CONSULT(REQUEST,NUM) ;
 ;
 S REQUEST("Request",NUM,"ConsultAssociatedStopCodes",1)=""
 S REQUEST("Request",NUM,"ConsultRequestType")=""
 S REQUEST("Request",NUM,"ConsultToService")=""
 S REQUEST("Request",NUM,"ConsultCovidPriority")=""
 S REQUEST("Request",NUM,"ConsultDateReleasedFromCPRS")="" ; check
 S REQUEST("Request",NUM,"ConsultUrgencyOrEarliestDate")=""
 S REQUEST("Request",NUM,"ConsultServiceRenderedAs")=""
 S REQUEST("Request",NUM,"ConsultProhibitedClinicFlag")=""
 S REQUEST("Request",NUM,"ConsultClinicIndicatedDate")=""
 S REQUEST("Request",NUM,"ConsultCanEditPid")=""
 S REQUEST("Request",NUM,"CPRSStatus")=""
 I '$D(REQUEST("Request",NUM,"DuplicateReason")) S REQUEST("Request",NUM,"DuplicateReason")=""
 I '$D(REQUEST("Request",NUM,"EASTrackingNumber")) S REQUEST("Request",NUM,"EASTrackingNumber")=""
 Q
