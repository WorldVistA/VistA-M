SDESGETAPPTWRAP3 ;ALB/RRM,MGD - RPC WRAPPER FOR VIEWING AN APPOINTMENT CONTINUATION;July 29, 2022
 ;;5.3;Scheduling;**815,823,824,825**;Aug 13, 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;
 Q  ;No Direct Call
 ;
GETAPPT40984(SDALLAPPTARY,DFN,BDATE,EDATE,SDAPPTIEN,RECNUM,SDVIEWAPPTBY) ;Traverse the "APTDT" cross reference in File #409.84 to retrieve appointments for a given datetime range
 N APPTIEN,APPTDATA,CLINICIEN,EXIST,STARTTIME,APPTSTATUS,ENDTIME,SDAPPTIENARY,SDAPPTNUM
 D BUILDAPPTARY(.SDAPPTIENARY,DFN,BDATE,EDATE)
 S EXIST=0
 S APPTIEN="" F  S APPTIEN=$O(SDAPPTIENARY(APPTIEN)) Q:APPTIEN=""!(EXIST)  D
 . S SDAPPTNUM="" F  S SDAPPTNUM=$O(SDAPPTIENARY(APPTIEN,SDAPPTNUM)) Q:SDAPPTNUM=""!(EXIST)  D
 . . K SDMSG,APPTDATA D SUMMARY2^SDESAPPTDATA(.APPTDATA,APPTIEN)
 . . I $G(SDVIEWAPPTBY)=1,$G(APPTDATA("Resource","ClinicIEN"))'=$G(SDCLINICIEN)  Q  ;if view appointment by Clinic IEN, we are only interested of those Clinic IEN passed in
 . . I $G(SDVIEWAPPTBY)=0!($G(SDVIEWAPPTBY)=2) S RECNUM=RECNUM+1
 . . S APPTSTATUS=SDAPPTIENARY(APPTIEN,SDAPPTNUM)
 . . I $D(APPTDATA) D
 . . . ;Build the appointment object as we go along
 . . . I $G(SDVIEWAPPTBY)=0!($G(SDVIEWAPPTBY)=2) D  Q
 . . . . ;while we are here, using the CLINICIEN, retrieve the rest of the appointment
 . . . . S CLINICIEN=$G(APPTDATA("Resource","ClinicIEN"))
 . . . . S STARTTIME=APPTDATA("StartTimeFM")
 . . . . S ENDTIME=$$GET1^DIQ(409.84,APPTIEN,.02,"I")
 . . . . D SETOVERLAIDAPPT(.SDALLAPPTARY,APPTSTATUS,RECNUM)
 . . . . I APPTSTATUS=0 D GETAPPT2(.SDALLAPPTARY,DFN,STARTTIME,ENDTIME) ;retrieve appointments from Appointment Multiple PATIENT File #2
 . . . . I CLINICIEN="",$D(SDALLAPPTARY("Appointment",RECNUM,"Clinic")) S CLINICIEN=SDALLAPPTARY("Appointment",RECNUM,"Clinic"),CLINICIEN=$$FIND1^DIC(44,"","MX",CLINICIEN,"","","ERROR")
 . . . . I CLINICIEN'="" D GETAPPT44(.SDALLAPPTARY,CLINICIEN,STARTTIME,ENDTIME,RECNUM) ;retrieves appointments in File #44
 . . . . I APPTDATA("Status")="" D SETSTATUS(.APPTDATA,APPTIEN,CLINICIEN)
 . . . . K SDALLAPPTARY("Appointment",RECNUM,"Clinic")
 . . . . M SDALLAPPTARY("Appointment",RECNUM)=APPTDATA ;merge File #409.84 last to override some of the duplicates File #2 and File #44
 . . . . D REMOVEDUPLICATE ;remove duplicates as we go along
 . . . I $D(SDAPPTIENARY(APPTIEN,CNTR)) D  Q
 . . . . Q:APPTSTATUS'=SDCLINSTATUS
 . . . . S SDCLINSTATUS=APPTSTATUS
 . . . . I APPTDATA("Status")="" D SETSTATUS(.APPTDATA,APPTIEN,SDCLINICIEN)
 . . . . M SDALLAPPTARY("Appointment",RECNUM)=APPTDATA
 . . . . S EXIST=1
 . . . I SDCLINSTATUS=0,APPTSTATUS=0 D
 . . . . I APPTDATA("Status")="" D SETSTATUS(.APPTDATA,APPTIEN,SDCLINICIEN)
 . . . . M SDALLAPPTARY("Appointment",RECNUM)=APPTDATA ;merge File #409.84 last to override some of the duplicates File #2 and File #44
 . . . . S EXIST=1
 I $O(SDALLAPPTARY("Appointment",""))="" S SDALLAPPTARY("Appointment",1)="" ;if no record found,set the array into a NULL value.
 Q
 ;
GETAPPT2(SDALLAPPTARY,DFN,BDATE,EDATE) ;Traverse the "S" node in Appointment Multiple Patient File #2 to retrieve appointments for a given datetime range
 N APPT,APPDATETIME,SDPATAPPT,SDMSG,ERR,NUM
 S NUM=0
 S APPDATETIME=$$FMADD^XLFDT(BDATE,-1) ;always start the previous datetime in order to get the needed date range
 F  S APPDATETIME=$O(^DPT(DFN,"S",APPDATETIME)) Q:(APPDATETIME="")!(APPDATETIME>EDATE)  D
 . Q:(APPDATETIME<BDATE)
 . I $G(SDVIEWAPPTBY)=1,$$GET1^DIQ(2.98,APPDATETIME_","_DFN_",",.01,"I")'=SDCLINICIEN Q  ;if view appointment by Clinic IEN, we are only interested of those Clinic IEN passed in
 . K SDMSG,ERR,SDPATAPPT,APPT
 . S NUM=NUM+1
 . S APPT=$$GETAPPT^SDESGETPATAPPT(.SDPATAPPT,$G(DFN),APPDATETIME)
 . Q:$D(ERR)
 . K SDPATAPPT("PatientAppt",NUM,"Clinic")
 . K SDPATAPPT("PatientAppt",NUM,"Status")
 . I $G(APPT) M SDALLAPPTARY("Appointment",RECNUM)=SDPATAPPT("PatientAppt",NUM)
 I $O(SDALLAPPTARY("Appointment",""))="" S SDALLAPPTARY("Appointment",1)="" ;if no record found, set the array into a NULL value
 Q
 ;
GETAPPT44(SDALLAPPTARY,SDCLINICIEN,BDATE,EDATE,RECNUM,SDVIEWAPPTBY) ;Traverse the "S" node in HOSPITAL LOCATION File #44 to retrieve appointments for a given datetime range
 N APPTREC,APTDATETIME,CNTR,EXIST,SDIEN,SDAPPT,SDAPPTNO,SDMSG,SDSTDT,SDCLIN,FOUND,SDCLINDFN,SDDFNARY,SDTMPARY,SDCLINSTATUS
 S EXIST=0
 D BUILDCLINAPPTARY(.SDDFNARY,SDCLINICIEN,BDATE,EDATE)
 S SDCLINDFN="" F  S SDCLINDFN=$O(SDDFNARY(SDCLINDFN)) Q:SDCLINDFN=""!(EXIST)  D
 . S APTDATETIME="" F  S APTDATETIME=$O(SDDFNARY(SDCLINDFN,APTDATETIME)) Q:APTDATETIME=""!(EXIST)  D
 . . S CNTR="" F  S CNTR=$O(SDDFNARY(SDCLINDFN,APTDATETIME,CNTR)) Q:CNTR=""  D
 . . . S SDIEN=$P(SDDFNARY(SDCLINDFN,APTDATETIME,CNTR),"^",2)
 . . . S SDAPPTNO=$P(SDIEN,",")
 . . . S SDSTDT=$P(SDIEN,",",2)
 . . . S SDCLIN=$P(SDIEN,",",3)
 . . . I $G(SDVIEWAPPTBY)=0!($G(SDVIEWAPPTBY)=2),$D(SDDFNARY(DFN,APTDATETIME,SDAPPTNUM)) S EXIST=1
 . . . I $G(SDVIEWAPPTBY)=1 S RECNUM=RECNUM+1,DFN=SDCLINDFN
 . . . Q:'$D(^DPT(SDCLINDFN,"S",SDSTDT,0))
 . . . Q:$G(DFN)'=SDCLINDFN
 . . . K SDMSG,SDAPPT,APPTREC D GETS^DIQ(44.003,SDIEN,"**","IE","SDAPPT","SDMSG")
 . . . Q:$D(SDMSG)
 . . . D BLDREC^SDESGETCLINAPPT
 . . . I $D(APPTREC) D
 . . . . ;Build the appointment object as we go along
 . . . . S APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",SDCLINDFN,"ICN")=$$GETPATICN^SDESINPUTVALUTL(DFN)
 . . . . M SDTMPARY("Patient")=APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",SDCLINDFN)
 . . . . K APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO,"Patient",SDCLINDFN)
 . . . . M SDALLAPPTARY("Appointment",RECNUM)=APPTREC("ClinicApptDate",SDSTDT,"ClinicApptNumber",SDAPPTNO)
 . . . . M SDALLAPPTARY("Appointment",RECNUM)=SDTMPARY K SDTMPARY
 . . . . I $G(SDVIEWAPPTBY)=1 D
 . . . . . I $D(SDDFNARY(SDCLINDFN,APTDATETIME,CNTR+1)) S SDCLINSTATUS=-1 ;Current Appt is cancelled and there is another APPT
 . . . . . I '$D(SDDFNARY(SDCLINDFN,APTDATETIME,CNTR+1)) S SDCLINSTATUS=0 ;Current Appt is either cancelled/not and no other APPT
 . . . . . D GETAPPT40984(.SDALLAPPTARY,SDCLINDFN,SDSTDT,SDSTDT,,RECNUM,SDVIEWAPPTBY) ;retrieve appointments from Appointment Multiple PATIENT File #2
 . . . . . D SETOVERLAIDAPPT(.SDALLAPPTARY,SDCLINSTATUS,RECNUM)
 . . . . . I SDCLINSTATUS=0 D GETAPPT2(.SDALLAPPTARY,SDCLINDFN,SDSTDT,SDSTDT) ;retrieve appointments from Appointment Multiple PATIENT File #2
 . . . . . D REMOVEDUPLICATE ;remove duplicates as we go along
 I $O(SDALLAPPTARY("Appointment",""))="" S SDALLAPPTARY("Appointment",1)="" ;if no record found, set the array into a NULL value
 Q
 ;
BUILDAPPTARY(SDAPPTIENARY,DFN,BDATE,EDATE) ;Retrieve all appointment IENs for a given DFN within the given date range
 N APPTIEN,SDAPPTNO,OLDAPPTIEN,SDBEGINDX
 S OLDAPPTIEN=""
 S SDBEGINDX=$$FMADD^XLFDT(BDATE,-1) ;Reset BDATE to immediately before actual start time
 S SDBEGINDX=0 F  S SDBEGINDX=$O(^SDEC(409.84,"APTDT",DFN,SDBEGINDX)) Q:SDBEGINDX=""!(SDBEGINDX>EDATE)  D
 . Q:SDBEGINDX<BDATE
 . S SDAPPTNO=0
 . S APPTIEN="" F  S APPTIEN=$O(^SDEC(409.84,"APTDT",DFN,SDBEGINDX,APPTIEN)) Q:APPTIEN=""  D
 . . I OLDAPPTIEN'=APPTIEN D
 . . . I $G(SDVIEWAPPTBY)=2,APPTIEN'=SDAPPTIEN Q
 . . . S SDAPPTNO=SDAPPTNO+1
 . . . S APPTSTATUS=$$SDEXPST(.SDRET,DFN,SDBEGINDX,APPTIEN)
 . . . S SDAPPTIENARY(APPTIEN,SDAPPTNO)=APPTSTATUS
 . . S OLDAPPTIEN=APPTIEN
 Q
 ;
BUILDCLINAPPTARY(SDDFNARY,SDCLINICIEN,BDATE,EDATE) ;Retrieve all appointments for a given clinic within the given date range
 N APPDATETIME,SDCLINDFN,SDAPPTCLNO,CLINAPPTSTAT,CNTR,OLDDFN
 K SDDFNARY
 S CNTR=0,OLDDFN=""
 S APPDATETIME=$$FMADD^XLFDT(BDATE,-1) ;always start the previous datetime in order to get the needed date range
 F  S APPDATETIME=$O(^SC(SDCLINICIEN,"S",APPDATETIME)) Q:APPDATETIME=""!(APPDATETIME>EDATE)  D
 . Q:APPDATETIME<BDATE
 . S SDAPPTCLNO="" F  S SDAPPTCLNO=$O(^SC(SDCLINICIEN,"S",APPDATETIME,1,SDAPPTCLNO)) Q:SDAPPTCLNO=""  D
 . . I '$D(^SC(SDCLINICIEN,"S",APPDATETIME,1,SDAPPTCLNO,0)) Q
 . . S SDCLINDFN=$$GET1^DIQ(44.003,SDAPPTCLNO_","_APPDATETIME_","_SDCLINICIEN_",",.01,"I")
 . . I ($G(SDVIEWAPPTBY)=0!($G(SDVIEWAPPTBY)=2)),SDCLINDFN'=DFN Q  ;if view appointment by DFN, we are only interested of those DFN's passed in
 . . I $D(SDDFNARY(SDCLINDFN,APPDATETIME)) S CNTR=$O(SDDFNARY(SDCLINDFN,APPDATETIME,""),-1)
 . . I '$D(SDDFNARY(SDCLINDFN,APPDATETIME))  S CNTR=0
 . . S CLINAPPTSTAT=$$GET1^DIQ(44.003,SDAPPTCLNO_","_APPDATETIME_","_SDCLINICIEN_",",310,"I")
 . . S CNTR=CNTR+1
 . . S SDDFNARY(SDCLINDFN,APPDATETIME,CNTR)=CLINAPPTSTAT_"^"_SDAPPTCLNO_","_APPDATETIME_","_SDCLINICIEN_","
 Q
 ;
SETOVERLAIDAPPT(SDALLAPPTARY,STATUS,RECNUM) ;set this subscript if the Appointment is cancelled and there is another APPT
 ;This is due to the record does not exist in the Appointment Multiple File #2.98 anymore
 ;This is per BJ to add a boolean subscript to identify the data no longer exist
 S SDALLAPPTARY("Appointment",RECNUM,"OverLaidAppointmentData")=$S($G(STATUS)=-1:"YES",1:"NO")
 I STATUS=-1 D SETAPPTMULT2NULL(.SDALLAPPTARY,RECNUM) ;Set all the fields of Appointment Multiple File #2.98 to NULL
 Q
 ;
SETSTATUS(APPTDATA,APPTIEN,CLINICIEN) ;
 N SDAPPTNODE
 S SDAPPTNODE=$G(^SDEC(409.84,APPTIEN,0))
 S APPTDATA("Status")=$$APPTSTS^SDEC50(APPTIEN,SDAPPTNODE,CLINICIEN)
 Q
 ;
SDEXPST(SDRET,DFN,ADT,SDAPPTIEN) ;
 N SDAPPT,SDRTN,SDNEXTIEN,SDCAN
 S SDRTN="" ; Appt can be expanded
 S SDAPPT="",ADT=+ADT
 F  S SDAPPT=$O(^SDEC(409.84,"APTDT",DFN,ADT,SDAPPT)) Q:'SDAPPT  D  Q:SDRTN'=""
 . Q:SDAPPT'=SDAPPTIEN
 . S SDCAN=($$GET1^DIQ(409.84,SDAPPT,.12,"I")'="")
 . S SDNEXTIEN=$O(^SDEC(409.84,"APTDT",DFN,ADT,SDAPPT))
 . ; Current Appt is cancelled and there is another APPT
 . I SDCAN,SDNEXTIEN S SDRTN=-1 Q
 . ; Current Appt is cancelled & no other Appt
 . I SDCAN,'SDNEXTIEN S SDRTN=0 Q
 . ; Current Appt is NOT cancelled so there can't be other Appt for same Date/Time
 . I 'SDCAN,'SDNEXTIEN S SDRTN=0 Q
 S SDRET=SDRTN
 Q SDRET
 ;
REMOVEDUPLICATE ;
 K SDALLAPPTARY("Appointment",RECNUM,"DateApptMade")
 K SDALLAPPTARY("Appointment",RECNUM,"EKGTIME")
 K SDALLAPPTARY("Appointment",RECNUM,"LABTIME")
 K SDALLAPPTARY("Appointment",RECNUM,"AppointmentLength")
 K SDALLAPPTARY("Appointment",RECNUM,"ApptCancelled")
 K SDALLAPPTARY("Appointment",RECNUM,"CheckedOutDate")
 K SDALLAPPTARY("Appointment",RECNUM,"CheckedIn")
 K SDALLAPPTARY("Appointment",RECNUM,"TelephoneOfClinic")
 K SDALLAPPTARY("Appointment",RECNUM,"XRAYTIME")
 K SDALLAPPTARY("Appointment",RECNUM,"Patient","NAME")
 K SDALLAPPTARY("Appointment",RECNUM,"DFN")
 K SDALLAPPTARY("Appointment",RECNUM,"COLLATERAL")
 K SDALLAPPTARY("Appointment",RECNUM,"Patient","EligbilityOfVisit")
 K SDALLAPPTARY("Appointment",RECNUM,"AppointmentTime")
 Q
 ;
SETAPPTMULT2NULL(SDALLAPPTARY,RECNUM) ;Set all the fields of Appointment Multiple File #2.98 to NULL
 ;This is per BJ and Lori as of 04/27/2022 to set all fields to NULL if the appointment is an overlaid appointment data
 S SDPATAPPT("PatientAppt",RECNUM,"RealAppointment")=""
 S SDPATAPPT("PatientAppt",RECNUM,"LabDateTime")=""
 S SDPATAPPT("PatientAppt",RECNUM,"XrayDateTime")=""
 S SDPATAPPT("PatientAppt",RECNUM,"EkgDateTime")=""
 S SDPATAPPT("PatientAppt",RECNUM,"RoutingSlipPrinted")=""
 S SDPATAPPT("PatientAppt",RECNUM,"RoutingSlipPrintDate")=""
 S SDPATAPPT("PatientAppt",RECNUM,"PurposeOfVisit")=""
 S SDPATAPPT("PatientAppt",RECNUM,"AppointmentType")=""
 S SDPATAPPT("PatientAppt",RECNUM,"SpecialSurveyDisposition")=""
 S SDPATAPPT("PatientAppt",RECNUM,"NumberOfCollateralSeen")=""
 S SDPATAPPT("PatientAppt",RECNUM,"AutoRebookedApptDateTime")=""
 S SDPATAPPT("PatientAppt",RECNUM,"CollateralVisit")=""
 S SDPATAPPT("PatientAppt",RECNUM,"NoShowCancelledBy")=""
 S SDPATAPPT("PatientAppt",RECNUM,"NoShowCancelDateTime")=""
 S SDPATAPPT("PatientAppt",RECNUM,"CancellationReason")=""
 S SDPATAPPT("PatientAppt",RECNUM,"CancellationRemarks")=""
 S SDPATAPPT("PatientAppt",RECNUM,"ApptCancelled")=""
 S SDPATAPPT("PatientAppt",RECNUM,"DataEntryClerk")=""
 S SDPATAPPT("PatientAppt",RECNUM,"DateApptMade")=""
 S SDPATAPPT("PatientAppt",RECNUM,"OutpatientEncounter")=""
 S SDPATAPPT("PatientAppt",RECNUM,"EncounterFormsPrinted")=""
 S SDPATAPPT("PatientAppt",RECNUM,"EncounterFormsAsAddOns")=""
 S SDPATAPPT("PatientAppt",RECNUM,"EncounterConversionStatus")=""
 S SDPATAPPT("PatientAppt",RECNUM,"AppointmentTypeSubCategory")=""
 S SDPATAPPT("PatientAppt",RECNUM,"SchedulingRequestType")=""
 S SDPATAPPT("PatientAppt",RECNUM,"NextAvaApptIndicator")=""
 S SDPATAPPT("PatientAppt",RECNUM,"DesiredDateOfAppointment")=""
 S SDPATAPPT("PatientAppt",RECNUM,"FollowUpVisit")=""
 S SDPATAPPT("PatientAppt",RECNUM,"SchedulingApplication")=""
 S SDPATAPPT("PatientAppt",RECNUM,"SchedulerName")=""
 S SDPATAPPT("PatientAppt",RECNUM,"CurrentStatus")=""
 M SDALLAPPTARY("Appointment",RECNUM)=SDPATAPPT("PatientAppt",RECNUM)
 Q
 ;
