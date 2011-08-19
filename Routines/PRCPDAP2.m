PRCPDAP2 ;WISC/RFJ-drug accountability/prime vendor (check items)   ;15 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print items on invoice
 ;  prcpferr=1 for errors, do not create repetitive item lists
 N X
 K X S X(1)="Enter the device which will be used to print the items on the invoice, any errors with the items, and the repetitive item list number if created." D DISPLAY^PRCPUX2(5,60,.X)
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Prime Vendor Invoice Upload Report",ZTRTN="DQ^PRCPDAP2"
 .   S ZTSAVE("PRC*")="",ZTSAVE("^TMP($J,")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%H,%I,DA,DATA,INVDATA,ITEMDA,LINEITEM,NOW,PAGE,PRCPFLAG,QTY,SCREEN,STCTRL,TOTAL,TOTCOST,UNITCOST,VENDA,VENDATA,WHODATA,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO
 S STCTRL="" F  S STCTRL=$O(^TMP($J,"PRCPDAPV SET",STCTRL)) Q:STCTRL=""!($G(PRCPFLAG))  D
 .   D H^PRCPDAP3
 .   I $G(^TMP($J,"PRCPDAPV SET",STCTRL,"E")) K X S X(1)="THERE ARE ERRORS WITH THIS INVOICE WHICH NEED CORRECTING BEFORE THE REPETITVE ITEM LIST CAN BE CREATED." D DISPLAY^PRCPUX2(1,80,.X)
 .   S INVDATA=$G(^TMP($J,"PRCPDAPV SET",STCTRL,"IN"))
 .   W !!,"INVOICE       : ",$P(INVDATA,"^",2),?40,"DATE: ",$$DATE($P(INVDATA,"^"))
 .   W !,"PURCHASE ORDER: ",$P(INVDATA,"^",4),?40,"DATE: ",$$DATE($P(INVDATA,"^",3))
 .   W !?5,"PRIME VENDOR: ",$P($G(^PRC(440,PRCPVEND,0)),"^")
 .   W !?5,"TERMS DISCOUNT PERCENT: ",$P(INVDATA,"^",6),?40,"DUE DATE: ",$$DATE($P(INVDATA,"^",7)),?60,"DAYS DUE: ",$P(INVDATA,"^",8)
 .   W !?5,"TERMS DISCOUNT AMOUNT : ",$J($P(INVDATA,"^",11),0,2),?40,"DUE DATE: ",$$DATE($P(INVDATA,"^",9)),?60,"NET DAYS: ",$P(INVDATA,"^",10),!
 .   W !?5,"DELIVERY DATE REQUESTED: ",$$DATE($P(INVDATA,"^",12))
 .   W !?5,"DELIVERED ON DATE      : ",$$DATE($P(INVDATA,"^",13))
 .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H^PRCPDAP3
 .   W !!?5,"BUYER INFORMATION: "
 .   S WHODATA=$G(^TMP($J,"PRCPDAPV SET",STCTRL,"BY")) I WHODATA="" W "(SAME AS SHIPPING INFORMATION)"
 .   E  D WHO(WHODATA)
 .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H^PRCPDAP3
 .   W !!?5,"SHIPPING INFORMATION: "
 .   S WHODATA=$G(^TMP($J,"PRCPDAPV SET",STCTRL,"ST")) I WHODATA="" W "(SAME AS BUYER INFORMATION)"
 .   E  D WHO(WHODATA)
 .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H^PRCPDAP3
 .   W !!?5,"DISTRIBUTER INFORMATION: "
 .   S WHODATA=$G(^TMP($J,"PRCPDAPV SET",STCTRL,"DS")) D WHO(WHODATA)
 .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H^PRCPDAP3
 .   D LINEITEM^PRCPDAP3
 Q
 ;
 ;
DATE(DATE)         ;  convert date
 S %=$E(DATE,3,4)_"/"_$E(DATE,5,6)_"/"_$E(DATE,1,2)
 I $TR(%,"/")="" S %=""
 Q %
 ;
 ;
WHO(WHODATA)       ;  show buyer, shipping, seller address information
 W !?8,"NAME: ",$P(WHODATA,"^"),?62,"ID: ",$P(WHODATA,"^",2)
 W !?8,"ADDR: ",$P(WHODATA,"^",3)
 W !?8,"CITY: ",$P(WHODATA,"^",4),?40,"STATE: ",$P(WHODATA,"^",5),?62,"ZIPCODE: ",$P(WHODATA,"^",6)
 Q
