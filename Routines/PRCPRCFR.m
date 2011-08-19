PRCPRCFR ;WISC/RFJ-conversion factor report (option, whse)          ;09 Jun 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="W" D PRIMARY^PRCPRCFP Q
 ;
 ;  conversion factor report for whse
 N PRCPEND,PRCPSTRT,X
 K X S X(1)="The Conversion Factor Report will display the inventory point items with procurement sources and conversion factors.  This report will sort the Warehouse inventory items by the NSN and the procurement source."
 D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Select the range of NSNs to display" D DISPLAY^PRCPUX2(2,40,.X)
 D NSNSEL^PRCPURS0 I '$D(PRCPSTRT) Q
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Conversion Factor Report",ZTRTN="DQ^PRCPRCFR"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%H,%I,ITEMDA,ITEMDATA,NOW,NSN,PAGE,PRCPFLAG,SCREEN,VENDATA,VENNM,X,Y
 K ^TMP($J,"PRCPRCFR")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D
 .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   I $E(NSN,1,$L(PRCPSTRT))'=PRCPSTRT,$E(NSN,1,$L(PRCPEND))'=PRCPEND I NSN']PRCPSTRT!(PRCPEND']NSN) Q
 .   S X=0 F  S X=$O(^PRCP(445,PRCP("I"),1,ITEMDA,5,X)) Q:'X  S VENDATA=$G(^(X,0)) I VENDATA'="" D
 .   .   S VENNM=$$VENNAME^PRCPUX1($P(VENDATA,"^")) S:VENNM="" VENNM=" "
 .   .   S ^TMP($J,"PRCPRCFR",NSN,ITEMDA,$E(VENNM,1,18))=VENDATA
 ;  print report
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S NSN="" F  S NSN=$O(^TMP($J,"PRCPRCFR",NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRCFR",NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   W !,$TR(NSN,"-"),?15,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,30),?46,ITEMDA,?53,$J(+$P(ITEMDATA,"^",7),8),$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),10)
 .   S VENNM="" F  S VENNM=$O(^TMP($J,"PRCPRCFR",NSN,ITEMDA,VENNM)) Q:VENNM=""!($G(PRCPFLAG))  S VENDATA=^(VENNM) D
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   S %=$S($P(VENDATA,"^")["PRCP(445":"I#",1:"V#")_+VENDATA
 .   .   W !?33,VENNM,?53,%,?61,$J($$UNITVAL^PRCPUX1($P(VENDATA,"^",3),$P(VENDATA,"^",2),"/"),10),$J($P(VENDATA,"^",4),9)
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 I '$G(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"PRCPRCFR")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"CONVERSION FACTOR REPORT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !,"NSN",?15,"DESCRIPTION",?46,"MI",$J("QTY OH",13),$J("UNIT/IS",10)
 W !?33,"PROCUREMENT SOURCE",?54,"IV#",?61,$J("UNIT/RE",10),$J("CF",9),!,%
 Q
