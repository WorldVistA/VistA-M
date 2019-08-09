RCDPEMAP ;AITC/FA - LIST ALL AUTO-POSTED RECEIPTS REPORT ;Nov 17, 2016
 ;;4.5;Accounts Receivable;**332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Main entry point
 N INPUT,RCPAR,RCVAUTD,XX,YY
 K ^TMP($J,"RCDPE_MAP"),^TMP("RCDPE_MAP",$J)
 K ^TMP("RCSELPAY",$J),^TMP($J,"SELPAYER"),^TMP($J,"SELUSER")
 ;
 S INPUT=$$STADIV(.RCVAUTD)                 ; Division filter
 Q:'INPUT                                   ; '^' or timeout
 S $P(INPUT,"^",2)=$$DTRNG(0)               ; Start Date|End date
 Q:'$P(INPUT,"^",2)                         ; '^' or timeout
 S $P(INPUT,"^",3)=$$RTYPE^RCDPEU1("")      ; M/P/T filter
 Q:$P(INPUT,"^",3)<0                        ; '^' or timeout
 S RCPAR("SELC")=$$PAYRNG^RCDPEU1()         ; Selected or Range of Payers
 Q:RCPAR("SELC")=-1                         ; '^' or timeout
 S $P(INPUT,"^",4)=RCPAR("SELC")
 ;
 I RCPAR("SELC")'="A" D  Q:XX=-1            ; Since we don't want all payers 
 . S RCPAR("TYPE")=$P(INPUT,"^",3)          ; prompt for payers we do want
 . S RCPAR("FILE")=344.4
 . S RCPAR("DICA")="Select Insurance Company NAME: "
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
 ;
 S $P(INPUT,"^",5)=$$SELUSER()              ; Selected or All users filter
 Q:$P(INPUT,"^",5)<0                        ; '^' or timeout
 ;
 I $P(INPUT,"^",5)=2 D  Q:XX=-1             ; Prompt for selected users
 . S XX=$$SELUSER2()
 ;
 S $P(INPUT,"^",6)=$$SECSORT()              ; Secondary Sort
 Q:$P(INPUT,"^",6)<0                        ; '^' or timeout
 S $P(INPUT,"^",7)=$$ASKLM^RCDPEARL         ; Ask to Display in Listman Template
 Q:$P(INPUT,"^",7)<0                        ; '^' or timeout
 I $P(INPUT,"^",7)=1 D  Q                   ; Compile data and call listman to display
 . D LMOUT(INPUT,.RCVAUTD,.IO)
 S $P(INPUT,"^",8)=$$EXCEL()                ; Ask to output to Excel
 Q:$P(INPUT,"^",8)=-1                       ; '^' or timeout
 D:$P(INPUT,"^",8)=1 INFO^RCDPEM6           ; Display capture information for Excel
 S $P(INPUT,"^",9)=$$DEVICE($P(INPUT,"^",8),.IO)    ; Ask output device
 Q:'$P(INPUT,"^",9)
 ;
 ; Option to queue
 I $D(IO("Q")) D  Q
 . N JOB S JOB=$J
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="REPORT^RCDPEMAP(INPUT,.RCVAUTD,.IO,JOB)"
 . S ZTDESC="EEOBS MARKED FOR AUTO-POST AUDIT REPORT"
 . M RCPYRSEL=^TMP("RCSELPAY",$J)
 . S ZTSAVE("RC*")="",ZTSAVE("VAUTD")="",ZTSAVE("IO*")=""
 . S ZTSAVE("INPUT")="",ZTSAVE("JOB")=""
 . S ZTSAVE("^TMP(""RCDPEU1"",$J,")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 . K ZTSK,IO("Q")
 . D HOME^%ZIS
 ;
 D REPORT(INPUT,.RCVAUTD,.IO)               ; Compile and Display Report data
 Q
 ;
LMOUT(INPUT,RCVAUTD,IO) ; Output report to Listman
 ; Input:   INPUT       - See REPORT for a complete description
 ;          RCVAUTD     -  Array of selected Divisions
 ;                         Only passed if A1=2
 ; Output:  ^TMP("RCDPE_MAP",$J,CTR)=Line - Array of display lines (no headers)
 ;                                          for output to Listman
 N HDR,RCTEMP
 S $P(INPUT,"^",10)=0                       ; Initial listman line counter
 D REPORT(INPUT,.RCVAUTD,.IO)               ; Get the lines to be displayed
 S HDR("TITLE")="EEOBs MARKED FOR AP AUDIT"
 S HDR(1)=$$HDRLN2^RCDPEMA1(INPUT)
 S HDR(2)=$$HDRLN3^RCDPEMA1(INPUT)
 S HDR(3)=$$HDRLN4^RCDPEMA1(INPUT)
 S HDR(4)="ERA #       Claim #     Trace #"
 S RCTEMP="RCDPE EEOB MARKED FOR AP AUDIT"
 D LMRPT^RCDPEARL(.HDR,$NA(^TMP("RCDPE_MAP",$J)),RCTEMP) ; Generate ListMan display
 ;
 D ^%ZISC                                   ; Close the device
 K ^TMP("RCDPE_MAP",$J),^TMP($J,"RCDPE_MAP")
 K ^TMP("RCSELPAY",$J),^TMP($J,"SELPAYER"),^TMP($J,"SELUSER")
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
SELUSER() ; Ask the user if they only want to all users or only selected ones
 ; Input:   None
 ; Returns: 0 - User up-arrowed or timed out
 ;          1 - Show all users
 ;          2 - Show selected user
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Run Report for (S)pecific or (A)ll Users: "
 S DIR(0)="SA^S:Specific;A:All"
 S DIR("?",1)="Enter 'A' to show EEOBs marked by any user."
 S DIR("?")="Enter 'S' to show EEOBs marked by specific user(s)."
 S DIR("B")="A"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q:Y="A" 1
 Q 2
 ;
SELUSER2(PARAM) ; Allows the user to enter the selected users to filter by
 ; Input:   None
 ; Output:  ^TMP($J,"SELUSER",IEN)="" Where IEN - IEN for file 200
 ; Returns: 1 - Success, -1 - Abort
 N RCA,RET,RETURN,QUIT
 K ^TMP($J,"SELUSER")
 S QUIT=0,RETURN=1
 F  D  Q:QUIT
 . S RET=$$ASKUSER()
 . I RET=-1 S RETURN=-1,QUIT=1 Q
 . I RET=0 D
 . . I $D(^TMP($J,"SELUSER")) S QUIT=1
 . . E  D
 . . . W !!,"You must select at least one user",*7,!
 I RETURN=-1 K ^TMP($J,"SELUSER") Q -1
 S RETURN=$S($D(^TMP($J,"SELUSER")):1,1:-1)
 Q RETURN
 ;
ASKUSER() ; Prompt for a User from file 200
 ; Input:   None
 ; Output:  ^TMP($J,"SELUSER",IEN)="" - Selected User
 ; Returns:  1 - User selected
 ;           0 - No User selected
 ;          -1 - user typed '^' or timed out
 ;
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S RETURN=1
 ;
 S DIC=200,DIC(0)="QEA"
 S DIC("A")="Select User: "
 S DIC("S")="I '$D(^TMP($J,""SELUSER"",Y))"
 D ^DIC
 I $D(DTOUT)!$D(DUOUT) Q -1
 I Y=-1 Q 0
 S ^TMP($J,"SELUSER",+Y)=""
 Q 1
 ;
SECSORT() ; Ask the user if they want the secondary sort by User or Payer Name
 ; Input:   None
 ; Returns: 0       - User up-arrowed or timed out
 ;          1       - Sort by User
 ;          2       - Sort by Payer Name
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A")="Sort by Insurance Company (N)ame or (U)ser: "
 S DIR(0)="SA^N:Name;U:User"
 S DIR("?",1)="Enter 'N' to sort by Payer Name."
 S DIR("?")="Enter 'U' to sort by user."
 S DIR("B")="N"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q:Y="U" 1
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
 S DIR(0)="DA^:"_DT_":APE"
 S DIR("A")="Start Date: "
 S DIR("?")="Enter the earliest Auto-Post date"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)!(Y="") 0
 S START=Y
ENDDT ; Prompt for end date
 K DIR
 S DIR("B")=Y(0)
 S DIR(0)="DA^"_START_":"_DT_":APE"
 S DIR("A")="End Date: "
 S DIR("?")="Enter the latest Auto-Post date"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)!(Y="") 0
 I Y<START D  G ENDDT
 . S XX=$$FMTE^XLFDT(START,"2ZD") ;****
 . W !,*7,"Enter an End date that is not less than "_XX
 S RANGE=START_"|"_Y
 Q RANGE
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
 ;                       A2 - B1|B2   - Where:
 ;                             B1 - Auto-Post Start Date
 ;                             B2 - Auto-Post End Date
 ;                       A3 - 'M' - Medical Payers only
 ;                            'P' - Pharmacy Payers only
 ;                            'T' - Tricare Payers onlye
 ;                            'A' - All Payers
 ;                       A4 - 'S' - Specific Payers
 ;                            'R' - Range of Payers
 ;                            'A' - All Payers
 ;                       A5 - 1 - Display all users
 ;                            2 - Display selected users
 ;                       A6 - 1 - Sort by User
 ;                            2 - Sort by Payer Name
 ;                       A7 - 0 - Do not display in a listman template
 ;                            1 - Display in a listman template
 ;                       A8 - 0 - Output to paper
 ;                            1 - Output to Excel
 ;                       A9 - Line counter for Listman output
 ;           RCVAUTD -  Array of selected Divisions
 ;                      Only passed if A1=2
 ;           IO      - Interface device
 ;           JOB     - $J (optional, only passed in when report is queued)
 ;           ^TMP($J,"RCSELPAY") - Global Array of selected insurance companies
 ;           ^TMP($J,"SELUSER")  - Global Array of selected users
 ; Output:   ^TMP("RCDPEMAP",$J,CTR)=Line - Array of display lines (no headers)
 ;                                          for output to Listman
 ;                                          Only set when A7-1
 N CURDT,DIVFLT,DTEND,DTSTART,IENS,IEN3444,IEN34441,PAYER,PAYERU
 N RCTYPE,RCPAYS,SORT,TIN,UIEN,USER,USERU,USERF,SVAL,XX,YY,ZZ
 K ^TMP("RCDPE_MAP",$J),^TMP($J,"RCDPE_MAP")
 ; I '$G(JOB) S JOB=""
 U IO
 S DIVFLT=$P(INPUT,"^",1)                   ; Division filter
 S SORT=$P(INPUT,"^",6)                     ; Type of secondary sort
 S DTEND=$P($P(INPUT,"^",2),"|",2)_".9999"  ; End of Date Range
 S DTSTART=$P($P(INPUT,"^",2),"|",1)        ; End of Date Range
 S RCTYPE=$P(INPUT,"^",3)                   ; Medical/Pharmacy/Tricare/All
 S RCPAYS=$P(INPUT,"^",4)                   ; Payers All/Selected/Range
 S USERF=$P(INPUT,"^",5)                    ; All Users/Selected Users
 ;
 ; First filter and sort the report
 S CURDT=(DTSTART-1)_.9999
 F  D  Q:'CURDT  Q:CURDT>(DTEND)
 . S CURDT=$O(^RCY(344.4,"F",CURDT))
 . Q:'CURDT
 . Q:CURDT>(DTEND)
 . S IEN3444=0
 . F  D  Q:'IEN3444
 . . S IEN3444=$O(^RCY(344.4,"F",CURDT,IEN3444))
 . . Q:'IEN3444
 . . I DIVFLT'=1 Q:'$$CHKDIV^RCDPEDAR(IEN3444,1,.RCVAUTD)  ; Not a selected Division
 . . S PAYER=$$GET1^DIQ(344.4,IEN3444,.06,"I")             ; Payment From field
 . . S TIN=$$GET1^DIQ(344.4,IEN3444,.03,"I")               ; Insurance Co Id
 . . S PAYERU=$$UP^XLFSTR(PAYER)
 . . S PAYER=TIN_"/"_$E(PAYER,1,70-$L(TIN))
 . . S XX=1
 . . I RCPAYS'="A" D  Q:'XX
 . . . S XX=$$ISSEL^RCDPEU1(344.4,IEN3444)              ; Check if payer was selected
 . . E  I RCTYPE'="A" D  Q:'XX                          ; If all of a give type of payer selected
 . . . S XX=$$ISTYPE^RCDPEU1(344.4,IEN3444,RCTYPE)      ; Check that payer matches type
 . . S IEN34441=""
 . . F  D  Q:IEN34441=""
 . . . S IEN34441=$O(^RCY(344.4,"F",CURDT,IEN3444,IEN34441))
 . . . Q:IEN34441=""
 . . . S IENS=IEN34441_","_IEN3444_","
 . . . S UIEN=$$GET1^DIQ(344.41,IENS,6.01,"I")          ; ERA Detail line Marked Auto-Post User
 . . . Q:UIEN=""                                        ; Not marked for Auto-Post
 . . . S USER=$$GET1^DIQ(200,UIEN_",",.01,"E")
 . . . S USERU=$$UP^XLFSTR(USER)
 . . . I USERF'=1,'$D(^TMP($J,"SELUSER",UIEN)) Q        ; Not a selected User
 . . . S SVAL=$S(SORT=2:PAYERU,1:USERU)                 ; Get the sort value
 . . . S XX=PAYER_"^"_USER
 . . . S $P(XX,"^",3)=$$GET1^DIQ(344.4,IEN3444_",",.01,"E")_"."_IEN34441 ; ERA#_"."_SEQ
 . . . S YY=$$GET1^DIQ(344.41,IENS,.02,"I")                 ; IEN for 361.1
 . . . S ZZ=$$GET1^DIQ(361.1,YY_",",.01,"I")                ; IEN for 399/430
 . . . S ZZ=$$GET1^DIQ(430,ZZ_",",.01,"E")                  ; Claim #
 . . . S ZZ=$TR(ZZ,"-","")
 . . . S $P(XX,"^",4)=ZZ
 . . . S $P(XX,"^",5)=$$GET1^DIQ(361.1,YY_",",.07,"E")      ; Trace #
 . . . ;
 . . . ; Found one that was marked for auto-post
 . . . S ^TMP($J,"RCDPE_MAP","SEL",CURDT)=$$FMTE^XLFDT(CURDT,"2ZD")
 . . . S ^TMP($J,"RCDPE_MAP","SEL",CURDT,SVAL)=$S(SORT=2:PAYER,1:USER)
 . . . S ^TMP($J,"RCDPE_MAP","SEL",CURDT,SVAL,IEN3444,IEN34441)=XX
 ;
 D RPTOUT^RCDPEMA1(INPUT)                   ; Output the report
 ;
 ; Quit if Listman - clean up of ^TMP & device is handled in LMOUT^RCDPELAR
 Q:$P(INPUT,"^",7)=1
 ;
 ; Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP("RCDPE_MAP",$J),^TMP($J,"RCDPE_MAP")
 K ^TMP("RCSELPAY",$J),^TMP($J,"SELPAYER"),^TMP($J,"SELUSER")
 K ^TMP("RCDPEU1",$J)
 K ZTQUEUED
 Q
 ;
ASKSTOP() ;EP from RCDPEMA1
 ; Ask to continue
 ; Input:   IOST    - Device Type 
 ; Returns: 1 - User wants to quit, 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q:$E(IOST,1,2)'["C-" 0                     ; Not a terminal
 S DIR(0)="E"
 W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) Q 1
 Q 0
 ;
