RCDPXFIX ;WISC/RFJ -fix duplicate deposits (! be careful using this !) ;22 Mar 02
 ;;4.5;Accounts Receivable;**177**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;  this routine is used to back out a duplicate deposit that has
 ;  been posted to first party bills.  do not use this routine
 ;  unless instructed to by software design and development or
 ;  national verification and support.  
 Q
 ;
 ;
REVERSE(RCDPOSIT,RCTRANDT) ;  back out deposit RCDPOSIT
 ;  RCDPOSIT is the deposit number, example 269296
 ;  RCTRANDT is the transmission date, example 3001113
 ;
 ;
 N %,RCBILLDA,RCDATA0,RCDPDT,RCFTEST,RCMESSAG,RCRCPT,RCTRAN1,RCTRANDA,X
 K ^TMP("RCDPXFIX",$J)
 ;
 ;  this is used for internal testing
 ;S RCFTEST=0   ;  NO, do not make updates to the database
 S RCFTEST=1  ;  YES, make changes to the database
 ;
 ;  set default message to send to user
 S RCMESSAG="Duplicate deposit "_RCDPOSIT_" with a transmission date of "_$E(RCTRANDT,4,5)_"/"_$E(RCTRANDT,6,7)_"/"_$E(RCTRANDT,2,3)_" was not found."
 ;
 ;  find deposit which was posted erroneously, if no date then it is not found
 S RCDPDT=$O(^RCY(344.1,"B",RCDPOSIT,0)) I 'RCDPDT D MAIL^RCDPXFIM(RCDPOSIT,RCTRANDT,RCMESSAG) Q
 ;
 ;  find receipts for deposit
 S RCRCPT=0 F  S RCRCPT=$O(^RCY(344,"AD",RCDPDT,RCRCPT))  Q:'RCRCPT  D
 .   S RCDATA0=$G(^RCY(344,RCRCPT,0))
 .   ;  check to see if the date opened is equal to the transmission date
 .   I $P(RCDATA0,"^",3)'=RCTRANDT Q
 .   ;
 .   ;  deposit already backed out (the *end date is set once backed out)
 .   I $P(RCDATA0,"^",10) S RCMESSAG="Duplicate Deposit "_RCDPOSIT_" was previously backed out on "_$E($P(RCDATA0,"^",10),4,5)_"/"_$E($P(RCDATA0,"^",10),6,7)_"/"_$E($P(RCDATA0,"^",10),2,3)_"." Q
 .   ;
 .   ;  found deposit/receipt and it needs to be backed out
 .   S RCMESSAG="Duplicate deposit "_RCDPOSIT_" with a transmission date of "_$E(RCTRANDT,4,5)_"/"_$E(RCTRANDT,6,7)_"/"_$E(RCTRANDT,2,3)_" has been removed."
 .   ;
 .   ;  loop payments made in transaction 433 file
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^PRCA(433,"AF",$P(RCDATA0,"^"),RCTRANDA)) Q:'RCTRANDA  D
 .   .   ;  transaction is already marked incomplete
 .   .   I $P(^PRCA(433,RCTRANDA,0),"^",4)=1 Q
 .   .   ;
 .   .   ;  lock the transaction
 .   .   L +^PRCA(433,RCTRANDA)
 .   .   ;
 .   .   ;  get transaction data
 .   .   S RCTRAN1=$G(^PRCA(433,RCTRANDA,1))
 .   .   S RCBILLDA=$P(^PRCA(433,RCTRANDA,0),"^",2)
 .   .   ;
 .   .   ;  lock the bill
 .   .   L +^PRCA(430,RCBILLDA)
 .   .   ;
 .   .   ;
 .   .   ;  transaction type = payment in part (2) or
 .   .   ;  transaction type = payment in full (34)
 .   .   I $P(RCTRAN1,"^",2)=2!($P(RCTRAN1,"^",2)=34) D PAYMENT(RCTRANDA,1)
 .   .   ;
 .   .   ;
 .   .   ;  transaction type = prepayment [increase adjustment (1)]
 .   .   I $P(RCTRAN1,"^",2)=1 D PREPAY
 .   .   ;
 .   .   ;  unlock the bill and transaction
 .   .   L -^PRCA(430,RCBILLDA)
 .   .   L -^PRCA(433,RCTRANDA)
 .   ;
 .   ;  make changes to the payments on the receipt
 .   D RECEIPT(RCDPOSIT,RCTRANDT,RCRCPT)
 .   ;
 .   ;  set piece 10 in receipt to show patch as being installed
 .   I RCFTEST D NOW^%DTC S $P(^RCY(344,RCRCPT,0),"^",10)=%
 ;
 D MAIL^RCDPXFIM(RCDPOSIT,RCTRANDT,RCMESSAG)
 ;
 K ^TMP("RCDPXFIX",$J)
 Q
 ;
 ;
PAYMENT(RCTRANDA,RCFREPRT) ;  mark payment transaction as incomplete and adjust bill
 ;  pass rcfrept equal to 1 to build mailman report.  since prepayment
 ;  payments to other bills are already printed on report, pass a zero
 ;  to stop the setting of the tmp global
 ;
 N %,DATA0,FYDA,PIECE,RCBILLDA,RCBILL7,RCCOMMNT,RCREPDA,RCTRAN3
 ;  amount paid
 S RCTRAN3=$G(^PRCA(433,RCTRANDA,3))
 ;  get the bill
 S RCBILLDA=$P($G(^PRCA(433,RCTRANDA,0)),"^",2)
 ;
 ;  reset the 7 node on the bill
 S RCBILL7=$G(^PRCA(430,RCBILLDA,7))
 F PIECE=1:1:5 D
 .   ;  add the payment back to the bills balance
 .   S $P(RCBILL7,"^",PIECE)=$P(RCBILL7,"^",PIECE)+$P(RCTRAN3,"^",PIECE)
 .   ;  subtract the payment made for the bill
 .   S $P(RCBILL7,"^",PIECE+6)=$P(RCBILL7,"^",PIECE+6)-$P(RCTRAN3,"^",PIECE)
 .   I RCFTEST S ^PRCA(430,RCBILLDA,7)=RCBILL7
 ;
 ;  make sure the bill is active (16) if collected/closed (22)
 I $P(^PRCA(430,RCBILLDA,0),"^",8)=22 I RCFTEST S %=$$EDIT430^RCBEUBIL(RCBILLDA,"8////16;")
 ;
 ;  reset the fiscal year multiple
 S FYDA=$O(^PRCA(430,RCBILLDA,2,999),-1)
 I $G(^PRCA(430,RCBILLDA,2,+FYDA,0))'="" I RCFTEST S $P(^PRCA(430,RCBILLDA,2,FYDA,0),"^",2)=$P(RCBILL7,"^")
 ;
 ;  remove repayment plans
 S RCREPDA=0 F  S RCREPDA=$O(^PRCA(430,RCBILLDA,5,RCREPDA)) Q:'RCREPDA  D
 .   S DATA0=$G(^PRCA(430,RCBILLDA,5,RCREPDA,0))
 .   I $P(DATA0,"^",4)'=RCTRANDA Q
 .   ;  found one, remove it
 .   I RCFTEST S ^PRCA(430,RCBILLDA,5,RCREPDA,0)=$P(DATA0,"^")_"^0"
 ;
 ;  set the payment transaction to incomplete
 I RCFTEST S $P(^PRCA(433,RCTRANDA,0),"^",4)=1
 ;
 ;  add comment to transaction
 S RCCOMMNT(1)="Duplicate deposit "_RCDPOSIT_" with transmission date "_$E(RCTRANDT,4,5)_"/"_$E(RCTRANDT,6,7)_"/"_$E(RCTRANDT,2,3)_" removed."
 I RCFTEST D ADDCOMM^RCBEUTRA(RCTRANDA,.RCCOMMNT)
 ;
 ;  build mailman message
 I RCFREPRT S ^TMP("RCDPXFIX",$J,RCBILLDA,RCTRANDA)=""
 Q
 ;
 ;
PREPAY ;  fix a prepayment
 ;  at entry point, rctranda is the increase adjustment to rcbillda
 ;
 N RCBILL7,RCDECADJ,RCPAYAMT,PAYTRAN
 S RCBILL7=$G(^PRCA(430,RCBILLDA,7))
 ;
 ;  simple, prepayment has not been used against another bill:
 ;    get rid of the increase adjustment
 I $P(RCBILL7,"^")'<$P($G(^PRCA(433,RCTRANDA,1)),"^",5) D PREPAYAD(RCTRANDA) Q
 ;
 ;  prepayment has been used against other bills:
 ;    get rid of the payments to other bills
 ;    get rid of the decrease adjustments to prepayment bill
 ;    get rid of the increase adjustment to prepayment bill
 S RCPAYAMT=$P($G(^PRCA(433,RCTRANDA,1)),"^",5)
 S RCDECADJ=RCTRANDA F  S RCDECADJ=$O(^PRCA(433,"C",RCBILLDA,RCDECADJ)) Q:'RCDECADJ  D  I 'RCPAYAMT Q
 .   ;  not a decrease adjustment
 .   I $P($G(^PRCA(433,RCDECADJ,1)),"^",2)'=35 Q
 .   ;
 .   ;  lock the decrease adjustment
 .   L +^PRCA(433,RCDECADJ)
 .   ;
 .   ;  get the payment transaction (433) that goes with decrease
 .   ;  to prepayment bill
 .   S PAYTRAN=$P($G(^PRCA(433,RCDECADJ,5)),"^",1)
 .   ;
 .   ;  lock the payment transaction
 .   L +^PRCA(433,PAYTRAN)
 .   ;
 .   ;  get rid of the payment transaction, activate bill
 .   ;  pass a zero so it does not show on mailman report twice
 .   I PAYTRAN D PAYMENT(PAYTRAN,0)
 .   ;
 .   ;  get rid of decrease adjustment
 .   D PREPAYAD(RCDECADJ)
 .   ;
 .   ;  subtract the decrease adjustment from the payment amount
 .   ;  do this till it reaches zero
 .   S RCPAYAMT=RCPAYAMT-$P($G(^PRCA(433,RCDECADJ,1)),"^",5)
 .   ;
 .   ;  unlock
 .   L -^PRCA(433,PAYTRAN)
 .   L -^PRCA(433,RCDECADJ)
 ;
 ;  get rid of the increase adjustment to the prepayment bill
 D PREPAYAD(RCTRANDA)
 Q
 ;
 ;
PREPAYAD(RCTRANDA) ;  get rid of a transaction on a prepayment bill
 N FYDA,RCBILL7,RCCOMMNT,RCTRAN1
 S RCTRAN1=$G(^PRCA(433,RCTRANDA,1))
 S RCBILL7=$G(^PRCA(430,RCBILLDA,7))
 ;
 ;  reset the 7 node on the bill
 ;  increase: subtract the payment from the bills principal balance
 I $P(RCTRAN1,"^",2)=1 S $P(RCBILL7,"^")=$P(RCBILL7,"^")-$P(RCTRAN1,"^",5)
 ;  decrease: add the payment from the bills principal balance
 I $P(RCTRAN1,"^",2)=35 S $P(RCBILL7,"^")=$P(RCBILL7,"^")+$P(RCTRAN1,"^",5)
 I RCFTEST S ^PRCA(430,RCBILLDA,7)=RCBILL7
 ;
 ;  reset the fiscal year multiple
 S FYDA=$O(^PRCA(430,RCBILLDA,2,999),-1)
 I $G(^PRCA(430,RCBILLDA,2,+FYDA,0))'="" I RCFTEST S $P(^PRCA(430,RCBILLDA,2,FYDA,0),"^",2)=$P(RCBILL7,"^")
 ;
 ;  if the bills balance is zero, cancel it
 I '$P(RCBILL7,"^") I RCFTEST S %=$$EDIT430^RCBEUBIL(RCBILLDA,"8////39;")
 ;
 ;  set the payment transaction to incomplete
 I RCFTEST S $P(^PRCA(433,RCTRANDA,0),"^",4)=1
 ;
 ;  add comment to transaction
 S RCCOMMNT(1)="Duplicate deposit "_RCDPOSIT_" with transmission date "_$E(RCTRANDT,4,5)_"/"_$E(RCTRANDT,6,7)_"/"_$E(RCTRANDT,2,3)_" removed."
 I RCFTEST D ADDCOMM^RCBEUTRA(RCTRANDA,.RCCOMMNT)
 ;
 ;  build for mailman report
 S ^TMP("RCDPXFIX",$J,RCBILLDA,RCTRANDA)=""
 Q
 ;
 ;
RECEIPT(RCDPOSIT,RCTRANDT,RCRCPT) ;  make changes to receipt file
 N RCACCT,RCBILLDA,RCDEBTDA,RCPAYDA
 S RCPAYDA=0 F  S RCPAYDA=$O(^RCY(344,RCRCPT,1,RCPAYDA)) Q:'RCPAYDA  D
 .   ;  add comment to payment in receipt file
 .   I RCFTEST S $P(^RCY(344,RCRCPT,1,RCPAYDA,1),"^",2)="Duplicate deposit "_RCDPOSIT_" with transmission date "_$E(RCTRANDT,4,5)_"/"_$E(RCTRANDT,6,7)_"/"_$E(RCTRANDT,2,3)_" removed."
 .   ;
 .   ;  if the account is missing on the payment, then zero out the dollar amount
 .   ;  to prevent it from showing as an unlinked payment
 .   S RCACCT=$P(^RCY(344,RCRCPT,1,RCPAYDA,0),"^",3)
 .   I 'RCACCT S:RCFTEST $P(^RCY(344,RCRCPT,1,RCPAYDA,0),"^",4)=0 Q
 .   ;
 .   ;  check acct to see if it has prepayments open with active bills.  if so,
 .   ;  apply the prepayment to the active bill
 .   S RCDEBTDA=$O(^RCD(340,"B",RCACCT,0)) I 'RCDEBTDA Q
 .   ;
 .   ;  no prepayments for account
 .   I '$O(^PRCA(430,"AS",RCDEBTDA,42,0)) Q
 .   ;
 .   ;  no active bills for account
 .   I '$O(^PRCA(430,"AS",RCDEBTDA,16,0)) Q
 .   ;
 .   ;  loop active (16) bills for debtor and apply prepayment
 .   S RCBILLDA=0 F  S RCBILLDA=$O(^PRCA(430,"AS",RCDEBTDA,16,RCBILLDA)) Q:'RCBILLDA  D
 .   .   ;  no prepayments left, stop loop
 .   .   I '$O(^PRCA(430,"AS",RCDEBTDA,42,0)) S RCBILLDA="A" Q
 .   .   ;
 .   .   ;  this line is for testing
 .   .   I 'RCFTEST W !,"Prepayment being applied to bill ",RCBILLDA Q
 .   .   D PREPAY^RCBEPAYP(RCBILLDA,0)
 Q
