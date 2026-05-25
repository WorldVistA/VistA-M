MAGDSTAX ;WOIFO/PMK - Display of CSV report for Excel ; Nov 08, 2022@13:48:26
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
 Q
 ;
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10103 reference $$HTE^XLFDT function call
 ; Supported IA #10103 reference $$FMTH^XLFDT function call
 ; Supported IA #10075 reference to read the OPTION file (#19)
 ; Supported IA #2051 reference $$FIND1^DIC function call
EXCELCSV(MYSERVICE,CSVLIST) ; output a CMP/RET comma-separated values report
 N DATE,I,OUTPUT,X
 S OUTPUT=0
 I $$LIST^MAGDSTA0(MYSERVICE,.CSVLIST)=0 D
 . W !!,"Sorry, there are no run results in Excel *.CSV file format on file"
 . Q
 E  D
 . W !!,"Output run results in Excel *.CSV file format"
 . I CSVLIST(0)>1 W " -- ",CSVLIST(0)," sets of results on file"
 . W !
 . I CSVLIST(0)=1 D
 . . S DATE=$$DATE(1)
 . . W !!,"There is just one CMP/RET CSV report for a run started ",DATE,!
 . . D INFO(1)
 . . I $$YESNO^MAGDSTQ("Output this run?","y",.X)<0 Q
 . . I X="YES" D OUTPUT(1)
 . . Q
 . E  D
 . .  S I=$$SELECT() Q:I<=0
 . .  I I D OUTPUT(I)
 . . Q
 . Q
 I 'OUTPUT D CONTINUE^MAGDSTQ
 Q
 ;
SELECT() ; pick the study to output
 N CHOICE,I,J,N,X
 S N=CSVLIST(0)
 S CHOICE=0
 F  D  Q:CHOICE
 . F I=1:1:N D
 . . W !,$J(I,3)," -- ",$$DATE(I)
 . . D COPY(I) W " -- ",^TMP("MAG",$J,"BATCH Q/R","OPTION")
 . . W " -- ",^XTMP(CSVLIST(I),"REPORT",0)," records"
 . . Q
 . W !!,"Enter report number 1-",N,": "
 . R J:DTIME E  S J="^"
 . I J["^" S CHOICE=-1 Q
 . I J'?1N.N W "  ??? - Please enter an integer",! Q
 . I J=0 W "  ??? Please enter an integer greater than zero",! Q
 . I J>N W "  ??? Please enter an integer no greater than ",N,! Q
 . D INFO(J)
 . I $$YESNO^MAGDSTQ("Output this run?","",.X)<0 Q
 . I X="YES" S CHOICE=J
 . Q
 Q CHOICE
 ;
DATE(I) ; return the date of the report
 N FMDT
 S FMDT=$P(CSVLIST(I)," ",4)
 Q $$FMTE^XLFDT(FMDT)
 ;
INFO(I) ;
 D COPY(I)
 D DISPLAY^MAGDSTA9
 Q
 ;
COPY(I) ;
 K ^TMP("MAG",$J)
 M ^TMP("MAG",$J)=^XTMP(CSVLIST(I),"INFO")
 Q
 ;
OUTPUT(I) ;
 N J,OUTPUTCSV,X
 W !! F J=1:1:IOM W "="
 W !
 W !,"For best results, set the Reflection Workplace screen width to 512:"
 W !,"     Menu - File/Settings under Terminal Configuration 'Set Up Display Settings'"
 W !,"     Scroll down to 'Number of characters per row', enter 512, click 'OK'",!
 W !,"Specify the Logging output *.CSV file for Excel:"
 W !,"     Menu - Tools/Logging, unselect Printer, select Disk, and enter a path"
 W !,"     for the *.CSV file (ex. ...\Auto QR\Retrieve_2022-11-24.CSV), click 'OK'",!
 W !,"     *** Be sure to select a different *.CVS file name for each run. ***",!
 W !,"     Clicking on the *.CSV file will automatically launch Excel.",!
 W !,"Turn on Logging:"
 W !,"     Menu - Tools 'Start Logging'",!
 W !,"Turn off Logging:"
 W !,"     Menu - Tools 'Stop Logging'"
 W !! F J=1:1:IOM W "="
 W ! I $$YESNO^MAGDSTQ("To output this run, Start Logging and push <Enter>, or NO to cancel ","y",.X)<0 Q
 I X="NO" W " -- output cancelled" Q
 S OUTPUTCSV=CSVLIST(I)
 U 0:512 W !
 F J=1:1:^XTMP(OUTPUTCSV,"REPORT",0) W ^(J),!
 U 0:IOM
 R !!,"Stop Logging now and push <Enter>",X:DTIME
 S OUTPUT=1
 Q
