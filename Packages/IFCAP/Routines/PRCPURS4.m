PRCPURS4 ;WISC/RFJ-select item list                                 ;11 Aug 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ITEMSEL ;  select a group of items from inventory point
 ;  if all items are selected, return prcpalli=1
 ;  selected items are returned in tmp($j,"prcpurs4",itemda)
 N ITEMDA
 K PRCPALLI,^TMP($J,"PRCPURS4")
 W !!,"To select ALL items, press RETURN."
 F  S ITEMDA=$$ITEM^PRCPUITM(PRCP("I"),0,"","") Q:'ITEMDA  S ^TMP($J,"PRCPURS4",ITEMDA)=""
 I ITEMDA["^" K ^TMP($J,"PRCPURS4"),PRCPALLI Q
 I $O(^TMP($J,"PRCPURS4",0)) Q
 S XP="Do you want to select ALL items",XH="Enter 'YES' to select ALL items, 'NO' or '^' to exit."
 W ! I $$YN^PRCPUYN(1)'=1 Q
 S PRCPALLI=1
 Q
 ;
 ;
ITEMMAST(PRCPDATE) ;  select a group of items from item master file
 ;  prcpdate = date to check for opening balance
 ;  if all items are selected, return allitems=1
 ;  selected items are returned in tmp($j,"prcpitems",itemda)
 K ALLITEMS,^TMP($J,"PRCPITEMS")
 W !!,"To select ALL items, press RETURN."
 F  S ITEMDA=$$MASTITEM^PRCPUITM($S(PRCPDATE:"I $D(^PRCP(445.1,PRCP(""I""),1,+Y,1,PRCPDATE,0))",1:"")) Q:'ITEMDA  S ^TMP($J,"PRCPITEMS",ITEMDA)=""
 I ITEMDA["^" K ^TMP($J,"PRCPITEMS") Q
 I '$O(^TMP($J,"PRCPITEMS",0)) S XP="Do you want to select ALL items",XH="Enter 'YES' to select ALL items, 'NO' or '^' to exit." W ! S %=$$YN^PRCPUYN(0) I %=1 S ALLITEMS=1
 I '$O(^TMP($J,"PRCPITEMS",0)),'$D(ALLITEMS) W !!,"NO ITEMS SELECTED!" Q
 Q
