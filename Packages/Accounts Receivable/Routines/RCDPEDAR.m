RCDPEDAR ;ALB/TMK - ACTIVITY REPORT ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,276,284,283,298,304,318,321,326,432,439**;Mar 20, 1995;Build 29
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
RPT ; Daily Activity Rpt On Demand
 N POP,RCDET,RCDIV,RCDONLY,RCDT1,RCDT2,RCEXCEL,RCEXSTOP,RCHDR,RCINC,RCLSTMGR,RCNJ  ;PRCA*4.5*439
 N RCPAR,RCPAY,RCPYRSEL,RCRANGE,RCSTOP,RCTMPND,RCTYPE,RCUNBAL,VAUTD,X,XX,Y,%ZIS
 S RCNJ=0                                   ; Not the nightly job, user interactions
 D DIVISION^VAUTOMA                         ; IA 664 Select Division/Station - sets VAUTD
 I 'VAUTD,($D(VAUTD)'=11) Q
 S RCDET=$$RTYPE^RCDPEDA4()                 ; Select Report Type (Summary/Detail)
 Q:RCDET=-1
 S XX=$$DTRANGE^RCDPEDA4(.RCDT1,.RCDT2)     ; Select Date Range to be used
 Q:'XX
 ;
 ; PRCA*4.5*326 - Ask to show Medical/Pharmacy Tricare CHAMPVA or All
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
 S RCDONLY=$$DBTONLY^RCDPEDA4()             ; Debit only filter   ;PRCA*4.5*321
 Q:RCDONLY=-1                               ; '^' or timeout
 ;
 S RCUNBAL=$$UNBALONLY^RCDPEDA4()           ; Unbalanced only filter   ;Add new filter, PRCA*4.5*439
 Q:RCUNBAL=-1                               ; '^' or timeout
 ;
 ; PRCA*4.5*439 Add Excel, begin
 ; if user selected detail report (RCDET=1), offer option of Excel format
 S RCEXCEL=0,RCEXSTOP=0 I RCDET D  Q:RCEXSTOP
 . S RCEXCEL=$$DISPTY^RCDPEM3() I RCEXCEL<0 S RCEXSTOP=1 Q
 . ; display device info about Excel format, set ListMan flag to prevent question
 . I RCEXCEL S RCLSTMGR="^" D INFO^RCDPEM6
 . I $D(DUOUT)!$D(DTOUT) S RCEXSTOP=1 Q
 ;
 ; if not output to Excel ask for ListMan display, quit if timeout or "^"
 S RCLSTMGR=0 I 'RCEXCEL S RCLSTMGR=$$ASKLM^RCDPEARL Q:RCLSTMGR<0
 ; PRCA*4.5*439 Add Excel, end
 ;
 I RCLSTMGR=1 D  Q                          ; ListMan Template format, put in array
 . S RCTMPND="RCDPE_DAR"
 . K ^TMP($J,RCTMPND)
 . D EN(RCDET,RCDT1,RCDT2,RCLSTMGR,RCDONLY,0,RCUNBAL)   ; PRCA*4.5*439 RCUNBAL
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
 . S ZTRTN="EN^RCDPEDAR("_RCDET_","_RCDT1_","_RCDT2_",0,"_RCDONLY_",0,"_RCUNBAL_")" ;PRCA*4.5*321 added RCDONLY ;PRCA*4.5*439 added RCUNBAL
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
 D EN(RCDET,RCDT1,RCDT2,RCLSTMGR,RCDONLY,RCEXCEL,RCUNBAL)    ;PRCA*4.5*439 Add RCEXCEL, added RCUNBAL
 Q
 ;
EN(RCDET,RCDT1,RCDT2,RCLSTMGR,DONLY,RCEXCEL,RCUNBAL) ; Entry point for report, might be queued
 ; Input:   RCDET       - 1 - Detail Report, 0 - Summary
 ;          RCDT1       - Internal Fileman Start date
 ;          RCDT2       - Internal Fileman End date
 ;          RCLSTMGR    - 1 display in list manager, 0 otherwise
 ;                        Optional, defaults to 0
 ;          DONLY       - 1 only display EFTs with a debit flag of 'D'
 ;                        0 display all EFTs
 ;          RCEXCEL     - 1 display in Excel format, 0 otherwise  ;PRCA*4.5*439 Add Excel
 ;                        Optional, defaults to 0
 ;          RCUNBAL     - A - All, B - Balanced, U - Unbalanced ; PRCA*4.5*439 Add Unbalanced/Balanced selection
 ;                        Optional, defaults to All
 ;          RCPAY       - A - All Payers selected
 ;                      - R - Range of Payers
 ;                      - S - Specific payers
 ;          RCPYRSEL    - Array of selected payers (Only present if A1=3 above
 ;          VAUTD       - 1 - All selected divisions OR an array of selected divisions
 N DFLG,DTADD,IEN3443,IEN34431,INPUT,RCDBAL,RCDBALOK,RCFLG,RCJOB,RCT,XX,Z   ; PRCA*4.5*321 Added DFLG ; PRCA*4.5*439 Added RCDBAL,RCDBALOK
 N:$G(ZTSK) ZTSTOP                          ; Job was tasked, ZTSTOP = flag to stop
 S:'$D(RCLSTMGR) RCLSTMGR=0
 S:'$D(RCEXCEL) RCEXCEL=0  ;PRCA*4.5*439 Add Excel
 S:'$D(RCUNBAL) RCUNBAL="A"  ;PRCA*4.5*439 Add Unbalanced/Balanced selection
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
 S $P(INPUT,"^",11)=RCUNBAL                 ; User selection: A - All, B - Balanced, U - Unbalanced  PRCA*4.5*439
 F  D  Q:'DTADD  Q:DTADD>(RCDT2_".9999")  Q:$P(INPUT,"^",5)=1
 . S DTADD=$O(^RCY(344.3,"ARECDT",DTADD))
 . Q:'DTADD
 . Q:DTADD>(RCDT2_".9999")
 . S IEN3443=0
 . F  D  Q:'IEN3443  Q:$P(INPUT,"^",5)=1
 . . S IEN3443=$O(^RCY(344.3,"ARECDT",DTADD,IEN3443))
 . . Q:'IEN3443
 . . ;Add block of code to check for balanced or out of balance deposits PRCA*4.5*439
 . . ;Check user's filter selection, match to balance state of deposit
 . . ;Only check for balanced or not if user did not select 'A' for ALL.
 . . I RCUNBAL'="A" S RCDBALOK=1 D  I 'RCDBALOK Q   ;If deposit balance/unbalance doesn't match user selection, quit to ignore this deposit.
 . . . S RCDBAL=$$DEPBAL^RCDPEDA4(IEN3443)  ;Check deposit balance. Compare to EFT totals. 1 if in balance, 0 if out of balance.
 . . . ; If user selected unbalanced deposits in filter selection, skip balanced deposits by setting okay flag to zero (RCDBALOK).
 . . . I RCUNBAL="U" S:RCDBAL RCDBALOK=0 Q
 . . . ; If user selected balanced deposits in filter selection, skip unbalanced deposits by setting okay flag to zero (RCDBALOK).
 . . . I RCUNBAL="B" S:'RCDBAL RCDBALOK=0 Q 
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
 . I 'RCEXCEL D RPT1(.INPUT)
 . I RCEXCEL D EXCEL(INPUT)                 ; Print in Excel format ; PRCA*4.5*439 Add EXCEL
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
 ;
EXCEL(INPUT) ; Loop to print Excel Format ;PRCA*4.5*439 Add EXCEL tag
 ; Input:   INPUT       - A1^A2^A3^...^An Where:
 ;                         A1 - 1 if called from Nightly Process, 0 otherwise
 ;                         A2 - 1 if displaying to Listman, 0 otherwise
 ;                         A4 - Current Page Number
 ;                         A5 - Stop Flag
 ;                         A6 - Start of Date Range
 ;                         A7 - End of Date Range
 ; Output in Excel Format
 D EXCELHDR^RCDPEDA4
 N DTADD,IEN3443,IEN34431
 ;
 S DTADD=""
 F  D  Q:DTADD=""  Q:$P(INPUT,"^",5)=1
 . S DTADD=$O(^TMP("RCDAILYACT",$J,DTADD)) Q:DTADD=""
 . S IEN3443=""
 . F  S IEN3443=$O(^TMP("RCDAILYACT",$J,DTADD,IEN3443)) Q:'IEN3443  D
 . . S IEN34431=""
 . . F  S IEN34431=$O(^TMP("RCDAILYACT",$J,DTADD,IEN3443,"EFT",IEN34431)) Q:'IEN34431  D
 . . . D EXCEL2(IEN3443,IEN34431)
 ;
 W !!,"*** END OF REPORT ***",!
 Q
 ;
EXCEL2(IEN3443,IEN34431)  ; Print lines in Excel format ;PRCA*4.5*439 Add EXCEL3 tag
 ; Output in Excel foramt
 ; Input:   IEN3443    - Internal IEN for 344.3
 ;          IEN34431   - Internal IEN for file 344.31
 ;
 N DEPDT,DEPNUM,DFLG,IEN344,MDT,MULT,PAMT,PAYER,PAYID,RCDBAL,RCDEBIT,TOTDEP,TRDOC,TRDOCS,TRSTAT,X,XX,YY
 ;PRCA*4.5*380 - Check for multiple mail messages on this deposit
 S:$O(^RCY(344.3,IEN3443,3,0))'="" MULT="*"
 ;PRCA*4.5*380 - Check if prior deposits exist
 S DEPNUM=$$GET1^DIQ(344.3,IEN3443,.06,"I"),DEPDT=$$GET1^DIQ(344.3,IEN3443,.07,"I")      ; Deposit Number and Deposit Date
 S XX=$O(^RCY(344.3,"ADEP2",DEPNUM,DEPDT,0)),XX=$O(^RCY(344.3,"ADEP2",DEPNUM,DEPDT,XX))
 S:XX'="" MULT=$G(MULT)_"+"
 S TOTDEP=$$GET1^DIQ(344.3,IEN3443,.08,"I")                                              ; Total Deposit
 S RCDBAL=$$DEPBAL^RCDPEDA4(IEN3443),RCDBAL=$S(RCDBAL:"",1:"UNBALANCED")                 ; Is Deposit balanceD, 0-No, 1-Yes
 ;PRCA*4.5*380 - Include multi-mail message indicator with date
 W !,DEPNUM,"^",RCDBAL,"^",$$FMTE^XLFDT(DEPDT\1,"2Z"),$G(MULT),"^",TOTDEP,"^"   ;Deposit #^Unbalanced Indicator^Deposit Date_Multi Flag^Total Deposit
 S YY=$$GET1^DIQ(344.31,IEN34431,3,"E")             ; Debit/Credit flag ; PRCA*4.5*321 added line
 S DFLG=$S(YY="D":1,1:0)                            ; PRCA*4.5*321 added line
 S PAMT=$$GET1^DIQ(344.31,IEN34431,.07,"I")         ; Amount of Payment
 S XX=+$$GET1^DIQ(344.31,IEN34431,.09,"I")          ; Receipt # from 344.31
 S TRDOC=$$GET1^DIQ(344,XX,200,"I")                 ; FMS Document #
 I $$GET1^DIQ(344,XX,201,"I") S X="ACCEPTED"        ; Default ON-LINE ENTRY status to accepted - PRCA*4.5*326
 E  S X=$S(TRDOC'="":$$STATUS^GECSSGET(TRDOC),1:"") ; PRCA*4.5*326
 S XX=$S(X="":"",X=-1:"NO FMS DOC",1:$E($P(X," ",1),1,10))
 W XX,"^"
 S XX=$$GET1^DIQ(344.31,IEN34431,.01,"E")           ; EFT Transaction detail - PRCA*4.5*326
 W XX,"^"
 S XX=$$GET1^DIQ(344.31,IEN34431,.12,"I")           ; Date Claims Paid
 W $$FMTE^XLFDT(XX\1,"2Z"),"^"
 S XX=$$GET1^DIQ(344.31,IEN34431,.07,"I")           ; Amount of Payment
 S RCDEBIT=$$GET1^DIQ(344.31,IEN34431,3,"E")        ; Check for Debit
 I '($E(XX)="-") S XX=$S(RCDEBIT="D":"-",1:"")_XX   ; If Debit, add minus sign
 W XX,"^"
 ;
 S XX=$$GET1^DIQ(344.31,IEN34431,.08,"I")           ; Match Status, Internal
 S YY=$$GET1^DIQ(344.31,IEN34431,.1,"I")            ; ERA IEN
 S MDT=""
 I XX=1 S MDT=$$MATCHDT^RCDPEWL7(IEN34431)          ; PRCA*4.5*326 - Date matched to ERA
 S XX=$$GET1^DIQ(344.31,IEN34431,.08,"E")           ; Match Status, External
 W XX,"^",YY,"^",MDT,"^"                            ; Match Status^ERA^Date Matched
 S XX=$$GET1^DIQ(344.31,IEN34431,.04,"I")           ; Trace Number
 W XX,"^"
 S IEN344=$$GET1^DIQ(344.31,IEN34431,.09,"I")       ; Receipt IEN
 S XX=""
 I IEN344'="" S XX=$$GET1^DIQ(344,IEN344,200,"I")   ; FMS Document Number
 W XX,"^"
 S PAYER=$$GET1^DIQ(344.31,IEN34431,.02,"I")        ; Payer Name
 S:PAYER="" PAYER="NO PAYER NAME RECEIVED"
 S PAYID=$$GET1^DIQ(344.31,IEN34431,.03,"I")        ; Payer ID (TIN)
 W PAYER,"^",PAYID,"^"                              ; Payer Name^Payer ID (TIN)
 ; Get TR #s
 D EXCELTR(IEN344,IEN34431,.TRDOCS,.TRSTAT) ; Get comma delimited list of TR document #s and status
 W TRDOCS,"^"
 S XX=""
 I IEN344'="" S XX=$$GET1^DIQ(344,IEN344,.01,"I")   ; Receipt Number
 W XX,"^"
 W TRSTAT
 Q
 ;
EXCELTR(IEN344,IEN34431,TRDOCS,TRSTAT) ;Get TR #s  ;PRCA*4.5*439 Add EXCELTR tag
 ; Input:   IEN344     - Internal IEN for file 344
 ;          IEN34431   - Internal IEN for file 344.31
 ;          TRDOCS     - Variable to hold list of TR document numbers
 ;
 ; Output:  TRDOCS     - List of TR document numbers
 ;
 N IEN3444,IENS,RECEIPT,TRDOC,XX
 S TRDOCS="",TRSTAT=""                            ; Initialize list of TR document numbers and status
 S IEN3444=$$GET1^DIQ(344.31,IEN34431,.1,"I")     ; Internal IEN for for 344.4
 S RECEIPT=+$$GET1^DIQ(344.31,IEN34431,.09,"I")   ; Receipt # from 344.31
 Q:'IEN3444
 I $L(RECEIPT) D                                  ; If a receipt exists, get FMS doc # and status
 . S TRDOC=$TR($$GET1^DIQ(344,RECEIPT,200,"I")," ")           ; FMS Document #
 . I $$GET1^DIQ(344,RECEIPT,201,"I") S TRSTAT="ACCEPTED"      ; Default ON-LINE ENTRY status to accepted - PRCA*4.5*326
 . E  S TRSTAT=$S(TRDOC'="":$$STATUS^GECSSGET(TRDOC),1:"")
 ;
 S TRDOC=""
 S RECEIPT=$$GET1^DIQ(344.4,IEN3444,.08,"I")      ; Receipt # from 344.4
 I RECEIPT="" Q
 S TRDOC=$TR($$GET1^DIQ(344,RECEIPT,200,"I")," ") ; FMS Document #
 I TRDOC="" Q
 S TRDOCS=TRDOC                                   ; First TR Document #
 S XX=""
 F  D  Q:XX=""                                    ; If EFT is matched to an ERA, look for additional TR Documents
 . S XX=$O(^RCY(344.4,IEN3444,8,XX))
 . Q:XX=""
 . S IENS=XX_","_IEN3444_","
 . S RECEIPT=$$GET1^DIQ(344.48,IENS,.01,"I")      ; Other receipt numbers
 . I RECEIPT="" Q
 . S TRDOC=$TR($$GET1^DIQ(344,RECEIPT,200,"I")," ")  ; FMS Document #
 . Q:TRDOC=""
 . S TRDOCS=TRDOCS_","_TRDOC                      ; Comma delimited list of TR Document #s
 Q
 ;
EXCELRST(IEN344,TRDOCS,TRSTAT)                ; Get Deposit Receipt Status  ;PRCA*4.5*439 Add EXCELRST tag
 ; Input:   IEN344     - Internal IEN for 344
 ;          TRDOCS     - Variable to hold list of TR document numbers
 ;          TRSTAT     - Variable to hold Deposit Receipt Status
 ;
 ; Output:  TRSTAT     - Deposit Receipt Status
 ;
 N TRDOC,X
 S TRSTAT=""                                                   ; Initialize status to null
 S TRDOC=$P(TRDOCS,",",1)                                      ; Get first TR document, Deposit Receipt Status is null
 Q:'$L(TRDOC)                                                  ; Quit if there isn't a TR document
 I $$GET1^DIQ(344,IEN344,201,"I") S X="ACCEPTED"               ; Default ON-LINE ENTRY status to accepted - PRCA*4.5*326
 E  S X=$S(TRDOC'="":$$STATUS^GECSSGET(TRDOC),1:"")            ; PRCA*4.5*326
 S TRSTAT=$S(X="":"",X=-1:"NO FMS DOC",1:$E($P(X," ",1),1,10)) ; FMS Document Status for EFT
 Q
 ; Moved tags RCDPEDA4: RTYPE, DTRANGE, DBTONLY, EXCELHDR; PRCA*4.5*439
