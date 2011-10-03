PRCPRCOS ;WISC/RFJ-unit costing report (whse)                       ;28 Jan 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"THIS OPTION CAN ONLY BE USED BY THE WAREHOUSE INVENTORY POINT." Q
 N WHSESRCE,X,Y
 S WHSESRCE=+$O(^PRC(440,"AC","S",0)) I 'WHSESRCE W !!,"THERE IS NOT A VENDOR IN THE VENDOR FILE (#440) DESIGNATED AS A SUPPLY WHSE." Q
 W !! F %=1:1 S X=$P($T(TEXT+%),";",3,99) Q:X=""  W !,X
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Inventory Unit Cost Report",ZTRTN="DQ^PRCPRCOS"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("WHSE*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;queue comes here
 N %,%I,DATA,ITEMDA,NOW,NSN,PAGE,PRCPFLAG,SCREEN,SKU,UNITCOST
 K ^TMP($J,"COST") D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  D
 .   S DATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   S UNITCOST="   NOT REQ" I $$MANDSRCE^PRCPU441(ITEMDA)=WHSESRCE S UNITCOST=$J($P($G(^PRC(441,ITEMDA,2,WHSESRCE,0)),"^",2),10,3)
 .   S SKU=$$SKU^PRCPUX1(PRCP("I"),ITEMDA)
 .   S ^TMP($J,"COST",NSN,ITEMDA)=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA)_"^"_$$UNITVAL^PRCPUX1($P(DATA,"^",14),$P(DATA,"^",5),"")_"^"_SKU_"^"_$J($P(DATA,"^",22),10,3)_"^"_$J($P(DATA,"^",15),10,3)_"^"_UNITCOST
 S NSN="" F  S NSN=$O(^TMP($J,"COST",NSN)) Q:NSN=""!($D(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"COST",NSN,ITEMDA)) Q:'ITEMDA!($D(PRCPFLAG))  S DATA=^(ITEMDA) D
 .   W !!,$TR(NSN,"-"),?14,$E($P(DATA,"^"),1,14),?29,$J(ITEMDA,6),$J($P(DATA,"^",2),8),?48,$P(DATA,"^",3),?50,$P(DATA,"^",4),$P(DATA,"^",5),$P(DATA,"^",6)
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 I $O(^TMP($J,"COST",""))="" W !!?20,">> NO ITEMS FOUND <<"
 E  I '$D(PRCPFLAG) W ! F %=1:1 S X=$P($T(TEXTEND+%),";",3,99) Q:X=""  W !?6,X I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I '$D(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"COST") Q
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"UNIT COSTING REPORT FOR: ",$E(PRCP("IN"),1,12),?(80-$L(%)),%
 S %="",$P(%,"-",81)="" W !,"NSN",?15,"DESCRIPTION",?33,"MI",?37,"UNIT/ISS",?47,"SKU",?53,"AVGCOST",?62,"LASTCOST",?72,"UNITCOST",!,%
 Q
 ;
TEXT ;;display info text
 ;;This option will print a report showing the unit costing for each item
 ;;stored in the warehouse inventory point.  You can use this report to
 ;;verify the current costing values stored.
 ;;
TEXTEND ;;display help at end of report
 ;;The average cost and last cost are defined in the inventory point
 ;;for each item.  The unit cost is defined in the item master file
 ;;for the warehouse vendor.  If the mandatory source in the item master
 ;;file is not the warehouse, the unit cost will print NOT REQ (for
 ;;not required).  Otherwise, the unit cost will be displayed.
