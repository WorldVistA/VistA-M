MAGDRPCC ;WOIFO/PMK- Imaging RPCs ; 31 Jul 2013 11:17 AM
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
 ;
CONLKUP(OUT,ACNUMB) ; RPC = MAG DICOM LOOKUP CON STUDY
 ; Consult patient/study lookup
 N A ;-------- array data from $$GETS^DIQ
 N CPTIEN ;--- ien for file #81
 N CPTCODE ;-- CPT code for the procedure
 N CPTNAME ;-- CPT name for the procedure
 N CPTSCHM ;-- CPT coding scheme
 N DATETIME ;- timestamp
 N DIVISION ;- pointer to INSTITUTION file (#4)
 N DFN ;------ patient pointer
 N EXAMSTS ;-- exam status (don't post images to CANCELLED exams)
 N GMRCIEN ;-- IEN for REQUEST/CONSULTATION file (#123)
 N GMRCIENS ;- GMRC concatenated with a comma (for GETS^DIQ results)
 N PROCEDURE ; procedure (#123.3) <internal ^ external>
 N PROCIEN ;-- radiology procedure ien in ^RAMIS(71)
 N SERVICE ;-- request service (#123.5) <internal ^ external)>
 N TIMESTAMP ; date/time of last activity
 N VACODE ;--- VA code for the procedure
 N VANAME ;--- VA name for the procedure
 N VASCHM ;-- VA coding scheme
 N IEN,X
 ; find the patient/study in ^GMR using the Consult Accession Number
 K OUT
 ;
 I $G(ACNUMB)="" S OUT(1)="-1,No Accession Number Specified" Q
 ;
 S GMRCIEN=$$GMRCIEN^MAGDFCNV(ACNUMB),GMRCIENS=GMRCIEN_","
 ;
 D GETS^DIQ(123,GMRCIEN,"**","EI","A")
 I '$D(A) S OUT(1)="-2,Error in Accession Number Lookup" Q
 ;
 ; get patient demographics file pointer
 S DFN=A(123,GMRCIENS,.02,"I")
 ;
 ; get the request service and procedure (if present)
 S SERVICE=A(123,GMRCIENS,1,"I")_"^"_A(123,GMRCIENS,1,"E")
 S X=A(123,GMRCIENS,4,"I") I X?1N.N1";GMR(123.3," S X=$P(X,";",1)
 S PROCEDURE=X_"^"_A(123,GMRCIENS,4,"E")
 I PROCEDURE="^" D  ; consult
 . S VACODE="C"_$P(SERVICE,"^",1)
 . S VANAME=$P(SERVICE,"^",2)
 . S VASCHM="99CON"
 . Q
 E  D  ; procedure
 . S VACODE="P"_$P(PROCEDURE,"^",1)
 . S VANAME=$P(PROCEDURE,"^",2)
 . S VASCHM="99PROC"
 . Q
 ;
 ; get CPT code and CPT name
 S IEN=$$IREQUEST^MAGDHOW1(+SERVICE,+PROCEDURE)
 I IEN S CPTIEN=$P(^MAG(2006.5831,IEN,0),"^",6)
 E  S CPTIEN=""
 I CPTIEN'="" D
 . S CPTCODE=$$GET1^DIQ(81,CPTIEN,.01)
 . S CPTNAME=$$GET1^DIQ(81,CPTIEN,2)
 . S CPTSCHM="C4"
 . Q
 E  D  ; use VA values for CPT
 . S CPTCODE=VACODE
 . S CPTNAME=VANAME
 . S CPTSCHM=VASCHM
 . Q
 ;
 ; get exam status
 S EXAMSTS=A(123,GMRCIENS,8,"E")
 ;
 S TIMESTAMP=A(123.02,"1,"_GMRCIENS,2,"I")
 ;
 ; stuff the data into the return array
 ;
 S OUT(1)=1 ; OK
 S OUT(2)=DFN
 S OUT(3)=SERVICE
 S OUT(4)=PROCEDURE
 S OUT(5)=VACODE
 S OUT(6)=VANAME
 S OUT(7)=VASCHM
 S OUT(8)=CPTCODE
 S OUT(9)=CPTNAME
 S OUT(10)=CPTSCHM
 S OUT(11)=$G(TIMESTAMP)
 S OUT(12)=EXAMSTS
 S OUT(13)=$$STATNUMB^MAGDFCNV()
 S OUT(14)=$$GMRCACN^MAGDFCNV(GMRCIEN)
 S OUT(15)=GMRCIEN
 Q
