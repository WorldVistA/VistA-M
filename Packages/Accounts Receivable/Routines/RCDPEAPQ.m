RCDPEAPQ ;AITC/CJE - AUTO POST REPORT -CONTINUED ;Dec 20, 2014@18:42
 ;;4.5;Accounts Receivable;**298,304,326**;Mar 20, 1995;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 ; PRCA*4.5*326 - Routine created as an overflow for RCDPEAPP due to size
 Q
SAVE(ERAIEN,RCRZ,RCTYPE,APDATE,RCSORT) ; EP - Save to ^TMP global
 ; Input:   ERAIEN  - Internal IEN into file 344.4
 ;          RCRZ    - Internal IEN into sub-file 344.41
 ;          RCTYPE  - 'D' for detail report, 'S' for summary
 ;          APDATE  - Internal Auto-Posting date
 ;          RCSORT  - 0 - Sort by Payer Name, 1 - Sort by Payer TIN
 ;          STNAM   - Division Name (Primary Sort)
 ;          STNUM   - Station Number
 ;          ^TMP("RCDPEAPP2",$J,ERAIEN,RCRZ) - Array of detail lines
 ; Output:   GTOTAL  - A1^A2^A3^A4 Where:
 ;                     A1 - Total Count
 ;                     A2 - Total Original Amounts
 ;                     A3 - Total Payment Amounts
 ;                     A4 - Total Balance
 N BALANCE,BAMT,BILL,CLAIMIEN,COLLECT,DATE,EFTNUM,EOBIEN,ERADATE,ERANUM
 N PAMT,PAYIX1,PAYIX2,PAYNAM,PTNAM,RECEIPT,SEQ,SEQ1,SEQ2,STIX
 N TIN,TOTBAL,TOTBAMT,TOTPAMT,TRACE,XX
 S PAYNAM=$$GET1^DIQ(344.4,ERAIEN,.06,"E")          ; Payer Name from ERA Record
 S TIN=$$GET1^DIQ(344.4,ERAIEN,.03,"E")             ; Payer TIN from ERA Record
 S:RCSORT=0 PAYIX1=PAYNAM,PAYIX2=TIN
 S:RCSORT=1 PAYIX1=TIN,PAYIX2=PAYNAM
 S:PAYNAM="" PAYNAM="UNKNOWN"
 S STIX=STNAM_"/"_STNUM
 S (TOTBAMT,TOTBAL,TOTPAMT)=0
 ;
 ; Detail mode, get these extra fields
 I RCTYPE="D" D
 . S TRACE=$$GET1^DIQ(344.4,ERAIEN,.02,"E")         ; Trace Number
 . S PTNAM=$$PNM4^RCDPEWL1(ERAIEN,RCRZ)             ; Patient name from claim file #399
 . S ERANUM=$$GET1^DIQ(344.4,ERAIEN,.01,"E")        ; ERA Number
 . S ERADATE=$$GET1^DIQ(344.4,ERAIEN,.07,"I")       ; Date received (file date/time)
 . S ERADATE=$$FMTE^XLFDT(ERADATE,"2DZ")
 . S DATE=$$FMTE^XLFDT(APDATE,"2DZ")                ; Auto-Posting DATE
 . S EFTNUM=$O(^RCY(344.31,"AERA",ERANUM,""))       ; EFT Number
 . S:EFTNUM EFTNUM=$$GET1^DIQ(344.31,EFTNUM,.01,"E")
 . S XX=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN,.25,"I")  ; Receipt IEN
 . S RECEIPT=$$EXTERNAL^DILFD(344.41,.25,,XX)
 ;
 ; Get link to the scratchpad detail line. If the worklist detail records exist, 
 ; loop through the ones with the same prefix to get the data (this will have split-edits)
 S SEQ=$G(^TMP("RCDPEAPP2",$J,ERAIEN,RCRZ))
 I SEQ D
 . S SEQ1=SEQ
 . F  S SEQ1=$O(^RCY(344.49,ERAIEN,1,"B",SEQ1)) Q:'SEQ1!(SEQ1\1'=SEQ)  D
 . . S SEQ2=$O(^RCY(344.49,ERAIEN,1,"B",SEQ1,""))
 . . Q:SEQ2=""
 . . S (BAMT,BALANCE,COLLECT)=""
 . . S CLAIMIEN=$$GET1^DIQ(344.491,SEQ2_","_ERAIEN,.07,"I") ; AR Bill
 . . S BILL=$$GET1^DIQ(344.491,SEQ2_","_ERAIEN,.02,"I")     ; Claim #
 . . I BILL="" S BILL="<blank>"
 . . S PAMT=$$GET1^DIQ(344.491,SEQ2_","_ERAIEN,.06,"I")     ; Amount Paid on Claim
 . . ;
 . . ; If there is a claim, get billed amount and balance from the claim
 . . I CLAIMIEN D
 . . . S BAMT=$J(+$$GET1^DIQ(430,CLAIMIEN,3,"I"),0,2)       ; Original Amount
 . . . S BALANCE=$J(+$$GET1^DIQ(430,CLAIMIEN,71,"I"),0,2)   ; Principal Balance
 . . ;
 . . ; Update total amounts
 . . S TOTBAMT=TOTBAMT+BAMT,TOTBAL=TOTBAL+BALANCE,TOTPAMT=TOTPAMT+PAMT
 . . I RCTYPE="D" D                         ; Get extra data for detail report
 . . . S PTNAM=$S('CLAIMIEN:"",1:$$PNM4^RCDPEWL1(ERAIEN,RCRZ))
 . . . S:BAMT COLLECT=$J(PAMT/BAMT*100,0,2)_"%"
 . . . S CNT=CNT+1
 . . . S XX=STNAM_U_STNUM_U_$S(RCSORT:TIN_"/"_PAYNAM,1:PAYNAM_"/"_TIN)_U ; PRCA*4.5*326 add TIN
 . . . S XX=XX_PTNAM_U_ERANUM_U_ERADATE_U_DATE_U_EFTNUM
 . . . S XX=XX_U_RECEIPT_U_BILL_U_BAMT_U_PAMT_U_BALANCE_U_COLLECT_U_TRACE
 . . . S @GLOB@(STIX,PAYIX1,PAYIX2,CNT)=XX ; Add data for detail report
 ;
 ; If the worlist detail record does not exist, get data from ERA detail
 I 'SEQ D
 . S (TOTBAMT,TOTBAL,COLLECT,CLAIMIEN)=0
 . S EOBIEN=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN,.02,"I")  ; IEN for 361.1
 . S:EOBIEN CLAIMIEN=$$GET1^DIQ(361.1,EOBIEN,.01,"I")   ; IEN for 399
 . S BILL=$$EXTERNAL^DILFD(344.41,.02,,EOBIEN)          ; Bill Number
 . ;
 . ; Get Billed Amount from AR (Original Balance)
 . I CLAIMIEN D
 . . S TOTBAMT=$J(+$$GET1^DIQ(430,CLAIMIEN,3,"I"),0,2)   ; Original Amount
 . S TOTPAMT=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN,.03,"I") ; Amount Paid on Claim
 . ;
 . ; Balance from AR (Principal Balance)
 . S:CLAIMIEN TOTBAL=$J(+$$GET1^DIQ(430,CLAIMIEN,71,"I"),0,2) ; Principal Balance
 . ;
 . ; Detail Report, get extra data and then update the detail global
 . I RCTYPE="D" D
 . . S PTNAM=$S('CLAIMIEN:"",1:$$PNM4^RCDPEWL1(ERAIEN,RCRZ))
 . . S:TOTBAMT COLLECT=$J(TOTPAMT/TOTBAMT*100,0,2)_"%"
 . . S CNT=CNT+1
 . . S XX=STNAM_U_STNUM_U_PAYNAM_U_PTNAM_U_ERANUM_U_ERADATE_U_DATE_U_EFTNUM
 . . S XX=XX_U_RECEIPT_U_BILL_U_TOTBAMT_U_TOTPAMT_U_TOTBAL_U_COLLECT_U_TRACE
 . . S @GLOB@(STIX,PAYIX1,PAYIX2,CNT)=XX
 ;
 ; Update totals for individual division
 S $P(@GLOB@(STIX),U,1)=$P($G(@GLOB@(STIX)),U,1)+1
 S $P(@GLOB@(STIX),U,2)=$P($G(@GLOB@(STIX)),U,2)+TOTBAMT
 S $P(@GLOB@(STIX),U,3)=$P($G(@GLOB@(STIX)),U,3)+TOTPAMT
 S $P(@GLOB@(STIX),U,4)=$P($G(@GLOB@(STIX)),U,4)+TOTBAL
 ;
 ; Update totals for individual division/payer
 S $P(@GLOB@(STIX,PAYIX1,PAYIX2),U,1)=$P($G(@GLOB@(STIX,PAYIX1,PAYIX2)),U,1)+1
 S $P(@GLOB@(STIX,PAYIX1,PAYIX2),U,2)=$P($G(@GLOB@(STIX,PAYIX1,PAYIX2)),U,2)+TOTBAMT
 S $P(@GLOB@(STIX,PAYIX1,PAYIX2),U,3)=$P($G(@GLOB@(STIX,PAYIX1,PAYIX2)),U,3)+TOTPAMT
 S $P(@GLOB@(STIX,PAYIX1,PAYIX2),U,4)=$P($G(@GLOB@(STIX,PAYIX1,PAYIX2)),U,4)+TOTBAL
 ;
 ; Update grand totals
 S $P(GTOTAL,U,1)=$P($G(GTOTAL),U,1)+1,$P(GTOTAL,U,2)=$P($G(GTOTAL),U,2)+TOTBAMT
 S $P(GTOTAL,U,3)=$P($G(GTOTAL),U,3)+TOTPAMT,$P(GTOTAL,U,4)=$P($G(GTOTAL),U,4)+TOTBAL
 Q
 ;
ERASTA(ERAIEN,STA,STNUM,STNAM) ; EP - Get the station (Division) for this ERA
 ; Input:   ERAIEN  -
 ; Output:  STA     - Internal Division IEN
 ;          STNUM   - Division Number
 ;          STNAME  - Division Name
 N ERAEOB,ERABILL,FOUND,STAIEN
 S (ERAEOB,ERABILL,FOUND)=""
 S (STA,STNUM,STNAM)="UNKNOWN"
 D
 . S ERAEOB=$$GET1^DIQ(344.41,"1,"_ERAIEN_",",.02,"I") Q:'ERAEOB
 . S ERABILL=$$GET1^DIQ(361.1,ERAEOB,.01,"I") Q:'ERABILL
 . S STAIEN=$$GET1^DIQ(399,ERABILL,.22,"I") Q:'STAIEN
 . S STA=STAIEN
 . S STNAM=$$EXTERNAL^DILFD(399,.22,,STA)
 . S STNUM=$$GET1^DIQ(40.8,STAIEN,1,"E")
 Q
 ;
COMPILE ; Generate the Auto Posting report ^TMP array
 ; Input:   GLOB    - "^TMP("RCDPEAPP",$J)"
 ;          RCDISP  - 0 - Output to paper or screen, 1 - Output to Excel
 ;          RCDIV   - 1 - All divisions, 2 - Selected divisions
 ;          RCDIVS()- Array of selected divisions if RCDIV=2
 ;          RCRANGE - 1^Start Date^End Date
 ;          RCJOB   - $J
 ;          RCLAIM  - "M" - Medical Claims, "P" - Pharmacy Claims, "B" - Both
 ;          RCPAGE  - Initialized to 0
 ;          RCPARRAY- Array of selected payers 
 ;          RCPROG  - "RCDPEAPP"
 ;          RCSORT  - 0 - Sort by Payer Name, 1 - Sort by Payer TIN
 ;          RCWHICH - 1 - Filter by Payer Name, 2 - Filter by Payer TIN
 ;          RCTYPE  - 'D' for detail report, 'S' for summary
 ;          ^TMP("RCSELPAY",RCJOB) - Selected Payer Names or TINs
 ; Ouput:   GTOTAL  - A1^A2^A3^A4 Where:
 ;                     A1 - Total Count
 ;                     A2 - Total Original Amounts
 ;                     A3 - Total Payment Amounts
 ;                     A4 - Total Balance
 ;          ^TMP("RCSELPAY",RCJOB,A1)=A2/A3 Where:
 ;                      A1 - CTR
 ;                      A2 - Payer Name if RCWHICH=1 else Payer TIN
 ;                      A3 - Payer TIN if RCWHICH=1 else Payer Name
 N APDATE,CNT,END,ERAIEN,IEN,OKAY,RCECME,RCRZ,STA,STNAM,STNUM
 S APDATE=$$FMADD^XLFDT($P(RCRANGE,U,2),-1)
 S END=$P(RCRANGE,U,3),CNT=0
 ;
 ; Scan F index for ERA within date range
 F  S APDATE=$O(^RCY(344.4,"F",APDATE)) Q:'APDATE  Q:(APDATE\1)>END  D
 . S ERAIEN=""
 . F  S ERAIEN=$O(^RCY(344.4,"F",APDATE,ERAIEN)) Q:'ERAIEN  D
 . . ;
 . . ; Check division - Note return values are set to UNKNOWN if not available
 . . D ERASTA(ERAIEN,.STA,.STNUM,.STNAM)
 . . I RCDIV=2,'$D(RCDIVS(STA)) Q
 . . ;
 . . ; PRCA*4.5*304 - Check if we include this ERA in report
 . . I RCPAY="A",RCLAIM'="A" D  Q:'OKAY  ; PRCA*4.5*326 If all payers included, check by type
 . . . S OKAY=$$ISTYPE^RCDPEU1(344.4,ERAIEN,RCLAIM)
 . . ;
 . . ; Check Payer Name
 . . I RCPAY'="A" D  Q:'OKAY               ; PRCA*4.5*326 
 . . . S OKAY=$$ISSEL^RCDPEU1(344.4,ERAIEN)
 . . ;
 . . ; If it does not already exist for this ERA, build X-ref of ERA detail lines to the lines in the worklist
 . . I '$D(^TMP("RCDPEAPP2",$J,ERAIEN)) D BUILD(ERAIEN)
 . . ;
 . . ; Scan index for auto posted claim lines within the ERA
 . . S RCRZ=""
 . . F  S RCRZ=$O(^RCY(344.4,"F",APDATE,ERAIEN,RCRZ)) Q:'RCRZ  D
 . . . D SAVE(ERAIEN,RCRZ,RCTYPE,APDATE,RCSORT)     ; Save claim line detail to ^TMP global
 Q
 ;
BUILD(RCSCR) ; Build cross-reference of ERA detail lines to ERA scratch-pad lines
 ; Input:   RCSCR   - Internal IEN of file 344.4/344.49
 N CNT,ERADET,ERALINE,SUB,SUB1
 Q:'$G(RCSCR)                               ; No ERA IEN
 Q:'$D(^RCY(344.49,RCSCR))                  ; No scratch pad entry for ERA
 S SUB=0
 F  S SUB=$O(^RCY(344.49,RCSCR,1,"B",SUB)) Q:SUB=""  D
 . Q:SUB["."                                ; Skip split edit lines
 . S SUB1=$O(^RCY(344.49,RCSCR,1,"B",SUB,"")) ; Get scratchpad ^RCY(344.49,RCSCR,1) node
 . Q:'SUB1
 . ;
 . ; Get pointer back to ERA detail line(s) - This can be a set of comma pieces
 . S ERALINE=$P($G(^RCY(344.49,RCSCR,1,SUB1,0)),U,9)
 . F CNT=1:1:$L(ERALINE,",") D
 . . S ERADET=$P(ERALINE,",",CNT)
 . . I ERADET S ^TMP("RCDPEAPP2",$J,RCSCR,ERADET)=+$G(^RCY(344.49,RCSCR,1,SUB1,0))
 Q
