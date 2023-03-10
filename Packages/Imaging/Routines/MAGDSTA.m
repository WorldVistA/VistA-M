MAGDSTA ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Feb 15, 2022@10:53:46
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
CONRET ; retrieve missing consult images from PACS
 K ^TMP("MAG",$J,"BATCH Q/R") ; remove clinical info from previous run
 S ^TMP("MAG",$J,"BATCH Q/R","IMAGING SERVICE")="CONSULTS"
 S ^TMP("MAG",$J,"BATCH Q/R","OPTION")="RETRIEVE MISSING IMAGES"
 D NEXT("CONRET")
 Q
 ;;
 ;;     DICOM Consult & Procedure Image Retriever
 ;;     -----------------------------------------
 ;;
 ;;This program transfers DICOM objects for CPRS consults and procedures
 ;;from the designated PACS to VistA.
 ;;
 ;;This application passes the CPRS consult and procedure request files to
 ;;find studies that are completed and should have images.  It compares
 ;;the study's SOP Instance UIDs (if any) with those on the designated
 ;;PACS for the specialty consult or procedure.
 ;;
 ;;It then formulates the requests to retrieve them, either by a list of 
 ;;of the missing SOP Instance UIDs, the series, or by the whole study.
 ;;
 ;;An optional Q/R provider may be stored in the QUERY/RETRIEVE PROVIDER
 ;;field (#8) of the CLINICAL SPECIALTY DICOM & HL7 file (#2006.5831).
 ;;
 ;;The DICOM Gateway issues the DICOM Query/Retrieve requests to send
 ;;the images from the PACS to VistA.
 ;;END
 ;
CONCMP ; compare image counts between consult and PACS without retrieving images
 K ^TMP("MAG",$J,"BATCH Q/R")
 S ^TMP("MAG",$J,"BATCH Q/R","IMAGING SERVICE")="CONSULTS"
 S ^TMP("MAG",$J,"BATCH Q/R","OPTION")="COMPARE IMAGE COUNTS"
 D NEXT("CONCMP")
 Q
 ;;
 ;;     DICOM Consult & Procedure Image Count Comparer
 ;;     ----------------------------------------------
 ;;
 ;;This application passes the CPRS consult and procedure request files to
 ;;find studies that are completed and should have images.  It compares
 ;;the count of the study's images (if any) with those on the designated
 ;;PACS for the specialty consult or procedure.
 ;;
 ;;The optional PACS Q/R provider is stored in the QUERY/RETRIEVE PROVIDER
 ;;field (#8) of the CLINICAL SPECIALTY DICOM & HL7 file (#2006.5831).
 ;;
 ;;No images are transferred from the PACS to VistA, however.
 ;;
 ;;The DICOM Gateway issues the DICOM Query/Retrieve requests to send
 ;;the images from the PACS to VistA.
 ;;END
 ;
RADRET ; retrieve missing radiology images from PACS
 K ^TMP("MAG",$J,"BATCH Q/R")
 S ^TMP("MAG",$J,"BATCH Q/R","IMAGING SERVICE")="RADIOLOGY"
 S ^TMP("MAG",$J,"BATCH Q/R","OPTION")="RETRIEVE MISSING IMAGES"
 D NEXT("RADRET")
 Q
 ;;
 ;;     DICOM Radiology Image Retriever
 ;;     -------------------------------
 ;;
 ;;This program transfers DICOM radiology objects from PACS to VistA.
 ;;
 ;;This application passes the radiology files to find completed studies.
 ;;It compares the study's SOP Instance UIDs (if any) with those on PACS.
 ;;
 ;;It then formulates the requests to retrieve them, either by a list of 
 ;;of the missing SOP Instance UIDs, the series, or by the whole study.
 ;;
 ;;The DICOM Gateway issues the DICOM Query/Retrieve requests to send
 ;;the images from the PACS to VistA.
 ;;END
 ;
RADCMP ; compare image counts between radiology and PACS without retrieving images
 K ^TMP("MAG",$J,"BATCH Q/R")
 S ^TMP("MAG",$J,"BATCH Q/R","IMAGING SERVICE")="RADIOLOGY"
 S ^TMP("MAG",$J,"BATCH Q/R","OPTION")="COMPARE IMAGE COUNTS"
 D NEXT("RADCMP")
 Q
 ;;
 ;;     DICOM Radiology Image Count Comparer
 ;;     ------------------------------------
 ;;
 ;;This application passes the radiology files to find completed studies.
 ;;It compares the count of the study's images (if any) with those on PACS.
 ;;
 ;;No images are transferred from the PACS to VistA, however.
 ;;
 ;;The DICOM Gateway issues the DICOM Query/Retrieve requests to send
 ;;the images from the PACS to VistA.
 ;;END
 ;
NEXT(ENTRYPOINT) ; output banner and proceed to next routine
 N I,J,MENUOPTION,MSG,TEXT
 S J=0
 F I=1:1 S TEXT=$T(@ENTRYPOINT+I) D  Q:TEXT="END"
 . I $E(TEXT,1,3)'=" ;;" Q  ; ignore code
 . S TEXT=$P(TEXT,";;",2)
 . I TEXT="END" D MESSAGE(.MSG) Q
 . S J=J+1,MSG(J)=TEXT
 . Q
 K ENTRYPOINT,I,J,MSG,TEXT
 S MENUOPTION=$P(XQY0,"^",1)
 D ENTRY^MAGDSTA1(MENUOPTION)
 Q
 ;
MESSAGE(MSG) ; display message
 N I,WIDTH
 S WIDTH=IOM
 W ! F I=1:1:WIDTH W "*"
 I $D(MSG)=1 W !,"*** ",MSG,?WIDTH-4," ***"
 E  F I=1:1 Q:'$D(MSG(I))  W !,"*** ",MSG(I),?WIDTH-4," ***"
 W ! F I=1:1:WIDTH W "*"
 Q
 ;
INITSTT(RUNNUMBER) ; initialize the statistics
 N I,T
 ; initialize the statistics so that they are in the most useful order
 F I=1:1:15 S T=$T(INITSTT+I+7),T=$P(T,";;",2) D  Q:T="**END**"
 . D STTWRITE^MAGDSTAA(T,"")
 . Q
 Q
 ;
 ;;VISTA STUDIES PROCESSED
 ;;VISTA STUDIES WITHOUT DICOM IMAGES
 ;;LEGACY STUDIES PROCESSED
 ;;LEGACY SERIES COUNT
 ;;LEGACY IMAGE COUNT
 ;;NEW SOP CLASS STUDIES PROCESSED
 ;;NEW SOP CLASS SERIES COUNT
 ;;NEW SOP CLASS IMAGE COUNT
 ;;PACS STUDIES PROCESSED
 ;;PACS STUDIES WITHOUT IMAGES
 ;;PACS SERIES COUNT
 ;;PACS IMAGE COUNT
 ;;PACS STUDY LEVEL RETRIEVES
 ;;PACS SERIES LEVEL RETRIEVES
 ;;PACS IMAGES RETRIEVED
 ;;**END**
 ;
KILLCON ; entry point to kill consult statistics runs
 N MYSERVICE S MYSERVICE="CONSULTS"
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 D KILL
 Q
 ;
KILLRAD ; entry point to kill radiology statistics runs
 N MYSERVICE S MYSERVICE="RADIOLOGY"
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 D KILL
 Q
 ;
KILL ; truncate the AUTOMATIC DICOM Q/R RUN STATS file (#2006.5443) 
 N COUNT,I,LIST,PROMPT,X
 D MAKELIST^MAGDSTAS(MYSERVICE,.LIST,.COUNT)
 I COUNT=0 D  Q
 . W !!,"The AUTOMATIC DICOM Q/R RUN STATS for ",MYSERVICE," have already been deleted."
 . Q
 I COUNT=1 D
 . W !!,"There is one entry in the AUTOMATIC DICOM Q/R RUN STATS for ",MYSERVICE,"."
 . S PROMPT="Do you want to remove it?"
 . Q
 E  D
 . W !!,"There are "_COUNT_" entries in the AUTOMATIC DICOM Q/R RUN STATS file for ",MYSERVICE,"."
 . S PROMPT="Do you want to remove them?"
 . Q
 I $$YESNO^MAGDSTQ(PROMPT,"n",.X)>0,X="YES"  D
 . L +^MAGDSTT(2006.543,0):30 E  D  Q
 . . W !!,"Cannot obtain LOCK on Q/R RETRIEVE DICOM RUN STATS Table.",!!
 . . Q
 . ; delete one node
 . F I=1:1:COUNT D KILL1(LIST(I))
 . ; update counter for zero node
 . S (J,K)=0,L="" F  S J=$O(^MAGDSTT(2006.543,J)) Q:'J  D
 . . S K=K+1 ; update count
 . . S L=J ; last node
 . . Q
 . ; update last node and counter in zero node
 . S $P(^MAGDSTT(2006.543,0),"^",3)=L ; last node
 . S $P(^MAGDSTT(2006.543,0),"^",4)=K ; count
 . L -^MAGDSTT(2006.543,0)
 . ;
 . W !!,"The AUTOMATIC DICOM Q/R RUN STATS file for ",MYSERVICE," has been truncated."
 . Q
 E  W !!,"The AUTOMATIC DICOM Q/R RUN STATS file for ",MYSERVICE," has not been truncated."
 Q
 ;
KILL1(I) ; delete a single entry
 N COUNT,J,K,L,MENUOPTION,NODE0,SCANMODE,STARTTIME
 S NODE0=$G(^MAGDSTT(2006.543,I,0))
 S STARTTIME=$P(NODE0,"^",1)
 S SCANMODE=$P(NODE0,"^",6)
 S MENUOPTION=$P(NODE0,"^",20)
 ; kill node and cross references
 K ^MAGDSTT(2006.543,I)
 K ^MAGDSTT(2006.543,"B",STARTTIME,I)
 K ^MAGDSTT(2006.543,"C",MENUOPTION,SCANMODE,I)
 Q
 ;
ERROR ; error trap for automatic processes
 N ERROR
 S ERROR=$$EC^%ZOSV
 I ERROR'?1"<INTERRUPT>".E D
 . W !!,"*** ERROR: ",ERROR," ***"
 . S X="ERROR: "_ERROR
 . D ^%ZTER ; record the error
 . Q
 E  S X="Interrupted by User"
 I $D(RUNNUMBER) D
 . S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",5)=$TR(X,"^","|")
 . Q
 I $G(MAGXTMP)'="" D
 . N HOSTNAME S HOSTNAME=$$HOSTNAME^MAGDFCNV
 . K ^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,$J) ; remove RUN status
 . Q
 D CONTINUE^MAGDSTQ
 D UNWIND^%ZTER ; unwind the stack and return to the menu
 Q
