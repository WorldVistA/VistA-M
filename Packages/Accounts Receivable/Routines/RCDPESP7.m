RCDPESP7 ;AITC/PJH - ePayment Lockbox Site Parameters Definition - auto-decrease ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**298,304,318,321,326,345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
PAID(PARMTYP) ;function, Paid claim auto-decrease parameters, PRCA*4.5*345 added PARMTYP
 ; Input: PARMTYP - 2 - Paid TRICARE Auto-Decrease parameters
 ;                  1 - Paid Rx Auto-Decrease parameters
 ;                  0 - Paid Medical Auto-Decrease parameters
 ;                  Optional, defaults to 0
 ; Returns: 0 - "OK"
 ;          1 - "ABORT"
 ;          2 - "SKIP"
 ;
 ; PRCA*4.5*345 logic changed below, FLD and CLMTYP variables added
 N ADAMT,ADMC,ADNAMT,CLMTYP,DIR,DTOUT,DUOUT,FDAEDI,FLD,RCAUDVAL,RCOK,RCQUIT,X,XX,Y
 S:'$G(PARMTYP) PARMTYP=0,CLMTYP="MEDICAL"
 S:PARMTYP=2 CLMTYP="TRICARE"                     ; PRCA*4.5*349 - Added line
 S:PARMTYP=1 CLMTYP="PHARMACY"                    ; PRCA*4.5*349 - Added line
 S FLD=$S(PARMTYP=2:1.06,PARMTYP=0:.03,1:1.02)    ; PRCA*4.5*349 - Added line
 S ADMC=$$GET1^DIQ(344.61,"1,",FLD,"I") ; Current value PRCA*4.5*349 - Changed .03 to FLD
 K DIR
 S DIR(0)="YA",DIR("B")=$S(ADMC=""!(ADMC=1):"Yes",1:"No")
 ;
 S DIR("A")="ENABLE AUTO-DECREASE OF "_CLMTYP_" CLAIMS WITH PAYMENTS (Y/N): "
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT")
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 ;
 ; If user changed value, update and audit
 S FLD=$S(PARMTYP=0:.03,PARMTYP=1:1.02,1:1.06) ; PRCA*4.5*349
 I ADMC'=Y D  ;
 . S FDAEDI(344.61,"1,",FLD)=Y
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_Y_U_ADMC
 . D:$D(FDAEDI) FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL)
 . K RCAUDVAL
 I Y=0 Q 2  ; Value set to No, update if needed
 ;
 ; Set auto-decrease maximum amount
ADAMT ; BEGIN - PRCA*4.5*326
 S FLD=$S(PARMTYP=0:.05,PARMTYP=1:1.04,1:1.07) ; PRCA*4.5*349
 S ADAMT=$$GET1^DIQ(344.61,"1,",FLD)
 K DIR
 S DIR("B")=ADAMT
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT")
 S DIR(0)="NA^1:99999:0"
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I ADAMT'=Y D
 . S FDAEDI(344.61,"1,",FLD)=Y,RCAUDVAL(2)="344.61^"_FLD_"^1^"_Y_U_ADAMT
 S ADNAMT=Y
 ;
 ; Check if any CARCs need reset and give choice to proceed
 S RCOK=$$CARCDSP^RCDPESP5(ADNAMT,PARMTYP)
 ;
 ; Finish if user exit selected
 Q:RCOK="QUIT" 1
 ;
 ; If user chooses to not reset then go back to re-enter maximum
 I RCOK=0 K FDAEDI(344.61,"1,",FLD),RCAUDVAL(2) G ADAMT
 ; END - PRCA*4.5*326
 ;
 ; File changes to Medical/Pharmacy Auto-Decrease parameters
 D:$D(FDAEDI) FILE^DIE(,"FDAEDI")
 D:$D(RCAUDVAL) AUDIT^RCDPESP(.RCAUDVAL)
 K FDAEDI,RCAUDVAL
 ; PRCA*4.5*345 - updated logic below with FLD and PARMTYP
 ; If auto-decrease on, ask about CARC/RARC auto-decrease setup
 W !
 S RCQUIT=0 D CARC(.RCQUIT,1,PARMTYP)
 W !
 S FLD=$S(PARMTYP=0:.03,PARMTYP=1:1.02,1:1.06) ; PRCA*4.5*349
 ;
 ; If no active CARCs turn Auto-Decrease off 
 I ($$COUNT^RCDPESP(1,0,PARMTYP)=0),($$GET1^DIQ(344.61,"1,",FLD,"I")=1) D  Q 2
 . N FDAEDI,MSGTXT,RCAUDVAL
 . S ADMC=$$GET1^DIQ(344.61,"1,",FLD,"I")
 . S FDAEDI(344.61,"1,",FLD)=0
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_0_U_ADMC_U
 . S XX=$S(PARMTYP=0:"Medical",PARMTYP=1:"Pharmacy",1:"TRICARE") ; PRCA*4.5*349 - Added line
 . S MSGTXT="SYSTEM disabled "_XX_" Auto-decrease, there are NO active CARCs"
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_0_U_ADMC_U_MSGTXT
 . D FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL)
 . W !,"*** The "_MSGTXT_".",!
 . D PAUSE^RCDPESP
 Q:RCQUIT 1
 ;
 ; Set number of days to wait before auto-decrease amount with payments
 S FLD=$S(PARMTYP=0:.04,PARMTYP=1:1.03,1:1.08)       ; PRCA*4.5*349
 S ADMT=$$GET1^DIQ(344.61,"1,",FLD) ; PRCA*4.5*349
 K DIR
 S:ADMT'="" DIR("B")=ADMT
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT"),DIR(0)="NA^0:7:0"
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I ADMT'=Y D  ;
 . S FDAEDI(344.61,"1,",FLD)=Y                ; PRCA*4.5*349
 . S RCAUDVAL(2)="344.61^"_FLD_"^1^"_Y_U_ADMT ; PRCA*4.5*349
 . ; File changes to medical no-pay auto-decrease parameters
 . D FILE^DIE(,"FDAEDI")
 . D:$D(RCAUDVAL) AUDIT^RCDPESP(.RCAUDVAL)
 . K RCAUDVAL
 Q 0
 ;
NOPAY(CLMTYP) ; function, No-payment claim auto-decrease parameters
 ; PRCA*4.5*345- Added CLMTYP
 ; Input CLMTYP - 0: Medical Claims, 1:Pharmacy, 2 - TRICARE
 ; Returns: 0: no issues, 1: ABORT, 2: SKIP
 ;
 N ADMC,ADMT,DIR,DTOUT,DUOUT,FDAEDI,FLD,MSGTXT,RCAUDVAL,RCQUIT,X,XX,Y
 ; If auto-decrease of paid claims is off skip auto-decrease no-pay parameters
 S FLD=$S(CLMTYP=0:.03,1:1.06)          ; PRCA*4.5*349
 I '$$GET1^DIQ(344.61,"1,",FLD,"I") Q 0 ; PRCA*4.5*349
 ;
 S FLD=$S(CLMTYP=0:.11,1:1.09)          ; PRCA*4.5*349
 S ADMC=$$GET1^DIQ(344.61,"1,",FLD,"I")  ; Get current value
 S DIR(0)="YA",DIR("B")=$S(ADMC=""!(ADMC=1):"Yes",1:"No")
 ;
 S XX=$S(CLMTYP=0:"MEDICAL",1:"TRICARE")
 S DIR("A")="ENABLE AUTO-DECREASE OF "_XX_" CLAIMS WITH NO PAYMENTS (Y/N): "
 S FLD=$S(CLMTYP=0:.11,1:1.09) ; PRCA*4.5*349 - Added line
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT")
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 ; if user changed value, update and audit
 I ADMC'=Y D  ;
 . S FDAEDI(344.61,"1,",FLD)=Y,RCAUDVAL(1)="344.61^"_FLD_"^1^"_Y_U_ADMC ; PRCA*4.5*349
 . D FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL)
 . K RCAUDVAL
 ;
 I Y=0 Q 2  ; Value set to No, update (if needed), go to Pharmacy params.
 ;
 ; If no-pay auto-decrease on, ask about CARC/RARC auto-decrease setup
 W !
 S RCQUIT=0
 D CARC(.RCQUIT,0,CLMTYP)
 W !
 ; If no active CARCs Turn medical no-pay auto-decrease off, Then go to Pharmacy params
 S ADMC=$$GET1^DIQ(344.61,"1,",FLD,"I") ; PRCA*4.5*349
 I ($$COUNT^RCDPESP(1,1,CLMTYP)=0)&(ADMC=1) D  Q 1
 . K FDAEDI,MSGTXT,RCAUDVAL
 . S FDAEDI(344.61,"1,",FLD)=0 ; PRCA*4.5*349
 . S XX=$S(CLMTYP=0:"Medical",1:"TRICARE") ; PRCA*4.5*349 - Added line
 . S MSGTXT="SYSTEM disabled "_XX_" No-pay Auto-decrease, there are NO active CARCs"
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^0^"_ADMC_U_MSGTXT ; PRCA*4.5*349
 . D FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL)
 . W !,"*** The "_MSGTXT,!
 . D PAUSE^RCDPESP
 Q:RCQUIT 1
 ;
 ; Set number of days to wait before no-pay auto-decrease amount
 S FLD=$S(CLMTYP=0:.12,1:1.1)       ; PRCA*4.5*349
 S ADMT=$$GET1^DIQ(344.61,"1,",FLD) ; PRCA*4.5*349
 K DIR
 S:ADMT'="" DIR("B")=ADMT
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT"),DIR(0)="NA^0:45:0"
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I ADMT'=Y D  ;
 . S FDAEDI(344.61,"1,",FLD)=Y                ; PRCA*4.5*349
 . S RCAUDVAL(2)="344.61^"_FLD_"^1^"_Y_U_ADMT ; PRCA*4.5*349
 . ; File changes to medical no-pay auto-decrease parameters
 . D FILE^DIE(,"FDAEDI")
 . D:$D(RCAUDVAL) AUDIT^RCDPESP(.RCAUDVAL)
 . K RCAUDVAL
 Q 0
 ;
CARC(RCQUIT,PAID,RCARCTYP) ; Update the CARC/RARC inclusion table
 ; PRCA*4.5*349 - Subroutine moved from RCDPESP5 for size.
 ; PRCA*4.5*345 - Added RCARCTYP for Rx Auto-Decrease CARC/RARC inclusion table
 ; Input:   RCQUIT  - Added RCQUIT as input parameter - PRCA*4.5*321
 ;          PAID    - 1 - Payment lines  0 = no-payment lines - PRCA*4.5*326
 ;          RCARCTYP   - 2 - TRICARE, 1 - Pharmacy, 0 - Medical
 ;                    Optional defaults to 0
 N F1,F2,RCANS,RCAUDARY,RCCARC,RCCHG,RCCDATA,RCCIEN,RCDESC,RCRSN,RCSTAT
 N RCAMT,RCNAMT,RCCARCDS,RCYN,RCVAL,RCACTV,RCTXT,XX
 S:'$D(RCARCTYP) RCARCTYP=0
 S RCTXT=$S(PAID:"",1:"NO-PAY ")  ; PRCA*4.5*326
 ;
 ; PRCA*4.5*349 - Fields for medical, Rx or TRICARE
 I PAID=1 D  ; Payment lines
 . S F1=$S(RCARCTYP=0:.02,RCARCTYP=1:2.01,1:3.01) ; Enabled
 . S F2=$S(RCARCTYP=0:.06,RCARCTYP=1:2.05,1:3.05) ; Amount
 E  D  ; No payment lines
 . S F1=$S(RCARCTYP=0:.08,RCARCTYP=1:2.01,1:3.07) ; Enabled (Note Rx does not have separate no-pay)
 . S F2=$S(RCARCTYP=0:.12,RCARCTYP=1:2.05,1:3.11) ; Amount
 ; 
 ; Display initial entry line
 W !,"AUTO-DECREASE "_RCTXT
 ;
 ; PRCA*4.5*345, PRCA*4.5*349 - Added pharmacy and TRICARE checks below
 W $S(RCARCTYP=0:"MEDICAL",RCARCTYP=1:"PHARMACY",1:"TRICARE")
 W " CLAIMS FOR THE FOLLOWING CARC/AMOUNTS ONLY:",!
 ;
 ; Loop until the user quits
 S RCANS=""
 F  D  Q:RCANS="Q"
 . ; Display list of currently enabled/disabled CARCs/RARCs
 . W !
 . D PRTCARC^RCDPESP5(PAID,RCARCTYP)  ; PRCA*4.5*326, PRCA*4.5*345 added RCARCTYP
 . W !!  ; skip lines
 . ; Ask user for the CARC/RARC to enable/disable (QUIT) [default] to exit
 . S RCCARC=$$GETCARC^RCDPESPB
 . I RCCARC=-1 S RCQUIT=1,RCANS="Q" Q
 . I RCCARC=0 S RCANS="Q" Q
 . ; Validate CARC entered
 . S RCVAL=$$VAL^RCDPCRR(345,RCCARC)   ; Validate CARC against File 345
 . S RCACTV=$$ACT^RCDPRU(345,RCCARC,DT)   ; Check if CARC is an active code
 . ; If the CARC is invalid, warn user and quit
 . I 'RCVAL D  Q
 . . W !,"The CARC code you have entered is not a valid CARC code.  Please try again"
 . ; Print CARC and description
 . S RCCARCDS=""
 . D GETCODES^RCDPCRR(RCCARC,"","A",$$DT^XLFDT,"RCCARCDS","1^100")
 . I $D(RCCARCDS("CARC",RCCARC))'=10 D
 . . D GETCODES^RCDPCRR(RCCARC,"","I",$$DT^XLFDT,"RCCARCDS","1^100")
 . S RCCIEN=$O(RCCARCDS("CARC",RCCARC,""))
 . S RCDESC=$P(RCCARCDS("CARC",RCCARC,RCCIEN),U,6)
 . ; If description longer than 70 characters, truncate add ellipsis
 . S:$L(RCDESC)>70 RCDESC=$E(RCDESC,1,70)_"..."
 . W !,?3,"  "_RCDESC,! ; PRCA*4.5*349 add ?3
 . I 'RCACTV W "   *** WARNING: CARC code "_RCCARC_" is no longer active.",!
 . ;
 . ; Look up CARC/RARC in table.
 . S RCCIEN=$O(^RCY(344.62,"B",RCCARC,""))
 . S (RCAMT,RCSTAT)=0  ; Initialize if new code entry for table
 . I RCCIEN D  ; Code exists in table
 . . ; PRCA*4.5*326, PRCA*4.5*345 begin
 . . ; Get current payment Auto-decrease status and Max decrease amount
 . . I PAID=1 D  ; Payment lines
 . . . S RCSTAT=$$GET1^DIQ(344.62,RCCIEN,F1,"I")
 . . . S RCAMT=$$GET1^DIQ(344.62,RCCIEN,F2)
 . . I PAID=0 D  ; No payment lines
 . . . S RCSTAT=$$GET1^DIQ(344.62,RCCIEN,F1,"I")
 . . . S RCAMT=$$GET1^DIQ(344.62,RCCIEN,F2)
 . . ; PRCA*4.5*326, PRCA*4.5*345 end
 . ; If CARC enabled
 . I RCCIEN,RCSTAT D  Q
 . . S RCNAMT=0,RCRSN=""
 . . ; Confirm that this is the correct CARC
 . . S RCYN=$$CONFIRM(4,PAID,RCARCTYP)  ; PRCA*4.5*326 -Added PAID, PRCA4*5*345 -Added RCARCTYP
 . . Q:RCYN=-1
 . . ; Ask for reason
 . . S RCRSN=$$GETREASN^RCDPESP5(RCCARC)
 . . Q:RCRSN=-1  ; User indicated to quit
 . . ; Confirm the disabling
 . . S RCYN=$$CONFIRM(3,PAID,RCARCTYP)  ; PRCA*4.5*326 -Added PAID, PRCA4*5*345 -Added RCARCTYP
 . . Q:RCYN=-1
 . . D UPDDATA^RCDPESP5(RCCIEN,0,RCAMT,RCRSN,PAID,RCARCTYP) ; If disabling - PRCA4*5*345 - Added RCARCTYP
 . . ; audit disabled CARC: "File^Field^IEN^New Value^Old Value^Comment"
 . . S RCAUDARY(1)="344.62^"_F1_"^"_RCCIEN_"^0^1^"_RCRSN ; PRCA*4.5*326
 . . D AUDIT^RCDPESP(.RCAUDARY)
 . ;
 . ; Confirm that this is the correct CARC to Enable
 . S RCYN=$$CONFIRM(1,PAID,RCARCTYP) ; Added PAID - PRCA*4.5*326
 . Q:RCYN=-1
 . ;
 . ; Ask for new amount
 . S RCNAMT=$$GETAMT^RCDPESPB(RCARCTYP)  ; PRCA4*5*345 - Added RCARCTYP
 . Q:RCNAMT=-1  ; User indicated to quit
 . ;
 . ; Ask for reason
 . S RCRSN=$$GETREASN^RCDPESP5(RCCARC)
 . Q:RCRSN=-1  ;User indicated to quit
 . ;
 . ; Confirm save
 . S RCYN=$$CONFIRM(2,PAID,RCARCTYP) ; Added PAID - PRCA*4.5*326 Added RCARCTYP
 . I (RCYN="N")!(RCYN=-1) W !,"NOT SAVED",! Q
 . ;
 . ; Re-enable if disabled and quit
 . I RCCIEN D  Q
 . . D UPDDATA^RCDPESP5(RCCIEN,1,RCNAMT,RCRSN,PAID,RCARCTYP)  ; Re-enable, update amount - PRCA*4.5*326 added RCARCTYP
 . . ; Update audit file with reason and changes (field format above)
 . . S RCAUDARY(1)="344.62^"_F1_"^"_RCCIEN_"^1^0^"_RCRSN  ; PRCA*4.5*326
 . . S RCAUDARY(2)="344.62^"_F2_"^"_RCCIEN_"^"_RCNAMT_"^"_RCAMT_"^"_RCRSN ; PRCA*4.5*326
 . . D AUDIT^RCDPESP(.RCAUDARY)
 . ;
 . ; Store new entry
 . D ADDDATA^RCDPESP5(RCCARC,RCNAMT,RCRSN,PAID,RCARCTYP) ; PAID added PRCA*4.5*326, PRCA4*5*345 - Added RCARCTYP
 . ;
 . ; Update audit file with reason and amount changes.
 . S RCCIEN=$$FIND1^DIC(344.62,"","",RCCARC,"","","RCERR")
 . S:RCCIEN="" RCCIEN="ERROR"
 . ;
 . S RCAUDARY(1)="344.62^"_F1_"^"_RCCIEN_"^1^0^"_RCRSN   ; PRCA*4.5*326
 . S RCAUDARY(2)="344.62^"_F2_"^"_RCCIEN_"^"_RCNAMT_"^0^"_RCRSN ; PRCA*4.5*326
 . D AUDIT^RCDPESP(.RCAUDARY)
 . ;
 Q
 ;
CONFIRM(RCIDX,PAID,RCARCTYP) ; Ask user to change or disable an enabled CARC auto-decrement
 ; Added PAID - PRCA*4.5*326
 ; PRCA*4.5*349 - Subroutine moved from RCDPESP5 for size.
 ; PRCA*4.5*345 - Added RCARCTYP parameter
 ; Input: RCIDX: 1 - Enable Auto-Decrease CARC
 ;               2 - Confirm Enable of Auto-Decrease CARC, 
 ;               3 - Confirm disable of Auto-Decrease CARC
 ;               4 - Disable Auto-Decrease CARC
 ;         PAID: 1 - Auto-Decrease CARCs for paid claims
 ;               0 - Auto-Decrease CARCs for no-pay claims
 ;     RCARCTYP: 0 - Medical Auto-Decrease CARCs
 ;               1 - Rx Auto-Decrease CARCs
 ;               2 - TRICARE CARCs
 ;               Optional, defaults to 0
 ;
 N DA,DIR,DTOUT,DUOUT,DIRUT,DIROUT,RCTXT,X,XX,Y
 S:'$D(RCARCTYP) RCARCTYP=0                 ; PRCA4*5*345 - Added line
 S RCTXT=$S(PAID:"",1:"NO-PAY ")            ; PRCA*4.5*326
 ;
 ; Confirm if the CARC code is correct
 I RCIDX=1 D
 . S XX="Either (Y)es to confirm that this is the correct code or (N)o to enter a different code."
 . S DIR("?")=XX
 . S XX="ENABLE this CARC for Auto-Decrease of "_RCTXT
 . ;
 . ; PRCA*4.5*349 - added Rx/TRICARE Check below
 . S XX=XX_$S(RCARCTYP=0:"Medical",RCARCTYP=1:"Pharmacy",1:"TRICARE")
 . S XX=XX_" Claims (Y/N)? "
 . S DIR("A")=XX
 ;
 ; Confirm user wishes to Enable changes
 I RCIDX=2 D
 . S DIR("?")="Either (Y)es to confirm changes or (N)o to exit without saving."
 . S DIR("A")="Save this CARC? (Y)es or (N)o: "
 ;
 ; Confirm user wishes to Disable changes
 I RCIDX=3 D
 . S DIR("?")="Either (Y)es to confirm changes or (N)o to exit without saving."
 . S DIR("A")="Remove this CARC? (Y)es or (N)o: "
 ;
 ; Confirm CARC code is correct
 I RCIDX=4 D
 . S XX="Either (Y)es to confirm that this is the correct code or (N)o to enter a different code."
 . S DIR("?")=XX
 . S XX="DISABLE this CARC for Auto-Decrease of "_RCTXT
 . ;
 . ; PRCA*4.5*349 - Added Rx/Tricare check below
 . S XX=XX_$S(RCARCTYP=0:"Medical",RCARCTYP=1:"Pharmacy",1:"TRICARE")_" Claims (Y/N)? "
 . S DIR("A")=XX
 ;
 S DIR(0)="YA",DIR("S")="Y:Yes;N:No"
 D ^DIR
 K DIR
 I $G(DTOUT)!$G(DUOUT) S Y=-1
 I Y="0" S Y=-1
 Q Y
