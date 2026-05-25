MAGDSTA9 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Aug 12, 2025@09:44:38
 ;;3.0;IMAGING;**231,306,333**;Mar 19, 2002;Build 2
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
 ; Supported IA #10061 reference DEM^VADPT subroutine call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ;
 Q
 ;
VERIFY ; get the parameters for this run
 N PROMPT,X
 W !!!?10,"F i n a l  P a r a m e t e r   C h e c k l i s t"
 W !?10,"------------------------------------------------"
 D DISPLAY
 I ^TMP("MAG",$J,"BATCH Q/R","OPTION")="RETRIEVE MISSING IMAGES" D
 . S PROMPT="Ready to retrieve missing DICOM images?"
 . Q
 E  S PROMPT="Ready to compare image counts?"
 I $$YESNO^MAGDSTQ(PROMPT,"y",.X)<0 S QUIT=1 Q
 I X="YES" S QUIT=0
 E  W " -- ",^TMP("MAG",$J,"BATCH Q/R","OPTION")," not started" S QUIT=-1
 Q
 ;
DISPLAY ; get and display the parameters
 N BATCHSIZE,BEGDATE,CONSULTSERVICES,DFN,DILOCKTM,DISYS,DOB,ENDDATE,HOURS
 N IMAGINGSERVICE,NAME,OPTION,QRSCP,SCANMODE,SERVICE,SORTORDER,SSN
 ;
 N ACNUMB,STATUS,STUDYDATE,STUDYIEN ; not set
 ;
 S IMAGINGSERVICE=^TMP("MAG",$J,"BATCH Q/R","IMAGING SERVICE")
 M CONSULTSERVICES=^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES") ; P333 PMK 08/12/2025
 S QRSCP=^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP")
 S OPTION=^TMP("MAG",$J,"BATCH Q/R","OPTION")
 S SORTORDER=$G(^TMP("MAG",$J,"BATCH Q/R","SORT ORDER")) ; P333 PMK 08/12/2025
 S BEGDATE=$G(^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE"))
 S ENDDATE=$G(^TMP("MAG",$J,"BATCH Q/R","END DATE"))
 S BATCHSIZE=$G(^TMP("MAG",$J,"BATCH Q/R","BATCH SIZE"))
 S HOURS=^TMP("MAG",$J,"BATCH Q/R","HOURS OF OPERATION")
 S SCANMODE=^TMP("MAG",$J,"Q/R PARAM","SCAN MODE")
 D DISPLAY1
 Q
 ;
DISPLAY1 ; just display the parameters - called by ^MAGDSTA1
 N I,J,LIST
 N VA,VADM,VAERR,VAICN,VAIN,VAINFO,VAPA,X
 W !,$$J("Imaging Service")
 I IMAGINGSERVICE="CONSULTS" D  ; display consult/procedure services
 . S (I,J)=0
 . F  S I=$O(CONSULTSERVICES(I)) Q:I=""  D
 . . S J=J+1,LIST(J)=CONSULTSERVICES(I)
 . . Q
 . I J D
 . . F I=1:1:J D
 . . . S X=LIST(I)
 . . . I ($L(X)+2)+$X>IOM W ",",!,?27 ; need new line
 . . . E  W:I>1 ", "
 . . . W X
 . . . Q
 . . Q
 . E  W "  -- *** Error: No Services Selected! ***"
 . Q
 E  W IMAGINGSERVICE
 W !,$$J("Query Retrieve Mode"),OPTION
 W !,$$J("Scan Mode"),SCANMODE
 W !,$$J("Query/Retrieve Provider"),QRSCP
 W !,$$J("Study scanning order"),SORTORDER
 I SCANMODE="NUMBER" D  ; internal entry number order
 . S IEN=$G(^TMP("MAG",$J,"BATCH Q/R","REPORT/STUDY IEN"))
 . I IMAGINGSERVICE="RADIOLOGY" D
 . . W !,$$J("Starting with report"),IEN
 . . Q
 . E  D  ; consults and procedures
 . . W !,$$J("Starting with consult"),IEN
 . . Q
 . W !,$$J("Number of studies to retrieve"),BATCHSIZE
 . Q
 E  I SCANMODE="PATIENT" D  ; patient scan
 . N I ; killed in DEM^VADPT
 . S DFN=$G(^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN"))
 . D DEM^VADPT
 . S NAME=VADM(1),DOB=$P(VADM(3),"^",2),SSN=$P(VADM(2),"^",2)
 . W !,$$J("Patient Name"),NAME
 . W !,$$J("Social Security Number"),SSN
 . W !,$$J("Date of Birth"),DOB
 . I SORTORDER="ASCENDING" D
 . . W !,$$J("Earliest date for study"),$$FMTE^XLFDT(BEGDATE,1)
 . . W !,$$J("Latest date for study"),$$FMTE^XLFDT(ENDDATE,1)
 . . Q
 . E  D  ; DESCENDING
 . . W !,$$J("Latest date for study"),$$FMTE^XLFDT(ENDDATE,1)
 . . W !,$$J("Earliest date for study"),$$FMTE^XLFDT(BEGDATE,1)
 . . Q
 . Q
 E  D  ; date scan order
 . I SORTORDER="ASCENDING" D
 . . W !,$$J("Earliest date for study"),$$FMTE^XLFDT(BEGDATE,1)
 . . W !,$$J("Latest date for study"),$$FMTE^XLFDT(ENDDATE,1)
 . . Q
 . E  D  ; DESCENDING
 . . W !,$$J("Latest date for study"),$$FMTE^XLFDT(ENDDATE,1)
 . . W !,$$J("Earliest date for study"),$$FMTE^XLFDT(BEGDATE,1)
 . . Q
 . Q
 . Q
 W !,$$J("Active hours of operation"),"M12345678901N12345678901 (M=midnight, N=noon)"
 W !?27,HOURS
 I $D(STATUS) D
 . W !!,$$J("Status of Previous Run"),STATUS
 . Q
 I $D(STUDYDATE) D
 . W !,$$J("Last Study Date"),$$FMTE^XLFDT(STUDYDATE)
 . Q
 I $D(ACNUMB) D
 . W !,$$J("Accession Number"),ACNUMB
 . Q
 I $D(STUDYIEN) D
 . W !,$$J("Last Report Number"),STUDYIEN
 . Q
 I $D(OUTPUTREPORT) D  ; P333 PMK 11/03/2022
 . W !,$$J("Report Date"),$P(OUTPUTREPORT,"^",1)
 . W !,$$J("Report #"),$P(OUTPUTREPORT,"^",2)
 . Q
 Q
 ;
J(X) ; right justify field name and add colon & space
 Q $J(X,25)_": "
