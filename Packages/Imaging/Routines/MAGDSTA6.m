MAGDSTA6 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Jul 06, 2021@08:04:39
 ;;3.0;IMAGING;**231,306**;MAR 19, 2002;Build 1;Feb 27, 2015
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
 ; Controlled IA #4110 to read REQUEST/CONSULTATION file (#123)
 ;
 Q
 ;
CONLKUP(DFN,COUNT,FIRSTDAY,LASTDAY,FIRSTIEN,LASTIEN) ;
 N GMRCDATE,GMRCIEN,OK,REALDATE
 S (COUNT,FIRSTDAY,FIRSTIEN,LASTDAY,LASTIEN)=0
 S GMRCDATE=$O(^GMR(123,"AD",DFN,""),1)
 I GMRCDATE="" D  Q
 . W !!,"*** Patient does not have any consults or procedures on file. ***"
 . D CONTINUE^MAGDSTQ(0)
 . Q
 ;
 ; find completed consults for the designated services
 S GMRCDATE=""
 F  S GMRCDATE=$O(^GMR(123,"AD",DFN,GMRCDATE),-1) Q:GMRCDATE=""  D
 . S GMRCIEN=""
 . F  S GMRCIEN=$O(^GMR(123,"AD",DFN,GMRCDATE,GMRCIEN)) Q:GMRCIEN=""  D
 . . S OK=$$CHECK(GMRCIEN)
 . . I OK=1 D
 . . . S COUNT=COUNT+1
 . . . S REALDATE=$$GMRCDATE^MAGDSTA7(GMRCDATE)
 . . . I FIRSTDAY=0 D  ; first in chronological order
 . . . . S FIRSTDAY=REALDATE
 . . . . S FIRSTIEN=GMRCIEN
 . . . . Q
 . . . S LASTDAY=REALDATE ; last in chronological order
 . . . S LASTIEN=GMRCIEN
 . . Q
 . Q
 ;
 S FIRSTDAY=FIRSTDAY\1,LASTDAY=LASTDAY\1 ; want dates only, not times
 ;
 I COUNT=0 D  Q
 . W !!,"*** Patient does not have any imaging consults or procedures on file. ***"
 . D CONTINUE^MAGDSTQ(0)
 . Q
 E  I COUNT>1 D
 . W !!,"Patient has ",COUNT," imaging studies on file, from "
 . W $$FMTE^XLFDT(FIRSTDAY,1)," to ",$$FMTE^XLFDT(LASTDAY,1)
 . Q
 E  D
 . W !!,"Patient has just one consult study in file for "
 . W $$FMTE^XLFDT(FIRSTDAY,1)
 . Q
 Q
 ;
CHECK(GMRCIEN) ; check if this consult or procedure should have images
 ; 1) check for designated service
 ; 2) check complete status
 ; 3) check if it is defined for DICOM MWL
 ; 
 N CPRSSTATUS,MWL,TOSERVICE
 ;
 ; check if this is a selected service
 S TOSERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 I TOSERVICE="" Q -1 ; no TOSERVICE
 ; check if it is for a designated service
 I '$D(^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES",TOSERVICE)) Q -2 ; nope
 ;
 ; check if this is consult has been completed
 S CPRSSTATUS=$$GET1^DIQ(123,GMRCIEN,8,"E")
 I CPRSSTATUS'="COMPLETE",CPRSSTATUS'="PARTIAL RESULTS" Q -3 ; not completed
 ;
 ; check if this consult or procedure is supported for DICOM
 S MWL=$$MWLFIND^MAGDHOW1(TOSERVICE,GMRCIEN)
 I 'MWL Q -4 ; no file 2006.5831 entry for MWL
 ;
 ; otherwise, it's OK
 Q 1
 ;
STUDY1 ; get the consult ien - called by MAGDSTA1
 N STUDY1,X
 S STUDY1=$G(^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN"))
 I STUDY1 D
 . W !!,"Scanning will start with consult #",STUDY1,"."
 . I $$YESNO^MAGDSTQ("Do you wish to change it?","n",.X)<0 S QUIT=1 Q
 . I X="YES" S STUDY1=+STUDY1 D STUDY1A
 . Q
 E  D STUDY1A
 Q
 ;
STUDY1A ; get new value
 N BEGPTR ; first possible ^GMR(123) pointer value
 N NEWPTR ; selected next possible ^GMR(123) pointer value
 N ENDPTR ; last possible ^GMR(123) pointer value
 N DATE ; consult date
 N DEFAULT,OK,X,Z
 ;
 S BEGPTR=$O(^GMR(123,0)) ; first ien
 D STUDY1B(BEGPTR,.DATE)
 W !!,"The first consult is #",BEGPTR," entered on ",DATE,"."
 ;
 S ENDPTR=$O(^GMR(123," "),-1) ; last ien
 D STUDY1B(ENDPTR,.DATE)
 W !,"The last consult is #",ENDPTR," entered on ",DATE,"."
 ;
 S OK=0 F  D  Q:OK
 . S DEFAULT=$S(STUDY1:STUDY1,SORTORDER="ASCENDING":BEGPTR,SORTORDER="DESCENDING":ENDPTR)
 . W !!,"Enter the new value of the consult #: ",DEFAULT,"// "
 . R X:DTIME E  S OK=-1 Q
 . I X["^" S OK=-1 Q
 . I X="" S X=DEFAULT W X
 . I (X>ENDPTR)!(X<BEGPTR) D  Q
 . . W !!,"Please enter a number between ",BEGPTR," and ",ENDPTR,"."
 . . Q
 . S NEWPTR=X
 . D STUDY1B(NEWPTR,.DATE)
 . W !!,"Consult #",NEWPTR," entered on ",DATE,"."
 . I $$YESNO^MAGDSTQ("Is this where to begin scanning?","n",.X)<0 S OK=-1 Q
 . S:X="YES" OK=$S(NEWPTR=DEFAULT:2,1:1)
 . Q
 I OK<0 S QUIT=1 Q
 I NEWPTR'=STUDY1 D
 . S ^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN")=NEWPTR_" ("_DATE_")"
 . W:OK=1 " -- changed"
 . Q
 Q
 ;
STUDY1B(GMRCIEN,DATE) ; get date from ^GMR(123,GMRCIEN,0)
 S DATE=$$GET1^DIQ(123,GMRCIEN,.01,"E")
 Q
