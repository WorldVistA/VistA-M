RCBEADJ1 ;ALB/PJH - PENDING PAYMENTS ;24-FEB-03
 ;;4.5;Accounts Receivable;**173,276,321,326,332**;Mar 20, 1995;Build 40
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
WARN(RCBILLDA) ; Display warning if pending payments exist EP ^RCBEADJ 
 ; Input - RCBILLDA - Pointer #430 - required
 ; Output - None - output to screen only
 ;
 ; Check for valid input
 Q:'$G(RCBILLDA)
 ;
 N DEBTOR,RCAMT,RCEOB,RCERA,RCLINE,RCPAID,RCPEND,RCRCPT,RCRCPTN,RCSUB,RCTOT,RCTRACE,RCTRANDA,RCZ,RCZL
 ; Set DEBTOR value
 S DEBTOR=RCBILLDA_";PRCA(430,"
 ; Check for unprocessed receipts
 S RCPEND=$$PENDPAY^RCDPURET(DEBTOR)
 ; Extract receipt numbers and amounts paid on individual lines for pending receipts
 S RCRCPT=0
 F  S RCRCPT=$O(^TMP($J,"RCDPUREC","PP",RCRCPT)) Q:'RCRCPT  D
 . S RCRCPTN=$$GET1^DIQ(344,RCRCPT_",",.01) Q:RCRCPTN=""
 . S RCPEND("R",RCRCPTN)=0
 . S RCTRANDA=0
 . F  S RCTRANDA=$O(^TMP($J,"RCDPUREC","PP",RCRCPT,RCTRANDA)) Q:'RCTRANDA  D
 . . S RCAMT=$P($G(^TMP($J,"RCDPUREC","PP",RCRCPT,RCTRANDA)),U,4) Q:+RCAMT=0
 . . ; Save paid amount for this claim on this receipt
 . . S RCPEND("R",RCRCPTN)=RCPEND("R",RCRCPTN)+RCAMT
 . . ; Get trace number for ERA
 . . S RCERA=$$GET1^DIQ(344,RCRCPT_",",.18,"I")
 . . S RCTRACE=$S(RCERA:$$GET1^DIQ(344.4,RCERA_",",.02,"I"),1:"No Trace Number")
 . . ; Save trace number
 . . S RCPEND("R",RCRCPTN,"T")=RCTRACE
 ; Clear ^TMP array returned by $$PENDPAY
 K ^TMP($J,"RCDPUREC","PP")
 ; Find EEOB's for this claim
 S RCEOB=0
 F  S RCEOB=$O(^IBM(361.1,"B",RCBILLDA,RCEOB)) Q:'RCEOB  D
 . ;Find ERAs for this EOB - may be multiple
 . S RCERA=0
 . F  S RCERA=$O(^RCY(344.4,"ADET",RCEOB,RCERA)) Q:'RCERA  D
 . . ; Ignore ERA which already has a receipt - processed or otherwise
 . . I $$GET1^DIQ(344.4,RCERA_",",.08,"I") Q
 . . ; Get ERA lines for this EOB
 . . S RCLINE=0,RCTOT=0
 . . F  S RCLINE=$O(^RCY(344.4,"ADET",RCEOB,RCERA,RCLINE)) Q:'RCLINE  D
 . . . ; Get paid amount from ERA line
 . . . S RCPAID=$$GET1^DIQ(344.41,RCLINE_","_RCERA_",",.03)
 . . . ; Ignore zero lines
 . . . Q:'RCPAID
 . . . ; If no scratchpad use paid amount from ERA - does not take into account ERA level adjustments
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
 . . ; If claim total for the ERA is zero do not save trace number and paid amount
 . . Q:RCTOT=0
 . . ; Otherwise get trace number
 . . S RCTRACE=$$GET1^DIQ(344.4,RCERA_",",.02,"I")
 . . S RCPEND=RCPEND+RCTOT
 . . ; Save totals by ERA
 . . S RCPEND("E",RCERA)=RCTOT,RCPEND("E",RCERA,"T")=$S(RCTRACE'="":RCTRACE,1:"No Trace Number")
 Q:'RCPEND
 W !!,"Warning - Pending Payments of $"_$J(RCPEND,0,2)_" exist."
 ; List unprocessed receipts
 S RCRCPTN=""
 F  S RCRCPTN=$O(RCPEND("R",RCRCPTN)) Q:RCRCPTN=""  W !,"Rcpt: ",RCRCPTN,?16,$J("$"_$J(RCPEND("R",RCRCPTN),0,2),11),?29,$G(RCPEND("R",RCRCPTN,"T"))
 ; List unprocessed EOB
 S RCERA=""
 F  S RCERA=$O(RCPEND("E",RCERA)) Q:'RCERA  W !,"ERA : ",RCERA,?16,$J("$"_$J(RCPEND("E",RCERA),0,2),11),?29,$G(RCPEND("E",RCERA,"T"))
 Q
 ;
FIND(RCERA,RCLINE) ; Search ORIGINAL ERA SEQUENCES for this line
 ; Input RCERA - Scratchpad IEN 
 ;       RCLINE - ERA line to find
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
