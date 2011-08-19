PRCPAWO0 ;WISC/RFJ-adjust inventory level - other adjustment        ;11 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
 ;  called from prcpawa0 for type 3 other adjustment
OTHER ;  other adjustment
 ;  select item from the inventory point and ask for input.
 N DATA,ITEMDA,ITEMDATA,ORDERNO,PRCPAWN0,PRCPID,QTY,REASON,REASONCD,VALUE,VOUCHER
 K ^TMP($J,"PRCPAWO0")
 F  D  Q:'ITEMDA  W !!!!!
 .   W !!,"  >> Select an item number from the ",PRCP("IN")," inventory point. <<"
 .   S ITEMDA=$$ITEM^PRCPUITM(PRCP("I"),0,"","") I 'ITEMDA Q
 .   D SHOWDATA^PRCPAWA0(PRCP("I"),ITEMDA)
 .   ;
 .   ;  item already selected
 .   I $D(^TMP($J,"PRCPAWO0","PROCESS",ITEMDA)) S XP="  THIS ITEM WAS PREVIOUSLY SELECTED DURING THIS SELECTION PROCESS.",XP(1)="  OK TO REMOVE THIS ADJUSTMENT SO YOU CAN ENTER A NEW ONE" W !! I $$YN^PRCPUYN(1)'=1 Q
 .   K ^TMP($J,"PRCPAWO0","PROCESS",ITEMDA)
 .   ;
 .   ;  enter adjustment
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)) I ITEMDATA="" Q
 .   W !!,"****************  E N T E R    A D J U S T M E N T    D A T A  ****************",!
 .   S QTY=$$QTY^PRCPAWU0(-$P(ITEMDATA,"^",7),99998) I QTY["^" Q
 .   S VALUE=$$VALUE^PRCPAWU0(-99999.99,99999.99," INVENTORY","") I VALUE["^" Q
 .   I 'QTY,'VALUE W !!?10,">> EITHER QUANTITY OR VALUE NEEDS TO BE ENTERED FOR AN ADJUSTMENT <<" Q
 .   I '$D(VOUCHER) W ! S VOUCHER=$$VOUCHER^PRCPAWU0 I VOUCHER=""!(VOUCHER="^") Q
 .   W ! S REASONCD=$$REASON I 'REASONCD Q
 .   W ! S REASON=$$REASON^PRCPAWU0(REASONCD) I REASON["^" Q
 .   S ^TMP($J,"PRCPAWO0","PROCESS",ITEMDA)=QTY_"^^"_VALUE_"^^"_VOUCHER_"^"_(+REASONCD)_"^"_REASON
 ;
 I ITEMDA["^" D Q Q
 I '$O(^TMP($J,"PRCPAWO0","PROCESS",0)) W !!?10,">> NO ITEMS HAVE BEEN SELECTED <<" D Q Q
 ;  get whse fcp data
 N PRCPWBFY,PRCPWFCP,PRCPWSTA
 D SVDATA^PRCPSFIU(PRCP("I"))
 S XP="READY TO PROCESS INVENTORY ADJUSTMENTS",XH="Enter YES to PROCESS the INVENTORY adjustments, NO to exit."
 W !! I $$YN^PRCPUYN(1)'=1 D Q Q
 ;
 ;  process inventory adjustments
 S ORDERNO=$$ORDERNO^PRCPUTRX(PRCP("I"))
 S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPAWO0","PROCESS",ITEMDA)) Q:'ITEMDA  S DATA=^(ITEMDA) I DATA'="" D
 .   K PRCPAWN0
 .   S PRCPAWN0("QTY")=$P(DATA,"^"),PRCPAWN0("INVVAL")=$P(DATA,"^",3),PRCPAWN0("SELVAL")=0,PRCPAWN0("REF")=$P(DATA,"^",5),PRCPAWN0("REASON")="0:"_$P(DATA,"^",7),PRCPAWN0("REASONCODE")=$P(DATA,"^",6),PRCPAWN0("2237PO")=PRC("SITE")
 .   D ITEM^PRCPUUIW(PRCP("I"),ITEMDA,"A",ORDERNO,.PRCPAWN0)
 .   K PRCPAWN0
 ;
 ;  create fms sv document
 D SV^PRCPSFSV(PRCP("I"),"A"_ORDERNO,"","")
 ;  create log or isms code sheets
 D CODESHTS^PRCPAWC0(PRCP("I"),"A"_ORDERNO)
 ;  print form
 D PRINFORM^PRCPAWR0("A"_ORDERNO)
Q K ^TMP($J,"PRCPAWO0")
 Q
 ;
 ;
REASON() ;  enter reason text
 N DIR,REASON,X,Y
 S REASON=$G(^DISV(+$G(DUZ),"PRCPAWO0","REASON"))
 S DIR(0)="SO^1:Transfer of stock to another VAMC Warehouse;2:Sale of stock to OGA;3:Transfer of excess stock to GSA;4:Adjustment of stock valuation;5:Writeoff damaged stock;6:Transfer Transportation expense to stock;7:Inventory Refund"
 S DIR("A")="  Select TYPE of ADJUSTMENT"
 I REASON'="" S DIR("B")=REASON
 W ! D ^DIR K DIR I Y'=1,Y'=2,Y'=3,Y'=4,Y'=5,Y'=6,Y'=7 Q 0
 S DIR("A",1)="  >> Enter the reason text which will appear on the transaction register. <<"
 D ^DIR
 I Y'["^" S ^DISV(DUZ,"PRCPAWO0","REASON")=Y
 Q Y_":"_Y(0)
