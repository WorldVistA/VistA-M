PRCPRAIR ;WISC/RFJ-abbreviated item report (option, whse)           ;09 Jun 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="W" D PRIMARY^PRCPRAIP Q
 ;
 ;  abbreviated item report for whse
 N PRCPEND,PRCPSTRT,X
 K X S X(1)="The Abbreviated Item Report will sort the Warehouse inventory items by the NSN." D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Select the range of NSNs to display" D DISPLAY^PRCPUX2(2,40,.X)
 D NSNSEL^PRCPURS0 I '$D(PRCPSTRT) Q
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Abbreviated Item Report",ZTRTN="DQ^PRCPRAIR"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%H,%I,ITEMDA,ITEMDATA,NOW,NSN,PAGE,PRCPFLAG,SCREEN,X,Y
 K ^TMP($J,"PRCPRAIR")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D
 .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   I NSN]PRCPSTRT,PRCPEND]NSN S ^TMP($J,"PRCPRAIR",NSN,ITEMDA)=""
 .   I $E(NSN,1,$L(PRCPSTRT))=PRCPSTRT!($E(NSN,1,$L(PRCPEND))=PRCPEND) S ^TMP($J,"PRCPRAIR",NSN,ITEMDA)=""
 ;  print report
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S NSN="" F  S NSN=$O(^TMP($J,"PRCPRAIR",NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRAIR",NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   W !,$TR(NSN,"-"),?15,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,23),?39,ITEMDA,?46,$J(+$P(ITEMDATA,"^",7),8),$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),10),$J($$STORAGE^PRCPESTO(PRCP("I"),ITEMDA),16)
 .   S %=0 F  S %=$O(^PRCP(445,PRCP("I"),1,ITEMDA,1,%)) Q:'%!($G(PRCPFLAG))  D
 .   .   I $X>60 W !
 .   .   S X=$E($$STORELOC^PRCPESTO(%),1,15),X="     "_X_$E("               ",$L(X)+1,15)
 .   .   W X
 .   .   I $X>60,$Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 I '$G(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"PRCPRAIR")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"ABBREVIATED ITEM REPORT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 W !,"NSN",?15,"DESCRIPTION",?39,"MI",$J("QTY OH",13),$J("UNIT/IS",10),$J("MAIN STORAGE",16),!?5,"ADD STORAGE",?26,"ADD STORAGE",?46,"ADD STORAGE",?66,"ADD STORAGE",!,%
 Q
