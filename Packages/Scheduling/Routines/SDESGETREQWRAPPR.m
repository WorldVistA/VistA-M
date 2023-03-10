SDESGETREQWRAPPR ;ALB/BLB,MGD - VISTA SCHEDULING RPCS ;SEP 14, 2022
 ;;5.3;Scheduling;**815,818,820,823,825,831**;Aug 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;
 ; Return
 ;("Request",1,"ByPatientOrProvider")
 ;("Request",1,"ClinicIEN")
 ;("Request",1,"ClinicName")
 ;("Request",1,"ClinicSecondaryStopCodeAMIS")
 ;("Request",1,"ClinicStopCodeAMIS")
 ;("Request",1,"ClinicStopCodeIEN")
 ;("Request",1,"ClinicStopCodeName")
 ;("Request",1,"CommentMultiple")
 ;("Request",1,"ConsultAssociatedStopCodes",1,"StopCode")
 ;("Request",1,"ConsultCanEditPid")
 ;("Request",1,"ConsultClinicIndicatedDate")
 ;("Request",1,"ConsultCovidPriority")
 ;("Request",1,"ConsultDateReleasedFromCPRS")
 ;("Request",1,"ConsultProhibitedClinicFlag")
 ;("Request",1,"ConsultRequestType")
 ;("Request",1,"ConsultServiceRenderedAs")
 ;("Request",1,"ConsultToService")
 ;("Request",1,"ConsultUrgencyOrEarliestDate")
 ;("Request",1,"CPRSOrderID")=""
 ;("Request",1,"CPRSTimeSensitive")=""
 ;("Request",1,"CPRSPreRequisites",1)=""
 ;("Request",1,"CreateDate")
 ;("Request",1,"DateLinkedApptMade")
 ;("Request",1,"DateTimeEntered")
 ;("Request",1,"DispositionReason")
 ;("Request",1,"DispositionedBy")
 ;("Request",1,"DispositionedDate")
 ;("Request",1,"EASTrackingNumber")
 ;("Request",1,"EnrollmentPriorityGroup")
 ;("Request",1,"EnteredByIEN")
 ;("Request",1,"EnteredByName")
 ;("Request",1,"InstitutionIEN")
 ;("Request",1,"InstitutionName")
 ;("Request",1,"LinkedApptType")
 ;("Request",1,"LinkedApptClinic")
 ;("Request",1,"LinkedApptCreditStopCode")
 ;("Request",1,"LinkedApptEnteredBy")
 ;("Request",1,"LinkedApptInstitutionNumber")
 ;("Request",1,"LinkedApptStatus")
 ;("Request",1,"LinkedApptStopCode")
 ;("Request",1,"LinkedApptInstitutionName")
 ;("Request",1,"MRTC",1,"ChildRequestIEN")
 ;("Request",1,"MRTC",1,"LinkedAppointmentIEN")
 ;("Request",1,"MRTC",1,"PatientIndicatedDate")
 ;("Request",1,"MRTCDaysBetweenAppts")
 ;("Request",1,"MRTCHowManyNeeded")
 ;("Request",1,"MRTCNeeded")
 ;("Request",1,"MRTCTotal")
 ;("Request",1,"ParentRequest")
 ;("Request",1,"PatientComment",1,"Comment")
 ;("Request",1,"PatientContact",1,"Action")
 ;("Request",1,"PatientContact",1,"DateEntered")
 ;("Request",1,"PatientContact",1,"EnteredByIEN")
 ;("Request",1,"PatientContact",1,"EnteredByName")
 ;("Request",1,"PatientContact",1,"PatientPhone")
 ;("Request",1,"PatientIEN")
 ;("Request",1,"PatientIndicatedDate")
 ;("Request",1,"PatientName")
 ;("Request",1,"PatientStatus")
 ;("Request",1,"Priority")
 ;("Request",1,"ProviderIEN")
 ;("Request",1,"ProviderName")
 ;("Request",1,"ProviderSecID")
 ;("Request",1,"RecallAccessionNumber")
 ;("Request",1,"RecallAppointmentLength")
 ;("Request",1,"RecallComment")
 ;("Request",1,"RecallDateReminderSent")
 ;("Request",1,"RecallFastingNonFasting")
 ;("Request",1,"RecallGAFScore")
 ;("Request",1,"RecallPatientSensitiveRecordAccessChecks")
 ;("Request",1,"RecallProviderIEN")
 ;("Request",1,"RecallProviderIndicatedDate")
 ;("Request",1,"RecallProviderName")
 ;("Request",1,"RecallSecondPrint")
 ;("Request",1,"RecallSimilarPatientData")
 ;("Request",1,"RequestComments")
 ;("Request",1,"RequestIEN")
 ;("Request",1,"RequestSubType")
 ;("Request",1,"ScheduledDateOfAppt")
 ;("Request",1,"SdecContactDateOfLastLetterSent")
 ;("Request",1,"SdecContactNumberOfCalls")
 ;("Request",1,"SdecContactNumberOfContacts")
 ;("Request",1,"SdecContactNumberOfEmailContact")
 ;("Request",1,"SdecContactNumberOfLetters")
 ;("Request",1,"SdecContactNumberOfSecureMessage")
 ;("Request",1,"SdecContactNumberOfTextContact")
 ;("Request",1,"ServiceConnectedPriority")
 ;("Request",1,"Type")
 ;
 Q
 ;
GETREQLISTBYDFN(JSONRETURN,DFN,EAS) ;
 ;
 N ISDFNVALID,ISEASVALID,RETURN,ERRORS,REQUESTIEN,REQUEST,CONSULTIEN,CPRSSTATUS,IFCROLE,RECALLIEN
 ;
 S ISDFNVALID=$$VALIDATEDFN(.ERRORS,$G(DFN))
 S ISEASVALID=$$VALIDATEEAS(.ERRORS,$G(EAS))
 I $D(ERRORS) S ERRORS("Request",1)="" M RETURN=ERRORS D BUILDJSON(.JSONRETURN,.RETURN) Q
 ;
 S REQUESTIEN=0
 F  S REQUESTIEN=$O(^SDEC(409.85,"B",DFN,REQUESTIEN)) Q:'REQUESTIEN  D
 .I $$GET1^DIQ(409.85,REQUESTIEN,23,"I")="C" Q
 .D GETREQUEST^SDESGETAPPTREQ(.REQUEST,REQUESTIEN)
 ;
 S RECALLIEN=0
 F  S RECALLIEN=$O(^SD(403.5,"B",DFN,RECALLIEN)) Q:RECALLIEN=""  D
 .S DFN=$$GET1^DIQ(403.5,RECALLIEN,.01,"I")
 .D GETRECALL^SDESGETRECALL(.REQUEST,RECALLIEN,DFN)
 ;
 S CONSULTIEN=0
 F  S CONSULTIEN=$O(^GMR(123,"F",DFN,CONSULTIEN)) Q:'CONSULTIEN  D
 .S CPRSSTATUS=$$GET1^DIQ(123,CONSULTIEN,8,"E"),IFCROLE=$$GET1^DIQ(123,CONSULTIEN,.125,"E")
 .I CPRSSTATUS'="PENDING",CPRSSTATUS'="ACTIVE" Q
 .I IFCROLE="PLACER" Q
 .D GETCONSULT^SDESGETCONSULTS(.REQUEST,CONSULTIEN)
 ;
 I '$D(REQUEST) S REQUEST("Request",1)=""
 M RETURN=REQUEST
 D BUILDJSON(.JSONRETURN,.RETURN)
 Q
 ;
VALIDATEDFN(ERRORS,DFN) ;
 I DFN="" D ERRLOG^SDESJSON(.ERRORS,1) Q 0
 I DFN'="",'$D(^DPT(DFN,0)) D ERRLOG^SDESJSON(.ERRORS,2) Q 0
 Q 1
 ;
VALIDATEEAS(ERRORS,EAS) ;
 I $L(EAS) S EAS=$$EASVALIDATE^SDESUTIL($G(EAS))
 I $P($G(EAS),U)=-1 D ERRLOG^SDESJSON(.ERRORS,142) Q 0
 Q 1
 ;
BUILDJSON(JSONRETURN,RETURN) ;
 D ENCODE^XLFJSON("RETURN","JSONRETURN","ERR")
 Q
 ;
APPTREQUEST(REQUEST,NUM) ;
 ;
 S REQUEST("Request",NUM,"InstitutionIEN")=""
 S REQUEST("Request",NUM,"InstitutionName")=""
 S REQUEST("Request",NUM,"RequestType")=""
 S REQUEST("Request",NUM,"ClinicStopCodeIEN")=""
 S REQUEST("Request",NUM,"ClinicStopCodeName")=""
 S REQUEST("Request",NUM,"LinkedAppointmentType")=""
 S REQUEST("Request",NUM,"DateTimeEntered")=""
 S REQUEST("Request",NUM,"Priority")=""
 S REQUEST("Request",NUM,"EnrollmentPriorityGroup")=""
 S REQUEST("Request",NUM,"ByPatientOrProvider")=""
 S REQUEST("Request",NUM,"DateLinkedApptMade")=""
 S REQUEST("Request",NUM,"LinkedApptClinic")=""
 S REQUEST("Request",NUM,"LinkedInstitution")=""
 S REQUEST("Request",NUM,"LinkedApptStopCode")=""
 S REQUEST("Request",NUM,"LinkedApptCreditStopCode")=""
 S REQUEST("Request",NUM,"LinkedApptStationNumber")=""
 S REQUEST("Request",NUM,"LinkedApptEnteredBy")=""
 S REQUEST("Request",NUM,"LinkedApptStatus")=""
 S REQUEST("Request",NUM,"MRTCNeeded")=""
 S REQUEST("Request",NUM,"MRTCDaysBetweenAppts")=""
 S REQUEST("Request",NUM,"MRTCHowManyNeeded")=""
 S REQUEST("Request",NUM,"EASTrackingNumber")=""
 S REQUEST("Request",NUM,"DispositionedDate")=""
 S REQUEST("Request",NUM,"DispositionedBy")=""
 S REQUEST("Request",NUM,"DispositionedBy")=""
 S REQUEST("Request",NUM,"DispositionReason")=""
 S REQUEST("Request",NUM,"ServiceConnectedPriority")=""
 S REQUEST("Request",NUM,"PatientStatus")=""
 S REQUEST("Request",NUM,"ParentRequestIEN")=""
 S REQUEST("Request",NUM,"PatientContact",1)=""
 S REQUEST("Request",NUM,"MRTC",1)=""
 S REQUEST("Request",NUM,"PatientComment",1)=""
 S REQUEST("Request",NUM,"ScheduledDateOfAppt")=""
 S REQUEST("Request",NUM,"CPRSOrderID")=""
 S REQUEST("Request",NUM,"CPRSTimeSensitive")=""
 S REQUEST("Request",NUM,"CPRSPreRequisites",1)=""
 S REQUEST("Request",NUM,"ClinicSecondaryStopCodeAMIS")=""
 S REQUEST("Request",NUM,"ClinicStopCodeAMIS")=""
 S REQUEST("Request",NUM,"CommentMultiple",1)=""
 S REQUEST("Request",NUM,"RequestComments")=""
 S REQUEST("Request",NUM,"ServiceConnectedPercentage")=""
 Q
 ;
SDECONTACT(REQUEST,NUM) ;
 S REQUEST("Request",NUM,"SdecContactNumberOfCalls")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfEmailContact")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfTextContact")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfSecureMessage")=""
 S REQUEST("Request",NUM,"SdecContactDateOfLastLetterSent")=""
 S REQUEST("Request",NUM,"SdecContactNumberOfContacts")=""
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
 S REQUEST("Request",NUM,"RecallPatientSensitiveRecordAccessChecks")=""
 S REQUEST("Request",NUM,"RecallSimilarPatientData")=""
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
 Q
 ;
