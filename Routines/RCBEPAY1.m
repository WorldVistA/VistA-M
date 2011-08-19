RCBEPAY1 ;WISC/RFJ-create a payment transaction cont                 ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PAYTRAN(RCBILLDA,RCPAYAMT,RCRECTDA,RCPAYDA,RCPAYDAT) ;  create the payment
 ;  transaction for a bill.
 ;  return 433 ien transaction if payment made
 ;  or 0^error if not processed.
 ;  input variables:
 ;      rcbillda = ien of bill to apply payment to
 ;      rcpayamt = total payment transaction amount
 ;      rcrectda = ien of receipt in file 344
 ;      rcpayda  = payment transaction number in file 344.01
 ;      rcpaydat = date of payment
 ;  note: rcrectda and rcpayda are passed as zero if posting from
 ;  a prepayment bill
 ;
 N RCDATA7,RCPAY,RCTRANDA
 ;
 ;  determine how payment should be applied
 S RCDATA7=^PRCA(430,RCBILLDA,7)
 ;  === check marshal fee balance and apply payment ===
 I $P(RCDATA7,"^",4)>0 D
 .   ;  if the payment amount is less than mf charge
 .   ;  apply all the payment to the mf charge and quit
 .   I RCPAYAMT<$P(RCDATA7,"^",4) D  Q
 .   .   S RCPAY("MF")=RCPAYAMT
 .   .   S RCPAYAMT=0
 .   ;  otherwise, apply payment to make the mf balance 0
 .   S RCPAY("MF")=$P(RCDATA7,"^",4)
 .   S RCPAYAMT=RCPAYAMT-$P(RCDATA7,"^",4)
 ;  no payment amount remaining
 I 'RCPAYAMT D SET^RCBEPAY2 Q RCTRANDA
 ;
 ;  === check court cost balance and apply payment ===
 I $P(RCDATA7,"^",5)>0 D
 .   ;  if the payment amount is less than cc charge
 .   ;  apply all the payment to the cc charge and quit
 .   I RCPAYAMT<$P(RCDATA7,"^",5) D  Q
 .   .   S RCPAY("CC")=RCPAYAMT
 .   .   S RCPAYAMT=0
 .   ;  otherwise, apply payment to make the cc balance 0
 .   S RCPAY("CC")=$P(RCDATA7,"^",5)
 .   S RCPAYAMT=RCPAYAMT-$P(RCDATA7,"^",5)
 ;  no payment amount remaining
 I 'RCPAYAMT D SET^RCBEPAY2 Q RCTRANDA
 ;
 ;  === check admin balance and apply payment ===
 I $P(RCDATA7,"^",3)>0 D
 .   ;  if the payment amount is less than admin charge
 .   ;  apply all the payment to the admin charge and quit
 .   I RCPAYAMT<$P(RCDATA7,"^",3) D  Q
 .   .   S RCPAY("ADM")=RCPAYAMT
 .   .   S RCPAYAMT=0
 .   ;  otherwise, apply payment to make the admin balance 0
 .   S RCPAY("ADM")=$P(RCDATA7,"^",3)
 .   S RCPAYAMT=RCPAYAMT-$P(RCDATA7,"^",3)
 ;  no payment amount remaining
 I 'RCPAYAMT D SET^RCBEPAY2 Q RCTRANDA
 ;
 ;  === check interest balance and apply payment ===
 I $P(RCDATA7,"^",2)>0 D
 .   ;  if the payment amount is less than interest charge
 .   ;  apply all the payment to the interest charge and quit
 .   I RCPAYAMT<$P(RCDATA7,"^",2) D  Q
 .   .   S RCPAY("INT")=RCPAYAMT
 .   .   S RCPAYAMT=0
 .   ;  otherwise, apply payment to make the interest balance 0
 .   S RCPAY("INT")=$P(RCDATA7,"^",2)
 .   S RCPAYAMT=RCPAYAMT-$P(RCDATA7,"^",2)
 ;  no payment amount remaining
 I 'RCPAYAMT D SET^RCBEPAY2 Q RCTRANDA
 ;
 ;  === check principal balance and apply payment ===
 I $P(RCDATA7,"^",1)>0 D
 .   ;  if the payment amount is less than principal charge
 .   ;  apply all the payment to the principal charge and quit
 .   I RCPAYAMT<$P(RCDATA7,"^",1) D  Q
 .   .   S RCPAY("PRIN")=RCPAYAMT
 .   .   S RCPAYAMT=0
 .   ;  otherwise, apply payment to make the principal balance 0
 .   S RCPAY("PRIN")=$P(RCDATA7,"^",1)
 .   S RCPAYAMT=RCPAYAMT-$P(RCDATA7,"^",1)
 ;
 D SET^RCBEPAY2
 Q RCTRANDA
