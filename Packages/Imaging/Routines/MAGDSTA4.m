MAGDSTA4 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Mar 03, 2022@08:41:56
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
RADLKUP(DFN,COUNT,FIRSTDAY,LASTDAY,FIRSTIEN,LASTIEN) ;
 N RARPT0,RARPT1,STATUS
 S (COUNT,FIRSTDAY,FIRSTIEN,LASTDAY,LASTIEN)=0
 S RARPT1=$O(^RARPT("C",DFN,""))
 I RARPT1="" D  Q
 . W !!,"*** Patient does not have any radiology reports on file. ***"
 . D CONTINUE^MAGDSTQ(0)
 . Q
 ;
 ; find completed reports
 S FIRSTDAY=999999999999,LASTDAY=0
 S RARPT1=""
 F  S RARPT1=$O(^RARPT("C",DFN,RARPT1)) Q:RARPT1=""  D
 . S RARPT0=$G(^RARPT(RARPT1,0))
 . S STATUS=$P(RARPT0,"^",5)
 . I STATUS'="V",STATUS'="EF" Q  ; only look at verified and electrically filed
 . S DATETIME=$P(RARPT0,"^",3)
 . I DATETIME<FIRSTDAY S FIRSTDAY=DATETIME,FIRSTIEN=RARPT1 ; get earliest date
 . I DATETIME>LASTDAY S LASTDAY=DATETIME,LASTIEN=RARPT1 ; get latest date
 . S COUNT=COUNT+1
 . Q
 S FIRSTDAY=FIRSTDAY\1,LASTDAY=LASTDAY\1 ; want dates only, not times
 I COUNT>1 D
 . W !!,"Patient has ",COUNT," radiology reports on file, from "
 . W $$FMTE^XLFDT(FIRSTDAY,1)," to ",$$FMTE^XLFDT(LASTDAY,1)
 . Q
 E  I COUNT=1 D
 . W !!,"Patient has just one radiology report in file for "
 . W $$FMTE^XLFDT(FIRSTDAY,1)
 . Q
 E  D
 . W !!,"*** Patient does not have any radiology reports on file. ***"
 . D CONTINUE^MAGDSTQ(0)
 . Q
 Q
 ;
RARPT1 ; get the radiology report ien - called by MAGDSTA1
 N RARPT1,X
 S RARPT1=$G(^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN"))
 I RARPT1 D
 . W !!,"Scanning will start with radiology report # """,RARPT1,"""."
 . I $$YESNO^MAGDSTQ("Do you wish to change it?","n",.X)<0 S QUIT=1 Q
 . I X="YES" S RARPT1=+RARPT1 D RARPT1A
 . Q
 E  D RARPT1A
 Q
 ;
RARPT1A ; get new value
 N BEGPTR ; first possible ^RARPT pointer value
 N NEWPTR ; selected next possible ^RARPT pointer value
 N ENDPTR ; last possible ^RARPT pointer value
 N ACNUMB ; accession number (long case number)
 N DATE ; radiology report date
 N DEFAULT,OK,X,Z
 ;
 S BEGPTR=$O(^RARPT(0))
 D RARPT1B(BEGPTR,.ACNUMB,.DATE)
 W !!,"The first radiology report is #",BEGPTR," (",ACNUMB,") entered on ",DATE,"."
 ;
 S ENDPTR=$O(^RARPT(" "),-1)
 D RARPT1B(ENDPTR,.ACNUMB,.DATE)
 W !,"The last radiology report is #",ENDPTR," (",ACNUMB,") entered on ",DATE,"."
 ;
 S OK=0 F  D  Q:OK
 . S DEFAULT=$S(RARPT1:RARPT1,SORTORDER="ASCENDING":BEGPTR,SORTORDER="DESCENDING":ENDPTR)
 . W !!,"Enter the new value of the radiology report #: ",DEFAULT,"// "
 . R X:DTIME E  S OK=-1 Q
 . I X["^" S OK=-1 Q
 . I X="" S X=DEFAULT W X
 . I (X>ENDPTR)!(X<BEGPTR) D  Q
 . . W !!,"Please enter a number between ",BEGPTR," and ",ENDPTR,"."
 . . Q
 . S NEWPTR=X
 . D RARPT1B(NEWPTR,.ACNUMB,.DATE)
 . W !!,"Radiology report #",NEWPTR," (",ACNUMB,") entered on ",DATE,"."
 . I $$YESNO^MAGDSTQ("Is this where to begin scanning?","n",.X)<0 S OK=-1 Q
 . S:X="YES" OK=$S(NEWPTR=DEFAULT:2,1:1)
 . Q
 I OK<0 S QUIT=1 Q
 I NEWPTR'=RARPT1 D
 . S ^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN")=NEWPTR_" ("_DATE_")"
 . W:OK=1 " -- changed"
 . Q
 Q
 ;
RARPT1B(RARPTIEN,ACNUMB,DATE) ; get accession number and date from ^RARPT(RARPTIEN,0)
 N RARPT0,Y,Z
 S RARPT0=$G(^RARPT(RARPTIEN,0))
 S ACNUMB=$P(RARPT0,"^",1)
 S DATE=$P($$FMTE^XLFDT($P(RARPT0,"^",3),1),"@",1)
 Q
