PRCPWPL0 ;WISC/RFJ-whse post issue book (options)                   ;13 Jan 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EEITEMS ;  called from protocol file to enter/edit invpt items
 D FULL^VALM1
 N PRC,PRCP
 S PRCP("DPTYPE")="WP"
 D ^PRCPEILM
 D REBUILD^PRCPWPLB
 S VALMBCK="R"
 Q
 ;
 ;
SHOWNSN ;  show nsn on list
 S PRCPFNSN=$S($G(PRCPFNSN):0,1:1)
 D REBUILD^PRCPWPLB
 S ^DISV(DUZ,"PRCPWPLM","SHOWNSN")=PRCPFNSN
 S VALMSG=$S(PRCPFNSN:"SHOW NSN",1:"DO NOT SHOW NSN")
 S VALMBCK="R"
 Q
 ;
 ;
REMAIN ;  set qty to post to remaining (outstanding) qty
 D FULL^VALM1
 S VALMBCK="R"
 N DATA,ITEMDA,LINEDA,QTY,X
 K X S X(1)="This option will set the QUANTITY TO POST equal to the QUANTITY REMAINing (same as quantity outstanding).  The QUANTITY REMAINing is equal to the QUANTITY ORDERED minus the QUANTITY POSTED previously."
 D DISPLAY^PRCPUX2(5,75,.X)
 S XP="Do you want to set the QUANTITY TO POST equal to QUANTITY REMAINing",XH="Enter YES to set the QUANTITY TO POST equal to the QUANTITY REMAINing,",XH(1)="      NO or ^ to return to the posting list."
 I $$YN^PRCPUYN(1)'=1 Q
 S LINEDA=0 F  S LINEDA=$O(^TMP($J,"PRCPWPLMLIST",LINEDA)) Q:'LINEDA  S DATA=^(LINEDA) D
 .   S ITEMDA=+$P(DATA,"^"),QTY=+$P(DATA,"^",2)
 .   I QTY<0 S QTY=0
 .   I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) S QTY=0
 .   S ^TMP($J,"PRCPWPLMPOST",LINEDA)=QTY
 D REBUILD^PRCPWPLB
 S VALMSG="QTY TO POST now set to QTY REMAINing"
 Q
 ;
 ;
ONHAND ;  set qty to post to onhand qty
 D FULL^VALM1
 S VALMBCK="R"
 N DATA,ITEMDA,LINEDA,ONHAND,QTY,X
 K X S X(1)="This option will set the QUANTITY TO POST equal to the QUANTITY ON-HAND in the warehouse inventory point.  A note of caution: Since the warehouse inventory point is not locked, the quantity on-hand could be changing"
 S X(2)="and will be a snapshot of the database.  By the time you actually post this issue book, the quantity on-hand may be different and you may even post into the negative."
 D DISPLAY^PRCPUX2(5,75,.X)
 S XP="Do you want to set the QUANTITY TO POST equal to QUANTITY ONHAND",XH="Enter YES to set the QUANTITY TO POST equal to the QUANTITY ONHAND,",XH(1)="      NO or ^ to return to the posting list."
 I $$YN^PRCPUYN(1)'=1 Q
 S LINEDA=0 F  S LINEDA=$O(^TMP($J,"PRCPWPLMLIST",LINEDA)) Q:'LINEDA  S DATA=^(LINEDA) D
 .   S ITEMDA=+$P(DATA,"^"),QTY=+$P(DATA,"^",2)
 .   S ONHAND=$P($G(^PRCP(445,PRCPINPT,1,ITEMDA,0)),"^",7) I QTY>ONHAND S QTY=ONHAND
 .   S ^TMP($J,"PRCPWPLMPOST",LINEDA)=QTY
 D REBUILD^PRCPWPLB
 S VALMSG="QTY TO POST now set to QTY ONHAND"
 Q
 ;
 ;
ENTER ;  enter quantity to post
 D FULL^VALM1
 S VALMBCK="R"
 N DATA,DIR,ITEMDA,INVDATA,LINEDA,ONHAND,QTYOUT,STATUS,X,Y
 F  W ! S LINEDA=$$LINEITEM Q:LINEDA<1  D
 .   S DATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,0)) I DATA="" W !,"CANNOT FIND LINE ITEM." Q
 .   S ITEMDA=+$P(DATA,"^",5),STATUS=$P(DATA,"^",14),INVDATA=$G(^PRCP(445,PRCPINPT,1,ITEMDA,0))
 .   I INVDATA="" W !,"ITEM (#",ITEMDA,") NOT STORED IN THE INVENTORY POINT." Q
 .   I STATUS'="" W !,"ITEM IS CANCELLED",$S(STATUS["S":" AND SUBSTITUTED WITH LINE #(S): "_$P(STATUS,",",2,99),1:"") Q
 .   S ONHAND=+$P(INVDATA,"^",7),QTYOUT=+$P($G(^TMP($J,"PRCPWPLMLIST",LINEDA)),"^",2) I QTYOUT<0 S QTYOUT=0
 .   W !!,ITEMDA,?5,$E($$DESCR^PRCPUX1(PRCPINPT,ITEMDA),1,30),"  ",$$NSN^PRCPUX1(ITEMDA),"  U/I: ",$$UNIT^PRCPUX1(PRCPINPT,ITEMDA,"/")
 .   W !?5,"AVERAGE COST   : ",$J(+$P(INVDATA,"^",22),0,2)
 .   W !?5,"LAST COST      : ",$J(+$P(INVDATA,"^",15),0,2)
 .   W !
 .   W !?5,"QTY ON-HAND    : ",ONHAND
 .   W !?5,"QTY ORDERED    : ",+$P(DATA,"^",2)
 .   W !?5,"QTY POSTED     : ",+$P(DATA,"^",12)
 .   W !?5,"QTY OUTSTANDING: ",QTYOUT
 .   W !?5,"QTY TO POST    : ",+$G(^TMP($J,"PRCPWPLMPOST",LINEDA))
 .   S DIR(0)="NA^0:"_ONHAND_":0",DIR("A")="  QUANTITY TO POST: ",DIR("B")=$S(QTYOUT<ONHAND:QTYOUT,1:ONHAND)
 .   S DIR("A",1)="Enter the quantity of this item to post from 0 to "_ONHAND_"."
 .   W ! D ^DIR K DIR
 .   I Y S ^TMP($J,"PRCPWPLMPOST",LINEDA)=+Y I Y>ONHAND K X S X(1)="WARNING: YOU WILL BE POSTING INTO THE NEGATIVE" D DISPLAY^PRCPUX2(5,75,.X)
 .   K X S X(1)="QUANTITY TO POST: "_+$G(^TMP($J,"PRCPWPLMPOST",LINEDA)) D DISPLAY^PRCPUX2(3,32,.X)
 D REBUILD^PRCPWPLB
 Q
 ;
 ;
LINEITEM()         ;  select line item for issue book
 N DA,DIC,X,Y
 S DIC="^PRCS(410,"_PRCPDA_",""IT"",",DA(1)=PRCPDA,DIC(0)="QEAMZ",DIC("A")="Select LINE ITEM Number: "
 S DIC("W")="S PRCPNODE=12 D DICW^PRCPWPL0 K PRCPNODE"
 D ^DIC
 Q +Y
 ;
 ;
DICW ;  write identifier for item
 N %,A,B
 ;  reference global ^prcs(410,da,0) from fileman
 S %=^(0),B=$G(^PRC(441,+$P(%,"^",5),0))
 W ?7," ",$P(B,"^",5)," (#",+$P(%,"^",5),")",?35," QTY.ORD: ",+$P(%,"^",2),?50," QTY.DIS: ",+$P(%,"^",PRCPNODE),?65
 I $P(%,"^",14)="" S A=$P(%,"^",2)-$P(%,"^",PRCPNODE) S:A<0 A=0 W " QTY.OUT: ",A
 E  S %=$P(%,"^",14) S A=$S(%["C":" CANCEL",1:"")_$S(%["S":" SUBST",1:"") W A
 I $D(DZ),DZ["??" W !?7," ",$P(B,"^",2)
 Q
