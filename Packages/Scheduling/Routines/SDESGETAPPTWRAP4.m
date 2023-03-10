SDESGETAPPTWRAP4 ;ALB/RRM,MGD/RRM - RPC WRAPPER FOR VIEWING AN APPOINTMENT ;JULY 5, 2022
 ;;5.3;Scheduling;**823**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$GETS^DIQ     is supported by IA #2056
 ; Reference to GETS^DIQ       is supported by IA #2056
 ; Reference to $$FIND1^DIC    is supported by IA #2051
 ; Reference to ENCODE^XLFJSON is supported by IA #6682
 ;
 ;Global References
 ;-----------------
 ; Reference to ^DPT( is supported by IAs #7030,7029,1476,10035
 ;
 Q  ;No Direct Call
 ;
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
 ; 
 ; Copy of SDESGETAPPTWRAP2
 ;
GETAPPTBYPATDFN(RETURNJSON,DFN,SDBEGDATE,SDENDDATE,SDEAS) ;Called from the RPC: SDES GET APPTS BY PATIENT DFN
 ;Based on Patient DFN, retrieve and return all appointments associated with a patient from SDEC APPOINTMENT File #409.84,
 ;HOSPITAL LOCATION File #44, and the Appointment Multiple Patient File #2
 ;
 ; Input:
 ;    DFN       [Required] = This the patient's DFN from PATIENT File #2
 ;    SDBEGDATE [Required] = The beginning date/time in ISO8601 Time Format for the search.
 ;    SDENDDATE [Required] = The ending date/time in ISO8601 Time Format for the search.
 ;    SDEAS     [Optional] = The Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;
 ; Output:
 ;    RETURNJSON = Returns fields from the (not in particular order) HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 ;                 in JSON format. JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURNERROR ;temp data storage for input validation error
 N SDALLAPPTARY       ;temp data storage for all records found in the HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 N SDVIEWAPPTBY       ;the driver of which process to perform in retrieving appointment
 N HASDFNERRORS,HASBEGDATEERRORS,HASENDDATEERRORS,HASEASERRORS,SDAPPTNO
 ;
 D INITVARBYDFN
 S HASDFNERRORS=$$VALIDATEPTDFN(.ERRORS,$G(DFN)) ;DFN input parameter validation
 I HASDFNERRORS M RETURNERROR=ERRORS
 ;
 S:$G(SDBEGDATE)'="" SDBEGDATE=$$ISOTFM^SDAMUTDT(SDBEGDATE)
 S:$G(SDENDDATE)'="" SDENDDATE=$$ISOTFM^SDAMUTDT(SDENDDATE)
 D INPUTDATEVAL($G(SDBEGDATE),$G(SDENDDATE)) ;beginning and ending date input parameter validation
 ;
 S HASEASERRORS=$$VALIDATEEAS(.ERRORS,$G(SDEAS))
 I HASEASERRORS M RETURNERROR=ERRORS
 ;
 I $O(RETURNERROR("Error",""))'="" S RETURNERROR("Appointment",1)="" D BUILDJSON(.RETURNERROR,.RETURNJSON) Q  ;do not continue, errors detected
 ;
 S (SDVIEWAPPTBY,SDAPPTNO)=0 ;view appointment using DFN of the patient from Patient File #2
 D GETAPPOINTMENTS(.SDALLAPPTARY,DFN,SDBEGDATE,SDENDDATE,SDVIEWAPPTBY)
 D BUILDJSON(.SDALLAPPTARY,.RETURNJSON)
 D CLEANUP
 Q
 ;
GETAPPTBYCLNIEN(RETURNJSON,CLINICIEN,SDBEGDATE,SDENDDATE,SDEAS) ;Called from the RPC: SDES GET APPTS BY CLIN IEN
 ;Based on CLINIC IEN, retrieve and return all appointments associated with a clinic from SDEC APPOINTMENT File #409.84,
 ;HOSPITAL LOCATION File #44, and the Appointment Multiple Patient File #2
 ;
 ; Input:
 ;    CLINICIEN [Required] = This the CLINIC IEN from HOSPITAL LOCATION File #44
 ;    SDBEGDATE [Required] = The beginning date/time in ISO8601 Time Format for the search.
 ;    SDENDDATE [Required] = The ending date/time in ISO8601 Time Format for the search.
 ;    SDEAS     [Optional] = The Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;
 ; Output:
 ;    RETURNJSON = Returns fields from the (not in particular order) HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 ;                 in JSON format. JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURNERROR ;temp data storage for input validation error
 N SDALLAPPTARY       ;temp data storage for all records found in the HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 N SDVIEWAPPTBY       ;the driver of which process to perform in retrieving appointment
 N HASCLINIENERRORS,HASBEGDATEERRORS,HASENDDATEERRORS,HASEASERRORS,SDAPPTNO
 ;
 D INITVARBYCLNIEN
 S HASCLINIENERRORS=$$VALIDATECLINIC(.ERRORS,$G(CLINICIEN)) ;CLINICIEN input parameter validation
 I HASCLINIENERRORS M RETURNERROR=ERRORS
 ;
 S:$G(SDBEGDATE)'="" SDBEGDATE=$$ISOTFM^SDAMUTDT(SDBEGDATE)
 S:$G(SDENDDATE)'="" SDENDDATE=$$ISOTFM^SDAMUTDT(SDENDDATE)
 D INPUTDATEVAL($G(SDBEGDATE),$G(SDENDDATE)) ;beginning and ending date input parameter validation
 ;
 S HASEASERRORS=$$VALIDATEEAS(.ERRORS,$G(SDEAS))
 I HASEASERRORS M RETURNERROR=ERRORS
 ;
 I $O(RETURNERROR("Error",""))'="" S RETURNERROR("Appointment",1)="" D BUILDJSON(.RETURNERROR,.RETURNJSON) Q  ;do not continue, errors detected
 ;
 S SDVIEWAPPTBY=1 ;view appointment using CLINIC IEN from Hospital Location File #44
 D GETAPPOINTMENTS(.SDALLAPPTARY,CLINICIEN,SDBEGDATE,SDENDDATE,SDVIEWAPPTBY)
 D BUILDJSON(.SDALLAPPTARY,.RETURNJSON)
 D CLEANUP
 Q
 ;
GETAPPTBYIEN(RETURNJSON,SDAPPTIEN,SDEAS) ;Called from the RPC: SDES GET APPTS BY IEN
 ;Based on APPOINTMENT IEN, retrieve and return all appointments associated with a clinic from SDEC APPOINTMENT File #409.84,
 ;HOSPITAL LOCATION File #44, and the Appointment Multiple Patient File #2
 ;
 ; Input:
 ;    DFN       [Required] = This the patient's DFN from PATIENT File #2
 ;    SDEAS     [Optional] = The Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;
 ; Output:
 ;    RETURNJSON = Returns fields from the (not in particular order) HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 ;                 in JSON format. JSON Errors will be returned for any invalid/missing parameters.
 ;
 N ERRORS,RETURNERROR ;temp data storage for input validation error
 N SDALLAPPTARY       ;temp data storage for all records found in the HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 N SDVIEWAPPTBY       ;the driver of which process to perform in retrieving appointment
 N HASAPPTIENERRORS,HASEASERRORS,DFN,APPTIEN,SDAPPTNO,SDBEGDATE,SDENDDATE,SDAPPTNO,FOUND
 ;
 D INITVARBYCLNIEN
 S HASAPPTIENERRORS=$$VALIDATEAPPTIEN(.ERRORS,$G(SDAPPTIEN)) ;CLINICIEN input parameter validation
 I HASAPPTIENERRORS M RETURNERROR=ERRORS
 ;
 S HASEASERRORS=$$VALIDATEEAS(.ERRORS,$G(SDEAS))
 I HASEASERRORS M RETURNERROR=ERRORS
 ;
 I $O(RETURNERROR("Error",""))'="" S RETURNERROR("Appointment",1)="" D BUILDJSON(.RETURNERROR,.RETURNJSON) Q  ;do not continue,errors detected
 ;
 S SDVIEWAPPTBY=2 ;view appointment using APPOINTMENT IEN from SDEC APPOINTMENT File #409.84
 S DFN=$$GET1^DIQ(409.84,SDAPPTIEN,.05,"I")
 S SDBEGDATE=$$GET1^DIQ(409.84,SDAPPTIEN,.01,"I")
 S SDENDDATE=$$GET1^DIQ(409.84,SDAPPTIEN,.02,"I")
 D GETAPPOINTMENTS(.SDALLAPPTARY,DFN,SDBEGDATE,SDENDDATE,SDVIEWAPPTBY,SDAPPTIEN)
 D BUILDJSON(.SDALLAPPTARY,.RETURNJSON)
 D CLEANUP
 Q
 ;
GETAPPOINTMENTS(SDALLAPPTARY,SDPOINTERIEN,SDBEGDATE,SDENDDATE,SDVIEWAPPTBY,SDAPPTIEN) ;
 ; Input:
 ;    SDPOINTERIEN  [Required] = This can be a patient's DFN from PATIENT File #2 or the Internal Entry Number (IEN) from HOSPITAL LOCATION FILE #44.
 ;    SDBEGDATE     [Required] = The beginning date/time in FileMan Format for the search.
 ;    SDENDDATE     [Required] = The ending date/time in FileMan Time Format for the search.
 ;    SDVIEWAPPTBY  [Optional] = The driver of which process to perform when retrieving appointments (By DFN, Clinic IEN, or Appointment IEN)
 ;                             = If NULL, this will be defaulted to by DFN
 ;    SDAPPTIEN     [Optional] = Only send this parameter if you want to retrieve appointments using APPOINTMENT IEN from SDEC APPOINTMENT File #409.84
 ;
 ; Output:
 ;    SDALLAPPTARY = Returns fields from the (not in particular order) HOSPITAL LOCATION File #44, PATIENT File #2, and SDEC APPOINTMENT File #409.84
 ;                   in array format. Errors will be returned for any invalid/missing parameters.
 N RECNUM
 S RECNUM=0
 I $G(SDVIEWAPPTBY)="" S SDVIEWAPPTBY=0
 S SDAPPTIEN=$G(SDAPPTIEN)
 I $G(SDVIEWAPPTBY)=0!($G(SDVIEWAPPTBY)=2) D GETAPPT40984^SDESGETAPPTWRAP5(.SDALLAPPTARY,SDPOINTERIEN,SDBEGDATE,SDENDDATE,SDAPPTIEN,RECNUM,SDVIEWAPPTBY) ;view appointment using DFN of the patient OR using Appointment IEN
 I $G(SDVIEWAPPTBY)=1 D GETAPPT44^SDESGETAPPTWRAP5(.SDALLAPPTARY,SDPOINTERIEN,SDBEGDATE,SDENDDATE,RECNUM,SDVIEWAPPTBY) ;view appointment using Clinic IEN
 Q
 ;
VALIDATEPTDFN(ERRORS,SDDFN)    ;Validate patient DFN
 N ERRORFLAG
 S ERRORFLAG=$$VALIDATEPTDFN^SDESGETPATAPPT(.ERRORS,SDDFN)
 Q $G(ERRORFLAG)
 ;
VALIDATECLINIC(ERRORS,SDCLINICIEN)  ;Validate Clinic
 N ERRORFLAG
 S ERRORFLAG=$$VALIDATECLINIC^SDESGETPATAPPT(.ERRORS,SDCLINICIEN)
 Q $G(ERRORFLAG)
 ;
VALIDATEAPPTIEN(ERRORS,SDAPPTIEN) ;Validate Appointment IEN
 N ERRORFLAG
 I SDAPPTIEN="" D ERRLOG^SDESJSON(.ERRORS,14) S ERRORFLAG=1
 I SDAPPTIEN'="",'$D(^SDEC(409.84,SDAPPTIEN,0)) D ERRLOG^SDESJSON(.ERRORS,15) S ERRORFLAG=1
 Q $G(ERRORFLAG)
 ;
INPUTDATEVAL(SDBEGDATE,SDENDDATE) ;beginning and ending date input parameter validation
 S HASBEGDATEERRORS=$$VALIDATEBEGDATE(.ERRORS,SDBEGDATE) ;SDBEGDATE input parameter validation
 I HASBEGDATEERRORS M RETURNERROR=ERRORS
 ;
 S HASENDDATEERRORS=$$VALIDATEENDDATE(.ERRORS,SDENDDATE) ;SDENDDATE input parameter validation
 I HASENDDATEERRORS M RETURNERROR=ERRORS
 Q
 ;
VALIDATEBEGDATE(ERRORS,SDBEGDATE)   ;Validate Beginning Date
 N ERRORFLAG
 I $G(SDBEGDATE)="" D ERRLOG^SDESJSON(.ERRORS,25) S ERRORFLAG=1 Q $G(ERRORFLAG)
 S ERRORFLAG=$$VALIDATEBEGDT^SDESPRINTPATAPPT(.ERRORS,SDBEGDATE)
 Q $G(ERRORFLAG)
 ;
VALIDATEENDDATE(ERRORS,SDENDDATE)   ;Validate Ending Date
 N ERRORFLAG
 I SDENDDATE="" D ERRLOG^SDESJSON(.ERRORS,26) S ERRORFLAG=1 Q $G(ERRORFLAG)
 S ERRORFLAG=$$VALIDATEENDDT^SDESPRINTPATAPPT(.ERRORS,SDENDDATE)
 Q $G(ERRORFLAG)
 ;
VALIDATEEAS(ERRORS,EAS) ;
 I $L(EAS) S EAS=$$EASVALIDATE^SDESUTIL($G(EAS))
 I $P($G(EAS),U)=-1 D ERRLOG^SDESJSON(.ERRORS,142) Q 1
 Q 0
 ;
BUILDJSON(RETURNJSON,INPUT) ; Build JSON format
 N JSONERROR
 S JSONERROR=""
 D ENCODE^XLFJSON("RETURNJSON","INPUT","JSONERROR")
 Q
 ;
CLEANUP ;
 K RETURNERROR,SDALLAPPTARY,SDBEG,SDEND,ERRORFLAG,HASDFNERRORS,HASCLINIENERRORS,ERRORS
 K SDMSG,FOUND,ERR,SDCLINICIEN,SDDFN,SDVIEWAPPTBY,HASBEGDATEERRORS,HASENDDATEERRORS,STARTTIME
 Q
 ;
INITVARBYDFN ;initialized input parameter for SDES GET APPTS BY PATIENT DFN3 RPC
 S DFN=$G(DFN)
 S SDBEGDATE=$G(SDBEGDATE)
 S SDENDDATE=$G(SDENDDATE)
 S SDEAS=$G(SDEAS)
 Q
 ;
INITVARBYCLNIEN ;initialized input parameter for SDES GET APPTS BY CLIN IEN 3 RPC
 S CLINICIEN=$G(CLINICIEN)
 S SDBEGDATE=$G(SDBEGDATE)
 S SDENDDATE=$G(SDENDDATE)
 S SDEAS=$G(SDEAS)
 Q
 ;
INITVARBYIEN ;initialized input parameter for SDES GET APPTS BY IEN 2 RPC
 S SDAPPTIEN=$G(SDAPPTIEN)
 S SDEAS=$G(SDEAS)
 Q
 ;
