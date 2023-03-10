MAGDSTAE ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Jan 04, 2021@11:56:22
 ;;3.0;IMAGING;**231**;5-May-2007;Build 9
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
 ; Third Step - Get missing series from PACS.
 ; 
 ; VistA appears to be missing one or more series. Get them from the PACS.
 ; 
 ; Perform the following steps to get all the missing series:
 ;   a.  Issue a PACS Study Root Series Level query (C-FIND) using the Study
 ;       Instance UID (0020,000D) as the key.  Request the following return
 ;       data attributes:
 ;         i.   Series Instance UID (0020,000E)
 ;        ii.   Number of Series Related Instances (0020,1209)
 ;   b.  Compare the PACS retrieved Series Instance UIDs against those on VistA.
 ;       For each missing Series Instance UID, do the following four steps:
 ;         i.  Use the Study Instance UID (0020,000D) and PACS retrieved Series
 ;             Instance UID (0020,000E) to issue a Series Level retrieve (C-MOVE)
 ;             to copy all the series' DICOM objects from the PACS to VistA.
 ;        ii.  Use the Study Instance UID (0020,000D) and PACS retrieved Series
 ;             Instance UID (0020,000E) to issue an Image Level query (C-FIND)
 ;             to obtain all the series' SOP Instance UIDs (0008,0018).
 ;       iii.  Add the retrieved Series Instance UID (0020,000E) and the series'
 ;             SOP Instance UIDs (0008,0018) to the hierarchy mentioned above.
 ;        iv.  Update the study's SOP Instance count for VistA.
 ; get the series uid(s) for this study
 ;
 ; Note: PACS STUDYUID is a multiple, since PACS may have more than on Study UID per study.
 ;       SERIES is called for each PACSSERIESUID for the study.
 ;
SERIES(PACSSERIESUID) ; retrieve the series
 N I,NSERIESRI,PACSSTUDYUID,RETURN
 N SOPUID ;----- sop instance uid
 S RETURN=0
 ; get all of the series sop instances and send them to VistA
 S NSERIESRI=^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID,"IMAGE COUNT")
 I NSERIESRI>1 D
 . D QRSTATUS^MAGDSTAA("Retrieving a series with "_NSERIESRI_" images from PACS")
 . Q
 E  D
 . D QRSTATUS^MAGDSTAA("Retrieving a series with one image from PACS")
 . Q
 S PACSSTUDYUID=$O(^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID,"STUDY UID",""))
 I PACSSTUDYUID="" Q  ; there should always be a single Study UID for each Series UID
 D STTINC^MAGDSTAA("PACS SERIES LEVEL RETRIEVES",1)
 D STTINC^MAGDSTAA("PACS IMAGES RETRIEVED",NSERIESRI)
 D GETIMAGE(PACSSTUDYUID,SERIESUID) ; get one series of images
 Q
 ;
GETIMAGE(PACSSTUDYUID,SERIESUID) ; retrieve one series SOP instances
 N I,SOPUID
 K ^TMP("MAG",$J,"Q/R QUERY")
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)")=PACSSTUDYUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SERIES INSTANCE UID(0001)")=PACSSERIESUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=$$QRSCP^MAGDSTA8
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"RETRIEVE LEVEL")="SERIES"
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")="STUDY"
 D SOPUIDR^MAGDSTV1 ; C-MOVE
 Q
