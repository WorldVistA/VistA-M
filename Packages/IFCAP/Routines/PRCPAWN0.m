PRCPAWN0 ;WISC/RFJ-adjust inventory level to or from non-issuable   ;11 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
 ;  called from prcpawa0 for type 2 non-issuable adjustment
NONISSUE ;  move quantity to or from non-issuable
 ;  select item from the inventory point and ask for input.
 N DATA,ITEMDA,ITEMDATA,ORDERNO,PRCPAWN0,PRCPID,QTY,REASON,VOUCHER
 K ^TMP($J,"PRCPAWN0")
 F  D  Q:'ITEMDA  W !!!!!
 .   W !!,"  >> Select an item number from the ",PRCP("IN")," inventory point. <<"
 .   S ITEMDA=$$ITEM^PRCPUITM(PRCP("I"),0,"","") I 'ITEMDA Q
 .   D SHOWDATA^PRCPAWA0(PRCP("I"),ITEMDA)
 .   ;
 .   ;  item already selected
 .   I $D(^TMP($J,"PRCPAWN0","PROCESS",ITEMDA)) S XP="  THIS ITEM WAS PREVIOUSLY SELECTED DURING THIS SELECTION PROCESS.",XP(1)="  OK TO REMOVE THIS ADJUSTMENT SO YOU CAN ENTER A NEW ONE" W !! I $$YN^PRCPUYN(1)'=1 Q
 .   K ^TMP($J,"PRCPAWN0","PROCESS",ITEMDA)
 .   ;
 .   ;  enter adjustment
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)) I ITEMDATA="" Q
 .   W !!,"****************  E N T E R    A D J U S T M E N T    D A T A  ****************",!
 .   S QTY=$$QTY^PRCPAWU0(-$P(ITEMDATA,"^",7),+$P(ITEMDATA,"^",19)) I QTY["^" Q
 .   I QTY=0 W !!?5,">> THE QUANTITY MOVED TO OR FROM NON-ISSUABLE CANNOT EQUAL 0. <<" Q
 .   I '$D(VOUCHER) W ! S VOUCHER=$$VOUCHER^PRCPAWU0 I VOUCHER="" Q
 .   W ! S REASON=$$REASON^PRCPAWU0($S(QTY<0:"TO ",1:"FROM ")_"non-issuable") I REASON["^" Q
 .   S ^TMP($J,"PRCPAWN0","PROCESS",ITEMDA)=QTY_"^^^^"_VOUCHER_"^"_REASON
 ;
 I ITEMDA["^" D Q Q
 I '$O(^TMP($J,"PRCPAWN0","PROCESS",0)) W !!?10,">> NO ITEMS HAVE BEEN SELECTED <<" D Q Q
 S XP="READY TO PROCESS NON-ISSUABLE ADJUSTMENTS",XH="Enter YES to PROCESS the NON-ISSUABLE adjustments, NO to exit."
 W !! I $$YN^PRCPUYN(1)'=1 D Q Q
 ;
 ;  process non-issuable adjustments
 S ORDERNO=$$ORDERNO^PRCPUTRX(PRCP("I"))
 S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPAWN0","PROCESS",ITEMDA)) Q:'ITEMDA  S DATA=^(ITEMDA) I DATA'="" D
 .   K PRCPAWN0
 .   S PRCPAWN0("QTY")=$P(DATA,"^"),(PRCPAWN0("INVVAL"),PRCPAWN0("SELVAL"))=0,PRCPAWN0("REF")=$P(DATA,"^",5),PRCPAWN0("REASON")="0:"_$P(DATA,"^",6),PRCPAWN0("ISSUE")=$S(QTY<0:"N",1:"I"),PRCPAWN0("2237PO")=PRC("SITE")
 .   D ITEM^PRCPUUIW(PRCP("I"),ITEMDA,"A",ORDERNO,.PRCPAWN0)
 .   K PRCPAWN0
 ;
 ;  create log or isms code sheets
 D CODESHTS^PRCPAWC0(PRCP("I"),"A"_ORDERNO)
 ;  print form
 D PRINFORM^PRCPAWR0("A"_ORDERNO)
Q K ^TMP($J,"PRCPAWN0")
 Q
