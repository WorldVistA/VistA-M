MAGVRD01 ;WOIFO/DAC - Radiation Dosage - Attach Instance ; 25 April 2013 10:41 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 Q
INPUTSEP() ; Name value separator for input data  ie. NAME`TESTPATIENT
 Q "`"
OUTSEP() ; Name value separator for output data ie. NAME|TESTPATIENT
 Q "|"
STATSEP() ; Status and Result separator ie. -3``No record IEN  
 Q "`"
 ; 
 ; Add an irradiation instance entry
 ;
 ; RPC: MAGV ATTACH IRRADIATION DOSE
 ;
 ; Input Variables: 
 ;                 PATIENT   - Patient DFN
 ;                 PROC      - Accession Number
 ;                 TYPE      - "FLUORO" or "CT"
 ;                 STUDYUID  - Study UID
 ;                 SERUID    - Series UID
 ;                 IIUID     - Irradiation Instance UID
 ;                 ATTS      - Array of name value pairs separated by an input separator 
 ; Output Variables:
 ;                 OUT       - Returns success and new record IEN or error and error message 
 ;
ATTACH(OUT,PATIENT,PROC,TYPE,STUDYUID,SERUID,IIUID,ATTS) ; RPC [MAGV ATTACH IRRADIATION DOSE]
 N FDA,OSEP,ISEP,SSEP,NAM,VAL,I,ATTNAMS,STUDYIEN,SERIEN
 S OSEP=$$OUTSEP,ISEP=$$INPUTSEP,SSEP=$$STATSEP
 ; Quit with error if any input variable not defined
 I $G(PATIENT)="" S OUT="-10"_SSEP_"Patient not defined" Q
 I $G(PROC)="" S OUT="-11"_SSEP_"Procedure not defined" Q
 I $G(TYPE)="" S OUT="-12"_SSEP_"Type not defined" Q
 I $G(STUDYUID)="" S OUT="-1"_SSEP_"Study UID not defined" Q
 I $G(SERUID)="" S OUT="-2"_SSEP_"Series UID not defined" Q
 I $G(IIUID)="" S OUT="-3"_SSEP_"Irradiation Instance UID not defined" Q
 I '$D(ATTS) S OUT="-13"_SSEP_"Attribute array not defined" Q
 ; Quit if Study not defined or not active
 I '$D(^MAGV(2005.62,"B",STUDYUID)) S OUT="-4"_SSEP_"Study UID not on file" Q
 S STUDYIEN=$O(^MAGV(2005.62,"B",STUDYUID,""))
 I $P($G(^MAGV(2005.62,STUDYIEN,5)),U,2)'="A" S OUT="-5"_SSEP_"Study not accessible"
 ; Quit if Series not defined or not active
 I '$D(^MAGV(2005.63,"B",SERUID)) S OUT="-6"_SSEP_"Series UID not on file" Q
 S SERIEN=$O(^MAGV(2005.63,"B",SERUID,""))
 I $P($G(^MAGV(2005.63,SERIEN,6)),U,1)'=STUDYIEN S OUT="-7"_SSEP_"Series not attached to study"
 I $P($G(^MAGV(2005.63,SERIEN,9)),U,1)'="A" S OUT="-8"_SSEP_"Series not accessible"
 ; If atts not defined quit with error
 S I=0
 F  S I=$O(ATTS(I)) Q:'I  D  Q:$D(OUT(1))
 . S NAM=$P(ATTS(I),ISEP,1),VAL=$P(ATTS(I),ISEP,2)
 . I NAM="" S OUT="-9"_SSEP_"Attribute name(s) missing from attribute array" Q
 . S ATTNAMS(NAM)=VAL
 . Q
 Q:$D(OUT) 
 ; Add Irradiation Instance to attribute array 
 S ATTNAMS("IRRADIATION INSTANCE UID")=IIUID
 ; Update Irradiation Instance table 
 I TYPE="FLUORO" D FLUORO^MAGVRD02(.OUT,.ATTNAMS,SERUID,IIUID)
 I TYPE="CT" D CT^MAGVRD02(.OUT,.ATTNAMS,SERUID,IIUID)
 Q
