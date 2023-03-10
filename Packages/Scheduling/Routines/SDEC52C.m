SDEC52C ;ALB/BLB - VISTA SCHEDULING RPCS ;APR 14, 2021@10:48
 ;;5.3;Scheduling;**784,785**;Aug 13, 1993;Build 14
 ;
 ;Reference is made to ICR #10035
 Q
 ;
RECGET(SDECY,DFN) ;Return a list of OPEN recall appointment types for patient
 ;INPUT - DFN (Date File Number) Pointer to PATIENT (#2) File.
 ;RETURN PARAMETER:
 ;List of recalls associated with a given patient
 ;Data is delimited by carat (^). 
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
 N ERR,IEN,NUM,F,IENS,ACCESION,COMM,FASTING,RRAPPTYP,RRPROVIEN,PROVNAME,CLINIEN,SDTMP,NUM,SDECI
 N CLINNAME,APPTLEN,DATE,DATE1,DAPTDT,DATE2,DATE3,MSGTYP,GAF,SENSITIVE,SIMILAR,SDREC,CPHONE,CLET
 D INIT ; initialize variables/ build header
 I '$D(^DPT(DFN,0)) S NUM=NUM+1 D NODATA("PATIENT") Q  ; send error and quit if patient does not exist
 I '$D(^SD(403.5,"B",DFN)) S NUM=NUM+1 D NODATA("RECALL") Q  ; send error and quit if patient has no entry in the RECALL REMINDERS File (403.5)
 F  S IEN=$O(^SD(403.5,"B",DFN,IEN)) Q:IEN=""  D
 .D RECDATA(DFN,IEN) ; build out recall data
 .D PATDATA(DFN,IEN) ; build out required patient data
 .D BUILDER ; build return
 S ^TMP("SDEC52C",$J,"RECGET",NUM)=^TMP("SDEC52C",$J,"RECGET",NUM)_$C(31)
 Q
BUILDER ;
 S NUM=NUM+1
 S SDTMP=IEN_U_ACCESION_U_COMM_U_FASTING_U_RRAPPTYP_U_RRPROVIEN_U_PROVNAME_U_CLINIEN_U_CLINNAME_U_APPTLEN_U_DATE_U_DATE1
 ; internal IEN^accession^comment^fast/nonfasting^test/app^provider IEN^provider name^clinic IEN^clinic name^length of appt^recall date^recall date(per patient)
 S SDTMP=SDTMP_U_DAPTDT_U_DATE2_U_DATE3_U_GAF_U_SENSITIVE_U_SIMILAR_U_CPHONE_U_CLET
 ; date reminder sent^second print^date/time recall added^GAF score^patient sensitive^similar patient data^# call attempts^recall reminders letter date
 S ^TMP("SDEC52C",$J,"RECGET",NUM)=SDTMP_$C(30)
 Q
INIT ;
 S DFN=$G(DFN)
 S ERR=0,IEN=0,NUM=0
 S SDECY="^TMP(""SDEC52C"","_$J_",""RECGET"")"
 K ^TMP("SDEC52C",$J,"RECGET")
 S SDTMP="T00030IEN^T00030ACCESION^T00030COMM^T00030FASTING^T00030RRAPPTYP^T00030RRPROVIEN"
 S SDTMP=SDTMP_"^T00030PROVNAME^T00030CLINIEN^T00030CLINNAME^T00030APPTLEN^T00030DATE"
 S SDTMP=SDTMP_"^T00030DATE1^T00030DAPTDT^T00030DATE2^T00030DATE3^T00030GAF^T00030SENSITIVE"
 S SDTMP=SDTMP_"^T00030SIMILAR^T00030CPHONE^T00030CLET"
 S ^TMP("SDEC52C",$J,"RECGET",NUM)=SDTMP_$C(30)
 Q
RECDATA(DFN,IEN) ;
 N RECARY
 D GETS^DIQ(403.5,IEN,"**","IE","RECARY","SDMSG")
 S F=403.5
 S IENS=IEN_","
 S ACCESION=$G(RECARY(F,IENS,2,"E"))
 S COMM=$G(RECARY(F,IENS,2.5,"E"))
 S FASTING=$G(RECARY(F,IENS,2.6,"I"))
 S RRAPPTYP=$G(RECARY(F,IENS,3,"I"))
 S RRPROVIEN=$G(RECARY(F,IENS,4,"I"))
 S PROVNAME=$$GET1^DIQ(403.54,RRPROVIEN,.01,"E")
 S CLINIEN=$G(RECARY(F,IENS,4.5,"I"))
 S CLINNAME=$G(RECARY(F,IENS,4.5,"E"))
 S APPTLEN=$G(RECARY(F,IENS,4.7,"E"))
 S DATE=$G(RECARY(F,IENS,5,"I")) S DATE=$$FMTE^XLFDT(DATE)
 S DATE1=$G(RECARY(F,IENS,5.5,"I")) S DATE1=$$FMTE^XLFDT(DATE1)
 S DAPTDT=$G(RECARY(F,IENS,6,"I")) S DAPTDT=$$FMTE^XLFDT(DAPTDT)
 S DATE2=$G(RECARY(F,IENS,8,"I")) S DATE2=$$FMTE^XLFDT(DATE2)
 S DATE3=$G(RECARY(403.5,IENS,7.5,"E")) S DATE3=$$FMTE^XLFDT(DATE3)
 Q
PATDATA(DFN,IEN) ;
 S GAF=$$GAF^SDECU2(DFN)
 S SENSITIVE=$$PTSEC^SDECUTL(DFN)
 S SIMILAR=$$SIM^SDECU3(DFN)
 S SDREC=$$RECALL^SDECAR1A(DFN,IEN),CPHONE=$P(SDREC,U),CLET=$P(SDREC,U,2)
 Q
NODATA(MSGTYP) ;differentiate between error messages based on NO recall data, patient data, invalid recall IEN, and invalid patient DFN
 I MSGTYP="RECALL" D ERR1^SDECERR(-1,"No recall associated with this patient.",NUM,SDECY) Q
 ; checking for entry in recall reminder file
 I MSGTYP="PATIENT" D ERR1^SDECERR(-1,"Invalid Patient ID.",NUM,SDECY) Q
 ; checking for entry in patient file
 Q
RECGETONE(SDECY,IEN) ;Return a single OPEN recall appointment type based on the IEN passed
 ;INPUT - IEN (Internal Entry Number) RECALL REMINDERS File (403.5)
 ;RETURN PARAMETER: recall based on IEN being passed
 ;Data is delimited by carat (^). 
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
 N ERR,NUM,F,IENS,ACCESION,COMM,FASTING,RRAPPTYP,RRPROVIEN,PROVNAME,CLINIEN,SDTMP,NUM,SDECI,DFN
 N CLINNAME,APPTLEN,DATE,DATE1,DAPTDT,DATE2,DATE3,MSGTYP,GAF,SENSITIVE,SIMILAR,SDREC,CPHONE,CLET
 D INITONE ; initialize variables/ build header
 I '$D(^SD(403.5,IEN)) S NUM=NUM+1 D NODATAONE("RECALL") Q  ; send error and quit if patient has no entry in the RECALL REMINDERS File (403.5)
 D RECDATAONE(IEN) ; build out recall data
 D PATDATAONE(IEN) ; build out required patient data
 D BUILDERONE ; build return
 S ^TMP("SDEC52C",$J,"RECGET",NUM)=^TMP("SDEC52C",$J,"RECGET",NUM)_$C(31)
 Q
BUILDERONE ;
 S NUM=NUM+1
 S SDTMP=IEN_U_ACCESION_U_COMM_U_FASTING_U_RRAPPTYP_U_RRPROVIEN_U_PROVNAME_U_CLINIEN_U_CLINNAME_U_APPTLEN_U_DATE_U_DATE1
 ; internal IEN^accession^comment^fast/nonfasting^test/app^provider IEN^provider name^clinic IEN^clinic name^length of appt^recall date^recall date(per patient)
 S SDTMP=SDTMP_U_DAPTDT_U_DATE2_U_DATE3_U_GAF_U_SENSITIVE_U_SIMILAR_U_CPHONE_U_CLET
 ; date reminder sent^second print^date/time recall added^GAF score^patient sensitive^similar patient data^# call attempts^recall reminders letter date
 S ^TMP("SDEC52C",$J,"RECGET",NUM)=SDTMP_$C(30)
 Q
INITONE ;
 S ERR=0,NUM=0
 S SDECY="^TMP(""SDEC52C"","_$J_",""RECGET"")"
 K ^TMP("SDEC52C",$J,"RECGET")
 S SDTMP="T00030IEN^T00030ACCESION^T00030COMM^T00030FASTING^T00030RRAPPTYP^T00030RRPROVIEN"
 S SDTMP=SDTMP_"^T00030PROVNAME^T00030CLINIEN^T00030CLINNAME^T00030APPTLEN^T00030DATE"
 S SDTMP=SDTMP_"^T00030DATE1^T00030DAPTDT^T00030DATE2^T00030DATE3^T00030GAF^T00030SENSITIVE"
 S SDTMP=SDTMP_"^T00030SIMILAR^T00030CPHONE^T00030CLET"
 S ^TMP("SDEC52C",$J,"RECGET",NUM)=SDTMP_$C(30)
 Q
RECDATAONE(IEN) ;
 N RECARY
 D GETS^DIQ(403.5,IEN,"**","IE","RECARY","SDMSG")
 S F=403.5
 S IENS=IEN_","
 S ACCESION=$G(RECARY(F,IENS,2,"E"))
 S COMM=$G(RECARY(F,IENS,2.5,"E"))
 S FASTING=$G(RECARY(F,IENS,2.6,"I"))
 S RRAPPTYP=$G(RECARY(F,IENS,3,"I"))
 S RRPROVIEN=$G(RECARY(F,IENS,4,"I"))
 S PROVNAME=$$GET1^DIQ(403.54,RRPROVIEN,.01,"E")
 S CLINIEN=$G(RECARY(F,IENS,4.5,"I"))
 S CLINNAME=$G(RECARY(F,IENS,4.5,"E"))
 S APPTLEN=$G(RECARY(F,IENS,4.7,"E"))
 S DATE=$G(RECARY(F,IENS,5,"I")) S DATE=$$FMTE^XLFDT(DATE)
 S DATE1=$G(RECARY(F,IENS,5.5,"I")) S DATE1=$$FMTE^XLFDT(DATE1)
 S DAPTDT=$G(RECARY(F,IENS,6,"I")) S DAPTDT=$$FMTE^XLFDT(DAPTDT)
 S DATE2=$G(RECARY(F,IENS,8,"I")) S DATE2=$$FMTE^XLFDT(DATE2)
 S DATE3=$G(RECARY(403.5,IENS,7.5,"E")) S DATE3=$$FMTE^XLFDT(DATE3)
 Q
PATDATAONE(IEN) ;
 S DFN=$$GET1^DIQ(403.5,IEN,.01,"I")
 S GAF=$$GAF^SDECU2(DFN)
 S SENSITIVE=$$PTSEC^SDECUTL(DFN)
 S SIMILAR=$$SIM^SDECU3(DFN)
 S SDREC=$$RECALL^SDECAR1A(DFN,IEN),CPHONE=$P(SDREC,U),CLET=$P(SDREC,U,2)
 Q
NODATAONE(MSGTYP) ;differentiate between error messages based on NO recall data, patient data, invalid recall IEN, and invalid patient DFN
 I MSGTYP="RECALL" D ERR1^SDECERR(-1,"No recall associated with the IEN.",NUM,SDECY) Q
 ; checking for entry in recall reminder file
 Q
