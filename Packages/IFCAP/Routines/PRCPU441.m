PRCPU441 ;WISC/RFJ-master item file utilities                       ;10 Feb 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PURCHASE(ITEMDA) ;  return 1 if item is purchasable
 Q $S($P($G(^PRC(441,+ITEMDA,0)),"^",6)'="S":1,1:0)
 ;
 ;
REUSABLE(ITEMDA) ;  return if item is resuable or disposable
 Q $S($P($G(^PRC(441,+ITEMDA,0)),"^",13)="y":1,1:0)
 ;
 ;
SUBACCT(ITEMDA) ;  return subacct of item
 Q $P($G(^PRC(441,+ITEMDA,0)),"^",10)
 ;
 ;
MANDSRCE(ITEMDA)   ;  return mandatory source for item
 Q $P($G(^PRC(441,+ITEMDA,0)),"^",8)
 ;
 ;
INACTIVE(ITEMDA)   ;  return 1 if item is inactive
 Q +$P($G(^PRC(441,+ITEMDA,3)),"^")
