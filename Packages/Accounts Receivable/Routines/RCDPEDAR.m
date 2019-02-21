RCDPEDAR ;ALB/TMK - ACTIVITY REPORT ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,276,284,283,298,304,318,321,326**;Mar 20, 1995;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
RPT ; Daily Activity Rpt On Demand
 N POP,RCDET,RCDIV,RCDONLY,RCDT1,RCDT2,RCHDR,RCINC,RCLSTMGR,RCNJ
 N RCPAR,RCPAY,RCPYRSEL,RCRANGE,RCSTOP,RCTMPND,RCTYPE,VAUTD,X,XX,Y,%ZIS
 S RCNJ=0                                   ; Not the nightly job, user interactions
 D DIVISION^VAUTOMA                         ; IA 664 Select Division/Station - sets VAUTD
 I 'VAUTD,($D(VAUTD)'=11) Q
 S RCDET=$$RTYPE()                          ; Select Report Type (Summary/Detail)
 Q:RCDET=-1
 S XX=$$DTRANGE(.RCDT1,.RCDT2)              ; Select Date Range to be used
 Q:'XX
 ;
 ; PRCA*4.5*326 - Ask to show Medical/Pharmacy Tricare or All
 S RCTYPE=$$RTYPE^RCDPEU1("")
 I RCTYPE<0 Q
 ;
 S RCPAY=$$PAYRNG^RCDPEU1()             ; PRCA*4.5*326 - Selected or Range of Payers
 Q:RCPAY=-1                             ; PRCA*4.5*326 '^' or timeout
 ;
 I RCPAY'="A" D  Q:XX=-1                ; PRCA*4.5*326 - Since we don't want all payers 
 . S RCPAR("SELC")=RCPAY                ;         prompt for payers we do want
 . S RCPAR("TYPE")=RCTYPE
 . S RCPAR("FILE")=344.4
 . S RCPAR("DICA")="Select Insurance Company NAME: "
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
 ;
 S RCDONLY=$$DBTONLY()                      ; Debit only filter   ;PRCA*4.5*321
 Q:RCDONLY=-1                               ; '^' or timeout
 S RCLSTMGR=$$ASKLM^RCDPEARL                ; Ask to Display in Listman Template
 Q:RCLSTMGR<0                               ; '^' or timeout
 ;
 I RCLSTMGR=1 D  Q                          ; ListMan Template format, put in array
 . S RCTMPND="RCDPE_DAR"
 . K ^TMP($J,RCTMPND)
 . D EN(RCDET,RCDT1,RCDT2,RCLSTMGR,RCDONLY)
 . D LMHDR^RCDPEDA4(.RCSTOP,RCDET,1,RCDT1,RCDT2,.RCHDR,RCDONLY)
 . D LMRPT^RCDPEARL(.RCHDR,$NA(^TMP($J,RCTMPND))) ; Generate ListMan display
 . K ^TMP($J,RCTMPND)
 ;
 ; Ask device
 S %ZIS="QM"
 D ^%ZIS
 Q:POP
 ;
 I $D(IO("Q")) D  Q                         ; Queued Report
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="EN^RCDPEDAR("_RCDET_","_RCDT1_","_RCDT2_",0,"_RCDONLY_")" ;PRCA*4.5*321 added RCDONLY
 . S ZTDESC="AR - EDI LOCKBOX EFT DAILY ACTIVITY REPORT"
 . S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 . S ZTSAVE("^TMP(""RCDPEU1"",$J,")="" ; PRCA*4.5*326
 . ;
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 . K ZTSK,IO("Q")
 . D HOME^%ZIS
 ;
 U IO
 D EN(RCDET,RCDT1,RCDT2,RCLSTMGR,RCDONLY)
 Q
 ;
DBTONLY() ; Allows the user to select filter to only show EFTs with debits
 ; PRCA*4.5*321 Added subroutine
 ; Input:   None
 ; Returns: 0       - All EFTs to display
 ;          1       - Only EFTs with debits to be displayed
 ;         -1       - User up-arrowed or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR("A")="Show EFTs with debits only? "
 S DIR(0)="SA^Y:YES;N:NO"
 S DIR("B")="NO"
 S DIR("?",1)="Enter 'YES' to only show EFTs with a debit flag of 'D'."
 S DIR("?")="Enter 'NO' to show all EFTs."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q $E(Y,1)="Y"
 ;
RTYPE() ; Allows the user to select the report type (Summary/Detail)
 ; Input:   None
 ; Returns: 0       - Summary Display
 ;          1       - Detail Display
 ;         -1       - User up-arrowed or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR("A")="(S)UMMARY OR (D)ETAIL?: "
 S DIR(0)="SA^S:SUMMARY TOTALS ONLY;D:DETAIL AND TOTALS"
 S DIR("B")="D"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q Y="D"
 ;
DTRANGE(STDATE,ENDDATE) ; Allows the user to select the date range to by used
 ; Input:   None
 ; Output:  STDATE  = Internal Fileman Date to start at
 ;          ENDDATE - Internal Fileman Date to end at
 ; Returns: 0 - User up-arrowed or timed out, 1 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR("?")="Enter the earliest date of receipt of deposit to include on the report."
 S DIR(0)="DAO^:"_DT_":APE"
 S DIR("A")="START DATE: "
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)!(Y="") 0
 S STDATE=Y
 K DIR
 S DIR("?")="Enter the latest date of receipt of deposit to include on the report."
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_RCDT1_":"_DT_":APE",DIR("A")="END DATE: "
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)!(Y="") 0
 S ENDDATE=Y
 Q 1
 ;
EN(RCDET,RCDT1,RCDT2,RCLSTMGR,DONLY) ; Entry point for report, might be queued
 ; Input:   RCDET       - 1 - Detail Report, 0 - Summary
 ;          RCDT1       - Internal Fileman Start date
 ;          RCDT2       - Internal Fileman End date
 ;          RCLSTMGR    - 1 display in list manager, 0 otherwise
 ;                        Optional, defaults to 0
 ;          DONLY       - 1 only display EFTs with a debit flag of 'D'
 ;                        0 display all EFTs
 ;          RCPAY       - A - All Payers selected
 ;                      - R - Range of Payers
 ;                      - S - Specific payers
 ;          RCPYRSEL    - Array of selected payers (Only present if A1=3 above
 ;          VAUTD       - 1 - All selected divisions OR an array of selected divisions
 N DFLG,DTADD,IEN3443,IEN34431,INPUT,RCFLG,RCJOB,RCT,XX,Z   ; PRCA*4.5*321 Added DFLG
 N:$G(ZTSK) ZTSTOP                          ; Job was tasked, ZTSTOP = flag to stop
 S:'$D(RCLSTMGR) RCLSTMGR=0
 S RCPAY=$G(RCPAY,"A") ; PRCA*4.5*326
 ;
 S XX=$S(RCLSTMGR:1,1:0)
 S INPUT=XX_"^"_RCLSTMGR_"^"_+RCDET
 S RCJOB=$J
 K ^TMP("RCDAILYACT",$J)
 K ^TMP($J,"TOTALS")                        ; Initialize Totals temp workspace
 ;
 ; Loop through all of the EDI LOCKBOX DEPOSIT records in the selected date
 ; range and add any that pass the payer and division filters into ^TMP
 ; by the internal date added
 S DTADD=RCDT1-.0001,RCT=0
 S $P(INPUT,"^",4)=0                        ; Current Page Number
 S $P(INPUT,"^",5)=0                        ; Stop Flag
 S $P(INPUT,"^",10)=DONLY
 F  D  Q:'DTADD  Q:DTADD>(RCDT2_".9999")  Q:$P(INPUT,"^",5)=1
 . S DTADD=$O(^RCY(344.3,"ARECDT",DTADD))
 . Q:'DTADD
 . Q:DTADD>(RCDT2_".9999")
 . S IEN3443=0
 . F  D  Q:'IEN3443  Q:$P(INPUT,"^",5)=1
 . . S IEN3443=$O(^RCY(344.3,"ARECDT",DTADD,IEN3443))
 . . Q:'IEN3443
 . . S IEN34431="",RCFLG=0
 . . F  D  Q:IEN34431=""
 . . . S IEN34431=$O(^RCY(344.31,"B",IEN3443,IEN34431))
 . . . Q:IEN34431=""
 . . . ;
 . . . I RCPAY'="A" D  Q:'XX
 . . . . S XX=$$ISSEL^RCDPEU1(344.31,IEN34431)          ; PRCA*4.5*326 Check if payer was selected
 . . . I RCTYPE'="A" D  Q:'XX                           ; If all of a given type of payer selected
 . . . . S XX=$$ISTYPE^RCDPEU1(344.31,IEN34431,RCTYPE)  ;  check that payer matches type
 . . . ;
 . . . Q:'$$CHKDIV(IEN34431,0,.VAUTD)       ; Not a selected station/division
 . . . ;
 . . . ; PRCA*4.5*321 Added filter for Debit EFTs Only below
 . . . I DONLY D  Q:DFLG'="D"               ; Not an EFT with a debit flag of 'D'
 . . . . S DFLG=$$GET1^DIQ(344.31,IEN34431,3,"E")
 . . . S RCFLG=1
 . . . S ^TMP("RCDAILYACT",$J,DTADD\1,IEN3443,"EFT",IEN34431)=""
 . . ;
 . . S:RCFLG ^TMP("RCDAILYACT",$J,DTADD\1,IEN3443)=""
 . . S RCT=RCT+1                            ; Current Record Count
 . . ;
 . . ; Check for user stopped every 100 records
 . . I '(RCT#100),$D(ZTQUEUED),$$S^%ZTLOAD D  Q
 . . . S ZTSTOP=1
 . . . S $P(INPUT,"^",5)=1                  ; Stop now
 . . . K ZTREQ
 ;
 I '$P(INPUT,"^",5) D
 . S $P(INPUT,"^",6)=RCDT1                  ; Start of Date Range
 . S $P(INPUT,"^",7)=RCDT2                  ; End of Date Range
 . D RPT1(.INPUT)
 D ENQ(INPUT)
 Q
 ;
ENQ(INPUT) ; Clean up
 ; Input:   INPUT       - A1^A2^A3^...^A8 Where:
 ;                         A1 - 1 if Detail report, 0 if summary report
 ;                         A2 - 1 if displaying to Listman, 0 otherwise
 ;                         A3 - 0 if NOT called from Nightly Process, 1 otherwise
 ;                         A4 - Current Page Number
 ;                         A5 - Stop Flag
 ;                         A6 - Start of Date Range
 ;                         A7 - End of Date Range
 ;          ZTQUEUED    - Defined if Joh was queued
 ; Output:  ZTREQ       - "@" Only returned if ZTQUEUED is defined
 N XX,YY,ZZ
 K ^TMP($J,"DEPERRS"),^TMP($J,"ONEDEP")  ; PRCA*4.5*321
 K ^TMP("RCDAILYACT",$J),^TMP("RCSELPAY",$J)
 K ^TMP($J,"TOTALS")
 K ^TMP("RCDPEU1",$J) ; PRCA*4.5*326
 I '$D(ZTQUEUED) D
 . D ^%ZISC
 . S XX=$P(INPUT,"^",1)                     ; Nightly Process Flag
 . S YY=$P(INPUT,"^",5)                     ; Stop Flag
 . S ZZ=$P(INPUT,"^",4)                     ; Current Page Number
 . I 'XX,'YY,ZZ D
 . . S XX=""
 . . D ASK^RCDPEARL(.XX)
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
RPT1(INPUT) ;EP from RCDPEM1 (Nightly Process)
 ; Output the report
 ; Input:   INPUT       - A1^A2^A3^...^An Where:
 ;                         A1 - 1 if called from Nightly Process, 0 otherwise
 ;                         A2 - 1 if displaying to Listman, 0 otherwise
 ;                         A4 - Current Page Number
 ;                         A5 - Stop Flag
 ;                         A6 - Start of Date Range
 ;                         A7 - End of Date Range
 ;          ^TMP(B1,$J,B2,B3)          = "" - Array of record IENs in 344.3 in date range
 ;                                            and for selected payer(s) and division(s)
 ;          ^TMP(B1,$J,B2,B3,"EFT",B4) = "" - Array of record IENS in 344.31 for above Where:
 ;                        B1 - "RCDAILYACT"
 ;                        B2 - Internal Date from DATE/TIME ADDED (344.3, .13)
 ;                        B3 - Internal IEN for 344.3
 ;                        B4 - Internal IEN for file 344.31
 ; Output:  INPUT       - A1^A2^A3^...^An - The following pieces may be updated
 ;                         A4 - Current Page Number
 ;                         A5 - Stop Flag
 ;
 N CURPG,DETL,DTADD,DTEND,DTST,HDR1,LSTMAN,NJ
 S DETL=$P(INPUT,"^",3)                     ; Detail Report flag
 S LSTMAN=$P(INPUT,"^",2)                   ; Listman flag
 S NJ=$P(INPUT,"^",1)                       ; Nightly Process flag
 S CURPG=$P(INPUT,"^",4)                    ; Current Page Number
 S DTST=$P(INPUT,"^",6)                     ; Date Range Start
 S DTEND=$P(INPUT,"^",7)                    ; Date Range End
 S $P(INPUT,"^",8)=0                        ; Current line counter
 S DTADD=""
 F  D  Q:DTADD=""  Q:$P(INPUT,"^",5)=1
 . S DTADD=$O(^TMP("RCDAILYACT",$J,DTADD))
 . Q:DTADD=""
 . ;
 . I 'LSTMAN,DETL D  Q:$P(INPUT,"^",5)=1               ; PRCA*4.5*321
 . . D HDR^RCDPEDA3(.INPUT)
 . ;
 . I DETL D                                   ; Detail Report
 . . S HDR1="DATE EFT DEPOSIT RECEIVED: "_$$FMTE^XLFDT(DTADD,"2Z")  ; PRCA*4.5*321 moved location
 . . S HDR1=$J("",80-$L(HDR1)\2)_HDR1         ; Center it
 . . D SL^RCDPEDA3(.INPUT,HDR1)
 . . D SL^RCDPEDA3(.INPUT," ")
 . S $P(INPUT,"^",9)=DTADD
 . D RPT2^RCDPEDA2(.INPUT)                  ; Process all 344.3 records found
 . Q:$P(INPUT,"^",5)=1                      ; User quit
 . D TOTSDAY^RCDPEDA3(.INPUT)               ; Display Totals for Date
 ;
 Q:$P(INPUT,"^",5)=1                        ; User quit
 D TOTSF^RCDPEDA3(.INPUT)                   ; Display Final Totals
 D SL^RCDPEDA3(.INPUT,$$ENDORPRT^RCDPEARL)  ; Display End of Report
 Q
 ;
CHKDIV(IEN,FLG,VAUTD) ;
 ; IEN - ien in file 344.31 or 344.4
 ; FLG - 0 if IEN contains ien in file 344.31, 1 if IEN contains ien in file 344.4
 ; VAUTD - array of selected divisions from DIVISION^VAUTOMA API call
 ; returns 1 if division associated with an entry in 344.31 is on the list in VAUTD
 ; returns 0 otherwise
 N ERA,I,NAME,RCSTA,RES
 S RES=0
 I VAUTD=1 S RES=1 G CHKDIVX
 I 'IEN G CHKDIVX
 S ERA=$S(FLG:IEN,1:$P($G(^RCY(344.31,IEN,0)),U,10))
 S RCSTA=$$ERASTA^RCDPEM3(ERA),NAME=$P(RCSTA,U)
 I NAME="UNKNOWN" G CHKDIVX
 S I=0 I 'VAUTD F  S I=$O(VAUTD(I)) Q:'I!RES  I NAME=VAUTD(I) S RES=1
CHKDIVX ;
 Q RES
