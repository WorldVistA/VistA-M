IBCOPR1 ;WISC/RFJ,BOISE/WRL-print dollar amts for pre-registration ; 05 May 97  8:34 AM
 ;;2.0; INTEGRATED BILLING ;**75,345**; 21-MAR-94;Build 28
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print report
 N %,%H,%I,DATA,DATEDIS1,DATEDIS2,DFN,IBCNFLAG,IBCNLINE,INSCO,NOW,PAGE,SCREEN,X,Y,SOI
 ;
 S Y=$P(DATESTRT,".") D DD^%DT S DATEDIS1=Y
 S Y=$P(DATEEND,".") D DD^%DT S DATEDIS2=Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,IBCNLINE="",$P(IBCNLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO
 S SOI=0
P1 S SOI=$O(COUNTNEW(SOI)) I SOI="" Q
 I SCREEN,PAGE>1 D PAUSE Q:$G(IBCNFLAG)
 D H
 ;
 ;  show list of new patients for source
 I IBCNFSUM=2 D H1 S DFN=0 F  S DFN=$O(^TMP($J,"IBCOPR","NEW",SOI,DFN)) Q:'DFN!($G(IBCNFLAG))  D
 .   S INSCO=0 F  S INSCO=$O(^TMP($J,"IBCOPR","NEW",SOI,DFN,INSCO)) Q:'INSCO!($G(IBCNFLAG))  D
 .   .   S DATA=^TMP($J,"IBCOPR","ALL",DFN,INSCO)
 .   .   W !,$E($P(DATA,"^"),1,25),?27,$P(DATA,"^",2),?34,$E($P($G(^DIC(36,INSCO,0)),"^"),1,30),?68,$P(DATA,"^",3)
 .   .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H,H1
 ;
 I $G(IBCNFLAG) Q
 I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H
 ;
 W !,"    TOTAL NEW POLICIES IDENTIFIED WITH ",$P(^IBE(355.12,SOI,0),"^",2),": ",COUNTNEW(SOI),!
 ;
 ;  *** INPATIENT ***
 ;  show list of new inpatient bills
 I $G(IBCNFSUM)=2 D BILL(1)
 I $G(IBCNFLAG) Q
 I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H
 ;
 W !,"    TOTAL INPATIENT BILLS COUNT: ",$G(TOTALCNT(SOI,1))+0,?44,"AMOUNT: ",$J($FN(+$G(TOTALAMT(SOI,1)),",",2),12),!
 I $G(IBCNFLAG) Q
 I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H
 ;
 ;  show list of inpatient transactions
 I $G(IBCNFSUM)=2 D TRAN(1)
 I $G(IBCNFLAG) Q
 I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H
 ;
 W !,"    TOTAL INPATIENT PAYMENT COUNT: ",$G(PAYMTCNT(SOI,1))+0,?44,"AMOUNT: ",$J($FN(+$G(PAYMTAMT(SOI,1)),",",2),12),!
 ;
 ;  *** OUTPATIENT ***
 ;  show list of new outpatient bills
 I $G(IBCNFSUM)=2 D BILL(3)
 I $G(IBCNFLAG) Q
 I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H
 ;
 W !,"    TOTAL OUTPATIENT BILLS COUNT: ",$G(TOTALCNT(SOI,3))+0,?44,"AMOUNT: ",$J($FN(+$G(TOTALAMT(SOI,3)),",",2),12),!
 I $G(IBCNFLAG) Q
 I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H
 ;
 ;  show list of outpatient transactions
 I $G(IBCNFSUM)=2 D TRAN(3)
 I $G(IBCNFLAG) Q
 I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H
 ;
 W !,"    TOTAL OUTPATIENT PAYMENT COUNT: ",$G(PAYMTCNT(SOI,3))+0,?44,"AMOUNT: ",$J($FN(+$G(PAYMTAMT(SOI,3)),",",2),12),!
 G P1
 ;
 ;
 ;
BILL(CLASS) ;  print bills where class=1 inpatient, class=3 outpatient
 N CANCEL,DA,DATE,DATA,DATA1,Y
 D H2
 S DATE=0 F  S DATE=$O(^TMP($J,"IBCOPR","BILL",SOI,CLASS,DATE)) Q:'DATE!($G(IBCNFLAG))  D
 .   S DA=0 F  S DA=$O(^TMP($J,"IBCOPR","BILL",SOI,CLASS,DATE,DA)) Q:'DA!($G(IBCNFLAG))  D
 .   .   ;  data1 = dfn ^ insco ^ cancel ^ bill number ^ amount
 .   .   S DATA1=$G(^TMP($J,"IBCOPR","BILL",SOI,CLASS,DATE,DA))
 .   .   S DATA=$G(^TMP($J,"IBCOPR","ALL",+$P(DATA1,"^"),$P(DATA1,"^",2)))
 .   .   S Y=DATE D DD^%DT
 .   .   W !,$E($P(DATA,"^"),1,25),?27,$P(DATA,"^",2),?33,$P(DATA1,"^",3),?34,$P(DATA1,"^",4),?54,$J($FN(+$P(DATA1,"^",5),",",2),10),?68,Y
 .   .   I $P(DATA1,"^",3)'="" S CANCEL=1
 .   .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H,H2
 I $G(IBCNFLAG) Q
 I $G(CANCEL) W !,"    * Next to bill indicates bill is canceled and not used in totals"
 Q
 ;
 ;
TRAN(CLASS) ;  print transaction where class=1 inpatient, class=3 outpatient
 N CANCEL,DA,DATE,DATA,DATA1,TYPE,Y
 D H3
 S DATE=0 F  S DATE=$O(^TMP($J,"IBCOPR","TRAN",SOI,CLASS,DATE)) Q:'DATE!($G(IBCNFLAG))  D
 .   S DA=0 F  S DA=$O(^TMP($J,"IBCOPR","TRAN",SOI,CLASS,DATE,DA)) Q:'DA!($G(IBCNFLAG))  D
 .   .   ;  data1 = dfn ^ insco ^ cancel ^ trans # ^ type ^ amount 
 .   .   S DATA1=$G(^TMP($J,"IBCOPR","TRAN",SOI,CLASS,DATE,DA))
 .   .   S DATA=$G(^TMP($J,"IBCOPR","ALL",+$P(DATA1,"^"),$P(DATA1,"^",2)))
 .   .   S Y=DATE D DD^%DT
 .   .   S TYPE=$P(DATA1,"^",5),TYPE=$S(TYPE=34:"FULL",1:"PART")
 .   .   W !,$E($P(DATA,"^"),1,25),?27,$P(DATA,"^",2),?33,$P(DATA1,"^",3),?34,$P(DATA1,"^",4),?46,TYPE,?54,$J($FN(+$P(DATA1,"^",6),",",2),10),?68,Y
 .   .   I $P(DATA1,"^",3)'="" S CANCEL=1
 .   .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(IBCNFLAG)  D H,H3
 I $G(IBCNFLAG) Q
 I $G(CANCEL) W !,"    * Next to payment indicates payment is canceled and not used in totals"
 Q
 ;
 ;
PAUSE ;  pause at end of page
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME
 S:'$T X="^" S:X["^" IBCNFLAG=1 U IO
 Q
 ;
 ;
H ;  header
 S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"SOURCE OF INFORMATION REPORT",?(80-$L(%)),%
 W !,"  FOR THE DATE RANGE: ",DATEDIS1,"  TO  ",DATEDIS2,?65,$J("TYPE: "_$S(IBCNFSUM=1:"SUMMARY",1:"DETAILED"),15)
 W !,"  SOURCE OF INFORMATION: ",$P(^IBE(355.12,SOI,0),"^",2)
 W !,IBCNLINE
 Q
 ;
 ;
H1 ;  header for patient list
 W !,"Patient Name",?27,"SSN",?34,"Insurance Company",?68,"Source Date"
 W !,$TR(IBCNLINE,"-",".")
 Q
 ;
 ;
H2 ;  header for bill list
 W !,$E($TR(IBCNLINE,"-","."),1,27)," ",$S(CLASS=1:" Inpatient",1:"Outpatient")," Bills Entered ",$E($TR(IBCNLINE,"-","."),1,27)
 W !,"Patient Name",?27,"SSN",?34,"Bill Number",?54,$J("Amount",10),?68,"Bill Date"
 W !,$TR(IBCNLINE,"-",".")
 Q
 ;
 ;
H3 ;  header for transaction list
 W !,$E($TR(IBCNLINE,"-","."),1,24)," ",$S(CLASS=1:" Inpatient",1:"Outpatient")," Payments Collected ",$E($TR(IBCNLINE,"-","."),1,25)
 W !,"Patient Name",?27,"SSN",?34,"Tran Number",?46,"Type",?54,$J("Amount",10),?68,"Bill Date"
 W !,$TR(IBCNLINE,"-",".")
 Q
