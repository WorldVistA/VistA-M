MAGDSTAD ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Sep 10, 2020@10:46:09
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
 ; Second Step, get study info from PACS.
 ; 
 ; Issue a PACS Study Root Study Level query (C-FIND) using the
 ; the Study Instance UID (0020,000D) as the key.
 ; Request the following return data attributes:
 ;   a. Number of Study Related Series (0020,1206)
 ;   b. Number of Study Related Instances (0020,1208)
 ;   c. Series Instance UID(s) (0020,000E)
 ;
 ; If the study cannot be found on the PACS, then return error.
 ;
STUDY(PACSSTUDYUID) ; get the study information
 N COUNT,I,RETURN,X
 S RETURN=0
 K ^TMP("MAG",$J,"Q/R QUERY")
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)")=PACSSTUDYUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=$$QRSCP^MAGDSTA8
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")="STUDY"
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")="STUDY"
 D SOPUIDQ^MAGDSTV1 ; C-FIND
 I $D(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"MESSAGE","MSG")) D
 . S X=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"MESSAGE","MSG",2))
 . I X="No matching PATIENT/STUDY was found" S RETURN=-1  ; study not found
 . E  S RETURN=-2 ; other errors, also just in case the message changes
 . Q
 Q RETURN
