RCDPEAD ;ALB/PJH - AUTO DECREASE ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298,304,318,326,332,345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
EN ;Auto Decrease - applies to auto-posted claims only
 ;
 ; Begin PRCA*4.5*345
 N AD,AP,J,RCDAY
 S AP=$$GET1^DIQ(344.61,"1,",.02,"I")       ; Medical Claims Auto-Posting on/off
 S AD=$$GET1^DIQ(344.61,"1,",.03,"I")       ; Medical Claims Auto-Decrease on/off
 I AP,AD D                                  ; Attempt to Auto-Decrease Medical Claims w/Payments
 . S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",.04))
 . D EN1A(RCDAY,1,1)
 ;
 S AD=$$GET1^DIQ(344.61,"1,",.11,"I")       ; Medical Claims Auto-Decrease no-pay on/off
 I AP,AD D                                  ; Attempt to Auto-Decrease Medical Claims w/No Payments
 . S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",.12))
 . D EN1A(RCDAY,2,1)
 ;
 S AP=$$GET1^DIQ(344.61,"1,",1.01,"I")      ; Rx Claims Auto-Posting on/off
 S AD=$$GET1^DIQ(344.61,"1,",1.02,"I")      ; Rx Claims Auto-Decrease on/off
 I AP,AD D                                  ; Attempt to Auto-Decrease Rx Claims w/Payments
 . S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",1.03))
 . D EN1A(RCDAY,1,2)
 ;
 ; PRCA*4.5*349 - Begin added block
 S AP=$$GET1^DIQ(344.61,"1,",1.05,"I")      ; TRICARE Claims Auto-Posting on/off
 S AD=$$GET1^DIQ(344.61,"1,",1.06,"I")      ; TRICARE Claims w/payments Auto-Decrease on/off
 I AP,AD D                                  ; Attempt to Auto-Decrease TRICARE Claims w/Payments
 . S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",1.08))
 . D EN1A(RCDAY,1,3)
 ;
 S AD=$$GET1^DIQ(344.61,"1,",1.09,"I")      ; TRICARE Claims Auto-Decrease no-pay on/off
 I AP,AD D                                  ; Attempt to Auto-Decrease TRICARE Claims w/No Payments
 . D REJ^RCDPEAD4(3)
 ; PRCA*4.5*349 - End added block
 ;
 ; Payer Rejects for Medical Claims
 S AP=$$GET1^DIQ(344.61,"1,",.02,"I")       ; Medical Claims Auto-Posting on/off
 S AD=$$GET1^DIQ(344.61,"1,",.03,"I")       ; Medical Claims Auto-Decrease on/off
 I AP,AD D                                  ; Attempt to Auto-Decrease Rx Claims w/Payments
 . D REJ^RCDPEAD4(1)
 ; End PRCA*4.5*345
 Q
 ;
EN1A(RCDAY,PAID,WHICH) ; Scan ERA's for auto-posted lines on RCDAY
 ; PRCA*4.5*345 - Added WHICH
 ; Input:   RCDAY   - Day to begin search for auto-posted but not decreased lines
 ;          PAID    - 1 - Decrease paid lines only, 2 - Decrease no-pay lines only
 ;          WHICH   - 1 - Checking for Medical Claims, 2 - Checking for Rx Claims
 ; Output:  Auto-decreases claims (potentially)
 ; 
 ; Scan F (Auto-Post) index for ERAs within date range
 S RCDATE=$$FMADD^XLFDT(RCDAY,-1)
 F  D  Q:'RCDATE  Q:(RCDATE\1)>RCDAY
 . S RCDATE=$O(^RCY(344.4,"F",RCDATE))
 . Q:'RCDATE
 . Q:(RCDATE\1)>RCDAY
 . ;
 . ; Scan ERA detail lines for claims with AUTOPOST DATE field #4.03 matching RCDAY
 . D EN2(RCDATE,RCDAY,PAID,WHICH)           ; PRCA*4.5*345 - Added WHICH
 Q
 ;
EN2(RCDATE,RCDAY,PAID,WHICH) ; Scans the 'F' index of the ERA file for ERA entries with an
 ; AUTOPOST DATE field (#4.03) matching RCDAY
 ; PRCA*4.5*345 - Added WHICH
 ; Input:   RCDATE      - Auto-Post Date of the ERA
 ;          RCDAY       - Day to begin search for auto-posted but not decreased lines
 ;          PAID        - 1 - Decrease paid lines, 2 - Decrease no-pay lines
 ;          WHICH       - 1 - Checking for Medical Claims
 ;                        2 - Checking for Rx Claims
 ;                        3 - Checking for TRICARE Claims
 N IEN3446,PAYID,PAYNAM,RCARRAY,RCERA,RCRTYPE   ; PRCA*4.5*345 - Added IEN3446
 S RCERA=0
 F  D  Q:'RCERA
 . K RCARRAY
 . S RCERA=$O(^RCY(344.4,"F",RCDATE,RCERA))
 . Q:'RCERA
 . S XX=$$ISTYPE^RCDPEU1(344.4,RCERA,"T")       ; PRCA*4.5*349 - Added line
 . I XX S RCRTYPE=2                             ; PRCA*4.5*349 - Check if this is TRICARE ERA
 . E  S RCRTYPE=$$PHARM^RCDPEAP1(RCERA)          ; It must be a Medical or Rx ERA
 . I RCRTYPE'=0,WHICH=1 Q                       ; PRCA*4.5*345 - Not processing Medical Claims
 . I RCRTYPE'=1,WHICH=2 Q                       ; PRCA*4.5*345 - Not processing Rx Claims
 . I RCRTYPE'=2,WHICH=3 Q                       ; PRCA*4.5*349 - Not processing TRICARE Claims
 . S PAYID=$$GET1^DIQ(344.4,RCERA_",",.03,"E")  ; Payer TIN
 . S PAYNAM=$$GET1^DIQ(344.4,RCERA_",",.06,"E") ; Payer Name
 . S PAYNAM=$P($G(^RCY(344.4,RCERA,0)),U,6)
 . S IEN3446=""
 . I PAYID'="",PAYNAM'="" D
 . . S IEN3446=$O(^RCY(344.6,"CPID",PAYNAM,PAYID,""))
 . ;
 . ; Skip if payer is excluded from Auto-Post or Auto-Decrease
 . I $$PAYEX(WHICH,IEN3446) Q
 . ; 
 . ; Build index to scratchpad for this ERA
 . D BUILD^RCDPEAP(RCERA,.RCARRAY)
 . ;
 . ; Scan ERA DETAIL entries in #344.41 for auto-posted medical claims
 . D EN3(RCDATE,RCERA,.RCARRAY,PAID,WHICH)      ; PRCA*4.5*345 - Added WHICH
 Q
 ;
EN3(RCDATE,RCERA,RCARRAY,PAID,WHICH) ; Scan ERA Detail lines in #344.41 for 
 ; auto-posted Medical/Rx claims - PRCA*4.5*345 added WHICH
 ; Input:   RCDATE      - Auto-Post Date
 ;          RCERA       - IEN of the ERA (#344.4)
 ;          RCARRAY     - Array of ERA Scratchpad lines
 ;          PAID        - 1 - Decrease paid lines, 2 - Decrease no-pay lines
 ;          WHICH       - 1 - Processing Medical Claims, 2 - Processing Rx Claims
 N IENS,RCADJ,RCLINE
 S RCLINE=0
 ;
 ; Find auto-posted claim lines to auto-decrease
 F  D  Q:'RCLINE
 . S RCLINE=$O(^RCY(344.4,"F",RCDATE,RCERA,RCLINE))
 . Q:'RCLINE
 . ;
 . ; Ignore claim line if already auto decreased
 . Q:$P($G(^RCY(344.4,RCERA,1,RCLINE,5)),U,3)
 . ;
 . ; Process line
 . D EN4(RCDATE,RCERA,.RCARRAY,PAID,RCLINE,WHICH)   ; PRCA*4.5*345 - Added WHICH
 Q
 ; 
EN4(RCDATE,RCERA,RCARRAY,PAID,RCLINE,WHICH) ; Auto-decrease selected lines
 ; PRCA*4.5*345 - Added WHICH
 ; Input:   RCDATE      - Auto-Post Date
 ;          RCERA       - IEN of the ERA (#344.4)
 ;          RCARRAY     - Array of scratch pad lines
 ;          PAID        - 1 - Decrease paid lines
 ;                        2 - Decrease no-pay lines
 ;          RCLINE      - IEN of the detail ilne in sub-file 344.41
 ;          WHICH       - 1 - Processing Medical Claims, 2 - Processing Rx Claims
 ;
 ; Get claim number RCBILL for the ERA line using EOB #361.1 pointer
 ; BEGIN PRCA*4.5*326
 N COMMENT,EOBIEN,J,PENDING,RCAMT,RCBAL,RCBILL,RCIARR,RCITEN,RCJ,RCK,RCMAX,RCTRANDA,RCZERO,STATUS
 ;
 ; Check if this is a zero payment line
 S RCZERO=$S($$GET1^DIQ(344.41,RCLINE_","_RCERA_",",.03)=0:1,1:0)
 ;
 ; Quit if this is a no-payment line and loop is for payment lines
 I PAID=1,RCZERO Q
 ;
 ; Quit if this is not a no-payment line and loop is for no-payment lines
 I PAID=2,'RCZERO Q
 ;
 ; Ignore zero amount reversals
 I RCZERO Q:'$G(RCARRAY(RCLINE))
 ;
 ; Ignore zero lines if status is unverified in scratchpad (#344.491,.13)
 I RCZERO D  Q:'$$GET1^DIQ(344.491,IENS,.13,"I")
 . S IENS=$G(RCARRAY(RCLINE))_","_RCERA
 ; END PRCA*4.5*326
 ;
 ; Get pointer to EOB file #361.1 from ERA DETAIL
 S EOBIEN=$P($G(^RCY(344.4,RCERA,1,RCLINE,0)),U,2),RCBILL=0
 ;
 ; Get ^DGCR(399 pointer (DINUM for #430 file)
 S:EOBIEN RCBILL=$P($G(^IBM(361.1,EOBIEN,0)),U) Q:'RCBILL
 ;
 ; If claim has been split/edit and claim changed in APAR do not auto decrease
 Q:$$SPLIT(RCERA,RCLINE,RCBILL,.RCARRAY)
 ;
 ; Do not auto decrease if claim is referred to General Council
 Q:$P($G(^PRCA(430,RCBILL,6)),U,4)'=""
 ;
 ; Claim must be OPEN or ACTIVE
 S STATUS=$P($G(^PRCA(430,RCBILL,0)),"^",8)
 I STATUS'=42,STATUS'=16 Q 
 ;
 S RCAMT=$$CARCLMT(EOBIEN,RCZERO,WHICH)     ; PRCA*4.5*345 - Added WHICH
 Q:$L(RCAMT)=0                              ; No CARCs on EOB were eligible for auto-decrease
 ;
 ; Order CARCs for Auto-Decrease in largest to smallest amount order
 K RCIARR
 F J=1:1 S RCITEM=$P(RCAMT,U,J) Q:RCITEM=""  S RCIARR(-($P(RCITEM,";",1)),J)=RCITEM
 Q:$D(RCIARR)<10  ; Quit if CARC adjustment array doesn't have any elements to process
 ;
 ; Get top limit for auto-decrease
 I WHICH=1 S RCMAX=+$$GET1^DIQ(344.61,"1,",.05)     ; Medical Claims limit PRCA*4.5*345
 E  I WHICH=2 S RCMAX=+$$GET1^DIQ(344.61,"1,",1.04) ; Rx Claims limit PRCA*4.5*349
 E  S RCMAX=+$$GET1^DIQ(344.61,"1,",1.07)           ; TRICARE Claims limit PRCA*4.5*349
 ;
 ; Walk the RCIARR and apply CARC based adjustments to the bill.
 S RCJ="",RCADJ=0
 F  S RCJ=$O(RCIARR(RCJ)) Q:RCJ=""  S RCK="" F  S RCK=$O(RCIARR(RCJ,RCK)) Q:RCK=""  D
 . ; Get current balance on Bill
 . S RCBAL=$P($G(^PRCA(430,RCBILL,7)),U)
 . ;
 . ; Check pending payment amount and bill balance 
 . S PENDING=$$PENDPAY^RCDPURET(RCBILL)
 . K ^TMP($J,"RCDPUREC","PP")
 . Q:(RCBAL-PENDING)<(+$P(RCIARR(RCJ,RCK),";",1))
 . ;
 . Q:(RCADJ+$P(RCIARR(RCJ,RCK),";",1))>RCMAX  ; Don't apply decrease if over top limit
 . ;
 . S XX=$S(WHICH=1:"MEDICAL",WHICH=2:"PHARMACY",1:"TRICARE")    ; PRCA*4.5*345, PRCA*4.5*349 Rx and TRICARE
 . S COMMENT(1)=XX+" AUTO-DECREASE FOR CARC: "_$P(RCIARR(RCJ,RCK),";",2)    ; PRCA*4.5*345
 . S COMMENT(1)=COMMENT(1)_" AMOUNT: "_+$P(RCIARR(RCJ,RCK),";",1) ; PRCA*4.5*326
 . S COMMENT(1)=COMMENT(1)_" (MAX DEC: "
 . S COMMENT(1)=COMMENT(1)_+$P($$ACTCARC^RCDPEAD2($P(RCIARR(RCJ,RCK),";",2),RCZERO,WHICH),U,2)_")" ; PRCA*4.5*326
 . ;
 . ; If this CARC is expired then add that information to the comment
 . I $P(RCIARR(RCJ,RCK),";",3)'="" D
 . . S COMMENT(1)=COMMENT(1)_" CARC expired on "_$$FMTE^XLFDT($P(RCIARR(RCJ,RCK),";",3),"6D")
 . ;
 . ; Apply contract adjustment for CARC adjustment amount from claim information
 . S RCTRANDA=$$INCDEC^RCBEUTR1(RCBILL,-$P(RCIARR(RCJ,RCK),";",1),.COMMENT,"","",1)
 . Q:'RCTRANDA
 . ;
 . ; Update total adjustments for line
 . S RCADJ=RCADJ+$P(RCIARR(RCJ,RCK),";",1)
 ;
 ; Update auto-decrease indicator, auto decrease amount and auto decrease date
 N DA,DIE,DR
 S DA(1)=RCERA,DA=RCLINE,DIE="^RCY(344.4,"_DA(1)_",1,",DR="7///1;8///"_RCADJ_";10///"_DT
 D ^DIE
 ;
 ; Update last auto decrease date on ERA
 N DA,DIE,DR
 S DA=RCERA,DIE="^RCY(344.4,",DR="4.03///"_DT
 ;
 ; PRCA*4.5*332 - If we just did an Auto-Decrease of a zero-dollar ERA set
 ; the Match Status to MATCH - 0 PAYMENT and the Posting Status to POSTING NOT NEEDED
 I PAID=0,RCZERO D
 . S DR=DR_";.09////3;.14////3"
 D ^DIE
 Q
 ;
SPLIT(RCSCR,RCLINE,RCBILL,RCARRAY) ;Check for SPLIT/EDIT in scratchpad
 ;Input RCSCR - IEN of #344.49
 ;      RCLINE - ERA detail line sequence number
 ;      RCBILL - IEN of #430
 ;      ARRAY - reference to passed array (from BUILD^RCDPEAP)
 ;Output return value 1/0 = Split/Not Split 
 N SUB,SUB1
 ;Find ERA line in scratchpad
 S SUB=$G(RCARRAY(RCLINE)) Q:'SUB 0
 ;Get n.001 line
 S SUB1=$O(^RCY(344.49,RCSCR,1,SUB)) Q:'SUB1 0
 ;Check sequence number is the same
 Q:$P($G(^RCY(344.49,RCSCR,1,SUB1,0)),".")'=$P($G(^RCY(344.49,RCSCR,1,SUB,0)),U) 0
 ;Check that claim number is unchanged from original ERA
 Q:$P($G(^RCY(344.49,RCSCR,1,SUB1,0)),U,7)=RCBILL 0
 ;Otherwise claim was edited (and should not be decreased)
 Q 1
 ;
CARCLMT(RCEOB,RCZERO,WHICH,FROMADP,ADATE) ;EP from COMPILE^RCDPEADP and AUTO^RCDPEWLZ
 ; Checks to see if CARCs are included and eligible for auto-decrease
 ; PRCA*4.5*345 - Added WHICH
 ; Returns 0 if not, Max Amount ^ CARC if it is.
 ; Input:   RCEOB   - Internal IEN for the explanation of benefits field (361.1)
 ;          FROMADP - 1 if being called from COMPILE^RCDPEADP, 0 otherwise
 ;                    Optional, default to 0
 ;          ADATE   - Internal Auto-Post Date (only passed if FROMADP=1)
 ;          RCZERO  - 0 = ERA Line with payment 1 = ERA Line without payment
 ;          WHICH   - 1 - Checking Auto-Decrease for Medical CARCs
 ;                    2 - Checking Auto-Decrease for Rx CARCs
 ;                    3 - Checking Auto-Decrease for TRICARE CARCs
 ;                    Optional, defaults to 1 (Medical)
 ; Returns: A1;A2;A3;A4^B1;B2;B3;B4^...^N1;N2;N3;N4 Where:
 ;           A1 - Auto-Decrease amount of the 1st CARC code in the EOB
 ;           A2 - 1st CARC code in the EOB
 ;           A3 - Deactivation Date of the 1st CARC code in the EOB if
 ;                it has one and is less than today AND FROMADP=0
 ;                Otherwise Quantity of the first CARC code in the EOB if
 ;                FROMADP=1
 ;           A4 - Reason of the 1st CARC code in the EOB
 ;                only passed if FROMADP=1
 N I,RCAMT,RCCAMT,RCCODE,RCCODES,RCDATA,RCITEM,RCTAMT,XDT,XIEN
 I $G(WHICH)="" S WHICH=1
 S:'$D(FROMADP) FROMADP=0
 S RCAMT="",RCCODES=""
 ;
 ; Extract the CARC codes from the EOB.
 ; Returned are ^A1;A2;A3;A4^A1;A2;A3;A4^... Where
 ;                 A1 - CARC code
 ;                 A2 - Auto Decrease Amount
 ;                 A3 - Quantity       (only returned if FROMADP=1)
 ;                 A4 - REASON         (only returned if FROMADP=1)
 D GETCARCS^RCDPEAD2(RCEOB,.RCCODES,FROMADP)
 ; 
 ; Loop through all of the CARC codes found.  If none, it will exit.
 F I=2:1:$L(RCCODES,"^") D
 . S RCITEM=$P(RCCODES,"^",I)
 . Q:RCITEM=""
 . S RCCODE=$P(RCITEM,";",1),RCCAMT=$P(RCITEM,";",2)
 . ;
 . ; Quit If the Adjustment amount is a negative amount
 . Q:+RCCAMT<0
 . ;
 . ; Look up code in CARC table and get max adjustment
 . S RCDATA=$$ACTCARC^RCDPEAD2(RCCODE,RCZERO,WHICH) ; PRCA*4.5*345 - added WHICH
 . ;
 . ; Quit If auto decrease is not active on this code
 . Q:+RCDATA=0
 . ;
 . ; Get code inactive date if it exists
 . S XIEN=$$FIND1^DIC(345,,"O",RCCODE)
 . S:$G(XIEN)'="" XDT=$$GET1^DIQ(345,XIEN_",",2,"I")
 . I $G(XDT)'="" S:XDT'<DT XDT=""
 . S RCTAMT=$P(RCDATA,U,2)                  ; Get limit
 . ;
 . ; 11/11/2015: Compare the max adjustment in parameters to the adjustment on EEOB
 . ; Quit if over 
 . ;
 . ; If the CARC payer adjustment <= CARC max adjustment amount, Then add to list
 . ; for possible adjustments.
 . I RCCAMT<(RCTAMT+.01)!FROMADP D
 . . ;
 . . ; If we're being called from the auto-decrease report, return all CARC information
 . . I FROMADP D  Q
 . . . S XX=RCCAMT_";"_RCCODE_";"_$P(RCITEM,";",3,4)
 . . . S RCAMT=$S(RCAMT'[";":XX,1:RCAMT_"^"_XX)
 . . S RCAMT=$S($L(RCAMT)=0:RCCAMT_";"_RCCODE_";"_XDT,1:RCAMT_U_RCCAMT_";"_RCCODE_";"_XDT)
 Q RCAMT
 ;
OTHER(RCBILLDA,ORIG) ; Check if APAR/WL entries exist on other ERA for this bill
 ; INPUT 
 ;    RCBILLDA - IEN for claim in #430 or #399
 ;    ORIG - IEN for current ERA      
 ; OUTPUT
 ;    RCPEND - 1 = Other ERA payments exist   0 - No other ERA payments exit
 ;
 N AUTOSTA,RCERA,RCEOB,RCLINE,RCPAID,RCPEND,RCTOT,RCZ,RCZL
 ; Find EEOB's for this claim
 S RCEOB=0,RCPEND=0
 F  S RCEOB=$O(^IBM(361.1,"B",RCBILLDA,RCEOB)) Q:'RCEOB  Q:RCPEND  D
 . ;Find ERAs for this EOB - may be multiple
 . S RCERA=0
 . F  S RCERA=$O(^RCY(344.4,"ADET",RCEOB,RCERA)) Q:'RCERA  Q:RCPEND  D
 . . ; Ignore original ERA
 . . Q:RCERA=ORIG
 . . ; Get auto-post status for ERA
 . . S AUTOSTA=$$GET1^DIQ(344.4,RCERA_",",4.02,"I")
 . . ; Ignore completely processed auto-post ERA
 . . Q:AUTOSTA=2
 . . ; Ignore non-auto-post ERA which already have a receipt - processed or otherwise
 . . I AUTOSTA="",$$GET1^DIQ(344.4,RCERA_",",.08,"I") Q
 . . ; Get ERA lines for this EOB
 . . S RCLINE=0,RCTOT=0
 . . F  S RCLINE=$O(^RCY(344.4,"ADET",RCEOB,RCERA,RCLINE)) Q:'RCLINE  Q:RCPEND  D
 . . . ; Ignore auto-posted lines (which have a receipt)
 . . . I AUTOSTA]"",$$GET1^DIQ(344.41,RCLINE_","_RCERA_",",.25) Q
 . . . ; Get paid amount from ERA line
 . . . S RCPAID=$$GET1^DIQ(344.41,RCLINE_","_RCERA_",",.03)
 . . . ; Ignore zero lines  
 . . . Q:'RCPAID
 . . . ; If no scratchpad use paid amount from ERA
 . . . I '$D(^RCY(344.49,RCERA)) S RCTOT=RCTOT+RCPAID Q
 . . . ; Find ERA line in scratchpad
 . . . S RCZL=$$FIND(RCERA,RCLINE) Q:'RCZL
 . . . ; If scratchpad exists scan B index for split lines(344.49 is DINUM with 344.4)
 . . . S RCSUB=RCZL
 . . . F  S RCSUB=$O(^RCY(344.49,RCERA,1,"B",RCSUB)) Q:(RCSUB\1)'=RCZL  D
 . . . . S RCZ=$O(^RCY(344.49,RCERA,1,"B",RCSUB,"")) Q:'RCZ
 . . . . ; Check AR BILL is for this claim
 . . . . Q:$$GET1^DIQ(344.491,RCZ_","_RCERA_",",.07,"I")'=RCBILLDA
 . . . . ; Add AMOUNT TO POST ON RECEIPT to pending total - should resolve reversals
 . . . . S RCTOT=RCTOT+$$GET1^DIQ(344.491,RCZ_","_RCERA_",",.03)
 . . ; If claim total for the ERA is non-zero auto-decrease is blocked
 . . S:RCTOT>0 RCPEND=1
 Q RCPEND
 ;
FIND(RCERA,RCLINE) ; Search ORIGINAL ERA SEQUENCES for this line
 ; Input RCERA - Scratchpad IEN 
 ; RCLINE - ERA line to find
 ; Output RET - Scratchpad line number
 ;
 N DA,ORIG,RCSUB,RET
 S RCSUB=0,RET=0
 F  S RCSUB=$O(^RCY(344.49,RCERA,1,"ASEQ",RCSUB)) Q:RET  Q:'RCSUB  D
 . S DA=$O(^RCY(344.49,RCERA,1,"ASEQ",RCSUB,"")) Q:'DA
 . ;Get Original sequences
 . S ORIG=$$GET1^DIQ(344.491,DA_","_RCERA_",",.09) Q:ORIG=""
 . ;Check if scratchpad line is for original ERA line
 . S ORIG=","_ORIG_","
 . S:$F(ORIG,","_RCLINE_",") RET=RCSUB
 Q RET
 ;
PAYEX(WHICH,IEN3446) ; Check if payer is excluded
 ; Subroutine added for PRCA*4.5*349
 ; Input: WHICH - 1=Medical, 2=Rx, 3=TRICARE
 ;        IEN3446 - Internal Entry number of Payer Exclusion file entry
 ; Returns: 1 if payer is excluded, otherwise 0.
 ;
 N FLDA,FLDD,RETURN,XX
 S RETURN=0
 S FLDA=$S(WHICH=1:.06,WHICH=2:.08,1:.13)
 S FLDD=$S(WHICH=1:.07,WHICH=2:.12,1:.14)
 ; If processing Rx Claims, skip if payer is excluded from Auto-Post or Auto-Decrease
 I IEN3446'="" D  ;
 . S XX=$$GET1^DIQ(344.6,IEN3446_",",FLDA,"I")
 . I XX S RETURN=1 Q                            ; Payer excluded from Rx Auto-Post
 . S XX=$$GET1^DIQ(344.6,IEN3446_",",FLDD,"I")
 . I XX S RETURN=1                              ; Payer excluded from Rx Auto-Decrease
 Q RETURN
