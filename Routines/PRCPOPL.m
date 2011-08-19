PRCPOPL ;WISC/RFJ/DGL-distribution order processing list manager ; 3/20/00 9:27am
V ;;5.1;IFCAP;**1,41**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I "PS"'[PRCP("DPTYPE") W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY OR SECONDARY INVENTORY POINT." Q
 ;
 N %,ORDERDA,PRCPFNEW,PRCPFONE,PRCPORD,PRCPPAT,PRCPPRIM,PRCPSECO,VA,X,Y
 ;
 I PRCP("DPTYPE")="S" S PRCPPRIM=+$$FROMCHEK^PRCPUDPT(PRCP("I"),1) Q:'PRCPPRIM  S PRCPSECO=PRCP("I")
 I PRCP("DPTYPE")="P" S PRCPSECO=+$$TO^PRCPUDPT(PRCP("I")) Q:'PRCPSECO  S PRCPPRIM=PRCP("I")
 W !!,"** Distribution ",$S(PRCP("DPTYPE")="S":"from",1:"to")_" inventory point: ",$$INVNAME^PRCPUX1($S(PRCP("DPTYPE")="S":PRCPPRIM,1:PRCPSECO))," **"
 ;
 F  W !! S ORDERDA=+$$ORDERSEL^PRCPOPUS(PRCPPRIM,PRCPSECO,"*",1) Q:'ORDERDA  D
 .   W !
 .   L +^PRCP(445.3,ORDERDA):5 I '$T D SHOWWHO^PRCPULOC(445.3,ORDERDA,0) D R^PRCPUREP Q
 .   D ADD^PRCPULOC(445.3,ORDERDA,0,"Distribution Order Processing")
 .   I $$TYPE^PRCPOPUS(ORDERDA) D UNLOCK Q
 .   W ! I $$REMARKS^PRCPOPUS(ORDERDA) D UNLOCK Q
 .   D VARIABLE^PRCPOPU
 .   D EN^VALM("PRCP DIST ORDER PROCESSING")
 .   D UNLOCK
 Q
 ;
 ;
UNLOCK ;  unlock distribution order
 D CLEAR^PRCPULOC(445.3,ORDERDA,0)
 L -^PRCP(445.3,ORDERDA)
 Q
 ;
 ;
HDR ;  build header
 K VALMHDR
 I $P($G(PRCPORD(2)),"^")'="" S VALMHDR(1)=$E("POST ITEMS TO: "_$P(PRCPORD(2),"^")_$J(" ",80),1,47)_"  THRU SECONDARY: "_$E($P(PRCPORD(0),"^",3),1,15)
 I $P($G(PRCPORD(2)),"^")="" S VALMHDR(1)="POST ITEMS TO SECONDARY: "_$P(PRCPORD(0),"^",3)
 S VALMHDR(2)=$E("  "_$E($P(PRCPORD(0),"^",2),1,15)_" DISTRIBUTION ORDER: "_$P(PRCPORD(0),"^")_$J(" ",50),1,49)_"STATUS: "_$$STATUS^PRCPOPU(ORDERDA)
 Q
 ;
 ;
INIT ;  init variables and build array
 N DATA,ITEMDA,ITEMDATA,QTYOH,STATUS
 K ^TMP($J,"PRCPOP")
 S VALMCNT=0
 I $P(^PRCP(445.3,ORDERDA,0),"^",10)]"" D SET("  ***This Order was sent to the supply station and cannot be updated. ***"),SET(" ")
 S STATUS=$P(^PRCP(445.3,ORDERDA,0),"^",6)
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA,0)) I DATA'="" D
 .   D BLDARRAY(PRCPPRIM,PRCPSECO,ITEMDA,$P(DATA,"^",2),STATUS)
 .   S ITEMDATA=$G(^PRCP(445,PRCPPRIM,1,ITEMDA,0)),QTYOH=+$P($G(ITEMDATA),"^",7)
 .   I ITEMDATA="" D SET("  *** WARNING -- ITEM IS NO LONGER STOCKED IN PRIMARY INVENTORY POINT *** ") Q
 .   I STATUS'="P"&($P(DATA,"^",2)>QTYOH),QTYOH'<0 D
 .   .   D SET("     *** WARNING -- QTY ORDERED ("_$P(DATA,"^",2)_") IS MORE THAN QTY ON HAND ("_QTYOH_") ***")
 .   .   D SET("     *** Quantity on hand will be posted unless quantity ordered is edited ***")
 .   I STATUS'="P"&($P(DATA,"^",2)>QTYOH),QTYOH<0 D
 .   .   D SET("     *** WARNING -- QTY ORDERED ("_$P(DATA,"^",2)_") IS MORE THAN QTY ON HAND ("_QTYOH_") ***")
 .   .   D SET(" *** A quantity of ZERO(0) will be posted unless quantity ordered is edited ***")
 .   I STATUS="P"&($P(DATA,"^",2)'=$P(DATA,"^",7)) D SET("              *** Actual posted quantity was "_$P(DATA,"^",7)_" ***")
 ;
 I VALMCNT=0 D SET(" "),SET("  * * * NO ITEMS ARE ON THIS ORDER * * *")
 Q
 ;
 ;
BLDARRAY(PRCPPRIM,PRCPSECO,ITEMDA,QTYORDER,STATUS) ;  build item array
 S:'$D(STATUS) STATUS=0
 S X=$$SETFLD^VALM1("  "_$E($$DESCR^PRCPUX1(PRCPPRIM,ITEMDA),1,28)_" (#"_ITEMDA_")","","ITEM")
 S X=$$SETFLD^VALM1($P($$UNIT^PRCPUX1(PRCPPRIM,ITEMDA,"^"),"^",2),X,"UNIT")
 S X=$$SETFLD^VALM1(QTYORDER,X,"ORDERED")
 S X=$$SETFLD^VALM1($P($$GETVEN^PRCPUVEN(PRCPSECO,ITEMDA,PRCPPRIM_";PRCP(445,",1),"^",4),X,"CONV")
 I STATUS'="P" S X=$$SETFLD^VALM1($P($G(^PRCP(445,PRCPPRIM,1,ITEMDA,0)),"^",7),X,"ONHAND")
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,X,VALMCNT)
 Q
 ;
 ;
EXIT ;  exit and clean up
 K ^TMP($J,"PRCPOP")
 Q
 ;
 ;
EEITEMS ;  called from protocol file to enter/edit invpt items
 N PRC,PRCP
 S PRCP("DPTYPE")="PS"
 D ^PRCPEILM
 D INIT
 S VALMBCK="R"
 Q
 ;
 ;
CHECK(TYPE)        ;  called when screen displays and when protocol selected
 ;  causes () to be display around inappropriate protocol selections
 ;  type="edit" or "delete" or "release" or "picktick" or "post"
 ;  returns 1 for sucess, 0 for no
 I '$D(^PRCP(445.3,$G(ORDERDA),0)) Q 0
 N STATUS,SECID
 S STATUS=$P(^PRCP(445.3,ORDERDA,0),"^",6) S:STATUS="B" STATUS="R"
 S SECID=$P(^PRCP(445.3,ORDERDA,0),"^",3)
 I TYPE="EDIT",PRCP("DPTYPE")="S",STATUS'="" Q 0
 I TYPE'="DELETE",TYPE'="PICKTICK",TYPE'="SEND",$P(^PRCP(445.3,ORDERDA,0),"^",10)]"" Q 0
 I TYPE="EDIT",STATUS="P" Q 0
 I TYPE="DELETE",PRCP("DPTYPE")="S",STATUS'="" Q 0
 I TYPE="DELETE",STATUS="P" Q 0
 I TYPE="RELEASE",STATUS'="" Q 0
 I TYPE="POST",PRCP("DPTYPE")="S" Q 0
 I TYPE="POST",STATUS="" Q 0
 ;I TYPE="POST",$P(^PRCP(445.3,ORDERDA,0),"^",7)="" Q 0
 I TYPE="POST",STATUS="P" Q 0
 I TYPE="PICKTICK",STATUS="P" Q 1
 I TYPE="PICKTICK" I STATUS'="R" Q 0
 I TYPE="SEND",$P(^PRCP(445.3,ORDERDA,0),"^",8)'="R" Q 0
 I TYPE="SEND",$P($G(^PRCP(445,SECID,5)),"^",1)']"" Q 0
 I TYPE="SEND",STATUS'="R" Q 0
 Q 1
 ;
 ;
SET(STRING)        ;  set string in array
 N %
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,STRING)
 Q
