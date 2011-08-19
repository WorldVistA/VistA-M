PRCPCASC ;WISC/RFJ-assemble case cart                               ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="P" W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY INVENTORY POINT." Q
 N %,CCITEM,DATA,ITEMDA,NEGATIVE,NOTINVPT,ORDERNO,PRCPCASC,PRCPID,PRCPITEM,QUANTITY,X,Y
 I $$CHECK^PRCPCUT1(PRCP("I")) Q
 S IOP="HOME" D ^%ZIS K IOP
 K X S X(1)="The Assemble Case Cart option will build the selected case cart by the case cart definition.  The case cart definition describes the items and quantities which are used in building the case cart."
 S X(2)="If a case cart has previously been built by the inventory point and the definition has been altered, the previously built case cart will have to be disassembled first."
 D DISPLAY^PRCPUX2(40,79,.X)
ASSEMBLE ;  assemble case cart
 K NEGATIVE,NOTINVPT,ORDERNO,PRCPFLAG
 W ! S ITEMDA=$$SELECT^PRCPCED0("C",0,PRCP("I")) I ITEMDA<1 Q
 I '$D(^PRCP(445,PRCP("I"),1,ITEMDA,0)) W !!,"Case Cart is not stored as an item in the inventory point." G ASSEMBLE
 W ! S QUANTITY=$$QUANTITY^PRCPCUT1(99,"A") I 'QUANTITY G ASSEMBLE
 L +^PRCP(445.7,ITEMDA):5 I '$T D SHOWWHO^PRCPULOC(445.7,ITEMDA,0),EXIT G ASSEMBLE
 D ADD^PRCPULOC(445.7,ITEMDA,0,"Assemble Case Cart")
 D GETDEF^PRCPCUT1(445.7,ITEMDA)
 I '$O(^TMP($J,"PRCPLIST-DISP",0)) W !!,"No Disposable Items Stored in Case Cart." D EXIT G ASSEMBLE
 ;
 I $P($G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),"^",7) D CHECK^PRCPCASR("C") I $G(PRCPFLAG) D EXIT G ASSEMBLE
 ;
 ;  show items in cc
 D PRINT^PRCPCASR(QUANTITY)
 ;  some items not in inventory point message
 I $G(NOTINVPT) D  D EXIT G ASSEMBLE
 .   K X S X(1)="WARNING -- Before assembling a case cart, all items used to build the case cart must be contained in the inventory point."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 .   D R^PRCPUREP
 ;
 ;  some items have new quantities less than zero
 I $G(NEGATIVE) D
 .   K X S X(1)="WARNING -- After assembling the case cart, some of the items contained within the case cart will have a quantity on-hand less than zero."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 ;
 ;  no disposable items to build list with
 I '$O(^TMP($J,"PRCPCASR",0)) D  D EXIT G ASSEMBLE
 .   K X S X(1)="There are no disposable items or defined quantities for building the case cart."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 ;
 ;  user entered '^' during list display
 I $G(PRCPFLAG) D  D EXIT G ASSEMBLE
 .   K X S X(1)="You must display the entire list of items for the case cart before you can assemble it."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 S XP="ARE YOU SURE YOU WANT TO ASSEMBLE THIS CASE CART",XH="Enter 'YES' to assemble the case cart, 'NO' or '^' to exit."
 W ! I $$YN^PRCPUYN(2)'=1 D EXIT G ASSEMBLE
 ;
 ;  reset case cart items in inventory point
 K ^PRCP(445,PRCP("I"),1,ITEMDA,8)
 S ORDERNO=$$ORDERNO^PRCPUTRX(PRCP("I"))
 S CCITEM=0 F  S CCITEM=$O(^TMP($J,"PRCPCASR",CCITEM)) Q:'CCITEM  S DATA=^(CCITEM) D
 .   K PRCPCASC S PRCPCASC("QTY")=-$P(DATA,"^"),PRCPCASC("INVVAL")=-$J($P(DATA,"^",2),0,2),PRCPCASC("REASON")="0:Assembled Case Cart"
 .   D ITEM^PRCPUUIP(PRCP("I"),CCITEM,"S",ORDERNO,.PRCPCASC)
 .   ;
 .   ; add item to case cart in inventory point
 .   D ADDCCIK^PRCPCUT1(PRCP("I"),ITEMDA,CCITEM,^TMP($J,"PRCPLIST",CCITEM))
 ;
 ;  increment case cart item
 K PRCPCASC S PRCPCASC("QTY")=QUANTITY,PRCPCASC("INVVAL")=$J(QUANTITY*$P($G(^PRCP(445.7,ITEMDA,0)),"^",7),0,2),PRCPCASC("REASON")="0:Assembled Case Cart"
 D ITEM^PRCPUUIP(PRCP("I"),ITEMDA,"S",ORDERNO,.PRCPCASC)
 D EXIT G ASSEMBLE
 ;
EXIT ;  exit, unlock, clean up
 D CLEAR^PRCPULOC(445.7,ITEMDA,0)
 L -^PRCP(445.7,ITEMDA)
 K ^TMP($J,"PRCPLIST"),^TMP($J,"PRCPLIST-DISP"),^TMP($J,"PRCPCASR")
 Q
