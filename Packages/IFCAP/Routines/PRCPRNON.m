PRCPRNON ;WISC/RFJ-nonissuable item report                          ;20 Apr 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;  option to print non-issuable item report
 ;
 D ^PRCPUSEL Q:'$D(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN USE THIS OPTION." Q
 N %,PRCPALLI,X,Y
 D ITEMSEL^PRCPURS4 I '$O(^TMP($J,"PRCPURS4",0)),'$D(PRCPALLI) Q
 ;
 S %ZIS="Q" W ! D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK,^TMP($J,"PRCPURS4") Q
 .   S ZTDESC="Non-issuable Stock Report",ZTRTN="DQ^PRCPRNON"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,""PRCPURS4"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;queue comes here
 N %I,DATA,ITEMDA,NOW,NSN,PAGE,PRCPFLAG,SCREEN
 K ^TMP($J,"NONISS") S ITEMDA=0
 ;
 ;  if $g(prcpalli) then all items selected, loop inventory point.
 ;
 I $G(PRCPALLI) F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D BUILD
 ;
 ;  loop specific items selected.
 ;
 I '$G(PRCPALLI) F  S ITEMDA=$O(^TMP($J,"PRCPURS4",ITEMDA)) Q:'ITEMDA  D BUILD
 ;
 ;  start printing report
 ;
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S NSN="" F  S NSN=$O(^TMP($J,"NONISS",NSN)) Q:NSN=""  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"NONISS",NSN,ITEMDA)) Q:'ITEMDA  S DATA=^(ITEMDA) D
 .   W !!,$S(NSN=" ":"** NO NSN **",1:NSN),?19,$E($P(DATA,"^"),1,25),?47,"[#",ITEMDA,"]",?57,$J($P(DATA,"^",3),9),$J($P(DATA,"^",2),14),!?30,"QUANTITY IN NON-ISSUABLE: ",$J($P(DATA,"^",4),10)
 .   I $Y>(IOSL-6) D:$G(SCREEN) P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 I '$G(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"PRCPURS4"),^TMP($J,"NONISS") Q
 ;
 ;
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"NON-ISSUABLE STOCK REPORT FOR ",PRCP("IN"),?(80-$L(%)),%
 W !,"NSN",?19,"DESCRIPTION",?47,"[#MI]",?55,"QTY ON-HAND",?77,"U/I"
 S %="",$P(%,"-",81)="" W !,%
 Q
 ;
 ;
 ;
 ;
BUILD ;  set up tmp global for printing
 ;  tmp($j,"noniss",nsn,item number) = description ^ unit per
 ;      issue ^ quantity on-hand ^ quantity non-issuable.
 ;
 S DATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)) I '$P(DATA,"^",19) Q
 S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 S ^TMP($J,"NONISS",NSN,ITEMDA)=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA)_"^"_$$UNITVAL^PRCPUX1($P(DATA,"^",14),$P(DATA,"^",5)," per ")_"^"_$P(DATA,"^",7)_"^"_$P(DATA,"^",19)
 Q
