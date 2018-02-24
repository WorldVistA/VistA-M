MAGT7S ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build;04 May 2017 11:21 AM
 ;;3.0;IMAGING;**138,183**;Mar 19, 2002;Build 11;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; Supported IA #4716 reference ^HLOAPI function calls
 ;
 Q
 ;
SEGADD(MSG,FILE,LABDATA,STATE,SEGNAME,DFN,LRDFN,LRSS,LRI,IENS,ACNUMB) ; FUNCTION - main entry point - create a segment
 I $G(SEGNAME)'?1U2NU Q "-4010`Invalid segment name (SEGNAME="_$G(SEGNAME)_")"
 N SPMDT ; specimen date
 N SEGELTS ; segment element array
 N IENSX,IX ; indices for NTE and SPM
 ;
 N ERRMSG ; Error message
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 D  ; SWITCH on segment name
 . I SEGNAME="PID" D  Q  ; get pt number and populate the PID segment
 . . D PIDPV1^MAGDHOW2(.MSG,DFN) ; P183 PMK 3/7/17
 . . Q
 . I SEGNAME="PV1" Q  ; done above in PIDPIV1^MAGDHOW2 - P183 PMK 3/7/17
 . ;
 . I SEGNAME="ORC" D  Q
 . . S ERRSTAT=$$ORCSEG^MAGT7SO(.SEGELTS,.FILE,STATE,IENS,ACNUMB) Q:ERRSTAT
 . . I '$$ADDSEG^HLOAPI(.MSG,.SEGELTS,.ERRMSG) D  Q
 . . . S ERRSTAT="-2`HLO SEGMENT INSERTION ERROR ("_ERRMSG_")"
 . . . Q
 . . Q
 . I SEGNAME="TQ1" D  Q
 . . S ERRSTAT=$$TQ1SEG^MAGT7ST(.SEGELTS,DFN) Q:ERRSTAT
 . . I '$$ADDSEG^HLOAPI(.MSG,.SEGELTS,.ERRMSG) D  Q
 . . . S ERRSTAT="-2`HLO SEGMENT INSERTION ERROR ("_ERRMSG_")"
 . . . Q
 . . Q
 . I SEGNAME="OBR" D  Q
 . . S ERRSTAT=$$OBRSEG^MAGT7SB(.SEGELTS,.FILE,LRSS,IENS,ACNUMB) Q:ERRSTAT
 . . I '$$ADDSEG^HLOAPI(.MSG,.SEGELTS,.ERRMSG) D  Q
 . . . S ERRSTAT="-2`HLO SEGMENT INSERTION ERROR ("_ERRMSG_")"
 . . . Q
 . . Q
 . I SEGNAME="NTE" D  Q
 . . S IENSX=""
 . . F  S IENSX=$O(@LABDATA@(FILE("COMMENT"),IENSX)) Q:IENSX=""  D  Q:ERRSTAT
 . . . S IX=$P(IENSX,",",1)
 . . . S ERRSTAT=$$NTESEGC^MAGT7SN(.SEGELTS,.FILE,IENSX,ACNUMB,IX) Q:ERRSTAT
 . . . I '$$ADDSEG^HLOAPI(.MSG,.SEGELTS,.ERRMSG) D  Q
 . . . . S ERRSTAT="-2`HLO SEGMENT INSERTION ERROR ("_ERRMSG_")"
 . . . . Q
 . . . Q
 . . Q
 . I SEGNAME="SPM" D  Q
 . . S IENSX=""
 . . F  S IENSX=$O(@LABDATA@(FILE("SPECIMEN"),IENSX)) Q:IENSX=""  D  Q:ERRSTAT
 . . . S IX=$P(IENSX,",",1)
 . . . S ERRSTAT=$$SPMSEG^MAGT7SS(.SEGELTS,.FILE,IENS,IENSX,ACNUMB,IX) Q:ERRSTAT
 . . . I '$$ADDSEG^HLOAPI(.MSG,.SEGELTS,.ERRMSG) D  Q
 . . . . S ERRSTAT="-2`HLO SEGMENT INSERTION ERROR ("_ERRMSG_")"
 . . . . Q
 . . . ; send ancillary specimen attributes in OBX segments
 . . . S ERRSTAT=$$SPMANC^MAGT7SSA(.MSG,.FILE,IENSX,LRSS,IX)
 . . . Q
 . . Q
 . I SEGNAME="IPC" D  Q
 . . S ERRSTAT=$$IPCSEG^MAGT7SI(.SEGELTS,DFN,ACNUMB) Q:ERRSTAT
 . . I '$$ADDSEG^HLOAPI(.MSG,.SEGELTS,.ERRMSG) D  Q
 . . . S ERRSTAT="-2`HLO SEGMENT INSERTION ERROR ("_ERRMSG_")"
 . . . Q
 . . Q
 . I SEGNAME="TXT" D  Q  ; output text objects as NTE segments
 . . N SS3,TITLE
 . . I 'ERRSTAT S TITLE="BRIEF CLINICAL HISTORY",SS3=.013 S ERRSTAT=$$BUILD(.SEGELTS,.FILE,IENS,TITLE,SS3) Q:ERRSTAT
 . . I 'ERRSTAT S TITLE="PREOPERATIVE DIAGNOSIS",SS3=.014 S ERRSTAT=$$BUILD(.SEGELTS,.FILE,IENS,TITLE,SS3) Q:ERRSTAT
 . . I 'ERRSTAT S TITLE="OPERATIVE FINDINGS",SS3=.015 S ERRSTAT=$$BUILD(.SEGELTS,.FILE,IENS,TITLE,SS3) Q:ERRSTAT
 . . I 'ERRSTAT S TITLE="POSTOPERATIVE FINDINGS",SS3=.016 S ERRSTAT=$$BUILD(.SEGELTS,.FILE,IENS,TITLE,SS3) Q:ERRSTAT
 . . I 'ERRSTAT S TITLE="GROSS DESCRIPTION",SS3=1 S ERRSTAT=$$BUILD(.SEGELTS,.FILE,IENS,TITLE,SS3) Q:ERRSTAT
 . . I 'ERRSTAT S TITLE="MICROSCOPIC DESCRIPTION",SS3=1.1 S ERRSTAT=$$BUILD(.SEGELTS,.FILE,IENS,TITLE,SS3) Q:ERRSTAT
 . . I 'ERRSTAT S TITLE="DIAGNOSIS",SS3=1.4 S ERRSTAT=$$BUILD(.SEGELTS,.FILE,IENS,TITLE,SS3) Q:ERRSTAT
 . . Q
 . S ERRSTAT="-3`unrecognized segment name ("_SEGNAME_")"
 . Q
 Q ERRSTAT
 ;
BUILD(SEGELTS,FILE,IENS,TITLE,SS3) ; output an NTE segment for each line of the result
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 N I,FIRST,TEXT
 S I="",FIRST=1
 F  S I=$O(@LABDATA@(FILE(0),IENS,SS3,I)) Q:'I  D  Q:ERRSTAT
 . I FIRST D  S FIRST=0
 . . S TEXT="" S ERRSTAT=$$BUILD1(.SEGELTS,TEXT) Q:ERRSTAT
 . . S TEXT=TITLE S ERRSTAT=$$BUILD1(.SEGELTS,TEXT) Q:ERRSTAT
 . . S TEXT=$TR($J("",$L(TITLE))," ","-") S ERRSTAT=$$BUILD1(.SEGELTS,TEXT) Q:ERRSTAT
 . S TEXT=@LABDATA@(FILE(0),IENS,SS3,I) S ERRSTAT=$$BUILD1(.SEGELTS,TEXT) Q:ERRSTAT
 . Q
 Q ERRSTAT
 ;
BUILD1(SEGELTS,TEXT) ; output one NTE segment
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 D
 . S ERRSTAT=$$NTESEGT^MAGT7SN(.SEGELTS,TEXT) Q:ERRSTAT
 . I '$$ADDSEG^HLOAPI(.MSG,.SEGELTS,.ERRMSG) D  Q
 . . S ERRSTAT="-2`HLO SEGMENT INSERTION ERROR ("_ERRMSG_")"
 . . Q
 . Q
 Q ERRSTAT
