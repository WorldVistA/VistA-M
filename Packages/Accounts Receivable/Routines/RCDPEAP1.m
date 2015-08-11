RCDPEAP1 ;ALB/KML - AUTO POST MATCHING EFT ERA PAIR - CONT. ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
 ;-------------------
 ;RCDPEM0 SUBROUTINES
 ;-------------------
AUTOCHK(RCERA) ;Verify if ERA can be auto-posted - PRE-CHECK USED IN RCDPEM0
 N NOTOK,RCDSUB,RCD0,RCSCR
 K ^TMP($J,"RCDPEWLA")
 ;Check for exceptions
 S RCDSUB=0,NOTOK=0
 F  S RCDSUB=$O(^RCY(344.4,RCERA,1,RCDSUB)) Q:'RCDSUB  D  Q:NOTOK
 . ;Exception exists if INVALID BILL NUMBER field is populated in #344.41
 . S RCD0=$G(^RCY(344.4,RCERA,1,RCDSUB,0)) S:($P(RCD0,U,5)]"") NOTOK=1
 ;Cannot auto-post if exceptions exist
 Q:NOTOK 0
 ; Ignore ERA if ERA level Adjustments exist
 I $O(^RCY(344.4,RCERA,2,0)) Q 0
 ;Create scratchpad
 S RCSCR=$$SCRPAD^RCDPEAP(RCERA) Q:'RCSCR 0
 ;Ignore ERA if claim level adjustments without payment exist
 I $D(^TMP($J,"RCDPEWLA","ERA LEVEL ADJUSTMENT EXISTS")) D CLEAR^RCDPEAP(RCSCR) Q 0
 ; ERA needs to drop to standard worklist if adjustment between matching 
 ;positive/negative does not create a zero balance
 I '$$ZEROBAL(RCSCR) D CLEAR^RCDPEAP(RCSCR) Q 0
 ;Clear scratchpad
 D CLEAR^RCDPEAP(RCSCR)
 ;This is valid auto-post - return to MATCH^RCPDEM0
 Q 1
 ;
EXCLUDE(RCERA) ;Verify if auto-posting is allowed for this Payer - PRECHECK USED IN RCDPEM0
 ;Not allowed if medical auto-posting is switched off
 Q:'$P($G(^RCY(344.61,1,0)),U,2) 1
 ;Check if Payer Name and Payer ID from ERA are in auto-posting payer table
 N RCPNM,RCPID,RCPXDA
 S RCPNM=$P($G(^RCY(344.4,RCERA,0)),U,6) Q:RCPNM="" 1
 S RCPID=$P($G(^RCY(344.4,RCERA,0)),U,3) Q:RCPID="" 1
 ;Auto-post is allowed if this is a new payer (not in table)
 S RCPXDA=$O(^RCY(344.6,"CPID",RCPNM,RCPID,"")) Q:RCPXDA="" 0
 ;If payer table entry found check if payer is excluded from medical auto-post
 Q:$P($G(^RCY(344.6,RCPXDA,0)),U,6)=1 1
 ;Otherwise it is OK to auto-post
 Q 0
 ;
PHARM(RCERA) ;Check if ERA is for Pharmacy only (ECME number on first line) - CALLED FROM RCDPEM0
 N SUB S SUB=$O(^RCY(344.4,RCERA,1,0)) Q:'SUB 0
 Q:$P($G(^RCY(344.4,RCERA,1,SUB,4)),U,2)]"" 1
 Q 0
 ;
RECDET(RCERA,RCRCPTDA,RCLINES) ; called on subsequent attempts of auto-post for a given ERA (DAY 2, DAY 3, ex.)
 ;  update ERA with receipt or if not posted then update the AUTO-POST REJECTION REASON (344.41,5)
 ;
 ; RCERA = ien of entry in file 344.4
 ; RCRCPTDA = ien of receipt number (344, .01)
 ; RCLINES = array of ERA line references
 ;
 N DA,DIC,DIE,DLAYGO,DR,X,DO,RCO,RCLIN
 S RC0=$G(^RCY(344.4,RCERA,0))
 ; If a receipt reference is already at 344.4, .08, then add subsequent receipt at 344.48, .01 (OTHER RECEIPTS multiple)
 I $P(RC0,U,8)]"" D
 . S DA(1)=RCERA
 . S DIC="^RCY(344.4,"_DA(1)_",8,",DIC(0)="L",X=RCRCPTDA
 . D FILE^DICN
 E  S DIE="^RCY(344.4,",DR=".14////1;.08////"_RCRCPTDA,DA=RCERA D ^DIE
 N LNUM,RCI,REJECT
 S RCLIN=0 F  S RCLIN=$O(RCLINES(RCLIN)) Q:'RCLIN  D
 . ; flag the line if it was rejected during validation
 . S REJECT=0 I '$P(RCLINES(RCLIN),U) S REJECT=1
 . ;get all ERA line references; RCLINES(RCLIN) could have multiple line # references (e.g., RCLINES(3,4) or RCLINES(3))
 . ;Need to parse out each line reference so that the necessary fields can be updated for the specific line.
 . ;If not posted then update the AUTO-POST REJECTION REASON (344.41,5)  ;otherwise update line with receipt number and auto-post date
 . ; MARK FOR AUTO-POST (344.41, 6) needs to be reset for all lines
 . F RCI=1:1 S LNUM=$P(RCLIN,",",RCI) Q:LNUM=""  D
 . . S DA(1)=RCERA,DA=LNUM,DIE="^RCY(344.4,"_DA(1)_",1,"
 . . I REJECT S DR="5////"_$P(RCLINES(RCLIN),U,3)_";6////0"
 . . E  S DR=".25////"_RCRCPTDA_";9////"_DT_";6////0"
 . . D ^DIE
 Q
 ;
REJDET(RCERA,RCLINES) ; called on subsequent attempts of auto-post for a given ERA (DAY 2, DAY 3, ex.)
 ; called when a receipt has not been created due to an error condition
 ;  reset MARK FOR AUTOPOST and update REJECTION REASON for lines receiving validation errors
 ;
 ; RCERA = ien of entry in file 344.4
 ; RCLINES = array of ERA line references
 ;
 N LNUM,RCI,REJECT
 S RCLIN=0 F  S RCLIN=$O(RCLINES(RCLIN)) Q:'RCLIN  D
 . ; flag the line if it was rejected during validation
 . S REJECT=0 I '$P(RCLINES(RCLIN),U) S REJECT=1
 . ;get all ERA line references; RCLINES(RCLIN) could have multiple line # references (e.g., RCLINES(3,4) or RCLINES(3))
 . ;Need to parse out each line reference so that the necessary fields can be updated for the specific line.
 . ;If not posted then update the AUTO-POST REJECTION REASON (344.41,5)
 . ; MARK FOR AUTO-POST (344.41, 6) needs to be reset for all lines
 . F RCI=1:1 S LNUM=$P(RCLIN,",",RCI) Q:LNUM=""  D
 . . S DA(1)=RCERA,DA=LNUM,DIE="^RCY(344.4,"_DA(1)_",1,"
 . . I REJECT S DR="5////"_$P(RCLINES(RCLIN),U,3)_";6////0"
 . . D ^DIE
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
