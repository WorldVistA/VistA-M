PRCPSMA0 ;WISC/RFJ-isms adjustment transaction                      ;27 Apr 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
ADJUST(INVPTDA,ITEMDA,QTY,VALUE,AVGCOST,BACKORD) ;adjustment transaction
 ;  invptda = inventory internal entry number
 ;  itemda  = item internal entry number
 ;  qty     = quantity adjustment
 ;  value   = value adjustment
 ;  avgcost = (optional) use this avgcost if defined
 ;  backord = set to null for version 4
 ;
 ;  if qty, no value or avgcost.
 ;  if value, use avgcost but no qty
 ;
 ;  returns 'string("at")' of code sheet
 ;
 N NSN,SKU
 S NSN=$TR($$NSN^PRCPUX1(ITEMDA),"-"),SKU=$$SKU^PRCPUX1(INVPTDA,ITEMDA) I SKU["?"!(NSN="") S STRING("AT")="" Q
 I VALUE S VALUE=$P(VALUE,".")_$P($J(VALUE,0,2),".",2)
 I VALUE,'AVGCOST S AVGCOST=+$P($G(^PRCP(445,+INVPTDA,1,+ITEMDA,0)),"^",22)
 I AVGCOST S AVGCOST=$P(AVGCOST,".")_$P($J(AVGCOST,0,2),".",2)
 S STRING("AT")="AT^"_NSN_"^"_SKU_"^"_QTY_"^"_VALUE_"^"_AVGCOST_"^"_BACKORD_"^|"
 Q
