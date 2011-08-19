PRCAI164 ;ALB/LDB-post init patch 164 ;19 Nov 00
 ;;4.5;Accounts Receivable;**164**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;  this routine is used to back out an duplicate receipt that has
 ;  been posted to first party bills.  it was used to back out a
 ;  lockbox deposit ticket 269296 which was sent twice from Austin
 ;  on november 10 and november 13, 2000.
 Q
 ;
 ;
START ;  start post init
 D BMES^XPDUTL(" >>  Removing payments for duplicate deposit 269296 ...")
 ;
 N %,RCBILLDA,RCDATA0,RCDPDT,RCFTEST,RCMESSAG,RCRCPT,RCTRAN1,RCTRANDA,X
 K ^TMP("PRCAI164",$J)
 ;
 ;S RCFTEST=0   ;  NO, do not make updates to the database
 S RCFTEST=1  ;  YES, make changes to the database
 ;
 ;  set default message to send to user
 S RCMESSAG="Duplicate receipt not found for deposit 269296.  Patch 164 is installed."
 ;
 ;  find deposit which was posted erroneously
 S RCDPDT=$O(^RCY(344.1,"B",269296,0)) I 'RCDPDT D MAIL^PRCAI16M Q
 ;
 ;  find receipts for deposit
 S RCRCPT=0 F  S RCRCPT=$O(^RCY(344,"AD",RCDPDT,RCRCPT))  Q:'RCRCPT  D
 .   S RCDATA0=$G(^RCY(344,RCRCPT,0))
 .   I $P(RCDATA0,"^",3)'=3001113 Q
 .   ;
 .   ;  patch already installed
 .   I $P(RCDATA0,"^",10) S RCMESSAG="Patch 164 has already been previously installed." Q
 .   ;
 .   ;  found deposit/receipt and it needs to be backed out
 .   S RCMESSAG="Patch 164 has been completely installed."
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
 .   ;  add comment on payments in receipt
 .   D ADDCOMM(RCRCPT)
 .   ;
 .   ;  set piece 10 in receipt to show patch as being installed
 .   I RCFTEST D NOW^%DTC S $P(^RCY(344,RCRCPT,0),"^",10)=%
 ;
 D MAIL^PRCAI16M
 K ^TMP("PRCAI164",$J)
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
 S RCCOMMNT(1)="Incomplete by patch 164 due to duplicate payment processed on deposit 269296"
 I RCFTEST D ADDCOMM^RCBEUTRA(RCTRANDA,.RCCOMMNT)
 ;
 ;  build mailman message
 I RCFREPRT S ^TMP("PRCAI164",$J,RCBILLDA,RCTRANDA)=""
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
 N FYDA,RCBILL7,RCTRAN1
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
 S RCCOMMNT(1)="Incomplete by patch 164 due to duplicate payment processed on deposit 269296"
 I RCFTEST D ADDCOMM^RCBEUTRA(RCTRANDA,.RCCOMMNT)
 ;
 ;  build for mailman report
 S ^TMP("PRCAI164",$J,RCBILLDA,RCTRANDA)=""
 Q
 ;
 ;
ADDCOMM(RCRCPT) ;  add comment on payments on receipt to show they have been removed
 N RCPAYDA
 S RCPAYDA=0 F  S RCPAYDA=$O(^RCY(344,RCRCPT,1,RCPAYDA)) Q:'RCPAYDA  D
 .   I RCFTEST S $P(^RCY(344,RCRCPT,1,RCPAYDA,1),"^",2)="Payment removed by patch 164 as a duplicate."
 Q
