SDESGETAPPTWRAP ;ALB/RRM - RPC WRAPPER FOR VIEWING AN APPOINTMENT ;APR 12, 2022@13:47
 ;;5.3;Scheduling;**814**;Aug 13, 1993;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;
 Q  ;No Direct Call
 ;
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
 ;
 ;This is the entry point to retrieve appointments from (not in particular order):
 ; - HOSPITAL LOCATION File #44
 ; - PATIENT File #2, and
 ; - SDEC APPOINTMENT File #409.84
 ;
 ; Called from the following RPC:
 ;   - SDES GET APPTS BY CLINIC #44
 ;   - SDES GET APPTS BY DFN #2
GETAPPTS(RETURNJSON,SDPOINTERIEN,SDBEGDATE,SDENDDATE) ;
 ;
 ; Input:
 ;    SDPOINTERIEN  [Required] = This can be a patient's DFN from PATIENT File #2 or the Internal Entry Number (IEN) from HOSPITAL LOCATION FILE #44.
 ;    SDBEGDATE     [Required] = The beginning date/time in ISO8601 Time Format for the search.
 ;    SDENDDATE     [Required] = The ending date/time in ISO8601 Time Format for the search.
 ;
 ; Output:
 ;    RETURNJSON = Returns fields from the (not in particular order) HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 ;                 in JSON format. JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURNERROR ;temp data storage for input validation error
 N SDAPPT40984        ;temp data storage for File #409.84
 N SDAPPT44           ;temp data storage for File #44
 N SDAPPTMULT2        ;temp data storage for Appointment Multiple File #2
 N SDALLAPPTARY       ;temp data storage for all records found in the HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 N SDDFN,SDCLINICIEN,HASDFNERRORS,HASCLINIENERRORS,HASBEGDATEERRORS,HASENDDATEERRORS
 ;
 ;NOTE: Ensure that before calling this routine the SDVIEWAPPTBY variable is set to either 0 OR 1
 ;      0 - View Appointment using DFN
 ;      1 - View Appointment using CLINIC IEN
 ;
 S ERRORFLAG=0
 ;Input parameters validation begins here
 I $G(SDVIEWAPPTBY)=0 D  ;DFN input parameter validation
 . S SDDFN=SDPOINTERIEN
 . S HASDFNERRORS=$$VALIDATEPTDFN(.ERRORS,SDDFN)
 . I HASDFNERRORS M RETURNERROR=ERRORS
 ;
 I $G(SDVIEWAPPTBY)=1 D  ;CLINIC IEN input parameter validation
 . S SDCLINICIEN=SDPOINTERIEN
 . S HASCLINIENERRORS=$$VALIDATECLINIC(.ERRORS,SDCLINICIEN)
 . I HASCLINIENERRORS M RETURNERROR=ERRORS
 ;
 ;convert beginning and ending date time to Fileman Format
 S:$G(SDBEGDATE)'="" SDBEGDATE=$$ISOTFM^SDAMUTDT(SDBEGDATE)
 S:$G(SDENDDATE)'="" SDENDDATE=$$ISOTFM^SDAMUTDT(SDENDDATE)
 ;
 S HASBEGDATEERRORS=$$VALIDATEBEGDATE(.ERRORS,SDBEGDATE) ;SDBEGDATE input parameter validation
 I HASBEGDATEERRORS M RETURNERROR=ERRORS
 ;
 S HASENDDATEERRORS=$$VALIDATEENDDATE(.ERRORS,SDENDDATE) ;SDENDDATE input parameter validation
 I HASENDDATEERRORS M RETURNERROR=ERRORS
 ;Input parameters validation ends here
 ;
 I $O(RETURNERROR("Error",""))'="" D BUILDJSON(.RETURNERROR,.RETURNJSON) Q  ;do not continue processing if errors are detected
 ;
 K RETURNJSON,SDAPPT40984,SDAPPT44,SDAPPTMULT2     ;always clear returned data to ensure a new array of data are returned
 ;
 I $G(SDVIEWAPPTBY)=0 D GETAPPTBYDFN(SDDFN,SDBEGDATE,SDENDDATE)        ;view appointment using DFN of the patient
 I $G(SDVIEWAPPTBY)=1 D GETAPPTBYCLIN(SDCLINICIEN,SDBEGDATE,SDENDDATE) ;view appointment using Clinic IEN
 ;
 ;Merge the three retrieved appointments into one big array
 D MERGEALLAPPT(.SDALLAPPTARY,.SDAPPT40984,.SDAPPT44,.SDAPPTMULT2)
 ;
 D BUILDJSON(.SDALLAPPTARY,.RETURNJSON)
 D CLEANUP
 Q
 ;
VALIDATEPTDFN(ERRORS,SDDFN)    ;Validate patient DFN
 N ERRORFLAG
 S ERRORFLAG=$$VALIDATEPTDFN^SDESGETPATAPPT(.ERRORS,SDDFN)
 Q ERRORFLAG
 ;
VALIDATECLINIC(ERRORS,SDCLINICIEN)  ;Validate Clinic
 N ERRORFLAG
 S ERRORFLAG=$$VALIDATECLINIC^SDESGETPATAPPT(.ERRORS,SDCLINICIEN)
 Q ERRORFLAG
 ;
VALIDATEBEGDATE(ERRORS,SDBEGDATE)   ;Validate Beginning Date
 N ERRORFLAG
 I $G(SDBEGDATE)="" D ERRLOG^SDESJSON(.ERRORS,25) S ERRORFLAG=1 Q ERRORFLAG
 S ERRORFLAG=$$VALIDATEBEGDT^SDESPRINTPATAPPT(.ERRORS,SDBEGDATE)
 Q ERRORFLAG
 ;
VALIDATEENDDATE(ERRORS,SDENDDATE)   ;Validate ENding Date
 N ERRORFLAG
 I SDENDDATE="" D ERRLOG^SDESJSON(.ERRORS,26) S ERRORFLAG=1 Q ERRORFLAG
 S ERRORFLAG=$$VALIDATEENDDT^SDESPRINTPATAPPT(.ERRORS,SDENDDATE)
 Q ERRORFLAG
 ;
GETAPPTBYDFN(DFN,SDBEG,SDEND) ;View Appointment using DFN of the patient
 N SDCLINICARY
 D GETAPPT40984(DFN,SDBEG,SDEND) ;retrieves appointment from File #409.84
 ;SDCLINICARY is set while retrieving the appointments from File #409.84 in GETAPPT40984 line tag
 D LOOPCLINICARY(.SDCLINICARY,SDBEG,SDEND)   ;retrieves appointment from File #44
 D GETAPPT2(DFN,SDBEG,SDEND)     ;retrieves appointment from Appointment Multiple Patient File #2
 Q
 ;
GETAPPTBYCLIN(SDCLINICIEN,SDBEGDATE,SDENDDATE) ;View Appointment using Clinic IEN
 N PATDFNARY
 D GETAPPT44(SDCLINICIEN,SDBEGDATE,SDENDDATE) ;Retrieves appointments in File #44
 ;PATDFNARY array is created while retrieving appointments from File #44 in GETAPPT44 line tag
 ;PATDFNARY will be use to retrieve appointments from Appointment Multiple PATIENT File #2 and File #409.84
 I $D(PATDFNARY) D
 . S DFN="" F  S DFN=$O(PATDFNARY(DFN)) Q:DFN=""  D
 . . D GETAPPT40984(DFN,SDBEGDATE,SDENDDATE) ;retrieves appointment from File #409.84
 . . D GETAPPT2(DFN,SDBEGDATE,SDENDDATE)     ;retrieve appointments from Appointment Multiple PATIENT File #2
 Q
 ;
GETAPPT40984(DFN,BDATE,EDATE) ;Traverse the "CPAT" cross reference in File #409.84 to retrieve appointments for a given datetime range
 N APPTIEN,APPTDATA,RECNUM,CLINICIEN
 S RECNUM=0
 S APPTIEN=0 F  S APPTIEN=$O(^SDEC(409.84,"CPAT",DFN,APPTIEN)) Q:'APPTIEN  D
 . K SDMSG
 . I '$$APPTINDTRANGE^SDESAPPT(APPTIEN,BDATE,EDATE) Q
 . D SUMMARY^SDESAPPTDATA(.APPTDATA,APPTIEN)
 . I $G(SDVIEWAPPTBY)=1,$G(APPTDATA("Resource","ClinicIEN"))'=SDCLINICIEN  Q  ;if view appointment by Clinic IEN, we are only interested of those Clinic IEN passed in
 . S RECNUM=RECNUM+1
 . S APPTDATA("AppointmentType")=$$GET1^DIQ(409.84,APPTIEN_",",.06)
 . I $D(APPTDATA) D
 . . M SDAPPT40984("PatientAppt","File#409.84",RECNUM)=APPTDATA
 . . I $G(SDVIEWAPPTBY)=0 D
 . . . S CLINICIEN=$G(APPTDATA("Resource","ClinicIEN"))
 . . . I $G(CLINICIEN)'="" S SDCLINICARY(CLINICIEN)="" ;this will use later when retrieving the appointments in File #44
 I $O(SDAPPT40984("PatientAppt","File#409.84",""))="" S SDAPPT40984("PatientAppt","File#409.84")="" ;if no record found, set the array into a null value
 Q
 ;
LOOPCLINICARY(SDCLINICARY,SDBEG,SDEND) ;Retrieve appointments from File #44
 N CLINICIEN
 S CLINICIEN="" F  S CLINICIEN=$O(SDCLINICARY(CLINICIEN)) Q:CLINICIEN=""  D GETAPPT44(CLINICIEN,SDBEG,SDEND)
 Q
 ;
GETAPPT44(SDCLINICIEN,BDATE,EDATE) ;Traverse the "S" node in HOSPITAL LOCATION File #44 to retrieve appointments for a given datetime range
 N APPDATETIME,APPTREC,SDAPPTNO,SDIEN,SDAPPT,SDMSG,SDSTDT,SDCLIN,FOUND,NUM,SDCLINDFN
 S NUM=0
 S APPDATETIME=$$FMADD^XLFDT(BDATE,-1) ;always start the previous date in order to get the needed date range
 F  S APPDATETIME=$O(^SC(SDCLINICIEN,"S",APPDATETIME)) Q:(APPDATETIME="")!(APPDATETIME>EDATE)  D
 . Q:APPDATETIME<BDATE
 . S SDAPPTNO=0 F  S SDAPPTNO=$O(^SC(SDCLINICIEN,"S",APPDATETIME,1,SDAPPTNO)) Q:SDAPPTNO=""  D
 . . I '$D(^SC(SDCLINICIEN,"S",APPDATETIME,1,SDAPPTNO,0)) Q
 . . S SDIEN=SDAPPTNO_","_APPDATETIME_","_SDCLINICIEN_","
 . . S SDCLINDFN=$$GET1^DIQ(44.003,SDIEN,.01,"I")
 . . Q:'$D(^DPT(SDCLINDFN,"S",APPDATETIME,0))
 . . K SDMSG,SDAPPT D GETS^DIQ(44.003,SDIEN,"**","IE","SDAPPT","SDMSG")
 . . Q:$D(SDMSG)
 . . I $G(SDVIEWAPPTBY)=0,$G(SDAPPT(44.003,SDIEN,.01,"I"))'=DFN Q  ;if view appointment by DFN, we are only interested of those DFN's passed in
 . . S SDSTDT=APPDATETIME
 . . S SDCLIN=SDCLINICIEN
 . . S NUM=NUM+1
 . . D BLDREC^SDESGETCLINAPPT
 . . I $D(APPTREC) M SDAPPT44("PatientAppt","File#44",NUM)=APPTREC("ClinicApptDate",SDSTDT)
 . . I $G(SDVIEWAPPTBY)=1 S PATDFNARY(SDAPPT(44.003,SDIEN,.01,"I"))="" ;will be used later to retrieve appointments from the appointment multiple in File #2
 I $O(SDAPPT44("PatientAppt","File#44",""))=""  S SDAPPT44("PatientAppt","File#44")="" ;if no record found, set the array into a null value
 Q
 ;
GETAPPT2(DFN,BDATE,EDATE) ;Traverse the "S" node in Appointment Multiple Patient File #2 to retrieve appointments for a given datetime range
 N APPT,APPDATETIME,SDPATAPPT,SDMSG,ERR,NUM
 S NUM=0
 S APPDATETIME=$$FMADD^XLFDT(BDATE,-1) ;always start the previous date in order to get the needed date range
 F  S APPDATETIME=$O(^DPT(DFN,"S",APPDATETIME)) Q:(APPDATETIME="")!(APPDATETIME>EDATE)  D
 . Q:APPDATETIME<BDATE
 . I $G(SDVIEWAPPTBY)=1,$$GET1^DIQ(2.98,APPDATETIME_","_DFN_",",.01,"I")'=SDCLINICIEN Q  ;if view appointment by Clinic IEN, we are only interested of those Clinic IEN passed in
 . K SDMSG,ERR
 . S NUM=NUM+1
 . S APPT=$$GETAPPT^SDESGETPATAPPT(.SDPATAPPT,$G(DFN),APPDATETIME)
 . Q:$D(ERR)
 . I $G(APPT) M SDAPPTMULT2("PatientAppt","File#2.98",NUM)=SDPATAPPT("PatientAppt",NUM)
 I $O(SDAPPTMULT2("PatientAppt","File#2.98",""))="" S SDAPPTMULT2("PatientAppt","File#2.98")="" ;if no record found, set the array into a null value
 Q
 ;
MERGEALLAPPT(SDALLAPPTARY,SDAPPT40984,SDAPPT44,SDAPPTMULT2) ;Merge all appointments(409.84, 44, and 2.98) altogther into one big array
 M SDALLAPPTARY=SDAPPT40984
 M SDALLAPPTARY=SDAPPT44
 M SDALLAPPTARY=SDAPPTMULT2
 Q
 ;
BUILDJSON(RETURNJSON,INPUT) ; Build JSON format
 N JSONERROR
 S JSONERROR=""
 D ENCODE^XLFJSON("RETURNJSON","INPUT","JSONERROR")
 Q
 ;
CLEANUP ;
 K RETURNERROR,SDALLAPPTARY,SDBEG,SDEND,ERRORFLAG,HASDFNERRORS,HASCLINIENERRORS,ERRORS
 K SDMSG,FOUND,ERR,SDCLINICIEN,SDDFN,SDVIEWAPPTBY,HASBEGDATEERRORS,HASENDDATEERRORS
 Q
 ;
