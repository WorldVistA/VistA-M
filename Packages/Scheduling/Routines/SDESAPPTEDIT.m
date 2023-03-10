SDESAPPTEDIT ;ALB/RRM - EDIT SDEC APPOINTMENT FILE #409.84 ;March 21, 2022
 ;;5.3;Scheduling;**813**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;Global References      Supported by ICR#               Type
 ;-----------------      -----------------               ----------
 ; ^SDEC(409.84          SD is the owner. ICR not needed
 ;
 ;External References
 ;-------------------
 ; FILE^DIE               2053                           Supported
 ;
 Q  ;No Direct Call
 ;
 ; Called from RPC: SDES EDIT APPT #409.84
 ; The parameter list for this RPC must be kept in sync.
 ; If you need to add or remove a parameter, ensure that the Remote Procedure File #8994 definition is also updated.
 ;
EDITAPPT(SDRETJSONFRMT,SDECAPTID,SDECNOTE,SDECLEN) ;Edit Appointment in File #409.84 (only 'note text' and appointment length can be edited)
 ;EDITAPPT(.SDRETJSONFRMT,SDECAPTID,SDECNOTE,SDECLEN)  external parameter tag is in SDES routine
 ; SDECAPTID - Appointment IEN - Pointer to SDEC APPOINTMENT File #409.84
 ; SDECNOTE  - Note
 ; SDECLEN   - If there is a change in the length of appointment, this is the new value (in minutes) for length
 ;
 N SDERROR,SDEDITAPPTRET
 K SDRETJSONFRMT,SDEDITAPPTRET ;always clear returned data array to ensure a new array of data are returned
 I $$VALAPTIEN($G(SDECAPTID,"")) Q  ;validate Appointment IEN
 I $$VALAPTLEN(SDECLEN) Q  ;validate Appointment Length
 ;update begins when all input parameters pass all validations
 D UPDATEAPT($G(SDECAPTID,""),$G(SDECNOTE),$G(SDECLEN))
 D BUILDJSON(.SDEDITAPPTRET,.SDRETJSONFRMT)
 D CLEANUP
 Q
 ;
VALAPTIEN(SDECAPTID) ;validate Appointment IEN in File #409.84
 N SDERRFLG
 S SDERRFLG=0
 I SDECAPTID="" D ERRLOG^SDESJSON(.SDEDITAPPTRET,14,SDECAPTID) S SDERRFLG=1
 I SDECAPTID'="",'$D(^SDEC(409.84,SDECAPTID,0)) D ERRLOG^SDESJSON(.SDEDITAPPTRET,15,SDECAPTID) S SDERRFLG=1
 I SDERRFLG D BUILDJSON(.SDEDITAPPTRET,.SDRETJSONFRMT),CLEANUP
 Q SDERRFLG
 ;
VALAPTLEN(SDECLEN) ;validate Appointment Length
 N SDERRFLG
 S SDERRFLG=0
 I SDECLEN'?.N D ERRLOG^SDESJSON(.SDEDITAPPTRET,116) S SDERRFLG=1
 E  D
 . I $G(SDECLEN)&($G(SDECLEN)>0) D
 . . I $G(SDECLEN)?.E1"."1N.N D ERRLOG^SDESJSON(.SDEDITAPPTRET,116,"Length of Appointment must be 0 decimal digits.") S SDERRFLG=1
 . . I +$G(SDECLEN)>120!(+$G(SDECLEN)<5) D ERRLOG^SDESJSON(.SDEDITAPPTRET,116,"Length of Appointment must be between 5 and 120.") S SDERRFLG=1
 I SDERRFLG D BUILDJSON(.SDEDITAPPTRET,.SDRETJSONFRMT),CLEANUP
 Q SDERRFLG
 ;
UPDATEAPT(SDECAPTID,SDECNOTE,SDECLEN) ;update Field .18 LENGTH OF APPT and Field 1 Note Multiple in File #409.84
 N SDECAPTFDA,SDECAPTERR,SDECMSG
 I $G(SDECLEN),$G(SDECLEN)>0 D  ;Edit Field .18 LENGTH OF APPT in File #409.84
 . S SDECAPTFDA(409.84,SDECAPTID_",",.18)=SDECLEN
 . D FILE^DIE("","SDECAPTFDA","SDECAPTERR")
 . I $D(SDECAPTERR) D ERRLOG^SDESJSON(.SDEDITAPPTRET,52,"Appt Length update not Successful.Error occurred during Filing.")
 Q:$D(SDECAPTERR)  ;do not continue editing if Appointment Length errored out
 ;
 ;update NOTE begins here
 S SDECNOTE=$$STRIP^SDEC07($E(SDECNOTE,1,150)),SDECNOTE=$TR(SDECNOTE,"^"," ")   ;only use 1st 150 characters
 S SDECNOTE(.5)=SDECNOTE,SDECNOTE=""
 D WP^DIE(409.84,SDECAPTID_",",1,"","SDECNOTE","SDECMSG") ;edit Field 1 Note Multiple in File #409.84
 I $D(SDECMSG("DIERR")) D ERRLOG^SDESJSON(.SDEDITAPPTRET,52,"NOTE update not Successful.Error occurred during Filing.")
 E  S SDEDITAPPTRET("Success")="Appointment is successfully updated."
 K SDECAPTFDA,SDECAPTERR,SDECMSG
 Q
 ;
BUILDJSON(SDEDITAPPTRET,SDRETJSONFRMT) ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDEDITAPPTRET,.SDRETJSONFRMT,.JSONERR)
 Q
 ;
CLEANUP ;cleanup variables
 K SDERROR,SDEDITAPPTRET,SDTMPARY
 Q
 ;
