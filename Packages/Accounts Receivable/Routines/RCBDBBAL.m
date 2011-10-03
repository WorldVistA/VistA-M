RCBDBBAL ;WISC/RFJ-bill balances check ;1 Mar 2001
 ;;4.5;Accounts Receivable;**169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
OUTOFBAL(RCBILLDA) ;  returns balance if a bill is out of balance
 ;  returns rclist array of transactions against bill
 ;  locks to file 430 should be applied before calling this function
 ;
 N BALANCE,DATA7,OUTOFBAL,STATUS
 ;  if it is not activated, not out of balance
 I '$P($G(^PRCA(430,RCBILLDA,6)),"^",21) Q ""
 ;
 ;  calculate balance and get current balance
 S BALANCE=$$GETTRANS^RCDPBTLM(RCBILLDA)
 S DATA7=$G(^PRCA(430,RCBILLDA,7))
 S STATUS=$P($G(^PRCA(430,RCBILLDA,0)),"^",8)
 ;
 ;  for a write-off bill, the balance should equal all zeros, for
 ;  these bills, node 7 is the write-off amount, so for the out of
 ;  balance check to work, node 7 needs to be adjusted to all zeros
 I STATUS=23 S DATA7="0^0^0^0^0"
 ;
 ;  test for out of balance
 S OUTOFBAL=0
 I +$P(DATA7,"^")'=+$P(BALANCE,"^")!(+$P(DATA7,"^",2)'=+$P(BALANCE,"^",2))!(+$P(DATA7,"^",3)'=+$P(BALANCE,"^",3))!(+$P(DATA7,"^",4)'=+$P(BALANCE,"^",4))!(+$P(DATA7,"^",5)'=+$P(BALANCE,"^",5)) S OUTOFBAL=1
 ;
 ;  for collected/closed (22) and cancellation (39) bills
 ;  the balance in 430 should equal 0, if not it is out of balance
 I STATUS=22!(STATUS)=39 I $TR($P(DATA7,"^",1,5),"^0")'="" S OUTOFBAL=1
 ;
 Q $S('OUTOFBAL:"",1:BALANCE)
