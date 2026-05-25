MAGDSTA0 ;WOIFO/PMK - Study Tracker - Automatic CMP/RET ; Nov 08, 2022@14:32:16
 ;;3.0;IMAGING;**333**;Mar 19, 2002;Build 2
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Supported IA #10103 reference $$FMADD^XLFDT function call
 ;
 Q
 ;
INITXTMP(OUTPUTEXCEL) ; initialize ^XTMP for Study Tracker's automatic CMP/RET
 ; This is different from INITXTMP^MAGDSTQ0
 N NOW,PURGE,TITLE,TODAY
 S TITLE="MAG Study Tracker"
 L +^XTMP(TITLE):3 E  W !!,"Can't lock ^XTMP(",TITLE,") - No Excel file" Q
 S NOW=$$NOW^XLFDT(),TODAY=NOW\1
 D KILL(TITLE,TODAY)
 S PURGE=$$FMADD^XLFDT(TODAY,14) ; keep two week's worth of reports
 S OUTPUTEXCEL=TITLE_" "_NOW
 S ^XTMP(OUTPUTEXCEL,0)=PURGE_"^"_TODAY_"^"_TITLE
 M ^XTMP(OUTPUTEXCEL,"INFO")=^TMP("MAG",$J)
 S ^XTMP(OUTPUTEXCEL,"DUZ")=DUZ
 S ^XTMP(OUTPUTEXCEL,"REPORT",0)=1,^(1)=""
 L -^XTMP(TITLE)
 Q
 ;
SAVE(OUTPUTEXCEL,OUTPUT,CONCATENATE) ; save output to ^XTMP
 N SS4
 S CONCATENATE=$G(CONCATENATE,0)
 S MAGSTXTMP=$P(OUTPUTEXCEL,"^",1),XTMPSS=$P(OUTPUTEXCEL,"^",2)
 S SS4=^XTMP(OUTPUTEXCEL,"REPORT",0)
 I CONCATENATE S ^(SS4)=^XTMP(OUTPUTEXCEL,"REPORT",SS4)_OUTPUT
 E  D
 . S SS4=SS4+1
 . S ^XTMP(OUTPUTEXCEL,"REPORT",0)=SS4,^(SS4)=OUTPUT
 . Q
 Q
 ;
KILL(TITLE,TODAY) ; remove old ^XTMP files
 N OUTPUTEXCEL,X
 S OUTPUTEXCEL=TITLE
 F  S OUTPUTEXCEL=$O(^XTMP(OUTPUTEXCEL)) Q:OUTPUTEXCEL'?1"MAG".E  D
 . ; check purge date against today's - keep two week's worth of reports
 . S X=$G(^XTMP(OUTPUTEXCEL,0)) I $P(X,"^",1)<TODAY  K ^XTMP(OUTPUTEXCEL)
 . Q
 Q
 ;
LIST(MYSERVICE,LIST) ; get list of ^XTMP("MAG Study Tracker *" entries for service
 N I,OUTPUTEXCEL,TITLE
 K LIST
 S (I,LIST(0))=0
 S TITLE="MAG Study Tracker"
 S OUTPUTEXCEL="MAG Study Tracker"
 F  S OUTPUTEXCEL=$O(^XTMP(OUTPUTEXCEL)) Q:OUTPUTEXCEL=""  Q:OUTPUTEXCEL'?1"MAG Study Tracker".E  D
 . I $G(^XTMP(OUTPUTEXCEL,"INFO","BATCH Q/R","IMAGING SERVICE"))=MYSERVICE D
 . . S I=LIST(0)+1,LIST(0)=I,LIST(I)=OUTPUTEXCEL
 . . Q
 . Q
 Q I
 ;
 ;
COPYPARM(NORMALRUN) ; copy last run's parameters for the next run
 N I,DIRECTION
 S ^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP")=QRSCP
 S ^TMP("MAG",$J,"Q/R PARAM","SCAN MODE")=SCANMODE
 S ^TMP("MAG",$J,"BATCH Q/R","SORT ORDER")=SORTORDER
 S ^TMP("MAG",$J,"BATCH Q/R","HOURS OF OPERATION")=HOURS
 ;
 S ^TMP("MAG",$J,"Q/R PARAM","QUERY USER APPLICATION")=QRSCP ; needed for QRSCP^MAGDSTA2
 ;
 S DIRECTION=$$DIRECTION(SORTORDER)
 ;
 ; get scan mode specific parameters
 I SCANMODE="PATIENT" D
 . ; user may want to change patient
 . S ^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN")=DFN
 . Q
 I (SCANMODE="DATE")!(SCANMODE="PATIENT") D  ; user may want to change date range 
 . I SORTORDER="ASCENDING" D  ; set BEGIN DATE to the last date of the previous run
 . . I NORMALRUN S ^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE")=$$NEXTDATE(ENDDATE,DIRECTION)
 . . E  S ^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE")=STUDYDATE\1
 . . S ^TMP("MAG",$J,"BATCH Q/R","END DATE")=""
 . . Q
 . E  D  ; DESCENDING -- set END DATE to the last date of the previous run
 . . I NORMALRUN S ^TMP("MAG",$J,"BATCH Q/R","END DATE")=$$NEXTDATE(BEGDATE,DIRECTION)
 . . E  S ^TMP("MAG",$J,"BATCH Q/R","END DATE")=STUDYDATE\1
 . . S ^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE")=""
 . . Q
 . Q
 E  I SCANMODE="NUMBER" D
 . ; set REPORT/STUDY IEN to the last IEN of the previous run
 . S ^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN")=(STUDYIEN+DIRECTION)
 . S ^TMP("MAG",$J,"BATCH Q/R","BATCH SIZE")=BATCHSIZE
 . Q
 ;
 ; get consult services
 M ^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES")=CONSULTSERVICES
 Q
 ;
DIRECTION(SORTORDER) ; return the direction for $order
 ;  1 = normal order
 ; -1 = reverse order
 Q $S(SORTORDER="ASCENDING":1,SORTORDER="DESCENDING":-1)
 ;
NEXTDATE(DATE,DIRECTION) ; get the next date, but not in the future
 N NEXTDATE,NOW
 S NOW=$$NOW^XLFDT\1
 S NEXTDATE=$$FMADD^XLFDT(DATE\1,DIRECTION)
 I NEXTDATE>NOW S NEXTDATE=NOW ; no future dates
 Q NEXTDATE
