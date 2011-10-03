RCBEPAYF ;WISC/RFJ-first party payment processing(called by rcbepay) ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
FIRSTPTY() ;  apply payment to first party account
 ;  called by rcbepay
 N PAYMENT,RCBILBAL,RCBILLDA,RCDATE,RCDEBTDA,RCERROR,RCREPAMT,RCSTATUS,RCTRANDA,X
 K ^TMP("RCBEPAY",$J)
 ;
 ;  look up account in debtor file
 S RCDEBTDA=$$DEBT^RCEVUTL(RCACCT)
 I RCDEBTDA<0 Q "1^Could not add Patient ("_RCACCT_") to debtor file"
 ;
 ;  lock the debtor account
 L +^RCD(340,RCDEBTDA):20 I '$T Q "1^Another user is working with this patient account"
 ;
 ;  build list of active(16) and open(42) bills for patient
 ;  sorted by date bill prepared
 F RCSTATUS=16,42 S RCBILLDA=0 F  S RCBILLDA=$O(^PRCA(430,"AS",RCDEBTDA,RCSTATUS,RCBILLDA)) Q:'RCBILLDA  D
 .   ;  check bill for prepayment
 .   I $P(^PRCA(430,RCBILLDA,0),"^",2)=26 Q
 .   ;  if this bill was entered for payment applied against it on
 .   ;  the receipt, set the tmp global with the date prepared
 .   ;  equal to zero so payment will be applied to it first
 .   I $P(RCDATA,"^",3)["PRCA(430,",RCBILLDA=+$P(RCDATA,"^",3) S ^TMP("RCBEPAY",$J,0,RCBILLDA)="" Q
 .   S ^TMP("RCBEPAY",$J,+$P(^PRCA(430,RCBILLDA,0),"^",10),RCBILLDA)=""
 ;
 ;  loop all the bills for a patients account and keep looping them
 ;  until either there is no more bills or the money paid is zero.
 ;  the bills are looped in case of repayments.  if there is money
 ;  left over, this will apply more money to the repayment bills
 ;  instead of creating a prepayment.  a prepayment should only be
 ;  created if all bills for the account is collected/closed.
 S RCERROR=0
 ;  quit the loop if no money left to apply OR an error occurred OR
 ;  no more bills left to apply payment to
 F  D  I 'RCPAYAMT!(RCERROR)!($O(^TMP("RCBEPAY",$J,""))="") Q
 .   ;  loop the bills by date prepared and apply the payment
 .   ;  quit if no money left to apply OR and error occurred
 .   S RCDATE="" F  S RCDATE=$O(^TMP("RCBEPAY",$J,RCDATE)) Q:RCDATE=""  D  I 'RCPAYAMT!(RCERROR) Q
 .   .   S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("RCBEPAY",$J,RCDATE,RCBILLDA)) Q:'RCBILLDA  D  I 'RCPAYAMT!(RCERROR) Q
 .   .   .   L +^PRCA(430,RCBILLDA):10
 .   .   .   I '$T S RCERROR="1^Another user is working will bill "_$P(^PRCA(430,RCBILLDA,0),"^") Q
 .   .   .   ;
 .   .   .   ;  exempt any interest/admin/penalty charges added on or after
 .   .   .   ;  the payment date
 .   .   .   D EXEMPT^RCBECHGE(RCBILLDA,RCPAYDAT)
 .   .   .   ;
 .   .   .   ;  get the repayment amount (if any)
 .   .   .   S RCREPAMT=$P($G(^PRCA(430,RCBILLDA,4)),"^",3)
 .   .   .   ;
 .   .   .   ;  get the balance of the bill
 .   .   .   S X=$G(^PRCA(430,RCBILLDA,7))
 .   .   .   S RCBILBAL=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)
 .   .   .   ;  if bill has no balance, chg status = collected/closed
 .   .   .   I 'RCBILBAL D CHGSTAT^RCBEUBIL(RCBILLDA,22) L -^PRCA(430,RCBILLDA) K ^TMP("RCBEPAY",$J,RCDATE,RCBILLDA) Q
 .   .   .   ;
 .   .   .   ;  determine amount to pay
 .   .   .   ;  if the payment is greater than billed amount, pay billed amount
 .   .   .   ;  if there is a repayment amount, pay the repayment amount
 .   .   .   ;  do not allow payment to exceed amount paid
 .   .   .   S PAYMENT=RCPAYAMT
 .   .   .   I PAYMENT>RCBILBAL S PAYMENT=RCBILBAL
 .   .   .   I RCREPAMT S PAYMENT=RCREPAMT I PAYMENT>RCBILBAL S PAYMENT=RCBILBAL
 .   .   .   I PAYMENT>RCPAYAMT S PAYMENT=RCPAYAMT
 .   .   .   ;
 .   .   .   ;  apply payment to bill
 .   .   .   ;  return error if problem adding payment transaction
 .   .   .   S RCTRANDA=$$PAYTRAN^RCBEPAY1(RCBILLDA,PAYMENT,RCRECTDA,RCPAYDA,RCPAYDAT)
 .   .   .   I 'RCTRANDA L -^PRCA(430,RCBILLDA) S RCERROR="1^"_$P(RCTRANDA,"^",2) Q
 .   .   .   ;
 .   .   .   ;  payment applied to bill, subtract off the payment amount
 .   .   .   S RCPAYAMT=RCPAYAMT-$P($G(^PRCA(433,RCTRANDA,1)),"^",5)
 .   .   .   ;
 .   .   .   ;  set the amount processed on the receipt payment
 .   .   .   D SETAMT^RCBEPAY(RCRECTDA,RCPAYDA,$P($G(^PRCA(433,RCTRANDA,1)),"^",5))
 .   .   .   ;
 .   .   .   ;  get the new balance of the bill.  if it is zero
 .   .   .   ;  remove it from the tmp global (this will stop the
 .   .   .   ;  loop if dollars are left and no bills are active)
 .   .   .   S X=$G(^PRCA(430,RCBILLDA,7))
 .   .   .   S RCBILBAL=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)
 .   .   .   I 'RCBILBAL K ^TMP("RCBEPAY",$J,RCDATE,RCBILLDA)
 .   .   .   ;
 .   .   .   L -^PRCA(430,RCBILLDA)
 ;
 K ^TMP("RCBEPAY",$J)
 ;
 ;  if an error occurred, quit
 I RCERROR L -^RCD(340,RCDEBTDA) Q RCERROR
 ;
 ;  if no money left, quit
 I 'RCPAYAMT L -^RCD(340,RCDEBTDA) Q 0
 ;
 ;  dollars remaining, create a prepayment
 N %,%H,%I,%X,D,D0,DFN,DI,DIC,DICR,DIG,DIH,DIU,DIV,DIW,DQ,I,PRCA,RCREF,VA,VADM
 D EN^PRCAPAY3(RCACCT,RCPAYAMT,RCPAYDAT,DUZ,$P(^RCY(344,RCRECTDA,0),"^"),"","",.RCERROR,"")
 ;  no errors
 I RCERROR=""!(RCERROR=0) D
 .   S RCERROR=0
 .   ;  set the amount processed on the receipt
 .   D SETAMT^RCBEPAY(RCRECTDA,RCPAYDA,RCPAYAMT)
 ;  error creating prepayment
 I RCERROR'=0 S RCERROR="1^"_RCERROR
 ;
 L -^RCD(340,RCDEBTDA)
 Q RCERROR
