RCDPEDAR ;ALB/TMK - ACTIVITY REPORT ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,276,284,283,298,304,318**;Mar 20, 1995;Build 37
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
RPT ; Daily Activity Rpt On Demand
 N POP,RCDET,RCDIV,RCDT1,RCDT2,RCHDR,RCINC,RCLSTMGR,RCNP,RCNJ
 N RCPYRSEL,RCRANGE,RCSTOP,RCTMPND,VAUTD,X,XX,Y,%ZIS
 S RCNJ=0                                   ; Not the nightly job, user interactions
 D DIVISION^VAUTOMA                         ; IA 664 Select Division/Station - sets VAUTD
 I 'VAUTD,($D(VAUTD)'=11) Q
 S RCDET=$$RTYPE()                          ; Select Report Type (Summary/Detail)
 Q:RCDET=-1
 S XX=$$DTRANGE(.RCDT1,.RCDT2)              ; Select Date Range to be used
 Q:'XX
 ;
 ; Get insurance company to be used as filter
 ; PRCA*4.5*284 - RCNP is Type of Response (1=Range,2=All,3=Specific) ^ From Range^ Thru Range
 S RCNP=$$GETPAY^RCDPEM9(344.31)
 Q:+RCNP=-1                                 ; No Insurance Company selected
 S RCLSTMGR=$$ASKLM^RCDPEARL                ; Ask to Display in Listman Template
 Q:RCLSTMGR<0                               ; '^' or timeout
 ;
 I RCLSTMGR=1 D  Q                          ; ListMan Template format, put in array
 . S RCTMPND="RCDPE_DAR"
 . K ^TMP($J,RCTMPND)
 . D EN(RCDET,RCDT1,RCDT2,RCLSTMGR)
 . D LMHDR^RCDPEDA3(.RCSTOP,RCDET,1,RCDT1,RCDT2,.RCHDR)
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
 . S ZTRTN="EN^RCDPEDAR("_RCDET_","_RCDT1_","_RCDT2_")"
 . S ZTDESC="AR - EDI LOCKBOX EFT DAILY ACTIVITY REPORT"
 . S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 . ;
 . ; PRCA*4.5*284 - Because TMP global may be on another server, save off specific payers in local
 . M RCPYRSEL=^TMP("RCSELPAY",$J)
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 . K ZTSK,IO("Q")
 . D HOME^%ZIS
 ;
 U IO
 D EN(RCDET,RCDT1,RCDT2,RCLSTMGR)
 Q
 ;
RTYPE() ; Allows the user to select the report type (Summary/Detail)
 ; Input:   None
 ; Returns: 0       - Summary Display
 ;          1       - Detail Display
 ;         -1       - User up-arrowed or timed out
 N DIR,DTOUT,DUOUT
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
 N DIR,DTOUT,DUOUT
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
EN(RCDET,RCDT1,RCDT2,RCLSTMGR) ; Entry point for report, might be queued
 ; Input:   RCDET       - 1 - Detail Report, 0 - Summary
 ;          RCDT1       - Internal Fileman Start date
 ;          RCDT2       - Internal Fileman End date
 ;          RCLSTMGR    - 1 display in list manager, 0 otherwise
 ;                        Optional, defaults to 0
 ;          RCNP        - A1^A2^A3 Where:
 ;                           A1 - 1 - Range of Payers
 ;                                2 - All Payers selected
 ;                                3 - Specific payers
 ;                           A2 - From Range (When a from/thru range is selected by user)
 ;                           A3 - Thru Range (When a from/thru range is selected by user)
 ;          RCPYRSEL    - Array of selected payers (Only present if A1=3 above
 ;          VAUTD       - 1 - All selected divisions OR an array of selected divisions
 N DTADD,IEN3443,IEN34431,INPUT,RCFLG,RCJOB,RCT,XX,Z
 N:$G(ZTSK) ZTSTOP                          ; Job was tasked, ZTSTOP = flag to stop
 S:'$D(RCLSTMGR) RCLSTMGR=0
 ;
 ; PRCA*4.5*284 - Queued job needs to reload payer selection list
 I $D(RCPYRSEL) D
 . K ^TMP("RCSELPAY",$J)
 . M ^TMP("RCSELPAY",$J)=RCPYRSEL
 ;
 S XX=$S(RCLSTMGR:1,1:0)
 S INPUT=XX_"^"_RCLSTMGR_"^"_+RCDET
 S RCNP=+RCNP,RCJOB=$J
 K ^TMP("RCDAILYACT",$J)
 K ^TMP($J,"TOTALS")                        ; Initialize Totals temp workspace
 ;
 ; Loop through all of the EDI LOCKBOX DEPOSIT records in the selected date
 ; range and add any that pass the payer and division filters into ^TMP
 ; by the internal date added
 S DTADD=RCDT1-.0001,RCT=0
 S $P(INPUT,"^",4)=0                        ; Current Page Number
 S $P(INPUT,"^",5)=0                        ; Stop Flag
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
 . . . Q:'$$CHKPYR(IEN34431,0,RCJOB,RCNP)   ; Not a selected payer PRCA*4.5(318 added ,RCNP
 . . . Q:'$$CHKDIV(IEN34431,0,.VAUTD)       ; Not a selected station/division
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
 K ^TMP("RCDAILYACT",$J),^TMP("RCSELPAY",$J)
 K ^TMP($J,"TOTALS")
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
 . ; If not being displayed in the list manager and either this is the initial
 . ; page header (RCPG=0) OR this wasn't called by the nightly job and we have
 . ; reached the end of the page, then print a page header
 . I 'LSTMAN,'CURPG!$S('NJ:($Y+5)>IOSL,1:0) D  Q:$P(INPUT,"^",5)=1
 . . D HDR^RCDPEDA3(.INPUT)
 . S HDR1="DATE EFT DEPOSIT RECEIVED: "_$$FMTE^XLFDT(DTADD,"2Z")
 . S HDR1=$J("",80-$L(HDR1)\2)_HDR1         ; Center it
 . Q:$P(INPUT,"^",5)=1                      ; User quit
 . I DETL D                                 ; Detail Report
 . . D SL^RCDPEDA3(.INPUT,HDR1)
 . . D SL^RCDPEDA3(.INPUT," ")
 . S $P(INPUT,"^",9)=DTADD
 . D RPT2^RCDPEDA2(.INPUT)                  ; Process all 344.3 records found
 . Q:$P(INPUT,"^",5)=1                      ; User quit
 . D TOTSDAY^RCDPEDA3(.INPUT)                        ; Display Totals for Date
 ;
 Q:$P(INPUT,"^",5)=1                        ; User quit
 D TOTSF^RCDPEDA3(.INPUT)                            ; Display Final Totals
 D SL^RCDPEDA3(.INPUT,$$ENDORPRT^RCDPEARL)           ; Display End of Report
 Q
 ;
CHKPYR(IEN,FLG,RCJOB,RCNP) ;EP from RCDPEAR2 PRCA*4.5*318 added RCNP parameter
 ; Checks to be sure the specified payer has been selected
 ; Input:   IEN     - Internal IEN into file 344.31 (EDI THIRD PARTY EFT DETAI) OR
 ;                                      file 344.4  (ELECTRONIC REMITTANCE ADVICE)
 ;                    Used to retrieve the payer
 ;          FLG     - 0 if IEN contains ien in file 344.31
 ;                    1 if IEN contains ien in file 344.4
 ;          RCJOB   - $J
 ;          RCNP    - 0 - Not passed
 ;                    1 - Range of Payers
 ;                    2 - All Payers selected
 ;                    3 - Specific payers
 ;                    Optional, defaults to 0
 ;          ^TMP("RCSELPAY",$J,CNT)=A1 Where:
 ;                                   CNT - Counter of the number of payers 1-n
 ;                                   A1  - Payer Name
 ; Returns: 1 if payer in 344.31/.02 or 344.4/.06 is in the list of selected payers
 ;            ^TMP("RCSELPAY",$J)
 ;          0 otherwise
 N RCPAY,RES,Z
 S:'$D(RCNP) RCNP=0                                 ; PRCA*4.5*318 added line
 S RCPAY=""
 I IEN D
 . I FLG S RCPAY=$$GET1^DIQ(344.4,IEN,.06,"I") Q    ; PAYMENT FROM field
 . S RCPAY=$$GET1^DIQ(344.31,IEN,.02,"I")           ; PAYER NAME field
 ;
 ; Include EFT with null Payer Names in reports for ALL payers - PRCA*4.5*298 
 I FLG=0,RCNP=2,RCPAY="" Q 1
 Q:RCPAY="" 0                                       ; No Payer to compare, invalid
 S Z=0,RES=0
 F  D  Q:Z=""  Q:RES
 . S Z=$O(^TMP("RCSELPAY",RCJOB,Z))
 . Q:Z=""
 . S:RCPAY=$G(^TMP("RCSELPAY",RCJOB,Z)) RES=1
 Q RES
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
