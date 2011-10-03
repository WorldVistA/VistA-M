PRCPCDIC ;WISC/RFJ-disassemble case cart                            ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="P" W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY INVENTORY POINT." Q
 N %,CCITEM,DATA,ITEMDA,ITEMDATA,NOTINVPT,ORDERNO,PRCPCDIC,PRCPID,QUANTITY,TOTVAL,X,Y
 I $$CHECK^PRCPCUT1(PRCP("I")) Q
 S IOP="HOME" D ^%ZIS K IOP
 K X S X(1)="The Disassemble Case Cart option will break down the case cart and return the individual disposable items back to stock."
 S X(2)="When a case cart is disassembled, the quantity on-hand for the case cart will be decremented and the quantity on-hand for the disposable items will be incremented.  The quantity on-hand for reusable items will not change."
 S X(3)="The disposable item quantity to return to stock equals the quantity used for the item during assembly of the case cart."
 S X(4)="This quantity may be different from the case cart definition quantity since the case cart definition may have been altered after the case cart was assembled."
 D DISPLAY^PRCPUX2(40,79,.X)
DISASMBL ;  disassemble case cart
 K NOTINVPT,ORDERNO,PRCPFLAG
 W ! S ITEMDA=$$SELECT^PRCPCED0("C",0,PRCP("I")) I ITEMDA<1 Q
 S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 I ITEMDATA="" W !!,"Case Cart is not stored as an item in the inventory point." G DISASMBL
 I '$P(ITEMDATA,"^",7) W !!,"Case Cart has not been assembled (quantity on-hand is zero)." G DISASMBL
 W ! S QUANTITY=$$QUANTITY^PRCPCUT1($P(ITEMDATA,"^",7),"D") I 'QUANTITY G DISASMBL
 L +^PRCP(445.7,ITEMDA):5 I '$T D SHOWWHO^PRCPULOC(445.7,ITEMDA,0),EXIT G DISASMBL
 D ADD^PRCPULOC(445.7,ITEMDA,0,"Disassemble Case Cart")
 ;
 ;  show items in cc
 D PRINT^PRCPCDIR(ITEMDA,QUANTITY)
 ;  some items not in inventory point message
 I $G(NOTINVPT) D  D EXIT G DISASMBL
 .   K X S X(1)="WARNING -- Before disassembling a case cart, all items used to build the case cart must be contained in the inventory point."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 .   D R^PRCPUREP
 ;
 ;  no items to build list with
 I '$O(^TMP($J,"PRCPCDIR",0)) D  D EXIT G DISASMBL
 .   K X S X(1)="There are no items or defined quantities for disassembling the case cart."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 ;
 ;  user entered '^' during list display
 I $G(PRCPFLAG) D  D EXIT G DISASMBL
 .   K X S X(1)="You must display the entire list of items for the case cart before you can disassemble it."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 S XP="ARE YOU SURE YOU WANT TO DISASSEMBLE THIS CASE CART",XH="Enter 'YES' to disassemble the case cart, 'NO' or '^' to exit."
 W ! I $$YN^PRCPUYN(2)'=1 D EXIT G DISASMBL
 ;
 S ORDERNO=$$ORDERNO^PRCPUTRX(PRCP("I"))
 S CCITEM=0 F  S CCITEM=$O(^TMP($J,"PRCPCDIR",CCITEM)) Q:'CCITEM  S DATA=^(CCITEM) D
 .   K PRCPCDIC S PRCPCDIC("QTY")=$P(DATA,"^"),PRCPCDIC("INVVAL")=$J($P(DATA,"^",2),0,2),PRCPCDIC("REASON")="0:Disassembled Case Cart"
 .   D ITEM^PRCPUUIP(PRCP("I"),CCITEM,"S",ORDERNO,.PRCPCDIC)
 ;
 ;  decrement case cart item
 S ITEMDATA=^PRCP(445,PRCP("I"),1,ITEMDA,0),TOTVAL=$J(QUANTITY*$P(ITEMDATA,"^",22),0,2)
 I $P(ITEMDATA,"^",7)=QUANTITY S TOTVAL=$P(ITEMDATA,"^",27) K ^PRCP(445,PRCP("I"),1,ITEMDA,8)
 K PRCPCDIC S PRCPCDIC("QTY")=-QUANTITY,PRCPCDIC("INVVAL")=-TOTVAL,PRCPCDIC("REASON")="0:Disassembled Case Cart"
 D ITEM^PRCPUUIP(PRCP("I"),ITEMDA,"S",ORDERNO,.PRCPCDIC)
 D EXIT G DISASMBL
 ;
EXIT ;  exit, unlock, clean up
 D CLEAR^PRCPULOC(445.7,ITEMDA,0)
 L -^PRCP(445.7,ITEMDA)
 K ^TMP($J,"PRCPCDIR")
 Q
