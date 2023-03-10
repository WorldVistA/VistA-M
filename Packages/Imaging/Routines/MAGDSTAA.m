MAGDSTAA ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Feb 15, 2022@10:50:34
 ;;3.0;IMAGING;**231,306,305**;Mar 19, 2002;Build 3
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
 ;
 ; Supported IA #10063 reference $$S^%ZTLOAD function call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Supported IA #10035 to read PATIENT file (#2)
 ;
 Q
 ;
LOOKUP(DFN,STUDYDATE,STUDYIEN,ACNUMB,MAGIENLIST) ; called by MAGDSTA5 and MAGDSTA7
 ; STUDYDATE ---- date of study
 ; STUDYIEN ----- RARPT1 or GMRCIEN
 ; ACNUMB ------- accession number
 ; MAGIENLIST --- array of MAGIEN pointers
 ; VISTAUIDFLAG - flag to indicate that an acn query failed
 ;
 N ERROR,EXAMDATE,I,IMAGECOUNT,MAGGLIST,MAGIEN,NONDICOM,SSN
 N PACS,RUNTIME,SERIESCOUNT,PACSSTUDYUID,VISTASTUDYUID,VISTA,X
 ;
 D STTINC("VISTA STUDIES PROCESSED",1)
 S RUNTIME=$$NOW^XLFDT()
 S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",3)=RUNTIME ; updated during the run
 S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",5)="RUNNING"
 S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",15)=DFN
 S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",16)=STUDYDATE
 S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",17)=STUDYIEN
 S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",18)=ACNUMB
 ;
 I $$SUSPEND(HOURS) Q 1  ; stop
 I $Y>(IOSL-6) W !! D HEADER(1)
 ;
 S NONDICOM=0,IMAGES="NONE"
 W !,$J(STUDYIEN,8),?11,ACNUMB,?30,$P($$FMTE^XLFDT(STUDYDATE,"2Z"),"@",1)
 ; lookup legacy 2005 image group pointers
 K ^TMP("MAG",$J,"UIDS") ; remove the list of UIDs for the VistA study
 S MAGIEN=""
 F I=1:1 S MAGIEN=$O(MAGIENLIST(MAGIEN)) Q:MAGIEN=""  D
 . W:I>1 ! W ?40,$J(MAGIEN,8)
 . D LEGACY^MAGDSTA8(MAGIEN,.SERIESCOUNT,.IMAGECOUNT) ; count images in all groups
 . I SERIESCOUNT W ?52,$J(SERIESCOUNT,5)
 . E  D
 . . I IMAGECOUNT W ?52,$J("",5) ; same as previous series, don't show count
 . . E  D
 . . . W ?55,"non-DICOM" ; not DICOM, maybe TGA, JPEG, PDF, etc.
 . . . S NONDICOM=1
 . . . Q
 . . Q
 . I IMAGECOUNT W ?59,$J(IMAGECOUNT,5)
 . D STTINC("LEGACY STUDIES PROCESSED",1)
 . D STTINC("LEGACY SERIES COUNT",SERIESCOUNT)
 . D STTINC("LEGACY IMAGE COUNT",IMAGECOUNT)
 . ;
 . ; save VistA counts for later steps
 . ; Note: These counts may be for multiple study instance UIDs
 . S VISTA("SERIES COUNT")=$G(VISTA("SERIES COUNT"),0)+$G(SERIESCOUNT,0)
 . S VISTA("IMAGE COUNT")=$G(VISTA("IMAGE COUNT"),0)+$G(IMAGECOUNT,0)
 . Q
 ;
 ; look up in new sop class database (P34)
 D NEWSOPDB^MAGDSTA8(ACNUMB,.SERIESCOUNT,.IMAGECOUNT)
 I IMAGECOUNT>0 D
 . W:$D(MAGIENLIST) ! W ?41,"NEW SOP",?52,$J(SERIESCOUNT,5),?59,$J(IMAGECOUNT,5)
 . D STTINC("NEW SOP CLASS STUDIES PROCESSED",1)
 . D STTINC("NEW SOP CLASS SERIES COUNT",SERIESCOUNT)
 . D STTINC("NEW SOP CLASS IMAGE COUNT",IMAGECOUNT)
 . Q
 ;
 ; update legacy and new database VistA counts for later steps
 S VISTA("SERIES COUNT")=$G(VISTA("SERIES COUNT"),0)+$G(SERIESCOUNT,0)
 S VISTA("IMAGE COUNT")=$G(VISTA("IMAGE COUNT"),0)+$G(IMAGECOUNT,0)
 ;
 K PACSSTUDYUID
 S VISTAUIDFLAG=0
 ; perform Accession Number query to obtain the Study Instance UID & counts from PACS
 S SSN=$$GET1^DIQ(2,DFN,.09,"E") ; P306 PMK 06/11/2021 use last 4 of SSN to make query unique
 S ERROR=$$FINDSUID^MAGDSTAB(ACNUMB,SSN,.PACSSTUDYUID,.SERIESCOUNT,.IMAGECOUNT)
 ;
 I VISTA("IMAGE COUNT")=0 D  ; no DICOM images on file in VistA
 . I NONDICOM=0 W ?46,"--",?55,"--",?62,"--"
 . D STTINC("VISTA STUDIES WITHOUT DICOM IMAGES",1)
 . Q
 E  I '$D(PACSSTUDYUID) D
 . ; perform queries using the VistA Study Instance UID to get the image and series counts
 . S (I,VISTASTUDYUID)=0 ; build array of VistA Study Instance UIDs for the query
 . F  S VISTASTUDYUID=$O(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID)) Q:VISTASTUDYUID=""  D
 . . S I=I+1,PACSSTUDYUID(I)=VISTASTUDYUID
 . . Q
 . S ERROR=$$QUERY^MAGDSTAC(.PACSSTUDYUID,.SERIESCOUNT,.IMAGECOUNT)
 . I $D(PACSSTUDYUID(1)) S VISTAUIDFLAG=1
 . Q
 ; 
 ; Note: These counts may be for multiple study instance UIDs
 S PACS("SERIES COUNT")=SERIESCOUNT,PACS("IMAGE COUNT")=IMAGECOUNT
 I SERIESCOUNT D
 . W ?67,$J(SERIESCOUNT,5),?74,$J(IMAGECOUNT,5)
 . D STTINC("PACS STUDIES PROCESSED",1)
 . D STTINC("PACS SERIES COUNT",SERIESCOUNT)
 . D STTINC("PACS IMAGE COUNT",IMAGECOUNT)
 . I VISTAUIDFLAG D
 . . W !," (Query with Accession Number failed, but worked with VistA Study Instance UID)"
 . . Q
 . Q
 E  D
 . W ?70,"--",?77,"--"
 . D STTINC("PACS STUDIES WITHOUT IMAGES",1)
 . Q
 ;
 I ^TMP("MAG",$J,"BATCH Q/R","OPTION")="RETRIEVE MISSING IMAGES" D
 . S ERROR=$$RETRIEVE^MAGDSTAC(.PACSSTUDYUID)
 . Q
 ;
 ;
 ; cleanup
 K ^TMP("MAG",$J,"DICOM"),^("Q/R QUERY"),^("UIDS")
 Q 0
 ;
 ;
HEADER(CONTINUE,CLEARSCREEN) ;
 S CONTINUE=$G(CONTINUE,1)
 S CLEARSCREEN=$G(CLEARSCREEN,1)
 I CONTINUE D CONTINUE^MAGDSTQ(0)
 I CLEARSCREEN W @IOF
 E  W !! S $Y=0
 W $$FMTE^XLFDT($$NOW^XLFDT,1),?55,"VistA",?71,"PACS"
 W !,"Report #",?11,"Accession Number",?32,"Date",?40,"Group #",?51,"Series Images",?66,"Series Images"
 I ^TMP("MAG",$J,"BATCH Q/R","OPTION")="RETRIEVE MISSING IMAGES" D
 . W ?82,"Retrieve Status"
 . Q
 W !,"--------",?11,"----------------",?30,"--------",?40,"--------",?51,"------ ------",?66,"------ ------"
 I ^TMP("MAG",$J,"BATCH Q/R","OPTION")="RETRIEVE MISSING IMAGES" D
 . W ?82,"-------- ------"
 . Q
 Q
 ;
QRSTATUS(TEXT) ; output query/retrieve status text
 I $Y>(IOSL-4) D HEADER(1)
 W:$X>82 ! W ?82,TEXT
 Q
 ;
SUSPEND(HOURS) ; check date/time & request to stop
 ; HOURS is a 24 character string of Y's and N's indicating active times
 ; Assume that Saturday and Sunday are 24 hours
 N DONE,FIRSTTIME,TICKER,X
 ;
 I SCANMODE="ACCESSION" Q 0  ; don't check for accession number scans
 ;
 S (DONE,TICKER)=0,FIRSTTIME=1
 I "23"[($H#7) S HOURS=$TR($J("",24)," ","Y") ; Saturday and Sunday
 F  D  Q:DONE
 . I $G(^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,$J,"STATUS"))'="RUN" D  Q  ; menu stop
 . . S DONE=-1 ; indicates user stop task
 . . W !!,"User requested VistA Automatic Q/R Processing to stop at ",$$FMTE^XLFDT($$NOW^XLFDT,1)
 . . Q
 . I $$S^%ZTLOAD("Stopping "_ZTDESC)  D  Q  ; user has asked task to stop
 . . S DONE=-1 ; indicates user stop task
 . . S ZTSTOP=1 ; notify submanager of response to user's STOP request
 . . W !!,"User requested task to stop at ",$$FMTE^XLFDT($$NOW^XLFDT,1)
 . . Q
 . S X=$E(HOURS,$P($H,",",2)\3600+1)
 . I X="Y" S DONE=1
 . E  D  ; suspend run  
 . . I FIRSTTIME W !!,"Waiting for time to start " S FIRSTTIME=0
 . . ; Show "idle" marker
 . . S TICKER=TICKER+1 S:TICKER<1 TICKER=1 S:TICKER>4 TICKER=1
 . . I $E(IOST,1,2)="C-" W $E("-\|/",TICKER),$C(8)
 . . H 1
 . . Q
 . Q
 Q $S(DONE=1:0,1:DONE)
 ;
STOP ; stop job
 N COUNT,DONE,LIST,X
 S COUNT=$$STOP1(.LIST)
 I 'COUNT D
 . W !!,"No VistA Automatic Q/R Processes appear to be running."
 . Q
 E  D
 . D STOP2(.LIST,COUNT)
 . I COUNT=1 D
 . . S ERROR=$$YESNO^MAGDSTQ("Stop this process?","y",.X)
 . . I ERROR<0 W " YESNO ERROR" Q
 . . I X="YES" D
 . . . D STOP3(.LIST,1)
 . . . Q
 . . Q
 . E  D
 . . S DONE=0 F  D  Q:DONE
 . . . W !!,"Enter 1-",COUNT," to stop a procss: "
 . . . R X:DTIME  E  S X="^"
 . . . I X="" W " -- nothing selected" Q
 . . . I X["^" S DONE=-11 Q
 . . . I X?1N.N,X,X'>COUNT D
 . . . . D STOP3(.LIST,X)
 . . . . S DONE=1
 . . . . Q
 . . . E  D
 . . . . W " ???"
 . . . . Q
 . . . Q
 . . Q
 . Q
 D CONTINUE^MAGDSTQ
 Q
 ;
STOP1(LIST) ; get list of running VistA Automatic Q/R Processes
 N COUNT,HOSTNAME,I,JOB,MAGXTMP
 S COUNT=0
 S MAGXTMP="MAG Q/R Client"
 F  S MAGXTMP=$O(^XTMP(MAGXTMP)) Q:MAGXTMP'?1"MAG Q/R Client".E  D
 . S HOSTNAME=""
 . F  S HOSTNAME=$O(^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME)) Q:HOSTNAME=""  D
 . . S JOB=0
 . . F  S JOB=$O(^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,JOB)) Q:'JOB  D
 . . . S COUNT=COUNT+1
 . . . S LIST(COUNT)=MAGXTMP_"^"_HOSTNAME_"^"_JOB
 . . . Q
 . . Q
 . Q
 Q COUNT
 ;
STOP2(LIST,COUNT) ; display the jobs
 N HOSTNAME,I,JOB,MAGXTMP
 F I=1:1:COUNT D
 . S MAGXTMP=$P(LIST(I),"^",1),HOSTNAME=$P(LIST(I),"^",2),JOB=$P(LIST(I),"^",3)
 . W ! W:COUNT>1 $J(I,2),")"
 . W ?4,^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,JOB,"IMAGING SERVICE")
 . W ?20,^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,JOB,"OPTION")
 . W ?50,"Started: ",$$FMTE^XLFDT(^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,JOB,"START TIME"),"2MP")
 . Q
 Q
 ;
STOP3(LIST,I) ; signal the process to stop by killing the "STATUS" node
 N HOSTNAME,JOB,MAGXTMP
 S MAGXTMP=$P(LIST(I),"^",1),HOSTNAME=$P(LIST(I),"^",2),JOB=$P(LIST(I),"^",3)
 K ^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,JOB)
 W !!,"VistA Automatic Q/R Processing will stop soon."
 Q
 ;
STTWRITE(NAME,VALUE) ; write statistics for the run
 N IEN
 S VALUE=$G(VALUE)
 S IEN=$$STTNAME(NAME) Q:IEN<0
 I IEN>0 D STTUPDT(NAME,VALUE) Q  ; use update instead
 S IEN=$O(^MAGDSTT(2006.543,RUNNUMBER,2,"B"),-1)+1
 S ^MAGDSTT(2006.543,RUNNUMBER,2,IEN,0)=NAME_"^"_VALUE
 S ^MAGDSTT(2006.543,RUNNUMBER,2,"B",NAME,IEN)=""
 S ^MAGDSTT(2006.543,RUNNUMBER,2,0)="^2006.5432^"_IEN_"^"_IEN
 Q
 ;
STTREAD(NAME) ; read a statistics parameter
 N IEN
 S IEN=$$STTNAME(NAME) Q:IEN<0
 I IEN="" D  Q ""
 . W !,"*** ERROR in STTREAD^",$T(+0)," ***"
 . W !,"NAME """,NAME,""" is not defined in"
 . W " ^MAGDSTT(2006.543,",RUNNUMBER,")."
 . Q 
 Q $P(^MAGDSTT(2006.543,RUNNUMBER,2,IEN,0),"^",2)
 ;
STTUPDT(NAME,VALUE) ; update a statistics parameter
 N IEN
 S VALUE=$G(VALUE)
 S IEN=$$STTNAME(NAME) Q:IEN<0
 I IEN="" D STTWRITE(NAME,VALUE) Q
 S $P(^MAGDSTT(2006.543,RUNNUMBER,2,IEN,0),"^",2)=VALUE
 Q
 ;
STTINC(NAME,VALUE) ; increment a statistics parameter
 N IEN
 S VALUE=+$G(VALUE)
 S IEN=$$STTNAME(NAME) Q:IEN<0
 I IEN="" D STTWRITE(NAME,VALUE) Q
 S $P(^(0),"^",2)=$P(^MAGDSTT(2006.543,RUNNUMBER,2,IEN,0),"^",2)+VALUE
 Q
 ;
STTNAME(NAME) ; get IEN for NAME
 ; return: -1 for an error, "" for no NAME, IEN otherwise
 N IEN
 S NAME=$G(NAME)
 I NAME="" D  Q -1
 . W !,"*** ERROR in STTNAME^",$T(+0)
 . W " NAME is null or undefined ***"
 . Q
 ; check for existence of the statistical parameter
 S IEN=$O(^MAGDSTT(2006.543,RUNNUMBER,2,"B",NAME,""))
 Q IEN
