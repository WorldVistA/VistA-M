MAGDIR8A ;WOIFO/PMK - Read a DICOM image file ; 03/08/2005  07:02
 ;;3.0;IMAGING;**11,51**;26-August-2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
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
 Q:CASENUMB=""    ;LB 12/16/98
 S RAIX=$S($D(^RADPT("C")):"C",1:"AE") ; for Radiology Patch RA*5*7
 S RAIX=$S(CASENUMB["-":"ADC",1:RAIX) ; select the cross-reference
 S RADPT1=$O(^RADPT(RAIX,CASENUMB,"")) I 'RADPT1 Q
 S RADPT2=$O(^RADPT(RAIX,CASENUMB,RADPT1,"")) I 'RADPT2 Q
 S RADPT3=$O(^RADPT(RAIX,CASENUMB,RADPT1,RADPT2,"")) I 'RADPT3 Q
 S X=$O(^RADPT(RAIX,CASENUMB,RADPT1,RADPT2,RADPT3))
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
 I ACNUMB'?1"GMRC-".1N.N Q
 S GMRCIEN=$P(ACNUMB,"-",2)
 S DFN=$$GET1^DIQ(123,GMRCIEN,.02,"I")
 I DFN="" Q  ; no patient demographics file pointer
 S EXAMSTS=$$GET1^DIQ(123,GMRCIEN,8) ; check for cancelled exam
 I EXAMSTS="CANCELLED" S RADATA("EXAMSTS")=EXAMSTS Q
 S PROCDESC=$$GET1^DIQ(123,GMRCIEN,1)
 S Z=$$GET1^DIQ(123,GMRCIEN,13,"I") ; request type
 S CONPROC=$S(Z="C":"CONSULT",Z="P":"PROCEDURE",1:"UNKNOWN")
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
 S DIQUIET=1 D DEM^VADPT
 S PNAMEVAH=VADM(1)
 S LASTVAH=$P(PNAMEVAH,","),FIRSTVAH=$P(PNAMEVAH,",",2)
 S MIVAH=$TR($P(FIRSTVAH," ",2,999),"."),FIRSTVAH=$P(FIRSTVAH," ")
 S IDVAH=$P(VADM(2),"^"),DCMPID=$P(VADM(2),"^",2)
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
