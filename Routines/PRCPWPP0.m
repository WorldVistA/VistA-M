PRCPWPP0 ;WISC/RFJ,DWA-primary receive issue book (options)             ;20 Jan 94
 ;;5.1;IFCAP;**4**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EEITEMS ;  called from protocol file to enter/edit invpt items
 D FULL^VALM1
 D EN^PRCPEILM
 D REBUILD^PRCPWPPB
 S VALMBCK="R"
 Q
 ;
 ;
REMAIN ;  set qty to receive to remaining (outstanding) qty
 D FULL^VALM1
 S VALMBCK="R"
 N DATA,ITEMDA,LINEDA,QTY,X
 K X S X(1)="This option will set the QUANTITY TO RECEIVE equal to the difference between the QUANTITY ORDERED and the QUANTITY PRIMARY REC'D."
 D DISPLAY^PRCPUX2(5,75,.X)
 S XP="Do you want to set the QUANTITY TO RECEIVE",XH="Enter YES to set the QUANTITY TO RECEIVE, NO or ^ to return to the list."
 I $$YN^PRCPUYN(1)'=1 Q
 S LINEDA=0 F  S LINEDA=$O(^TMP($J,"PRCPWPPLLIST",LINEDA)) Q:'LINEDA  S DATA=^(LINEDA) D
 .   S ITEMDA=+$P(DATA,"^"),QTY=+$P(DATA,"^",2)
 .   I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) S QTY=0
 .   S ^TMP($J,"PRCPWPPLPOST",LINEDA)=QTY
 D REBUILD^PRCPWPPB
 S VALMSG="QTY TO RECEIVE now set to remaining"
 Q
 ;
 ;
ENTER ;  enter quantity to post
 D FULL^VALM1
 S VALMBCK="R"
 N DATA,DIR,ITEMDA,INVDATA,LINEDA,ONHAND,QTYOUT,QTYPST,QTYREC,STATUS,QUIT,X,Y
 S QUIT=0
 F  W ! S LINEDA=$$LINEITEM Q:LINEDA<1  D
 .   S DATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,0)) I DATA="" W !,"CANNOT FIND LINE ITEM." Q
 .   S ITEMDA=+$P(DATA,"^",5),STATUS=$P(DATA,"^",14),INVDATA=$G(^PRCP(445,PRCPINPT,1,ITEMDA,0))
 .   I INVDATA="" W !,"ITEM (#",ITEMDA,") NOT STORED IN THE INVENTORY POINT." Q
 .   I STATUS'="" W !,"ITEM IS CANCELLED",$S(STATUS["S":" AND SUBSTITUTED WITH LINE #(S): "_$P(STATUS,",",2,99),1:"") Q
 .   S ONHAND=+$P(INVDATA,"^",7),QTYOUT=+$P($G(^TMP($J,"PRCPWPPLLIST",LINEDA)),"^",2),QTYPST=+$P($G(^TMP($J,"PRCPWPPLLIST",LINEDA)),"^",3)
 .   W !!,ITEMDA,?5,$E($$DESCR^PRCPUX1(PRCPINPT,ITEMDA),1,30),"  ",$$NSN^PRCPUX1(ITEMDA),"  U/I: ",$$UNIT^PRCPUX1(PRCPINPT,ITEMDA,"/")
 .   W !?5,"AVERAGE COST   : ",$J(+$P(INVDATA,"^",22),0,2)
 .   W !?5,"LAST COST      : ",$J(+$P(INVDATA,"^",15),0,2)
 .   W !
 .   W !?5,"QTY ON-HAND    : ",ONHAND
 .   W !?5,"QTY ORDERED    : ",+$P(DATA,"^",2)
 .   W !?5,"QTY POSTED     : ",+$P(DATA,"^",12)
 .   W !?5,"QTY RECEIVED   : ",+$P(DATA,"^",13)
 .   W !?5,"QTY OUTSTANDING: ",QTYOUT
 .   W !?5,"QTY TO RECEIVE : ",+$G(^TMP($J,"PRCPWPPLPOST",LINEDA))
 .   S DIR(0)="NA^0:"_QTYPST_":0",DIR("A")="  QUANTITY TO RECEIVE: ",DIR("B")=QTYPST
 .   S DIR("A",1)="Enter the quantity of this item to receive from 0 to "_QTYPST_"."
 .   W ! D ^DIR K DIR
 .   I Y!(Y=0) S ^TMP($J,"PRCPWPPLPOST",LINEDA)=+Y
 .   K X S X(1)="QUANTITY TO RECEIVE: "_+$G(^TMP($J,"PRCPWPPLPOST",LINEDA)),QTYREC=$TR($P(X(1),":",2)," ")
 .   I QTYREC>QTYOUT D
 .   .   W !!
 .   .   W !,?15,"*****************WARNING*********************"
 .   .   W !,?15,"** Quantity RECEIVED greater than ORDERED. **"
 .   .   W !,?15,"**      Is that what you want to do?       **"
 .   .   W !,?15,"*********************************************",!!
 .   .   S DIR(0)="E" D ^DIR
 .   .   I 'Y S QUIT=1 K QTYREC,X(1)
 .   .   Q
 .   D:'QUIT DISPLAY^PRCPUX2(3,32,.X)
 D:'QUIT REBUILD^PRCPWPPB
 Q
 ;
 ;
LINEITEM()         ;  select line item for issue book
 N DA,DIC,X,Y
 S DIC="^PRCS(410,"_PRCPDA_",""IT"",",DA(1)=PRCPDA,DIC(0)="QEAMZ",DIC("A")="Select LINE ITEM Number: "
 S DIC("W")="S PRCPNODE=13 D DICW^PRCPWPL0 K PRCPNODE"
 D ^DIC
 Q +Y
