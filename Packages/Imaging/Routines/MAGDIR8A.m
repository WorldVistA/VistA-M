MAGDIR8A ;WOIFO/PMK,JSJ - Read a DICOM image file ; Jul 14, 2021@09:50:40
 ;;3.0;IMAGING;**11,51,49,123,138,231,307**;Mar 19, 2002;Build 28
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
 ; M2MB server
 ;
 ; Reference to FIND1^DIC in ICR #2051
 ; Reference to GET1^DIQ in ICR #2056
 ; Reference to ACCFIND^RAAPI in ICR #5020
 ; Reference to ^RA(70 in ICR #1172
 ; Reference to ^RA(72 in ICR #1174
 ;
 ; Lookup the patient/study in the imaging service's database
 ; Different entry points are invoked from LOOKUP^MAGDIR81
 ;
RADLKUP ; Radiology patient/study lookup -- called by ^MAGDIR81
 ; (also invoked by ^MAGDEXC4, ^MAGDFND4 and ^MAGDIW1)
 ;
 ; returns RADATA array DFN, DATETIME, and PROCDESC
 ;
 N CPTCODE ;-- CPT code for the procedure
 N CPTNAME ;-- CPT name for the procedure
 N EXAMSTS ;-- Exam status (don't post images to CANCELLED exams)
 N PROCIEN ;-- radiology procedure ien in ^RAMIS(71)
 N RAIX ;----- cross reference subscript for case number lookup
 N RADPT1 ;--- first level subscript in ^RADPT
 N RADPT2 ;--- second level subscript in ^RADPT (after "DT")
 N RADPT3 ;--- third level subscript in ^RADPT (after "P")
 N I,LIST,VARIABLE,X,Z
 ;
 ; find the patient/study in ^RARPT using the Radiology Case Number
 K RADATA ; kill returned array of Radiology Package data
 D RADLKUP1
 S LIST="RADPT1^RADPT2^RADPT3^PROCIEN^CPTCODE^CPTNAME^Z^EXAMSTS"
 F I=1:1:$L(LIST,"^") D
 . S VARIABLE=$P(LIST,"^",I)
 . S RADATA(VARIABLE)=$G(@VARIABLE)
 . Q
 Q
 ;
RADLKUP1 ; not an entry point
 N LIST
 Q:CASENUMB=""    ;LB 12/16/98
 S X=$$ACCFIND^RAAPI(CASENUMB,.LIST)
 ;
 I X'=1 D  ; P231 PMK 11/12/2019
 . ; if accession number prefix exists, strip it off and try lookup again
 . N ANPREFIX,STRIPPEDCASENUMB
 . S ANPREFIX=$$ANPREFIX^MAGDSTAB Q:ANPREFIX=""
 . S STRIPPEDCASENUMB=$P(CASENUMB,ANPREFIX,2,999) Q:STRIPPEDCASENUMB=""
 . S X=$$ACCFIND^RAAPI(STRIPPEDCASENUMB,.LIST)
 . Q
 ;
 Q:X'=1  S X=LIST(1) ; two conditions, no accession number & duplicate
 S RADPT1=$P(X,"^",1),RADPT2=$P(X,"^",2),RADPT3=$P(X,"^",3)
 I '$D(^RADPT(RADPT1,0)) Q  ; no patient demographics file pointer
 ; get patient demographics file pointer
 S X=^RADPT(RADPT1,0),DFN=$P(X,"^")
 I '$D(^RADPT(RADPT1,"DT",RADPT2,0)) Q  ; no datetime level
 ; get date and time of examination
 S DATETIME=$P($G(^RADPT(RADPT1,"DT",RADPT2,0)),"^",1)
 ; get case info
 S X=$G(^RADPT(RADPT1,"DT",RADPT2,"P",RADPT3,0))
 S PROCIEN=$P(X,"^",2),EXAMSTS=$P(X,"^",3)
 I EXAMSTS S EXAMSTS=$$GET1^DIQ(72,EXAMSTS,.01)
 S (PROCDESC,CPTNAME,CPTCODE)=""
 I 'PROCIEN Q  ; need PROCIEN to do lookup in ^RAMIS
 S Z=$G(^RAMIS(71,PROCIEN,0))
 S PROCDESC=$P(Z,"^"),CPTCODE=$P(Z,"^",9)
 S CPTNAME=PROCDESC ; approximate value since ^ICPT is not translated
 Q
 ;
CONLKUP ; CPRS Consult/Procedure patient/study lookup -- called by ^MAGDIR81
 N EXAMSTS ;-- Exam status (don't post images to CANCELLED exams)
 N CONPROC,Z
 S GMRCIEN=$$GMRCIEN^MAGDFCNV(ACNUMB) I 'GMRCIEN Q  ; check for legal consult accession number
 S DFN=$$GET1^DIQ(123,GMRCIEN,.02,"I")
 I DFN="" Q  ; no patient demographics file pointer
 S EXAMSTS=$$GET1^DIQ(123,GMRCIEN,8) ; check for cancelled exam
 I "^CANCELLED^DISCONTINUED^DISCONTINUED/EDIT^EXPIRED^"[("^"_EXAMSTS_"^") D  Q
 . S RADATA("EXAMSTS")="CANCELLED" ; value needed in PIDCHECK
 . Q
 S PROCDESC=$$GET1^DIQ(123,GMRCIEN,1)
 S Z=$$GET1^DIQ(123,GMRCIEN,13,"I") ; request type
 S CONPROC=$S(Z="C":"CONSULT",Z="P":"PROCEDURE",1:"UNKNOWN")
 Q
 ;
LABLKUP ; Lab patient/study lookup -- called by ^MAGDIR81
 N ABBR,CASE,FMYEAR,LRAA,IENS,YEAR  ;P307
 S ABBR=$P(ACNUMB," ",1),YEAR=$P(ACNUMB," ",2),CASE=$P(ACNUMB," ",3) ;P307
 S LRAA=$$FIND1^DIC(68,"","BX",ABBR,"","","ERR") ; get lab area index ;P307
 S LRSS=$$GET1^DIQ(68,LRAA,.02,"I") ;P307
 S PROCDESC=$$GET1^DIQ(68,LRAA,.01)
 S FMYEAR="3"_YEAR_"0000"
 S IENS=CASE_","_FMYEAR_","_LRAA
 ; lookup in ACCESSION file (#68)
 S LRDFN=$$GET1^DIQ(68.02,IENS,.01)
 I LRDFN="" Q  ; no AP study
 I $$GET1^DIQ(68.02,IENS,1)'="PATIENT" Q  ; patient not in PATIENT file (#2)
 I $$GET1^DIQ(68.02,IENS,15)'=ACNUMB Q  ; not right specimen
 S LRI=$$GET1^DIQ(68.02,IENS,13.5,"I")
 ; lookup in LAB DATA file (#63)
 I $$GET1^DIQ(63,LRDFN,.02)'="PATIENT" Q  ; patient not in PATIENT file (#2)
 S DFN=$$GET1^DIQ(63,LRDFN,.03,"I")
 Q
 ;
PIDCHECK() ; compare VistA patient ID with DICOM patient ID
 N CHECK ;---- patient demographic comparison check value
 N FIRSTVAH ;- patient first name from VADM(1)
 N IDDCM ;---- patient id, w/o punctuation, from image header
 N IDVAH ;---- patient id from VADM(2)
 N LASTVAH ;-- patient last name from VADM(1)
 N MIVAH ;---- patient middle initial from VADM(1)
 N DIQUIET,I,VA,VAERR,X,Y
 ;
 S X=PNAMEDCM X ^%ZOSF("UPPERCASE") S PNAMEDCM=Y
 ; parse the DICOM patient name (2 formats)
 I PNAMEDCM["^" D  ; DICOM format patient name
 . S LASTDCM=$P(PNAMEDCM,"^"),FIRSTDCM=$P(PNAMEDCM,"^",2)
 . S MIDCM=$P(PNAMEDCM,"^",3)
 . Q
 E  I PNAMEDCM["," D  ; ACR-NEMA format patient name
 . F  Q:'$F(PNAMEDCM,", ")  D  ; remove blanks after last name comma
 . . S PNAMEDCM=$P(PNAMEDCM,", ")_","_$P(PNAMEDCM,", ",2,999)
 . . Q
 . S LASTDCM=$P(PNAMEDCM,","),FIRSTDCM=$P(PNAMEDCM,",",2)
 . S MIDCM=$S(PNAMEDCM[",":$P(FIRSTDCM,",",2),1:$P(FIRSTDCM," ",2,999))
 . Q
 E  D  ; patient name in "last first mi" order with space delimiters
 . S LASTDCM=$P(PNAMEDCM," "),FIRSTDCM=$P(PNAMEDCM," ",2)
 . S MIDCM=$P(PNAMEDCM," ",3)
 . Q
 S FIRSTDCM=$S(FIRSTDCM[",":$P(FIRSTDCM,","),1:$P(FIRSTDCM," "))
 ; only check the first part of the name
 ; remove dashes and atypical punctuation from the DICOM PID
 S IDDCM="" F I=1:1:$L(PID) I $E(PID,I)?1AN S IDDCM=IDDCM_$E(PID,I)
 ;
 I CASENUMB="" Q "-1,NO CASE #"
 I '$G(DFN) Q "-2,BAD CASE #"
 I $G(RADATA("EXAMSTS"))="CANCELLED" Q "-3,CANCELLED"
 ;
 ; lookup patient in VistA database
 S DIQUIET=1 D DEM^MAGSPID($G(INSTLOC)) ; P123
 S PNAMEVAH=VADM(1)
 S LASTVAH=$P(PNAMEVAH,","),FIRSTVAH=$P(PNAMEVAH,",",2)
 S MIVAH=$TR($P(FIRSTVAH," ",2,999),"."),FIRSTVAH=$P(FIRSTVAH," ")
 I $$ISIHS^MAGSPID() S (IDVAH,DCMPID)=VA("PID")  ; P123 proper VA/IHS PID
 E  S IDVAH=$P(VADM(2),"^"),DCMPID=$P(VADM(2),"^",2)
 ;
 ; compare the values - allow a single transposition in the patient name,
 ; but require exact patient id values (i.e., social security numbers)
 S CHECK=(5*$$COMPARE(LASTDCM,LASTVAH))
 S CHECK=CHECK+(5*$$COMPARE($E(FIRSTDCM,1,6),$E(FIRSTVAH,1,6)))
 S CHECK=CHECK+(1*$$COMPARE(MIDCM,MIVAH))
 S CHECK=CHECK+(5*(IDDCM=IDVAH)) ; patient id requires an exact match
 I CHECK<14.5 Q "-4,PID ERROR" ; require an "almost exact" match
 Q 0  ; correct patient
 ;
COMPARE(A,B) ; pattern match checker
 Q:A=B 1 ; exact match
 Q:A="" 0 Q:B="" 0 ; don't count missing data
 ; calculate fractional value for pattern match
 N I,LENGTH,MATCH
 S MATCH=0,LENGTH=$S($L(B)>$L(A):$L(B),1:$L(A))
 F I=1:1:LENGTH D
 . I $E(A,I)=$E(B,I) S MATCH=MATCH+1
 . E  I $E(A,I)=$E(B,I-1) S MATCH=MATCH+.25
 . E  I $E(A,I)=$E(B,I+1) S MATCH=MATCH+.25
 . E  I $E(A,I-1)=$E(B,I) S MATCH=MATCH+.25
 . E  I $E(A,I+1)=$E(B,I) S MATCH=MATCH+.25
 . Q
 Q MATCH/LENGTH ; return fractional pattern match value
