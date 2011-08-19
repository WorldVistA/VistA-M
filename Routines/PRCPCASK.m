PRCPCASK ;WISC/RFJ-assemble instrument kit                          ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="P" W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY INVENTORY POINT." Q
 N %,IKITEM,DATA,ITEMDA,NEGATIVE,NOTINVPT,ORDERNO,PRCPCASK,PRCPID,PRCPITEM,QUANTITY,X,Y
 I $$CHECK^PRCPCUT1(PRCP("I")) Q
 S IOP="HOME" D ^%ZIS K IOP
 K X S X(1)="The Assemble Instrument Kit option will build the selected instrument kit by the instrument kit definition.  The instrument kit definition describes the items and quantities which are used in building the instrument kit."
 S X(2)="If a instrument kit has previously been built by the inventory point and the definition has been altered, the previously built instrument kit will have to be disassembled first."
 D DISPLAY^PRCPUX2(40,79,.X)
ASSEMBLE ;  assemble instrument kit
 K NEGATIVE,NOTINVPT,ORDERNO,PRCPFLAG
 W ! S ITEMDA=$$SELECT^PRCPCED0("K",0,PRCP("I")) I ITEMDA<1 Q
 I '$D(^PRCP(445,PRCP("I"),1,ITEMDA,0)) W !!,"Instrument Kit is not stored as an item in the inventory point." G ASSEMBLE
 W ! S QUANTITY=$$QUANTITY^PRCPCUT1(99,"A") I 'QUANTITY G ASSEMBLE
 L +^PRCP(445.8,ITEMDA):5 I '$T D SHOWWHO^PRCPULOC(445.8,ITEMDA,0),EXIT G ASSEMBLE
 D ADD^PRCPULOC(445.8,ITEMDA,0,"Assemble Intrument Kit")
 D GETDEF^PRCPCUT1(445.8,ITEMDA)
 ;I '$O(^TMP($J,"PRCPLIST-DISP",0)) W !!,"No Disposable Items Stored in Instrument Kit." D EXIT G ASSEMBLE
 ;
 I $P($G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),"^",7) D CHECK^PRCPCASR("I") I $G(PRCPFLAG) D EXIT G ASSEMBLE
 ;
 ;  show items in ik
 D PRINT^PRCPCASR(QUANTITY)
 ;  some items not in inventory point message
 I $G(NOTINVPT) D  D EXIT G ASSEMBLE
 .   K X S X(1)="WARNING -- Before assembling a instrument kit, all items used to build the instrument kit must be contained in the inventory point."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 .   D R^PRCPUREP
 ;
 ;  some items have new quantities less than zero
 I $G(NEGATIVE) D
 .   K X S X(1)="WARNING -- After assembling the instrument kit, some of the items contained within the instrument kit will have a quantity on-hand less than zero."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 ;
 ;  no disposable items to build list with
 I '$O(^TMP($J,"PRCPCASR",0)) D  D EXIT G ASSEMBLE
 .   K X S X(1)="There are no disposable items or defined quantities for building the instrument kit."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 .   K X S X(1)="Assembling Instrument Kit" D DISPLAY^PRCPUX2(1,79,.X)
 .   ;  increment ik qty
 .   S ORDERNO=$$ORDERNO^PRCPUTRX(PRCP("I"))
 .   K PRCPCASK S PRCPCASK("QTY")=QUANTITY,PRCPCASK("INVVAL")=0,PRCPCASK("REASON")="0:Assembled Instrument Kit"
 .   D ITEM^PRCPUUIP(PRCP("I"),ITEMDA,"S",ORDERNO,.PRCPCASK)
 ;
 ;  user entered '^' during list display
 I $G(PRCPFLAG) D  D EXIT G ASSEMBLE
 .   K X S X(1)="You must display the entire list of items for the instrument kit before you can assemble it."
 .   D DISPLAY^PRCPUX2(20,60,.X)
 S XP="ARE YOU SURE YOU WANT TO ASSEMBLE THIS INSTRUMENT KIT",XH="Enter 'YES' to assemble the instrument kit, 'NO' or '^' to exit."
 W ! I $$YN^PRCPUYN(2)'=1 D EXIT G ASSEMBLE
 ;
 ;  reset instrument kit items in inventory point
 K ^PRCP(445,PRCP("I"),1,ITEMDA,8)
 S ORDERNO=$$ORDERNO^PRCPUTRX(PRCP("I"))
 S IKITEM=0 F  S IKITEM=$O(^TMP($J,"PRCPCASR",IKITEM)) Q:'IKITEM  S DATA=^(IKITEM) D
 .   K PRCPCASK S PRCPCASK("QTY")=-$P(DATA,"^"),PRCPCASK("INVVAL")=-$J($P(DATA,"^",2),0,2),PRCPCASK("REASON")="0:Assembled Instrument Kit"
 .   D ITEM^PRCPUUIP(PRCP("I"),IKITEM,"S",ORDERNO,.PRCPCASK)
 .   ;
 .   ; add item to instrument kit in inventory point
 .   D ADDCCIK^PRCPCUT1(PRCP("I"),ITEMDA,IKITEM,^TMP($J,"PRCPLIST",IKITEM))
 ;
 ;  increment instrument kit item
 K PRCPCASK S PRCPCASK("QTY")=QUANTITY,PRCPCASK("INVVAL")=$J(QUANTITY*$P($G(^PRCP(445.8,ITEMDA,0)),"^",9),0,2),PRCPCASK("REASON")="0:Assembled Instrument Kit"
 D ITEM^PRCPUUIP(PRCP("I"),ITEMDA,"S",ORDERNO,.PRCPCASK)
 D EXIT G ASSEMBLE
 ;
EXIT ;  exit, unlock, clean up
 D CLEAR^PRCPULOC(445.8,ITEMDA,0)
 L -^PRCP(445.8,ITEMDA)
 K ^TMP($J,"PRCPLIST"),^TMP($J,"PRCPLIST-DISP"),^TMP($J,"PRCPCASR")
 Q
