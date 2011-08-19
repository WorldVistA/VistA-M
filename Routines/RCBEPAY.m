RCBEPAY ;WISC/RFJ-payment processing (top routine)                  ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PROCESS(RCRECTDA,RCPAYDA) ;  process a payment for receipt
 ;  rcrectda - receipt ien file 344
 ;  rcpayda  - payment ien file 344 under rcrectda
 ;  returns 0 if processed, 1^error if not processed
 ;
 N RCACCT,RCBILLDA,RCDATA,RCERROR,RCPAYAMT,RCPAYDAT,RCTRANDA,X
 ;
 ;  lock the receipt payment
 L +^RCY(344,RCRECTDA,1,RCPAYDA):10
 I '$T Q "1^Another user is working with this payment"
 ;
 ;  get the payment data
 S RCDATA=^RCY(344,RCRECTDA,1,RCPAYDA,0)
 ;
 ;  there is no account, this will go to suspense
 I $P(RCDATA,"^",3)="" L -^RCY(344,RCRECTDA,1,RCPAYDA) Q 0
 ;
 ;  check the payment for errors
 S X=$$CHECKPAY^RCBEPAYC(RCRECTDA,RCPAYDA)
 I X L -^RCY(344,RCRECTDA,1,RCPAYDA) Q X
 ;
 ;  get the payment date from the payment.  if not on payment get it
 ;  from the deposit.  if not on deposit, set equal to today
 S RCPAYDAT=$P($P(RCDATA,"^",6),".") I 'RCPAYDAT S RCPAYDAT=$P($G(^RCY(344.1,+$P(^RCY(344,RCRECTDA,0),"^",6),0)),"^",3) I 'RCPAYDAT S RCPAYDAT=DT
 ;  get the payment amount (amount paid minus amount processed).
 ;  if the payment amount is not greater than zero, do not post.
 S RCPAYAMT=$P(RCDATA,"^",4)-$P(RCDATA,"^",5) I RCPAYAMT'>0 L -^RCY(344,RCRECTDA,1,RCPAYDA) Q 0
 ;
 ;  get the account
 S RCACCT=$P(RCDATA,"^",3)
 ;  if the account is a bill and the debtor is first party,
 ;  then get the account from the debtor file
 I RCACCT["PRCA(430," S X=$P($G(^RCD(340,+$P($G(^PRCA(430,+RCACCT,0)),"^",9),0)),"^") I X["DPT(" S RCACCT=X
 ;
 ;
 ;  ----------------- START PROCESSING PAYMENT -----------------
 ;
 ;  === benefit debt (example: first party account) ===
 I RCACCT["DPT(" D  Q RCERROR
 .   S RCERROR=$$FIRSTPTY^RCBEPAYF
 .   ;  store or clear error
 .   D SETERROR(RCRECTDA,RCPAYDA,$P(RCERROR,"^",2))
 .   L -^RCY(344,RCRECTDA,1,RCPAYDA)
 ;
 ;
 ;  === non-benefit debt (example: third party) ===
 S RCBILLDA=+$P(RCDATA,"^",3)
 ;  lock the bill to prevent another used from changing the balance
 L +^PRCA(430,RCBILLDA):10
 I '$T D  Q RCERROR
 .   S RCERROR="1^Another user is working with bill "_$P(^PRCA(430,RCBILLDA,0),"^")
 .   D SETERROR(RCRECTDA,RCPAYDA,$P(RCERROR,"^",2))
 .   L -^RCY(344,RCRECTDA,1,RCPAYDA)
 ;
 ;  exempt any interest/admin/penalty charges added on or after
 ;  the payment date
 D EXEMPT^RCBECHGE(RCBILLDA,RCPAYDAT)
 ;
 ;  once charges have been exempted, recheck the payment for errors
 S X=$$CHECKPAY^RCBEPAYC(RCRECTDA,RCPAYDA)
 I X D  Q RCERROR
 .   S RCERROR="1^"_$P(X,"^",2)
 .   D SETERROR(RCRECTDA,RCPAYDA,$P(RCERROR,"^",2))
 .   L -^PRCA(430,RCBILLDA)
 .   L -^RCY(344,RCRECTDA,1,RCPAYDA)
 ;
 ;  apply payment to bill
 ;  return error if problem adding payment transaction
 S RCTRANDA=$$PAYTRAN^RCBEPAY1(RCBILLDA,RCPAYAMT,RCRECTDA,RCPAYDA,RCPAYDAT)
 I 'RCTRANDA D  Q RCERROR
 .   S RCERROR="1^"_$P(RCTRANDA,"^",2)
 .   D SETERROR(RCRECTDA,RCPAYDA,$P(RCERROR,"^",2))
 .   L -^PRCA(430,RCBILLDA)
 .   L -^RCY(344,RCRECTDA,1,RCPAYDA)
 ;
 ;  set the amount processed in the receipt
 D SETAMT(RCRECTDA,RCPAYDA,$P($G(^PRCA(433,RCTRANDA,1)),"^",5))
 ;
 ;  payment applied to bill
 D SETERROR(RCRECTDA,RCPAYDA,"")
 L -^PRCA(430,RCBILLDA)
 L -^RCY(344,RCRECTDA,1,RCPAYDA)
 Q 0
 ;
 ;
SETAMT(RCRECTDA,RCPAYDA,RCAMOUNT) ;  update the amount posted on the receipt
 N DATA
 S DATA=$G(^RCY(344,RCRECTDA,1,RCPAYDA,0))
 I DATA="" Q
 S $P(^RCY(344,RCRECTDA,1,RCPAYDA,0),"^",5)=$P(DATA,"^",5)+RCAMOUNT
 Q
 ;
 ;
SETERROR(RCRECTDA,RCPAYDA,RCERROR) ;  store the error on the receipt
 ;  or clear the posting error if null and defined
 ;  error is null and posting error data in file is null
 I RCERROR="",$P($G(^RCY(344,RCRECTDA,1,RCPAYDA,1)),"^")="" Q
 ;  error is null, clear posting error
 I RCERROR="" S $P(^RCY(344,RCRECTDA,1,RCPAYDA,1),"^")="" Q
 ;  error exists, set the posting error
 I RCERROR'="" S $P(^RCY(344,RCRECTDA,1,RCPAYDA,1),"^")=$E(RCERROR,1,60)
 Q
