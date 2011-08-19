ORXTABS4 ; SLC/PKS - Edit calls, tab parameters preferences. [9/28/00 3:05pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,47,84**;Dec 17, 1997
 ;
 ; NOTES: The routines herein are called by those of the same tag 
 ;        name in ORXTABS2.  Most variables are NEW'd and assigned 
 ;        by one or more routines in the preceding call chains. 
 ;        Refer to comments and notes there for additional infor-
 ;        mation.  
 ;
 ;   Each tag in this routine must return one of the following:
 ;
 ;      1 - A new value entered or selected by the user,
 ;      2 - A null string,
 ;      3 - The string "*Invalid*" - to repeat due to invalid entry,
 ;      4 - The "^" character, indicating user's cancel action.
 ;
 Q
 ;
STATUS(TYPE) ; Status, for various tabs.
 ;
 ; Internal variables used:
 ;
 ;    ORXAUTH  = Holds current value of AUTHOR value for some TYPEs.
 ;    ORXFLAG  = Used in set/reset of ORDSTS^ORCHANG2 values.
 ;    ORXP1    = Prompt piece holder.
 ;    ORXP2    = Prompt piece holder.
 ;    ORXSCNT  = Loop counter.
 ;    ORXSETC  = Set of codes for assignment to DIR(0) variable.
 ;    ORXSTAGS = Orders STATUS tags, in routine ORXCHANG2 or herein.
 ;    TYPE     = Type of STATUS being processed; must be one of:
 ;
 ;                 - ORDERS
 ;                 - CONSULTS
 ;                 - NOTES
 ;                 - D/C SUMMARIES
 ;                 - PROBLEMS
 ;
 N ORXAUTH,ORXFLAG,ORXP1,ORXP2,ORXSCNT,ORXSETC,ORXSTAGS
 ;
 ; Process DIR call through IF statements below, based on TYPE.
 ;
 ; Orders and Consults:
 ;
 ;    NOTE: Displayed choices are numerically sequential as coded.
 ;          Actual storage number values come from routine data tags. 
 ;          Thus, the default entry must be converted before
 ;          display, reset before updates - as is done below.
 ;
 I ((TYPE="ORDERS")!(TYPE="CONSULTS")) D
 .K ORXSTAGS                                 ; Clean up each time.
 .S ORXSCNT=0                                ; Initialize counter.
 .S ORXFLAG=1                                ; Start true each time.
 .;
 .; Establish loop for tag entries:
 .F  D  Q:(ORXSTAGS(ORXSCNT)="")!(ORXSTAGS(ORXSCNT)["ZZZ")
 ..S ORXSCNT=ORXSCNT+1                       ; Increment counter.
 ..;
 ..; Assign retrieved values to ORXSTAGS array:
 ..S ORXSTAGS="ORDSTS+"_ORXSCNT_"^ORCHANG2"  ; ORDERS data tag.
 ..;
 ..; For CONSULTS set a different data tag:
 ..I TYPE="CONSULTS" S ORXSTAGS="CORDSTS+"_ORXSCNT
 ..;
 ..S ORXSTAGS(ORXSCNT)=ORXSCNT_";"_$P($T(@ORXSTAGS),";;",2)
 ..I (ORXSTAGS(ORXSCNT)="")!(ORXSTAGS(ORXSCNT)["ZZZ") Q
 ..;
 ..; Reset ORXNOW (current value) number when found:
 ..I ORXFLAG D
 ...I $P(ORXSTAGS(ORXSCNT),";",2)=ORXNOW S ORXNOW=$P(ORXSTAGS(ORXSCNT),";",1) S ORXFLAG=0                         ; Do only once each time.
 ..;
 ..; Continue building prompt strings from retrieved values:
 ..S ORXP1=$P(ORXSTAGS(ORXSCNT),";",1)       ; First prompt piece.
 ..S ORXP1=$$LJ^XLFSTR(ORXP1,9)              ; Format for 9 chars.
 ..S ORXP2=$P(ORXSTAGS(ORXSCNT),";",3)       ; Second prompt piece.
 ..S ORXP2=$$LJ^XLFSTR(ORXP2,24)             ; Format for 24 chars.
 ..;
 ..; Assign DIR("A") display array:
 ..S DIR("A",ORXSCNT)=ORXP1_ORXP2            ; Complete prompt string.
 .;
 .; Check for bad/missing tag data:
 .I ORXSCNT<2 W !!,"ERROR: Bad data tag entry(ies)." S ORXNOW="^" Q
 .;
 .; Assign remaining DIR variables:
 .S DIR("T")=120 ; Two minute maximum timeout for response.
 .S DIR("A")="   Enter # for type of "_ORXPDIS_" to display:  "
 .S DIR("?")="   Entry must be between 1 and "_(ORXSCNT-1)
 .S DIR(0)="NA^1:"_(ORXSCNT-1)               ; Numerical, required.
 .;
 .; Call tag to get/assign input:
 .D INPUT^ORXTABS2
 .;
 .; Check for user abort:
 .I ORXNOW="^" Q
 .;
 .; Reset user entry to actual number from data tag in use:
 .S:ORXNOW'="" ORXNOW=$P(ORXSTAGS(ORXNOW),";",2)
 ;
 ; Notes and D/C Summaries:
 I ((TYPE="NOTES")!(TYPE="D/C SUMMARIES")) D
 .;
 .; Assign values retrieved to ORXSTAGS array:
 .S ORXP1="1"                                ; First piece.
 .S ORXP1=$$LJ^XLFSTR(ORXP1,9)               ; Format for 9 chars.
 .S ORXP2="All Signed"                       ; Second piece.
 .S ORXP2=$$LJ^XLFSTR(ORXP2,24)              ; Format for 24 chars.
 .S DIR("A",1)=ORXP1_ORXP2                   ; First prompt string.
 .S ORXP1="2"                                ; First piece.
 .S ORXP1=$$LJ^XLFSTR(ORXP1,9)               ; Format for 9 chars.
 .S ORXP2="My Unsigned"                      ; Second piece.
 .S ORXP2=$$LJ^XLFSTR(ORXP2,24)              ; Format for 24 chars.
 .S DIR("A",2)=ORXP1_ORXP2                   ; Second prompt string.
 .S ORXP1="3"                                ; First piece.
 .S ORXP1=$$LJ^XLFSTR(ORXP1,9)               ; Format for 9 chars.
 .S ORXP2="My Un-cosigned"                   ; Second piece.
 .S ORXP2=$$LJ^XLFSTR(ORXP2,24)              ; Format for 24 chars.
 .S DIR("A",3)=ORXP1_ORXP2                   ; Third prompt string.
 .S ORXP1="4"                                ; First piece.
 .S ORXP1=$$LJ^XLFSTR(ORXP1,9)               ; Format for 9 chars.
 .S ORXP2="Signed/Author"                    ; Second piece.
 .S ORXP2=$$LJ^XLFSTR(ORXP2,24)              ; Format for 24 chars.
 .S DIR("A",4)=ORXP1_ORXP2                   ; Fourth prompt string.
 .S ORXP1="5"                                ; First piece.
 .S ORXP1=$$LJ^XLFSTR(ORXP1,9)               ; Format for 9 chars.
 .S ORXP2="Signed/Dates"                     ; Second piece.
 .S ORXP2=$$LJ^XLFSTR(ORXP2,24)              ; Format for 24 chars.
 .S DIR("A",5)=ORXP1_ORXP2                   ; Fifth prompt string.
 .;
 .; Assign remaining DIR variables:
 .S DIR("T")=120 ; Two minute maximum timeout for response.
 .S DIR("A")="   Enter # for type of "_ORXPDIS_" to display:  "
 .S DIR("?")="   Entry must be between 1 and 5"
 .S DIR(0)="NA^1:5"                          ; Numerical, required.
 .;
 .; Call tag to get/assign input:
 .D INPUT^ORXTABS2
 .;
 .; Check for user abort:
 .I ORXNOW="^" Q
 .;
 .; Use ORXAUTH twice to Check for valid entry:
 .I ORXNOW'="" D
 ..I (ORXCNT+1)<1 W !!,"ERROR: Improper TABS entry." S ORXNOW="^" Q
 ..S ORXAUTH=$P($G(ORXSETS),";",ORXCNT+1)
 ..I ORXAUTH'="AUTHOR" W !!,"ERROR: Improper TABS entry." S ORXNOW="^" Q
 ..S ORXAUTH=$P($G(ORXCUR),";",$P($G(ORXPCS),";",ORXCNT+1))
 ..I ((ORXAUTH="")&(ORXNOW=4)) S $P(ORXCUR,";",$P($G(ORXPCS),";",ORXCNT+1))=+DUZ Q                                ; STATUS 4 = DUZ AUTHOR.
 ..I ORXAUTH="" Q                            ; Stop if already null.
 ..;
 ..; For all other entries, set matching AUTHOR value to null:
 ..S $P(ORXCUR,";",$P($G(ORXPCS),";",ORXCNT+1))=""
 .;
 .; Check for deletion entry:
 .I ORXNOW="@" S ORXNOW=""
 ;
 ; Problems:
 I TYPE="PROBLEMS" D
 .K ORXSTAGS                                 ; Clean up each time.
 .S ORXSETC=""                               ; Clear each time.
 .S ORXSCNT=0                                ; Initialize counter.
 .;
 .; Establish loop for tag entries:
 .F  D  Q:(ORXSTAGS(ORXSCNT)="")!(ORXSTAGS(ORXSCNT)["ZZZ")
 ..S ORXSCNT=ORXSCNT+1                       ; Increment counter.
 ..;
 ..; Assign retrieved values to ORXSTAGS array:
 ..S ORXSTAGS="PLSTS+"_ORXSCNT_"^ORCHANG2"   ; Data tags.
 ..S ORXSTAGS(ORXSCNT)=$P($T(@ORXSTAGS),";;",2)
 ..I (ORXSTAGS(ORXSCNT)="")!(ORXSTAGS(ORXSCNT)["ZZZ") Q
 ..S ORXP1=$P(ORXSTAGS(ORXSCNT),";",1)       ; First prompt piece.
 ..S:ORXSCNT=1 ORXSETC=ORXP1_":"             ; DIR codes string.
 ..S:ORXSCNT>1 ORXSETC=ORXSETC_";"_ORXP1_":" ;         "
 ..S ORXP1=$$LJ^XLFSTR(ORXP1,9)              ; Format for 9 chars.
 ..S ORXP2=$P(ORXSTAGS(ORXSCNT),";",2)       ; Second prompt piece.
 ..S ORXSETC=ORXSETC_ORXP2                   ; DIR codes string.
 ..S ORXP2=$$LJ^XLFSTR(ORXP2,24)             ; Format for 24 chars.
 ..;
 ..; Assign DIR("A") display array:
 ..S DIR("A",ORXSCNT)=ORXP1_ORXP2            ; Complete prompt string.
 .;
 .; Check for bad/missing data:
 .I ORXSCNT<2 W !!,"ERROR: Bad PLSTS tag data." S ORXNOW="^" Q
 .;
 .; Assign remaining DIR variables:
 .S DIR("T")=120 ; Two minute maximum timeout for response.
 .S DIR("A")="   Enter types of "_ORXPDIS_" to display:  "
 .S DIR(0)="SAO^"_ORXSETC                    ; Optional, Set of Codes.
 .;
 .; Call tag to get/assign input:
 .D INPUT^ORXTABS2
 .;
 .; Check for user abort:
 .I ORXNOW="^" Q
 .;
 .; Check for deletion entry:
 .I ORXNOW="@" S ORXNOW=""
 ;
 Q
 ;
 ;
 ; NOTES ON ENTRIES FOR "CORDSTS" TAG:
 ;    CORDSTS entries below match previous LM CONSULTS ORDERS
 ;    "STATUS" settings allowed.  They are also listed in the 
 ;    ORQ1 routine.  The listings consist of 2 pieces:
 ;
 ;         ValueToBeStoredInParam;ListingDescription
 ;    
CORDSTS ; Consults ORDERS "STATUS" settings.
 ;;1;Discontinued
 ;;2;Complete
 ;;5;Pending
 ;;6;Active
 ;;8;Scheduled
 ;;9;Partial Results
 ;;13;Cancelled
 ;;;All Statuses
 ;;;ZZZZ
 ;
 Q
 ;
