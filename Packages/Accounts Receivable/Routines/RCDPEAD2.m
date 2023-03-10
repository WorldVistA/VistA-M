RCDPEAD2 ;AITC/CJE - AUTO-DECREASE REPORT ;Nov 23, 2014@12:48:50
 ;;4.5;Accounts Receivable;**326,345,349**;Mar 20, 1995;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EXCEL(DATA,A1,A2,A3) ; Format EXCEL line
 ; Input:   DATA - ERA line adjustment total
 ;          A1,A2,A3 - ^TMP("RCDPEAP") subscripts
 N CARCAMT,CCTR,DATA1
 S CCTR=0
 F  S CCTR=$O(^TMP("RCDPEADP",$J,A1,A2,A3,CCTR)) Q:'CCTR  D
 . ;Display an EXCEL line for each CARC adjustment on the line
 . S DATA1=$G(^TMP("RCDPEADP",$J,A1,A2,A3,CCTR)),CARCAMT=$P(DATA1,U,2)
 . W !,$P(DATA,U,1,5)_U_CARCAMT_U_$P(DATA,U,7)_U_DATA1
 Q
 ;
LINE(DIV) ; List selected stations
 ; Input:   DIV()       - Array of selected divisions
 ; Returns: Comma delimited list of selected divisions
 N LINE,P,SUB
 S LINE="",SUB="",P=0
 F  D  Q:'SUB
 . S SUB=$O(DIV(SUB))
 . Q:'SUB
 . S P=P+1,$P(LINE,", ",P)=$G(DIV(SUB))
 Q LINE
 ;
CLAIM(EOBIEN) ; Gets the claim number from AR
 ; Input:   EOBIEN      - Internal IEN for file 361.1
 ; Returns: External Claim Number
 N CLAIM,CLAIMIEN
 Q:'$G(EOBIEN)>0 "(no EOB IEN)"
 S CLAIMIEN=$$GET1^DIQ(361.1,EOBIEN,.01,"I")    ; IEN for file 399
 Q:'CLAIMIEN "(no Claim IEN)"
 S CLAIM=$$GET1^DIQ(430,CLAIMIEN,.01,"I")
 Q:CLAIM="" "(Claim not found)"
 Q CLAIM                                        ; Return claim (nnn-Knnnnnn)
 ;
 ; PRCA*4.5*345 - Moved function from RCDPEAD
ACTCARC(CODE,RCZERO,WHICH) ; EP from RCDPEAD - Is this CARC an active code for auto-decrease
 ; PRCA*4.5*345 - Added WHICH
 ; Input:   CODE    - CARC code being checked
 ;          RCZERO  - 0 = Claim line with payment, 1 = Claim line with no payment
 ;          WHICH   - 1 Medical Claim CARCs, 2 - RX Claim CARCs, 3 TRICARE Claim CARCS
 ; Returns: '0^NOT ACTIVE' if not active
 ;          '1^{amount}' if active and the second piece is the decrease amount
 N ACTIVE,AIEN,FIELD,XX
 I $G(CODE)="" Q "0^NOT ACTIVE"
 S AIEN=$O(^RCY(344.62,"B",CODE,""))
 I AIEN="" Q "0^NOT ACTIVE"
 ;
 ; PRCA*4.5*349 - Parameterize for Medical, Rx and TRICARE
 I WHICH=1 S FIELD=$S(RCZERO:.08,1:.02)
 E  I WHICH=2 S FIELD=2.01
 E  S FIELD=$S(RCZERO:3.07,1:3.01)
 S ACTIVE=$$GET1^DIQ(344.62,AIEN,FIELD,"I")   ; Quit if auto-decrease is off
 ;
 I 'ACTIVE Q "0^NOT ACTIVE"
 ;
 I WHICH=1 S FIELD=$S(RCZERO:.12,1:.06)
 E  I WHICH=2 S FIELD=2.05
 E  S FIELD=$S(RCZERO:3.11,1:3.05)
 ;
 Q "1^"_$$GET1^DIQ(344.62,AIEN,FIELD)
 ; END PRCA*4.5*349
 ;
GETCARCS(RCEOB,RCCODES,FROMADP) ; EP from RCDPEAD - Extract the CARCs from an EOB at claim and line levels
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
