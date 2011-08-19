RAO7RON ;HISC/GJC- Request message from OE/RR. (frontdoor) ;2/2/98  12:34
 ;;5.0;Radiology/Nuclear Medicine;**41,75,86**;Mar 16, 1998;Build 7
 ;
 ;Supported IA #10040 reference to ^SC
 ;Supported IA #2187 reference to EN^ORERR
 ;Supported IA #10103 reference to ^XLFDT
 ;Supported IA #10141 reference to ^XPDUTL
 ;Supported IA #10106 reference to $$FMDATE^HLFNC
 ;
 ;------------------------- Variable List -------------------------------
 ; RADATA=HL7 data minus seg. hdr    RAHDR=Segment header
 ; RAHLFS="|"                        RAMSG=HL7 message passed in
 ; RAOBR12=danger code               RAOBR18=modifier
 ; RAOBR19=hosp. loc. pntr (44)      RAOBR30=trans. mode
 ; RAOBR4=univ. trans. mode          RAOBX2=format of observ. value
 ; RAOBX3=observ. ID                 RAOBX5=observ. value
 ; RAORC1=order control              RAORC10=entered by (200)
 ; RAORC11=approving rad/nm phys (for some procedures only)
 ; RAORC12=ordering provider (200)   RAORC15=order effective D/T
 ; RAORC16=order control reason      RAORC2=placer order #_"^OR"
 ; RAORC3=filler order #_"^RA"       RAORC7=start dt/freq. of service
 ; RAPID3=patient ID                 RAPID5=patient name (2)
 ; RAPV119=visit #                   RAPV12=patient class
 ; RAPV13=patient location (44)      RASEG=message seg. including header
 ; ----------------------------------------------------------------------
EN1(RAMSG) ; Pass in the message from RAO7RO.  Decipher information.
 D BRKOUT^RAO7UTL1
 ; defines RAORC2, RAORC3, RAPID3, RAPID5, RAMSH3 & RADIV(.119)
 S (RAERR,RAWP,RALINEX)=0,RACLIN="^" K ^TMP("RAWP",$J)
 F  S RALINEX=$O(RAMSG(RALINEX)) Q:RALINEX'>0  D  Q:RAERR
 . S RASEG=$G(RAMSG(RALINEX)) Q:$P(RASEG,RAHLFS)="MSH"  ; quit if MSH segment
 . S RAHDR=$P(RASEG,RAHLFS),RADATA=$P(RASEG,RAHLFS,2,999)
 . D @$S(RAHDR="PID":"PID",RAHDR="PV1":"PV1",RAHDR="ORC":"ORC",RAHDR="OBR":"OBR^RAO7RON1",RAHDR="OBX":"OBX^RAO7RON1",RAHDR="DG1":"GETCPRS^RABWORD1",RAHDR="ZCL":"GETCPRS^RABWORD1",1:"ERR")
 . Q
 S RANEW(75.1,"+1,",18)=RALDT
 Q
PID ; breakdown the 'PID' segment
 S RAERR=$$EN2^RAO7VLD(2,RAPID3,RAPID5) S:RAERR RAERR=2
 I 'RAERR S RANEW(75.1,"+1,",.01)=RAPID3
 Q
PV1 ; breakdown the 'PV1' segment
 S RAPV12=$P(RADATA,RAHLFS,2)
 S RAERR=$$EN1^RAO7VLD(75.1,4,"E",RAPV12,"RASULT","") S:RAERR RAERR=27 Q:RAERR
 S RANEW(75.1,"+1,",4)=RAPV12
 S RAPV13=$P(RADATA,RAHLFS,3)
 S RAERR=$$EN3^RAO7VLD(44,+RAPV13) S:RAERR RAERR=3 Q:RAERR
 S RANEW(75.1,"+1,",22)=+RAPV13
 ;check the GUI version of CPRS at this facility:
 ;$$PATCH^XPDUTL("OR*3.0*243")=1 CPRS V27, else CPRS V26.
 I '$$PATCH^XPDUTL("OR*3.0*243") D  Q:RAERR  ;P86
 .I RAPV12="I",$P(^SC($P(RAPV13,U,1),0),U,3)'="W" S RAERR=9 Q
 .I RAPV12="O",$P(^SC($P(RAPV13,U,1),0),U,3)="W" S RAERR=9
 .Q
 S RAPV119=$P(RADATA,RAHLFS,19)
 Q
ORC ; breakdown the 'ORC' segment
 ; RAORC7D is: timestamp HL7 format
 ; RAORC7P is: priority/urgency
 S:+RAORC2'>0 RAERR=16 Q:RAERR
 S RANEW(75.1,"+1,",7)=+RAORC2
 S RANEW(75.1,"+1,",5)=5
 S RAORC7=$P(RADATA,RAHLFS,7)
 S RAORC7D=$P(RAORC7,RAECH(1),4)
 S RAORC7D=$$FMDATE^HLFNC(RAORC7D)
 S RAERR=$$EN1^RAO7VLD(75.1,21,"E",RAORC7D,"RASULT","") S:RAERR RAERR=28 Q:RAERR
 S RANEW(75.1,"+1,",21)=RAORC7D
 S X=$P(RAORC7,RAECH(1),6)
 S RAORC7P=$S(X="S":1,X="A":2,X="R":9,1:"") I +RAORC7P'>0 S RAERR=5 Q
 S RANEW(75.1,"+1,",6)=RAORC7P
 S RAORC10=$P(RADATA,RAHLFS,10)
 S RAERR=$$EN3^RAO7VLD(200,RAORC10) S:RAERR RAERR=4 Q:RAERR
 S RANEW(75.1,"+1,",15)=RAORC10
 S RAORC11=$P(RADATA,RAHLFS,11) ;approving rad/nm phys for some proc's
 I $G(RAORC11) S RAERR=$$EN3^RAO7VLD(200,RAORC11) S:RAERR RAERR=36 Q:RAERR
 I $G(RAORC11) S RANEW(75.1,"+1,",8)=RAORC11
 S RAORC12=$P(RADATA,RAHLFS,12)
 S RAERR=$$EN3^RAO7VLD(200,RAORC12) S:RAERR RAERR=6 Q:RAERR
 S RANEW(75.1,"+1,",14)=RAORC12
 S RAORC15=$P(RADATA,RAHLFS,15)
 S RAORC15=$$FMDATE^HLFNC(RAORC15)
 ;The order entered dt/time validity ck results are ignored because we
 ;have never been able to determine why FileMan erroneously rejects
 ;some date/times in a Silent FM call.  We now assume this date is OK.
 S RAERR=$$EN1^RAO7VLD(75.1,16,"E",RAORC15,"RASULT","") S:RAERR RAERR=35
 ;Q:RAERR
 I RAERR D  S RAERR=0
 . N I,RAX,RAVARS,RAERRDT
 . S RAX=$G(^TMP("DIERR",$J,1,"TEXT",1))
 . S RAERRDT=$$NOW^XLFDT()
 . F I="RAX","RAORC15","RAERRDT","RAERR" S RAVARS(I)=""
 . S:$D(X) RAVARS("X")="" S:$D(%DT) RAVARS("%DT")=""
 . S:$D(%DT(0)) RAVARS("%DT(0)")=""
 . ;S RAVARS("RAX")="",RAVARS("RAORC15")="",RAVARS("RAERRDT")="",RAVARS("RAERR")=""
 . D EN^ORERR("RAD MYSTERY ERROR",.RAMSG,.RAVARS)
 . Q
 S RANOW=$$NOW^XLFDT() I RANOW<RAORC15 S RAERR=7 Q
 S RANEW(75.1,"+1,",16)=RAORC15
 Q
ERR ; error control - file 'soft' errors with CPRS
 N RAVAR S RAVAR("XQY0")=""
 D ERR^RAO7UTL("HL7 message with unknown segment header",.RAMSG,.RAVAR)
 Q
