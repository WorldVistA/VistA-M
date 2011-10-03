PRCPAWI0 ;WISC/RFJ-adjust inventory level - issue adjustment        ;11 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
 ;  called from prcpawa0 for type 1 issue book adjustment
ISUEBOOK ;  issue book adjustment
 N PRCPDA,PRCPPVNO
 S PRCPPVNO=+$O(^PRC(440,"AC","S",0))_";PRC(440," I '$D(^PRC(440,+PRCPPVNO,0)) W !!,"THERE IS NOT A VENDOR IN THE VENDOR FILE (#440) DESIGNATED AS A SUPPLY WHSE." Q
 F  S PRCPDA=$$SELECTIB^PRCPWPLM(0) Q:PRCPDA'>0  D
 .   L +^PRCS(410,PRCPDA):5 I '$T D SHOWWHO^PRCPULOC(410,PRCPDA,0) Q
 .   D ADD^PRCPULOC(410,PRCPDA,0,"Adjust Issue Book")
 .   N %,DISTRPT,OTHERPT,TRANNO,VOUCHER
 .   S TRANNO=$P($G(^PRCS(410,PRCPDA,0)),"^")
 .   I TRANNO="" W !,"CANNOT FIND THE TRANSACTION NUMBER FOR THIS ISSUE BOOK." D UNLOCK Q
 .   S %=$G(^PRCS(410,PRCPDA,445))
 .   I '$P(%,"^",2) W !,"THIS ISSUE BOOK HAS NOT BEEN POSTED (NO FMS LINE NUMBER) AND CANNOT BE ADJUSTED." D UNLOCK Q
 .   S VOUCHER=$P(%,"^")
 .   I VOUCHER="" W !,"THIS ISSUE BOOK DOES NOT HAVE A REFERENCE VOUCHER NUMBER AND CANNOT BE ADJUSTED." D UNLOCK Q
 .   W !!,">> Reference Voucher Number: ",VOUCHER
 .   S (DISTRPT,OTHERPT)=+$P(^PRCS(410,PRCPDA,0),"^",6)
 .   I DISTRPT D
 .   .   W !!,">> Distribution to: ",$$INVNAME^PRCPUX1(DISTRPT)," inventory point."
 .   .   S %=$G(^PRCP(445,DISTRPT,0))
 .   .   I $P(%,"^",2)'="Y" W !,"NOTE: Primary is NOT keeping a PERPETUAL INVENTORY." S DISTRPT=0
 .   .   I $P(%,"^",6)'="Y" W !,"NOTE: Primary is NOT keeping a DETAILED TRANSACTION REGISTER." S DISTRPT=0
 .   .   I $P(%,"^",16)="N" W !,"NOTE: Primary set up so it will NOT be updated by the warehouse." S DISTRPT=0
 .   .   I 'DISTRPT W !,">> PRIMARY inventory point will NOT be updated."
 .   ;  get line adjustments
 .   D LINEADJ
 .   I '$O(^TMP($J,"PRCPAWI0","PROCESS",0)) W !!?10,">> NO LINE ITEMS HAVE BEEN SELECTED <<" D UNLOCK Q
 .   ;  get whse and buyer fcp data
 .   N PRCPPBFY,PRCPPFCP,PRCPPSTA,PRCPWBFY,PRCPWFCP,PRCPWSTA
 .   D IVDATA^PRCPSFIU(PRCPDA,PRCP("I"))
 .   S XP="READY TO PROCESS ISSUE BOOK ADJUSTMENTS",XH="Enter YES to PROCESS the ISSUE BOOK adjustments, NO to exit."
 .   W !! I $$YN^PRCPUYN(1)'=1 D UNLOCK Q
 .   D ISUECONT^PRCPAWI1
 .   D UNLOCK
 ;
Q K ^TMP($J,"PRCPAWI0")
 Q
 ;
 ;
UNLOCK ;  unlock issue book lock
 D CLEAR^PRCPULOC(410,PRCPDA,0)
 L -^PRCS(410,PRCPDA)
 Q
 ;
 ;
LINEITEM()         ;  select line item
 N DA,DIC,X,Y
 S DIC="^PRCS(410,"_PRCPDA_",""IT"",",DA(1)=PRCPDA,DIC(0)="QEAMZ",DIC("A")="Select LINE ITEM Number: "
 S DIC("W")="S %=$G(^PRCS(410,PRCPDA,""IT"",Y,445)) W ?7,""IM#: "",$P(^PRCS(410,PRCPDA,""IT"",Y,0),U,5),?20,"" QTY POSTED: ""_+$P(%,U,3),?40,"" INV VALUE: "",$J(+$P(%,U,4),0,2),?60,"" SELL VALUE: "",$J(+$P(%,U,5),0,2)"
 D ^DIC
 Q +Y
 ;
 ;
LINEADJ ;  enter line adjustment
 N INVVALUE,ITEMDA,ITEMDATA,LINEDA,LINEDATA,POSTDATA,QTY,REASON,SELVALUE
 K ^TMP($J,"PRCPAWI0")
 F  W ! S LINEDA=$$LINEITEM Q:LINEDA'>0  D
 .   S LINEDATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,0)),ITEMDA=+$P(LINEDATA,"^",5) I 'ITEMDA W !,"MISSING ITEM MASTER NUMBER." Q
 .   D SHOWDATA^PRCPAWA0(PRCP("I"),ITEMDA)
 .   W !!,"=======================  I S S U E   B O O K   D A T A  ======================="
 .   S POSTDATA=$G(^PRCS(410,PRCPDA,"IT",LINEDA,445))
 .   W !?5,"QUANTITY ORDERED: ",+$P(LINEDATA,"^",2)
 .   W !?5,"QUANTITY POSTED : ",+$P(POSTDATA,"^",3)
 .   W !?5,"INVENTORY VALUE : ",$J(+$P(POSTDATA,"^",4),0,2)
 .   W !?5,"SELLING VALUE   : ",$J(+$P(POSTDATA,"^",5),0,2),!
 .   I $P(POSTDATA,"^")=""!('$P(POSTDATA,"^",3)&('$P(POSTDATA,"^",4))&('$P(POSTDATA,"^",5))) W !,"THIS LINE ITEM HAS NOT BEEN POSTED AND CANNOT BE ADJUSTED." Q
 .   ;  enter adjustment
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)) I ITEMDATA="" W !,"THIS ITEM IS NOT STORED IN THE INVENTORY POINT." Q
 .   ;  line item already selected
 .   I $D(^TMP($J,"PRCPAWI0","PROCESS",LINEDA)) S XP="  THIS ITEM WAS PREVIOUSLY SELECTED DURING THIS SELECTION PROCESS.",XP(1)="  OK TO REMOVE THIS ADJUSTMENT SO YOU CAN ENTER A NEW ONE" W !! I $$YN^PRCPUYN(1)'=1 Q
 .   K ^TMP($J,"PRCPAWI0","PROCESS",LINEDA)
 .   W !!,"****************  E N T E R    A D J U S T M E N T    D A T A  ****************",!
 .   S QTY=$$QTY^PRCPAWU0(-$P(POSTDATA,"^",3),0) I QTY["^" Q
 .   S INVVALUE=$$VALUE^PRCPAWU0(-$P(POSTDATA,"^",4),99999.99," ISSUE BOOK INVENTORY","") I INVVALUE["^" Q
 .   S SELVALUE=$$VALUE^PRCPAWU0(-$P(POSTDATA,"^",5),99999.99," ISSUE BOOK SELLING","") I SELVALUE["^" Q
 .   I 'QTY,'INVVALUE,'SELVALUE W !!?10,">> EITHER QUANTITY OR VALUE NEEDS TO BE ENTERED FOR AN ADJUSTMENT <<" Q
 .   W ! S REASON=$$REASON^PRCPAWU0("ISSUE BOOK adjustment") I REASON["^" Q
 .   S ^TMP($J,"PRCPAWI0","PROCESS",LINEDA)=QTY_"^"_SELVALUE_"^"_INVVALUE_"^^^"_REASON_"^"_ITEMDA
 Q
