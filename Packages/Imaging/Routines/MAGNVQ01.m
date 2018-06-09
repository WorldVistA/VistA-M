MAGNVQ01 ;WOIFO/NST - Retrieve study ; 11 Oct 2017 3:59 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 4525;May 01, 2013
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
GSTUDY(MAGOUT,REFTYPE,REFIEN,CONTEXT,IMGLESS)  ; Get Study by Reference and type
 ; MAGOUT  - Output array where the images will be added
 ; REFTYPE - "RAD" or "TIU" 
 ; REFIEN  - Radiology Report IEN or TIU Note IEN
 ; CONTEXT - Context ID
 ; IMGLESS - 0|1 Include images
 N STUDYUID
 ;
 S STUDYUID=$$STUDYUID(REFTYPE,REFIEN,CONTEXT) ; get Study UID
 I STUDYUID="" Q  ; No study found for the reference
 D IMGBYSTD(MAGOUT,STUDYUID,REFTYPE,REFIEN,CONTEXT,IMGLESS)
 Q
 ; 
IMGBYSTD(MAGOUT,STUDYUID,REFTYPE,REFIEN,CONTEXT,IMGLESS) ; Get a Study images
 N IARRAY,IMAGE,STYIX,SERIX,SOPIX,PROCIX,PATIX,PAT,PAT0,PATDTA
 ;
 S PAT=""
 S STYIX=""
 F  S STYIX=$O(^MAGV(2005.62,"B",STUDYUID,STYIX)) Q:'STYIX  D  Q:PAT<0
 . S PROCIX=$P($G(^MAGV(2005.62,STYIX,6)),"^",1) Q:'PROCIX
 . S PATIX=$P($G(^MAGV(2005.61,PROCIX,6)),"^",1) Q:'PATIX
 . S PATDTA=$G(^MAGV(2005.6,PATIX,0)) Q:PATDTA=""
 . S PAT0=$P(PATDTA,"^",1) S:PAT="" PAT=PAT0
 . I ($P(PATDTA,"^",3)'="D")!(PAT'=PAT0) S PAT=-1 Q
 . ; process study for valid pt
 . S SERIX=""
 . F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D
 . . N ACTVIMG
 . . S ACTVIMG=0
 . . S SOPIX=""
 . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIX,SOPIX)) Q:'SOPIX  D  Q:IMGLESS&ACTVIMG
 . . . S IMAGE=""
 . . . F  S IMAGE=$O(^MAGV(2005.65,"C",SOPIX,IMAGE)) Q:'IMAGE  D
 . . . . I $P($G(^MAGV(2005.65,IMAGE,1)),"^",5)'="I" D
 . . . . . S IARRAY(STYIX,SERIX,SOPIX,IMAGE)="",ACTVIMG=1
 . . . . Q
 . . . Q
 . . Q
 . Q
 I PAT<0 S @MAGOUT@(0)="0^Duplicate Study UID" Q
 ;
 D GETSTUDY(MAGOUT,.IARRAY,REFTYPE,REFIEN,CONTEXT) ; Get Study by graph ien
 Q
 ;
GETSTUDY(MAGOUT,IARRAY,REFTYPE,REFIEN,CONTEXT)  ; Get Study by graph ien
 N I,MAGNCNT,STYIX,SERIX,SOPIX,IMAGE
 ;
 I '$D(IARRAY) Q
 ;
 K ^TMP("MAGNVQ01",$J)
 S ^TMP("MAGNVQ01",$J)=0
 ;
 S STYIX=""
 F  S STYIX=$O(IARRAY(STYIX)) Q:'STYIX  D
 . D ASTUDY(STYIX,REFTYPE,REFIEN,CONTEXT)
 . S SERIX=""
 . F  S SERIX=$O(IARRAY(STYIX,SERIX)) Q:'SERIX  D
 . . D ASERIES(SERIX)
 . . S SOPIX=""
 . . F  S SOPIX=$O(IARRAY(STYIX,SERIX,SOPIX)) Q:'SOPIX  D
 . . . S IMAGE=$O(IARRAY(STYIX,SERIX,SOPIX,""))  ; First image instance in SOP
 . . . D ASOP(SOPIX,IMAGE)
 . . . S IMAGE=""
 . . . F  S IMAGE=$O(IARRAY(STYIX,SERIX,SOPIX,IMAGE)) Q:'IMAGE  D
 . . . . D AIMAGE(SOPIX,IMAGE)
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 ; Append it to end result
 S I=0
 S MAGNCNT=$O(@MAGOUT@(""),-1)
 F  S I=$O(^TMP("MAGNVQ01",$J,I)) Q:'I  D
 . S MAGNCNT=MAGNCNT+1
 . S @MAGOUT@(MAGNCNT)=^TMP("MAGNVQ01",$J,I)
 . Q
 I MAGNCNT S @MAGOUT@(0)=1
 Q
 ;
STUDYUID(REFTYPE,REFIEN,CONTEXT) ; Get Study UID by readiology report or TIU note
 N ACN,STDIEN
 ;
 I REFTYPE="RAD" S ACN=$$ACNRAD^MAGNU003(REFIEN,CONTEXT)
 I REFTYPE="TIU" S ACN=$$ACNTIU^MAGNU003(REFIEN)
 I ACN="" Q ""
 ;
 S STDIEN=$O(^MAGV(2005.62,"D",ACN,""))  ; Get study UID IEN
 Q $$GET1^DIQ(2005.62,STDIEN,".01")      ; Return study UID
 ;
WRTOUT(S) ; Write a new line
 N CNT
 S CNT=^TMP("MAGNVQ01",$J)+1
 S ^TMP("MAGNVQ01",$J)=CNT
 S ^TMP("MAGNVQ01",$J,CNT)=S
 Q
 ;
ASTUDY(STYIX,REFTYPE,REFIEN,CONTEXT) ; Append Study section
 N FILESTD,IENSSTD,MAGDFN,MAGOUTST,MAGOUTPR,MAGERR,UID,INFO,PROCIX
 ;
 S FILESTD=2005.62
 S IENSSTD=STYIX_","
 D GETS^DIQ(FILESTD,STYIX,"**","RIE","MAGOUTST","MAGERR")
 I REFIEN="" D 
 . N ACNUMB
 . S ACNUMB=MAGOUTST(FILESTD,IENSSTD,"ACCESSION NUMBER","I")
 . D REFBYACN^MAGNU003(.REFTYPE,.REFIEN,ACNUMB)  ; Set Reference type by Accession Number
 . S CONTEXT=$$CPRSCTX^MAGNU003(REFTYPE,REFIEN)
 . Q
 ;
 S UID=MAGOUTST(FILESTD,IENSSTD,"STUDY INSTANCE UID","I")
 D WRTOUT("NEXT_STUDY|"_UID_"|NEW")
 D WRTOUT("STUDY_UID|"_UID)
 D WRTOUT("STUDY_IEN|"_$$STUDYIEN(.MAGOUTST,IENSSTD))
 D WRTOUT("STUDY_INFO|"_$$STDINFO(.MAGOUTST,IENSSTD)_"|"_REFTYPE_"-"_REFIEN_"|"_CONTEXT)
 ;
 S MAGDFN=MAGOUTST(FILESTD,IENSSTD,"PATIENT REFERENCE","E")
 D WRTOUT("STUDY_PAT|"_MAGDFN_"|"_$S($T(GETICN^MPIF001)'="":$$GETICN^MPIF001(MAGDFN),1:"-1^NO MPI")_"|"_$P($G(^DPT(MAGDFN,0)),"^",1))
 ;
 D WRTOUT("STUDY_MODALITY|"_MAGOUTST(FILESTD,IENSSTD,"MODALITIES IN STUDY","E"))
 Q
 ;
STUDYIEN(MAGOUTST,IENSSTD) ; Return study IEN section
 N INFO,FILESTD
 S FILESTD=2005.62
 S $P(INFO,"|",1)=+IENSSTD
 S $P(INFO,"|",2)=$G(MAGOUTST(FILESTD,IENSSTD,"NUMBER OF SOP INSTANCES","I"))
 Q INFO
 ;
STDINFO(MAGOUTST,IENSSTD) ; Return study info section
 N INFO,FILEPRC,PROCIX,IENSPRC,FILESTD,MAGOUTPR,MAGERR
 ;
 S FILESTD=2005.62
 S FILEPRC=2005.61
 S PROCIX=MAGOUTST(FILESTD,IENSSTD,"PROCEDURE REFERENCE","I")
 S IENSPRC=PROCIX_","
 D GETS^DIQ(FILEPRC,PROCIX,"**","RIE","MAGOUTPR","MAGERR")
 ;
 S $P(INFO,U,4)=$$DTE^MAGSIXG3($G(MAGOUTPR(FILEPRC,IENSPRC,"PROCEDURE DATE/TIME","I")))
 S $P(INFO,U,6)=$G(MAGOUTST(FILESTD,IENSSTD,"DESCRIPTION","I")) ; description
 S $P(INFO,U,8)=$G(MAGOUTPR(FILEPRC,IENSPRC,"PACKAGE INDEX","I"))
 S $P(INFO,U,13)=$G(MAGOUTST(FILESTD,IENSSTD,"ORIGIN INDEX","E"))
 S $P(INFO,U,14)=$$DTE^MAGSIXG3($G(MAGOUTST(FILESTD,IENSSTD,"STUDY DATE/TIME","I")))  ; study date 
 S $P(INFO,U,20)=$G(MAGOUTST(FILESTD,IENSSTD,"ACCESSION NUMBER","I")) ; Accession number
 Q INFO
 ;
ASERIES(SERIX) ; Append Series section
 N FILESER,IENSSER,MAGOUTSR,MAGERR
 S FILESER=2005.63
 S IENSSER=SERIX_","
 D GETS^DIQ(FILESER,SERIX,"**","RIE","MAGOUTSR","MAGERR")
 ;
 D WRTOUT("NEXT_SERIES")
 D WRTOUT("SERIES_UID|"_$G(MAGOUTSR(FILESER,IENSSER,"SERIES INSTANCE UID","I")))
 D WRTOUT("SERIES_IEN|"_SERIX)
 D WRTOUT("SERIES_MODALITY|"_$G(MAGOUTSR(FILESER,IENSSER,"MODALITY","E")))
 D WRTOUT("SERIES_NUMBER|"_$G(MAGOUTSR(FILESER,IENSSER,"SERIES NUMBER","I")))
 D WRTOUT("SERIES_CLASS_INDEX|"_$G(MAGOUTSR(FILESER,IENSSER,"CLASS INDEX","I")))
 D WRTOUT("SERIES_PROC/EVENT_INDEX|"_$G(MAGOUTSR(FILESER,IENSSER,"PROC/EVENT INDEX","I")))
 D WRTOUT("SERIES_SPEC/SUBSPEC_INDEX|"_$G(MAGOUTSR(FILESER,IENSSER,"SPEC/SUBSPEC INDEX","I")))
 Q
 ;
ASOP(SOPIX,FIMAGE) ; Append SOP section
 N FILEIMG,I,IENSIMG,FILESOP,IENSSOP,MAGOUTIM,MAGOUTSO,MAGERR
 S FILESOP=2005.64
 S IENSSOP=SOPIX_","
 D GETS^DIQ(FILESOP,SOPIX,"**","RIE","MAGOUTSO","MAGERR")
 D WRTOUT("NEXT_IMAGE")
 D WRTOUT("IMAGE_IEN|"_SOPIX)
 D WRTOUT("IMAGE_UID|"_$G(MAGOUTSO(FILESOP,IENSSOP,"SOP INSTANCE UID","E")))
 D WRTOUT("IMAGE_NUMBER|"_$G(MAGOUTSO(FILESOP,IENSSOP,"INSTANCE NUMBER","E")))
 D WRTOUT("IMAGE_INFO|"_$$IMGINFO(.MAGOUTSO,IENSSOP,FIMAGE))
 Q
 ;
AIMAGE(SOPIX,IMAGE) ; Append Image section
 N FILEIMG,IENSIMG,MAGOUTIM,MAGERR
 ;
 S FILEIMG=2005.65
 S IENSIMG=IMAGE_","
 D GETS^DIQ(FILEIMG,IMAGE,"**","RIE","MAGOUTIM","MAGERR")
 ;
 D AINST(MAGOUTIM(FILEIMG,IENSIMG,"ARTIFACT TOKEN","E"))  ; Add Artifact Instance
 Q
 ;
IMGINFO(MAGOUTSO,IENSSOP,FIMAGE)  ;Get Image Info 
 N INFO,FILESOP
 S FILESOP=2005.64
 ;
 S $P(INFO,U,1)=+IENSSOP  ; Image IEN
 S $P(INFO,U,2)="" ;fullFilename
 S $P(INFO,U,3)="" ;absFilename
 S $P(INFO,U,4)="" ;description
 S $P(INFO,U,5)=""
 S $P(INFO,U,6)=$G(MAGOUTSO(FILESOP,IENSSOP,"TYPE INDEX","E"))  ; Image type
 S $P(INFO,U,7)="" ;procedure
 S $P(INFO,U,8)="" ;procedureDate 
 S $P(INFO,U,9)=""
 S $P(INFO,U,10)="" ;absLocation
 S $P(INFO,U,11)="" ;fullLocation
 S $P(INFO,U,12)="" ;dicomSequenceNumberForDisplay
 S $P(INFO,U,13)="" ;dicomImageNumberForDisplay
 S $P(INFO,U,14)=""
 S $P(INFO,U,15)=""
 S $P(INFO,U,16)="" ;siteAbbr
 S $P(INFO,U,17)="" ;qaMessage
 S $P(INFO,U,18)="" ;bigFilename
 S $P(INFO,U,19)="" ;patientDFN
 S $P(INFO,U,20)="" ;patientName
 S $P(INFO,U,21)="" ;imageClass
 S $P(INFO,U,22)=$$DTE($G(MAGOUTSO(FILESOP,IENSSOP,"ACQUISITION DATE/TIME","I")))  ; 09/12/2017 16:29:32  ;captureDate
 S $P(INFO,U,23)="" ;documentDate
 S $P(INFO,U,24)="" ;is the IEN of the group for the image
 S $P(INFO,U,25)="" ;is the IEN of the first image in a group
 S $P(INFO,U,26)="" ;is the Image type of the first image in the group
 S $P(INFO,U,27)=""
 S $P(INFO,U,28)=$$GET1^DIQ(2005.65,FIMAGE,"18","I") ; CONFIDENTIAL /Sensitive Image
 S $P(INFO,U,29)="" ;viewStatusValue
 S $P(INFO,U,30)="" ;statusValue
 S $P(INFO,U,31)="" ;imageHasAnnotationsValue
 S $P(INFO,U,32)="" ;associatedNoteResulted
 S $P(INFO,U,33)="" ;imageAnnotationStatusValue
 S $P(INFO,U,34)="" ;imageAnnotationStatusDescription
 S $P(INFO,U,35)="" ;imagePackage
 Q INFO
 ; 
AINST(TOKEN)  ; Add Artifact Instance 
 N KEY,VALUE,LINE,IEN,I,RES,TMPARR,QT
 D GETAIENT^MAGVAG02(.RES,TOKEN,"") ; Get not deleted Artifact IEN by Token
 I '$$ISOK^MAGVAF02(RES) Q
 S IEN=$$GETVAL^MAGVAF02(RES)
 D GETAINST^MAGVAG04(.TMPARR,IEN)
 I '$$ISOK^MAGVAF02(TMPARR(0)) Q
 S QT=$C(34)
 S I=1
 F  S I=$O(TMPARR(I)) Q:'I  S LINE=TMPARR(I) Q:LINE["</ARTIFACTINSTANCES"  D
 . I LINE["<ARTIFACTINSTANCE" D WRTOUT("NEXT_ARTIFACTINSTANCE") Q
 . I LINE["</ARTIFACTINSTANCE" Q
 . S KEY=$P(TMPARR(I),"=",1)
 . S VALUE=$TR($P(TMPARR(I),"=",2),QT,"")
 . S VALUE=$P(VALUE," >")  ; special handling because of XML result set
 . D WRTOUT("ARTIFACTINSTANCE_"_KEY_"|"_VALUE)
 . I KEY="DISKVOLUME" D  ; Add Phisical address
 . . N LOCATION
 . . S LOCATION=$$GET1^DIQ(2005.2,VALUE,"1")
 . . D WRTOUT("ARTIFACTINSTANCE_PHYSICALREFERENCE|"_LOCATION)
 . . Q
 . I KEY="STORAGEPROVIDER" D  ; Add Storage provider name
 . . D WRTOUT("ARTIFACTINSTANCE_STORAGEPROVIDERTYPE|"_$$GET1^DIQ(2006.917,VALUE,"2"))
 . . Q
 . I KEY="ARTIFACT" D  ; Add ARTIFACT FORMAT
 . . D WRTOUT("ARTIFACTINSTANCE_ARTIFACTFORMAT|"_$$GET1^DIQ(2006.916,VALUE,"2:3"))
 . . Q
 . Q
 Q
 ;
 ;+++++ PERFORMS SPECIAL CONVERSION OF THE DATE/TIME
DTE(DTI) ;
 Q $TR($$FMTE^XLFDT(DTI,"5Z"),"@"," ")
