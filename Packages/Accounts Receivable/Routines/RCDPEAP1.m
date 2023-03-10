RCDPEAP1 ;ALB/KML - AUTO POST MATCHING EFT ERA PAIR - CONT. ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298,304,318,321,326,345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
 ;-------------------------------
 ;RCDPEM0 and RCDPEAP SUBROUTINES
 ;-------------------------------
AUTOCHK(RCERA) ;Verify if ERA can be auto-posted - PRE-CHECK USED IN RCDPEM0
 ; Input:   RCERA       - IEN for file 344.4
 ; Returns: 1 - Auto-Post candidate, 0 - Not an Auto-Post candidate
 ; Many checks done by this are also done AUTOCHK2 below so if these are changed, 
 ; may also need to be changed
 N NOTOK,RCDSUB,RCD0,RCSCR
 K ^TMP($J,"RCDPEWLA")
 ;
 ; Check for exceptions
 S RCDSUB=0,NOTOK=0
 F  S RCDSUB=$O(^RCY(344.4,RCERA,1,RCDSUB)) Q:'RCDSUB  D  Q:NOTOK
 . ;
 . ; Exception exists if INVALID BILL NUMBER field is populated in #344.41
 . S RCD0=$G(^RCY(344.4,RCERA,1,RCDSUB,0)) S:($P(RCD0,U,5)]"") NOTOK=1
 ;
 ; Cannot auto-post if exceptions exist
 Q:NOTOK 0
 ;
 ; Ignore ERA if ERA level Adjustments exist
 I $O(^RCY(344.4,RCERA,2,0)) Q 0
 ; BEGIN PRCA*4.5*326
 ; Ignore non-ACH type ERA to prevent CHK type ERA from automatically auto-posting in nightly job - PRCA*4.5*321
 ;I $$GET1^DIQ(344.4,RCERA_",",.15)'="ACH" Q 0 ; extended - PRCA*4.5*326
 ; Ignore non-valid auto-post ERA types
 I "^ACH^CHK^BOP^NON^"'[(U_$$GET1^DIQ(344.4,RCERA_",",.15)_U) Q 0
 ;
 ; ERA must be matched to an EFT to be eligible for mark for autopost
 I '$O(^RCY(344.31,"AERA",RCERA,"")) Q 0
 ; END PRCA*4.5*326
 ;
 ; Create scratchpad
 S RCSCR=$$SCRPAD^RCDPEAP(RCERA) Q:'RCSCR 0
 ;
 ; Ignore ERA if claim level adjustments without payment exist
 ; This will only get set if the scratchpad is created, not if it already exists.  
 ; Looking at the code, it will mainly set if there are ERA level adjustments and 
 ; may get set for unbalanced pairs, which is found by the ZEROBAL function.  So, 
 ; I think this does not have a real purpose but was not 100% sure.
 I $D(^TMP($J,"RCDPEWLA","ERA LEVEL ADJUSTMENT EXISTS")) D CLEAR^RCDPEAP(RCSCR) Q 0
 ;
 ; ERA needs to drop to standard worklist if adjustment between matching 
 ; positive/negative does not create a zero balance
 I '$$ZEROBAL(RCSCR) D CLEAR^RCDPEAP(RCSCR) Q 0
 ;
 ; Clear scratchpad
 D CLEAR^RCDPEAP(RCSCR)
 ;
 ; This is valid auto-post - return to MATCH^RCPDEM0
 Q 1
 ;
AUTOCHK2(RCERA,RCTYP) ; RCTYP added PRCA*4.5*321
 ; Check if this entry is an auto-post candidate
 ; This has the same/similar checks as MATCH^RCDPEM0 and AUTOCHK above.  If those procedures are
 ;  changed, this may need to updated as well.
 ; ; Input: RCERA       - IEN for file 344.4
 ;          RCTYP       - 0 - Called from Worklist/Mark for autopost  
 ;                        1 - Called from Manual match
 ; Returns: 1 - Auto-Post candidate
 ;          0^Reason - Not an auto-post candidate and reason 
 ; Validate Parameter
 I '$G(RCERA) Q "0^Invalid Parameter"
 I $G(RCTYP)="" Q "0^Invalid Parameter" ; PRCA*4.5*321
 I (RCTYP>1)!(RCTYP<0) Q "0^Invalid Parameter" ; PRCA*4.5*321
 ;
 ; PRCA*4.5*345 - Added PNAM,PTIN,XX
 N NOTOK,PNAM,PTIN,RCCREATE,RCDSUB,RCERATYP,RCSCR,RCXCLDE,RC0,STATUS,XX
 K ^TMP($J,"RCDPEWLA")
 ;
 ; Check if record exists
 I '$D(^RCY(344.4,RCERA,0)) Q "0^Invalid ERA record"
 ;
 ; Check current status
 S STATUS=$$GET1^DIQ(344.4,RCERA_",",4.02,"I")
 I STATUS=0 Q "0^Already marked for Auto-Posting"
 I STATUS=1 Q "0^Already partially Auto-Posted"
 I STATUS=2 Q "0^Already completely Auto-Posted"
 ;
 ; Check for matching
 I '$$GET1^DIQ(344.4,RCERA_",",.09,"I") Q "0^ERA not matched"
 ;
 ; Check for zero value ERA
 S RC0=$G(^RCY(344.4,RCERA,0))
 I +$P(RC0,U,5)=0 Q "0^Zero value ERA"
 ;
 ; Determine if ERA should be excluded using the site parameters
 S PNAM=$$GET1^DIQ(344.4,RCERA_",",.06,"E") ; PRCA*4.5*345 - Added line - Payer Name
 S PTIN=$$GET1^DIQ(344.4,RCERA_",",.03,"E") ; PRCA*4.5*345 - Added line - Payer TIN
 S XX=$$GETPAY^RCDPEU1(PNAM,PTIN)           ; PRCA*4.5*345 - Get the IEN from 344.6
 I $$CHKTYPE^RCDPEU1(XX,"T") S RCERATYP=2   ; PRCA*4.5*349 - Check if this is TRICARE ERA
 E  S RCERATYP=$$PHARM^RCDPEAP1(RCERA)      ; Else it must be a Medical or Rx ERA
 ;
 ; Check if medical claim and auto-posting is turned off
 S XX=$$GET1^DIQ(344.61,"1,",.02,"I")       ; PRCA*4.5*345 - Added line - Med Auto-Posting on/off
 I RCERATYP=0,'XX Q "0^Medical auto-posting off"    ; PRCA*4.5*345 - Changed 'RCERATYP to RCEARTYP=0
 ;
 ; Check if pharmacy claim and auto-posting is turned off
 S XX=$$GET1^DIQ(344.61,"1,",1.01,"I")      ; PRCA*4.5*345 - Added line - Rx Auto-Posting on/off
 I RCERATYP=1,'XX Q "0^Pharmacy auto-posting off"   ; PRCA*4.5*345 - Changed RCERATYP to RCEARTYP=1
 ;
 ; Check if TRICARE claim and auto-posting is turned off
 S XX=$$GET1^DIQ(344.61,"1,",1.05,"I")              ; PRCA*4.5*349 - Added line - TRICARE Auto-Posting on/off
 I RCERATYP=2,'XX Q "0^TRICARE auto-posting off"    ; PRCA*4.5*349 - Added line
 ;
 ; Check if ERA payer is excluded from autopost
 S RCXCLDE=0
 S:RCERATYP=0 RCXCLDE=$$EXCLUDE(RCERA)              ; PRCA*4.5*345 - Changed to =0 from 'RCERATYP
 S:RCERATYP=1 RCXCLDE=$$EXCLDRX(RCERA)              ; PRCA*4.5*345 - Changed to =1 from RCERATYP
 S:RCERATYP=2 RCXCLDE=$$EXCLDTR(RCERA)              ; PRCA*4.5*349 - Added Line
 I RCXCLDE Q "0^"_$S(RCERATYP=1:"Pharmacy",RCERATYP=2:"TRICARE",1:"Medical")_" payer excluded" ; PRCA*4.5*349
 ;
 ; Check for invalid bill number exception
 S RCDSUB=0,NOTOK=0
 F  S RCDSUB=$O(^RCY(344.4,RCERA,1,RCDSUB)) Q:'RCDSUB  D  Q:NOTOK
 . S RCD0=$G(^RCY(344.4,RCERA,1,RCDSUB,0))
 . I $P(RCD0,U,5)]"" S NOTOK=1
 I NOTOK Q "0^Invalid Bill Number Exception(s)"
 ;
 ; Check for ERA level Adjustments
 I $O(^RCY(344.4,RCERA,2,0)) Q "0^ERA level Adjustment(s)"
 ;
 ; Check if receipt already created
 I +$P(RC0,U,8) Q "0^ERA has a receipt"
 ;
 ; BEGIN PRCA*4.5*326
 ; Check payment type of ERA - CHK type is allowed for a manual match
 ;I "^ACH^CHK^"'[(U_$P(RC0,U,15)_U) Q "0^Payment Type is not ACH or CHK" ; PRCA*4.5*321
 ; Check payment type of ERA - now also includes CHK, NON and BOP type from manual match
 I "^ACH^CHK^BOP^NON^"'[(U_$P(RC0,U,15)_U) Q "0^Payment Type is not ACH, CHK, BOP or NON"
 ;
 ; CHK type ERA must be matched to an EFT to be eligible for mark for autopost
 ;I $P(RC0,U,15)="CHK",'$O(^RCY(344.31,"AERA",RCERA,"")) Q "0^ERA is not matched to an EFT" ; PRCA*4.5*321
 ;  CHK, NON and BOP type ERA must be matched to an EFT to be eligible for mark for autopost
 I "^CHK^BOP^NON^"'[(U_$P(RC0,U,15)_U),'$O(^RCY(344.31,"AERA",RCERA,"")) Q "0^ERA is not matched to an EFT" ; 
 ; END PRCA*4.5*326
 ;
 ; Create scratchpad if needed
 S RCCREATE=0
 S RCSCR=+$O(^RCY(344.49,"B",RCERA,0))
 I 'RCSCR S RCSCR=$$SCRPAD^RCDPEAP(RCERA) S RCCREATE=1
 I 'RCSCR Q "0^Unable to create scratchpad"
 ;
 ; Check if claim level adjustments without payment exist
 ; Note that PRCA*298 sets this temp global only if the scratchpad is created by the call above ($$SCRPAD^RCDPEAP). If the
 ;   scratchpad already exists, the TMP global will never get set.   Looking at the code, it will mainly set if there
 ;   are ERA level adjustments and may get set for unbalanced pairs, which is found by the ZEROBAL function.  So, I think
 ;   this does not have a real purpose but was not 100% sure and wanted to mimic what AUTOCHK does.
 I $D(^TMP($J,"RCDPEWLA","ERA LEVEL ADJUSTMENT EXISTS")) D:RCCREATE CLEAR^RCDPEAP(RCSCR) Q "0^Claim Level Adjustments w/o payment"
 ;
 ; Check if adjustment between matching positive/negative does not create a zero balance
 I '$$ZEROBAL(RCSCR) D:RCCREATE CLEAR^RCDPEAP(RCSCR) Q "0^+/- pairs do not balance"
 ;
 ; Clear scratchpad if it was created by this function
 D:RCCREATE CLEAR^RCDPEAP(RCSCR)
 ;
 ;If we got this far, this is an autopost candidate so quit with 1
 Q 1
 ;
EXCLUDE(RCERA) ; Verify if auto-posting is allowed for this Payer - PRECHECK USED IN RCDPEM0
 ; Not allowed if medical auto-posting is switched off
 ; Input:   RCERA   - IEN for file 344.4
 ; Returns: 1 - Exclude ERA becaus Payer is in exclusion table, 0 otherwise
 ; PRCA*4.5*345 - changed to $$GET1^DIQ calls below
 Q:'$$GET1^DIQ(344.61,"1,",.02,"I") 1      ; Medical Auto-Posting is turned OFF
 ;
 ; Check if Payer Name and Payer ID from ERA are in auto-posting payer table
 N RCPID,RCPNM,RCPXDA
 S RCPNM=$$GET1^DIQ(344.4,RCERA_",",.06,"E")
 Q:RCPNM="" 1                               ; No Payer Name
 S RCPID=$$GET1^DIQ(344.4,RCERA_",",.03,"E")
 Q:RCPID="" 1                               ; No Payer TIN
 ;
 ; Auto-post is allowed if this is a new payer (not in table)
 S RCPXDA=$O(^RCY(344.6,"CPID",RCPNM,RCPID,""))
 Q:RCPXDA="" 0
 ;
 ; If payer table entry found check if payer is excluded from medical auto-post
 Q:$$GET1^DIQ(344.6,RCPXDA_",",.06,"I")=1 1
 ;
 ; Otherwise it is OK to auto-post
 Q 0
 ;
PHARM(RCERA) ;Check if ERA is for Pharmacy only (ECME number on first line) - CALLED FROM RCDPEM0
 N SUB S SUB=$O(^RCY(344.4,RCERA,1,0)) Q:'SUB 0
 Q:$P($G(^RCY(344.4,RCERA,1,SUB,4)),U,2)]"" 1
 Q 0
 ;
ERADET(RCERA,RCRCPTDA,RCLINES) ; called on subsequent attempts of auto-post for a given ERA (DAY 2, DAY 3, ex.)
 ;  update ERA with receipt or if not posted then update the AUTO-POST REJECTION REASON (#5)
 ;
 ; RCERA = ien of entry in file 344.4
 ; RCRCPTDA = ien of receipt number (344, .01) - optional
 ; RCLINES = array of ERA line references
 ;
 I '$G(RCERA) Q
 S RCRCPTDA=$G(RCRCPTDA)
 ;
 N DA,DIC,DIE,DLAYGO,DO,DR,X
 ; Update receipt.  If this is the first receipt, put it in the RECEIPT (#08) field.  If not, put in OTHER RECEIPTS multiple (#344.48)
 I RCRCPTDA D
 . I $P($G(^RCY(344.4,RCERA,0)),U,8)]"" S DA(1)=RCERA,DIC="^RCY(344.4,"_DA(1)_",8,",DIC(0)="L",X=RCRCPTDA D FILE^DICN I 1
 . E  S DIE="^RCY(344.4,",DR=".14////1;.08////"_RCRCPTDA,DA=RCERA D ^DIE
 ;
 ; Update ERA detail line with Receipt or reject reason as appropriate
 ; PRCA*4.5*318 begins
 N RCLIN,REJECT
 S RCLIN=0
 F  S RCLIN=$O(RCLINES(RCLIN)) Q:'RCLIN  D
 . ; Set REJECT to true if the line was rejected during validation
 . S REJECT=0 I '$P(RCLINES(RCLIN),U) S REJECT=1
 . ;If not posted then update the AUTO-POST REJECTION REASON (#5)
 . ;Otherwise update line with receipt number and autopost date
 . S DA(1)=RCERA,DA=RCLIN,DIE="^RCY(344.4,"_DA(1)_",1,"
 . I 'REJECT,'RCRCPTDA Q
 . I REJECT S DR="5///"_$P(RCLINES(RCLIN),U,3)
 . E  S DR=".25///"_RCRCPTDA_";9///"_DT
 . D ^DIE
 ; PRCA*4.5*318 ends
 Q
 ;
ZEROBAL(RCSCR) ;
 ; per requirements, only positive/negative payment pairs where payment 
 ; calculates to zero are allowed for auto-post
 ; if payment ends up less than zero or greater than zero then ERA cannot
 ;be autoposted.  
 ; ERA gets sent to the standard worklist for manual receipt processing
 ; note:  a payment pair represents 2 EEOB sequences with the same claim
 ;         RCSCR - 344.49 ien
 ;         X - returns 1 or 0
 ; 
 N SUB,SUB1,WLINE,X,ERALINE
 S SUB=0,X=1,ERALINE=""
 F  S SUB=$O(^RCY(344.49,RCSCR,1,"B",SUB)) Q:SUB=""  D
 . ;Get scratchpad line and data 
 . S SUB1=$O(^RCY(344.49,RCSCR,1,"B",SUB,"")) Q:'SUB1  S WLINE=$G(^RCY(344.49,RCSCR,1,SUB1,0))
 . ;If integer sequence, get ERA line reference then quit for this sequence and go on to the non-integer sequence to finish validation
 . I $P(WLINE,U)?1N.N S ERALINE=$P(WLINE,U,9) Q 
 . ; there are multiple EEOB sequences for the specific bill number so an adjustment took place; 
 . ; if payment adjustment doesn't generate a zero payment balance at 344.491,.06 then this ERA needs to drop to standard worklist
 . I ERALINE[",",+$P(WLINE,U,6)'=0 S X=0 Q
 . ;do not autopost ERA if one of payments is negative amount
 . I $P(WLINE,U,6)<0 S X=0
 Q X
 ;
EXCLDRX(RCERA) ; Verify if auto-posting is allowed for Pharmacy claims 
 ; and for the Payer - PRECHECK USED IN RCDPEM0. Not allowed if pharmacy 
 ; auto-posting is switched off
 ; Input:   RCERA   - IEN for file 344.4
 ; Returns: 1 - ERA is excluded from Auto-Posting, 0 otherwise
 Q:'$$GET1^DIQ(344.61,"1,",1.01,"I") 1      ; Rx Auto-Posting is turned OFF
 N RCPID,RCPNM,RCPXDA
 ;
 ; Check if Payer Name and Payer ID from ERA are in auto-posting payer table
 S RCPNM=$$GET1^DIQ(344.4,RCERA_",",.06,"E")
 Q:RCPNM="" 1                               ; No Payer Name
 S RCPID=$$GET1^DIQ(344.4,RCERA_",",.03,"E")
 Q:RCPID="" 1                               ; No Payer TIN
 ; 
 ; Auto-post is allowed if this is a new payer (not in table)
 S RCPXDA=$O(^RCY(344.6,"CPID",RCPNM,RCPID,"")) Q:RCPXDA="" 0
 ;
 ; If payer table entry found check if payer is excluded from pharmacy auto-post
 Q:$$GET1^DIQ(344.6,RCPXDA_",",.08,"I")=1 1
 ;
 ; Otherwise it is OK to auto-post
 Q 0
 ;
EXCLDTR(RCERA) ; Verify if auto-posting is allowed for TRICARE claims
 ; and for the Payer - PRECHECK USED IN RCDPEM0. Not allowed if TRICARE
 ; auto-posting is switched off
 ; PRCA*4.5*349 - Added function
 ; Input: RCERA - IEN for file 344.4
 ; Returns: 1 - ERA is excluded from Auto-Posting, 0 otherwise
 Q:'$$GET1^DIQ(344.61,"1,",1.05,"I") 1 ; TRICARE Auto-Posting is turned OFF
 N RCPID,RCPNM,RCPXDA
 ;
 ; Check if Payer Name and Payer ID from ERA are in auto-posting payer table
 S RCPNM=$$GET1^DIQ(344.4,RCERA_",",.06,"E")
 Q:RCPNM="" 1 ; No Payer Name
 S RCPID=$$GET1^DIQ(344.4,RCERA_",",.03,"E")
 Q:RCPID="" 1 ; No Payer TIN
 ;
 ; Auto-post is allowed if this is a new payer (not in table)
 S RCPXDA=$O(^RCY(344.6,"CPID",RCPNM,RCPID,"")) Q:RCPXDA="" 0
 ;
 ; If payer table entry found check if payer is excluded from TRICARE auto-post
 Q:$$GET1^DIQ(344.6,RCPXDA_",",.13,"I")=1 1
 ;
 ; Otherwise it is OK to auto-post
 Q 0
 ;
VALID(RCERA,RCLINES) ;
 ;Verify which scratchpad lines are able to auto-post - called by EN2^RCDPEAP
 ;
 ; RCERA - Electronic Remittance Advice (#344.4) IEN
 ; RCLINES - Array of ERA line references (passed in by reference)
 ;           RCLINES(ERALINE)=1  - ERA line(s) are postable.  Also RCLINES counter is incremented.
 ;           RCLINES(ERALINE)=0^^Reject Reason Code - ERA line(s) are not postable
 ;           NOTE: ORIGINAL ERA SEQUENCES (#.09) can have multiple ERA line references separated by commas (e.g.,"3,4")
 ;
 ;Check for ScratchPad entry.  If missing (should not happen), quit
 N RCSCR
 S RCSCR=$O(^RCY(344.49,"B",+$G(RCERA),""))
 I RCSCR="" S RCLINES=0 Q
 ;Loop through scratchpad for this ERA
 N SUB,SUB1,WLINE,ERALINE,PIECE,SEQ,CLAIM,STATUS,CLARRAY,AUTOPOST
 S SUB=0 F  S SUB=$O(^RCY(344.49,RCSCR,1,"B",SUB)) Q:SUB=""  D
 . ;Get scratchpad line and data
 . S SUB1=$O(^RCY(344.49,RCSCR,1,"B",SUB,""))
 . I 'SUB1 Q
 . S WLINE=$G(^RCY(344.49,RCSCR,1,SUB1,0))
 . ;If integer sequence, get ERA line reference and check for auto-post flag
 . I $P(WLINE,U)?1N.N D  Q
 .. S ERALINE=$P(WLINE,U,9)
 .. ; If ERA reference is missing (should not happen), skip ahead to next integer sequence
 .. I ERALINE="" S SUB=SUB\1_".999" Q
 .. ; Check for receipt - PRCA*4.5*318 
 .. I $$GET1^DIQ(344.41,ERALINE_","_RCERA_",",.25)]"" S SUB=SUB\1_".999" Q  ; PRCA*4.5*318
 .. S AUTOPOST=1
 .. F PIECE=1:1 S SEQ=$P(ERALINE,",",PIECE) Q:'SEQ  I '$P($G(^RCY(344.4,RCERA,1,SEQ,5)),U,2) S AUTOPOST=0 Q
 .. ; Unless all of the associated ERA detail lines are set for auto-post, skip ahead to next integer sequence
 .. I 'AUTOPOST S SUB=SUB\1_".999" Q
 . ;If no claim number (suspense), set to autopost but check the rest of the lines for the ERA reference
 . S CLAIM=$P(WLINE,U,7)
 . I 'CLAIM S RCLINES(ERALINE)=1 Q
 . ;Quit with error if claim is not OPEN or ACTIVE
 . S STATUS=$P($G(^PRCA(430,CLAIM,0)),"^",8)
 . I STATUS'=42,STATUS'=16 S RCLINES(ERALINE)="0^^5",SUB=SUB\1_".999" Q
 . ;Quit with error if referred to general council
 . I $P($G(^PRCA(430,CLAIM,6)),U,4)]"" S RCLINES(ERALINE)="0^^7",SUB=SUB\1_".999" Q
 . ;Check for negative payment amount
 . I $P(WLINE,U,6)<0 S RCLINES(ERALINE)="0^^6",SUB=SUB\1_".999" Q
 . ;Increment claim balance.  If payment exceeds claim balance and no pending payments (at the time of auto posting), quit
 . ;  with error.  Also deduct the amount from the balance so subsequent, smaller amounts may get posted
 . S CLARRAY(CLAIM)=+$G(CLARRAY(CLAIM))+$P(WLINE,U,3)
 . I '$$CHECKPAY^RCDPEAP(.CLARRAY,CLAIM) S RCLINES(ERALINE)="0^^3",SUB=SUB\1_".999",CLARRAY(CLAIM)=+$G(CLARRAY(CLAIM))-$P(WLINE,U,3) Q
 . ;Line is potentially postable - update flag
 . S RCLINES(ERALINE)=1
 ;
 ;Reset the MARK FOR AUTOPOST flag on ERA lines and return count of auto-postable lines - PRCA*4.5*318
 N DA,DIE,DR,RCLIN,RCI
 S RCLIN=0,RCLINES=0 F  S RCLIN=$O(RCLINES(RCLIN)) Q:'RCLIN  D
 . I +RCLINES(RCLIN) S RCLINES=RCLINES+1
 . ;Set MARK FOR AUTO-POST (#6) to NO for every line
 . S DA(1)=RCERA,DA=RCLIN,DIE="^RCY(344.4,"_DA(1)_",1,"
 . S DR="6///0"
 . D ^DIE
 Q
 ;
UNBAL(RCERA) ; PRCA*4.5*318 added method
 ; Determine if the ERA total matches the EFT total for the selected ERA
 ; Input:   RCERA    - Internal IEN of the selected ERA
 ; Returns: 1 - ERA is unbalanced, 0 otherwise
 N RCLTOT,RCSUB,RCTOT
 ;ERA total balance - on matched ERAs the ERA total balance is the same as the EFT total
 S RCTOT=+$$GET1^DIQ(344.4,RCERA_",",.05)
 ;Sum of ERA claim line payments
 S RCSUB=0,RCLTOT=0
 F  S RCSUB=$O(^RCY(344.4,RCERA,1,RCSUB)) Q:'RCSUB  D
 . S RCLTOT=RCLTOT+$$GET1^DIQ(344.41,RCSUB_","_RCERA_",",.03)
 ;Plus sum of ERA adjustment lines
 S RCSUB=0
 F  S RCSUB=$O(^RCY(344.4,RCERA,2,RCSUB)) Q:'RCSUB  D
 . S RCLTOT=RCLTOT+$$GET1^DIQ(344.42,RCSUB_","_RCERA_",",.03)
 ;Return 1 if total of ERA lines does not match EFT
 Q $S(RCTOT=RCLTOT:0,1:1)
