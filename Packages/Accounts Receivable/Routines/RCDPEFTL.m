RCDPEFTL ;EDE/FA - LIST LOCKED EFT REPORT ;18 July 2018 11:19:25
 ;;4.5;Accounts Receivable;**332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Entry from RCDPE EFT OVERRIDE REPORT option
 N RCINPT,RCVAL
 K ^TMP("RCDPE_EFTL",$J)
 ;
 ; Warn if override set today or not
 S RCVAL("OverRide")=+$$GET1^DIQ(344.61,1,20,"I") ; (#20) MEDICAL EFT OVERRIDE [1D]
 W !,"Medical Override "_$S($P(RCVAL("OverRide"),".")=DT:"",1:"not ")_"active for today's date"
 ;
 S RCVAL("EFTPostLimit")=+$$GET1^DIQ(344.61,1,.06) ; (#.06) MEDICAL EFT POST PREVENT DAYS [6N]
 S RCVAL("CutoffDate")=$$FMADD^XLFDT(DT,-RCVAL("EFTPostLimit")) ; Today's date less post prevent days
 W !,"Aged EFT days before Medical posting prevented = "_RCVAL("EFTPostLimit"),!
 ;
 ; Check if any medical unposted EFTs exist with aged days greater than site parameter value
 S RCVAL("1stEFTDate")=$$GETFRST(RCVAL("EFTPostLimit"),RCVAL("CutoffDate"))
 ;
 ; If none stop
 I 'RCVAL("1stEFTDate") D  Q
 . N DIR
 . S DIR(0)="EA"
 . S DIR("A",1)="The system does not have any aged, unposted EFTs."
 . S DIR("A",2)=" "
 . S DIR("A")="Press ENTER to continue: "
 . D ^DIR
 ;
 ; report parameters
 S RCINPT("DateRange")=RCVAL("1stEFTDate")_":"_RCVAL("CutoffDate")  ; Start Date:End date
 S RCINPT("2Excel?")=$$ASKXCEL  ; Ask to output to Excel
 Q:RCINPT("2Excel?")=-1  ; '^' or timeout
 D:RCINPT("2Excel?")=1 INFO^RCDPEM6  ; Display capture information for Excel
 S RCINPT("DeviceSelected?")=$$DEVICE(RCINPT("2Excel?"))  ; Ask output device
 Q:'RCINPT("DeviceSelected?")  ; '^' or timeout (POP from %ZIS call)
 ; done with user questions
 S RCINPT("AgedDays")=RCVAL("EFTPostLimit")  ; allowed aged days for report
 S RCINPT("1stEFT")=RCVAL("1stEFTDate")  ; first EFT date for report
 ; Medical EFT Override parameters
 S RCINPT(344.61,20)=$$GET1^DIQ(344.61,1_",",20,"E")  ; (#20) MEDICAL EFT OVERRIDE [1D]
 S RCINPT(344.61,22)=$$GET1^DIQ(344.61,1_",",22,"E")  ; (#22) USER - MEDICAL OVERRIDE [3P:200]
 S RCINPT(344.61,24)=$$GET1^DIQ(344.61,1_",",24,"E")  ; (#24) COMMENT - MEDICAL OVERRIDE [5F]
 ; Queue output
 I $D(IO("Q")) D  D HOME^%ZIS Q
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="REPORT^RCDPEFTL(.RCINPT)",ZTDESC="RCDPE EFT OVERRIDE REPORT"
 . S ZTSAVE("RC*")="",ZTSAVE("IO*")="" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 . K IO("Q")
 ;
 D REPORT(.RCINPT)
 Q
 ;
REPORT(RCINPT) ; entry point from TaskMan and above
 D RPTCOMP(.RCINPT)  ; Compile report
 D RPTOUT(.RCINPT)  ; Output report
 I '$D(ZTQUEUED) D ^%ZISC  ;if not queued Close device
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP("RCDPE_EFTL",$J)
 K ZTQUEUED
 Q
 ;
RPTCOMP(RCINPT) ; Full EFT scan to compile report
 ; Input:
 ;  RCINPT("DateRange")= Report start date:Report end date
 ; Output:
 ;  ^TMP("RCDPE_EFTL",$J) - compilation of report data
 ;
 N END,RCEFT,RECVDT
 ; RCEFT - array for EFT data, counter, IEN
 ;
 ; Initialize report
 K ^TMP("RCDPE_EFTL",$J)
 S RCEFT("Count")=0,^TMP("RCDPE_EFTL",$J,"EFT count")=0,^TMP("RCDPE_EFTL",$J,"Total Amt")=0
 S RECVDT=$P(RCINPT("DateRange"),":")-.1  ; start date minus fraction
 S END=$P(RCINPT("DateRange"),":",2) ; report ending date range
 ; File #344.31 Traditional Cross-Reference: "ADR", REGULAR   Field:  DATE RECEIVED  (344.31,.13)
 ; Scan EFT received date index for days
 F  S RECVDT=$O(^RCY(344.31,"ADR",RECVDT)) Q:'RECVDT  Q:RECVDT>END  D
 . S RCEFT("IEN")=""
 . ; Scan individual EFTs
 . F  S RCEFT("IEN")=$O(^RCY(344.31,"ADR",RECVDT,RCEFT("IEN"))) Q:'RCEFT("IEN")  D
 ..  ; Check this is a valid EFT type
 ..  Q:'$$VALID(RCEFT("IEN"))
 ..  ; calculate aged number of days of the EFT
 ..  S RCEFT("DaysAged")=$$FMDIFF^XLFDT(DT,RECVDT) ; get aged number of days of the EFT
 ..  Q:RCEFT("DaysAged")'>RCVAL("EFTPostLimit")  ; Ignore Unposted EFT younger than aged days maximum
 ..  S RCEFT("Trace#")=$$GET1^DIQ(344.31,RCEFT("IEN"),.04)  ;(#.04) TRACE # [4F] 
 ..  S RCEFT("MatchStatus")=$$GET1^DIQ(344.31,RCEFT("IEN"),.08,"E")  ;(#.08) MATCH STATUS [8S]
 ..  S RCEFT("Trans#")=$$GET1^DIQ(344.31,RCEFT("IEN"),.01,"E") ;(#.01) EFT TRANSACTION [1P:344.3]
 ..  S RCEFT("ERARecord")=$$GET1^DIQ(344.31,RCEFT("IEN"),.1)  ;(#.1) ERA RECORD [10P:344.4]
 ..  S:RCEFT("ERARecord")="" RCEFT("ERARecord")="None"
 ..  S RCEFT("Amount")=$$GET1^DIQ(344.31,RCEFT("IEN"),.07)  ;(#.07) AMOUNT OF PAYMENT [7N]
 ..  ; Save EFT detail and update totals for report
 ..  S RCEFT("Count")=RCEFT("Count")+1
 ..  S ^TMP("RCDPE_EFTL",$J,RCEFT("Count"))=RCEFT("Trans#")_U_RCEFT("MatchStatus")_U_RCEFT("DaysAged")_U_RCEFT("ERARecord")_U_RECVDT_U_RCEFT("Amount")_U_RCEFT("Trace#")
 ..  S ^TMP("RCDPE_EFTL",$J,"EFT count")=RCEFT("Count")
 ..  S ^TMP("RCDPE_EFTL",$J,"Total Amt")=^TMP("RCDPE_EFTL",$J,"Total Amt")+RCEFT("Amount")
 ;
 Q
 ;
RPTOUT(RCINPT) ; Output the report to paper/screen or excel
 ; Input: RCINPT 
 ; Output: OUTPUT
 N A,B,DATA,RCRPRT
 ; RCRPRT - array used for report
 S RCRPRT("LineCount")=0,RCRPRT("Page")=1 ; Initialize Line/Page counters
 S RCRPRT("RunDate")=$$FMTE^XLFDT($$NOW^XLFDT)
 S RCRPRT("ExcelFrmt?")=RCINPT("2Excel?")
 S RCRPRT("Exit")=0,RCRPRT("ListCntr")=0
 ; create lines 2-4 in the header
 S RCRPRT("HeaderLine",2)="Sorted by Aged Days, Comment: "_$S(RCINPT(344.61,24)]"":RCINPT(344.61,24),1:"None")
 ; place user's name on the right edge of line 3
 S A="Medical Override Date: "_$S(RCINPT(344.61,20)]"":RCINPT(344.61,20),1:"None"),B=" User: "_$S(RCINPT(344.61,22)]"":RCINPT(344.61,22),1:"None"),$E(A,IOM-$L(B)+1,IOM)=B
 S RCRPRT("HeaderLine",3)=A
 S RCRPRT("HeaderLine",4)="Number of Days (Age) of Unposted EFTs to prevent posting: "_$$GET1^DIQ(344.61,1,.06)
 S RCRPRT("HeaderBorder")=$TR($J(" ",IOM-1)," ","=")  ; row of equal signs for border
 I RCRPRT("ExcelFrmt?") W !,"EFT^Match Status^Aged Days^ERA #^Date Received^Amount^Trace #"
 I 'RCRPRT("ExcelFrmt?") D RPTHDR(.RCRPRT),RPTTOT S RCRPRT("LineCount")=11
 ;
 F  S RCRPRT("ListCntr")=$O(^TMP("RCDPE_EFTL",$J,RCRPRT("ListCntr"))) Q:'RCRPRT("ListCntr")  D  Q:RCRPRT("Exit")
 . S DATA=$G(^TMP("RCDPE_EFTL",$J,RCRPRT("ListCntr")))
 . ; Output lines for one EFT
 . S RCRPRT("Exit")=$$RPRT1EFT(DATA,.RCRPRT)
 ;
 I 'RCRPRT("ExcelFrmt?") W:'RCRPRT("Exit") !,RCRPRT("HeaderBorder"),!,$$ENDORPRT^RCDPEARL
 I RCRPRT("ExcelFrmt?"),$E(IOST,1,2)="C-" D  ; if Excel format and user terminal, pause
 . N DIR S DIR(0)="EA",DIR("A")="Press ENTER to continue: ",DIR("A",1)=" " D ^DIR
 Q
 ;
RPRT1EFT(DATA,RCRPRT) ; boolean function, Output one EFT record
 ; Input: 
 ; DATA - EFT to write, See REPORT for a complete description
 ; RCRPRT("ExcelFrmt?"): zero - formatted Output to Screen /printer
 ;        1 - Output in Excel format
 ; RCRPRT("LineCount") - Line Count
 ; RCRPRT("Page") - Page Count
 ; Output: 
 ; RCRPRT("LineCount") - Updated Line Count
 ; RCRPRT("Page") - Updated Page Count
 ; Returns:
 ;  1 if user indicates to quit, 0 otherwise
 N STOP
 I RCRPRT("ExcelFrmt?") D  Q 0  ; Excel output, format date received, write record and quit
 . N X,Y S Y=DATA,X=$$FMTE^XLFDT($P(DATA,U,5),"5DZ"),$P(Y,U,5)=X
 . S RCRPRT("LineCount")=RCRPRT("LineCount")+1 W !,Y
 ; screen /printer output
 S STOP=0  ; stop output flag
 I $E(IOST,1,2)="C-",'(RCRPRT("LineCount")+3<IOSL) D  ; bottom of screen logic, must be "C-" device subtype
 . S STOP=$$PGEND Q:STOP
 . S RCRPRT("Page")=RCRPRT("Page")+1 D RPTHDR(.RCRPRT) S RCRPRT("LineCount")=8
 ;
 Q:STOP 1  ; user indicated to stop
 S RCRPRT("LineCount")=RCRPRT("LineCount")+3
 W !,$$PAD($P(DATA,U),9)_$P(DATA,U,7)  ; EFT number & Trace #
 ; ; ERA number, Match Status, EFT Received Date, Aged Days, Amount
 W !,$$PAD(" "_$P(DATA,U,4),10)_$$PAD($P(DATA,U,2),20)_$$PAD($$FMTE^XLFDT($P(DATA,U,5)),15)_$$PAD($P(DATA,U,3),10)_"$"_$FN($P(DATA,U,6),",",2),!
 ;
 Q 0  ; return false, continue writing report
 ;
RPTHDR(RCRPRT) ; report header, line 1 is dynamic
 N A,B
 S A="Pending EFT Override Report - Page "_RCRPRT("Page")_" ",B=" Run Date: "_RCRPRT("RunDate"),$E(A,IOM-$L(B)+1,IOM)=B
 W !,A,!,RCRPRT("HeaderLine",2),!,RCRPRT("HeaderLine",3),!,RCRPRT("HeaderLine",4)
 W !!,"EFT    Trace#",!," ERA     Match Status        EFT Received    Aged       Amount"
 W !,RCRPRT("HeaderBorder")
 Q
 ;
RPTTOT ; Display report totals
 W !,"Total Number of Unposted EFTs: "_$G(^TMP("RCDPE_EFTL",$J,"EFT count"))
 W !,"Total Amount of Unposted EFTs: $"_$FN($G(^TMP("RCDPE_EFTL",$J,"Total Amt")),",",2)
 W !,RCRPRT("HeaderBorder")
 Q
 ;
PGEND() ; boolean function, end-of-page, Ask to continue
 ; Input: IOST - Device Type
 ; Returns: 1 - User wants to quit, 0 otherwise
 Q:'($E(IOST,1,2)="C-") 0  ; Not a terminal
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="EA",DIR("A")="Press ENTER to continue, '^' to exit: " D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) Q 1  ; user entered '^' or timeout
 Q 0
 ;
DEVICE(EXCEL) ; boolean function to Select output device
 ; Input: EXCEL - 1 - Ouput in Excel format, 0 otherwise
 ; Output: IO,IOST arrays in symbol table
 ; Returns:
 ;   0 - No device selected, 1 otherwise
 N %ZIS,POP S %ZIS="QM" D ^%ZIS
 Q 'POP ; return "not POP"
 ;
ASKXCEL() ; Ask user to export to Excel
 ; Input: None
 ; Returns: -1 - User up-arrowed or timed out
 ;        zero - Output to selected device
 ;           1 - Output to Excel
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="List the report in Microsoft Excel format"
 S DIR("B")="NO"
 S DIR("?")="Enter 'YES' to output in Excel format. Otherwise enter 'NO'"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q Y
 ;
GETFRST(LIMIT,END) ; scan for first EFT
 ; Input:
 ; LIMIT - Maximum days before aged UNPOSTED EFT lock the ERA worklist
 ; END - Today's date less LIMIT
 ; Output
 ; RET - Date of first 'lock' EFT or zero if none found
 ;
 N AGED,EFTDA,RECVDT,RET
 ;
 S RET=0,RECVDT=$$CUTOFF^RCDPEWLP ; PRCA*4.5*298 install date less 60 days
 ; Scan EFT received date index for days
 F  S RECVDT=$O(^RCY(344.31,"ADR",RECVDT)) Q:'RECVDT  Q:RECVDT>END  Q:RET  D
 . S EFTDA=""
 . ; Scan individual EFTs
 . F  S EFTDA=$O(^RCY(344.31,"ADR",RECVDT,EFTDA)) Q:'EFTDA  D
 ..  ; Check this is a valid EFT type
 ..  Q:'$$VALID(EFTDA)
 ..  ; Calculate aged number of days of the EFT
 ..  S AGED=$$FMDIFF^XLFDT(DT,RECVDT)
 ..  ; Unposted EFT found older than aged days allowed
 ..  I AGED>LIMIT S RET=RECVDT
 ;
 Q RET
 ;
VALID(EFTDA) ; Check if EFT is a valid candidate
 ; Ignore zero payment amts
 Q:+$$GET1^DIQ(344.31,EFTDA,.07)=0 0
 ; Ignore duplicate EFTs which have been removed
 Q:$$GET1^DIQ(344.31,EFTDA,.18)]"" 0
 ; ERA RECORD (344.31, .1) pointer to ERA record
 S RCEFT("ERARecord")=$$GET1^DIQ(344.31,EFTDA,.1)
 ; DETAIL POST STATUS (344.4, .14); ignore posted ERA-EFTs
 I RCEFT("ERARecord"),$$GET1^DIQ(344.4,RCEFT("ERARecord"),.14,"I")=1 Q 0
 ; Ignore EFT matched to Pharmacy ERA
 I RCEFT("ERARecord"),$$PHARM^RCDPEWLP(RCEFT("ERARecord")) Q 0
 ; Exclude EFT matched to Paper EOB if receipt is processed
 I 'RCEFT("ERARecord"),($$GET1^DIQ(344.31,EFTDA,.08,"I")=2) Q:$$PROC^RCDPEWLP(EFTDA) 0
 ; Otherwise valid
 Q 1
 ;
PAD(A,N) ; pad A with spaces to length N
 Q A_$J(" ",N-$L(A))  ; always add at least one trailing space
 ;
