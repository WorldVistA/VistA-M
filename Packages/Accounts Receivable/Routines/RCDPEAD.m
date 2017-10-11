RCDPEAD ;ALB/PJH - AUTO DECREASE ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298,304,318**;Mar 20, 1995;Build 37
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
EN ;Auto Decrease - applies to auto-posted claims only
 N RCAMT,RCDATE,RCDAY,RCSTART,RCITEM
 N RC344610,RCMDAP,RCMDAD,RCJ,RCK,RCIARR,J
 ;
 ; Quit if medical auto posting is OFF or medical auto decrease is OFF
 Q:'$P($G(^RCY(344.61,1,0)),U,2)  Q:'$P($G(^RCY(344.61,1,0)),U,3)
 ;
 ; Get the RCDPE PARAMETER file #344.61 field.04 AUTO DECREASE MED DAYS DEFAULT value and
 ; calculate process date by subtracting this value from today's date
 S RCDAY=$$FMADD^XLFDT(DT\1,-$P($G(^RCY(344.61,1,0)),U,4))
 ;
 ; PRCA*4.5*304 - removed generic auto-decrease amount. Now auto-decrease is by CARC
 ; Allow for a range of dates in future - currently only checks for RCDAY
 ;
 ; Scan F index for ERA within date range
 S RCDATE=$$FMADD^XLFDT(RCDAY,-1)
 F  S RCDATE=$O(^RCY(344.4,"F",RCDATE)) Q:'RCDATE  Q:(RCDATE\1)>RCDAY  D
 . ;
 . ; Scan "F" index of ERA file for ERA entries with AUTOPOST DATE field #4.03 matching RCDAY
 . D EN2(RCDATE,RCDAY)
 Q
 ;
EN2(RCDATE,RCDAY) ; Scans the 'F' index of the ERA file for ERA entries with an
 ; AUTOPOST DATE field (#4.03) matching RCDAY
 ; Input:   RCDATE      - Current date being search
 ;          RCDAY       - AUTO DECREATES MED DAYS DEFAULT (File 344.61, field .04)
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
 . D EN3(RCDATE,RCERA)
 Q
 ;
EN3(RCDATE,RCERA) ; Scan ERA DETAIL entries in #344.41 for auto-posted medical claims
 ; Input:   RCDATE      - Current date being search
 ;          RCERA       - ERA number
 N RCADJ,RCDREC,RCLINE
 S RCLINE=0
 F  S RCLINE=$O(^RCY(344.4,"F",RCDATE,RCERA,RCLINE)) Q:'RCLINE  D
 . ; 
 . ; Ignore claim line if already auto decreased
 . Q:$P($G(^RCY(344.4,RCERA,1,RCLINE,5)),U,3)
 . ;
 . ; Get record detail
 . S RCDREC=$G(^RCY(344.4,RCERA,1,RCLINE,0))
 . ;
 . ; Get claim number RCBILL for the ERA line using EOB #361.1 pointer
 . N COMMENT,EOBIEN,RCBAL,RCBILL,RCTRANDA
 . ;
 . ; Get pointer to EOB file #361.1 from ERA DETAIL
 . S EOBIEN=$P($G(^RCY(344.4,RCERA,1,RCLINE,0)),U,2),RCBILL=0
 . ;
 . ; Get ^DGCR(399 pointer (DINUM for #430 file)
 . S:EOBIEN RCBILL=$P($G(^IBM(361.1,EOBIEN,0)),U) Q:'RCBILL
 . ;
 . ; If claim has been split/edit and claim changed in APAR do not auto decrease
 . Q:$$SPLIT(RCERA,RCLINE,RCBILL,.RCARRAY)
 . ;
 . ; Do not auto decrease if claim is referred to General Council
 . Q:$P($G(^PRCA(430,RCBILL,6)),U,4)]""
 . ;
 . ; Claim must be OPEN or ACTIVE
 . N STATUS
 . S STATUS=$P($G(^PRCA(430,RCBILL,0)),"^",8)
 . I STATUS'=42,STATUS'=16 Q 
 . ;
 . ; PRCA*4.5*304 - A CARC must be included and have an auto-decrease limit before auto-decreasing can occur.
 . S RCAMT=$$CARCLMT(EOBIEN)
 . Q:$L(RCAMT)=0         ; No CARCs on EOB were eligible for auto-decrease
 . ;
 . ; Order CARCs for Auto-Decrease in largest to smallest amount order
 . K RCIARR
 . F J=1:1 S RCITEM=$P(RCAMT,U,J) Q:RCITEM=""  S RCIARR(-($P(RCITEM,";",1)),J)=RCITEM
 . Q:$D(RCIARR)<10  ; Quit if CARC adjustment array doesn't have any elements to process
 . ;
 . ; Walk the RCIARR and apply CARC based adjustments to the bill.
 . S RCJ="",RCADJ=0
 . F  S RCJ=$O(RCIARR(RCJ)) Q:RCJ=""  S RCK="" F  S RCK=$O(RCIARR(RCJ,RCK)) Q:RCK=""  D
 . . ; Get current balance on Bill
 . . S RCBAL=$P($G(^PRCA(430,RCBILL,7)),U)
 . . ;
 . . ; Check pending payment amount and bill balance 
 . . N PENDING
 . . S PENDING=$$PENDPAY^RCDPURET(RCBILL)
 . . K ^TMP($J,"RCDPUREC","PP")
 . . Q:(RCBAL-PENDING)<(+$P(RCIARR(RCJ,RCK),";",1))
 . . ;
 . . ; Add comment
 . . S COMMENT(1)="MEDICAL AUTO-DECREASE FOR CARC: "_$P(RCIARR(RCJ,RCK),";",2)_" AMOUNT: "_+$P(RCIARR(RCJ,RCK),";",1)_" (MAX DEC: "_+$P($$ACTCARC($P(RCIARR(RCJ,RCK),";",2)),U,2)_")"
 . . ; If this CARC is expired then add that information to the comment
 . . I $P(RCIARR(RCJ,RCK),";",3)'="" S COMMENT(1)=COMMENT(1)_" CARC expired on "_$$FMTE^XLFDT($P(RCIARR(RCJ,RCK),";",3),"6D")
 . . ; Apply contract adjustment for CARC adjustment amount from claim information
 . . S RCTRANDA=$$INCDEC^RCBEUTR1(RCBILL,-$P(RCIARR(RCJ,RCK),";",1),.COMMENT,"","",1) Q:'RCTRANDA
 . . ; Update total adjustments for line
 . . S RCADJ=RCADJ+$P(RCIARR(RCJ,RCK),";",1)
 . ; Update auto-decrease indicator, auto decrease amount and auto decrease date
 . N DA,DIE,DR S DA(1)=RCERA,DA=RCLINE,DIE="^RCY(344.4,"_DA(1)_",1,",DR="7///1;8///"_RCADJ_";10///"_DT D ^DIE
 . ; PRCA*4.5*304 - End of updates
 . ; Update last auto decrease date on ERA
 . N DA,DIE,DR S DA=RCERA,DIE="^RCY(344.4,",DR="4.03///"_DT D ^DIE
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
CARCLMT(RCEOB,FROMADP,ADATE) ;EP from COMPILE^RCDPEADP
 ; PRCA*4.5*304 - Check to see if CARC are included and are eligible
 ; for auto-decrease. Return 0 if not, Max Amount ^ CARC if it is.
 ; Input:   RCEOB   - Internal IEN for the explanation of benefits field (361.1)
 ;          FROMADP - 1 if being called from COMPILE^RCDPEADP, 0 otherwise
 ;                    Optional, default to 0
 ;          ADATE   - Internal Auto-Post Date (only passed if FROMADP=1)
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
 . S RCDATA=$$ACTCARC(RCCODE)
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
ACTCARC(CODE) ; Is this CARC an active code for auto-decrease
 ; Input:   CODE    - CARC code being checked
 ; Returns: '0^NOT ACTIVE' if not active
 ;          '1^{amount}' if active and the second peice is the decrease amount
 N AIEN,XX
 I $G(CODE)="" Q "0^NOT ACTIVE"
 S AIEN=$O(^RCY(344.62,"B",CODE,""))
 I AIEN="" Q "0^NOT ACTIVE"
 S XX=$$GET1^DIQ(344.62,AIEN,.02,"I")       ; Quit if auto-decrease is off
 I XX=1 Q "1^"_$$GET1^DIQ(344.62,AIEN,.06)  ; Active code returns maximum allowed decrease amount
 Q "0^NOT ACTIVE"
 ;
