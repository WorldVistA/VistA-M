SDES2BLDAPPT44 ;ALB/LAB,TJB,LAB,JAS,JDJ,JHC - VISTA SCHEDULING BUILDING APPT OBJECT FOR CLINIC ;OCT 24, 2025
 ;;5.3;Scheduling;**871,877,880,887,895,922**;Aug 13, 1993;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
GET44INFO(APPTOBJ,CLINIEN,RECCNT) ;
 N CLINIENS,ARRAY44
 S CLINIENS=CLINIEN_","
 D GETS^DIQ(44,CLINIENS,".01;3.5;8;10;20;21;60;62;63;99;99.1;200;2500;2502;2503","IE","ARRAY44","SDMSG")
 S APPTOBJ("Appointment",RECCNT,"Clinic","CreditStopCodeAMIS")=$$GET1^DIQ(40.7,$G(ARRAY44(44,CLINIENS,2503,"I")),1,"I")
 S APPTOBJ("Appointment",RECCNT,"Clinic","CreditStopCodeName")=$G(ARRAY44(44,CLINIENS,2503,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","DisplayClinicAppt")=$G(ARRAY44(44,CLINIENS,62,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","Division")=$G(ARRAY44(44,CLINIENS,3.5,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","ECheckinAllowed")=$G(ARRAY44(44,CLINIENS,20,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","Name")=$G(ARRAY44(44,CLINIENS,.01,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","NonCountClinic")=$S($G(ARRAY44(44,CLINIENS,2502,"E"))="YES":1,1:0)
 S APPTOBJ("Appointment",RECCNT,"Clinic","PatientFriendlyName")=$G(ARRAY44(44,CLINIENS,60,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","PbspID")=$G(ARRAY44(44,CLINIENS,200,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","PhysicalLocation")=$G(ARRAY44(44,CLINIENS,10,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","PreCheckinAllowed")=$G(ARRAY44(44,CLINIENS,21,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","StopCodeAMIS")=$$GET1^DIQ(40.7,$G(ARRAY44(44,CLINIENS,8,"I")),1,"I")
 S APPTOBJ("Appointment",RECCNT,"Clinic","StopCodeName")=$G(ARRAY44(44,CLINIENS,8,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","Telephone")=$G(ARRAY44(44,CLINIENS,99,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","TelephoneExtension")=$G(ARRAY44(44,CLINIENS,99.1,"E"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","StationNumber")=$$STATIONNUMBER^SDESUTIL($G(CLINIEN))
 S APPTOBJ("Appointment",RECCNT,"Clinic","ProhibitedClinic")=$S($G(ARRAY44(44,CLINIENS,2500,"E"))="YES":1,1:0)
 S APPTOBJ("Appointment",RECCNT,"Clinic","VeteranSelfCancel")=$G(ARRAY44(44,CLINIENS,63,"E"))
 D GETTIMEZONEINFO(.APPTOBJ,CLINIENS,RECCNT,.ARRAY44)
 Q
 ;
GETTIMEZONEINFO(APPTOBJ,CLINIENA,RECCNT,ARRAY44) ;
 N DIVISION,INSTITUTION,TIMEZONEIEN,TIMEZONELOOP,TIMEZONECOUNT,TIMEZONEIEN,TIMEZONEDATA,TZIENS
 S DIVISION=$G(ARRAY44(44,CLINIENS,3.5,"I"))
 S INSTITUTION=$$GET1^DIQ(40.8,DIVISION,.07,"I")
 S TIMEZONEIEN=$$GET1^DIQ(4,INSTITUTION,800,"I")
 I TIMEZONEIEN="" D BLANKTIMEZONE(.APPTOBJ,RECCNT) Q
 S APPTOBJ("Appointment",RECCNT,"Clinic","TimeZone")=$$GET1^DIQ(4,INSTITUTION,800,"E")
 S APPTOBJ("Appointment",RECCNT,"Clinic","TimeZoneException")=$$GET1^DIQ(4,INSTITUTION,802,"E")
 S (TIMEZONELOOP,TIMEZONECOUNT)=0 F  S TIMEZONELOOP=$O(^DIT(1.71,TIMEZONEIEN,1,TIMEZONELOOP)) Q:'TIMEZONELOOP  D
 .S TZIENS=TIMEZONELOOP_","_TIMEZONEIEN_","
 .D GETS^DIQ(1.711,TZIENS,"**","IE","TIMEZONEDATA")
 .S TIMEZONECOUNT=TIMEZONECOUNT+1
 .S APPTOBJ("Appointment",RECCNT,"Clinic","TimeZoneDetails",TIMEZONECOUNT,"TimeFrame")=$G(TIMEZONEDATA(1.711,TZIENS,.01,"E"))
 .S APPTOBJ("Appointment",RECCNT,"Clinic","TimeZoneDetails",TIMEZONECOUNT,"Offset")=$G(TIMEZONEDATA(1.711,TZIENS,.02,"E"))
 .S APPTOBJ("Appointment",RECCNT,"Clinic","TimeZoneDetails",TIMEZONECOUNT,"TimeZoneCode")=$G(TIMEZONEDATA(1.711,TZIENS,.03,"E"))
 Q
 ;
BLANKTIMEZONE(APPTOBJ,RECCNT) ;
 S APPTOBJ("Appointment",RECCNT,"Clinic","TimeZone")=""
 S APPTOBJ("Appointment",RECCNT,"Clinic","TimeZoneException")=""
 S APPTOBJ("Appointment",RECCNT,"Clinic","TimeZoneDetails",1)=""
 Q
 ;
GET44003INFO(APPTOBJ,CLINIEN,SDIEN,RECCNT) ; Build appointment object for HOSPITAL LOCATION appointemnt multiple.
 N ARRAY44003,SDMSG
 D GETS^DIQ(44.003,SDIEN,"1.6;1.7;2;3;4;6;9;10;10.5;30;200;302;304;306;310;400;688;999","IE","ARRAY44003","SDMSG")
 S APPTOBJ("Appointment",RECCNT,"AppointmentCancelled")=$G(ARRAY44003(44.003,SDIEN,310,"E"))
 S APPTOBJ("Appointment",RECCNT,"CheckInUser")=$G(ARRAY44003(44.003,SDIEN,302,"E"))
 S APPTOBJ("Appointment",RECCNT,"CheckOutEntered")=$$FMTISO^SDAMUTDT(ARRAY44003(44.003,SDIEN,306,"I"))
 S APPTOBJ("Appointment",RECCNT,"CheckOutUser")=$G(ARRAY44003(44.003,SDIEN,304,"E"))
 S APPTOBJ("Appointment",RECCNT,"ConsultLink")=$G(ARRAY44003(44.003,SDIEN,688,"I"))
 S APPTOBJ("Appointment",RECCNT,"DuplicateApptSameDay")=$G(ARRAY44003(44.003,SDIEN,999,"I"))
 S APPTOBJ("Appointment",RECCNT,"OtherTests")=$G(ARRAY44003(44.003,SDIEN,3,"I"))
 S APPTOBJ("Appointment",RECCNT,"OtherTravel")=$G(ARRAY44003(44.003,SDIEN,6,"I"))
 S APPTOBJ("Appointment",RECCNT,"OverbookFlag")=$G(ARRAY44003(44.003,SDIEN,9,"I"))
 S APPTOBJ("Appointment",RECCNT,"ParentRecordRequest")=$G(ARRAY44003(44.003,SDIEN,200,"E"))
 S APPTOBJ("Appointment",RECCNT,"Patient","CurrentEligibilityCode")=$G(ARRAY44003(44.003,SDIEN,10.5,"E"))
 S APPTOBJ("Appointment",RECCNT,"Patient","EligibilityOfVisit")=$G(ARRAY44003(44.003,SDIEN,30,"E"))
 S APPTOBJ("Appointment",RECCNT,"Patient","EnrollmentCode")=$G(ARRAY44003(44.003,SDIEN,1.6,"I"))
 S APPTOBJ("Appointment",RECCNT,"Patient","EnrollmentDate")=$$FMTISO^SDAMUTDT($G(ARRAY44003(44.003,SDIEN,1.7,"I")))
 S APPTOBJ("Appointment",RECCNT,"PriorXRayResults")=$G(ARRAY44003(44.003,SDIEN,10,"I"))
 S APPTOBJ("Appointment",RECCNT,"VeteranVideoCallURL")=$G(ARRAY44003(44.003,SDIEN,400,"I"))
 S APPTOBJ("Appointment",RECCNT,"WardLocation")=$G(ARRAY44003(44.003,SDIEN,4,"I"))
 S APPTOBJ("Appointment",RECCNT,"XRAY")=$G(ARRAY44003(44.003,SDIEN,2,"I"))
 S APPTOBJ("Appointment",RECCNT,"Clinic","IsOverbook")=$S($G(ARRAY44003(44.003,SDIEN,9,"I"))="O":1,1:0)
 Q
 ;
BLANK44003INFO(APPTOBJ,RECCNT) ;
 ;If Appointment multiple for the hospital location is not pressent, send blanks
 S APPTOBJ("Appointment",RECCNT,"AppointmentCancelled")=""
 S APPTOBJ("Appointment",RECCNT,"CheckInUser")=""
 S APPTOBJ("Appointment",RECCNT,"CheckOutEntered")=""
 S APPTOBJ("Appointment",RECCNT,"CheckOutUser")=""
 S APPTOBJ("Appointment",RECCNT,"ConsultLink")=""
 S APPTOBJ("Appointment",RECCNT,"DuplicateApptSameDay")=""
 S APPTOBJ("Appointment",RECCNT,"OtherTests")=""
 S APPTOBJ("Appointment",RECCNT,"OtherTravel")=""
 S APPTOBJ("Appointment",RECCNT,"OverbookFlag")=""
 S APPTOBJ("Appointment",RECCNT,"ParentRecordRequest")=""
 S APPTOBJ("Appointment",RECCNT,"Patient","CurrentEligibilityCode")=""
 S APPTOBJ("Appointment",RECCNT,"Patient","EligibilityOfVisit")=""
 S APPTOBJ("Appointment",RECCNT,"Patient","EnrollmentCode")=""
 S APPTOBJ("Appointment",RECCNT,"Patient","EnrollmentDate")=""
 S APPTOBJ("Appointment",RECCNT,"PriorXRayResults")=""
 S APPTOBJ("Appointment",RECCNT,"VeteranVideoCallURL")=""
 S APPTOBJ("Appointment",RECCNT,"WardLocation")=""
 S APPTOBJ("Appointment",RECCNT,"XRAY")=""
 S APPTOBJ("Appointment",RECCNT,"Clinic","IsOverbook")=""
 Q
 ;
