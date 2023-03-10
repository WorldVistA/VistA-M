MAGDSTA7 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Mar 04, 2022@13:42:59
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
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Supported IA #2056 reference GETS^DIQ subroutine call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Controlled IA #4110 to read REQUEST/CONSULTATION file (#123)
 ; Controlled IA #3461 to read TIU EXTERNAL DATA LINK (#8825.91)
 ;
 Q
 ;
 ; Look for images for partially resulted or completed studies.
 ;
MAIN() ; The main loop for the program for consults and procedures
 ; Input Variables 
 ; SCANMODE ;-- "PATIENT", "DATE", or "NUMBER"
 ; DIRECTION ;- 1="ASCENDING" or 0="DESCENDING"
 ; BATCHSIZE ;- number of consult & procedure requests to process on this run
 ; BEGDATE ;--- begin date for search
 ; ENDDATE ;-- end date for search
 ; QRSCP ;----- default query/retrieve provider
 ; HOURS ;----- 24 character string of Y's and N's indicating active times
 ; 
 N GMRCIEN,RUNTIME,STOP,X
 ;
 D HEADER^MAGDSTAA(0)
 ;
 ; STOP: -1=error, 0=run completed, 1=run stopped
 S STOP=$$CONLKUP()
 Q STOP
 ;
CONLKUP() ; Find the next study to retrieve
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
PATIENT() ; use "AD" cross-reference to find studies for a single patient
 ; ^GMR(123,"AD",DFN,GMRCDATE,GMRCIEN)=""
 N DATEBEG,DATESTOP,DONE,GMRCDATE,STOP
 S STOP=0 ; set to stop the q/r process
 D SETDATES(.DATEBEG,.DATESTOP,BEGDATE,ENDDATE,DIRECTION)
 S GMRCDATE=DATEBEG,DONE=0
 ; reverse date, opposite sort order
 F  S GMRCDATE=$O(^GMR(123,"AD",DFN,GMRCDATE),-DIRECTION) Q:'GMRCDATE  Q:DONE  Q:STOP  D
 . I DIRECTION=1 S DONE=GMRCDATE<DATESTOP Q:DONE
 . E  S DONE=GMRCDATE>DATESTOP Q:DONE
 . S GMRCIEN=""
 . F  S GMRCIEN=$O(^GMR(123,"AD",DFN,GMRCDATE,GMRCIEN),DIRECTION) Q:'GMRCIEN  Q:STOP  D
 . . ; does this consult get images?
 . . I $$CHECK^MAGDSTA6(GMRCIEN)'=1 Q  ; nope
 . . S STOP=$$CONLKUP1(GMRCIEN)
 . . Q
 . Q
 Q STOP
 ;
DATE() ; use "AE" cross-reference to find completed studies
 ; ^GMR(123,"AE",SERVICE,STATUS,GMRCDATE,GMRCIEN)=""
 ; only look for COMPLETED studies and PARTIAL RESULTS
 N DATEBEG,DATESTOP,DONE,GMRCDATE,STATUS,STOP
 S STOP=0 ; set to stop the q/r process
 D SETDATES(.DATEBEG,.DATESTOP,BEGDATE,ENDDATE,DIRECTION)
 S SERVICE="" F  S SERVICE=$O(CONSULTSERVICES(SERVICE)) Q:SERVICE=""  Q:STOP  D
 . F STATUS=2,9 D  ; STATUS=2 for COMPLETE, STATUS=9 for PARTIAL RESULTS
 . . W !!,CONSULTSERVICES(SERVICE)," -- "
 . . W $S(STATUS=2:"COMPLETE",STATUS=9:"PARTIAL RESULTS",1:"Unknown Status "_STATUS)
 . . S GMRCDATE=DATEBEG,DONE=0
 . . ; reverse date, opposite sort order
 . . F  S GMRCDATE=$O(^GMR(123,"AE",SERVICE,STATUS,GMRCDATE),-DIRECTION) Q:'GMRCDATE  Q:DONE  Q:STOP  D
 . . . I DIRECTION=1 S DONE=GMRCDATE<DATESTOP Q:DONE
 . . . E  S DONE=GMRCDATE>DATESTOP Q:DONE
 . . . S GMRCIEN=""
 . . . F  S GMRCIEN=$O(^GMR(123,"AE",SERVICE,STATUS,GMRCDATE,GMRCIEN),DIRECTION) Q:'GMRCIEN  Q:STOP  D
 . . . . ; does this consult get images?
 . . . . I $$CHECK^MAGDSTA6(GMRCIEN)'=1 Q  ; nope
 . . . . S STOP=$$CONLKUP1(GMRCIEN)
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q STOP
 ;
NUMBER() ; use GMRCIEN to find completed studies
 ; ^GMR(123,GMRC)=<consult record>
 N BATCHSIZE,GMRCIEN,STOP,STUDYCNT
 S STOP=0 ; set to stop the q/r process
 S STUDYCNT=0
 S BATCHSIZE=$G(^TMP("MAG",$J,"BATCH Q/R","BATCH SIZE"))
 S GMRCIEN=$G(^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN"))
 S GMRCIEN=GMRCIEN-DIRECTION ; Massage value for $O
 F  S GMRCIEN=$O(^GMR(123,GMRCIEN),DIRECTION) Q:'GMRCIEN  Q:STUDYCNT>=BATCHSIZE  Q:STOP  D
 . ; does this consult get images?
 . I $$CHECK^MAGDSTA6(GMRCIEN)'=1 Q  ; nope
 . S STUDYCNT=STUDYCNT+1
 . S STOP=$$CONLKUP1(GMRCIEN)
 . Q
 Q STOP
 ;
CONLKUP1(GMRCIEN) ; check consult
 N ACNUMB,DFN,EXAMDATE,I,ORDERINGFACILITY,MAGIENLIST
 ;
 S ORDERINGFACILITY=$$GET1^DIQ(123,GMRCIEN,.05,"I")
 I $$CHECKDIV^MAGDSTAB()="Y",ORDERINGFACILITY'=DIVISION Q 0  ; not this division
 ;
 S ACNUMB=$$GMRCACN^MAGDFCNV(GMRCIEN) ; legacy or site-specific
 S EXAMDATE=$$GET1^DIQ(123,GMRCIEN,.01,"I")
 S DFN=$$GET1^DIQ(123,GMRCIEN,.02,"I")
 I $$CONSULT(GMRCIEN,.MAGIENLIST)<0 Q 0
 Q $$LOOKUP^MAGDSTAA(DFN,EXAMDATE,GMRCIEN,ACNUMB,.MAGIENLIST)
 ;
CONSULT(GMRCIEN,MAGIENLIST) ; return a list of MAG Group IENs
 ; A consult may have multiple TIU notes and a TIU note may have multiple image groups.
 ; A consult may also have images associated in the DICOM TEMP LIST file (#2006.5839).
 N ERROR,GROUPIEN,I,MAG20065839,TIULIST,X
 S ERROR=$$CONSULT1(GMRCIEN,.TIULIST)
 I ERROR<0 Q ERROR
 ; a TIU note may have multiple image groups - get the list
 F I=1:1:TIULIST(0) D
 . D T892591(TIULIST(I),.MAGIENLIST)
 . Q
 S MAG20065839=""
 F  S MAG20065839=$O(^MAG(2006.5839,"C",123,GMRCIEN,MAG20065839)) Q:MAG20065839=""  D
 . S X=$G(^MAG(2006.5839,MAG20065839,0))
 . S GROUPIEN=$P(X,"^",3)
 . S MAGIENLIST(GROUPIEN)=""
 . Q
 Q 0
 ;
CONSULT1(GMRCIEN,TIULIST) ; return a list of TIU IENs
 ; a consult may have multiple TIU notes - get the list
 N A,I,SS2,TIUIEN
 K TIULIST ; initialize list of TIU IENs
 S TIULIST(0)=0
 D GETS^DIQ(123,GMRCIEN,"**","I","A")
 I '$D(A) S OUT(1)="-1,Error in CONSULT1 with file #123 GMRCIEN Lookup" Q
 S I=0,SS2="",I=0 F  S SS2=$O(A(123.03,SS2)) Q:SS2=""  D
 . S TIUIEN=A(123.03,SS2,.01,"I")
 . I $P(TIUIEN,";",2)="TIU(8925," D
 . . S I=I+1,TIULIST(0)=I
 . . S TIULIST(I)=$P(TIUIEN,";",1)
 . . Q
 . Q
 Q 0
 ;
T892591(TIUIEN,MAGIENLIST) ;
 N GROUPIEN,TIU892591
 S TIU892591=""
 F  S TIU892591=$O(^TIU(8925.91,"B",TIUIEN,TIU892591)) Q:'TIU892591  D
 . S GROUPIEN=$$GET1^DIQ(8925.91,TIU892591,.02,"I")
 . S MAGIENLIST(GROUPIEN)=""
 . Q
 Q
 ;
SETDATES(DATEBEG,DATESTOP,BEGDATE,ENDDATE,DIRECTION) ; get date range
 ; get the beginning and ending dates for the FOR loop
 ; these are in GMRC reverse date format
 ; they are also DIRECTION specific
 I DIRECTION=1 D  ; ascending direction
  . S DATEBEG=$$GMRCDATE(BEGDATE)
  . S DATESTOP=$$GMRCDATE(ENDDATE)
  . Q
 E  D  ; descending direction
 . S DATEBEG=$$GMRCDATE(ENDDATE)
 . S DATESTOP=$$GMRCDATE(BEGDATE)
 . Q 
 Q
 ;
GMRCDATE(GMRCDATE) ; convert a GMRC date to a FM date and vice versa
 Q 9999999-GMRCDATE ; unlike radiology which uses 9999999.9999
 ;
HEADER(CONTINUE) ;
 I CONTINUE D CONTINUE^MAGDSTQ(0)
 W @IOF," Patient",?12,"   Accession   ",?30,"  Date",?40,"Images",?51,"Group #",?60,"VistA",?68,"PACS",?75,"Need"
 W !,"---------",?12,"----------------",?30,"--------",?40,"------",?51,"-------",?60,"-----",?68,"----",?75,"----"
 Q
