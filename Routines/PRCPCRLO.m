PRCPCRLO ;WISC/RFJ-specific item or ik locator report               ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N ITEMDA,X
 K X S X(1)="The Specific Item Or Instrument Kit Locator Report will print which case carts contain a specified item or instrument kit AND which instrument kits contain a specified item."
 D DISPLAY^PRCPUX2(40,79,.X)
 S ITEMDA=$$MASTITEM^PRCPUITM("I '$D(^PRCP(445.7,+Y,0))") I 'ITEMDA Q
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 .   S ZTDESC="Specific Item Or Instrument Kit Locator Report",ZTRTN="DQ^PRCPCRLO"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ITEMDA")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%I,CCITEM,DATA,IKITEM,ITEMDESC,NOW,PAGE,PRCPFLAG,QTY,SCREEN,UNITS,X,Y
 S ITEMDESC=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA),QTY=+$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),"^",7),UNITS=$$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/")
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S CCITEM=0 F  S CCITEM=$O(^PRCP(445.7,"AI",ITEMDA,CCITEM)) Q:'CCITEM!($G(PRCPFLAG))  S DATA=$G(^PRCP(445.7,CCITEM,1,ITEMDA,0)) I DATA'="" D
 .   W !,"CC ITEM # ",CCITEM,?20,$E($$DESCR^PRCPUX1(PRCP("I"),CCITEM),1,28),?50,$E($$INVNAME^PRCPUX1(+$P(^PRCP(445.7,CCITEM,0),"^",2)),1,18),?70,$J($P(DATA,"^",2),10)
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I $G(PRCPFLAG) D Q Q
 S IKITEM=0 F  S IKITEM=$O(^PRCP(445.8,"AI",ITEMDA,IKITEM)) Q:'IKITEM!($G(PRCPFLAG))  S DATA=$G(^PRCP(445.8,IKITEM,1,ITEMDA,0)) I DATA'="" D
 .   W !,"IK ITEM # ",IKITEM,?20,$E($$DESCR^PRCPUX1(PRCP("I"),IKITEM),1,28),?50,$E($$INVNAME^PRCPUX1(+$P(^PRCP(445.8,IKITEM,0),"^",2)),1,18),?70,$J($P(DATA,"^",2),10)
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I $G(PRCPFLAG) D Q Q
 D END^PRCPUREP
Q D ^%ZISC
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"SPECIFIC ITEM OR INSTRUMENT KIT LOCATOR REPORT ",?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !?5,"FOR: ",PRCP("IN")
 W !?4,"ITEM: ",$E(ITEMDESC,1,20),?32,"CURRENT QTY ON-HAND: ",QTY,"  ",UNITS
 W !,"CASE CART OR INSTRUMENT KIT",?50,"CREATED BY",?70,$J("QTY NEEDED",10),!,%
 Q
