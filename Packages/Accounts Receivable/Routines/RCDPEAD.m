RCDPEAD ;ALB/PJH - AUTO DECREASE ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298,304,318,326**;Mar 20, 1995;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
EN ;Auto Decrease - applies to auto-posted claims only
 N RCAMT,RCDATE,RCDAY,RCSTART,RCITEM
 N RC344610,RCMDAP,RCMDAD,RCJ,RCK,RCIARR,J
 ; BEGIN PRCA*4.5*326 - added EN1A subroutine
 ;
 ; Quit if medical auto posting is OFF
 Q:'$$GET1^DIQ(344.61,"1,",.02,"I")
 ;
 ; Quit if medical auto decrease of payment lines is OFF
 Q:'$$GET1^DIQ(344.61,"1,",.03,"I") 
 ;
 ; Get the RCDPE PARAMETER file #344.61 field.04 AUTO DECREASE MED DAYS DEFAULT value and
 ; calculate process date by subtracting this value from today's date
 S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",.04))
 ;
 ; Search ERA's paid lines requiring auto-decrease
 D EN1A(RCDAY,1)
 ;
 ; Quit if medical auto decrease of no-payment lines is OFF
 Q:'$$GET1^DIQ(344.61,"1,",.11,"I")
 ;
 ; Get days to wait for no-pay lines 
 S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",.12))
 ; Search ERA's for no pay lines requiring auto-decrease
 D EN1A(RCDAY,2)
 ;
 ; Payer Rejects
 D REJ
 ;
 ; END PRCA*4.5*326
 Q
 ;
EN1A(RCDAY,PAID) ; Scan ERA's for auto-posted lines on RCDAY
 ; INPUT  RCDAY - Day to search for auto-posted but not decreased lines
 ;        PAID -  1 = decrease paid lines only, 2 = decrease no-pay lines only
 ; OUTPUT - Auto-decreases claims
 ; 
 ; PRCA*4.5*304 - removed generic auto-decrease amount. Now auto-decrease is by CARC
 ; Allow for a range of dates in future - currently only checks for RCDAY
 ;
 ; Scan F index for ERA within date range
 S RCDATE=$$FMADD^XLFDT(RCDAY,-1)
 F  S RCDATE=$O(^RCY(344.4,"F",RCDATE)) Q:'RCDATE  Q:(RCDATE\1)>RCDAY  D
 . ;
 . ; Scan "F" index of ERA file for ERA entries with AUTOPOST DATE field #4.03 matching RCDAY
 . D EN2(RCDATE,RCDAY,PAID)
 Q
 ;
EN2(RCDATE,RCDAY,PAID) ; Scans the 'F' index of the ERA file for ERA entries with an - PRCA*4.5*326
 ; AUTOPOST DATE field (#4.03) matching RCDAY
 ; Input:   RCDATE      - Current date being search
 ;          RCDAY       - AUTO DECREASES MED DAYS DEFAULT (File 344.61, field .04)
 ;          PAID        - 1 = decrease paid lines, 2 = decrease no-pay lines
 N PAYID,PAYNAM,RCERA,RCRTYPE
 S RCERA=0
 F  S RCERA=$O(^RCY(344.4,"F",RCDATE,RCERA)) Q:'RCERA  D
 . N RC3446,RCPARM
 . ;
 . ; Quit if ERA is for Pharmacy
 . S RCRTYPE=$$PHARM^RCDPEAP1(RCERA)
 . Q:RCRTYPE
 . ;
 . ; Check payer exclusion file for this ERA's payer
 . S PAYID=$P($G(^RCY(344.4,RCERA,0)),U,3)
 . S PAYNAM=$P($G(^RCY(344.4,RCERA,0)),U,6)
 . I PAYID'="",PAYNAM'="" D
 . . S RCPARM=$O(^RCY(344.6,"CPID",PAYNAM,PAYID,""))
 . . S:RCPARM'="" RC3446=$G(^RCY(344.6,RCPARM,0))
 . ;
 . ; Ignore ERA if EXCLUDE MED CLAIMS POSTING  (#.06) or
 . ; EXCLUDE MED CLAIMS DECREASE (#.07) fields set to 'yes'
 . I $G(RC3446)'="" Q:$P(RC3446,U,6)=1  Q:$P(RC3446,U,7)=1
 . ; 
 . ; Build index to scratchpad for this ERA
 . N RCARRAY
 . D BUILD^RCDPEAP(RCERA,.RCARRAY)
 . ;
 . ; Scan ERA DETAIL entries in #344.41 for auto-posted medical claims
 . D EN3(RCDATE,RCERA,.RCARRAY,PAID) ; PRCA*4.5*326
 Q
 ;
EN3(RCDATE,RCERA,RCARRAY,PAID) ; Scan ERA DETAIL entries in #344.41 for auto-posted medical claims - PRCA*4.5*326 added PAID
 ; Input:   RCDATE      - Current date being search
 ;          RCERA       - ERA number
 ;          RCARRAY     - Array of ERA Scratchpad lines
 ;          PAID        - 1 = decrease paid lines, 2 = decrease no-pay lines
 N IENS,RCADJ,RCLINE
 S RCLINE=0
 ;
 ; Find auto-posted paid lines to auto-decrease
 I PAID=1 D
 .F  S RCLINE=$O(^RCY(344.4,"F",RCDATE,RCERA,RCLINE)) Q:'RCLINE  D
 ..; Ignore claim line if already auto decreased
 ..Q:$P($G(^RCY(344.4,RCERA,1,RCLINE,5)),U,3)
 ..; Process line
 ..D EN4(RCDATE,RCERA,.RCARRAY,PAID,RCLINE)
 ;
 ; Find zero lines on the auto-posted ERA which are auto-decrease candidates
 I PAID=2 D
 .F  S RCLINE=$O(RCARRAY(RCLINE)) Q:'RCLINE  D
 ..; Ignore claim line if already auto decreased
 ..Q:$P($G(^RCY(344.4,RCERA,1,RCLINE,5)),U,3)
 ..; Process line
 ..D EN4(RCDATE,RCERA,.RCARRAY,PAID,RCLINE)
 Q
 ; 
EN4(RCDATE,RCERA,RCARRAY,PAID,RCLINE) ; Auto-decrease selected lines
 ;
 ; Get claim number RCBILL for the ERA line using EOB #361.1 pointer
 ; BEGIN PRCA*4.5*326
 N COMMENT,EOBIEN,RCBAL,RCBILL,RCMAX,RCTRANDA,RCZERO
  ; Check if this is a zero payment line
 S RCZERO=$S($$GET1^DIQ(344.41,RCLINE_","_RCERA_",",.03)=0:1,1:0)
 ;
 ; Quit if this is a no-payment line and loop is for payment lines
 I PAID=1,RCZERO Q
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
 ; Skip zero lines if other unposted non-zero amount ERA lines exist for this bill
 ;;I RCZERO,$$OTHER(RCBILL,RCERA) Q  ; PRCA*4.4*326
 ;
 ; If claim has been split/edit and claim changed in APAR do not auto decrease
 Q:$$SPLIT(RCERA,RCLINE,RCBILL,.RCARRAY)
 ;
 ; Do not auto decrease if claim is referred to General Council
 Q:$P($G(^PRCA(430,RCBILL,6)),U,4)]""
 ;
 ; Claim must be OPEN or ACTIVE
 N STATUS
 S STATUS=$P($G(^PRCA(430,RCBILL,0)),"^",8)
 I STATUS'=42,STATUS'=16 Q 
 ;
 ; PRCA*4.5*304 - A CARC must be included and have an auto-decrease limit before auto-decreasing can occur.
 S RCAMT=$$CARCLMT(EOBIEN,RCZERO) ; PRCA*4.5*326 - added RCZERO
 Q:$L(RCAMT)=0         ; No CARCs on EOB were eligible for auto-decrease
 ;
 ; Order CARCs for Auto-Decrease in largest to smallest amount order
 K RCIARR
 F J=1:1 S RCITEM=$P(RCAMT,U,J) Q:RCITEM=""  S RCIARR(-($P(RCITEM,";",1)),J)=RCITEM
 Q:$D(RCIARR)<10  ; Quit if CARC adjustment array doesn't have any elements to process
 ;
 ; Get top limit for auto-decrease
 S RCMAX=+$$GET1^DIQ(344.61,"1,",.05)
 ;
 ; Walk the RCIARR and apply CARC based adjustments to the bill.
 S RCJ="",RCADJ=0
 F  S RCJ=$O(RCIARR(RCJ)) Q:RCJ=""  S RCK="" F  S RCK=$O(RCIARR(RCJ,RCK)) Q:RCK=""  D
 . ; Get current balance on Bill
 . S RCBAL=$P($G(^PRCA(430,RCBILL,7)),U)
 . ;
 . ; Check pending payment amount and bill balance 
 . N PENDING
 . S PENDING=$$PENDPAY^RCDPURET(RCBILL)
 . K ^TMP($J,"RCDPUREC","PP")
 . Q:(RCBAL-PENDING)<(+$P(RCIARR(RCJ,RCK),";",1))
 . ;
 . Q:(RCADJ+$P(RCIARR(RCJ,RCK),";",1))>RCMAX  ; Don't apply decrease if over top limit
 . ;
 . S COMMENT(1)="MEDICAL AUTO-DECREASE FOR CARC: "_$P(RCIARR(RCJ,RCK),";",2)_" AMOUNT: "_+$P(RCIARR(RCJ,RCK),";",1) ; PRCA*&4.5*326
 . S COMMENT(1)=COMMENT(1)_" (MAX DEC: "_+$P($$ACTCARC($P(RCIARR(RCJ,RCK),";",2),RCZERO),U,2)_")" ; PRCA*4.5*326
 . ; If this CARC is expired then add that information to the comment
 . I $P(RCIARR(RCJ,RCK),";",3)'="" S COMMENT(1)=COMMENT(1)_" CARC expired on "_$$FMTE^XLFDT($P(RCIARR(RCJ,RCK),";",3),"6D")
 . ; Apply contract adjustment for CARC adjustment amount from claim information
 . S RCTRANDA=$$INCDEC^RCBEUTR1(RCBILL,-$P(RCIARR(RCJ,RCK),";",1),.COMMENT,"","",1) Q:'RCTRANDA
 . ; Update total adjustments for line
 . S RCADJ=RCADJ+$P(RCIARR(RCJ,RCK),";",1)
 ; Update auto-decrease indicator, auto decrease amount and auto decrease date
 N DA,DIE,DR S DA(1)=RCERA,DA=RCLINE,DIE="^RCY(344.4,"_DA(1)_",1,",DR="7///1;8///"_RCADJ_";10///"_DT D ^DIE
 ; PRCA*4.5*304 - End of updates
 ; Update last auto decrease date on ERA
 N DA,DIE,DR S DA=RCERA,DIE="^RCY(344.4,",DR="4.03///"_DT D ^DIE
 Q
 ;
REJ ; Process zero balance denial ERA's - PRCA*4.5*326
 N PAID,PAYID,PAYNAM,RC3446,RCDAY,RCLINE,RCPARM
 ; Get days to wait for payer rejects (rename no-pay lines field) 
 S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",.12))
 ; Scan AFD index for ERA received within date range
 S RCDATE=$$FMADD^XLFDT(RCDAY,-1)_".99999",PAID=0
 F  S RCDATE=$O(^RCY(344.4,"AFD",RCDATE)) Q:'RCDATE  Q:(RCDATE\1)>RCDAY  D
 . S RCERA=0
 . ; Check for payer reject ERA's
 . F  S RCERA=$O(^RCY(344.4,"AFD",RCDATE,RCERA)) Q:'RCERA  D
 .. ; Ignore ERA if total paid is not zero
 .. Q:+$$GET1^DIQ(344.4,RCERA_",",.05)
 .. ; Ignore ERA if removed from worklist
 .. Q:+$$GET1^DIQ(344.4,RCERA_",",.16,"I")
 .. ; Ignore ERA if not payment type of NON
 .. Q:$$GET1^DIQ(344.4,RCERA_",",.15)'="NON"
 .. ; Quit if ERA is for Pharmacy
 .. S RCRTYPE=$$PHARM^RCDPEAP1(RCERA)
 .. Q:RCRTYPE
 .. ; Check payer exclusion file for this ERA's payer
 .. S PAYID=$P($G(^RCY(344.4,RCERA,0)),U,3)
 .. S PAYNAM=$P($G(^RCY(344.4,RCERA,0)),U,6)
 .. I PAYID'="",PAYNAM'="" D
 .. . S RCPARM=$O(^RCY(344.6,"CPID",PAYNAM,PAYID,""))
 .. . S:RCPARM'="" RC3446=$G(^RCY(344.6,RCPARM,0))
 .. ; Ignore ERA if EXCLUDE MED CLAIMS POSTING  (#.06) or EXCLUDE MED CLAIMS DECREASE (#.07) fields set to 'yes'
 .. I $G(RC3446)'="" Q:$P(RC3446,U,6)=1  Q:$P(RC3446,U,7)=1
 .. ; Ignore ERA if auto-post blocked
 .. Q:$$GET1^DIQ(344.4,RCERA_",",.19,"I")
 .. ;
 .. ; Build Scratchpad (if needed) and Verify Lines
 .. K ^TMP($J,"RCDPEWLA")
 .. S RCSCR=$$SCRPAD^RCDPEWLZ(RCERA)
 .. I 'RCSCR Q
 .. ; Ignore ERA if it has PLBs
 .. I $D(^TMP($J,"RCDPEWLA","ERA LEVEL ADJUSTMENT EXISTS")) Q
 .. ;
 .. ; Build index to scratchpad for this ERA
 .. N RCARRAY
 .. D BUILD^RCDPEAP(RCERA,.RCARRAY)
 .. ; Search lines
 .. S RCLINE=0
 .. F  S RCLINE=$O(RCARRAY(RCLINE)) Q:'RCLINE  D
 ...; Ignore claim line if already auto decreased
 ...Q:$P($G(^RCY(344.4,RCERA,1,RCLINE,5)),U,3)
 ...; Process line
 ...D EN4(RCDATE,RCERA,.RCARRAY,PAID,RCLINE)
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
CARCLMT(RCEOB,RCZERO,FROMADP,ADATE) ;EP from COMPILE^RCDPEADP
 ; PRCA*4.5*304 - Check to see if CARC are included and are eligible
 ; for auto-decrease. Return 0 if not, Max Amount ^ CARC if it is.
 ; Input:   RCEOB   - Internal IEN for the explanation of benefits field (361.1)
 ;          FROMADP - 1 if being called from COMPILE^RCDPEADP, 0 otherwise
 ;                    Optional, default to 0
 ;          ADATE   - Internal Auto-Post Date (only passed if FROMADP=1)
 ;          RCZERO  - 0 = ERA Line with payment 1 = ERA Line without payment
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
 S:'$D(FROMADP) FROMADP=0
 S RCAMT="",RCCODES=""
 ;
 ; Extract the CARC codes from the EOB.
 ; Returned are ^A1;A2;A3;A4^A1;A2;A3;A4^... Where
 ;                 A1 - CARC code
 ;                 A2 - Auto Decrease Amount
 ;                 A3 - Quantity       (only returned if FROMADP=1)
 ;                 A4 - REASON         (only returned if FROMADP=1)
 D GETCARCS(RCEOB,.RCCODES,FROMADP)
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
 . S RCDATA=$$ACTCARC(RCCODE,RCZERO) ; PRCA*4.5*326
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
 . I RCCAMT<(RCTAMT+.01) D
 . . ;
 . . ; If we're being called from the auto-decrease report, return all CARC information
 . . I FROMADP D  Q
 . . . S XX=RCCAMT_";"_RCCODE_";"_$P(RCITEM,";",3,4)
 . . . S RCAMT=$S(RCAMT'[";":XX,1:RCAMT_"^"_XX)
 . . S RCAMT=$S($L(RCAMT)=0:RCCAMT_";"_RCCODE_";"_XDT,1:RCAMT_U_RCCAMT_";"_RCCODE_";"_XDT)
 Q RCAMT
 ;
GETCARCS(RCEOB,RCCODES,FROMADP) ; Extract the CARCs from an EOB at claim and line levels
 ; Input:   RCEOB   - Internal IEN for the explanation of benefits field (361.1)
 ;          FROMADP - 1 if being called from COMPILE^RCDPEAD1, 0 otherwise
 ;                    Optional, default to 0
 ; Output:  RCCODES - ^ delimitted string of CARC code information from the
 ;                      claim and claim ine levels for the specified EOB
 ;                      ^A1;A2;A3;A4^A1;A2;A3;A4^... Where
 ;                        A1 - CARC code
 ;                        A2 - Auto Decrease Amount
 ;                        A3 - Quantity       (only returned if FROMADP=1)
 ;                        A4 - REASON         (only returned if FROMADP=1)
 N IENS,RCAMT,QUANT,REASON,RCCODE,RCI,RCJ,RCL
 S:'$D(FROMADP) FROMADP=0
 S RCI=0,RCCODES=""
 ;
 ; Get to the Codes at the claim level
 F  D  Q:'RCI
 . S RCI=$O(^IBM(361.1,RCEOB,10,RCI))
 . Q:'RCI
 . S RCJ=0
 . F  D  Q:'RCJ
 . . S RCJ=$O(^IBM(361.1,RCEOB,10,RCI,1,RCJ))
 . . Q:'RCJ
 . . S IENS=RCJ_","_RCI_","_RCEOB_","
 . . S RCCODE=$$GET1^DIQ(361.111,IENS,.01,"I") ; CARC Code
 . . Q:RCCODE=""
 . . S RCAMT=$$GET1^DIQ(361.111,IENS,.02,"I")  ; CARC Amount
 . . I 'FROMADP S RCCODES=RCCODES_"^"_RCCODE_";"_RCAMT Q
 . . S QUANT=$$GET1^DIQ(361.111,IENS,.03,"I")  ; CARC Quantity
 . . S REASON=$$GET1^DIQ(361.111,IENS,.04,"I") ; CARC Reason
 . . S:$L(REASON)>30 REASON=$E(REASON,1,27)_"..."
 . . S RCCODES=RCCODES_"^"_RCCODE_";"_RCAMT_";"_QUANT_";"_REASON
 ;
 ; Get Claim Line level CARCs
 S RCL=0
 F  D  Q:+RCL=0
 . S RCL=$O(^IBM(361.1,RCEOB,15,RCL))
 . Q:+RCL=0
 . S RCI=0
 . F  D  Q:+RCI=0
 . . S RCI=$O(^IBM(361.1,RCEOB,15,RCL,1,RCI))
 . . Q:+RCI=0
 . . S RCJ=0
 . . F  D  Q:+RCJ=0
 . . . S RCJ=$O(^IBM(361.1,RCEOB,15,RCL,1,RCI,1,RCJ))
 . . . Q:+RCJ=0
 . . . S IENS=RCJ_","_RCI_","_RCL_","_RCEOB_","
 . . . S RCCODE=$$GET1^DIQ(361.11511,IENS,.01,"I") ; CARC Code
 . . . Q:RCCODE=""
 . . . S RCAMT=$$GET1^DIQ(361.11511,IENS,.02,"I")  ; CARC Amount
 . . . I 'FROMADP S RCCODES=RCCODES_"^"_RCCODE_";"_RCAMT Q
 . . . S QUANT=$$GET1^DIQ(361.11511,IENS,.03,"I")  ; CARC Quantity
 . . . S REASON=$$GET1^DIQ(361.11511,IENS,.04,"I") ; CARC Reason
 . . . S:$L(REASON)>30 REASON=$E(REASON,1,27)_"..."
 . . . S RCCODES=RCCODES_"^"_RCCODE_";"_RCAMT_";"_QUANT_";"_REASON
 Q
 ;
 ; PRCA*4.5*304 - Added function
ACTCARC(CODE,RCZERO) ; Is this CARC an active code for auto-decrease
 ; Input:   CODE    - CARC code being checked
 ;          RCZERO  - O = Claim line with payment, 1 = Claim line with no payment
 ; Returns: '0^NOT ACTIVE' if not active
 ;          '1^{amount}' if active and the second piece is the decrease amount
 N AIEN,FIELD,XX
 I $G(CODE)="" Q "0^NOT ACTIVE"
 S AIEN=$O(^RCY(344.62,"B",CODE,""))
 I AIEN="" Q "0^NOT ACTIVE"
 ; BEGIN PRCA*4.5*326
 S FIELD=$S(RCZERO:.08,1:.02) ; No pay line CARCs have separate on/off switch
 S XX=$$GET1^DIQ(344.62,AIEN,FIELD,"I")       ; Quit if auto-decrease is off
 S FIELD=$S(RCZERO:.12,1:.06) ; No pay line CARCs have different maximum
 I XX=1 Q "1^"_$$GET1^DIQ(344.62,AIEN,FIELD)  ; Active code returns maximum allowed decrease amount
 ; END PRCA*4.5*326
 Q "0^NOT ACTIVE"
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
