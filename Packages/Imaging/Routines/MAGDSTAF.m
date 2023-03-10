MAGDSTAF ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Sep 17, 2020@13:11:24
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
 ; Fourth Step - Get missing images from PACS.
 ; 
 ; VistA appears to be missing one or more images.  Get them from the PACS
 ; 
 ; Perform the following steps to get the missing images from the PACS:
 ;   a.  Issue a PACS Study Root Series Level query (C-FIND) using the Study
 ;       Instance UID (0020,000D) as the key.  Request the following return
 ;       data attributes:
 ;         i.   Series Instance UID (0020,000E)
 ;        ii.   Number of Series Related Instances (0020,1209)
 ;        
 ;   b.  For each Series Instance UID, if the number of Series Related Instances
 ;       (0020,1209) is greater than the number of SOP Instances for that series
 ;       on VistA, do the following steps:
 ;         i.  Use the Study Instance UID and Series Instance UID to issue a
 ;             PACS Study Root Image Level query (C-FIND) to obtain the list
 ;             of SOP Instance UIDs (0008,0018) for the series. 
 ;        ii.  Compare the SOP Instance UIDs (0008,0018) from the PACS against
 ;             those on VistA.  Make a list of missing SOP Instances.
 ;       iii.  Use the Study Instance UID (0020,000D), Series Instance UID
 ;             (0020,000E), and the list of missing SOP Instances (0008,0018) to
 ;             issue a Study Root Image Level retrieve (C-MOVE) to copy the missing
 ;             SOP Instances from the PACS to VistA.
 ;
 ;
 ; Note: PACS STUDYUID and VISTA STUDYUID are both multiples, since PACS and VistA
 ;       may have more than on Study UID per study.
 ;       GETIMAGE is called for each PACSSERIESUID for the study.
 ;
GETIMAGE(PACSSERIESUID) ; retrieve one series of "PACS ONLY" SOP Instances
 N PACSSTUDYUID
 D QRSTATUS^MAGDSTAA("Getting SOP Instance UIDs for a series")
 ;
 ; get each PACSSTUDYUID from the multiple and process it
 ; 
 S PACSSTUDYUID=""
 S PACSSTUDYUID=$O(^TMP("MAG",$J,"UIDS","PACS SERIES UID",PACSSERIESUID,"STUDY UID","")) Q:PACSSTUDYUID=""  D
 . D STUDYUID(PACSSTUDYUID,PACSSERIESUID)
 . Q
 Q
 ;
STUDYUID(PACSSTUDYUID,PACSSERIESUID) ; process one PACS Study Instance UID
 N I,SOPUID
 ;
 ; get the list of sop instances for the series and compare against VistA
 D GETSOPU(PACSSTUDYUID,PACSSERIESUID)
 D QRSTATUS^MAGDSTAA("Comparing SOP Instance UIDs for the series")
 D UIDCOMP(PACSSTUDYUID,PACSSERIESUID)
 ;
 ; retrieve the missing "PACS ONLY" images
 ;
 K ^TMP("MAG",$J,"Q/R QUERY")
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)")=PACSSTUDYUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SERIES INSTANCE UID(0001)")=PACSSERIESUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=$$QRSCP^MAGDSTA8
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"RETRIEVE LEVEL")="IMAGE"
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")="STUDY"
 S I=10000,SOPUID=""
 F  S SOPUID=$O(^TMP("MAG",$J,"UIDS","PACS ONLY",PACSSTUDYUID,PACSSERIESUID,SOPUID)) Q:SOPUID=""  D
 . S I=I+1,^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SOP INSTANCE UID("_$E(I,2,5)_")")=SOPUID
 . Q
 S I=I-10000 ; remove numeric offset
 I I>1 D
 . D QRSTATUS^MAGDSTAA("Retrieving "_(I)_" images for one series")
 . Q
 E  D
 . D QRSTATUS^MAGDSTAA("Retrieving one image for one series")
 . Q
 D STTINC^MAGDSTAA("PACS SERIES LEVEL RETRIEVES",1)
 D STTINC^MAGDSTAA("PACS IMAGES RETRIEVED",(I))
 D SOPUIDR^MAGDSTV1 ; C-MOVE
 Q
 ;
GETSOPU(PACSSTUDYUID,PACSSERIESUID) ; query for the SOP Instance UIDs for the series
 N COUNT,I,SOPUID
 K ^TMP("MAG",$J,"Q/R QUERY")
 K ^TMP("MAG",$J,"UIDS","PACS",PACSSTUDYUID,PACSSERIESUID)
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)")=PACSSTUDYUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SERIES INSTANCE UID(0001)")=PACSSERIESUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=$$QRSCP^MAGDSTA8
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")="IMAGE"
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")="STUDY"
 D SOPUIDQ^MAGDSTV1 ; C-FIND
 S COUNT=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"IMAGE",1,1,1))
 F I=1:1:COUNT D
 . S SOPUID=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"IMAGE",1,1,1,I,"SOPUID"),"*")
 . S ^TMP("MAG",$J,"UIDS","PACS",PACSSTUDYUID,PACSSERIESUID,SOPUID)=""
 . Q
 S ^TMP("MAG",$J,"UIDS","PACS",PACSSTUDYUID,PACSSERIESUID,0)=COUNT
 Q 
 ;
UIDCOMP(PACSSTUDYUID,PACSSERIESUID) ;
 ; Compare the UIDs between those on PACS with those on VistA
 ; Return a count of UIDs on both as well as lists of missing ones
 ; 
 ; Note that both PACS and VistA may have multiple Study Instance UIDs
 ; and that they may be different.
 ; 
 ; Input:  ^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID,SOPUID)=""
 ;         ^TMP("MAG",$J,"UIDS","PACS",PACSSTUDYUID,SERIESUID,SOPUID)=""
 ;        
 ; Output: BOTH - count of identical UIDs on both VistA and PACS
 ;         ^TMP("MAG",$J,"UIDS","PACS ONLY",PACSSTUDYUID,SERIESUID,SOPUID)=""
 ;         ^TMP("MAG",$J,"UIDS","VISTA ONLY",VISTASTUDYUID,SERIESUID,SOPUID)=""
 ;         ^TMP("MAG",$J,"UIDS","COUNTS","BOTH")
 ;         ^TMP("MAG",$J,"UIDS","COUNTS","PACS")
 ;         ^TMP("MAG",$J,"UIDS","COUNTS","PACS ONLY")
 ;         ^TMP("MAG",$J,"UIDS","COUNTS","VISTA")
 ;         ^TMP("MAG",$J,"UIDS","COUNTS","VISTA ONLY")
 ;           
 N BOTH,COUNT,MISSINGUIDS,PACSUIDS,VISTAUIDS,VISTASTUDYUID
 K ^TMP("MAG",$J,"UIDS","COUNTS"),^("PACS ONLY"),^("VISTA ONLY")
 ;
 ; build lists of SOP Instance UIDs (PACSSTUDYUID is a scalar)
 S ^TMP("MAG",$J,"UIDS","COUNTS","PACS")=$$UIDLIST("PACS",PACSSTUDYUID,PACSSERIESUID,.PACSUIDS)
 ;
 ; get each VISTASTUDYUID from the multiple and process it
 ;
 S ^TMP("MAG",$J,"UIDS","COUNTS","VISTA")=0,VISTASTUDYUID=""
 F  S VISTASTUDYUID=$O(^TMP("MAG",$J,"UIDS","VISTA SERIES UID",PACSSERIESUID,"STUDY UID",VISTASTUDYUID)) Q:VISTASTUDYUID=""  D
 . S COUNT=$$UIDLIST("VISTA",VISTASTUDYUID,PACSSERIESUID,.VISTAUIDS)
 . S ^TMP("MAG",$J,"UIDS","COUNTS","VISTA")=^TMP("MAG",$J,"UIDS","COUNTS","VISTA")+COUNT
 . Q
 ;
 ; compare PACS UIDs against VistA UIDs
 D SUBTRACT(.PACSUIDS,.VISTAUIDS,.MISSINGUIDS,.MISSING,.BOTH)
 S ^TMP("MAG",$J,"UIDS","COUNTS","BOTH")=BOTH
 S ^TMP("MAG",$J,"UIDS","COUNTS","PACS ONLY")=MISSING
 M ^TMP("MAG",$J,"UIDS","PACS ONLY",PACSSTUDYUID)=MISSINGUIDS
 ;
 ; don't need to compare VistA UIDs against PACS UIDs
 Q
 ;
UIDLIST(SYSTEM,STUDYUID,SERIESUID,ARRAY) ; get an array of Series and SOP Instance UIDs
 N COUNT,SOPUID
 S COUNT=0 ; SOP Instance UID count
 ;
 ; build the array of SOP Instance UIDs and get count
 S SOPUID=0 ; skip count
 F  S SOPUID=$O(^TMP("MAG",$J,"UIDS",SYSTEM,STUDYUID,SERIESUID,SOPUID))  Q:SOPUID=""  D
 . S ARRAY(SERIESUID,SOPUID)=""
 . S COUNT=COUNT+1
 . Q
 Q COUNT
 ;
SUBTRACT(A,B,C,MISSING,SAME) ; UID set subtraction
 ; A, B, and C are arrays of Series and SOP Instance UIDs
 ; C = all the nodes of A minus the nodes of B
 N SS1,SS2
 K C S (MISSING,SAME)=0
 M C=A
 S SS1=0
 F  S SS1=$O(A(SS1)) Q:SS1=""  D
 . S SS2=0
 . F  S SS2=$O(A(SS1,SS2)) Q:SS2=""  D
 . . I $D(B(SS1,SS2)) D  ; same node in B and A (now C)
 . . . K C(SS1,SS2) ; remove B's node from C
 . . . S SAME=SAME+1 ; count of same nodes
 . . . Q
 . . E  D  ; node in B is missing in A (now C)
 . . . S MISSING=MISSING+1
 . . . Q
 . . Q
 . Q
 Q
  ;
TEST1 ; test of SUBTRACT subroutine
 ; N A,B,C,MISSING,SAME
 S A(1,1)="1,1"
 S A(2,1)="2,1"
 S B(1,1)="ONE,ONE"
 S B(2,2)="TWO,TWO"
 D SUBTRACT(.A,.B,.C,.MISSING,.SAME)
 W !,"Same=",SAME,"  Missing=",MISSING,"  This should be C(2,1)=""2,1"""
 D TEST1A
 D SUBTRACT(.B,.A,.C,.MISSING,.SAME)
 W !!,"Same=",SAME,"  Missing=",MISSING,"  This should be C(2,2)=""TWO,TWO"""
 D TEST1A
 Q
 ;
TEST1A ; output
 N SS1,SS2
 S SS1=""
 F  S SS1=$O(C(SS1)) Q:SS1=""  D
 . S SS2=""
 . F  S SS2=$O(C(SS1,SS2)) Q:SS2=""  D
 . . W !,"C(",SS1,",",SS2,")=""",C(SS1,SS2),""""
 . . Q
 . Q
 Q 
 ; 
TEST2 ; test of UIDCOMP subroutine
 N I,PACSSTUDYUID,VISTASTUDYUID
 S PACSSTUDYUID="PACS STUDY UID",VISTASTUDYUID="VISTA STUDY UID"
 K ^TMP("MAG",$J,"UIDS")
 F I=1:1:5 S ^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,"A",$C(65+I))=""
 F I=4:1:9 S ^TMP("MAG",$J,"UIDS","PACS",PACSSTUDYUID,"A",$C(65+I))=""
 F I=4:1:9 S ^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,"B",$C(75+I))=""
 F I=1:1:5 S ^TMP("MAG",$J,"UIDS","PACS",PACSSTUDYUID,"B",$C(75+I))=""
 D UIDCOMP(PACSSTUDYUID,VISTASTUDYUID,"A")
 W !!,"Numbers should be 2, 6, 4, 5, and 3"
 D TEST2A("A")
 D UIDCOMP(PACSSTUDYUID,VISTASTUDYUID,"B")
  W !!,"Numbers should be 2, 5, 3, 6, and 4"
 D TEST2A("B")
 Q
 ;
TEST2A(SERIESUID) ; report
 W !,"Series UID: """,SERIESUID,""""
 F A="BOTH","PACS","PACS ONLY","VISTA","VISTA ONLY" D
 . W !,$J(A,10),": ",^TMP("MAG",$J,"UIDS","COUNTS",A)
 . Q
 Q
