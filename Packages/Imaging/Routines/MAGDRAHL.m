MAGDRAHL ;WOIFO/PMK,SAF - Program to read a DICOM file ; 21 Oct 2010 3:01 PM
 ;;3.0;IMAGING;**49,123**;Mar 19, 2002;Build 67;Jul 24, 2012
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
 ; This routine is invoked by RAHLR to create the HL7 ZDS segment with
 ; the Study Instance UID
 ;
 ; The following code creates a DICOM Study Instance UID from three
 ; Radiology Package variables: RADTI, RACNI, and ACNUMB
 ; Input:
 ;   RADTI -- internal subscript for the study in RADPT - reverse date/time  
 ;   RACNI -- internal subscript for the study in RADPT - counter
 ;   ACNUMB - external identifier for the study - [site number -] date-case number
 ;   
STUDYUID(RADTI,RACNI,ACNUMB) ; return the Study Instance UID
 N FLAG ;----- Flag to prevent multiple dots in a row or leading zeroes
 N I ;-------- Loop counter
 N RAW ;----- "Raw" STUDYUID
 N STATNUMB ;- Station number
 N STUDYUID ;- Resulting unique identifier
 ;
 S STATNUMB=$P($$SITE^VASITE(),"^",3) ; station number
 ;S STATNUMB=$E($P($$NS^XUAF4($$KSP^XUPARAM("INST")),U,2),1,3) ; station number
 S RAW=^MAGD(2006.15,1,"UID ROOT")_".1.4."_STATNUMB_"."_RADTI_"."_RACNI_"."_ACNUMB
 S STUDYUID="",FLAG=0 F I=1:1:$L(RAW) D
 . N E
 . S E=$E(RAW,I) S:E'?1AN E="."
 . I "123456789"[E S STUDYUID=STUDYUID_E,FLAG=1 Q
 . I E="0" S:$E(RAW,I+1)'?1AN FLAG=1 S:FLAG STUDYUID=STUDYUID_E Q
 . I E?1U S STUDYUID=STUDYUID_($A(E)),FLAG=1 Q
 . I E?1L S STUDYUID=STUDYUID_($A(E)-32),FLAG=1 Q
 . I E="." S:FLAG STUDYUID=STUDYUID_E S FLAG=0 Q
 . Q
 ; No trailing dots either
 F  Q:$E(STUDYUID,$L(STUDYUID))'="."  S STUDYUID=$E(STUDYUID,1,$L(STUDYUID)-1)
 I $L(STUDYUID)>64 S $EC=",U13-STUDY UID too long,"
 Q STUDYUID
 ;
ZDS(STUDYUID) ; returns the ZDS segment
 N HLECH1 ;--- HL7 component separator
 S HLECH1=$E(HLECH) ; HL7 component separator
 I $L(STUDYUID)>64 S $EC=",U13-STUDY UID too long,"
 Q "ZDS"_HLFS_STUDYUID_HLECH1_"VISTA"_HLECH1_"Application"_HLECH1_"DICOM"
