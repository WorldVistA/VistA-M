MAGT7SI ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build - IPC ;04 May 2017 10:40 AM
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
IPCSEG(SEGELTS,DFN,ACNUMB) ; FUNCTION - main entry point - create an IPC segment
 I $D(^MAGD(2006.15,1,"UID ROOT"))#10=0 Q "-1010`No study instance UID root on file"
 N STATNUMB ; station number
 N DIGIT ; 'digit' in station number
 N I ; scratch loop index
 N STUDYUID ; study instance UID
 N FLDACCID S FLDACCID=1 ; accession ID field number
 N FLDREQPROCID S FLDREQPROCID=2 ; requested procedure ID field number
 N FLDSTUDYUID S FLDSTUDYUID=3 ; study instance UID field number
 N FLDSPSID S FLDSPSID=4 ; scheduled procedure step ID field number
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 K SEGELTS ; always refresh *segment* array (not message array) on entry
 ;
 D SET^HLOAPI(.SEGELTS,"IPC",0) ; segment type
 D  ; set up fields, check exit flag after each
 . D  Q:ERRSTAT  ; IPC-1-accession identifier
 . . D SET^HLOAPI(.SEGELTS,ACNUMB,FLDACCID)
 . . Q
 . D  Q:ERRSTAT  ; IPC-2-requested procedure ID
 . . D SET^HLOAPI(.SEGELTS,ACNUMB,FLDREQPROCID)
 . . Q
 . D  Q:ERRSTAT  ; IPC-3-study instance UID
 . . S STUDYUID=$$UID^MAGT7SI(DFN,ACNUMB,"STUDY")
 . . D SET^HLOAPI(.SEGELTS,STUDYUID,FLDSTUDYUID)
 . . Q
 . D  Q:ERRSTAT  ; IPC-4-scheduled procedure step ID
 . . D SET^HLOAPI(.SEGELTS,ACNUMB,FLDSPSID)
 . . Q
 . Q
 ;
 Q ERRSTAT
 ;
UID(DFN,ACNUMB,TYPE,EXTENSION) ; generate a Study, Container, or Specimen UID
 ; DFN ------- file #2 patient identifier
 ; ACNUMB ---- accession number
 ; TYPE ------ "STUDY", "CONTAINER", or "SPECIMEN"
 ; EXTENSION - a number to add at the end
 ;
 N C,I,J,P,UID,UIDTYPE
 S DFN=$G(DFN) I 'DFN Q "-1, DFN value is wrong: """_DFN_""""
 S ACNUMB=$G(ACNUMB) I ACNUMB="" Q "-2, Accession Number is NULL"
 S TYPE=$G(TYPE)
 S UIDTYPE=$S(TYPE="STUDY":4,TYPE="CONTAINER":5,TYPE="SPECIMEN":6,1:-1)
 I UIDTYPE<0 Q "-3, Type is """_TYPE_""" It must be STUDY, CONTAINER, or SPECIMEN."
 S EXTENSION=$G(EXTENSION) ; optional
 S UID=^MAGD(2006.15,1,"UID ROOT")_".1."_UIDTYPE_"."_$$STATNUMB^MAGDFCNV()
 S UID=UID_"."_DFN
 F I=1:1:$L(ACNUMB," ") S P=$P(ACNUMB," ",I) D
 . S UID=UID_"."
 . I P?1N.N S UID=UID_P Q
 . ; convert non-numerics to ASCII equivalent
 . F J=1:1:$L(P) S UID=UID_$A($E(P,J))
 . Q
 I EXTENSION'="" S UID=UID_"."_EXTENSION
 Q UID
