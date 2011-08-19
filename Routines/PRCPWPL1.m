PRCPWPL1 ;WISC/RFJ-whse post issue book (substitute)                ;13 Jan 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SUBST ;  substitute item
 D FULL^VALM1
 S VALMBCK="R"
 N CONV,DATA,DIR,DR,INVDATA,ITEMDA,LINEDA,VENDDATA,NEWLINE,QTYORD,STATUS,SUBACCT,SUBITEM,UNITCOST,VENDOR,X
 K X S X(1)="This option will allow you to CANCEL and SUBSTITUTE a line item on the issue book.  Once a line item is cancelled, the oustanding quantity will be set to zero and the due-ins and due-outs will be cancelled."
 D DISPLAY^PRCPUX2(5,75,.X)
 F  W ! S LINEDA=$$LINEITEM^PRCPWPL0 Q:LINEDA<1  D
 .   S DATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,0)) I DATA="" W !,"CANNOT FIND LINE ITEM." Q
 .   S STATUS=$P(DATA,"^",14)
 .   I STATUS'="" W !,"ITEM IS CANCELLED",$S(STATUS["S":" AND SUBSTITUTED WITH LINE #(S): "_$P(STATUS,",",2,99),1:"")
 .   S ITEMDA=+$P(DATA,"^",5) I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) W !,"ITEM IS NOT STORED IN THE INVENTORY POINT." Q
 .   F  W ! S SUBITEM=$$SUBITEM Q:SUBITEM<1  D  Q:SUBITEM
 .   .   S INVDATA=$G(^PRCP(445,PRCPINPT,1,SUBITEM,0))
 .   .   I INVDATA="" W !,"SUBSTITUTE ITEM IS NOT STORED IN THE WAREHOUSE INVENTORY POINT." S SUBITEM=0 Q
 .   .   S VENDDATA=$G(^PRC(441,SUBITEM,2,+PRCPPVNO,0))
 .   .   I VENDDATA="" W !,"WAREHOUSE IS NOT ESTABLISHED AS A VENDOR FOR THIS ITEM." S SUBITEM=0 Q
 .   I SUBITEM<1 Q
 .   S UNITCOST=$P(INVDATA,"^",22) S:$P(INVDATA,"^",15)>UNITCOST UNITCOST=$P(INVDATA,"^",15) S:$P(VENDDATA,"^",2)>UNITCOST UNITCOST=$P(VENDDATA,"^",2) S UNITCOST=$J(UNITCOST,0,2)
 .   W !!,SUBITEM,?5,$E($$DESCR^PRCPUX1(PRCPINPT,SUBITEM),1,30),"  ",$$NSN^PRCPUX1(SUBITEM)
 .   W !?5,"UNIT/ISSUE     : ",$$UNIT^PRCPUX1(PRCPINPT,SUBITEM,"/")
 .   W !?5,"UNIT/PURCHASE  : ",$$UNITVAL^PRCPUX1($P(VENDDATA,"^",8),$P(VENDDATA,"^",7),"/")
 .   W !?5,"AVERAGE COST   : ",$J(+$P(INVDATA,"^",22),0,2)
 .   W !?5,"LAST COST      : ",$J(+$P(INVDATA,"^",15),0,2)
 .   W !?5,"CHARGE UNITCOST: ",UNITCOST
 .   W !
 .   W !?5,"QTY ON-HAND    : ",+$P(INVDATA,"^",7)
 .   S DIR(0)="NA^0:99999:0",DIR("A")="  QUANTITY ORDERED: "
 .   S DIR("A",1)="Enter the quantity ordered for this item."
 .   W ! D ^DIR K DIR S QTYORD=+Y
 .   S XP="ARE YOU SURE YOU WANT TO CANCEL AND SUBSTITUTE THIS ITEM",XH="Enter YES to CANCEL and SUBSTITUTE this line item."
 .   W ! I $$YN^PRCPUYN(1)'=1 Q
 .   I $E(STATUS)'="C" W !!,"cancelling original ordered item..." D CANCELIT^PRCPWPL2
 .   F NEWLINE=$P(^PRCS(410,PRCPDA,"IT",0),"^",3)+1:1 Q:'$D(^PRCS(410,PRCPDA,"IT",NEWLINE,0))
 .   W !!,"adding a NEW line item (#",NEWLINE,") as a substitute item..."
 .   S SUBACCT=$E($P($G(^PRCD(420.2,+$$SUBACCT^PRCPU441(SUBITEM),0)),"^"),1,30)
 .   S DR="2///"_QTYORD_";3///"_$P(VENDDATA,"^",7)_";4//"_SUBACCT_";5///"_SUBITEM_";7//"_$S('UNITCOST:"",1:"/"_UNITCOST)
 .   D NEWLINE(DR)
 .   ;
 .   ;  update cancelled item
 .   S STATUS=$P(^PRCS(410,PRCPDA,"IT",LINEDA,0),"^",14) I STATUS'["S" S STATUS=STATUS_"S"
 .   S $P(^PRCS(410,PRCPDA,"IT",LINEDA,0),"^",14)=STATUS_", "_NEWLINE
 .   I $D(^PRCP(445,PRCPINPT,1,SUBITEM,0)) W !?5,"... incrementing due-outs@warehouse by ",QTYORD D SETOUT^PRCPUDUE(PRCPINPT,SUBITEM,QTYORD)
 .   I $D(^PRCP(445,PRCPPRIM,1,SUBITEM,0)) D
 .   .   S VENDOR=$$GETVEN^PRCPUVEN(PRCPPRIM,SUBITEM,PRCPPVNO,1),CONV=$P(VENDOR,"^",4)
 .   .   W !?5,"... incrementing due-ins @primary   by ",QTYORD*CONV W:CONV>1 "  (convfact: ",CONV,")"
 .   .   D ADDUPD^PRCPUTRA(PRCPPRIM,SUBITEM,PRCPDA,QTYORD*CONV_"^"_$P(VENDOR,"^",2)_"^"_$P(VENDOR,"^",3)_"^"_CONV)
 D REBUILD^PRCPWPLB
 Q
 ;
 ;
SUBITEM() ;  select substitute item
 N DIC,DA,X,Y
 I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) Q 0
 I '$D(^PRCP(445,PRCPINPT,1,ITEMDA,4,0)) S ^(0)="^445.122PI^^"
 S DIC="^PRCP(445,"_PRCPINPT_",1,"_ITEMDA_",4,",DA(1)=PRCPINPT,DA=ITEMDA,DIC(0)="QEAM"
 S DIC("W")="N %,Z S %=$G(^PRC(441,+Y,0)),Z=$G(^PRCP(445,PRCPINPT,1,+Y,0)) W ?7,"" "",$P(%,U,5),?32,$E($P($G(^PRCP(445,PRCPINPT,1,+Y,6)),U),1,20),?55,""  QTY ON-HAND: "",$P(Z,U,7)"
 D ^DIC
 Q +Y
 ;
 ;
NEWLINE(DR) ;  set new line item in issue book
 N %,C,D0,DA,DD,DDH,DI,DIC,DIE,DLAYGO,DQ,I,PRCS,X,Y
 S DIC="^PRCS(410,"_PRCPDA_",""IT"",",DIC(0)="L",DLAYGO=410,DA(1)=PRCPDA,X=NEWLINE
 S DIE("NO^")=""
 I DR'="" S DIC("DR")=DR
 D FILE^DICN
 Q
