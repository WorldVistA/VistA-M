RCBEREFU ;WISC/RFJ-refund utilities ;1 Mar 2001
 ;;4.5;Accounts Receivable;**169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
REFUREVW(RCDEBTDA) ;  return prepayment bills in status refund review (44)
 ;  returns total of prepayment bills in refund review
 ;  returns rcprepay(billda)=amt in refund review
 N BILLDA,PRINCPAL,RCPREPAY,TOTAL
 K RCPREPAY
 S BILLDA=0 F  S BILLDA=$O(^PRCA(430,"AS",RCDEBTDA,44,BILLDA)) Q:'BILLDA  D
 .   ;  not a prepayment bill
 .   I $P($G(^PRCA(430,BILLDA,0)),"^",2)'=26 Q
 .   ;  prepayment bill in refund review
 .   ;  no money
 .   S PRINCPAL=+$P($G(^PRCA(430,BILLDA,7)),"^") I 'PRINCPAL Q
 .   S RCPREPAY(BILLDA)=PRINCPAL
 .   S TOTAL=$G(TOTAL)+PRINCPAL
 Q +$G(TOTAL)
