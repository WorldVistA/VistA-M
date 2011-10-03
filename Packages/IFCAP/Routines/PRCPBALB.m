PRCPBALB ;WISC/RGY,RFJ-process barcode data (build array)           ;04 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
BUILD ;  build array
 N COUNT,DATA,INVDATA,INVPT,ITEMDA,LINE,QTY,RECORD
 K ^TMP($J,"PRCPBALM"),^TMP($J,"PRCPBALMD"),^TMP($J,"PRCPBALME"),^TMP($J,"PRCPBALMU")
 S RECORD=1 F  S RECORD=$O(^PRCT(446.4,PRCTDA,2,PRCTDA1,1,RECORD)) Q:'RECORD  S DATA=^(RECORD,0) I DATA'="" D
 .   S INVPT=+$P($P(DATA," "),"IE",2),ITEMDA=+$P(DATA," ",2),QTY=+$P(DATA," ",3)
 .   S ^TMP($J,"PRCPBALMD",RECORD)=INVPT_"^"_ITEMDA_"^"_QTY
 .   I $E(DATA)="*" S ^TMP($J,"PRCPBALME",RECORD)="Data has been previously uploaded" Q
 .   I $E(DATA,1,2)'="IE" S ^TMP($J,"PRCPBALME",RECORD)="First two characters should equal IE" Q
 .   I DATA'?1"IE"1N.N1" "1N.N1" ",DATA'?1"IE"1N.N1" "1N.N1" "1N.N S ^TMP($J,"PRCPBALME",RECORD)="Record data is not in expected format" Q
 .   I 'INVPT!('ITEMDA) S ^TMP($J,"PRCPBALME",RECORD)="Record data has inventory point or item equal zero" Q
 .   I PRCPTYPE="U",QTY=0 S ^TMP($J,"PRCPBALME",RECORD)="Quantity is equal to zero for usage" Q
 .   I '$D(^PRCP(445,INVPT,4,DUZ)) S ^TMP($J,"PRCPBALME",RECORD)="You are not an authorized user for this inventory point" Q
 .   I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) S ^TMP($J,"PRCPBALME",RECORD)="Item is not stored in inventory point" Q
 .   I $D(^PRCP(445,"AC","W",INVPT)) S ^TMP($J,"PRCPBALME",RECORD)="Warehouse inventory items cannot be uploaded" Q
 .   S ^TMP($J,"PRCPBALMU",INVPT,ITEMDA,RECORD)=QTY
 ;  build array
 S LINE=0
 ;  show errors first
 I $D(^TMP($J,"PRCPBALME")) D
 .   D SET("* * * ERRORS: ITEMS WHICH WILL NOT BE UPLOADED TO THE INVENTORY POINTS * * *",1,1,80,IORVON,IORVOFF)
 .   D SET("LINE  INVENTORY POINT          IM#       DESCRIPTION                    QUANTITY",2,1,80,IORVON,IORVOFF)
 .   S LINE=2
 .   S RECORD=0 F  S RECORD=$O(^TMP($J,"PRCPBALME",RECORD)) Q:'RECORD  S DATA=^TMP($J,"PRCPBALMD",RECORD) D
 .   .   S LINE=LINE+1
 .   .   D SET(RECORD,LINE,1,80)
 .   .   D SET($$INVNAME^PRCPUX1($P(DATA,"^")),LINE,7,30)
 .   .   D SET($P(DATA,"^",2),LINE,32,40)
 .   .   D SET($$DESCR^PRCPUX1($P(DATA,"^"),$P(DATA,"^",2)),LINE,42,70)
 .   .   D SET($J($P(DATA,"^",3),10),LINE,71,80)
 .   .   S LINE=LINE+1
 .   .   D SET("      "_^TMP($J,"PRCPBALME",RECORD),LINE,1,80)
 ;  show records to upload
 K PRCPFSCA ;this flag is used to mark items scanned more than once
 I LINE'=0 S LINE=LINE+1 D SET("",LINE,1,80)
 S LINE=LINE+1
 D SET("* * * INVENTORY POINTS AND ITEMS TO UPLOAD * * *",LINE,1,80,IORVON,IORVOFF)
 S INVPT=0 F  S INVPT=$O(^TMP($J,"PRCPBALMU",INVPT)) Q:'INVPT  D
 .   S LINE=LINE+1
 .   D SET("",LINE,1,80)
 .   S LINE=LINE+1
 .   D SET("    INVENTORY POINT: "_$$INVNAME^PRCPUX1(INVPT),LINE,1,80,IORVON,IORVOFF)
 .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPBALMU",INVPT,ITEMDA)) Q:'ITEMDA  D
 .   .   S INVDATA=$G(^PRCP(445,INVPT,1,ITEMDA,0))
 .   .   S RECORD=0 F COUNT=0:1 S RECORD=$O(^TMP($J,"PRCPBALMU",INVPT,ITEMDA,RECORD)) Q:'RECORD  D
 .   .   .   S LINE=LINE+1
 .   .   .   D SET(RECORD,LINE,1,80)
 .   .   .   D SET($E($$DESCR^PRCPUX1(INVPT,ITEMDA),1,27),LINE,7,35)
 .   .   .   D SET(ITEMDA,LINE,36,43)
 .   .   .   D SET($TR($$NSN^PRCPUX1(ITEMDA),"-"),LINE,44,63)
 .   .   .   D SET($J($$UNIT^PRCPUX1(INVPT,ITEMDA),8),LINE,57,64)
 .   .   .   D SET($J($P(INVDATA,"^",7)+$P(INVDATA,"^",19),8),LINE,65,72)
 .   .   .   D SET($J(+^TMP($J,"PRCPBALMU",INVPT,ITEMDA,RECORD),8),LINE,73,80)
 .   .   I COUNT'=1 S LINE=LINE+1 D SET("  WARNING -- ITEM WAS SCANNED MORE THAN ONCE",LINE,1,80) S PRCPFSCA=1
 S VALMCNT=LINE
 Q
 ;
 ;
SET(STRING,LINE,COLUMN,CLREND,ON,OFF)  ;  set array
 I '$D(@VALMAR@(LINE,0)) D SET^VALM10(LINE,$J("",80))
 D SET^VALM10(LINE,$$SETSTR^VALM1(STRING,@VALMAR@(LINE,0),COLUMN,CLREND))
 I $G(ON)]""!($G(OFF)]"") D CNTRL^VALM10(LINE,COLUMN,$L(STRING),ON,OFF)
 Q
