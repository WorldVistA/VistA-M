RCDPESP7 ;AITC/PJH - ePayment Lockbox Site Parameters Definition - auto-decrease ;Nov. 
 ;;4.5;Accounts Receivable;**298,304,318,321,326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PAID() ; Paid claim auto-decrease parameters - EP from RCDPESP
 ; INPUT - None
 ; OUTPUT 0 = "OK"
 ;        1 = "ABORT"
 ;        2 = "SKIP"
 ;        
 N ADMC,DTOUT,DUOUT,FDAEDI,RCAUDVAL,RCQUIT,Y
 S ADMC=$$GET1^DIQ(344.61,"1,",.03,"I") ; get current value
 K DIR S DIR(0)="YA",DIR("B")=$S(ADMC=""!(ADMC=1):"Yes",1:"No")
 S DIR("A")="ENABLE AUTO-DECREASE OF MEDICAL CLAIMS WITH PAYMENTS (Y/N):"
 S DIR("?")=$$GET1^DID(344.61,.03,,"HELP-PROMPT")
 D ^DIR I $D(DTOUT)!$D(DUOUT) Q 1
 ; if user changed value, update and audit
 S:ADMC'=Y FDAEDI(344.61,"1,",.03)=Y,RCAUDVAL(1)="344.61^.03^1^"_Y_U_ADMC
 I Y=0 D  Q 2  ; value set to No, update (if needed), go to Pharmacy params.
 . D:$D(FDAEDI) FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL) K RCAUDVAL
 ;
 ; Set auto-decrease maximum amount
 N ADAMT,ADNAMT,RCOK ; ^DD(344.61,.05,0) = MED AMT DEFAULT AUTO-DECREASE
ADAMT ; BEGIN - PRCA*4.5*326
 S ADAMT=$$GET1^DIQ(344.61,"1,",.05)
 K DIR S DIR("B")=ADAMT
 S DIR("?")=$$GET1^DID(344.61,.05,,"HELP-PROMPT")
 S DIR(0)="NA^0:99999:0",DIR("A")=$$GET1^DID(344.61,.05,,"TITLE")
 D ^DIR I $D(DTOUT)!$D(DUOUT) Q 1
 S:ADAMT'=Y FDAEDI(344.61,"1,",.05)=Y,RCAUDVAL(2)="344.61^.05^1^"_Y_U_ADAMT
 S ADNAMT=Y
 ;
 ; Check if any CARCs need reset and give choice to proceed
 S RCOK=$$CARCDSP^RCDPESP5(ADNAMT)
 ; Finish if user exit selected
 Q:RCOK="QUIT" 1
 ; If user chooses to not reset then go back to re-enter maximum
 I RCOK=0 K FDAEDI(344.61,"1,",.05),RCAUDVAL(2) G ADAMT
 ; END - PRCA*4.5*326
 ;
 ; file changes to medical auto-decrease parameters
 D:$D(FDAEDI) FILE^DIE(,"FDAEDI")
 D:$D(RCAUDVAL) AUDIT^RCDPESP(.RCAUDVAL)
 K FDAEDI,RCAUDVAL
 ;
 ; If auto-decrease (medical for now) on, ask about CARC/RARC auto-decrease setup
 W !
 S RCQUIT=0
 D CARC^RCDPESP5(.RCQUIT,1) ; pass RCQUIT by reference - PRCA*4.5*321
 W !
 ; If no active CARCs Turn medical auto-decrease off, Then go to Pharacy params
 I ($$COUNT^RCDPESP(1)=0)&($$GET1^DIQ(344.61,"1,",.03,"I")=1) D  Q 2
 . K FDAEDI,RCAUDVAL
 . S ADMC=$$GET1^DIQ(344.61,"1,",.03,"I")
 . S FDAEDI(344.61,"1,",.03)=0,RCAUDVAL(1)="344.61^.03^1^"_0_U_ADMC_U_"SYSTEM disabled Medical Auto-decrease, there are NO active CARCs"
 . D FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL) K RCAUDVAL
 . W !,"*** System has DISABLED Medical Auto-decrease, there are NO active CARCs.",!
 . D PAUSE^RCDPESP
 Q:RCQUIT 1
 ;
 ; Set number of days to wait before auto-decrease amount
 N ADMT ; ^DD(344.61,.04,0) = AUTO-DECREASE MED DAYS DEFAULT
 S ADMT=$$GET1^DIQ(344.61,"1,",.04)
 K DIR S:ADMT]"" DIR("B")=ADMT
 S DIR("?")=$$GET1^DID(344.61,.04,,"HELP-PROMPT")
 S DIR(0)="NA^0:7:0",DIR("A")=$$GET1^DID(344.61,.04,,"TITLE")
 D ^DIR I $D(DTOUT)!$D(DUOUT) Q 1
 S:ADMT'=Y FDAEDI(344.61,"1,",.04)=Y,RCAUDVAL(1)="344.61^.04^1^"_Y_U_ADMT
 ; ;
 ; file changes to medical auto-decrease parameters
 D:$D(FDAEDI) FILE^DIE(,"FDAEDI")
 D:$D(RCAUDVAL) AUDIT^RCDPESP(.RCAUDVAL)
 K RCAUDVAL
 Q 0
 ;
NOPAY() ; No-payment claim auto-decrease parameters - EP from RCDPESP
 ; INPUT - None
 ; OUTPUT 0 = "OK"
 ;        1 = "ABORT"
 ;
 ; If auto-decrease of paid claims is off skip auto-decrease no-pay parameters
 Q:'$$GET1^DIQ(344.61,"1,",.03,"I") 0
 ;
 N ADMC,DTOUT,DUOUT,FDAEDI,RCAUDVAL,RCQUIT,Y
 S ADMC=$$GET1^DIQ(344.61,"1,",.11,"I") ; get current value
 K DIR S DIR(0)="YA",DIR("B")=$S(ADMC=""!(ADMC=1):"Yes",1:"No")
 S DIR("A")="ENABLE AUTO-DECREASE OF MEDICAL CLAIMS WITH NO PAYMENTS (Y/N):"
 S DIR("?")=$$GET1^DID(344.61,.11,,"HELP-PROMPT")
 W !
 D ^DIR I $D(DTOUT)!$D(DUOUT) Q 1
 ; if user changed value, update and audit
 S:ADMC'=Y FDAEDI(344.61,"1,",.11)=Y,RCAUDVAL(1)="344.61^.11^1^"_Y_U_ADMC
 I Y=0 D  Q "SKIP"  ; value set to No, update (if needed), go to Pharmacy params.
 . D:$D(FDAEDI) FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL) K RCAUDVAL
 ;
 ; If no-pay auto-decrease on, ask about CARC/RARC auto-decrease setup
 W !
 S RCQUIT=0
 D CARC^RCDPESP5(.RCQUIT,0) ; pass RCQUIT by reference - PRCA*4.5*321
 W !
 ; If no active CARCs Turn medical no-pay auto-decrease off, Then go to Pharacy params
 I ($$COUNT^RCDPESP(1)=0)&($$GET1^DIQ(344.61,"1,",.11,"I")=1) D  Q 1
 . K FDAEDI,RCAUDVAL
 . S ADMC=$$GET1^DIQ(344.61,"1,",.11,"I")
 . S FDAEDI(344.61,"1,",.03)=0,RCAUDVAL(1)="344.61^.11^1^"_0_U_ADMC_U_"SYSTEM disabled Medical Auto-decrease, there are NO active CARCs"
 . D FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL) K RCAUDVAL
 . W !,"*** System has DISABLED Medical No-Pay Auto-decrease, there are NO active CARCs.",!
 . D PAUSE^RCDPESP
 Q:RCQUIT 1
 ;
 ; Set number of days to wait before no-pay auto-decrease amount
 N ADMT ; ^DD(344.61,.12,0) = AUTO-DECREASE MED DAYS DEFAULT (ZERO)
 S ADMT=$$GET1^DIQ(344.61,"1,",.12)
 K DIR S:ADMT]"" DIR("B")=ADMT
 S DIR("?")=$$GET1^DID(344.61,.12,,"HELP-PROMPT")
 S DIR(0)="NA^0:45:0",DIR("A")=$$GET1^DID(344.61,.12,,"TITLE")
 D ^DIR I $D(DTOUT)!$D(DUOUT) Q 1
 S:ADMT'=Y FDAEDI(344.61,"1,",.12)=Y,RCAUDVAL(2)="344.61^.12^1^"_Y_U_ADMT
 ; ;
 ; file changes to medical no-pay auto-decrease parameters
 D FILE^DIE(,"FDAEDI")
 D:$D(RCAUDVAL) AUDIT^RCDPESP(.RCAUDVAL)
 K RCAUDVAL
 Q 0
 ;
