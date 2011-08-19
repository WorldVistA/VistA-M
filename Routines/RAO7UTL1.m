RAO7UTL1 ;HISC/GJC,FPT-Utilities for HL7 messages. ;9/14/98  08:00
 ;;5.0;Radiology/Nuclear Medicine;**2,76**;Mar 16, 1998;Build 4
BRKOUT ; Breakout the 'MSH', 'ORC' & 'PID' segments.
 ; Called from: RAO7RON & RAO7RCH
 N RADATA,RAHEAD,RASEG,X S X=0
 F  S X=$O(RAMSG(X)) Q:X'>0  D
 . S RASEG=$G(RAMSG(X)),RAHEAD=$P(RASEG,RAHLFS)
 . Q:RAHEAD'="PID"&(RAHEAD'="ORC")&(RAHEAD'="MSH")
 . S RADATA=$P(RASEG,RAHLFS,2,999)
 . S:RAHEAD="MSH" RAMSH3=$P(RADATA,RAHLFS,3)
 . S:RAHEAD="ORC" RAORC2=$P(RADATA,RAHLFS,2),RAORC3=$P(RADATA,RAHLFS,3)
 . S:RAHEAD="PID" RAPID3=$P(RADATA,RAHLFS,3),RAPID5=$P(RADATA,RAHLFS,5)
 . Q
 S RADIV(.119)=$P($G(^RA(79,RAMSH3,.1)),U,19)
 S:RADIV(.119)="" RADIV(.119)="n"
 Q
ABNOR(RAOIFN,RADFN,RADTI) ; test code to find 'Diagnostic Code' for
 ; descendents and adopted procedures.  Called from RAO7CMP.
 ; 'RAOIFN'-> ien of file 75.1
 ; 'RADFN' -> ien of the Rad/Nuc Med Patient
 ; 'RADTI' -> inverse date of the registered exam
 Q:'($D(^RADPT("AO",RAOIFN,RADFN,RADTI))\10) ""
 N RABN,RACNI,RAXAM S RABN="",RACNI=0
 F  S RACNI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RACNI)) Q:RACNI'>0  D  Q:RABN]""
 . S RAXAM(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 . Q:'$P(RAXAM(0),"^",25)  ; Quit if not part of the set.
 . S RABN=$$DIAG^RAO7UTL(RADFN,RADTI,RACNI)
 . Q
 Q RABN
 ;
XAMDT(RADFN) ;Return exam date/time for interpreted non-cancelled case. The
 ;'Cancelled' EXAMINATION STATUS record has an order number of zero.
 ;IA#: 4875 Private w/MPI
 ; input: RADFN=The DFN of the patient
 ;return: RAXAMDT=The exam date/time (FM internal) of the most recent
 ;                non-cancelled interpreted case, else "0^an active exam
 ;                with interpretation was not found for this patient"
 N RAXAMDT S RAXAMDT="0^an active exam with interpretation was not found for this patient"
 S RADTI=0 F  S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:'RADTI  D  Q:RAXAMDT
 .S RACNI=0
 .F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D  Q:RAXAMDT
 ..S RAX=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:$P(RAX,U,17)=""  ;no rpt
 ..Q:$P($G(^RA(72,+$P(RAX,U,3),0)),U,3)=0  ;cancelled case
 ..S RAXAMDT=(9999999.9999-RADTI)
 ..Q
 .Q
 K RACNI,RADTI,RAX
 Q RAXAMDT
 ;
