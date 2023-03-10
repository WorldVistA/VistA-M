SDEC52CRMVJSON ;ALB/BLB,LEG,LAB - VIA RECALL REMINDER REMOVE FILE (#403.56) ;MAR 23, 2022@10:48
 ;;5.3;Scheduling;**790,799,813**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;Reference is made to ICR #10035
 Q
 ;
RECGETJSON(SDECY,DFN) ;Return a list of REMOVED recall appointment types for patient
 ;INPUT - DFN (Data File Number) Pointer to PATIENT (#2) File.
 ;RETURN PARMETER:
 ;List of recalls associated with a given patient
 ; Field List:
 ; (1)     Internal IEN
 ; (2)     Accession #
 ; (3)     Comment
 ; (4)     Fast/Non-Fasting
 ; (5)     Test/App
 ; (6)     Provider IEN
 ; (7)     Provider Name
 ; (8)     Clinic IEN
 ; (9)     Clinic Name
 ; (10)    Length of Appointment
 ; (11)    Recall Date
 ; (12)    Recall Date (Per Patient)
 ; (13)    Date Reminder Sent
 ; (14)    Second Print
 ; (15)    Date/Time Recall Added
 ; (16)    GAF Score
 ; (17)    Patient Sensitive & Record Access Checks
 ; (18)    Similar Patient Data
 ; (19)    Number of Call Attempts
 ; (20)    Recall Reminders Letter Date
 ;         Number of Email Contacts
 ;         Number of Text Contacts
 ;         Number of Secure Messages
 ;
 N SDRECALLRMV,IEN,NUM,ERR,IENS,SDESJSONERR
 S DFN=$G(DFN),SDESJSONERR=0
 I DFN="" S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALLRMV,1)
 S ERR=0,IEN=0,NUM=0
 I DFN'="",'$D(^DPT(DFN,0)) S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALLRMV,2)
 I 'SDESJSONERR D
 . F  S IEN=$O(^SD(403.56,"B",DFN,IEN)) Q:IEN=""  D
 . . S NUM=NUM+1
 . . D RECDATA(DFN,IEN)
 . . D PATDATA(DFN,IEN)
 .I '$D(SDRECALLRMV("Recall")) S SDRECALLRMV("Recall")=""
 D BUILDER
 Q
 ;
RECDATA(DFN,IEN) ;
 N F,DAPTDT,DATE,DATE1,DATE2,DATE3,RECARY
 D GETS^DIQ(403.56,IEN,"**","IE","RECARY","SDMSG")
 S F=403.56
 S IENS=IEN_","
 S SDRECALLRMV("Recall",NUM,"RecallIEN")=IEN
 S SDRECALLRMV("Recall",NUM,"Accession")=$G(RECARY(F,IENS,2,"E"))
 S SDRECALLRMV("Recall",NUM,"Comment")=$G(RECARY(F,IENS,2.5,"E"))
 S SDRECALLRMV("Recall",NUM,"FastingNonFasting")=$G(RECARY(F,IENS,2.6,"I"))
 S SDRECALLRMV("Recall",NUM,"TestApp")=$G(RECARY(F,IENS,3,"I"))
 S SDRECALLRMV("Recall",NUM,"ProviderIEN")=$G(RECARY(F,IENS,4,"I"))
 S SDRECALLRMV("Recall",NUM,"ProviderName")=$$GET1^DIQ(403.54,SDRECALLRMV("Recall",NUM,"ProviderIEN"),.01,"E")
 S SDRECALLRMV("Recall",NUM,"ClinicIEN")=$G(RECARY(F,IENS,4.5,"I"))
 S SDRECALLRMV("Recall",NUM,"ClinicName")=$G(RECARY(F,IENS,4.5,"E"))
 S SDRECALLRMV("Recall",NUM,"AppointmentLength")=$G(RECARY(F,IENS,4.7,"E"))
 S DATE=$G(RECARY(F,IENS,5,"I")) S DATE=$$FMTE^XLFDT(DATE)
 S DATE1=$G(RECARY(F,IENS,5.5,"I")) S DATE1=$$FMTE^XLFDT(DATE1)
 S DAPTDT=$G(RECARY(F,IENS,6,"I")) S DAPTDT=$$FMTE^XLFDT(DAPTDT)
 S DATE2=$G(RECARY(F,IENS,8,"I")) S DATE2=$$FMTE^XLFDT(DATE2)
 S DATE3=$G(RECARY(403.56,IENS,7.5,"E")) S DATE3=$$FMTE^XLFDT(DATE3)
 S SDRECALLRMV("Recall",NUM,"RecallDate")=DATE
 S SDRECALLRMV("Recall",NUM,"RecallDatePerPatient")=DATE1
 S SDRECALLRMV("Recall",NUM,"DateReminderSent")=DAPTDT
 S SDRECALLRMV("Recall",NUM,"SecondPrint")=DATE2
 S SDRECALLRMV("Recall",NUM,"DateTimeRecallAdded")=DATE3
 Q
 ;
PATDATA(DFN,IEN) ;
 N SDREC
 S SDRECALLRMV("Recall",NUM,"GAFScore")=$$GAF^SDECU2(DFN)
 S SDRECALLRMV("Recall",NUM,"PatientSensitiveRecordAccessChecks")=$$PTSEC^SDECUTL(DFN)
 S SDRECALLRMV("Recall",NUM,"SimilarPatientData")=$$SIM^SDECU3(DFN)
 S SDREC=$$RECALL^SDECAR1A(DFN,IEN)
 S SDRECALLRMV("Recall",NUM,"NumberOfCallAttempts")=$P(SDREC,U)
 S SDRECALLRMV("Recall",NUM,"RecallRemindersLetterDate")=$P(SDREC,U,2)
 S SDRECALLRMV("Recall",NUM,"NumberOfEmailContact")=$P(SDREC,U,3)
 S SDRECALLRMV("Recall",NUM,"NumberOfTextContact")=$P(SDREC,U,4)
 S SDRECALLRMV("Recall",NUM,"NumberOfSecureMessages")=$P(SDREC,U,5)
 Q
 ;
BUILDER ;
 D ENCODE^XLFJSON("SDRECALLRMV","SDECY","ERR")
 Q
 ;
RECGETONERMVJSON(SDECY,DFN) ;Return the latest REMOVED RECALL REMINDER info in JSON format based on the patient DFN
 ;INPUT - DFN (Data File Number) Pointer to PATIENT (#2) File.
 ;RETURN PARAMETER: recall based on DFN being passed
 ; Field List:
 ; (1)     Internal IEN
 ; (2)     Accession #
 ; (3)     Comment
 ; (4)     Fast/Non-Fasting
 ; (5)     Test/App
 ; (6)     Provider IEN
 ; (7)     Provider Name
 ; (8)     Clinic IEN
 ; (9)     Clinic Name
 ; (10)    Length of Appointment
 ; (11)    Recall Date
 ; (12)    Recall Date (Per Patient)
 ; (13)    Date Reminder Sent
 ; (14)    Second Print
 ; (15)    Date/Time Recall Added
 ; (16)    GAF Score
 ; (17)    Patient Sensitive & Record Access Checks
 ; (18)    Similar Patient Data
 ; (19)    Number of Call Attempts
 ; (20)    Recall Reminders Letter Date
 ;
 N ERR,NUM,F,IENS,ACCESION,COMM,FASTING,RRAPPTYP,RRPROVIEN,PROVNAME,CLINIEN,SDTMP,NUM,SDECI,SDESJSONERR
 N CLINNAME,APPTLEN,DATE,DATE1,DAPTDT,DATE2,DATE3,MSGTYP,GAF,SENSITIVE,SIMILAR,SDREC,CPHONE,CLET,SDRECALLRMV
 S SDESJSONERR=0
 ; VSE-1066;LEG;6/25/2021 ;
 N SDRECALLRMV,IEN
 S DFN=$G(DFN)
 ; check if no DFN
 I DFN="" S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALLRMV,1)
 S ERR=0,NUM=0
 ; check for defined DFN
 I DFN,'$D(^DPT(DFN,0)) S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALLRMV,2)
 ; find latest REMOVED RECALL REMINDER info because patient has no entry in the RECALL REMINDERS File (#403.5)
 I 'SDESJSONERR S IEN=$O(^SD(403.56,"B",DFN,""),-1)
 ;
 S IEN=$G(IEN)
 I IEN,'$D(^SD(403.56,IEN)) S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALLRMV,17)  ; send error and quit if patient has no entry in the RECALL REMINDERS REMOVE File (#403.56)
 I 'IEN S SDESJSONERR=1 D ERRLOG^SDESJSON(.SDRECALLRMV,16)
 I 'SDESJSONERR D
 . D RECDATAONEJSON(IEN) ; build out recall data
 . D PATDATAONEJSON(IEN) ; build out required patient data
 D BUILDER ; build return
 Q
 ;
RECDATAONEJSON(IEN) ;
 N RECARY
 D GETS^DIQ(403.56,IEN,"**","IE","RECARY","SDMSG")
 S F=403.56
 S IENS=IEN_","
 S NUM=NUM+1
 S SDRECALLRMV("Recall",NUM,"RecallIEN")=IEN
 S SDRECALLRMV("Recall",NUM,"EASTrackingNumber")=$G(RECARY(F,IENS,100,"E"))
 S SDRECALLRMV("Recall",NUM,"Accession")=$G(RECARY(F,IENS,2,"E"))
 S SDRECALLRMV("Recall",NUM,"Comment")=$G(RECARY(F,IENS,2.5,"E"))
 S SDRECALLRMV("Recall",NUM,"FastingNonFasting")=$G(RECARY(F,IENS,2.6,"I"))
 S SDRECALLRMV("Recall",NUM,"TestApp")=$G(RECARY(F,IENS,3,"I"))
 S SDRECALLRMV("Recall",NUM,"ProviderIEN")=$G(RECARY(F,IENS,4,"I"))
 S SDRECALLRMV("Recall",NUM,"ProviderName")=$$GET1^DIQ(403.54,SDRECALLRMV("Recall",NUM,"ProviderIEN"),.01,"E")
 S SDRECALLRMV("Recall",NUM,"ClinicIEN")=$G(RECARY(F,IENS,4.5,"I"))
 S SDRECALLRMV("Recall",NUM,"ClinicName")=$G(RECARY(F,IENS,4.5,"E"))
 S SDRECALLRMV("Recall",NUM,"AppointmentLength")=$G(RECARY(F,IENS,4.7,"E"))
 S DATE=$G(RECARY(F,IENS,5,"I")) S DATE=$$FMTE^XLFDT(DATE)
 S DATE1=$G(RECARY(F,IENS,5.5,"I")) S DATE1=$$FMTE^XLFDT(DATE1)
 S DAPTDT=$G(RECARY(F,IENS,6,"I")) S DAPTDT=$$FMTE^XLFDT(DAPTDT)
 S DATE2=$G(RECARY(F,IENS,8,"I")) S DATE2=$$FMTE^XLFDT(DATE2)
 S DATE3=$G(RECARY(403.56,IENS,7.5,"E")) S DATE3=$$FMTE^XLFDT(DATE3)
 S SDRECALLRMV("Recall",NUM,"RecallDate")=DATE
 S SDRECALLRMV("Recall",NUM,"RecallDatePerPatient")=DATE1
 S SDRECALLRMV("Recall",NUM,"DateReminderSent")=DAPTDT
 S SDRECALLRMV("Recall",NUM,"SecondPrint")=DATE2
 S SDRECALLRMV("Recall",NUM,"DateTimeRecallAdded")=DATE3
 Q
 ;
PATDATAONEJSON(IEN) ;
 N SDECALL,SDECLET
 S DFN=$$GET1^DIQ(403.56,IEN,.01,"I")
 S SDRECALLRMV("Recall",NUM,"GAFScore")=$$GAF^SDECU2(DFN)
 S SDRECALLRMV("Recall",NUM,"PatientSensitiveRecordAccessChecks")=$$PTSEC^SDECUTL(DFN)
 S SDRECALLRMV("Recall",NUM,"SimilarPatientData")=$$SIM^SDECU3(DFN)
 S SDREC=$$RECALL^SDECAR1A(DFN,IEN)
 S SDRECALLRMV("Recall",NUM,"NumberOfCallAttempts")=$P(SDREC,U)
 S SDRECALLRMV("Recall",NUM,"RecallRemindersLetterDate")=$P(SDREC,U,2)
 S SDRECALLRMV("Recall",NUM,"NumberOfEmailContact")=$P(SDREC,U,3)
 S SDRECALLRMV("Recall",NUM,"NumberOfTextContact")=$P(SDREC,U,4)
 S SDRECALLRMV("Recall",NUM,"NumberOfSecureMessages")=$P(SDREC,U,5)
 Q
