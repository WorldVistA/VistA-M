PRCPOPP2 ;WISC/RFJ-case cart/instrument kit post items              ;27 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
POST ;  post cc's and ik's including items in cc's and ik's
 S VALMBCK="R"
 N CCIKITEM,DATA,ITEMDA,PRCPFLAG,QTYPOST
 ;
 W !!,"CHECKING CASE CART AND INSTRUMENT KIT ITEMS ON ORDER..."
 S (CCIKITEM,PRCPFLAG)=0 F  S CCIKITEM=$O(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM)) Q:'CCIKITEM!(PRCPFLAG)  D
 .   I $$ITEMCHK^PRCPOPER(PRCPPRIM,PRCPSECO,CCIKITEM)'="" S PRCPFLAG=1 Q
 .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM,ITEMDA)) Q:'ITEMDA  S DATA=^(ITEMDA) D
 .   .   S QTYPOST=$P(DATA,"^")-$P(DATA,"^",2)
 .   .   ;  if reusable items returned, do nothing
 .   .   I $$REUSABLE^PRCPU441(ITEMDA),'QTYPOST Q
 .   .   I $$ITEMCHK^PRCPOPER(PRCPPRIM,PRCPSECO,ITEMDA)'="" S PRCPFLAG=1 Q
 ;
 I PRCPFLAG S VALMSG="ORDER CANNOT BE POSTED - FIX ALL ERRORS FIRST" D EN^VALM("PRCP DIST ORDER CC/IK CHECK") Q
 W " NO ERRORS FOUND !",!
 ;
 S XP="Are you sure you want to POST the CC/IK items to "_$$INVNAME^PRCPUX1(PRCPSECO),XH="Enter 'YES' to start posting the CC/IK items to the secondary inventory point",XH(1)="Enter 'NO' or '^' to exit."
 W ! I $$YN^PRCPUYN(1)'=1 Q
 W !,"POSTING CASE CART AND INSTRUMENT KIT ITEMS ..."
 D POST^PRCPOPP3
 S VALMQUIT=1
 K VALMBCK
 Q
