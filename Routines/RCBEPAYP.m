RCBEPAYP ;WISC/RFJ-check and apply prepayment to bill                ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PREPAY(RCBILLDA,RCSCREEN) ;  if prepayment for patient account,
 ;  apply the prepayment to the bill.
 ;  pass variables:
 ;      rcbillda = active bill that needs to be paid
 ;      rcscreen = 1 if messages should be printed on the screen
 ;
 ;  set rcscreen to 1 to display data on screen
 I '$D(RCSCREEN) N RCSCREEN S RCSCREEN=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 I RCSCREEN W !!,"Checking for Prepayment Receivable......"
 ;
 N COMMENT,RCBILBAL,RCDATA0,RCDATA7,RCDEBTDA,RCERROR,RCPAYAMT,RCPREBAL,RCPREDA,RCTRANDA,RCTRVALU,Y
 ;  lock the bill
 L +^PRCA(430,RCBILLDA):10 I '$T S RCERROR="Bill "_$P(^PRCA(430,RCBILLDA,0),"^")_" is locked by another user." D Q Q
 ;
 ;  get the bill data
 S RCDATA0=^PRCA(430,RCBILLDA,0)
 ;
 ;  get the debtor and first party patient ([DPT)
 I $P($G(^RCD(340,+$P(RCDATA0,"^",9),0)),"^")'[";DPT" D Q Q
 S RCDEBTDA=+$P(RCDATA0,"^",9)
 ;
 ;  lock the account to prevent updates
 L +^RCD(340,RCDEBTDA):10 I '$T S RCERROR="Account is locked by another user." D Q Q
 ;
 ;  if the bill is not active or open, quit
 I $P(RCDATA0,"^",8)'=16,$P(RCDATA0,"^",8)'=42 S RCERROR="BILL STATUS IS "_$P($G(^PRCA(430.3,$P(RCDATA0,"^",8),0)),"^") D Q Q
 I $P(RCDATA0,"^",2)=26 S RCERROR="Bill is a prepayment" D Q Q
 ;
 ;  get the bills balance, quit if 0
 S RCDATA7=$G(^PRCA(430,RCBILLDA,7))
 S RCBILBAL=$P(RCDATA7,"^")+$P(RCDATA7,"^",2)+$P(RCDATA7,"^",3)+$P(RCDATA7,"^",4)+$P(RCDATA7,"^",5)
 I RCBILBAL'>0 S RCERROR="Bill has no outstanding balance" D Q Q
 ;
 ;  loop open (42) bills for debtor looking for prepayments
 S RCPREDA=0
 F  S RCPREDA=$O(^PRCA(430,"AS",RCDEBTDA,42,RCPREDA)) Q:'RCPREDA!($G(RCERROR)'="")!(RCBILBAL'>0)  D
 .   ;  get the bills balance, quit if 0
 .   S RCDATA7=$G(^PRCA(430,RCBILLDA,7))
 .   S RCBILBAL=$P(RCDATA7,"^")+$P(RCDATA7,"^",2)+$P(RCDATA7,"^",3)+$P(RCDATA7,"^",4)+$P(RCDATA7,"^",5)
 .   I $G(RCBILBAL)'>0 Q
 .   ;
 .   ;  not a prepayment
 .   I $P(^PRCA(430,RCPREDA,0),"^",2)'=26 Q
 .   ;  lock the prepayment
 .   L +^PRCA(430,RCPREDA):5 I '$T Q
 .   ;  no balance on prepayment, cancellation(39) the prepayment
 .   S RCPREBAL=$P($G(^PRCA(430,RCPREDA,7)),"^")
 .   I 'RCPREBAL D CHGSTAT^RCBEUBIL(RCPREDA,39) L -^PRCA(430,RCPREDA) Q
 .   ;  determine payment amount. set to balance of bill.  if
 .   ;  the prepayment amount is less, set to prepayment amount
 .   S RCPAYAMT=RCBILBAL I RCPAYAMT>RCPREBAL S RCPAYAMT=RCPREBAL
 .   ;
 .   ;  post payment, pass bill ien, payment amount, receipt and
 .   ;  payment number is 0 since it is being posted from a
 .   ;  prepayment, payment date = today
 .   S RCTRANDA=$$PAYTRAN^RCBEPAY1(RCBILLDA,RCPAYAMT,0,0,DT)
 .   I 'RCTRANDA S RCERROR=$P(RCTRANDA,"^",2) L -^PRCA(430,RCPREDA) Q
 .   ;
 .   ;  add comment to transaction
 .   S COMMENT(1)="Payment posted from Prepayment Receivable "_$P(^PRCA(430,RCPREDA,0),"^")
 .   D ADDCOMM^RCBEUTRA(RCTRANDA,.COMMENT)
 .   ;
 .   ;  since the bill is being paid with a prepayment, set the
 .   ;  incomplete transaction flag on the payment.  this code
 .   ;  can be removed after patch 146.
 .   S Y=$$EDIT433^RCBEUTRA(RCTRANDA,"10////1;")
 .   ;
 .   ;  get the value of the payment transaction
 .   S RCTRVALU=+$P($G(^PRCA(433,RCTRANDA,1)),"^",5) I 'RCTRVALU L -^PRCA(430,RCPREDA) Q
 .   ;
 .   I RCSCREEN W !,?5,"... Payment of $ ",$J(RCTRVALU,8,2)," applied from prepayment ",$P(^PRCA(430,RCPREDA,0),"^"),"."
 .   ;
 .   ;  decrease the prepayment by amount paid.
 .   ;  pass negative amount paid to create a decrease to prepayment.
 .   ;  pass 0 for date processed, the current date/time will be used.
 .   ;  pass the payment transaction ien (rctranda).
 .   S COMMENT(1)="Auto decrease from Account Receivable "_$P(RCDATA0,"^")
 .   S RCTRANDA=$$INCDEC^RCBEUTR1(RCPREDA,-RCTRVALU,.COMMENT,0,RCTRANDA)
 .   ;
 .   ;  clear the prepayment bill lock
 .   L -^PRCA(430,RCPREDA)
 ;
Q ;  show error to user and unlock
 I $G(RCERROR)'="",RCSCREEN W !,?5,"ERROR: "_RCERROR
 I $G(RCDEBTDA) L -^RCD(340,RCDEBTDA)
 I $G(RCBILLDA) L -^PRCA(430,RCBILLDA)
 Q
