SDEC08A ;ALB/PWC - VISTA SCHEDULING RPCS ;Aug 10, 2020@09:30
 ;;5.3;Scheduling;**745,756**;Aug 13, 1993;Build 43
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ; called from ^SDEC08 - routine was too big and had to split *745/*756
 ;
AVUPDT(SDECSCD,SDECSTART,SDECLEN) ;Update Clinic availability
 ;See SDCNP0
 N HSI,I,S,SB,SD,SDDIF,SI,SL,SS,ST,STARTDAY,STR,X,Y
 S (SD,S)=SDECSTART
 S I=SDECSCD
 Q:'$D(^SC(I,"ST",SD\1,1))
 S SL=^SC(I,"SL"),X=$P(SL,U,3),STARTDAY=$S($L(X):X,1:8),SB=STARTDAY-1/100,X=$P(SL,U,6),HSI=$S(X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4),STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2)
 S SL=SDECLEN
 S S=^SC(I,"ST",SD\1,1),Y=SD#1-SB*100,ST=Y#1*SI\.6+(Y\1*SI),SS=SL*HSI/60
 I Y'<1 F I=ST+ST:SDDIF S Y=$E(STR,$F(STR,$E(S,I+1))) Q:Y=""  S S=$E(S,1,I)_Y_$E(S,I+2,999),SS=SS-1 Q:SS'>0
 S ^SC(SDECSCD,"ST",SD\1,1)=S
 Q
 ;
APCAN(SDECZ,SDECLOC,SDECDFN,SDECSD,SDECAPTID,SDECLEN) ;
 ;Cancel appointment for patient SDECDFN in clinic SDECSC1 at time SDECSD
 N SDECPNOD,SDECC,DA,DIE,DPTST,DR,%H
 ;save data into SDEC APPOINTMENT in case of un-cancel (status & appt length)
 S SDECPNOD=^DPT(SDECPATID,"S",SDECSD,0)
 S DPTST=$P(SDECPNOD,U,2)
 S DIE=409.84
 S DA=SDECAPTID
 S DR=".17///"_DPTST_";"_".18///"_SDECLEN
 D ^DIE
 S SDECC("PAT")=SDECDFN
 S SDECC("CLN")=SDECLOC
 S SDECC("TYP")=SDECTYP
 S SDECC("ADT")=SDECSD
 S %H=$H D YMD^%DTC
 S SDECC("CDT")=SDECDATE   ;X+%
 S SDECC("NOT")=SDECNOT
 S:+SDECCR SDECC("CR")=SDECCR
 S SDECC("USR")=SDUSER
 S SDECZ=$$CANCEL^SDEC08(.SDECC)   ;PWC - changed to call routine SDEC08, code was previously in that routine before split *745
 Q
 ;
SDECUCAN(SDECAPTID) ;called internally to update SDEC APPOINTMENT by clearing cancel date/time
 N PROVIEN,SDAPTYP,SDCL,SDRES,SDECIENS
 S SDECIENS=SDECAPTID_","
 S SDECFDA(409.84,SDECIENS,.12)=""
 K SDECMSG
 D FILE^DIE("","SDECFDA","SDECMSG")
 S SDAPTYP=$$GET1^DIQ(409.84,SDECAPTID_",",.22,"I")
 I $P(SDAPTYP,";",2)="GMR(123," D
 .S SDCL=$$SDCL^SDECUTL(SDECAPTID)
 .S PROVIEN=$$GET1^DIQ(44,SDCL_",",16,"I")
 .D REQSET^SDEC07A($P(SDAPTYP,";",1),PROVIEN,"",1)
 Q
 ;
APUCAN(SDECZ,SDECLOC,SDECPATID,SDECSTART,SDECDAM,SDECDEC,SDECLEN,SDECNOTE,SDECRES,SDECWKIN) ;
 ;un-Cancel appointment for patient SDECDFN in clinic SDECSC1
 ;  SDECLOC   = pointer to hospital location ^SC file 44
 ;  SDECPATID = pointer to VA Patient ^DPT file 2
 ;  SDECSTART = Appointment time
 ;  SDECDAM   = Date appointment made in FM format
 ;  SDECDEC   = Data entry clerk - pointer to NEW PERSON file 200
 N SDECC,%H
 S SDECC("PAT")=SDECPATID
 S SDECC("CLN")=SDECLOC
 S SDECC("ADT")=SDECSTART
 S SDECC("NOTE")=SDECNOTE  ;user note
 S SDECC("RES")=SDECRES
 S SDECC("USR")=DUZ
 S SDECC("LEN")=SDECLEN
 S SDECC("WKIN")=SDECWKIN
 ;
 S SDECZ=$$UNCANCEL(.SDECC)
 Q
 ;
UNCANCEL(BSDR) ;PEP; called to un-cancel appt
 ; Make call using: S ERR=$$UNCANCEL(.ARRAY)
 ;
 ; Input Array -
 ; BSDR("PAT") = ien of patient in file 2
 ; BSDR("CLN") = ien of clinic in file 44
 ; BSDR("ADT") = appointment date and time
 ; BSDR("USR") = user who un-canceled appt
 ; BSDR("NOTE") = appointment note from SDEC APPOINTMENT
 ; BSDR("LEN") = appt length in minutes (numeric)
 ; BSDR("RES") = resource
 ; BSDR("WKIN")= walk-in
 ;
 ;Output: error status and message
 ;   = 0 or null:  everything okay
 ;   = 1^message:  error and reason
 ;
 N DPTNOD,DPTNODR,SDECERR
 I '$D(^DPT(+$G(BSDR("PAT")),0)) Q 1_U_"Patient not on file: "_$G(BSDR("PAT"))
 I '$D(^SC(+$G(BSDR("CLN")),0)) Q 1_U_"Clinic not on file: "_$G(BSDR("CLN"))
 I $G(BSDR("ADT"))'?7N1"."1N.N Q 1_U_"Appt Date/Time error: "_$G(BSDR("ADT"))  ;PWC  allow any time combination of numbers #694
 I '$D(^VA(200,+$G(BSDR("USR")),0)) Q 1_U_"User Who Canceled Appt Error: "_$G(BSDR("USR"))
 ;
 S SDECERR=$$APPVISTA^SDEC07B(BSDR("LEN"),BSDR("NOTE"),BSDR("PAT"),BSDR("RES"),BSDR("ADT"),BSDR("WKIN"),BSDR("CLN"),.SDECI)  ;alb/sat 665 APPVISTA moved to SDEC07B
 Q SDECERR
