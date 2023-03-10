SDESCANCELAPPT44 ;ALB/MGD,KML - CANCEL APPOINTMENT REQUEST IN FILE 44 ;Feb 14,2022
 ;;5.3;Scheduling;**805,809**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ; RPC: SDES CANCEL APPT #44
ARCANCEL44(RETURN,SDDFN,SDCLNIEN,SDARDTTM) ; Cancel Appointment Request in #44 (VSE-1944)
 ; INP - Input parameters array
 ;  SDDFN    = (Req) DFN Pointer to the PATIENT file #2
 ;  SDCLNIEN = (Req) IEN of Clinic in HOSPITAL LOCATION #44
 ;  SDARDTTM = (Req) Date/Time of Appointment in ISO 8601 extended format (e.g. 2022-01-19T20:15:44)
 ;
 N POP,SDIEN,SDAPTREQ
 S POP=0
 ;
 D VALIDATE
 I 'POP D UPDATE
 D BUILDER
 Q
 ;
VALIDATE ;
 S POP=0
 ;
 ; Patient DFN
 S SDDFN=$G(SDDFN,"")
 I SDDFN="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,1) Q
 I SDDFN'="",'$D(^DPT(+SDDFN,0)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,2) Q
 ;
 ; Clinic IEN
 S SDCLNIEN=$G(SDCLNIEN,"")
 I SDCLNIEN="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,18) Q
 I '$D(^SC(+SDCLNIEN,0)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,19) Q
 ;
 ; Date/time of appt - CLINIC TIME ZONE
 S SDARDTTM=$G(SDARDTTM,"")
 I SDARDTTM="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,76) Q
 S SDARDTTM=$$ISOTFM^SDAMUTDT(SDARDTTM,SDCLNIEN) ;VSE-2396  convert from ISO8601 format to Fileman
 I SDARDTTM=-1 S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,77) Q
 S SDIEN=$$SCIEN(SDDFN,SDCLNIEN,SDARDTTM)
 I $P(SDIEN,U,2)="C"  S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,52,"Appointment has already been cancelled.") Q
 I 'SDIEN S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,52,"Appt Date/Time not found in Clinic for this Patient.") Q
 S SDIEN=+SDIEN
 Q
 ;
SCIEN(SDDFN,CLINIC,DATE) ;get the ien for the appointment
 ; Input -
 ; SDDFN = PATIENT ien (DFN)
 ; CLINIC = CLINIC ien
 ; DATE = Date/time of appointment
 ; Output - returns ien of appt at 44.003
 N X,RESULTS,APPTSTRING
 S (RESULTS,X)=0
 F  S X=$O(^SC(CLINIC,"S",DATE,1,X)) Q:'X  D
 . S APPTSTRING=$G(^SC(CLINIC,"S",DATE,1,X,0))
 . I $P(APPTSTRING,U)=SDDFN,$P(APPTSTRING,U,9)="C" S RESULTS=X_"^C" Q  ; APPT is cancelled for the patient
 . I $P(APPTSTRING,U)=SDDFN S RESULTS=X
 Q RESULTS
 ;
UPDATE ;Update Appointment for Cancellation
 N SDFDA,SDERR
 S SDFDA(44.003,SDIEN_","_SDARDTTM_","_SDCLNIEN_",",310)="C"
 K SDERR D UPDATE^DIE("","SDFDA","","SDERR")
 I $D(SDERR) S SDAPTREQ("Error",1)="Error trying to cancel Appointment in File #44." Q
 S SDAPTREQ("Success")="Appointment is successfully cancelled."
 Q
 ;
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDAPTREQ,.RETURN,.JSONERR)
 Q
