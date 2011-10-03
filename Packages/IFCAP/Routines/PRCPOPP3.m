PRCPOPP3 ;WISC/RFJ/DWA-case cart/instrument kit post (cont) ;27 Sep 93
 ;;5.1;IFCAP;**41**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
POST ;  post cc/ik items
 N INVVALUE,ORDRDATA,PRCPOPP,QTYORDER,QTYPOST,QTYRET,QUANTITY,REUSABLE,UNITCOST
 S CCIKITEM=0 F  S CCIKITEM=$O(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM)) Q:'CCIKITEM  D
 .   ;  if cc or ik item is on distribution order, sell ccik item from
 .   ;  primary and update primary qty on-hand, dueouts, etc.
 .   I $D(^PRCP(445.3,ORDERDA,1,CCIKITEM,0)) S ORDRDATA=^(0) D
 .   .   S QUANTITY=$P(ORDRDATA,"^",2),INVVALUE=$J(QUANTITY*$P(ORDRDATA,"^",3),0,2)
 .   .   I 'QUANTITY D DELITEM^PRCPOPD(ORDERDA,CCIKITEM) Q
 .   .   ;  sell item from primary
 .   .   K PRCPOPP
 .   .   S (PRCPOPP("QTY"),PRCPOPP("DUEOUT"))=-QUANTITY,PRCPOPP("INVVAL")=-INVVALUE,PRCPOPP("OTHERPT")=PRCPSECO,PRCPOPP("ORDERDA")=ORDERDA
 .   .   D SALE^PRCPOPPP(PRCPPRIM,CCIKITEM,PRCPPORD,.PRCPOPP)
 .   .   ;
 .   .   K PRCPOPP
 .   .   S PRCPOPP("QTY")=QUANTITY*$P($$GETVEN^PRCPUVEN(PRCPSECO,CCIKITEM,PRCPPRIM_";PRCP(445,",1),"^",4),PRCPOPP("DUEIN")=-PRCPOPP("QTY"),PRCPOPP("INVVAL")=INVVALUE
 .   .   I $G(PRCPPTDA) S PRCPOPP("PRCPPTDA")=+$G(PRCPPTDA)
 .   .   D RECEIPT^PRCPOPPP(PRCPSECO,CCIKITEM,PRCPSORD,.PRCPOPP)
 .   .   ;
 .   .   ;  remove ccik item from order
 .   .   ;D DELITEM^PRCPOPD(ORDERDA,CCIKITEM)
 .   ;
 .   ;  post items in cc/ik
 .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM,ITEMDA)) Q:'ITEMDA  S %=^(ITEMDA) D
 .   .   S QTYORDER=$P(%,"^"),QTYRET=$P(%,"^",2),QTYPOST=QTYORDER-QTYRET
 .   .   S REUSABLE=$$REUSABLE^PRCPU441(ITEMDA)
 .   .   ;  calculate inventory value of items sold
 .   .   S %=$G(^PRCP(445,PRCPPRIM,1,ITEMDA,0))
 .   .   S UNITCOST=$P(%,"^",15) I 'UNITCOST S UNITCOST=$P(%,"^",22)
 .   .   S INVVALUE=$J(QTYPOST*UNITCOST,0,2)
 .   .   D PRIMARY
 .   .   D SECOND
 Q
 ;
 ;
PRIMARY ;  sale of item from primary
 ;  if an item is an ik, sell it
 ;I $D(^PRCP(445.8,ITEMDA)) D  Q
 ;.   K PRCPOPP
 ;.   S PRCPOPP("QTY")=-QTYPOST,PRCPOPP("INVVAL")=-INVVALUE,PRCPOPP("OTHERPT")=PRCPSECO,PRCPOPP("ORDERDA")=ORDERDA
 ;.   S PRCPOPP("REASON")="0:Instrument kit sold with case cart IM# "_CCIKITEM
 ;.   D SALE^PRCPOPPP(PRCPPRIM,ITEMDA,PRCPPORD,.PRCPOPP)
 ;
 ;  if item is reusable and was returned, do nothing
 I REUSABLE,QTYPOST=0 Q
 ;
 ;  if item is reusable and not returned, sell it
 I REUSABLE D  Q
 .   K PRCPOPP
 .   S PRCPOPP("QTY")=-QTYPOST,PRCPOPP("INVVAL")=-INVVALUE,PRCPOPP("OTHERPT")=PRCPSECO,PRCPOPP("ORDERDA")=ORDERDA
 .   S PRCPOPP("REASON")="0:Reusable item not returned in cc,ik IM# "_CCIKITEM
 .   D SALE^PRCPOPPP(PRCPPRIM,ITEMDA,PRCPPORD,.PRCPOPP)
 ;
 ;  disposable items
 ;  if item is disposable and not returned, show distribution
 ;  do not update primary invpt since it was updated during assembly
 I QTYRET=0 D  Q
 .   K PRCPOPP
 .   S PRCPOPP("QTY")=-QTYPOST,PRCPOPP("INVVAL")=-INVVALUE,PRCPOPP("OTHERPT")=PRCPSECO,PRCPOPP("ORDERDA")=ORDERDA,PRCPOPP("NOINVPT")=1
 .   D SALE^PRCPOPPP(PRCPPRIM,ITEMDA,PRCPPORD,.PRCPOPP)
 ;
 ;  if disposable item is returned, add back to primary inventory
 K PRCPOPP
 S PRCPOPP("QTY")=QTYRET,PRCPOPP("INVVAL")=$J(QTYRET*UNITCOST,0,2)
 S PRCPOPP("REASON")="0:Disposable item returned with cc,ik IM# "_CCIKITEM
 D INVPT^PRCPOPPP(PRCPPRIM,ITEMDA,"S",PRCPPORD,.PRCPOPP)
 Q
 ;
 ;
SECOND ;  receipt in secondary
 ;  if an item is an ik, receive it
 I $D(^PRCP(445.8,ITEMDA)) D  Q
 .   K PRCPOPP
 .   S PRCPOPP("QTY")=QTYPOST,PRCPOPP("INVVAL")=INVVALUE,PRCPOPP("OTHERPT")=PRCPPRIM
 .   I $G(PRCPPTDA) S PRCPOPP("PRCPPTDA")=+$G(PRCPPTDA)
 .   S PRCPOPP("REASON")="0:Instrument kit sold with case cart IM# "_CCIKITEM
 .   D RECEIPT^PRCPOPPP(PRCPSECO,ITEMDA,PRCPSORD,.PRCPOPP)
 ;
 ;  if item is reusable and was returned, do nothing
 I REUSABLE,QTYPOST=0 Q
 ;
 ;  if item is reusable and not returned, receive it
 I REUSABLE D  Q
 .   K PRCPOPP
 .   S PRCPOPP("QTY")=QTYPOST,PRCPOPP("INVVAL")=INVVALUE,PRCPOPP("OTHERPT")=PRCPPRIM
 .   I $G(PRCPPTDA) S PRCPOPP("PRCPPTDA")=+$G(PRCPPTDA)
 .   S PRCPOPP("REASON")="0:Reusable item not returned in cc,ik IM# "_CCIKITEM
 .   D RECEIPT^PRCPOPPP(PRCPSECO,ITEMDA,PRCPSORD,.PRCPOPP)
 ;
 ;  disposable items
 ;  if item is disposable and returned, do nothing
 I QTYPOST=0 Q
 ;
 ;  disposable items not returned
 K PRCPOPP
 S PRCPOPP("QTY")=QTYPOST,PRCPOPP("INVVAL")=INVVALUE,PRCPOPP("OTHERPT")=PRCPPRIM
 I $G(PRCPPTDA) S PRCPOPP("PRCPPTDA")=+$G(PRCPPTDA)
 D RECEIPT^PRCPOPPP(PRCPSECO,ITEMDA,PRCPSORD,.PRCPOPP)
 Q
