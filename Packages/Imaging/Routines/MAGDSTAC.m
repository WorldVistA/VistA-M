MAGDSTAC ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Feb 15, 2022@10:52:31
 ;;3.0;IMAGING;**231,305**;Mar 19, 2002;Build 3
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
 ; COMPARE is called by MAGDSTAA when the study's images are already on VistA.
 ; 
 ; It is used to retrieve possibly some missing SOP Instances from PACS.
 ; 
 ; This is a multi-step process.
 ;
 ; 
 ; First, get VistA study, series, and image UID info.
 ; The Study Instance UID (0020,000D), Series Instance UIDs (0020,000E),
 ; and SOP Instance UIDs (0008,0018) are retrieved from VistA from either
 ; the legacy Image file (#2005) or the new SOP Class Database (#2005.6x).
 ; 
 ; Count the number of Series Instance UIDs and number of SOP Instances.
 ; 
 ; Store the data in the following hierarchy:
 ; 
 ; ^TMP("MAG",$J,"UIDS","VISTA",0)=<study count>
 ; ^TMP("MAG",$J,"UIDS","VISTA",<study uid>)=""
 ; ^TMP("MAG",$J,"UIDS","VISTA",<study uid>,0)=<series count>
 ; ^TMP("MAG",$J,"UIDS","VISTA",<study uid>,<series uid>)=""
 ; ^TMP("MAG",$J,"UIDS","VISTA",<study uid>,<series uid>,0)=<sop instance count>
 ; ^TMP("MAG",$J,"UIDS","VISTA",<study uid>,<series uid>,<sop instance uid>)=""
 ;
 ; This is done prior to invoking COMPARE.
 ; 
 ; The same hierarchy is used for PACS UIDs in Step 3.
 ;   
 ;
 ; Second, get study info from PACS.
 ; Issue a PACS Study Root Study Level query (C-FIND) using the
 ; the Study Instance UID (0020,000D) as the key.
 ; Request the following return data attributes:
 ;   a. Number of Study Related Series (0020,1206)
 ;   b. Number of Study Related Instances (0020,1208)
 ;   c. Series Instance UID(s) (0020,000E)
 ;
 ; If the study cannot be found on the PACS, then STOP.
 ;
 ; 
 ; Third, get series info from PACS.
 ;   a.  Issue a PACS Study Root Series Level query (C-FIND) using the Study
 ;       Instance UID (0020,000D) as the key.  Request the following return
 ;       data attributes:
 ;         i.   Series Instance UID (0020,000E)
 ;        ii.   Number of Series Related Instances (0020,1209)
 ;
 ;
 ; Fourth, compare series counts.
 ; If the Number of Study Related Series (0020,1206) is greater
 ; than the number of Series Instance UIDs for the study on VistA,
 ; then compare the PACS retrieved Series Instance UIDs against those on VistA.
 ; For each missing VistA Series Instance UID, do the following four steps:
 ;   a.  Use the Study Instance UID (0020,000D) and PACS retrieved Series
 ;       Instance UID (0020,000E) to issue a Series Level retrieve (C-MOVE)
 ;       to copy all the series' DICOM objects from the PACS to VistA.
 ;   b.  Use the Study Instance UID (0020,000D) and PACS retrieved Series
 ;       Instance UID (0020,000E) to issue an Image Level query (C-FIND)
 ;       to obtain all the series' SOP Instance UIDs (0008,0018).
 ;   c.  Delete the study and corresponding images counts from the 
 ;
 ;
 ; Fifth, compare image counts.
 ; If the Number of Study Related Instances (0020,1208) is
 ; greater than the number of SOP Instances for the study on VistA,
 ; then for each Series Instance UID, if the number of Series Related Instances
 ; (0020,1209) is greater than the number of SOP Instances for that series
 ; on VistA, do the following steps:
 ;   a.  Use the Study Instance UID and Series Instance UID to issue a
 ;       PACS Study Root Image Level query (C-FIND) to obtain the list
 ;       of SOP Instance UIDs (0008,0018) for the series . 
 ;   b.  Compare the SOP Instance UIDs (0008,0018) from the PACS against
 ;       those on VistA.  Make a list of missing SOP Instances.
 ;   c.  Use the Study Instance UID (0020,000D), Series Instance UID
 ;       (0020,000E), and the list of missing SOP Instances (0008,0018) to
 ;       issue a Study Root Image Level retrieve (C-MOVE) to copy the missing
 ;       SOP Instances from the PACS to VistA.
 ;
 ;
 ;
QUERY(PACSSTUDYUID,SERIESCOUNT,IMAGECOUNT) ; check PACS to see if some of the images need to be retrieved
 N ERROR
 N NSTUDYRI ; -- number of study related instances
 N NSTUDYRS ; -- number of study related series
 N SERIESUID ;-- series instance uid
 N SOPICOUNT ; - number of sop instances on VistA
 N STUDYCOUNT ;- number of study instances on VistA
 N I
 ;
 S (I,IMAGECOUNT,SERIESCOUNT)=0,ERROR=""
 ;
 ; check to see if there is a Study UID available to query PACS
 I $G(PACSSTUDYUID(1))="" Q "-1,No PACS Study UID" ; nope
 ;
 ; ; Query PACS at study level and get series image counts
 F  S I=$O(PACSSTUDYUID(I)) Q:I=""  D
 . S ERROR=$$COUNTS(PACSSTUDYUID(I),.SERIESCOUNT,.IMAGECOUNT)
 . Q
 Q ERROR
 ;
COUNTS(PACSSTUDYUID,SERIESCOUNT,IMAGECOUNT) ; get series and image counts from PACS
 N ERROR
 S ERROR=$$STUDY^MAGDSTAD(PACSSTUDYUID)
 I ERROR<0 Q "-2,No such Study Instance UID "_PACSSTUDYUID_" found on PACS"
 ;
 ; get number of study related series and study related sop instances
 S NSTUDYRS=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1,1,"NSTUDYRS"))
 S PACS(PACSSTUDYUID,"SERIES COUNT")=NSTUDYRS
 S SERIESCOUNT=SERIESCOUNT+NSTUDYRS ; count of all series instance uids
 S NSTUDYRI=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1,1,"NSTUDYRI"))
 S PACS(PACSSTUDYUID,"IMAGE COUNT")=NSTUDYRI
 S IMAGECOUNT=IMAGECOUNT+NSTUDYRI ; count of sop instance uids, for all series
 Q 0
 ;
 ;
 ;
RETRIEVE(PACSSTUDYUID) ; primary retrieve capability for studies with some missing images
 N ERROR,I
 N NSERIESRI ; ------ number of series related images
 N PACSIMAGECOUNT ; - total number of PACS images
 N PACSSERIESCOUNT ;  number of PACS series
 N PACSSERIESUID ; -- PACS series instance uids
 N SERIESUID ; ------ variable for VistA series uid
 N VISTAIMAGECOUNT ;  total number of VistA images
 N VISTASERIESCOUNT ; number of VistA series
 N VISTASERIESUID ; - VistA series instance uid
 ;
 S ERROR=0
 ;
 ; Query PACS at series level and get series UIDs and series image counts
 S I=0 F  S I=$O(PACSSTUDYUID(I)) Q:I=""  D
 . D GETSERIU(PACSSTUDYUID(I))
 . Q
 ;
 ; get series UIDs and series image counts from VistA
 S VISTASTUDYUID=0
 F  S VISTASTUDYUID=$O(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID)) Q:VISTASTUDYUID=""  D
 . S SERIESUID=0
 . F  S SERIESUID=$O(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID)) Q:SERIESUID=""  D
 . . S NSERIESRI=$G(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID,0))
 . . S ^("IMAGE COUNT")=$G(^TMP("MAG",$J,"UIDS","VISTA SERIES UID",SERIESUID,"IMAGE COUNT"))+NSERIESRI
 . . Q
 . Q
 ;
 ; get actual number of series and image counts
 S PACSSERIESUID="",(PACSIMAGECOUNT,PACSSERIESCOUNT)=0
 F  S PACSSERIESUID=$O(^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID)) Q:PACSSERIESUID=""  D
 . S PACSSERIESCOUNT=PACSSERIESCOUNT+1
 . S PACSIMAGECOUNT=PACSIMAGECOUNT+^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID,"IMAGE COUNT")
 . Q
 S VISTASERIESUID=0,(VISTAIMAGECOUNT,VISTASERIESCOUNT)=0
 F  S VISTASERIESUID=$O(^TMP("MAG",$J,"UIDS","VISTA SERIES UID",VISTASERIESUID)) Q:VISTASERIESUID=""  D
 . S VISTASERIESCOUNT=VISTASERIESCOUNT+1 ; $G added in next line in P305 - PMK 11/22/2021
 . S VISTAIMAGECOUNT=VISTAIMAGECOUNT+$G(^TMP("MAG",$J,"UIDS","VISTA SERIES UID",VISTASERIESUID,"IMAGE COUNT"))
 . Q
 ;
 ;
 I 'PACSIMAGECOUNT D  Q 0 ; no images on PACS
 . D QRSTATUS^MAGDSTAA("No DICOM objects on PACS to retrieve")
 . Q
 ;
 ; check for additional images on VistA - suggested by Lisa Hulslander, Philips
 I VISTASERIESCOUNT>PACSSERIESCOUNT,VISTAIMAGECOUNT>PACSIMAGECOUNT D  Q 0
 . D QRSTATUS^MAGDSTAA("VistA has more series and images than PACS")
 . Q
 ;
 I VISTASERIESCOUNT=PACSSERIESCOUNT,VISTAIMAGECOUNT=PACSIMAGECOUNT D  Q 0
 . D QRSTATUS^MAGDSTAA("VistA has same series and images as PACS")
 . Q
 ;
 I VISTASERIESCOUNT>PACSSERIESCOUNT,VISTAIMAGECOUNT=PACSIMAGECOUNT D  Q 0
 . D QRSTATUS^MAGDSTAA("VistA has more series but same images as PACS")
 . Q
 ;
 ; this test was added in P305 - PMK 11/09/2021 
 I VISTASERIESCOUNT=PACSSERIESCOUNT,VISTAIMAGECOUNT>PACSIMAGECOUNT D  Q 0
 . D QRSTATUS^MAGDSTAA("VistA has same series but more images than PACS")
 . Q
 ;
 I VISTAIMAGECOUNT>PACSIMAGECOUNT D  Q 0 ; QUIT added in P305 - PMK 11/09/2021
 . D QRSTATUS^MAGDSTAA("VistA has more images than PACS")
 . Q
 ;
 ; this test was added in P305 - PMK 11/09/2021 
 I VISTAIMAGECOUNT=PACSIMAGECOUNT D  Q 0
 . D QRSTATUS^MAGDSTAA("VistA has the same images as PACS")
 . Q
 ;
 ; retrieve any missing images 
 ;
 I 'VISTAIMAGECOUNT D  ; no images on VistA
 . I PACSIMAGECOUNT>1 D
 . . D QRSTATUS^MAGDSTAA("Retrieving entire study of "_PACS("IMAGE COUNT")_" images from PACS")
 . . Q
 . E  D
 . . D QRSTATUS^MAGDSTAA("Retrieving a study with one image from PACS")
 . . Q
 . D STTINC^MAGDSTAA("PACS STUDY LEVEL RETRIEVES",1)
 . D STTINC^MAGDSTAA("PACS IMAGES RETRIEVED",PACSIMAGECOUNT)
 . S ERROR=$$MOVEALL^MAGDSTAB() ; move all study instance uids for this study
 . Q
 E  D  ; retrieve missing series or missing images within existing series
 . ; compare the number of images in each PACS series against those in VistA 
 . S PACSSERIESUID=""
 . F  S PACSSERIESUID=$O(^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID)) Q:PACSSERIESUID=""  D
 . . ; if the series does not exist on VistA, retrieve the whole series
 . . I '$D(^TMP("MAG",$J,"UIDS","VISTA SERIES UID",PACSSERIESUID)) D
 . . . D SERIES^MAGDSTAE(PACSSERIESUID) ; retrieve the series 
 . . . Q
 . . ;
 . . ; if series image count on VistA is less than on PACS, retrieve missing images
 . . E  I ^TMP("MAG",$J,"UIDS","VISTA SERIES UID",PACSSERIESUID,"IMAGE COUNT")<^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID,"IMAGE COUNT") D
 . . . M VISTASTUDYUID=^TMP("MAG",$J,"UIDS","VISTA SERIES UID",PACSSERIESUID,"STUDY UID")
 . . . D GETIMAGE^MAGDSTAF(PACSSERIESUID)
 . . . Q
 . . Q
 . Q
 ;
 Q ERROR
 ;
GETSERIU(PACSSTUDYUID) ; query for Series Instance UIDs for the study
 N COUNT,I,NSERIESRI,PACSSERIESUID
 K ^TMP("MAG",$J,"Q/R QUERY")
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)")=PACSSTUDYUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SERIES INSTANCE UID")=""
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=$$QRSCP^MAGDSTA8
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")="SERIES"
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")="STUDY"
 D SOPUIDQ^MAGDSTV1 ; C-FIND
 S COUNT=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",1,1))
 F I=1:1:COUNT D
 . S PACSSERIESUID=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",1,1,I,"SERIESUID"))
 . S NSERIESRI=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",1,1,I,"NSERIESRI"))
 . ; Like VistA, PACS may have same series under different study instance uids, so add image count
 . S ^("IMAGE COUNT")=$G(^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID,"IMAGE COUNT"))+NSERIESRI
 . S ^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID,"STUDY UID",PACSSTUDYUID)=""
 . Q
 Q
