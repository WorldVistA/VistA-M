PRCPUSA ;WISC/RFJ-utility program for updating inventory point     ;30 Sep 92
 ;;5.1;IFCAP;**126**;Oct 20, 2000;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified.
 S X=$$UPDATE(.PRCP) I X'="" W !!,X Q
 K PRCP,X Q
 ;
 ;
UPDATE(PRCPZ) ;  start updating inventory point
 ;prcpz =
 ;  i)        = internal inventory point number
 ;  item)     = item number
 ;  typ)      = R or C for distribution
 ;                   = RC for receipts
 ;                   = U for usage
 ;                   = A for adjustment
 ;                   = P for physical counts
 ;  qty)      = quantity to  add to on-hand
 ;  com)      = transaction register comments
 ;  returns error message if unsuccessful or null if successful
 ;
 I '$D(^PRCP(445,+$G(PRCPZ("I")),0)) Q "Invalid inventory location"
 I '$D(^PRCP(445,PRCPZ("I"),4,+$G(DUZ),0)) Q "User does not have access to the inventory point"
 I '$D(^PRCP(445,PRCPZ("I"),1,+$G(PRCPZ("ITEM")),0)) Q "Item is not stored in inventory point"
 S:'$D(PRCPZ("TYP")) PRCPZ("TYP")="" I "RCAUP"'[PRCPZ("TYP") Q "Invalid transaction type '"_PRCPZ("TYP")_"'"
 S:'$D(PRCPZ("QTY")) PRCPZ("QTY")=0 I "AP"'[PRCPZ("TYP"),PRCPZ("QTY")=0 Q "Quantity cannot equal zero"
 I PRCPZ("TYP")="RC",PRCPZ("QTY")<0 Q "For receipts, quantity must be greater than zero"
 I (PRCPZ("TYP")="R"!(PRCPZ("TYP")="C"))&(PRCPZ("QTY")>0) Q "For distribution (Regular or Call-in), quantity must be less than zero"
 ;
 N ORDERNO,PRCPID,PRCPUSA,TOTCOST,VALUE,X,Y,Z
 S VALUE=$P(^PRCP(445,PRCPZ("I"),1,PRCPZ("ITEM"),0),"^",22)
 I VALUE=0,PRCPZ("TYP")="P" S VALUE=$P(^PRCP(445,PRCPZ("I"),1,PRCPZ("ITEM"),0),"^",15)
 S TOTCOST=$J(PRCPZ("QTY")*VALUE,0,2)
 ;
 I $P(^PRCP(445,PRCPZ("I"),0),"^",6)="Y" S ORDERNO=$$ORDERNO^PRCPUTRX(PRCPZ("I"))
 K PRCPUSA S PRCPUSA("QTY")=PRCPZ("QTY"),PRCPUSA("INVVAL")=TOTCOST,PRCPUSA("SELVAL")=TOTCOST,PRCPUSA("REASON")="0:"_$G(PRCPZ("COM")),PRCPUSA("NODUEIN")=1,PRCPUSA("NODUEOUT")=1,PRCPUSA("OTHERPT")=""
 D ITEM^PRCPUUIP(PRCPZ("I"),PRCPZ("ITEM"),PRCPZ("TYP"),+$G(ORDERNO),.PRCPUSA)
 Q ""
