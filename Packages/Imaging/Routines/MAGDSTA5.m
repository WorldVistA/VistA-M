MAGDSTA5 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Mar 08, 2022@08:59:51
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
 ;
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Controlled Subscription IA #1171 to read RAD/NUC MED REPORTS file (#74)
 ;
 Q
 ;
 ; Look for images for completed studies.  The status must be either
 ; V-VERIFIED or EF-ELECTRONICALY FILED.
 ;
MAIN() ; The main loop for the program for Radiology
 ; Input Variables 
 ; SCANMODE ;-- "PATIENT", "DATE", or "NUMBER"
 ; DIRECTION ;- 1="ASCENDING" or 0="DESCENDING"
 ; BATCHSIZE ;- number of consult & procedure requests to process on this run
 ; BEGDATE ;--- begin date for search
 ; ENDDATE ;-- end date for search
 ; QRSCP ;----- default query/retrieve provider
 ; HOURS ;----- 24 character string of Y's and N's indicating active times
 ;
 N RARPT1,RUNTIME,STOP,X
 ;
 D HEADER^MAGDSTAA(0)
 ;
 ; STOP: -1=error, 0=run completed, 1=run stopped
 S STOP=$$RADLKUP()
 Q STOP
 ;
RADLKUP() ; Find the next study to retrieve
 N STOP
 I SCANMODE="PATIENT" D
 . S STOP=$$PATIENT()
 . Q
 E  I SCANMODE="DATE" D
 . S STOP=$$DATE()
 . Q
 E  I SCANMODE="NUMBER" D
 . S STOP=$$NUMBER()
 . Q
 E  D
 . W !!,"*** Illegal SCAN MODE: """,SCANMODE,""""
 . S STOP=-1
 . Q
 Q STOP
 ;
PATIENT() ; use ^RARPT "C" xref to find studies for a single patient
 ; ^RARPT("C",DFN,RARPT1)=""
 N EXAMDATE,RARPT0,RARPT1,RETURN,STATUS,STOP
 S STOP=0 ; set to stop the q/r process
 S RARPT1=""
 F  S RARPT1=$O(^RARPT("C",DFN,RARPT1),DIRECTION) Q:'RARPT1  Q:STOP  D
 . S RARPT0=$G(^RARPT(RARPT1,0))
 . S EXAMDATE=$P(RARPT0,"^",3),STATUS=$P(RARPT0,"^",5)
 . Q:EXAMDATE<BEGDATE  Q:EXAMDATE>ENDDATE
 . I STATUS'="V",STATUS'="EF" Q
 . S STOP=$$RADLKUP1(RARPT1)
 . Q
 Q STOP
 ;
DATE() ; use ^RARTPT "AA" xref to find studies by verified date
 ; ^RARPT("AA",RADTI,RARPT1)=""
 N DATEBEG,DATESTOP,DONE,RADTI,RARPT0,RARPT1,RETURN,STATUS,STOP
 S STOP=0 ; set to stop the q/r process
 D SETDATES(.DATEBEG,.DATESTOP,BEGDATE,ENDDATE,DIRECTION)
 S RADTI=DATEBEG,(DONE,RETURN)=0
 ; reverse date, opposite sort order
 F  S RADTI=$O(^RARPT("AA",RADTI),-DIRECTION) Q:'RADTI  Q:DONE  Q:STOP  D
 . I DIRECTION=1 S DONE=RADTI<DATESTOP Q:DONE
 . E  S DONE=RADTI>DATESTOP Q:DONE
 . S RARPT1=""
 . F  S RARPT1=$O(^RARPT("AA",RADTI,RARPT1),DIRECTION) Q:'RARPT1  Q:STOP  D
 . . S RARPT0=$G(^RARPT(RARPT1,0))
 . . S STATUS=$P(RARPT0,"^",5)
 . . I STATUS'="V",STATUS'="EF" Q
 . . S STOP=$$RADLKUP1(RARPT1)
 . . Q
 . Q
 Q STOP
 ;
NUMBER() ; use ^RARPT ien
 ; ^RARPT(RARPT1,...
 N BATCHSIZE,RARPT0,RARPT1,RETURN,STOP,STATUS,STUDYCNT
 S STOP=0 ; set to stop the q/r process
 S STUDYCNT=0 ; only count completed (V or EF) studies
 S BATCHSIZE=$G(^TMP("MAG",$J,"BATCH Q/R","BATCH SIZE"))
 S RARPT1=$G(^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN"))
 S RARPT1=RARPT1-DIRECTION ; Massage value for $O
 F  S RARPT1=$O(^RARPT(RARPT1),DIRECTION) Q:'RARPT1  Q:STUDYCNT>=BATCHSIZE  Q:STOP  D
 . S RARPT0=$G(^RARPT(RARPT1,0))
 . S STATUS=$P(RARPT0,"^",5)
 . ; should this study have image?
 . I STATUS'="V",STATUS'="EF" Q  ; nope
 . S STUDYCNT=STUDYCNT+1
 . S STOP=$$RADLKUP1(RARPT1)
 . Q
 Q STOP
 ;
RADLKUP1(RARPT1) ; lookup one radiology exam
 N ACNUMB,DFN,EXAMDATE,HOSPDIV,MAGIEN,MAGIENLIST,RADPT0,RADTI,RARPT0,RARPT3
 ;
 S RARPT0=$G(^RARPT(RARPT1,0))
 S ACNUMB=$P(RARPT0,"^",1),DFN=$P(RARPT0,"^",2)
 S EXAMDATE=$P(RARPT0,"^",3)
 ;
 ; check DIVISION
 S RADTI=$$RADTI(EXAMDATE)
 S RADPT0=$G(^RADPT(DFN,"DT",RADTI,0))
 S HOSPDIV=$P(RADPT0,"^",3) ; HOSPITAL DIVISION
 I $$CHECKDIV^MAGDSTAB()="Y",HOSPDIV'=DIVISION Q 0 ; not the user's division
 ;
 ; lookup legacy 2005 image group pointers
 S RARPT3=0
 F  S RARPT3=$O(^RARPT(RARPT1,2005,RARPT3)) Q:'RARPT3  D
 . S MAGIEN=$G(^RARPT(RARPT1,2005,RARPT3,0))
 . S MAGIENLIST(MAGIEN)=""
 . Q
 Q $$LOOKUP^MAGDSTAA(DFN,EXAMDATE,RARPT1,ACNUMB,.MAGIENLIST)
 ;
SETDATES(DATEBEG,DATESTOP,BEGDATE,ENDDATE,DIRECTION) ; get date range
 ; get the beginning and ending dates for the FOR loop
 ; these are in RARPT reverse date format
 ; they are also DIRECTION specific
 I DIRECTION=1 D  ; ascending direction
 . S DATEBEG=$$RADTI(BEGDATE)
 . S DATESTOP=$$RADTI(ENDDATE)
 . Q
 E  D  ; descending direction
 . S DATEBEG=$$RADTI(ENDDATE)
 . S DATESTOP=$$RADTI(BEGDATE)
 . Q 
 Q
 ;
RADTI(RADTI) ; convert a reverse date to a FM date and vice versa
 Q 9999999.9999-RADTI ; 9's complement conversion
