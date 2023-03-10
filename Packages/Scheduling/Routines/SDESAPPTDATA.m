SDESAPPTDATA ;ALB/TAW/BWF/MGD/RRM/ANU - VISTA Appointment data getter ;OCT 12, 2022@10:38
 ;;5.3;Scheduling;**788,814,815,820,823,827**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to ^VA(200 in ICR #10060
 Q
 ; The intention of this rtn is to return a unique set of data from the Appointment
 ;File (409.84) for a specific IEN.
 ;
 ; It is assumed by getting here all business logic and validation has been performed.
 ;
 ; This routine should only be used for retrieving data from the Appointment file.
 ;
SUMMARY(APPTDATA,IEN) ;
 ;Returns a basic set of data for a specific appointment
 ;
 ; Input
 ;  IEN - Specific appointment IEN
 ; Return
 ;  APPTDATA - Array of field names and the data for the field based on the IEN
 ;
 N APPTARY,FN,IENS,SDMSG,DFN,RESOURCEIEN,CLINICIEN,SIEN,OVERBOOK,STIME,ETIME,X
 N DATETIME,NUM,STATPOINTER,CLINICARY,STAT,CLINICDATA,PROV
 K APPTDATA
 S FN=409.84,IENS=IEN_",",OVERBOOK=0
 D GETS^DIQ(FN,IEN,".01;.02;.03;.04;.05;.06;.07;.12;.121;.122;.14;.16;.17;.18;1;3;100","IE","APPTARY","SDMSG") ;SD,814-Added 100 for the EAS Tracking Number
 S APPTDATA("StartTime")=$G(APPTARY(FN,IENS,.01,"E"))
 S APPTDATA("StartTimeFM")=$G(APPTARY(FN,IENS,.01,"I"))
 S STIME=$G(APPTARY(FN,IENS,.01,"I"))
 S APPTDATA("EndTime")=$G(APPTARY(FN,IENS,.02,"E"))
 S ETIME=$G(APPTARY(FN,IENS,.02,"I"))
 S APPTDATA("AppointmentTypeIEN")=$G(APPTARY(FN,IENS,.06,"I"))
 S APPTDATA("LengthOfAppt")=$G(APPTARY(FN,IENS,.18,"E"))
 K APPTARY(FN,IENS,1,"I"),APPTARY(FN,IENS,1,"E")
 I $D(APPTARY(FN,IENS,1)) M APPTDATA("Note")=APPTARY(FN,IENS,1)
 E  S APPTDATA("Note")=""
 S APPTDATA("AppointmentIEN")=IEN
 S DATETIME=$G(APPTARY(FN,IENS,.03,"I"))
 S APPTDATA("CheckIn")=$$FMTE^XLFDT(DATETIME)
 S DATETIME=$G(APPTARY(FN,IENS,.04,"I"))
 S APPTDATA("CheckInEntered")=$$FMTE^XLFDT(DATETIME)
 S DATETIME=$G(APPTARY(FN,IENS,.14,"I"))
 S APPTDATA("CheckOut")=$$FMTE^XLFDT(DATETIME)
 S APPTDATA("EASTrackingNumber")=$G(APPTARY(FN,IENS,100,"I")) ;SD,814-Retrieve EAS Tracking Number
 S APPTDATA("CancelDateTime")=$$FMTE^XLFDT($G(APPTARY(FN,IENS,.12,"I")))
 S APPTDATA("CancelledByUser")=$G(APPTARY(FN,IENS,.121,"E"))
 S APPTDATA("CancellationReason")=$G(APPTARY(FN,IENS,.122,"E"))
 ;
 ;Always send these Resource / Clinic data elements
 S APPTDATA("Clinic","IsOverbook")=0
 S RESOURCEIEN=$G(APPTARY(FN,IENS,.07,"I"))
 S APPTDATA("ResourceIEN")=RESOURCEIEN
 S APPTDATA("Resource","Name")=$G(APPTARY(FN,IENS,.07,"E"))
 S CLINICIEN=$$GET1^DIQ(409.831,RESOURCEIEN,.04,"I")
 S APPTDATA("Resource","ClinicIEN")=CLINICIEN
 D SETSTATUS^SDESGETAPPTWRAP5(.APPTDATA,IEN,CLINICIEN)
 D APPTCLINIC^SDESCLINICDATA(.CLINICDATA,CLINICIEN)
 M APPTDATA("Clinic")=CLINICDATA
 I CLINICIEN D
 .S SIEN=0
 .F  S SIEN=$O(^SC(CLINICIEN,"S",STIME,SIEN)) Q:'SIEN  D
 ..S X=$O(^SC(CLINICIEN,"S",STIME,SIEN,""),-1)
 ..S:X OVERBOOK=$G(^SC(CLINICIEN,"S",STIME,SIEN,X,"OB"))
 I OVERBOOK="O" S APPTDATA("Clinic","IsOverbook")=1
 ;
 S (SIEN,NUM)=0
 F  S SIEN=$O(^SDEC(409.84,IEN,3,SIEN)) Q:'SIEN  D
 .S NUM=NUM+1
 .S STATPOINTER=$$GET1^DIQ(409.843,SIEN_","_IEN_",",.01,"I")
 .S STAT=$$GET1^DIQ(409.842,STATPOINTER,.01,"E")
 .S DATETIME=$$GET1^DIQ(409.843,SIEN_","_IEN_",",1,"E")
 .S APPTDATA("CheckInSteps",NUM,"IEN")=SIEN
 .S APPTDATA("CheckInSteps",NUM,"Status")=$G(STAT)
 .S APPTDATA("CheckInSteps",NUM,"DateTime")=$$FMTE^XLFDT(DATETIME)
 I '$D(APPTDATA("CheckInSteps")) S APPTDATA("CheckInSteps")=""
 ;
 ;Always send these Patient data elements
 S DFN=$G(APPTARY(FN,IENS,.05,"I"))
 S APPTDATA("DFN")=DFN
 S APPTDATA("Patient","EligibilityIEN")=$$GET1^DIQ(2,DFN,.361,"I")
 S APPTDATA("Patient","Name")=$$GET1^DIQ(2,DFN,.01,"E")
 ;
 ; provider data elements
 S PROV=$G(APPTARY(FN,IENS,.16,"I"))
 S APPTDATA("Provider","ID")=PROV
 S APPTDATA("Provider","Name")=$G(APPTARY(FN,IENS,.16,"E"))
 S APPTDATA("Provider","SecId")=$$GET1^DIQ(200,PROV,205.1,"I")
 Q
 ;Returns a basic set of data for a specific appointment with ISO dates
 ;
 ; Input
 ;  IEN - Specific appointment IEN
 ; Return
 ;  APPTDATA - Array of field names and the data for the field based on the IEN
 ;
SUMMARY2(APPTDATA,IEN) ;
 N APPTARY,FN,IENS,SDMSG,DFN,RESOURCEIEN,CLINICIEN,SIEN,OVERBOOK,STIME,ETIME,X,PROV
 N DATETIME,NUM,STATPOINTER,CLINICARY,STAT,CLINICDATA,CIDATETIME,CODATETIME,CIENDATETIME
 K APPTDATA
 S FN=409.84,IENS=IEN_",",OVERBOOK=0
 D GETS^DIQ(FN,IEN,".01;.02;.03;.04;.05;.06;.07;.14;.16;.17;.18;1;2;3;4;100","IE","APPTARY","SDMSG") ;SD,814-Added 100 for the EAS Tracking Number
 S RESOURCEIEN=$G(APPTARY(FN,IENS,.07,"I"))
 S CLINICIEN=$$GET1^DIQ(409.831,RESOURCEIEN,.04,"I")
 S STIME=$G(APPTARY(FN,IENS,.01,"I"))
 S APPTDATA("AppointmentDateTime")=$$FMTISO^SDAMUTDT(STIME,CLINICIEN)
 S APPTDATA("StartTimeFM")=$G(APPTARY(FN,IENS,.01,"I"))
 S ETIME=$G(APPTARY(FN,IENS,.02,"I"))
 S APPTDATA("EndTime")=$$FMTISO^SDAMUTDT(ETIME,CLINICIEN)
 S APPTDATA("AppointmentTypeIEN")=$G(APPTARY(FN,IENS,.06,"I"))
 S APPTDATA("LengthOfAppt")=$G(APPTARY(FN,IENS,.18,"E"))
 K APPTARY(FN,IENS,1,"I"),APPTARY(FN,IENS,1,"E")
 I $D(APPTARY(FN,IENS,1)) M APPTDATA("Note")=APPTARY(FN,IENS,1)
 I '$D(APPTDATA("Note")) S APPTDATA("Note")=""
 S APPTDATA("AppointmentIEN")=IEN
 S CIDATETIME=$G(APPTARY(FN,IENS,.03,"I"))
 S APPTDATA("CheckIn")=$$FMTISO^SDAMUTDT(CIDATETIME,CLINICIEN)
 S CIENDATETIME=$G(APPTARY(FN,IENS,.04,"I"))
 S APPTDATA("CheckInEntered")=$$FMTISO^SDAMUTDT(CIENDATETIME)
 S CODATETIME=$G(APPTARY(FN,IENS,.14,"I"))
 S APPTDATA("CheckOut")=$$FMTISO^SDAMUTDT(CODATETIME,CLINICIEN)
 D SETSTATUS^SDESGETAPPTWRAP5(.APPTDATA,IEN,CLINICIEN)
 S APPTDATA("EASTrackingNumber")=$G(APPTARY(FN,IENS,100,"I")) ;SD,814-Retrieve EAS Tracking Number
 ;
 ; patient comments
 I $D(^SDEC(409.84,IEN,6,0)) D GETPATCOMMENTS(.APPTDATA,IEN)
 ;
 ; Resource / Clinic data elements
 S APPTDATA("ResourceIEN")=RESOURCEIEN
 I RESOURCEIEN D
 .S APPTDATA("Resource","Name")=$G(APPTARY(FN,IENS,.07,"E"))
 .S APPTDATA("Resource","ClinicIEN")=CLINICIEN
 I '$D(APPTDATA("Resource")) S APPTDATA("Resource",1)=""
 I CLINICIEN D
 .D APPTCLINIC^SDESCLINICDATA(.CLINICDATA,CLINICIEN)
 .M APPTDATA("Clinic")=CLINICDATA
 .S APPTDATA("Clinic","IsOverbook")=0
 .S SIEN=0
 .F  S SIEN=$O(^SC(CLINICIEN,"S",STIME,SIEN)) Q:'SIEN  D
 ..S X=$O(^SC(CLINICIEN,"S",STIME,SIEN,""),-1)
 ..S:X OVERBOOK=$G(^SC(CLINICIEN,"S",STIME,SIEN,X,"OB"))
 I OVERBOOK="O",$D(APPTDATA("Clinic")) S APPTDATA("Clinic","IsOverbook")=1
 I '$D(APPTDATA("Clinic")) S APPTDATA("Clinic",1)=""
 ;
 S (SIEN,NUM)=0
 F  S SIEN=$O(^SDEC(409.84,IEN,3,SIEN)) Q:'SIEN  D
 .S NUM=NUM+1
 .S STAT=$$GET1^DIQ(409.843,SIEN_","_IEN_",",.01,"E")
 .S DATETIME=$$GET1^DIQ(409.843,SIEN_","_IEN_",",1,"I")
 .S APPTDATA("CheckInSteps",NUM,"IEN")=SIEN
 .S APPTDATA("CheckInSteps",NUM,"Status")=STAT
 .S APPTDATA("CheckInSteps",NUM,"DateTime")=$$FMTISO^SDAMUTDT(DATETIME)
 I '$D(APPTDATA("CheckInSteps")) S APPTDATA("CheckInSteps",1)=""
 ;
 ;Always send these Patient data elements
 S DFN=$G(APPTARY(FN,IENS,.05,"I"))
 S APPTDATA("DFN")=DFN
 S APPTDATA("Patient","EligibilityIEN")=$$GET1^DIQ(2,DFN,.361,"I")
 S APPTDATA("Patient","Name")=$$GET1^DIQ(2,DFN,.01,"E")
 ; provider data elements
 S PROV=$G(APPTARY(FN,IENS,.16,"I"))
 I PROV D
 .S APPTDATA("Provider","ID")=PROV
 .S APPTDATA("Provider","Name")=$G(APPTARY(FN,IENS,.16,"E"))
 .S APPTDATA("Provider","SecId")=$$GET1^DIQ(200,PROV,205.1,"I")
 I '$D(APPTDATA("Provider")) S APPTDATA("Provider",1)=""
 S APPTDATA("VVSApptID")=$G(APPTARY(FN,IENS,2,"I")) ;This field added as part of VSE2857
 Q
GETPATCOMMENTS(APPTDATA,IEN) ;
 N SUBIEN,COUNT
 S SUBIEN=0,COUNT=0
 F  S SUBIEN=$O(^SDEC(409.84,IEN,6,SUBIEN)) Q:'SUBIEN  D
 .S COUNT=COUNT+1
 .S APPTDATA("PatientComments",COUNT)=$$GET1^DIQ(409.846,SUBIEN_","_IEN_",",.01,"E")
 Q
 ;
