RCBEPAYC ;WISC/RFJ-check a payment before processing                 ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CHECKPAY(RCRECTDA,RCPAYDA) ;  check a payment before processing.  this call
 ;  is normally used to check a payment and verify that the billed
 ;  amount is not less than the paid amount.
 ;  returns 1^error if the payment cannot be processed
 ;
 N RCACCT,RCBILAMT,RCDATA,RCPAYAMT,X
 ;
 S RCDATA=$G(^RCY(344,RCRECTDA,1,RCPAYDA,0))
 I RCDATA="" Q "1^Unable to find payment"
 ;
 S RCACCT=$P(RCDATA,"^",3)
 I RCACCT="" Q "1^Account not defined"
 ;
 ;  get the payment amount (amount paid minus amount processed)
 ;  if no payment amount, do not return error
 S RCPAYAMT=$P(RCDATA,"^",4)-$P(RCDATA,"^",5) I RCPAYAMT'>0 Q 0
 ;
 ;  if first party bill, everything is ok, quit
 I $P(RCDATA,"^",3)["DPT(" Q 0
 I $P(RCDATA,"^",3)["PRCA(430,",$P($G(^RCD(340,+$P($G(^PRCA(430,+$P(RCDATA,"^",3),0)),"^",9),0)),"^")["DPT(" Q 0
 ;
 ;  === third party bills ===
 ;
 ;  bill not activated or open
 S X=$P($G(^PRCA(430,+$P(RCDATA,"^",3),0)),"^",8)
 I X'=42,X'=16 Q "1^Bill not activated or open"
 ;
 ;  calculate dollars on receivable
 S X=$G(^PRCA(430,+$P(RCDATA,"^",3),7))
 S RCBILAMT=$P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5)
 ;
 ;  does the payment exceed the billed amount?
 ;  pending payments is not greater than bill balance, payment ok, quit
 I RCPAYAMT'>RCBILAMT Q 0
 ;
 ;  pending payments exceed balance of the bill, return error
 Q "1^Pending Payments of "_$J(RCPAYAMT,0,2)_" is greater than the balance of the bill "_$J(RCBILAMT,0,2)
