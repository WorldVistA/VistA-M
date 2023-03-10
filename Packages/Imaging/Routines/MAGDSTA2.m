MAGDSTA2 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Aug 19, 2020@16:04:13
 ;;3.0;IMAGING;**231**;MAR 19, 2002;Build 9;Feb 27, 2015
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
 ; Supported IA #10003 reference ^%DT subroutine call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10000 reference NOW^%DTC subroutine call
 ;
 Q
 ;
QRSCP ; get the PACS DICOM Q/R SCP for the retrieve
 N DEFAULT,TITLE,X
 ;
 I IMAGINGSERVICE="RADIOLOGY" D
 . S TITLE="Radiology PACS"
 . Q
 E  D
 . S TITLE="Default Consult"
 . Q
 ;
 K ^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP") ; first remove the old value
 ;
 ; now get the new value
 S DEFAULT=$G(^TMP("MAG",$J,"Q/R PARAM","QUERY USER APPLICATION"))
 I $L(DEFAULT) D
 . W !!,"The ",TITLE," Query/Retrieve Provider is """,DEFAULT,"""."
 . I $$YESNO^MAGDSTQ("Do you wish to change it?","n",.X)<0 Q
 . I X="YES" D
 . . D QRSCP1
 . . Q
 . E  D
 . . S ^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP")=DEFAULT
 . . Q
 . Q
 E  D QRSCP1
 Q
 ;
QRSCP1 ; get new value
 N OK,QRSCP
 S OK=0 F  D  Q:OK
 . W !!,"Please select the ",TITLE," Query/Retrieve Provider"
 . S QRSCP=$$PICKSCP^MAGDSTQ9(DEFAULT,"Q/R")
 . I QRSCP="" W !!,"No ",TITLE," query/retrieve SCP was selected" S OK=-1 Q
 . S ^TMP("MAG",$J,"Q/R PARAM","QUERY USER APPLICATION")=QRSCP
 . S ^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP")=QRSCP
 . S OK=1
 . Q
 Q
 ;
 ;
 ;
SORTORDR ; get the direction for the ^RARPT OR ^GMR search
 N X
 S SORTORDER=$G(^TMP("MAG",$J,"BATCH Q/R","SORT ORDER"))
 I $L(SORTORDER) D
 . W !!,"The studies will be scanned in the """,SORTORDER,""" order."
 . I $$YESNO^MAGDSTQ("Do you wish to change it?","n",.X)<0 S QUIT=1 Q
 . I X="YES" D SORTORD1
 . Q
 E  D SORTORD1
 Q
 ;
SORTORD1 ; get new value
 N OK
 S OK=0 F  D  Q:OK
 . I SORTORDER="" S SORTORDER="ASCENDING"
 . W !!,"Enter the scanning order for studies: ",SORTORDER,"// "
 . R X:DTIME E  S OK=-1 Q
 . I X["^" S OK=-1 Q
 . I X="" S X=SORTORDER,OK=2 W X Q
 . I "Aa"[$E(X) S SORTORDER="ASCENDING",OK=1 Q
 . I "Dd"[$E(X) S SORTORDER="DESCENDING",OK=1 Q
 . W !!,"Enter either Ascending (oldest to newest) or Descending (newest to oldest).",!
 . Q
 I OK<0 S QUIT=1 Q
 I SORTORDER'=$G(^TMP("MAG",$J,"BATCH Q/R","SORT ORDER")) D
 . S ^TMP("MAG",$J,"BATCH Q/R","SORT ORDER")=SORTORDER
 . W:OK=1 " -- changed"
 . Q
 Q
 ;
 ;
BEGDATE ; get the beginning date for the scan
 N %DT,X,Y
 ; following line is for RPT option
 I '$D(SORTORDER) N SORTORDER S SORTORDER="ASCENDING"
 W !!,"Enter the earliest date for the study.",!
 S Y=$G(^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE"))
 I Y S %DT("B")=$$FMTE^XLFDT(Y,1) ; default
 I SORTORDER="ASCENDING" D
 . S %DT(0)=-$$MIDNIGHT
 . Q
 E  D  ; DESCENDING
 . S %DT(0)=-$G(^TMP("MAG",$J,"BATCH Q/R","END DATE"))
 . Q
 S %DT="AEPTS",%DT("A")="Earliest Study Date: ",X="" D ^%DT
 I Y=-1 S QUIT=1
 E  S ^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE")=Y
 Q
 ;
 ;
ENDDATE ; get the ending date for the scan
 N %DT,X,Y
 ; following line is for RPT option
 I '$D(SORTORDER) N SORTORDER S SORTORDER="ASCENDING"
 W !!,"Enter the latest date for the study.",!
 S Y=$G(^TMP("MAG",$J,"BATCH Q/R","END DATE"))
 I Y S %DT("B")=$$FMTE^XLFDT(Y,1) ; default
 ; set the earliest date
 I SORTORDER="ASCENDING" D
 . S %DT(0)=$G(^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE"))
 . Q
 E  D  ; DESCENDING
 . S %DT(0)=-$$MIDNIGHT
 . Q
 S %DT="AEPTS",%DT("A")="Latest Study Date: ",X="" D ^%DT
 I Y=-1 S QUIT=1
 E  D
 . I Y'[".",$E(Y,4,5),$E(Y,6,7) S Y=Y+.235959 ; end of day
 . S ^TMP("MAG",$J,"BATCH Q/R","END DATE")=Y
 . Q
 Q
 ;
MIDNIGHT() ; return midnight today
 N %,%H,%I,X
 D NOW^%DTC
 Q X+.24
 ;
BATCHSIZ ; get the size of the batch of studies to be retrieved in one run
 N BATCHSIZE,X
 S BATCHSIZE=$G(^TMP("MAG",$J,"BATCH Q/R","BATCH SIZE"))
 I BATCHSIZE D
 . W !!,"This run will try to retrieve images for ",BATCHSIZE," studies."
 . I IMAGINGSERVICE="CONSULTS" D
 . . W !,"Only image-enabled consults and procedures are counted."
 . . Q
 . I $$YESNO^MAGDSTQ("Do you wish to change this count?","n",.X)<0 S QUIT=1 Q
 . I X="YES" D BATCHSZ1
 . Q
 E  D BATCHSZ1
 Q
 ;
BATCHSZ1 ; get the batch size for the retrieve run
 N DEFAULT,OK,X
 S DEFAULT=$S(BATCHSIZE:BATCHSIZE,1:100)
 S OK=0 F  D  Q:OK
 . W !!,"Enter the new value of the batch size: ",DEFAULT,"// "
 . R X:DTIME E  S OK=-1 Q
 . I X["^" S OK=-1 Q
 . I X="" S X=DEFAULT W X
 . I X?1.N S OK=$S(X=DEFAULT:2,1:1) Q
 . W "  ??? (enter a a positive integer number)"
 . Q
 I OK<0 S QUIT=1 Q
 D:BATCHSIZE'=X
 . S ^TMP("MAG",$J,"BATCH Q/R","BATCH SIZE")=X
 . W:X=1 " -- changed"
 . Q
 Q
 ;
 ;
HOURS ; get hours of operation
 N HOURS,X
 S HOURS=$G(^TMP("MAG",$J,"BATCH Q/R","HOURS OF OPERATION"))
 I HOURS'="" D
 . W !!,"The active hours of operation are indicated below with a ""Y"""
 . W !?18,"M12345678901N12345678901 (M=midnight, N=noon)"
 . W !,"Active hours are: ",HOURS
 . I $$YESNO^MAGDSTQ("Do you wish to change these hours?","n",.X)<0 S QUIT=1 Q
 . I X="YES" D HOURS1
 . Q
 E  D HOURS1
 Q
 ;
HOURS1 ; initialize/modify the hours of operations
 N DEFAULT,FULLDAY,I,OK,X
 S FULLDAY=$TR($J("",24)," ","Y") ; 24 hours
 S DEFAULT=$S($L(HOURS):HOURS,1:FULLDAY)
 S DEFAULT=$E(DEFAULT_"NNNNNNNNNNNNNNNNNNNNNNNN",1,24)
 S OK=0 F  D  Q:OK
 . W !?18,"M12345678901N12345678901 (M=midnight, N=noon)"
 . W !,"Active hours are: ",DEFAULT
 . W !?15,"// " R X:DTIME E  S OK=-1 Q
 . I X["^" S OK=-1 Q
 . I X="" S X=DEFAULT W X
 . S X=$TR(X,"yn","YN")
 . I $TR(X,"YN")="" D
 . . S X=$E(X_FULLDAY,1,24)
 . . S OK=1
 . . S ^TMP("MAG",$J,"BATCH Q/R","HOURS OF OPERATION")=X
 . . W " -- changed"
 . . Q
 . E  D
 . . W !,?18 F I=1:1:24 S Z=$E(X,I) W $S("YN"'[Z:"^",1:" ")
 . . W !!,"Enter a sequence of (up to) 24 ""Y's"" and ""N's""."
 . . W !,"Every ""Y"" represents an hour when DICOM Query/Retrieve will be active."
 . . W !,"Every ""N"" represents an hour when DICOM Query/Retrieve will not be active.",!
 . . Q
 . Q
 I OK=-1 S QUIT=1
 Q
 ;
ACNUM ; get the accession number
 N GMRCIEN,HOURS,OK,RADPT1,RADPT2,RADPT3,RARPT1,RUNNUMBER,X,Y,Z,ZTDESC
 S HOURS="YYYYYYYYYYYYYYYYYYYYYYYY"
 S RUNNUMBER=0 ; not interested in this
 S FIRSTTIME=1
 D TASKINIT^MAGDSTA1
 S X=MAGIOM X ^%ZOSF("RM") ; set right margin to 80 or 132
 S OK=0  F  D  Q:OK
 . I ^TMP("MAG",$J,"BATCH Q/R","IMAGING SERVICE")="RADIOLOGY" D
 . . S OK=$$ACNUMRAD
 . . Q
 . E  D  ; consults
 . . S OK=$$ACNUMCON
 . . K ^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES") ; remove old ones
 . . Q
 . Q
 Q
 ;
ACNUMRAD() ; get and process a radiology study
 W !!!!,"Enter the accession number: "
 R X:DTIME E  Q -1
 I "^"[X Q -1
 I X?1"?".E D  Q 0
 . W !,"Enter either the site-specific accession number (sss-MMDDYY-nnnn),"
 . W !,"or just the legacy accession number (MMDDYY-nnnn) portion."
 . Q
 S X=$$ACCFIND^RAAPI(X,.RAA)
 I X'=1 D  Q 0
 . W " ??? not on file"
 . Q
 S RADPT1=$P(RAA(1),"^",1),RADPT2=$P(RAA(1),"^",2),RADPT3=$P(RAA(1),"^",3)
 S Y=$G(^RADPT(RADPT1,"DT",RADPT2,"P",RADPT3,0))
 S RARPT1=$P(Y,"^",17) ; REPORT TEXT
 D HEADER^MAGDSTAA(0,0)
 S Z=$$RADLKUP1^MAGDSTA5(RARPT1)
 Q 0
 ;
ACNUMCON() ; get and process a consult study
 N CONSULTSERVICES,LIST,PICK,SERVICE,SERVICENAME
 ;
 ; build the list of all consult services
 S SERVICE=""
 F I=1:1 S SERVICE=$O(^MAG(2006.5831,"B",SERVICE)) Q:'SERVICE  D
 . S SERVICENAME=$$GET1^DIQ(123.5,SERVICE,.01,"E")
 . S LIST(I)=SERVICENAME_"^"_SERVICE,PICK(I)=1
 . Q
 D SERVICE4^MAGDSTA8(.CONSULTSERVICES,"YES",.LIST,.PICK)
 K ^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES") ; remove old ones
 M ^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES")=CONSULTSERVICES
 ;
 W !!!!,"Enter the accession number: "
 R X:DTIME E  Q -1
 I "^"[X Q -1
 I X?1"?".E D  Q 0
 . W !,"The consult accession number has two formats: ""sss-GMR-nnnn"" and ""GMRC-nnnn""."
 . W !,"Enter the accession number or just the digits following the ""GMR-"" or ""GMRC-""."
 . Q
 S GMRCIEN=$P(X,"-",$L(X,"-"))
 I '$D(^GMR(123,GMRCIEN)) D  Q 0
 . W " ??? not on file"
 . Q
 D HEADER^MAGDSTAA(0,0)
 S Z=$$CONLKUP1^MAGDSTA7(GMRCIEN)
 Q 0
