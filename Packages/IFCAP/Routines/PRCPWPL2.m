PRCPWPL2 ;WISC/RFJ/DGL-whse post issue book (cancel);13 Jan 94 [1/13/99 11:16am]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CANCEL ;  cancel item
 D FULL^VALM1
 S VALMBCK="R"
 N DATA,LINEDA,STATUS,X,XP
 K X S X(1)="This option will allow you to CANCEL a line item on the issue book.  Once a line item is cancelled, the due-ins and due-outs will be decreased by the outstanding quantity."
 D DISPLAY^PRCPUX2(5,75,.X)
 F  W ! S LINEDA=$$LINEITEM^PRCPWPL0 Q:LINEDA<1  D
 .   S DATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,0)) I DATA="" W !,"CANNOT FIND LINE ITEM." Q
 .   S STATUS=$P(DATA,"^",14),XP=""
 .   I STATUS'="" W !,"ITEM IS ALREADY CANCELLED",$S(STATUS["S":" AND SUBSTITUTED WITH LINE #(S): "_$P(STATUS,",",2,99),1:"") Q
 .   I $P(DATA,"^",12)>$P(DATA,"^",13) S XP="Primary will NOT be able to receive this item. "
 .   S XP=XP_"ARE YOU SURE YOU WANT TO CANCEL THIS ITEM",XH="Enter YES to CANCEL this line item."
 .   W ! I $$YN^PRCPUYN(1)'=1 Q
 .   D CANCELIT
 D REBUILD^PRCPWPLB
 Q
 ;
 ;
CANCELIT ;  cancel the item without asking
 S ^TMP($J,"PRCPWPLMPOST",LINEDA)=0
 N %,DATA,ITEMDA,QTYOUT
 S DATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,0)) I DATA="" Q
 S ITEMDA=+$P(DATA,"^",5)
 S QTYOUT=$P(DATA,"^",2)-$P(DATA,"^",12) I QTYOUT<0 S QTYOUT=0
 I $P(DATA,"^",14)'["C" S $P(^PRCS(410,PRCPDA,"IT",LINEDA,0),"^",14)="C"_$P(DATA,"^",14)
 I $D(^PRCP(445,PRCPINPT,1,ITEMDA,0)) W !?5,"... decrementing due-outs@warehouse by ",QTYOUT D SETOUT^PRCPUDUE(PRCPINPT,ITEMDA,-QTYOUT)
 I $D(^PRCP(445,PRCPPRIM,1,ITEMDA,7,PRCPDA,0)) D
 .   W !?5,"... decrementing due-ins @primary   by ",QTYOUT
 .   I QTYOUT>0 D SETIN^PRCPUDUE(PRCPPRIM,ITEMDA,-QTYOUT)
 .   S DIK="^PRCP(445,"_PRCPPRIM_",1,"_ITEMDA_",7,"
 .   S DA=PRCPDA,DA(1)=ITEMDA,DA(2)=PRCPPRIM
 .   D ^DIK
 W !,"*** Line item HAS BEEN cancelled ***"
 Q
 ;
 ;
FINAL ;  make issue book a final
 D FULL^VALM1
 S VALMBCK="R"
 S PRCPFINL=$S($$FINALASK=1:1,1:0)
 D HDR^PRCPWPLM
 Q
 ;
 ;
FINALASK() ;  ask to make issue book a final
 N X
 K X S X(1)="You have the option to make this issue book a FINAL.  If you make the issue book a FINAL, all due-outs and due-ins will be cancelled and you will no longer be able to post the issue book."
 D DISPLAY^PRCPUX2(5,75,.X)
 S XP="Do you want to make this issue book a FINAL",XH="Enter YES to make this issue book a final."
 Q $$YN^PRCPUYN(2)
