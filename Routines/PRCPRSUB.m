PRCPRSUB ;WISC/RFJ-substitute listing for whse                      ;08 Jun 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="W" W !,"THIS REPORT CAN ONLY BE USED BY THE WAREHOUSE." Q
 N PRCPEND,PRCPSTRT,X
 K X S X(1)="The Substitute Listing Report will display inventory items which have at least one substitute item stored.  The report will sort Warehouse inventory items by the NSN." D DISPLAY^PRCPUX2(40,79,.X)
 K X S X(1)="Select the range of NSNs to display." D DISPLAY^PRCPUX2(2,40,.X)
 D NSNSEL^PRCPURS0 I '$D(PRCPSTRT) Q
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Substitute Listing",ZTRTN="DQ^PRCPRSUB"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%H,%I,ITEMDA,ITEMDATA,NOW,NSN,PAGE,PRCPFLAG,SCREEN,SUBST,Y
 K ^TMP($J,"PRCPRSUB")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  I +$O(^(ITEMDA,4,0)) D
 .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   I $E(NSN,1,$L(PRCPSTRT))'=PRCPSTRT,$E(NSN,1,$L(PRCPEND))'=PRCPEND I NSN']PRCPSTRT!(PRCPEND']NSN) Q
 .   S %=0 F  S %=$O(^PRCP(445,PRCP("I"),1,ITEMDA,4,%)) Q:'%  S ^TMP($J,"PRCPRSUB",NSN,ITEMDA,%)=""
 ;  print report
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S NSN="" F  S NSN=$O(^TMP($J,"PRCPRSUB",NSN)) Q:'NSN!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRSUB",NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   W !!,$TR(NSN,"-"),?19,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,30),?52,$J(ITEMDA,6),$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),10),$J(+$P(ITEMDATA,"^",7),12)
 .   S SUBST=0 F  S SUBST=$O(^TMP($J,"PRCPRSUB",NSN,ITEMDA,SUBST)) Q:'SUBST!($G(PRCPFLAG))  D
 .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,SUBST,0))
 .   .   W !?4,$TR(NSN,"-"),?19,$E($$DESCR^PRCPUX1(PRCP("I"),SUBST),1,30),?52,$J(SUBST,6),$J($$UNIT^PRCPUX1(PRCP("I"),SUBST,"/"),10),$J(+$P(ITEMDATA,"^",7),12)
 I '$G(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"PRCPRSUB")
 Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"SUBSTITUTE ITEM LISTING FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)="" W !,"NSN",?19,"DESCRIPTION",?56,"MI",$J("UNIT/IS",10),$J("ONHAND QTY",12),!?4,"SUBSTITUTE ITEM(S)",!,%
 Q
