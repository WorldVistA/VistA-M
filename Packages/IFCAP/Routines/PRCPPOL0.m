PRCPPOL0 ;WISC/RFJ-receive purchase order (list manager)            ;06 Jan 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DISTCOST ;  item not in inventory point, cost to distribution point
 ;  needs prcpordr,prcpinpt
 D FULL^VALM1
 S VALMBCK="R"
 N %,C,COSTCNTR,DATA,DISTRPT,I,ITEMDA,LINEDA,X,Y
 K X S X(1)="This option allows items which are not stored in the "_$$INVNAME^PRCPUX1(PRCPINPT)_" to be costed to a distribution point."
 D DISPLAY^PRCPUX2(5,75,.X)
 I '$O(^TMP($J,"PRCPPOLMCOS",0)) K X S X(1)="All items on the purchase order are currently stored in the inventory point." D DISPLAY^PRCPUX2(15,55,.X) D R^PRCPUREP Q
 S LINEDA=$$LINEITEM^PRCPPOU1(PRCPORDR) I 'LINEDA Q
 S DATA=$G(^TMP($J,"PRCPPOLMCOS",LINEDA)) Q:DATA=""
 S ITEMDA=$P(DATA,"^")
 K X S X(1)="This item is not stored in the inventory point.  You have the option to cost this out as a distribution cost to one of your distribution inventory points."
 W ! D DISPLAY^PRCPUX2(5,75,.X)
 W !,"Line Number: ",LINEDA,?20,"Master Item Number: ",ITEMDA,!?2,"DESCRIPTION: "
 K X S %=0 F I=1:1 S %=$O(^PRC(442,PRCPORDR,2,LINEDA,1,%)) Q:'%  S X(I)=^(%,0)
 D DISPLAY^PRCPUX2(13,75,.X)
 S %=$$INVNAME^PRCPUX1($P(DATA,"^",2))
 W !,"COST OUT TO INVPT: ",$S(%="":"<NONE>",1:%),?50,"COST CENTER: ",$S($P(DATA,"^",3)="":"<NONE>",1:$P(DATA,"^",3))
 ;  select distribution point
 F  S DISTRPT=$$TO^PRCPUDPT(PRCPINPT) Q:'DISTRPT  D  Q:DISTRPT
 .   S COSTCNTR=$P($G(^PRCP(445,DISTRPT,0)),"^",7) S:'COSTCNTR COSTCNTR=$P(^PRC(442,PRCPORDR,0),"^",5) I 'COSTCNTR W !?5,"INVENTORY POINT DOES NOT CONTAIN A COST CENTER." S DISTRPT=0 Q
 .   W !?5,"COSTING TO COST CENTER: ",COSTCNTR
 .   S ^TMP($J,"PRCPPOLMCOS",LINEDA)=ITEMDA_"^"_DISTRPT_"^"_COSTCNTR
 D REBUILD^PRCPPOLB
 S VALMBCK="R"
 Q
 ;
 ;
EEITEMS ;  called from protocol file to enter/edit invpt items
 D FULL^VALM1
 N PRC,PRCP
 S PRCP("DPTYPE")="WP"
 D ^PRCPEILM
 D REBUILD^PRCPPOLB
 S VALMBCK="R"
 Q
