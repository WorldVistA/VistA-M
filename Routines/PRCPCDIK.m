PRCPCDIK ;WISC/RFJ-disassemble instrument kit                       ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="P" W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY INVENTORY POINT." Q
 N %,IKITEM,DATA,ITEMDA,ITEMDATA,NOTINVPT,ORDERNO,PRCPCDIK,PRCPID,QUANTITY,TOTVAL,X,Y
 I $$CHECK^PRCPCUT1(PRCP("I")) Q
 S IOP="HOME" D ^%ZIS K IOP
 K X S X(1)="The Disassemble Instrument Kit option will break down the instrument kit and return the individual disposable items back to stock."
 S X(2)="When a instrument kit is disassembled, the quantity on-hand for the instrument kit will be decremented and the quantity on-hand for the disposable items will be incremented.  The quantity on-hand for reusable items will not change."
 S X(3)="The disposable item quantity to return to stock equals the quantity used for the item during assembly of the instrument kit."
 S X(4)="This quantity may be different from the instrument kit definition quantity since the instrument kit definition may have been altered after the instrument kit was assembled."
 D DISPLAY^PRCPUX2(40,79,.X)
DISASMBL ;  disassemble instrument kit
 K NOTINVPT,ORDERNO,PRCPFLAG
 W ! S ITEMDA=$$SELECT^PRCPCED0("K",0,PRCP("I")) I ITEMDA<1 Q
 S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 I ITEMDATA="" W !!,"Instrument Kit is not stored as an item in the inventory point." G DISASMBL
 I '$P(ITEMDATA,"^",7) W !!,"Instrument Kit has not been assembled (quantity on-hand is zero)." G DISASMBL
 W ! S QUANTITY=$$QUANTITY^PRCPCUT1($P(ITEMDATA,"^",7),"D") I 'QUANTITY G DISASMBL
 L +^PRCP(445.8,ITEMDA):5 I '$T D SHOWWHO^PRCPULOC(445.8,ITEMDA,0),EXIT G DISASMBL
 D ADD^PRCPULOC(445.8,ITEMDA,0,"Disassemble Instrument Kit")
 ;
 ;  show items in ik
 D PRINT^PRCPCDIR(ITEMDA,QUANTITY)
 ;  some items not in inventory point message
 I $G(NOTINVPT) D  D EXIT G DISASMBL
 .   K X S X(1)="WARNING -- Before disassembling a instrument kit, all items used to build the instrument kit must be contained in the inventory point."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 .   D R^PRCPUREP
 ;
 ;  no items to build list with
 I '$O(^TMP($J,"PRCPCDIR",0)) D  D EXIT G DISASMBL
 .   K X S X(1)="There are no items or defined quantities for disassembling the instrument kit."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 .   K X S X(1)="Disassembling Instrument Kit" D DISPLAY^PRCPUX2(1,79,.X)
 .   ;  decrement instrument kit item
 .   S ORDERNO=$$ORDERNO^PRCPUTRX(PRCP("I"))
 .   S ITEMDATA=^PRCP(445,PRCP("I"),1,ITEMDA,0),TOTVAL=$J(QUANTITY*$P(ITEMDATA,"^",22),0,2)
 .   K PRCPCDIK S PRCPCDIK("QTY")=-QUANTITY,PRCPCDIK("INVVAL")=-TOTVAL,PRCPCDIK("REASON")="0:Disassembled Instrument Kit"
 .   D ITEM^PRCPUUIP(PRCP("I"),ITEMDA,"S",ORDERNO,.PRCPCDIK)
 ;
 ;  user entered '^' during list display
 I $G(PRCPFLAG) D  D EXIT G DISASMBL
 .   K X S X(1)="You must display the entire list of items for the instrument kit before you can disassemble it."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 S XP="ARE YOU SURE YOU WANT TO DISASSEMBLE THIS INSTRUMENT KIT",XH="Enter 'YES' to disassemble the instrument kit, 'NO' or '^' to exit."
 W ! I $$YN^PRCPUYN(2)'=1 D EXIT G DISASMBL
 ;
 S ORDERNO=$$ORDERNO^PRCPUTRX(PRCP("I"))
 S IKITEM=0 F  S IKITEM=$O(^TMP($J,"PRCPCDIR",IKITEM)) Q:'IKITEM  S DATA=^(IKITEM) D
 .   K PRCPCDIK S PRCPCDIK("QTY")=$P(DATA,"^"),PRCPCDIK("INVVAL")=$J($P(DATA,"^",2),0,2),PRCPCDIK("REASON")="0:Disassembled Instrument Kit"
 .   D ITEM^PRCPUUIP(PRCP("I"),IKITEM,"S",ORDERNO,.PRCPCDIK)
 ;
 ;  decrement instrument kit item
 S ITEMDATA=^PRCP(445,PRCP("I"),1,ITEMDA,0),TOTVAL=$J(QUANTITY*$P(ITEMDATA,"^",22),0,2)
 ;  do not remove node 8 since other ccs may contain the ik
 ;I $P(ITEMDATA,"^",7)=QUANTITY S TOTVAL=$P(ITEMDATA,"^",27) K ^PRCP(445,PRCP("I"),1,ITEMDA,8)
 K PRCPCDIK S PRCPCDIK("QTY")=-QUANTITY,PRCPCDIK("INVVAL")=-TOTVAL,PRCPCDIK("REASON")="0:Disassembled Instrument Kit"
 D ITEM^PRCPUUIP(PRCP("I"),ITEMDA,"S",ORDERNO,.PRCPCDIK)
 D EXIT G DISASMBL
 ;
EXIT ;  exit, unlock, clean up
 D CLEAR^PRCPULOC(445.8,ITEMDA,0)
 L -^PRCP(445.8,ITEMDA)
 K ^TMP($J,"PRCPCDIR")
 Q
