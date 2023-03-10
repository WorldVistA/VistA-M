MAGDSTA1 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Mar 08, 2022@07:55:07
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
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10103 reference $$FMADD^XLFDT function call
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Supported IA #1519 reference EN^XUTMDEVQ subroutine call
 ; Supported IA #10097 reference $$EC^%ZOSV
 ; Supported IA #1621 reference UNWIND^%ZTER
 ; Supported IA #10035 to read PATIENT file (#2)
 ;
 Q
 ;
ENTRY(MENUOPTION) ; Entry point from main menu
 N ACNUMB,BATCHSIZE,BEGDATE,DFN,ENDDATE,HOSTNAME,HOURS,IMAGINGSERVICE,OPTION,QRSCP,QRSTACK
 N MAGIOM,MAGXTMP,RUNTIME,SCANMODE,SORTORDER,STARTIEN,STARTTIME,STATUS,STUDYDATE,STUDYIEN
 N CONSULTSERVICES,DEFAULT,DIVISION,DONE,ERROR,I,LASTRUN,OK,QUESTION,QUIT,SERVICES,X,ZTDESC
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 ;
 ; application-wide variables
 S OPTION=$G(^TMP("MAG",$J,"BATCH Q/R","OPTION"))
 S IMAGINGSERVICE=$G(^TMP("MAG",$J,"BATCH Q/R","IMAGING SERVICE"))
 S QRSTACK="AUTOMATIC"
 S HOSTNAME=$$HOSTNAME^MAGDFCNV
  I $$CHECKDIV^MAGDSTAB()="" D  Q
 . W !!,"*** Use the PARM option to set Check Study Division switch ***"
 . D CONTINUE^MAGDSTQ
 . Q
 S DIVISION=$G(DUZ(2),0) ; user's logon division
 I $$CHECKDIV^MAGDSTAB()="Y",'DIVISION D  Q
 . W !!,"*** User's Division is not defined ***"
 . D CONTINUE^MAGDSTQ
 . Q
 ;
 S MAGXTMP=$$INITXTMP^MAGDSTQ0
 ;
 S DEFAULT=$G(^TMP("MAG",$J,"Q/R PARAM","SCAN MODE"),"DATE")
 W ! S OK=0 F  D  Q:OK
 . I IMAGINGSERVICE="RADIOLOGY" D
 . . W !!,"Scan by Date, Report Number, Patient, or Accession (D, N, P, or A): "
 . . Q
 . E  D
 . . W !!,"Scan by Date, Consult Number, Patient, or Accession (D, N, P, or A): "
 . . Q
 . I $L(DEFAULT) W DEFAULT,"// "
 . R X:DTIME E  S OK=-1 Q
 . I X="",$L(DEFAULT) S X=DEFAULT W X
 . I X="" S OK=-1 Q
 . I X["^" S OK=-1 Q
 . I "Dd"[$E(X) S SCANMODE="DATE",OK=1 Q
 . I "Nn"[$E(X) S SCANMODE="NUMBER",OK=1 Q
 . I "Pp"[$E(X) S SCANMODE="PATIENT",OK=1 Q
 . I "Aa"[$E(X) S SCANMODE="ACCESSION",OK=1 Q
 . W "   ???",!,"Please enter ""D"", ""N"", ""P"", or ""A""."
 . Q
 Q:OK'=1  ; didn't enter a choice
 S ^TMP("MAG",$J,"Q/R PARAM","SCAN MODE")=SCANMODE
 ;
 ; get parameters of last run
 S LASTRUN=$O(^MAGDSTT(2006.543,"C",MENUOPTION,$E(SCANMODE,1),""),-1)
 I LASTRUN D
 . S X="Parameters of the Previous "_SCANMODE_" Run"
 . W !!?10,X,!?10 F I=1:1:$L(X) W "-"
 . D LASTRUN^MAGDSTAS(LASTRUN)
 . D DISPLAY1^MAGDSTA9
 . I STATUS="COMPLETED" D
 . . W !!,"The last ",SCANMODE," scan run completed on ",$$FMTE^XLFDT(RUNTIME)
 . . S ERROR=$$YESNO^MAGDSTQ("Start this "_SCANMODE_" scan where the last run ended?","y",.X)
 . . I ERROR<0 W " YESNO ERROR" Q
 . . I X="YES" D
 . . . D COPYPARM(1)
 . . . Q
 . . E  D
 . . . K ^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN")
 . . . K PICK ; consult service list
 . . . Q
 . . Q
 . E  I STATUS="RUNNING" D
 . . W !!,"THE LAST ",SCANMODE," SCAN RUN HAS NOT YET COMPLETED. The last action was on ",$$FMTE^XLFDT(RUNTIME)
 . . S ERROR=$$YESNO^MAGDSTQ("Start this "_SCANMODE_" scan where the last run is expected to end?",,.X) ; no default
 . . I ERROR<0 W " YESNO ERROR" Q
 . . I X="YES" D
 . . . D COPYPARM(1)
 . . . Q
 . . E  D
 . . . K ^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN")
 . . . Q
 . . Q
 . E  I STATUS="STARTED" D
 . . W !!,"THE LAST ",SCANMODE," SCAN RUN HAS NOT YET BEGUN. The last action was on ",$$FMTE^XLFDT(RUNTIME)
 . . S ERROR=$$YESNO^MAGDSTQ("Start this "_SCANMODE_" scan where the last run is expected to end?",,.X) ; no default
 . . I ERROR<0 W " YESNO ERROR" Q
 . . I X="YES" D
 . . . D COPYPARM(1)
 . . . Q
 . . E  D
 . . . K ^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN")
 . . . Q
 . . Q
 . E  D
 . . W !!,"THE LAST ",SCANMODE," SCAN RUN ABNORMALLY TERMINATED: ",STATUS
 . . W !,"The last action was on ",$$FMTE^XLFDT(RUNTIME)
 . . S ERROR=$$YESNO^MAGDSTQ("Start this "_SCANMODE_" scan where the last run abnormally ended?",,.X) ; no default
 . . I ERROR<0 W " YESNO ERROR" Q
 . . I X="YES" D
 . . . D COPYPARM(0)
 . . . Q
 . . E  D
 . . . K ^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN")
 . . . Q
 . . Q
 . . Q
 . Q
 ;
 I '$D(^TMP("MAG",$J,"BATCH Q/R","HOURS OF OPERATION")) D
 . S ^TMP("MAG",$J,"BATCH Q/R","HOURS OF OPERATION")="YYYYYYYYYYYYYYYYYYYYYYYY"
 . Q
 ;
 D QRSCP^MAGDSTA2 ; get query/retrieve scp for radiology & consults
 I $G(^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP"))="" W " -- Exiting" Q
 ;
 I SCANMODE="ACCESSION" D  Q  ; single accession number compare/retrieve
 . D ACNUM^MAGDSTA2
 . Q
 ;
 S X=0
 I IMAGINGSERVICE="CONSULTS" D
 . S X=$$SERVICES^MAGDSTA8(.CONSULTSERVICES,"YES")
 . K ^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES") ; remove old ones
 . M ^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES")=CONSULTSERVICES
 . Q
 I X<0 W !,"Exiting" Q
 ;
 I SCANMODE="NUMBER" D
 . S QUESTION="SORTORDR^MAGDSTA2"
 . I IMAGINGSERVICE="RADIOLOGY" D
 . . S QUESTION=QUESTION_" RARPT1^MAGDSTA4"
 . . Q
 . E  D  ; consults
 . . S QUESTION=QUESTION_" STUDY1^MAGDSTA6"
 . . Q
 . S QUESTION=QUESTION_" BATCHSIZ^MAGDSTA2 HOURS^MAGDSTA2 VERIFY^MAGDSTA9"
 . S QUESTION("ASCENDING")=QUESTION
 . S QUESTION("DESCENDING")=QUESTION
 . Q
 E  I SCANMODE="DATE" D
 . S QUESTION="SORTORDR^MAGDSTA2"
 . S QUESTION("ASCENDING")=QUESTION_" BEGDATE^MAGDSTA2 ENDDATE^MAGDSTA2 HOURS^MAGDSTA2 VERIFY^MAGDSTA9"
 . S QUESTION("DESCENDING")=QUESTION_" ENDDATE^MAGDSTA2 BEGDATE^MAGDSTA2 HOURS^MAGDSTA2 VERIFY^MAGDSTA9"
 . Q
 E  I SCANMODE="PATIENT" D
 . S QUESTION="PATIENTA^MAGDSTQA SORTORDR^MAGDSTA2"
 . S QUESTION("ASCENDING")=QUESTION_" BEGDATE^MAGDSTA2 ENDDATE^MAGDSTA2 HOURS^MAGDSTA2 VERIFY^MAGDSTA9"
 . S QUESTION("DESCENDING")=QUESTION_" ENDDATE^MAGDSTA2 BEGDATE^MAGDSTA2 HOURS^MAGDSTA2 VERIFY^MAGDSTA9"
 . Q
 ; 
 S QUESTION("NONE")=QUESTION("ASCENDING") ; initial default is ASCENDING
 ;
 S SORTORDER="NONE" ; value will change when SORTORDER^MAGDSTA2 is invoked
 F I=1:1:$L(QUESTION(SORTORDER)," ") D  I I<0 S QUIT=-1 Q
 . S QUIT=0
 . D @$P(QUESTION(SORTORDER)," ",I)
 . I QUIT>0 S I=I-2
 . E  I QUIT<0 S I=-1
 . Q
 I QUIT<0 Q
 ;
 D TASKINIT
 ;
 ; Setup for tasking the compare image counts/retrieve job
 ;
 ; ZTDESC is set above
 ;
 N %ZIS,ZTSAVE
 S ZTSAVE("HOSTNAME")=""
 S ZTSAVE("MAGIOM")=""
 S ZTSAVE("MAGXTMP")=""
 S ZTSAVE("MENUOPTION")=""
 S ZTSAVE("^TMP(""MAG"",$J,""BATCH Q/R"",")=""
 S ZTSAVE("^TMP(""MAG"",$J,""Q/R PARAM"",")=""
 S ZTSAVE("QRSTACK")=""
 S ZTSAVE("CONSULTSERVICES(")=""
 D EN^XUTMDEVQ("TASK^"_$T(+0),ZTDESC,.ZTSAVE,.%ZIS)
 Q
 ;
TASKINIT ; initialize MAGIOM and ZTDESC
 I ^TMP("MAG",$J,"BATCH Q/R","OPTION")="RETRIEVE MISSING IMAGES" D
 . W !!,"Recommend report output of 132 columns",!!
 . S MAGIOM=132 ; retrieve requires 132 columns
 . S ZTDESC="Retrieve Missing Images" ; for tasking
 . Q
 E  D  ; compare image counts
 . S MAGIOM=80 ; comparing image counts requires only 80 columns
 . S ZTDESC="Compare Image Counts" ; for tasking
 . Q
 S ZTDESC=ZTDESC_" for "_IMAGINGSERVICE
 Q
 ;
TASK ; entry point for a tasked job
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 N I
 F I=1:1:$L(ZTDESC) W $E(ZTDESC,I)," "
 W !,"-" F I=2:1:$L(ZTDESC) W "--"
 W !,"Started on ",$$FMTE^XLFDT($$NOW^XLFDT,1)
 W " by ",$$GET1^DIQ(200,DUZ,.01,"E")," (DUZ: ",DUZ,")"
 W "  Job Number: ",$J
 D DISPLAY^MAGDSTA9
 W !!
 ;
BEGIN ; entry point for running the image compare or retrieve process
 N ACNUMB,BATCHSIZE,BEGDATE,DFN,ENDDATE,HOURS,IMAGINGSERVICE,OPTION,QRSCP,RUNTIME
 N SCANMODE,SORTORDER,STARTIEN,STARTTIME,STATUS,STUDYDATE,STUDYIEN
 N DIRECTION,I,J,K,L,RUNNUMBER,STOP
 ;
 S X=MAGIOM X ^%ZOSF("RM") ; set right margin to 80 or 132
 ;
 S OPTION=$G(^TMP("MAG",$J,"BATCH Q/R","OPTION"))
 S IMAGINGSERVICE=$G(^TMP("MAG",$J,"BATCH Q/R","IMAGING SERVICE"))
 S SCANMODE=$G(^TMP("MAG",$J,"Q/R PARAM","SCAN MODE"))
 S SORTORDER=$G(^TMP("MAG",$J,"BATCH Q/R","SORT ORDER"))
 S BATCHSIZE=$G(^TMP("MAG",$J,"BATCH Q/R","BATCH SIZE"))
 S STARTIEN=$G(^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN"))
 S BEGDATE=$G(^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE"))
 S ENDDATE=$G(^TMP("MAG",$J,"BATCH Q/R","END DATE"))
 S SORTORDER=$G(^TMP("MAG",$J,"BATCH Q/R","SORT ORDER"))
 S HOURS=^TMP("MAG",$J,"BATCH Q/R","HOURS OF OPERATION")
 S QRSCP=$G(^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP"))
 S DFN=$G(^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN"))
 ;
 L +^MAGDSTT(2006.543,0):30 E  D  Q
 . W !!,"Cannot obtain LOCK on Q/R RETRIEVE DICOM RUN STATISTICS Table.",!!
 . Q
 S X=$G(^MAGDSTT(2006.543,0))
 S $P(X,"^",1,2)="DICOM BATCH Q/R RUN STATISTICS^2006.543"
 S (RUNNUMBER,$P(X,"^",3))=$O(^MAGDSTT(2006.543," "),-1)+1 ; get next IEN
 S $P(X,"^",4)=$P(X,"^",4)+1 ; increment total count
 S ^MAGDSTT(2006.543,0)=X
 ;
 S (RUNTIME,STARTTIME)=$$NOW^XLFDT(),X=""
 S $P(X,"^",1)=STARTTIME
 S $P(X,"^",2)=$E(IMAGINGSERVICE,1) ; R or C
 S $P(X,"^",3)=RUNTIME ; updated during the run
 S $P(X,"^",4)=$E(OPTION,1) ; C or R
 S $P(X,"^",5)="STARTED" ; will be updated during the run
 S $P(X,"^",6)=$E(SCANMODE,1) ; D, N, or P
 S $P(X,"^",7)=QRSCP
 S $P(X,"^",9)=BEGDATE
 S $P(X,"^",10)=ENDDATE
 S $P(X,"^",11)=STARTIEN
 S $P(X,"^",12)=BATCHSIZE
 S $P(X,"^",13)=$E(SORTORDER,1) ; A or D
 S $P(X,"^",14)=HOURS
 S $P(X,"^",15)=DFN
 ;
 ; piece 8 will be set in ^MAGDSTV1
 ; pieces 15-18 will be set in ^MAGDSTAA
 ; 
 S $P(X,"^",19)=DUZ
 S $P(X,"^",20)=MENUOPTION
 S ^MAGDSTT(2006.543,RUNNUMBER,0)=X
 I IMAGINGSERVICE="CONSULTS" D  ; add the consult request services, if applicable
 . S (I,J)=0
 . F  S I=$O(CONSULTSERVICES(I)) Q:'I  D
 . . S J=J+1
 . . S ^MAGDSTT(2006.543,RUNNUMBER,1,J,0)=I
 . . S ^MAGDSTT(2006.543,RUNNUMBER,1,"B",I,J)=""
 . . Q
 . S ^MAGDSTT(2006.543,RUNNUMBER,1,0)="^2006.5431P^"_J_"^"_J
 . Q
 S ^MAGDSTT(2006.543,"B",STARTTIME,RUNNUMBER)=""
 S ^MAGDSTT(2006.543,"C",MENUOPTION,$E(SCANMODE,1),RUNNUMBER)=""
 L -^MAGDSTT(2006.543,0)
 ;
 D INITSTT^MAGDSTA(RUNNUMBER) ; initialize the statistics
 ;
 S ^TMP("MAG",$J,"BATCH Q/R","RUN NUMBER")=RUNNUMBER
 ;
 S DIRECTION=$$DIRECTON(SORTORDER)
 ;
 S ^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,$J,"STATUS")="RUN",^("IMAGING SERVICE")=IMAGINGSERVICE
 S ^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,$J,"SCAN MODE")=SCANMODE,^("OPTION")=OPTION
 S ^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,$J,"START TIME")=$$NOW^XLFDT
 ;
 I IMAGINGSERVICE="RADIOLOGY" D
 . S STOP=$$MAIN^MAGDSTA5()
 . Q
 E  D  ; consults and procedures
 . S STOP=$$MAIN^MAGDSTA7()
 . Q
 ;
 ;
 ; STOP: -1=error, 0=run completed, 1=run stopped
 S RUNTIME=$$NOW^XLFDT()
 S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",3)=RUNTIME ; final time updated
 S X=$S(STOP<0:"Stopped due to Error",STOP>0:"Stopped by User",1:"COMPLETED")
 S $P(^MAGDSTT(2006.543,RUNNUMBER,0),"^",5)=X
 W !!,"RUN ",X
 W " at ",$$FMTE^XLFDT($$NOW^XLFDT,1)
 K ^XTMP(MAGXTMP,"AUTO Q/R",HOSTNAME,$J)
 K ^TMP("MAG",$J,"BATCH Q/R")
 D CONTINUE^MAGDSTQ
 Q
 ;
DIRECTON(SORTORDER) ; return the direction for $order
 ;  1 = normal order
 ; -1 = reverse order
 Q $S(SORTORDER="ASCENDING":1,SORTORDER="DESCENDING":-1)
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
 S DIRECTION=$$DIRECTON(SORTORDER)
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
NEXTDATE(DATE,DIRECTION) ; get the next date, but not in the future
 N NEXTDATE,NOW
 S NOW=$$NOW^XLFDT\1
 S NEXTDATE=$$FMADD^XLFDT(DATE\1,DIRECTION)
 I NEXTDATE>NOW S NEXTDATE=NOW ; no future dates
 Q NEXTDATE
