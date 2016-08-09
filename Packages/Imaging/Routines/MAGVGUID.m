MAGVGUID ;WOIFO/RRB,DAC - Duplicate DICOM Study, Series, & SOP Instance UID Checks ; 23 Nov 2015 3:17 PM
 ;;3.0;IMAGING;**118,138,162**;Mar 19, 2002;Build 22;Nov 23, 2015
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
 ; check for duplicate SOP Instance UID
SOP(DFN,ACNUMB,STUDYUID,SERIESUID,SOPUID) ;
 N MAGIEN ;--- ien of 2005 DICOM object
 N DUPSOP ;--- -1 = Error, 1 = Duplicate UID, 2 = RESEND 
 ; 
 ; is there a DICOM object on file with this SOP Instance UID?
 I '$O(^MAG(2005,"P",SOPUID,0)) Q 0 ; nope
 ;
 ; is the same DICOM object already on file?
 ; there might be multiples and we have to check each one
 S MAGIEN=0,DUPSOP=0
 F  S MAGIEN=$O(^MAG(2005,"P",SOPUID,MAGIEN)) Q:MAGIEN=""  D  Q:DUPSOP
 . S DUPSOP=$$SAMEIMG(MAGIEN,DFN,STUDYUID,SERIESUID)
 . Q
 S DUPSOP=$S(DUPSOP=0:2,1:DUPSOP)
 Q DUPSOP
 ;
SAMEIMG(MAGIEN,DFN,STUDYUID,SERIESUID) ; check DFN and study & series UIDs
 N MAG0 ;----- 0-node of file 2005
 N MAGDFN ;--- DFN of designated image
 N MAGGROUP ;- pointer to the image group
 N MAGPTR,MAGACN
 N OLDSTUDY,OLDSERIES ; UIDs of the original series or study
 ; check for defined arguments
 Q:$G(MAGIEN)="" -1
 Q:$G(DFN)="" -1
 Q:$G(STUDYUID)="" -1
 Q:$G(SERIESUID)="" -1
 S MAG0=$G(^MAG(2005,MAGIEN,0)) Q:MAG0="" -1 ; no 0-node
 S MAGDFN=$P(MAG0,"^",7) Q:DFN'=MAGDFN 1 ; different patient
 S MAGGROUP=$P(MAG0,"^",10)
 ; P162 DAC - Accession Number Check producing duplicates instread of resends
 S OLDSTUDY=$S(MAGGROUP:$P($G(^MAG(2005,MAGGROUP,"PACS")),"^",1),1:"")
 I $L(OLDSTUDY),OLDSTUDY'=STUDYUID Q 1  ; different study instance UIDs
 S OLDSERIES=$G(^MAG(2005,MAGIEN,"SERIESUID"))
 I $L(OLDSERIES),OLDSERIES'=SERIESUID Q 1  ; different series instance UIDs
 Q 0
 ;
 ; check for duplicate Series Instance UID
SERIES(DFN,ACNUMB,STUDYUID,SERIESUID) ;
 N MAG0 ;----- 0-node of file 2005
 N MAGACN ;--- accession number of 2005 DICOM object
 N MAGIEN ;--- ien of 2005 DICOM object
 N MAGIENG ;-- ien of 2005 DICOM object in group file (2005.04)
 N MAGDFN ;--- DFN of designated image
 N MAGGROUP ;- pointer to the image group
 N MAGSTUID ;- study instance uid of 2005 DICOM object
 N DUPSERIES
 N I,X
 ;
 ; is there a DICOM object on file with this Series Instance UID?
 I '$O(^MAG(2005,"SERIESUID",SERIESUID,0)) Q 0 ; nope
 ;
 K ^TMP("MAG",$J,"SERIES UID")
 ;
 ; First pass - get the list of DICOM objects for this series
 ; 
 S MAGIEN=0
 F  S MAGIEN=$O(^MAG(2005,"SERIESUID",SERIESUID,MAGIEN)) Q:MAGIEN=""  D
 . S ^TMP("MAG",$J,"SERIES UID",MAGIEN)=""
 . Q
 ;
 ; Second pass - for each DICOM object on file, do the following steps
 ; 1) look up the group and get DFN, ACNUMB, Study Instance UID
 ; 2) record this information for the first DICOM object in each group
 ; 3) skip other DICOM objects in same group - redundant information
 ; 
 S MAGIEN=0
 F  S MAGIEN=$O(^TMP("MAG",$J,"SERIES UID",MAGIEN)) Q:'MAGIEN  S X=^(MAGIEN) D
 . Q:X?1"SKIP".E  ; skip DICOM objects in groups that were already processed
 . S MAG0=$G(^MAG(2005,MAGIEN,0)) Q:MAG0=""
 . S MAGDFN=$P(MAG0,"^",7),MAGGROUP=$P(MAG0,"^",10)
 . S MAGSTUID=$P($G(^MAG(2005,MAGGROUP,"PACS")),"^",1)
 . S MAGACN=$$GETACN(MAGIEN)
 . S X=MAGDFN_"^"_MAGACN_"^"_MAGSTUID
 . S ^TMP("MAG",$J,"SERIES UID",MAGIEN)=X
 . ; go through the object group file (2005.04) and remove redundancies
 . S I=0 F  S I=$O(^MAG(2005,MAGGROUP,1,I)) Q:'I  S X=^(I,0) D
 . . S MAGIENG=$P(X,"^",1) Q:MAGIENG=MAGIEN  ; keep first object 
 . . I $D(^TMP("MAG",$J,"SERIES UID",MAGIENG)) S ^(MAGIENG)="SKIP-"_MAGIEN
 . . Q
 . Q
 ;
 ; Third pass - check remaining entries in ^TMP for duplicates
 ; 
 S MAGIEN="",DUPSERIES=0
 F  S MAGIEN=$O(^TMP("MAG",$J,"SERIES UID",MAGIEN)) Q:MAGIEN=""  D  Q:DUPSERIES
 . S X=^TMP("MAG",$J,"SERIES UID",MAGIEN)
 . Q:X["SKIP"
 . S MAGDFN=$P(X,"^",1),MAGACN=$P(X,"^",2),MAGSTUID=$P(X,"^",3)
 . S DUPSERIES=1
 . I DFN=MAGDFN,ACNUMB=MAGACN,STUDYUID=MAGSTUID S DUPSERIES=0
 . Q
 ;
 Q DUPSERIES
 ;
 ; check for duplicate Study Instance UID
STUDY(DFN,ACNUMB,STUDYUID) ;
 N HIT ;------ switch
 N MAGIEN ;--- ien of 2005 DICOM object
 ;
 ; is there a DICOM object on file with this Study Instance UID?
 I '$O(^MAG(2005,"P",STUDYUID,0)) Q 0 ; nope
 ;
 ; is the same DICOM object already on file?
 ; there might be multiples and we have to check each one
 S (HIT,MAGIEN)=0
 F  S MAGIEN=$O(^MAG(2005,"P",STUDYUID,MAGIEN)) Q:MAGIEN=""  D  Q:HIT
 . S HIT=$$SAMESTDY(MAGIEN,DFN,ACNUMB)
 . Q
 ;
 Q HIT
 ;
SAMESTDY(MAGIEN,DFN,ACNUMB) ;
 N MAG0 ; 0-node and 2-node of file 2005
 N MAGDFN ; DFN of designated image
 S MAG0=$G(^MAG(2005,MAGIEN,0)) Q:MAG0="" -1 ; no 0-node
 S MAGDFN=$P(MAG0,"^",7) Q:DFN'=MAGDFN 1 ; different patient
 I ACNUMB'=$$GETACN(MAGIEN) Q 1  ; different accession
 Q 0
 ;
GETACN(MAGIEN) ; return the accession number of a study
 N ACNUMBVAH ; VA HIS accession number
 N DATETIME ; Accession DateTime
 N MAG2 ; 2-node of file 2005
 N RARPT0 ; 0-node of ^RARPT
 N RADPT0 ; 0-node of ^RADPT
 N REVDT ;
 N ROOT,POINTER ; parent data file root and pointer
 S MAG2=$G(^MAG(2005,MAGIEN,2)) Q:MAG2="" "" ; no 2-node
 S ROOT=$P(MAG2,"^",6),POINTER=$P(MAG2,"^",7)
 I ROOT=74 D
 . S RARPT0=$G(^RARPT(POINTER,0)),DATETIME=$P(RARPT0,"^",3)
 . S REVDT=9999999.9999-DATETIME
 . S RADPT0=$G(^RADPT(DFN,"DT",REVDT,"P",1,0))
 . S ACNUMBVAH=$P(RADPT0,"^",31)
 . I ACNUMBVAH="" S ACNUMBVAH=$P(RARPT0,"^",1)
 . Q
 E  I ROOT=8925 S ACNUMBVAH=$$GMRCACN^MAGDFCNV(+$$GET1^DIQ(8925,POINTER,1405,"I"))
 E  I ROOT=2006.5839 S ACNUMBVAH=$$GMRCACN^MAGDFCNV(POINTER)
 E  S ACNUMBVAH=""
 Q ACNUMBVAH
 ;
