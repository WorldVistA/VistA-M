PRCPAWA0 ;WISC/RFJ-adjust whse inventory point                      ;11 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$D(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN USE THIS OPTION." Q
 I $$CHECK^PRCPCUT1(PRCP("I")) Q
 N %,%H,%I,D,DI,DISYS,DQ,TYPE,X,Y
 S X="" W ! D ESIG^PRCUESIG(DUZ,.X) I X'>0 Q
 S DIR(0)="SO^1:Issue Book Adjustment;2:Non-Issuable or Issuable Adjustment;3:Other (GIP and FMS) Adjustment;"_$S($$KEY^PRCPUREP("PRCPW MGRKEY",DUZ):"4:Supply Only (GIP) Adjustment;",1:""),DIR("A")="Select TYPE of ADJUSTMENT"
 W ! D ^DIR K DIR I Y'=1,Y'=2,Y'=3,Y'=4 Q
 S TYPE=Y,IOP="HOME" D ^%ZIS K IOP
 I TYPE=1 D ISUEBOOK^PRCPAWI0 Q
 I TYPE=2 D NONISSUE^PRCPAWN0 Q
 I TYPE=3 D OTHER^PRCPAWO0
 I TYPE=4 D SUPPLY^PRCPAWS0
 Q
 ;
 ;
SHOWDATA(INVPT,ITEMDA) ;  show inventory item data
 S ITEMDATA=$G(^PRCP(445,INVPT,1,ITEMDA,0)) I ITEMDATA="" W !,"ITEM IS NOT STORED IN THE INVENTORY POINT." Q
 W !!,"=====================  C U R R E N T   I T E M   D A T A  ====================="
 W !,"ITEM NUMBER: ",ITEMDA,?23,$E($$DESCR^PRCPUX1(INVPT,ITEMDA),1,30),?58,"NSN: ",$$NSN^PRCPUX1(ITEMDA)
 W !?5,"UNIT/ISSUE      : ",$$UNIT^PRCPUX1(INVPT,ITEMDA,"/")
 W !?5,"AVERAGE COST    : ",$J(+$P(ITEMDATA,"^",22),0,2)
 W !?5,"LAST COST       : ",$J(+$P(ITEMDATA,"^",15),0,2)
 W !
 W !?5,"TOTAL VALUE     : ",$J(+$P(ITEMDATA,"^",27),0,2)
 W !?5,"QTY ON-HAND     : ",$P(ITEMDATA,"^",7)
 W !?5,"QTY NON-ISSUABLE: ",$P(ITEMDATA,"^",19)
 Q
