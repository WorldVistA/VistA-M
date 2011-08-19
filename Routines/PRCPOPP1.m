PRCPOPP1 ;WISC/RFJ-case cart/instrument kit post utilities          ;27 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EDIT ;  edit items on list
 D FULL^VALM1
 S VALMBCK="R"
 N CCIKITEM,ITEMDA
 F  W ! S CCIKITEM=+$$ITEMSEL("C") Q:'CCIKITEM  D
 .   F  W ! S ITEMDA=+$$ITEMSEL("I") Q:'ITEMDA  D
 .   .   D QTYRETRN
 D BUILD^PRCPOPPC
 Q
 ;
 ;
QTYRETRN ;  ask for quantity to return to primary
 N DIR,X,Y
 S X=$G(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM,ITEMDA))
 S DIR(0)="NA^0:"_$P(X,"^")_":0",DIR("A")="  QUANTITY TO RETURN: ",DIR("B")=$P(X,"^",2)
 S DIR("A",1)="  Quantity Ordered : "_$P(X,"^")
 S DIR("A",2)="  Quantity Returned: "_$P(X,"^",2)
 S DIR("A",3)="  Quantity to Post : "_($P(X,"^")-$P(X,"^",2))
 S DIR("A",4)="Enter the quantity of this item to return to the primary inventory point."
 W ! D ^DIR
 I +Y=Y S ^TMP($J,"PRCPOPPC-RETURN",CCIKITEM,ITEMDA)=+Y,$P(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM,ITEMDA),"^",2)=+Y
 Q
 ;
 ;
ITEMSEL(V1) ;  select items
 ;  v1=C for cc or ik items; v1=I for non cc or ik items
 ;  returns item number
 N %,DDH,DIC,DTOUT,DUOUT,PRCPSET,X,Y
 I V1="C" D
 .   S DIC("S")="I $P(^(0),U,6)=""S"",$D(^TMP($J,""PRCPOPPC-ITEMS"",Y))",DIC("A")="Select CASE CART or INSTRUMENT KIT: "
 I V1="I" D
 .   S DIC("S")="I $P(^(0),U,6)'=""S"",$D(^TMP($J,""PRCPOPPC-ITEMS"",CCIKITEM,Y))",DIC("A")="  Select ITEM: "
 S PRCPSET="I 1"
 S DIC="^PRC(441,",DIC(0)="QEAM" D ^DIC
 Q $S(Y<1:0,1:+Y)
 ;
 ;
REMREUSE ;  remove all reusable items from the list and post zero
 D FULL^VALM1
 S VALMBCK="R"
 N %,CCIKITEM,ITEMDA
 S XP="Do you want to remove ALL reusable items from the list and post ZERO"
 S XH="Enter 'YES' to remove all REUSABLE items from the list and post zero"
 S XH(1)="Enter 'NO' or '^' to leave the list as is and return to the main screen."
 W ! I $$YN^PRCPUYN(2)'=1 Q
 ;  remove reusables from list
 S CCIKITEM=0 F  S CCIKITEM=$O(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM)) Q:'CCIKITEM  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM,ITEMDA)) Q:'ITEMDA  D
 .   I $$REUSABLE^PRCPU441(ITEMDA) K ^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM,ITEMDA),^TMP($J,"PRCPOPPC-RETURN",CCIKITEM,ITEMDA) S ^TMP($J,"PRCPOPPC-NO",ITEMDA)=""
 D BUILD^PRCPOPPC
 Q
 ;
 ;
REMCCIK ;  remove cc or ik from list and post zero
 D FULL^VALM1
 S VALMBCK="R"
 N %,CCIKITEM,ITEMDA,PRCPFILE,TYPE
 W ! S CCIKITEM=+$$ITEMSEL("C") I 'CCIKITEM Q
 S PRCPFILE=$$FILENUMB^PRCPCUT1(CCIKITEM),TYPE=$S(PRCPFILE=445.7:"CASE CART",1:"INSTRUMENT KIT")
 S XP="Do you want to remove this "_TYPE_" from the list and post ZERO"
 S XH="Enter 'YES' to remove "_TYPE_" from the list and post ZERO"
 S XH(1)="Enter 'NO' or '^' to leave the list as is and return to the main screen."
 W ! I $$YN^PRCPUYN(2)'=1 Q
 ;  remove cc or ik from list
 K ^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM),^TMP($J,"PRCPOPPCCIK",CCIKITEM),^TMP($J,"PRCPOPPC-RETURN",CCIKITEM)
 S ^TMP($J,"PRCPOPPC-NO",CCIKITEM)=""
 D BUILD^PRCPOPPC
 Q
