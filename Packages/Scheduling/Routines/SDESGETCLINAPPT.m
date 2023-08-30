SDESGETCLINAPPT ;ALB/LAB - VISTA SCHEDULING READ CLINIC APPOINTMENT ;FEB 21,2023@15:01
 ;;5.3;Scheduling;**805,838**;Aug 13, 1993;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ;
GETAPPOINTMENTS(SDECY,SDCLIN,SDSTDTTM,SDENDDTTM) ;get all appointments for a given clinic for a given datetime range
 ; ALERT!  This tag should NOT be called directly from outside source.  This RPC will be called via an EAS wrapper/layer.
 ; INPUT:
 ; SDCLIN - Pointer to HOSPITAL LOCATION (#44) FILE
 ; SDDTTM - start appointment date time in ISO8601 Time format
 ; SDENDDTTM  - end appoitnment date time in ISO8601 Time fomat
 N APPTREC,SDAPPT,SDSTDT,SDAPPT,SDAPPTNO,SDMSG,SDIEN,NUM,ERR,FOUND,SDENDDT
 K SDECY
 S NUM=0,FOUND=0
 D VALIDATE ;basic validation just to make sure required fields have been sent
 D:+NUM ERRLOG^SDESJSON(.SDECY,NUM)
 I '+NUM D
 . D CONVERTINPDTS
 . Q:+NUM
 . F  S SDSTDT=$O(^SC(SDCLIN,"S",SDSTDT)) Q:(SDSTDT="")!(SDSTDT>SDENDDT)  D
 . . S SDAPPTNO=0
 . . F  S SDAPPTNO=$O(^SC(SDCLIN,"S",SDSTDT,1,SDAPPTNO)) Q:SDAPPTNO=""  D
 . . . K SDAPPT,SDMSG
 . . . S SDIEN=SDAPPTNO_","_SDSTDT_","_SDCLIN_","
 . . . D GETS^DIQ(44.003,SDIEN,"**","IE","SDAPPT","SDMSG")
 . . . D BLDREC
 I +NUM D
 . S FOUND=1
 . D ERRLOG^SDESJSON(.APPTREC,NUM)
 S:'FOUND APPTREC("ClinicApptDate")=""
 D BUILDER
 Q
 ;
VALIDATE ;Validate required fields are sent
 I ('+$G(SDCLIN)) S NUM=18 Q
 I ('+$G(SDSTDTTM)) S NUM=25 Q
 I ('+$G(SDENDDTTM)) S NUM=26 Q
 Q
 ;
CONVERTINPDTS ;Convert INPUT dates from ISO8601 to Fileman
 S SDSTDT=$$ISOTFM^SDAMUTDT(SDSTDTTM,SDCLIN) ;Need to change this to conversion
 S:SDSTDT=-1 NUM=27
 Q:NUM
 I $L(SDSTDT,".")=1 S SDSTDT=SDSTDT_.0001
 S SDSTDT=$O(^SC(SDCLIN,"S",SDSTDT),-1)
 S SDENDDT=$$ISOTFM^SDAMUTDT(SDENDDTTM,SDCLIN) ;need to convert this from ISO8601 based on clinic time zone
 S:SDENDDT=-1 NUM=28
 Q:NUM
 I $L(SDENDDT,".")=1 S SDENDDT=SDENDDT_.24
 Q
 ;
BUILDER ;
 D ENCODE^XLFJSON("APPTREC","SDECY","ERR")
 Q
 ;
BLDREC ; build an appointment record 
 N DFN
 S FOUND=1
 S DFN=SDAPPT(44.003,SDIEN,.01,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"AppointmentTime")=$$FMTISO^SDAMUTDT(SDSTDT,SDCLIN)
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"DFN")=DFN
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"NAME")=SDAPPT(44.003,SDIEN,.01,"E")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"SSN")=SDAPPT(44.003,SDIEN,.09,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"Last4")=SDAPPT(44.003,SDIEN,.099,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"Street")=SDAPPT(44.003,SDIEN,.11,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"AppointmentLength")=SDAPPT(44.003,SDIEN,1,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"EnrollmentCode")=SDAPPT(44.003,SDIEN,1.6,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"EnrollmentDate")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,1.7,"I"))
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"XRAY")=SDAPPT(44.003,SDIEN,2,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"OtherTests")=SDAPPT(44.003,SDIEN,3,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"WardLocation")=SDAPPT(44.003,SDIEN,4,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Status")=SDAPPT(44.003,SDIEN,5,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"OtherTravel")=SDAPPT(44.003,SDIEN,6,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"DataEntryClerk")=SDAPPT(44.003,SDIEN,7,"E")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"DateAppointmentMade")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,8,"I"))
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"OverbookFlag")=SDAPPT(44.003,SDIEN,9,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"PriorXRayResults")=SDAPPT(44.003,SDIEN,10,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"CurrentEligibilityCode")=SDAPPT(44.003,SDIEN,10.5,"E")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"COLLATERAL")=SDAPPT(44.003,SDIEN,11,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"LABTIME")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,12,"I"))
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"XRAYTIME")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,13,"I"))
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"EKGTIME")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,14,"I"))
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",DFN,"EligibilityOfVisit")=SDAPPT(44.003,SDIEN,30,"E")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"ParentRecordRequest")=SDAPPT(44.003,SDIEN,200,"E")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"CheckInUser")=SDAPPT(44.003,SDIEN,302,"E")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"CheckedOutDate")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,303,"I"),SDCLIN)
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"CheckOutUser")=SDAPPT(44.003,SDIEN,304,"E")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"CheckInEntered")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,305,"I"))
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"CheckOutEntered")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,306,"I"))
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"CheckedIn")=$$FMTISO^SDAMUTDT(SDAPPT(44.003,SDIEN,309,"I"),SDCLIN)
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"AppointmentCancelled")=SDAPPT(44.003,SDIEN,310,"E")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"VeteranVideoCallURL")=SDAPPT(44.003,SDIEN,400,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"ConsultLink")=SDAPPT(44.003,SDIEN,688,"I")
 S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"DuplicateApptSameDay")=SDAPPT(44.003,SDIEN,999,"I")
 Q
 ;
