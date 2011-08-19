PRCPRLDO ;WISC/RFJ-list distribution orders ;7/24/00  23:29
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$D(PRCP("I"))
 N %,ORDERDA,PRCPFITM,PRCPFLAG,PRCPFPIC,X
 K X S X(1)="The List Distribution Orders To/From Inventory Point option will display distribution orders which have been entered but not posted to the secondary."
 D DISPLAY^PRCPUX2(40,79,.X)
 I PRCP("DPTYPE")="P" D  Q:$G(PRCPFLAG)
 .   K X S X(1)="You have the option to release all orders which have been placed to "_PRCP("IN")_", but not released for filling." D DISPLAY^PRCPUX2(2,40,.X)
 .   S XP="Do you want to release the orders now",XH="Enter YES to release the orders."
 .   S %=$$YN^PRCPUYN(2) I '% S PRCPFLAG=1 Q
 .   I %=1 D
 .   .   K ^TMP($J,"PRCPBAL3")
 .   .   S ORDERDA=0 F  S ORDERDA=$O(^PRCP(445.3,ORDERDA)) Q:'ORDERDA  S DATA=$G(^(ORDERDA,0)) I $P(DATA,"^",2)=PRCP("I"),$P(DATA,"^",6)="" S ^TMP($J,"PRCPBAL3",ORDERDA)=""
 .   .   I '$O(^TMP($J,"PRCPBAL3",0)) W !,"NO ORDERS READY FOR RELEASING." Q
 .   .   D RELEASE^PRCPBAL3
 .   .   K ^TMP($J,"PRCPBAL3")
 .   ;
 .   K X S X(1)="You have the option to print the picking tickets for all orders which have been released for filling to "_PRCP("IN")_".  Only the picking tickets which have never been printed (no reprints) will be selected."
 .   W ! D DISPLAY^PRCPUX2(2,40,.X)
 .   S XP="Do you want to print picking tickets for released orders",XH="Enter YES to print the picking tickets for all released orders,",XH(1)="Enter NO to skip printing the picking tickets."
 .   S %=$$YN^PRCPUYN(2) I '% S PRCPFLAG=1 Q
 .   S PRCPFPIC=$S(%=1:1,1:0)
 I $G(PRCPFPIC) D DEVICE Q
 ;
 K X S X(1)="You have the option to print the list of items for each order or to print each order just displaying the status." W ! D DISPLAY^PRCPUX2(2,40,.X)
 S XP="Do you want to breakout a list of items on each order",XH="Enter YES to display a list of all items on the order,",XH(1)="Enter NO to only print the status of each order."
 S %=$$YN^PRCPUYN(2) I '% Q
 S PRCPFITM=$S(%=1:1,1:0)
DEVICE ;
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $G(PRCPFPIC),IO=IO(0) W !,"YOU CANNOT SELECT YOUR CURRENT DEVICE FOR PRINTING PICKING TICKETS." G DEVICE
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="List Distribution Orders",ZTRTN="DQ^PRCPRLDO"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 I $G(PRCPFPIC) D PICKTICK Q
 ;
 N DATA,ITEMDA,ITEMDATA,NOW,ORDERDA,PAGE,PRCPFLAG,SCREEN,UNITCOST,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S ORDERDA=0 F  S ORDERDA=$O(^PRCP(445.3,ORDERDA)) Q:'ORDERDA!($G(PRCPFLAG))  S DATA=$G(^(ORDERDA,0)) I DATA'="" D
 .   I $P(DATA,"^",6)="P" Q
 .   I PRCP("DPTYPE")="P",$P(DATA,"^",2)'=PRCP("I") Q
 .   I PRCP("DPTYPE")="S",$P(DATA,"^",3)'=PRCP("I") Q
 .   S Y=$P(DATA,"^",4) D DD^%DT
 .   W !,$P(DATA,"^"),?8,$P(Y,"@"),?22,$P($$TYPE^PRCPOPU(ORDERDA),"ORDER"),?32,$$STATUS^PRCPOPU(ORDERDA)
 .   I PRCP("DPTYPE")="P" W ?54,$E($$INVNAME^PRCPUX1(+$P(DATA,"^",3)),1,25)
 .   I PRCP("DPTYPE")="S" W ?54,$E($$INVNAME^PRCPUX1(+$P(DATA,"^",2)),1,25)
 .   I $Y>(IOSL-5) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 .   I '$G(PRCPFITM) Q
 .   S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S ITEMDATA=$G(^(ITEMDA,0)) I ITEMDATA'="" D
 .   .   S UNITCOST=$P($G(^PRCP(445,+$P(DATA,"^",2),1,ITEMDA,0)),"^",22)
 .   .   W !?10,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,29),?40,ITEMDA,?50,$J(+$P(ITEMDATA,"^",2),15),$J(UNITCOST,15)
 .   .   I $Y>(IOSL-5) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 D END^PRCPUREP
 D ^%ZISC
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"LIST DISTRIBUTION ORDER REPORT FOR ",PRCP("IN"),?(80-$L(%)),%
 W !,"ORDER#",?8,"DATE",?22,"TYPE",?32,"STATUS",?54,"DELIVER ",$S(PRCP("DPTYPE")="P":"TO",1:"FROM")," INVENTORY POINT"
 I $G(PRCPFITM) W !?10,"ITEM",?40,"MI#",?50,$J("QUANTITY",15),$J("EST. UNIT COST",15)
 S %="",$P(%,"-",81)="" W !,%
 Q
 ;
 ;
PICKTICK ;  print orders which have been released but the picking ticket
 ;  has not been printed
 N DATA,ORDERDA,PRCPORD,PRCPPAT,PRCPPRIM,PRCPSECO
 S ORDERDA=0 F  S ORDERDA=$O(^PRCP(445.3,ORDERDA)) Q:'ORDERDA  S DATA=$G(^(ORDERDA,0)) I DATA'="" D
 .   I PRCP("DPTYPE")="P",$P(DATA,"^",2)'=PRCP("I") Q
 .   I $P(DATA,"^",7)="Y" Q
 .   I $P(DATA,"^",6)'="R" Q
 .   D VARIABLE^PRCPOPU
 .   D BUILD^PRCPOPT(ORDERDA)
 .   D DQ^PRCPOPT1
 D Q^PRCPOPT
 Q
