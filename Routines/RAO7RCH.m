RAO7RCH ;HISC/GJC,FPT-Process Discontinued Message ;9/4/97  09:11
 ;;5.0;Radiology/Nuclear Medicine;**15**;Mar 16, 1998
 ;
 ;------------------------- Variable List -------------------------------
 ; RADATA=HL7 data minus seg. hdr    RAHDR=Segment header
 ; RAHLFS="|"                        RAMSG=HL7 message passed in
 ; RAORC1=order control              RAORC10=entered by (200)
 ; RAORC16=order control reason      RAORC2=placer order #_"^OR"
 ; RAORC3=filler order #_"^RA"       RAPID3=patient ID
 ; RAPID5=patient name (2)           RASEG=message seg. including header
 ; ----------------------------------------------------------------------
EN1(RAMSG) ;
 D BRKOUT^RAO7UTL1
 ; defines RAORC2, RAORC3, RAPID3, RAPID5, RAMSH3, & RADIV(.119)
 S (RAERR,RALINEX)=0
 F  S RALINEX=$O(RAMSG(RALINEX)) Q:RALINEX'>0  D  Q:RAERR
 . S RASEG=$G(RAMSG(RALINEX)) Q:$P(RASEG,RAHLFS)="MSH"  ; quit if MSH segment
 . S RAHDR=$P(RASEG,RAHLFS),RADATA=$P(RASEG,RAHLFS,2,999)
 . D @$S(RAHDR="PID":"PID",RAHDR="ORC":"ORC",1:"ERR")
 . Q
 Q
PID ; breakdown the 'PID' segment
 S RAERR=$$EN2^RAO7VLD(2,RAPID3,RAPID5) S:RAERR RAERR=2
 Q
ORC ; breakdown the 'ORC' segment
 S RAERR=$$EN3^RAO7VLD(75.1,+RAORC3) S:RAERR RAERR=22 Q:RAERR
 S RA0=$G(^RAO(75.1,+RAORC3,0))
 S RASTATUS=+$P(RA0,U,5)
 I "358"'[$E(RASTATUS) S RAERR=25 Q
 S RAORC10=$P(RADATA,RAHLFS,10)
 S RAERR=$$EN3^RAO7VLD(200,+RAORC10) S:RAERR RAERR=4 Q:RAERR
 S RAORC16=$P($P(RADATA,RAHLFS,16),"^",4) ;Rad Reason file ien
 S RAORC161=$P($P(RADATA,RAHLFS,16),"^",5) ; Cancel Description
 D  Q:RAERR
 .S RANEW(75.1,+RAORC3_",",23)="@"
 .I RAORC16']"",(RAORC161']"") Q
 .I RAORC16]"",'$D(^RA(75.2,+RAORC16,0)),RAORC161']"" S RAERR=23 Q
 .S RANEW(75.1,+RAORC3_",",10)=RAORC16
 .S RANEW(75.1,+RAORC3_",",27)=RAORC161
 S RANEW(75.1,+RAORC3_",",5)=1
 S RANEW(75.1,+RAORC3_",",18)=RALDT
 Q
ERR ; error control - file 'soft' errors with CPRS
 N RAVAR S RAVAR("XQY0")=""
 D ERR^RAO7UTL("HL7 message missing 'PID' & 'ORC' segments",.RAMSG,.RAVAR)
 Q
