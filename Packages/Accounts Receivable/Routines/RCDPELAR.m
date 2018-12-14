RCDPELAR ;EDE/FA - LIST ALL AUTO-POSTED RECEIPTS REPORT ;Nov 17, 2016
 ;;4.5;Accounts Receivable;**318,321,326**;Mar 20, 1995;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Main entry point
 N INPUT,RCPAR,RCVAUTD,XX,YY
 K ^TMP($J,"RCDPE_LAR"),^TMP("RCDPE_LAR",$J)
 K ^TMP("RCSELPAY",$J),^TMP($J,"SELPAYER")
 ;
 S INPUT=$$STADIV(.RCVAUTD)                     ; Division filter
 Q:'INPUT                                       ; '^' or timeout
 S $P(INPUT,"^",2)=$$APORERA()                  ; Filter by Auto-Post Date or ERA Date Received
 Q:'$P(INPUT,"^",2)                             ; '^' or timeout
 S $P(INPUT,"^",3)=$$DTRNG(0)                   ; Start Date|End date
 Q:'$P(INPUT,"^",3)                             ; '^' or timeout
 S $P(INPUT,"^",4)=$$SELERA()                   ; Select type of ERAS to be displayed
 Q:'$P(INPUT,"^",4)
 ;
 ; PRCA*4.5*326 - Ask to show Medical/Pharmacy Tricare or All
 S $P(INPUT,"^",10)=$$RTYPE^RCDPEU1("")
 I $P(INPUT,"^",10)<0 Q
 ;
 S RCPAR("SELC")=$$PAYRNG^RCDPEU1()             ; PRCA*4.5*326 - Selected or Range of Payers
 Q:RCPAR("SELC")=-1                             ; PRCA*4.5*326 '^' or timeout
 S $P(INPUT,"^",5)=RCPAR("SELC")
 ;
 I RCPAR("SELC")'="A" D  Q:XX=-1                ; PRCA*4.5*326 - Since we don't want all payers 
 . S RCPAR("TYPE")=$P(INPUT,"^",10)             ;         prompt for payers we do want
 . S RCPAR("FILE")=344.4
 . S RCPAR("DICA")="Select Insurance Company NAME: "
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
 ;
 S XX=$P(INPUT,"^",2),YY=$P(INPUT,"^",4)
 S $P(INPUT,"^",6)=$$RPTSORT(XX,YY)             ; Select Secondary sort
 Q:'$P(INPUT,"^",6)                             ; '^' or timeout
 S $P(INPUT,"^",7)=$$ASKLM^RCDPEARL             ; Ask to Display in Listman Template
 Q:$P(INPUT,"^",7)<0                            ; '^' or timeout
 I $P(INPUT,"^",7)=1 D  Q                       ; Compile data and call listman to display
 . D LMOUT(INPUT,.RCVAUTD,.IO)
 S $P(INPUT,"^",8)=$$EXCEL()                    ; Ask to output to Excel
 Q:$P(INPUT,"^",8)=-1                           ; '^' or timeout
 D:$P(INPUT,"^",8)=1 INFO^RCDPEM6               ; Display capture information for Excel
 S $P(INPUT,"^",9)=$$DEVICE($P(INPUT,"^",8),.IO)    ; Ask output device
 Q:'$P(INPUT,"^",9)
 ;
 ; Option to queue
 I $D(IO("Q")) D  Q
 . N JOB S JOB=$J
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="REPORT^RCDPELAR(INPUT,.RCVAUTD,.IO,JOB)"
 . S ZTDESC="LIST ALL AUTO-POSTED RECEIPTS REPORT"
 . M RCPYRSEL=^TMP("RCSELPAY",$J)
 . S ZTSAVE("RC*")="",ZTSAVE("VAUTD")="",ZTSAVE("IO*")=""
 . S ZTSAVE("INPUT")="",ZTSAVE("JOB")=""
 . S ZTSAVE("^TMP(""RCDPEU1"",$J,")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 . K ZTSK,IO("Q")
 . D HOME^%ZIS
 ;
 D REPORT(INPUT,.RCVAUTD,.IO)           ; Compile and Display Report data
 Q
 ;
LMOUT(INPUT,RCVAUTD,IO) ; Output report to Listman
 ; Input:   INPUT       - See REPORT for a complete description
 ;          RCVAUTD     -  Array of selected Divisions
 ;                         Only passed if A1=2
 ; Output:  ^TMP("RCDPE_LAR",$J,CTR)=Line - Array of display lines (no headers)
 ;                                           for output to Listman
 ;                                           Only set when A7-1
 N HDR
 S $P(INPUT,"^",9)=0                             ; Initial listman line counter
 D REPORT(INPUT,.RCVAUTD,.IO)                    ; Get the lines to be displayed
 S HDR("TITLE")="AUTO-POSTED RECEIPT REPORT"
 S HDR(1)=$$HDRLN2^RCDPELA1(INPUT)
 S HDR(2)=$$HDRLN3^RCDPELA1(INPUT)
 S HDR(3)=""
 S HDR(4)=""
 S HDR(5)="PAYER"
 S HDR(6)="        DATE      DATE"
 S HDR(7)=$$ERAHDR2^RCDPELA1()
 D LMRPT^RCDPEARL(.HDR,$NA(^TMP("RCDPE_LAR",$J))) ; Generate ListMan display
 ;
 D ^%ZISC                                       ; Close the device
 K ^TMP("RCDPE_LAR",$J),^TMP($J,"RCDPE_LAR")
 K ^TMP("RCSELPAY",$J),^TMP($J,"SELPAYER")
 Q
 ;
STADIV(RCVAUTD) ; Division/Station Filter
 ; Input:   None
 ; Output:  RCVAUTD     - Array of selected divisions, if 1 is returned
 ; Returns: 0           - User up-arrowed or timed out
 ;          1           - All divisions selected
 ;          2           - Selected Divisions
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,VAUTD,X,Y
 D DIVISION^VAUTOMA                         ; IA #664 allows this
 Q:Y<0 0                                    ; User up-arrowed or timed out
 Q:VAUTD=1 1                                ; All divisions selected
 M RCVAUTD=VAUTD                            ; Save selected divisions (if any)
 Q 2
 ;
APORERA() ; Ask the user if they want to filter by Auto-Post Date or ERA Date
 ; received
 ; Input:   None
 ; Returns: 0       - User up-arrowed or timed out
 ;          1       - Filter by Auto-Post date range
 ;          2       - Filter by ERA Date Received
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="(A)uto-Post Date or (E)RA Date Received? (A/E): "
 S DIR(0)="SA^A:Auto-Post Date;E:ERA Date Received"
 S DIR("?",1)="Enter 'A' to filter by an Auto-Post Date Range."
 S DIR("?")="Enter 'E' to filter by an ERA Date Received Date Range."
 S DIR("B")="A"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q 0
 Q:Y="A" 1
 Q 2
 ;
DTRNG(WHICH) ; Allows the user to select the Auto-Post OR ERA Received
 ; date range to be used
 ; Input:   WHICH   - 0 - Auto-Post Date Range
 ;                    1 - ERA Date Received Date Range
 ; Returns: 0       - User up-arrowed or timed out, 1 otherwise
 ;          A1^A2   - Where:
 ;                    A1 - Aut-Post Start Date
 ;                    A2 - Auto-Post End Date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RANGE,START,X,XX,Y
 S DIR(0)="DAO^:"_DT_":APE"
 S DIR("A")="Start Date: "
 S XX="Enter the earliest "_$S(WHICH=0:"Auto-Post date",1:"ERA Date Received")
 S XX=XX_" for receipts to include on the report"
 S DIR("?")=XX
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)!(Y="") 0
 S START=Y
ENDDT ; Prompt for end date
 K DIR
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_START_":"_DT_":APE"
 S DIR("A")="End Date: "
 S XX="Enter the latest "_$S(WHICH=0:"Auto-Post date",1:"ERA Date Received")
 S XX=XX_" for receipts to include on the report"
 S DIR("?")=XX
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)!(Y="") 0
 I Y<START D  G ENDDT
 . S XX=$$FMTE^XLFDT(START,"2ZD") ;****
 . W !,*7,"Enter an End date that is not less than "_XX
 S RANGE=START_"|"_Y
 Q RANGE
 ;
SELERA() ; Ask the user which types of ERA the want to see on the report
 ; Input:   None
 ; Returns: 0       - User up-arrowed or timed out
 ;          1       - Posted/Completed Receipts
 ;          2       - Only ERAs with Missing Receipts
 ;          3       - Both Posted/Completed and Missing Receipts
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Select ERAs to be Displayed: "
 S DIR(0)="SA^1:Posted/Completed Receipts;2:Missing Receipts;3:Both"
 S DIR("B")="Both"
 S DIR("?",1)="Enter 1 to only display Posted Receipts."
 S DIR("?",2)="Enter 2 to only display ERAs with missing receipts."
 S DIR("?")="Enter 3 to display all receipts."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q 0
 Q Y
 ;
RPTSORT(WHICH,ERASEL) ; Ask the user how they want to sort the data
 ; Input:   WHICH   - 1- Filtering by Auto-Post Date
 ;                    2 - Filtering by ERA Date Received 
 ;          ERASEL  - ERA Filter          
 ;                    1 - Posted/Completed Receipts
 ;                    2 - Only ERAs with Missing Receipts
 ;                    3 - Both Posted/Completed and Missing Receipts
 ; Returns: 0       - User up-arrowed or timed out
 ;          1       - Auto-Post Date sort
 ;          2       - Missing Receipts
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y
 ;
 ; If the user is only showing Posted/Completed Receipts OR 
 ; Missing Receipts then the only possible sort value is by date
 I ERASEL'=3 Q 1
 S DIR("A")="Sort by (D)ate or (M)issing Receipts: "
 S DIR(0)="SA^D:Date;M:Missing Receipts"
 S DIR("B")="D"
 S XX=$S(WHICH=1:"Auto-Post date.",1:"ERA Date Received.")
 S DIR("?",1)="Enter 'D' to sort by "_XX
 S DIR("?")="Enter 'M' to display Missing Receipts first."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q 0
 S XX=$S(Y="D":1,Y="P":2,1:3)
 Q XX
 ;
EXCEL() ; Ask the user if they want to export to Excel
 ; Input:   None
 ; Returns: -1      - User up-arrowed or timed out
 ;           0      - Output to paper
 ;           1      - Output to Excel
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="Export the report to Microsoft Excel"
 S DIR("B")="NO"
 S DIR("?")="Enter 'YES' to output to Excel. Otherwise enter 'NO'"
 D ^DIR
 I $G(DUOUT) Q -1
 Q Y
 ;
DEVICE(EXCEL,IO) ; Select the output device
 ; Input:   EXCEL   - 1 - Ouput to Excel, 0 otherwise
 ; Output:  %ZIS    - Selected device
 ;          IO      - Array of selected output info
 ; Returns: 0       - No device selected, 1 otherwise
 N POP,RCPYRSEL,%ZIS
 S %ZIS="QM"
 D ^%ZIS
 Q:POP 0
 Q:EXCEL 1                  ; Output to Excel, no queueing
 ;
 Q 1
 ;
REPORT(INPUT,RCVAUTD,IO,JOB) ; Compile and run the report
 ; Expects ZTQUEUED to be defined already if queued
 ; Input:   INPUT   - A1^A2^A3^...^An Where:
 ;                       A1 - 1 - All divisions selected
 ;                            2 - Selected divisions
 ;                       A2 - 1 - Filter by Auto-Post date range
 ;                            2 - Filter by ERA Date Received date range
 ;                       A3 - B1|B2   - Where:
 ;                             B1 - ERA Date Received Start Date if A2=2
 ;                                  Auto-Post Start Date of A2=1
 ;                             B2 - ERA Date Received End Date if A2=2
 ;                                  Auto-Post End Date of A2=1
 ;                       A4 - 1 - Posted/Completed Receipts
 ;                            2 - Only ERAs with Missing Receipts
 ;                            3 - Both Posted/Completed and Missing Receipts
 ;                       A5 - 1 - All insurance companies selected
 ;                            2 - Selected insurance companies chosen
 ;                       A6 - 1 - Auto-Post Date/ERA Date Received Sort
 ;                            2 - Payer sort
 ;                            3 - Missing Receipts
 ;                       A7 - 0 - Do not display in a listman template
 ;                            1 - Display in a listman template
 ;                       A8 - 0 - Output to paper
 ;                            1 - Output to Excel
 ;                       A9 - Line counter for Listman output
 ;                       A10 - M/P/T/A = Medical/Pharmacy/Tricare/All  
 ;           RCVAUTD -  Array of selected Divisions
 ;                      Only passed if A1=2
 ;           IO      - Interface device
 ;           JOB     - $J (optional, only passed in when report is queued)
 ;           ^TMP("RCSELPAY",$J)- Global Array of selected insurance companies
 ; Output:   ^TMP("RCDPE_LAR",$J,CTR)=Line - Array of display lines (no headers)
 ;                                           for output to Listman
 ;                                           Only set when A7-1
 N CURDT,DIVFLT,DTEND,DTSTART,ERAFILT,WHICH,RCTYPE,RCPAYS,SORT,STOP,XX
 K ^TMP("RCDPE_LAR",$J),^TMP($J,"RCDPE_LAR")
 ; I '$G(JOB) S JOB=""
 U IO
 ; D PAYERS(JOB)                            ; Rearrange payer global for easier use
 S DIVFLT=$P(INPUT,"^",1)                   ; Division filter
 S WHICH=$P(INPUT,"^",2)                    ; 1 - Auto-Post date, 2 - ERA Date Received
 S SORT=$P(INPUT,"^",6)                     ; Type of secondary sort
 S DTEND=$P($P(INPUT,"^",3),"|",2)_".9999"  ; End of Date Range
 S DTSTART=$P($P(INPUT,"^",3),"|",1)        ; End of Date Range
 S ERAFILT=$P(INPUT,"^",4)                  ; ERA Filter
 S RCTYPE=$P(INPUT,"^",10)                  ; PRCA*4.5*326 Medical/Pharmacy/Tricare/All
 S RCPAYS=$P(INPUT,"^",5)                   ; Payers All/Selected/Range
 ;
 ; First filter and sort the report
 S CURDT=(DTSTART-1)_.9999                  ;PRCA*4.5*321 Added '_.9999'
 F  D  Q:'CURDT  Q:CURDT>(DTEND)
 . S:WHICH=1 CURDT=$O(^RCY(344.4,"F",CURDT))
 . S:WHICH=2 CURDT=$O(^RCY(344.4,"AFD",CURDT))
 . Q:'CURDT
 . Q:CURDT>(DTEND)
 . I WHICH=2 D RPTE(DIVFLT,CURDT,SORT,ERAFILT,.RCVAUTD,RCTYPE,RCPAYS) Q
 . D RPTA(DIVFLT,CURDT,SORT,ERAFILT,.RCVAUTD,RCTYPE,RCPAYS)
 ;
 D RPTOUT^RCDPELA1(INPUT)                ; Output the report
 ;
 ; Quit if Listman - clean up of ^TMP & device is handled in LMOUT^RCDPELAR
 I $P(INPUT,"^",7)=1 Q
 ;
 ; Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP("RCDPE_LAR",$J),^TMP($J,"RCDPE_LAR")
 K ^TMP("RCSELPAY",$J),^TMP($J,"SELPAYER")
 K ^TMP("RCDPEU1",$J) ; PRCA*4.5*326
 K ZTQUEUED
 Q
 ;
PAYERS(JOB) ; Rearrange payer global for easier use
 ; Input:   ^TMP("RCSELPAY",$J,nn)=Payer Name - Global Array of selected
 ;                                              insurance companies
 ; Output   ^TMP($J,"SELPAYER",Payer Name)="" - Global Array of selected
 ;                                    insurance rearranged for easier checks
 I JOB="" S JOB=$J
 N PAYER,XX
 K ^TMP($J,"SELPAYER")
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(^TMP("RCSELPAY",JOB,XX))
 . Q:XX=""
 . S PAYER=$$UP^XLFSTR(^TMP("RCSELPAY",JOB,XX))
 . S ^TMP($J,"SELPAYER",PAYER)=""
 K ^TMP("RCSELPAY",JOB)
 Q
 ;
RPTE(DIVFLT,CURDT,SORT,ERAFILT,VAUTD,RCTYPE,RCPAYS) ; Use the ERA Date Received index and filter out
 ; divisions, payers that weren't selected
 ; Input:   DIVFLT              - 1 - All Divisions selected, 2 otherwise
 ;          CURDT               - Date being processed
 ;          SORT                - 1 - Auto-Post Date Sort
 ;                                2 - Missing Receipts
 ;          ERAFILT             - 1 - Posted/Completed Receipts
 ;                                2 - Only ERAs with Missing Receipts
 ;                                3 - Both Posted/Completed and Missing Receipts
 ;          VAUTD               - Array of selected divisions
 ;          RCTYPE              - Type of payer - M/P/T/A
 ;          RCPAYS              - A - All payers, S - Selected Payers, R - Range of Payers
 ;         ^TMP("RCSELPAY",$J)  - Global Array of selected insurance companies
 ; Output: ^TMP($J,A1,"SEL",A2,A3,A4,A5)="" - if record passed filters Where:
 ;                                 A1 - "RCDPE_LAR"
 ;                                 A2 - Uppercased Payer Name (primary sort)
 ;                                 A3 - Secondary Sort Value
 ;                                 A4 - Internal IEN for file 344.4
 ;                                 A5 - Internal IEN for sub file 344.41
 N COMPLETE,IEN3444,IEN34441,IENS,PAYER,RECEIPT,SVAL,TIN,XX
 S IEN3444=0
 F  D  Q:'IEN3444
 . S IEN3444=$O(^RCY(344.4,"AFD",CURDT,IEN3444))
 . Q:'IEN3444
 . S PAYER=$$GET1^DIQ(344.4,IEN3444,.06,"I")            ; Payment From field
 . S PAYER=$$UP^XLFSTR(PAYER)
 . S XX=1
 . I RCPAYS'="A" D  Q:'XX
 . . S XX=$$ISSEL^RCDPEU1(344.4,IEN3444)                ; PRCA*4.5*326 Check if payer was selected
 . E  I RCTYPE'="A" D  Q:'XX                            ; If all of a give type of payer selected
 . . S XX=$$ISTYPE^RCDPEU1(344.4,IEN3444,RCTYPE)        ;  check that payer matches type
 . I DIVFLT'=1 Q:'$$CHKDIV^RCDPEDAR(IEN3444,1,.VAUTD)   ; Not a selected Division
 . S XX=$$GET1^DIQ(344.4,IEN3444,4.01,"I")              ; Auto-Post date on ERA
 . Q:'XX                                                ; skip if not auto-posted ERA
 . S COMPLETE=$$COMPLETE(IEN3444)                       ; Check for missing receipts
 . I ERAFILT=1,'COMPLETE Q                              ; Missing Receipt
 . I ERAFILT=2,COMPLETE Q                               ; Not a Missing Receipt
 . ;
 . ; Just showing missing receipts and this ERA doesn't have any
 . I ERAFILT=2,COMPLETE Q
 . S IEN34441=0
 . F  D  Q:'IEN34441
 . . S IEN34441=$O(^RCY(344.4,IEN3444,1,IEN34441))
 . . Q:'IEN34441
 . . S IENS=IEN34441_","_IEN3444_","
 . . S SVAL=$S(SORT=1:CURDT,1:COMPLETE)                 ; Get the sort value
 . . S ^TMP($J,"RCDPE_LAR","SEL",PAYER,SVAL,IEN3444,IEN34441)=""
 Q
 ;
RPTA(DIVFLT,CURDT,SORT,ERAFILT,VAUTD,RCTYPE,RCPAYS) ; Use the Auto-Post Date index and filter out
 ; divisions, payers that weren't selected
 ; Input:   DIVFLT              - 1 - All Divisions selected, 2 otherwise
 ;          CURDT               - Date being processed
 ;          SORT                - 1 - Auto-Post Date Sort
 ;                                2 - Missing Receipts
 ;          ERAFILT             - 1 - Posted/Completed Receipts
 ;                                2 - Only ERAs with Missing Receipts
 ;                                3 - Both Posted/Completed and Missing Receipts
 ;          VAUTD               - Array of selected divisions
 ;          RCTYPE              - Type of payer - M/P/T/A
 ;          RCPAYS              - A - All payers, S - Selected Payers, R - Range of Payers
 ;         ^TMP("RCSELPAY",$J)  - Global Array of selected insurance companies
 ;         ^TMP($J,"RCDPE_LAR","ERA") - see output for definition
 ; Output: ^TMP($J,A1,"SEL",A2,A3,A4,A5)="" - if record passed filters Where:
 ;                                 A1 - "RCDPE_LAR"
 ;                                 A2 - Uppercased Payer Name (primary sort)
 ;                                 A3 - Secondary Sort Value
 ;                                 A4 - Internal IEN for file 344.4
 ;                                 A5 - Internal IEN for sub file 344.41
 ;        ^TMP($J,A1,"ERA",A2)="" - List of ERAs that were already pulled Where:
 ;                                 A1 - "RCDPE_LAR"
 ;                                 A2 - IEN of #344.4 (ERA #)
 ;
 N COMPLETE,IEN3444,IEN3441,PAYER,SVAL
 S IEN3444=0
 F  D  Q:'IEN3444
 . S IEN3444=$O(^RCY(344.4,"F",CURDT,IEN3444))
 . Q:'IEN3444
 . I DIVFLT'=1 Q:'$$CHKDIV^RCDPEDAR(IEN3444,1,.VAUTD)   ; Not a selected Division
 . S COMPLETE=$$COMPLETE(IEN3444)
 . I ERAFILT=1,'COMPLETE Q                              ; Missing Receipt
 . I ERAFILT=2,COMPLETE Q                               ; Not a Missing Receipt
 . S PAYER=$$GET1^DIQ(344.4,IEN3444,.06,"I")            ; Payment From field
 . S PAYER=$$UP^XLFSTR(PAYER)
 . ; Q:'$D(^TMP($J,"SELPAYER",PAYER))                   ; Not a selected payer
 . S XX=1
 . I RCPAYS'="A" D  Q:'XX
 . . S XX=$$ISSEL^RCDPEU1(344.4,IEN3444)                ; PRCA*4.5*326 Check if payer was selected
 . E  I RCTYPE'="A" D  Q:'XX                            ; If all of a give type of payer selected
 . . S XX=$$ISTYPE^RCDPEU1(344.4,IEN3444,RCTYPE)        ;  check that payer matches type
 . Q:$D(^TMP($J,"RCDPE_LAR","ERA",IEN3444))             ; Already pulled this ERA
 . ;
 . S ^TMP($J,"RCDPE_LAR","ERA",IEN3444)=""
 . S IEN34441=0
 . F  D  Q:'IEN34441
 . . S IEN34441=$O(^RCY(344.4,IEN3444,1,IEN34441))
 . . Q:'IEN34441
 . . S SVAL=$S(SORT=1:CURDT,1:COMPLETE)                ; Get the sort value
 . . S ^TMP($J,"RCDPE_LAR","SEL",PAYER,SVAL,IEN3444,IEN34441)=""
 Q
 ;
COMPLETE(IEN3444) ; Checks an ERA for missing receipts
 ; Input:   IEN3444   - ERA to be checked
 ; Returns: 0 if at least one detail line of the ERA has a missing receipt
 ;          1 otherwise
 N XX
 S XX=$$GET1^DIQ(344.4,IEN3444,4.02,"I")    ; Auto-Post Status field
 I XX=2 Q 1                                 ; Complete ERA
 Q 0
 ;
ASKSTOP() ; Ask to continue
 ; Input:   IOST    - Device Type 
 ; Returns: 1 - User wants to quit, 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q:$E(IOST,1,2)'["C-" 0                     ; Not a terminal
 S DIR(0)="E"
 W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) Q 1
 Q 0
 ;
