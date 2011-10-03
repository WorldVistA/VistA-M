PRCPRSO1 ;WISC/RFJ/VAC-days of stock on hand report (print)             ; 9/20/06 11:15am
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;*98 Modified to show Standard, ODI or Both
 Q
 ;
 ;
PRINT ;  print report
 N %,%H,%I,D,DESCR,GROUP,ITEMDA,NOW,NSN,PAGE,PRCPFLAG,SCREEN,TOTAL,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 I PRCP("DPTYPE")="W" D WHSE
 I PRCP("DPTYPE")'="W" D PRIMARY
 I '$G(PRCPFLAG),$Y>(IOSL-3) D:SCREEN P^PRCPUREP I '$G(PRCPFLAG) D H
 I $G(PRCPFLAG) Q
 W !!?38,"TOTAL SELLING VALUE IN STOCK: ",$J(TOTAL,12,2)
 D END^PRCPUREP
 Q
 ;
 ;
WHSE ;  print whse report
 S TOTAL=0,NSN="" F  S NSN=$O(^TMP($J,"PRCPRSOH",NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRSOH",NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S D=^(ITEMDA) D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   W !,$TR(NSN,"-"),?15,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,15),?31,ITEMDA,?37,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),8)
 .   S TOTAL=TOTAL+$P(D,"^",5)
 .   I $P(D,"^",5)>99999.99 S $P(D,"^",5)=">99999"
 .   I $P(D,"^",4)>9999 S $P(D,"^",4)=">9999"
 .   I $P(D,"^",3)>9999 S $P(D,"^",3)=">9999"
 .   I $P(D,"^",2)>99.99 S $P(D,"^",2)=">99.99"
 .   I $P(D,"^")>99999 S $P(D,"^")=">99999"
 .   W ?45,$J($P(D,"^"),7),$J($P(D,"^",2),7),$J($P(D,"^",3),6),$J($P(D,"^",4),6),$J($P(D,"^",5),9)
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 Q
 ;
 ;
PRIMARY ;  print primary or secondary report
 S TOTAL=0,GROUP="" F  S GROUP=$O(^TMP($J,"PRCPRSOH",GROUP)) Q:GROUP=""!($G(PRCPFLAG))  D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   W !!?5,"GROUP: ",$S(GROUP=" ":"<<NONE>>",1:GROUP)
 .   S DESCR="" F  S DESCR=$O(^TMP($J,"PRCPRSOH",GROUP,DESCR)) Q:DESCR=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRSOH",GROUP,DESCR,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S D=^(ITEMDA) D
 .   .   W !,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,30),?31,ITEMDA,?37,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),8)
 .   .   S TOTAL=TOTAL+$P(D,"^",5)
 .   .   I $P(D,"^",5)>99999.99 S $P(D,"^",5)=">99999"
 .   .   I $P(D,"^",4)>9999 S $P(D,"^",4)=">9999"
 .   .   I $P(D,"^",3)>9999 S $P(D,"^",3)=">9999"
 .   .   I $P(D,"^",2)>99.99 S $P(D,"^",2)=">99.99"
 .   .   I $P(D,"^")>99999 S $P(D,"^")=">99999"
 .   .   W ?45,$J($P(D,"^"),7),$J($P(D,"^",2),7),$J($P(D,"^",3),6),$J($P(D,"^",4),6),$J($P(D,"^",5),9)
 .   .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"DAYS OF STOCK ON HAND REPORT: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !?5,"USAGE DATE RANGE FROM ",DATESTRD,"  TO  ",DATEENDD,"  (",TOTALDAY," DAYS)"
 W !?5,"ITEMS WITH STOCK ON HAND ",$S(PRCPTYPE=1:"LESS",1:"GREATER")," THAN ",PRCPDAYS," DAYS"
 I PRCP("DPTYPE")'="W" D
 . I ODIFLG=1 W !?5,"REPORT SHOWS STANDARD ITEMS ONLY"
 . I ODIFLG=2 W !?5,"REPORT SHOWS ON-DEMAND ITEMS ONLY"
 . I ODIFLG=3 W !?5,"REPORT SHOWS BOTH STANDARD AND ON-DEMAND ITEMS"
 W !?45,$J("TOTAL",7),$J("DAYS",7),$J("QTY",6),$J("DAYS",6),$J("SELL",9)
 I PRCP("DPTYPE")="W" W !,"NSN",?15,"DESCRIPTION"
 E  W !,"DESCRIPTION"
 W ?31,"IM",$J("UNIT/IS",12),?45,$J("USAGE",7),$J("AVG",7),$J("ONHND",6),$J("LEFT",6),$J("VALUE",9),!,%
 Q
