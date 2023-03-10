SDESVVC ;ALB/WTC,DJS,JAS - VISTA SCHEDULING RPCS ;DEC 23, 2022@11:25
 ;;5.3;Scheduling;**828,833**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
VVCAPPT(SDESJSON,SDESAPPT) ;
 ;
 ;  SDES VVC APPT RPC
 ;
 ;  Returns VVC Web app URL in JSON format if appointment is valid and for a VVC clinic.
 ;
 ;  SDESAPPT = Appointment (pointer to #409.84)
 ;
 N SDESARRAY
 ;
 D ERRCHK
 I '$D(SDESARRAY("Error",1)) D URLCHK
 ;
 D BUILDJSON^SDESBUILDJSON(.SDESJSON,.SDESARRAY)
 Q
 ;
ERRCHK ;
 ;
 ; ERROR CHECKING
 ;
 I '$L($G(SDESAPPT)) D  Q
 . S SDESARRAY("Error",1)=$$ERRTXT(14)  ; Missing Appt IEN
 ;
 I '+$G(SDESAPPT) D  Q
 . S SDESARRAY("Error",1)=$$ERRTXT(15)  ; Incorrectly formatted Appt IEN
 ;
 I '$D(^SDEC(409.84,SDESAPPT)) D  Q
 . S SDESARRAY("Error",1)=$$ERRTXT(15)  ; Appt IEN does not exist
 Q
 ;
URLCHK ;
 ;
 N SDESRES,SDES44,SDESSTOP,SDESREDT
 ;
 ;  Appointment's resource
 ;
 S SDESRES=$$GET1^DIQ(409.84,SDESAPPT,.07,"I")
 I 'SDESRES S SDESARRAY("Error",1)=$$ERRTXT(383) Q  ; Resource is missing from Appt
 ;
 ;  Resource's clinic
 ;
 S SDES44=$$GET1^DIQ(409.831,SDESRES,.04,"I")
 I 'SDES44 S SDESARRAY("Error",1)=$$ERRTXT(283) Q  ; Clinic is missing from Resource
 ;
 ;  Clinic's stop code and credit stop code.
 ;
 S SDESSTOP=$$GET1^DIQ(44,SDES44,8,"I"),SDESREDT=$$GET1^DIQ(44,SDES44,2503,"I")
 I SDESSTOP S SDESSTOP=$$GET1^DIQ(40.7,SDESSTOP,1,"I")
 I SDESREDT S SDESREDT=$$GET1^DIQ(40.7,SDESREDT,1,"I")
 ;
 I 'SDESSTOP,'SDESREDT S SDESARRAY("Error",1)=$$ERRTXT(98) Q  ;  No stop codes so no URL.
 ;
 ;  If clinic's stop code or credit stop code is for VVC, return URL for VVC Web app
 ;
 I SDESSTOP'="",$O(^SDEC(409.98,1,3,"B",SDESSTOP,0))>0 D  Q
 . S SDESARRAY(0)="T01000URL",SDESARRAY(1)=$$GET1^DIQ(409.98,1,6)
 I SDESREDT'="",$O(^SDEC(409.98,1,3,"B",SDESREDT,0))>0 D  Q
 . S SDESARRAY(0)="T01000URL",SDESARRAY(1)=$$GET1^DIQ(409.98,1,6)
 ;
 ;  Not a VVC appointment.
 ;
 S SDESARRAY("Error",1)=$$ERRTXT(403)
 ;
ERRTXT(ERRNM) ;
 ;
 ; ERRNM - The ERROR CODE/NUMBER field from the SDES ERROR CODES file (#409.93)
 ;
 N SDESERR
 D ERRLOG^SDESJSON(.SDESERR,ERRNM)
 Q SDESERR("Error",1)
