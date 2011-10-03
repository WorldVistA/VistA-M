RCBEPAY2 ;WISC/RFJ-create a payment transaction cont                 ;1 Jun 00
 ;;4.5;Accounts Receivable;**153,162**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SET ;  set the transactions and balances (continuation of rcbepay1)
 N COMMENT,DR,RCDATA3,RCLINE,RCREPAMT,RCREPDA,RCTOTAL,RCTYPE,X
 ;
 ;  no payment amount
 S RCTOTAL=$G(RCPAY("PRIN"))+$G(RCPAY("INT"))+$G(RCPAY("ADM"))+$G(RCPAY("MF"))+$G(RCPAY("CC"))
 I 'RCTOTAL S RCTRANDA="0^Bill has no balance, no payment made" Q
 ;
 ;  create 433 transaction for bill, transaction type = payment (2)
 ;  the transaction will be locked
 S RCTRANDA=$$ADD433^RCBEUTRA(RCBILLDA,2)
 I 'RCTRANDA S RCTRANDA="0^Unable to add a payment transaction to file 433" Q
 ;  433 transaction added and lock applied
 ;
 ;  edit/setup fields for 433 transaction.  11=payment date
 ;  13=receipt number;  15=trasaction amount;  7=rcdoj code
 ;  5.02=brief comment = deposit / receipt / payment #
 S DR="11////"_RCPAYDAT_";"
 S DR=DR_"15////"_RCTOTAL_";"
 ;  if receipt is passed, set fields for receipt
 ;  note: a receipt is not passed if posting from a prepayment
 S X=$G(^RCY(344,+RCRECTDA,0)) I X'="" D
 .   S DR=DR_"13////"_$P(X,"^")_";"
 .   S DR=DR_"5.02////"_$P($G(^RCY(344.1,+$P(X,"^",6),0)),"^")_" / "_$P(X,"^")_" / "_RCPAYDA_";"
 ;
 ;  determine if DOJ, RC, TOP, or IRS payment
 S RCTYPE=$P($G(^RC(341.1,+$P($G(^RCY(344,+RCRECTDA,0)),"^",4),0)),"^",2)
 S RCTYPE=$S(RCTYPE=5:"DOJ",RCTYPE=3:"RC",RCTYPE=13:"TOP",RCTYPE=11:"IRS",1:"")
 I RCTYPE="" S RCTYPE=$P($G(^PRCA(430,RCBILLDA,6)),"^",5)
 I RCTYPE'="" S:RCTYPE="DC" RCTYPE="RC" S DR=DR_"7////"_RCTYPE_";"
 S X=$$EDIT433^RCBEUTRA(RCTRANDA,DR)
 I 'X S RCTRANDA="0^Unable to set fields for transaction "_RCTRANDA L -^PRCA(433,RCTRANDA) Q
 ;
 ;  if TOP, decrement current top debt amount (field 4.03 in file 340)
 I RCTYPE="TOP" D TOPAMT^RCBEUDEB(RCBILLDA,-RCTOTAL)
 ;
 ;  if there is a repayment plan, set as being paid in file 430
 ;  loop thru all repayment plans and keep paying them off till
 ;  you run out of money.  this code is for double payments.
 S RCREPAMT=$P($G(^PRCA(430,RCBILLDA,4)),"^",3)
 ;  is there a repayment amount and is the total amt equal to
 ;  or greater than the expected repayment amount?
 I RCREPAMT,RCTOTAL'<RCREPAMT D
 .   S RCREPDA=0 F  S RCREPDA=$O(^PRCA(430,RCBILLDA,5,RCREPDA)) Q:'RCREPDA  D  I 'RCREPDA Q
 .   .   I +$P($G(^PRCA(430,RCBILLDA,5,RCREPDA,0)),"^",2)=1 Q
 .   .   S $P(^PRCA(430,RCBILLDA,5,RCREPDA,0),"^",2,4)="1^0^"_RCTRANDA
 .   .   S RCTOTAL=RCTOTAL-RCREPAMT I RCTOTAL<RCREPAMT S RCREPDA=0
 ;
 ;  set 433 transaction with payment amounts
 S RCDATA3=""
 S $P(RCDATA3,"^",1)=$G(RCPAY("PRIN"))  ; amount paid principal
 S $P(RCDATA3,"^",2)=$G(RCPAY("INT"))   ; amount paid interest
 S $P(RCDATA3,"^",3)=$G(RCPAY("ADM"))   ; amount paid admin
 S $P(RCDATA3,"^",4)=$G(RCPAY("MF"))    ; amount paid marshal fee
 S $P(RCDATA3,"^",5)=$G(RCPAY("CC"))    ; amount paid court cost
 S ^PRCA(433,RCTRANDA,3)=RCDATA3
 ;
 ;  set 430 bill balance amounts
 S $P(RCDATA7,"^",1)=$P(RCDATA7,"^",1)-$G(RCPAY("PRIN"))  ; principal
 S $P(RCDATA7,"^",2)=$P(RCDATA7,"^",2)-$G(RCPAY("INT"))   ; interest
 S $P(RCDATA7,"^",3)=$P(RCDATA7,"^",3)-$G(RCPAY("ADM"))   ; admin
 S $P(RCDATA7,"^",4)=$P(RCDATA7,"^",4)-$G(RCPAY("MF"))    ; marshal fee
 S $P(RCDATA7,"^",5)=$P(RCDATA7,"^",5)-$G(RCPAY("CC"))    ; court cost
 ;
 ;  set 430 amounts paid
 S $P(RCDATA7,"^",7)=$P(RCDATA7,"^",7)+$G(RCPAY("PRIN"))  ; principal
 S $P(RCDATA7,"^",8)=$P(RCDATA7,"^",8)+$G(RCPAY("INT"))   ; interest
 S $P(RCDATA7,"^",9)=$P(RCDATA7,"^",9)+$G(RCPAY("ADM"))   ; admin
 S $P(RCDATA7,"^",10)=$P(RCDATA7,"^",10)+$G(RCPAY("MF"))  ; marshal fee
 S $P(RCDATA7,"^",11)=$P(RCDATA7,"^",11)+$G(RCPAY("CC"))  ; court cost
 S ^PRCA(430,RCBILLDA,7)=RCDATA7
 ;
 ;  set new bill balances in 433 (for reference)
 S $P(^PRCA(433,RCTRANDA,8),"^",1,5)=$P(RCDATA7,"^",1,5)
 ;
 ;  if the bill has no balance, set as being paid in full
 S X=$P(RCDATA7,"^")+$P(RCDATA7,"^",2)+$P(RCDATA7,"^",3)+$P(RCDATA7,"^",4)+$P(RCDATA7,"^",5)
 I 'X D
 .   ;  change the status to collected/closed (22)
 .   D CHGSTAT^RCBEUBIL(RCBILLDA,22)
 .   ;
 .   ;  change the transaction type in file 433 to payment in full
 .   S DR="12////34;"
 .   S X=$$EDIT433^RCBEUTRA(RCTRANDA,DR)
 .   ;
 .   ;  if third party bill (with no balance) generate ib bulletin
 .   ;  look at field 5 in 430.2 to determine type of bill based
 .   ;  on category
 .   I $P($G(^PRCA(430.2,+$P(^PRCA(430,RCBILLDA,0),"^",2),0)),"^",6)="T" D
 .   .   D BULL^IBCNSBL2(RCBILLDA,$P(^PRCA(430,RCBILLDA,0),"^",3),$$PAID^PRCAFN1(RCBILLDA))
 .   .   N PRCABN,PRCAEN
 .   .   S PRCABN=RCBILLDA,PRCAEN=RCTRANDA
 .   .   D PF^RCRCAT("P")
 ;
 ;  add comment field to 433 (only if receipt passed)
 S X=$G(^RCY(344,+RCRECTDA,1,+RCPAYDA,0))
 I X'="" D
 .   S RCLINE=0
 .   I $P(X,"^",7)'="" S RCLINE=RCLINE+1,COMMENT(RCLINE)="Check#: "_$P(X,"^",7)
 .   I $P(X,"^",8)'="" S RCLINE=RCLINE+1,COMMENT(RCLINE)="Bank Routing#: "_$P(X,"^",8)
 .   I $P(X,"^",10)'="" S RCLINE=RCLINE+1,COMMENT(RCLINE)="Check Date: "_$E($P(X,"^",10),4,5)_"-"_$E($P(X,"^",10),6,7)_"-"_$E($P(X,"^",10),2,3)
 .   I $P(X,"^",13)'="" S RCLINE=RCLINE+1,COMMENT(RCLINE)="Check Acct: "_$P(X,"^",13)
 .   I $P(X,"^",11)'="" S RCLINE=RCLINE+1,COMMENT(RCLINE)="Credit Card: "_$P(X,"^",11)
 .   S X=$G(^RCY(344,RCRECTDA,1,RCPAYDA,2))
 .   I $P(X,"^",2)'="" S RCLINE=RCLINE+1,COMMENT(RCLINE)="Batch: "_$P(X,"^",2)
 .   I $P(X,"^",3)'="" S RCLINE=RCLINE+1,COMMENT(RCLINE)="Sequence: "_$P(X,"^",3)
 .   I $G(COMMENT(1))'="" D ADDCOMM^RCBEUTRA(RCTRANDA,.COMMENT)
 ;
 ;  mark 433 transaction as processed
 D PROCESS^RCBEUTRA(RCTRANDA)
 ;
 ;  update 433 fy multiple
 D FYMULT^RCBEUTRA(RCTRANDA)
 ;
 ;  unlock 433 transaction
 L -^PRCA(433,RCTRANDA)
 Q
