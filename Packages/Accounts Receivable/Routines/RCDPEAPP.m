RCDPEAPP ;OIFO-BAYPINES/PJH - AUTO POST REPORT ;Dec 20, 2014@18:42
 ;;4.5;Accounts Receivable;**298,304,326,345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^DGCR(399) via Private IA 3820
 ;Read ^DG(40.8) via Controlled IA 417
 ;Read ^IBM(361.1) via Private IA 4051
 ;Use DIVISION^VAUTOMA via Controlled IA 664
 ; PRCA*4.5*326 - Extensive re-write of this routine to add selection/sort by Payer TIN
RPT ; entry point for Auto-Post Report [RCDPE AUTO-POST REPORT]
 N POP,RCDISP,RCDIV,RCDIVS,RCDTRNG,RCJOB,RCLAIM,RCPAGE,RCPAR,RCPARRAY,RCPAY,RCPROG,RCRANGE
 N RCSORT,RCTYPE,RCWHICH,STANAM,STANUM,X,Y
 S (RCDTRNG,RCPAGE)=0,RCPROG="RCDPEAPP",RCJOB=$J    ; Initialize page and start point
 S RCDIV=$$STADIV(.RCDIVS) Q:'RCDIV                 ; Select Filter/Sort by Division
 S RCTYPE=$$DETORSUM() Q:RCTYPE=-1                  ; Detail or Summary mode
 ;
 S RCLAIM=$$RTYPE^RCDPEU1() Q:RCLAIM=-1             ; PRCA*4.5*326 - Add Tricare filter to Med/Pharm/Both
 S RCWHICH=$$NMORTIN() Q:RCWHICH=-1                 ; PRCA*4.5*326 - Filter by Payer Name or TIN
 ;
 S RCPAR("SELC")=$$PAYRNG^RCDPEU1(0,1,RCWHICH)      ; PRCA*4.5*326 - Selected or Range of Payers
 Q:RCPAR("SELC")=-1                                 ; PRCA*4.5*326 '^' or timeout
 S RCPAY=RCPAR("SELC")
 ;
 I RCPAR("SELC")'="A" D  Q:XX=-1                    ; PRCA*4.5*326 - Since we don't want all payers 
 . S RCPAR("TYPE")=RCLAIM
 . S RCPAR("SRCH")=$S(RCWHICH=2:"T",1:"N")          ; prompt for payers we do want
 . S RCPAR("FILE")=344.4
 . S RCPAR("DICA")="Select Insurance Company"_$S(RCWHICH=1:" NAME: ",1:" TIN: ")
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
 ;
 S RCSORT=$$SORTT() Q:RCSORT=-1                     ; Select Sort
 S RCRANGE=$$DTRNG() Q:RCRANGE=0                    ; Select Date Range for Report
 I RCTYPE="S" S RCDISP=0                            ; Excel not implemented for summary report - PRCA*4.5*345
 E  S RCDISP=$$DISPTY() Q:RCDISP=-1                 ; Output to Excel?    
 I RCDISP D INFO^RCDPEM6                            ; Display capture information for Excel
 ;
 I 'RCDISP W !,"This report requires 132 column display."
 S %ZIS="QM" D ^%ZIS Q:POP                          ; Select output device
 ;
 ; Option to queue
 I 'RCDISP,$D(IO("Q")) D  Q
 . N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="REPORT^RCDPEAPP"
 . S ZTDESC="EDI LOCKBOX AUTO POST REPORT"
 . S ZTSAVE("RC*")="" ;**FA** ,ZTSAVE("VAUTD")=""
 . S ZTSAVE("^TMP(""RCDPEU1"",$J,")="" ; PRCA*4.5*326
 . D ^%ZTLOAD
 . I $D(ZTSK) W !!,"Task number "_ZTSK_" was queued."
 . E  W !!,"Unable to queue this job."
 . K IO("Q")
 . D HOME^%ZIS
 ;
 D REPORT                                           ; Compile and print report
 Q
 ;
STADIV(DIVS) ; Division/Station Filter/Sort
 ; Input:   None
 ; Output:  DIVS(A1)=A1^A3 Selected Divisions (if not 'ALL') Where:
 ;           A1 - Division IEN
 ;           A2 - Division Name
 ;           A3 - Station Number
 ; Returns: -1 - User ^ or timed out
 ;           1 - All divisions selected
 ;           2 - Selected Divisions
 N DIR,DIRUT,DIROUT,DIV,DTOUT,DUOUT,STNUM,VAUTD,Y
 D DIVISION^VAUTOMA Q:Y<0 -1                ; IA 664
 I VAUTD=1 S RCDIV=1 Q 1                    ; All Divisions selected
 K DIVS
 S DIV=""
 F  D  Q:DIV=""
 . S DIV=$O(VAUTD(DIV))
 . Q:DIV=""
 . S STNUM=$$GET1^DIQ(40.8,DIV,1,"E")
 . S:STNUM="" STNUM="UNKNOWN"
 . S DIVS(DIV)=VAUTD(DIV)_"^"_STNUM
 Q 2                                        ; Some Divisions selected
 ;
DETORSUM() ; Ask the user wants to see the detail or summary report
 ; Input:   None
 ; Returns: -1 - User ^ or timed out
 ;           D - Detail Mode
 ;           S - Summary Mode
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y
 S DIR(0)="SA^S:SUMMARY;D:DETAIL;",DIR("A")="Display (S)UMMARY or (D)ETAIL Format?: "
 S DIR("B")="DETAIL"
 S XX="Select 'SUMMARY' to see the summary report or "
 S DIR("?")=XX_"'DETAIL' to see the detail report"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q Y
 ;
NMORTIN() ; EP - Ask the user if they want to filter by Payer Name or TIN
 ; Input:   None
 ; Returns: -1 - User ^ or timed out
 ;           1 - Filter by Payer Name
 ;           2 - Filter by Payer TIN
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^N:NAME;T:TIN;"
 S DIR("A")="Select Insurance Companies by NAME or TIN: "
 S DIR("B")="TIN"
 S DIR("?")="Select 'NAME' to select Payers by name or 'TIN' to select Payers by TIN"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q:Y="N" 1
 Q 2
 ;
SELPAY(RCJOB,RCPARRAY) ; Move ^TMP("RCSELPAY",RCJOB) into RCPARRAY for lookup
 ; note that payer names for 344.4 are UPPER CASE
 ; Input:   RCJOB                   - $J
 ;          ^TMP("RCSELPAY",RCJOB,) - Temp array of selected Payers
 ; Output:  RCPARRAY(A1,A2)=A3      - Array of selected Payers Where:
 ;                                     A1 - Payer Name or TIN based on the way ^TMP("RCSELPAY" was built
 ;                                     A2 - Counter
 ;                                     A3 - Payer Name/TIN or TIN/Payer Name based on the way ^TMP("RCSELPAY" was built
 N PAYER,PSUB
 S PSUB=0
 F  S PSUB=$O(^TMP("RCSELPAY",RCJOB,PSUB)) Q:'PSUB  D
 . S PAYER=$G(^TMP("RCSELPAY",RCJOB,PSUB))
 . S:PAYER'="" RCPARRAY($P(PAYER,"/",1),PSUB)=PAYER
 Q
 ;
SORTT() ; Ask the user if they want to sort by Payer Name or Payer TIN
 ; Input:   None
 ; Returns: -1 - User ^ or timed out
 ;           0 - Sort by Payer Name
 ;           1 - Sort by Payer TIN
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^N:NAME;T:TIN;"
 S DIR("A")="Sort by Insurance Company NAME or TIN: "
 S DIR("B")="TIN"
 S DIR("?",1)="Select 'NAME' to sort by Division/Payer Name or"
 S DIR("?")="select 'TIN' to sort by Division/Payer TIN"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q:Y="N" 0
 Q 1
 ;
DTRNG() ; Get the date range for the report
 ; Input:   None
 ; Returns: 0 - User ^ or timed out
 ;          1^Start Date^End Date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCEND,RNGFLG,RCSTART,X,Y
 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
DISPTY() ; Get display/output type
 ; Input:   None
 ; Return:: -1 - User ^ or timed out
 ;           0 - Not to Excel
 ;           1 - Output to Excel
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="Export the report to Microsoft Excel"
 S DIR("B")="NO"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q Y
 ;
DATES(BDATE,EDATE) ; Get a date range.
 ; Input:   None
 ; Output:  BDATE   - Internal Begin date
 ;          EDATE   - Internal End date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S (BDATE,EDATE)=0
 S DIR("?")="Enter the earliest Auto-Posting date to include on the report"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y
 S DIR("?")="Enter the latest Auto-Posting date to include on the report"
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="End Date: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S EDATE=Y
 Q
 ;
REPORT ; Compile and print report
 ; Input:   RCDISP  - 0 - Output to paper or screen, 1 - Output to Excel
 ;          RCDIV   - 1 - All divisions, 2 - Selected divisions
 ;          RCDIVS()- Array of selected divisions if RCDIV=2
 ;          RCRANGE - 1^Start Date^End Date
 ;          RCJOB   - $J
 ;          RCLAIM  - "M" - Medical Claims, "P" - Pharmacy Claims, "B" - Both
 ;          RCPAGE  - Initialized to 0
 ;          RCPARRAY- Array of selected payers 
 ;          RCPROG  - "RCDPEAPP"
 ;          RCSORT  - 0 - Sort by Payer Name, 1 - Sort by Payer TIN
 ;          RCTYPE  - 'D' for detail report, 'S' for summary
 ;          RCWHICH - 1 - Filter by Payer Name, 2 - Filter by Payer TIN
 ;          ^TMP("RCDPEU1",$J) - Selected payerers (see SELPAY^RCDPEU1 for details)
 ;
 N GLOB,GTOTAL,ZTREQ
 K ^TMP(RCPROG,$J),^TMP("RCDPEAPP2",$J)
 S GLOB=$NA(^TMP(RCPROG,$J))
 D COMPILE^RCDPEAPQ                         ; Scan ERA file for entries in date range
 D DISP                                     ; Display the Report
 ;
 ; Clear ^TMP global
 K ^TMP(RCPROG,$J),^TMP("RCSELPAY",RCJOB),^TMP("RCDPEAPP2",$J),^TMP("RCDPEU1",$J) ; PRCA*4.5*326
 Q
 ;
DISP ; Format the display for screen/printer or MS Excel
 ; Input:   GLOB    - "^TMP("RCDPEAPP",$J)
 ;          RCDISP  - 1 - Output to Excel, 0 otherwise
 ;          RCDIV   - 1 - All Divisions selected
 ;          RCDIVS  - Array of selected Divisions (if all not selected)
 ;          RCPARRAY- Array of selected Payers
 ;          RCPAY   - 1 - All Payers selected
 N DIVS,LINE1,LINE2,PAYERS,RCDATA,RCHDRDT,RCSTOP,SUB,SUB1,SUB2,SUB3
 S RCHDRDT=$$FMTE^XLFDT($$NOW^XLFDT,"2SZ")       ; Date/time for header
 S LINE1=$TR($J("",131)," ","-"),LINE2=$TR(LINE1,"-","=")
 U IO
 ;
 ; Report by division or 'ALL'
 D LINED(RCDIV,.RCDIVS,.DIVS)                   ; Format Division filter
 D LINEP(RCPAY,.RCPARRAY,RCWHICH,.PAYERS)       ; Format Payer filter
 S SUB="",RCSTOP=0
 I RCDISP D HDR(.DIVS,.PAYERS)                  ; Single header for Excel
 I RCTYPE="D" F  S SUB=$O(@GLOB@(SUB)) Q:SUB=""  D  Q:RCSTOP  ; PRCA*4.5*345 Loop for Detail report
 . I 'RCDISP D
 . . D HDR(.DIVS,.PAYERS)                         ; Display Header
 . . W !,"DIVISION: ",SUB
 . S SUB1=""                                    ; Division
 . F  S SUB1=$O(@GLOB@(SUB,SUB1)) Q:SUB1=""  D  Q:RCSTOP
 . . S SUB2=""
 . . F  S SUB2=$O(@GLOB@(SUB,SUB1,SUB2)) Q:SUB2=""  D  Q:RCSTOP
 . . . ;
 . . . ; Display payer sub-header for detail report only
 . . . I 'RCDISP,RCTYPE="D" D HDRP(SUB1_"/"_SUB2)
 . . . S SUB3=""
 . . . F  S SUB3=$O(@GLOB@(SUB,SUB1,SUB2,SUB3)) Q:SUB3=""  D  Q:RCSTOP
 . . . . S RCDATA=@GLOB@(SUB,SUB1,SUB2,SUB3)
 . . . . I 'RCDISP D  Q:RCSTOP
 . . . . . I $Y>(IOSL-6) D HDR(.DIVS,.PAYERS) Q:RCSTOP
 . . . . . W !,$P(RCDATA,U,4)                   ; Patient Name
 . . . . . W ?31,$P(RCDATA,U,5)                 ; ERA#
 . . . . . W ?38,$P(RCDATA,U,6)                 ; Date Received
 . . . . . W ?49,$P(RCDATA,U,7)                 ; Date Autposted
 . . . . . W ?58,$P(RCDATA,U,8)                 ; EFT#
 . . . . . W ?67,$P(RCDATA,U,9)                 ; "TR" Receipt
 . . . . . W ?79,$E($P(RCDATA,U,10),1,12)       ; Bill #
 . . . . . ; PRCA*4.5*345 - Begin modified code block
 . . . . . W ?90,$J($P(RCDATA,U,11),10,2)       ; Original Billed Amount
 . . . . . W $J($P(RCDATA,U,12),10,2)           ; Paid Amount
 . . . . . W $J($P(RCDATA,U,13),10,2)           ; Balance
 . . . . . W $J($P(RCDATA,U,14),10,2)           ; % COLLECTED
 . . . . . W !,?8,"DEP#:",$P(RCDATA,U,16)       ; Deposit #
 . . . . . W ?25,"TRACE#:",$P(RCDATA,U,15)      ; Trace #
 . . . . . ; PRCA*4.5*345 - End modified code block
 . . . . . ;
 . . . . . ; Subtotals for Payer on detail report
 . . . . . I 'RCDISP,$O(@GLOB@(SUB,SUB1,SUB2,SUB3))="" D TOTALDP(SUB,SUB1,SUB2)
 . . . . I RCDISP D
 . . . . . I $L(RCDATA)>255 D  ;
 . . . . . . N RCPAY,RCTIN
 . . . . . . S RCPAY=$P(RCDATA,"^",3)
 . . . . . . S RCTIN=$P(RCPAY,"/",$S(RCSORT=0:2,1:1))
 . . . . . . S RCPAY=$P(RCPAY,"/",$S(RCSORT=0:1,1:2))
 . . . . . . S RCPAY=$E(RCPAY,1,$L(RCPAY)-($L(RCDATA)-255))
 . . . . . . S RCPAY=$S(RCSORT=0:RCPAY_"/"_RCTIN,1:RCTIN_"/"_RCPAY)
 . . . . . . S $P(RCDATA,"^",3)=RCPAY
 . . . . . W !,RCDATA
 . . . ;
 . . . ; Subtotals for Division on detail report
 . . . I 'RCDISP,RCTYPE="D",$O(@GLOB@(SUB,SUB1))="" D TOTALD(SUB)
 ;
 ; Grand totals
 I $D(GTOTAL),'RCSTOP D
 . I 'RCDISP,RCTYPE="D" D TOTALG                ; Print grand only total if detail report
 . I 'RCDISP,RCTYPE="S" D TOTALS                ; Print all totals if summary report
 . W !,$$ENDORPRT^RCDPEARL D:'$G(ZTSK) ASK(.RCSTOP)
 ;
 I '$D(GTOTAL) D                                ; Null Report
 . D HDR(.DIVS,.PAYERS)
 . W !!,?26,"*** NO RECORDS TO PRINT ***",!
 . W !,$$ENDORPRT^RCDPEARL D:'$G(ZTSK) ASK(.RCSTOP) ; PRCA*4.5*326
 ;
 ; Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
ASK(STOP) ; Ask to continue
 ; Output:  STOP    - 1 if display is aborted
 I $E(IOST,1,2)'["C-" Q                         ; Not displaying to screen, quit
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR("A")="Press ENTER to continue: "
 S DIR(0)="EA"
 D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S STOP=1
 Q
 ;
HDR(DIVS,PAYERS) ; Print the report header
 ; Input:   DIVS()      - Array of selected Division lines for Header
 ;          PAYERS()    - Array of selected Payer lines for Header
 ;          RCDISP      - 1 - Output to Excel, 0 otherwise
 ;          RCHDRDT     - External Print Date/Tim
 ;          RCPAGE      - Current Page number
 ;          RCRANGE     - Selected Date Range
 ;          RCSORT      - 0 - Sort by Payer Name, 1 - Sort by Payer TIN
 ;          RCSTOP      - 1 if display aborted
 ; Output:  RCPAGE      - Updated Page Number
 ;          RCSTOP      - 1 if display aborted
 N END,LN,MSG,START,XX,Y
 Q:RCSTOP
 I RCDISP D  Q          ; Output to Excel
 . S XX="STATION^STATION NUMBER^PAYER^PATIENT NAME/SSN^ERA#^DT REC'D"
 . S XX=XX_"^DT POST^EFT#^RECEIPT#^BILL#^AMT BILLED^AMT PAID^BALANCE^%COLL^TRACE#^DEPOSIT#"
 . W !,XX
 S START=$$FMTE^XLFDT($P(RCRANGE,U,2),"2DZ")
 S END=$$FMTE^XLFDT($P(RCRANGE,U,3),"2DZ")
 I RCPAGE D ASK(.RCSTOP) Q:RCSTOP
 S RCPAGE=RCPAGE+1
 W @IOF
 S MSG(1)="EDI LOCKBOX AUTO-POST REPORT - "_$S(RCTYPE="D":"DETAIL ",1:"SUMMARY")
 S MSG(1)=MSG(1)_$J("",47)_"Print Date: "_RCHDRDT_"    Page: "_RCPAGE
 ;
 S LN=2,XX=""
 F  D  Q:XX=""                              ; Display Division filters
 . S XX=$O(DIVS(XX))
 . Q:XX=""
 . S MSG(LN)=DIVS(XX),LN=LN+1
 ;
 S MSG(LN)="CLAIM TYPE: "
 S MSG(LN)=MSG(LN)_$S(RCLAIM="P":"PHARMACY",RCLAIM="M":"MEDICAL",RCLAIM="T":"TRICARE",1:"ALL")
 S MSG(LN)=MSG(LN)_$J("",55-$L(MSG(LN)))_"SORTED BY: "_$S(RCSORT=0:"PAYER NAME",1:"PAYER TIN") ; PRCA*4.5*326
 S LN=LN+1
 S MSG(LN)=$S(RCWHICH=2:"TINS",1:"PAYERS")_" : "_$S(RCPAY="S":"SELECTED",RCPAY="R":"RANGE",1:"ALL") ; PRCA*4.5*326
 S LN=LN+1
 S MSG(LN)="AUTOPOST POSTING RESULTS FOR DATE RANGE: "_START_" - "_END
 S LN=LN+1,MSG(LN)=LINE2
 S LN=LN+1
 I RCTYPE="D" D  ;
 . S MSG(LN)="PATIENT NAME/SSN               ERA#   DT REC'D   DT POST  EFT#     RECEIPT#    BILL#"
 E  S MSG(LN)="                                                                                    "
 S MSG(LN)=MSG(LN)_"      AMT BILLED  AMT PAID   BALANCE     %COLL"
 S LN=LN+1,MSG(LN)=LINE2
 D EN^DDIOL(.MSG)
 Q
 ;
HDRP(PAYNAM) ; Print Payer Sub-header
 ; Input:   LINE1   - 131 '-'s
 ;          PAYNAM  - TIN/Payer Name or Payer NAME/TIN depending on sort
 W !,LINE1,!,"PAYER: ",PAYNAM,!,LINE1
 Q
 ;
LINED(RCDIV,RCDIVS,DIVS) ; List selected Divisions
 ; Input:   RCDIV   - 1 - All Divisions Selected,
 ;          RCDIVS()- Array of selected Divisions
 ; Output   DIVS()  - Array of lines to print the Divisions
 ; Returns: Comma Delimitted list of Divisions
 N LN,SUB,XX
 K DIVS
 S SUB="",LN=1,DIVS(1)="DIVISIONS:  "
 I RCDIV=1 S DIVS(1)=DIVS(1)_"ALL" Q
 F  D  Q:'SUB
 . S SUB=$O(RCDIVS(SUB))
 . Q:'SUB
 . S XX=$P(RCDIVS(SUB),"^",2)
 . I $L(XX)+$L(DIVS(LN))+2>132 D
 . . S LN=LN+1,DIVS(LN)="            "_XX
 . E  S DIVS(LN)=$S($L(DIVS(LN))=12:DIVS(LN)_XX,1:DIVS(LN)_", "_XX)
 Q
 ;
LINEP(RCPAY,RCPARRAY,RCWHICH,PAYERS) ; List selected Payers
 ; Input:   RCPAY       - 2 - All Payers selected
 ;          RCPARRAY    - Array of selected Payers
 ;          RCWHICH     - 1 - Filter by Payer Name, 2 - Filter by Payer TIN
 ; Output:  PAYERS()    - Array of lines to Print the Payers
 ; Returns: Comma delimited list of Payer Names
 N CTR,DPAYS,LN,PAYR,PCE,XX
 K PAYERS
 S PAYR="",LN=1,PAYERS(1)="PAYERS:     "
 S PCE=$S(RCWHICH=1:2,1:1)
 I $P(RCPAY,U,1)=2 S PAYERS(1)=PAYERS(1)_"ALL" Q
 F  D  Q:PAYR=""
 . S PAYR=$O(RCPARRAY(PAYR))
 . Q:PAYR=""
 . S CTR=""
 . F  D  Q:CTR=""
 . . S CTR=$O(RCPARRAY(PAYR,CTR))
 . . Q:CTR=""
 . . S XX=$P(RCPARRAY(PAYR,CTR),"/",PCE)    ; Payer TIN
 . . Q:$D(DPAYS(XX))                        ; Already displayed
 . . S DPAYS(XX)=""
 . . I $L(XX)+$L(PAYERS(LN))+2>132 D
 . . . S LN=LN+1,PAYERS(LN)="            "_XX
 . . E  S PAYERS(LN)=$S($L(PAYERS(LN))=12:PAYERS(LN)_XX,1:PAYERS(LN)_", "_XX)
 Q
 ;
TOTALS ; Print totals for summary report
 ; Input:   GLOB    - "^TMP("RCPDEAPP",$J)
 N DBAL,DBAMT,DCNT,DIV,DPAMT,PAYIX1,PAYIX2
 S DIV=""
 F  D  Q:DIV=""  Q:RCSTOP
 . S DIV=$O(@GLOB@(DIV))
 . Q:DIV=""
 . D HDR(.DIVS,.PAYERS)                         ; PRCA*4.5*345 Display header
 . W !,"DIVISION: ",DIV,!,LINE1                 ; PRCA*4.5*345 Display division
 . S PAYIX1=""
 . F  D  Q:PAYIX1=""  Q:RCSTOP
 . . S PAYIX1=$O(@GLOB@(DIV,PAYIX1))
 . . Q:PAYIX1=""
 . . S PAYIX2=""
 . . F  D  Q:PAYIX2=""  Q:RCSTOP
 . . . S PAYIX2=$O(@GLOB@(DIV,PAYIX1,PAYIX2))
 . . . Q:PAYIX2=""
 . . . D TOTALDP(DIV,PAYIX1,PAYIX2)         ; Payer Totals
 . D TOTALD(DIV)                            ; Division Totals
 D TOTALG                                   ; Grand Totals
 Q
 ;
TOTALD(DIV) ; Display totals for a division
 ; Input:   DIV     - Division Name
 ;          DIVS()  - Array of selected Division lines for Header
 ;          PAYERS()- Array of selected Payer lines for Header
 ;          GLOB    - "^TMP("RCPDEAPP",$J)
 ;          LINE1   - 131 '-'s
 ;          RCDISP  - 1 - Output to Excel, 0 otherwise
 ; Output:  RCSTOP  - 1 if display aborted, 0 otherwise
 N DBAL,DBAMT,DCNT,DPAMTL
 S DCNT=$P(@GLOB@(DIV),U),DBAMT=$P(@GLOB@(DIV),U,2)
 S DPAMT=$P(@GLOB@(DIV),U,3),DBAL=$P(@GLOB@(DIV),U,4)
 I 'RCDISP,$Y>(IOSL-6) D HDR(.DIVS,.PAYERS) Q:RCSTOP
 W !,"DIVISION TOTALS FOR ",DIV,?90,$J(DBAMT,10,2)
 W $J(DPAMT,10,2),$J(DBAL,10,2)
 W:DBAMT'=0 $J(DPAMT/DBAMT*100,10,2),"%"
 W !,?8,"COUNT",?90,$J(DCNT,10,0),$J(DCNT,10,0),$J(DCNT,10,0)
 W !,?8,"MEAN",?90,$J(DBAMT/DCNT,10,2),$J(DPAMT/DCNT,10,2),$J(DBAL/DCNT,10,2)
 W !,LINE1
 Q
 ;
TOTALDP(DIV,PAYIX1,PAYIX2) ; Display totals for a payer within a division
 ; Input:   DIV     - Division Name
 ;          PAYIX1  - Payer Name OR TIN
 ;          PAYIX2  - TIN OR Payer Name
 ;          DIVS()  - Array of selected Division lines for Header
 ;          GLOB    - "^TMP("RCPDEAPP",$J)
 ;          LINE1   - 131 '-'s
 ;          PAYERS()- Array of selected Payer lines for Header
 ;          RCDISP  - 1 - Output to Excel, 0 otherwise
 ; Output:  RCSTOP  - 1 if display aborted, 0 otherwise
 N DATA,DBAL,DBAMT,DCNT,DPAMT
 I 'RCDISP,$Y>(IOSL-6) D HDR(.DIVS,.PAYERS) Q:RCSTOP
 S DATA=@GLOB@(DIV,PAYIX1,PAYIX2)       ; PRCA*4.5*345 Correct totals by payer
 S DCNT=$P(DATA,U),DBAMT=$P(DATA,U,2)   ; PRCA*4.5*345
 S DPAMT=$P(DATA,U,3),DBAL=$P(DATA,U,4) ; PRCA*4.5*345
 W:RCTYPE="D" !,?90,"-----------------------------------------"
 W !,"SUBTOTALS FOR PAYER: ",PAYIX1,"/",PAYIX2,?90,$J(DBAMT,10,2),$J(DPAMT,10,2)
 W $J(DBAL,10,2)
 W:DBAMT'=0 $J(DPAMT/DBAMT*100,10,2),"%"
 W !,?8,"COUNT",?90,$J(DCNT,10,0),$J(DCNT,10,0),$J(DCNT,10,0)
 W !,?8,"MEAN",?90,$J(DBAMT/DCNT,10,2),$J(DPAMT/DCNT,10,2),$J(DBAL/DCNT,10,2)
 W !,LINE1
 Q
 ;
TOTALG ;Display overall report total
 ; Input:   DIVS()  - Array of selected Division lines for Header
 ;          PAYERS()- Array of selected Payer lines for Header
 ;          GTOTAL  - Grand Totals
 ;          LINE1   - 131 '-'s
 ;          RCDISP  - 1 - Output to Excel, 0 otherwise
 ; Output:  RCSTOP  - 1 if display aborted, 0 otherwise
 I 'RCDISP,$Y>(IOSL-6) D HDR(.DIVS,.PAYERS) Q:RCSTOP
 W !,"GRAND TOTALS FOR ALL DIVISIONS",?90,$J(+$P(GTOTAL,U,2),10,2)
 W $J(+$P(GTOTAL,U,3),10,2),$J(+$P(GTOTAL,U,4),10,2)
 W $J($P(GTOTAL,U,3)/$P(GTOTAL,U,2)*100,9,2),"%"
 W !,?8,"COUNT",?90,$J(+$P(GTOTAL,U),10,0),$J(+$P(GTOTAL,U),10,0),$J(+$P(GTOTAL,U),10,0)
 W !,?8,"MEAN",?90,$J($P(GTOTAL,U,2)/$P(GTOTAL,U),10,2)
 W $J($P(GTOTAL,U,3)/$P(GTOTAL,U),10,2),$J($P(GTOTAL,U,4)/$P(GTOTAL,U),10,2)
 W !,LINE1
 Q
