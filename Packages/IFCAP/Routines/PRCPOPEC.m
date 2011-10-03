PRCPOPEC ;WISC/RFJ-distribution order error report for cc,ik items  ;27 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
INIT       ;  check order for errors and build array
 N DATA,ITEMDA,QTYORDER
 K ^TMP($J,"PRCPOPER")
 S VALMCNT=0
 S CCIKITEM=0 F  S CCIKITEM=$O(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM)) Q:'CCIKITEM  D
 .   S QTYORDER=$P($G(^PRCP(445.3,ORDERDA,1,CCIKITEM,0)),"^",2)
 .   D SETERROR(CCIKITEM)
 .   ;  check items to post
 .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM,ITEMDA)) Q:'ITEMDA  S QTYORDER=$P(^(ITEMDA),"^")-$P(^(ITEMDA),"^",2) I QTYORDER D
 .   .   ;  do not check cc/ik items twice
 .   .   I $D(^TMP($J,"PRCPOPPC-ITEMS",ITEMDA)) Q
 .   .   D SETERROR(ITEMDA)
 ;
 I VALMCNT=0 S VALMQUIT=1,VALMSG="* * * NO ERRORS FOUND * * *"
 Q
 ;
 ;
EXIT ;  exit and clean up
 K ^TMP($J,"PRCPOPER")
 Q
 ;
 ;
EEITEMS ;  called from protocol file to enter/edit invpt items
 N PRC,PRCP
 S PRCP("DPTYPE")="PS"
 D ^PRCPEILM
 D INIT
 S VALMBCK="R"
 I $G(VALMQUIT) K VALMBCK
 Q
 ;
 ;
SETERROR(ITEMDA) ;  set error in list for itemda
 N ERROR
 S ERROR=$$ITEMCHK^PRCPOPER(PRCPPRIM,PRCPSECO,ITEMDA)
 I $P($G(^PRCP(445,PRCPPRIM,1,ITEMDA,0)),"^",7)<QTYORDER S ERROR=ERROR_$S(ERROR="":"",1:"^")_"    ** PRIMARY QUANTITY ON-HAND LESS THAN QUANTITY ON ORDER **"
 I ERROR="" Q
 D BLDARRAY^PRCPOPL(PRCPPRIM,PRCPSECO,ITEMDA,QTYORDER)
 F %=1:1 Q:$P(ERROR,"^",%,99)=""  I $P(ERROR,"^",%)'="" D SET^PRCPOPL($P(ERROR,"^",%))
 Q
