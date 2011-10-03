PRCPCRU1 ;WISC/RFJ-cc & ik report utilities: select                 ;01 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CASECART ;  select a group of case carts
 ;  if all carts are selected, return allcarts=1
 ;  selected case carts are returned in tmp($j,"prcpcarts",itemda)
 N %,ITEMDA
 K ALLCARTS,^TMP($J,"PRCPCARTS")
 W !!,"To select ALL case carts, press RETURN."
 F  S ITEMDA=$$SELECT^PRCPCED0("C",0,0) Q:'ITEMDA  S ^TMP($J,"PRCPCARTS",ITEMDA)=""
 I ITEMDA["^" K ^TMP($J,"PRCPCARTS") Q
 I '$O(^TMP($J,"PRCPCARTS",0)) S XP="Do you want to select ALL case carts",XH="Enter 'YES' to select ALL case carts, 'NO' or '^' to exit." W ! I $$YN^PRCPUYN(1)=1 S ALLCARTS=1
 I '$O(^TMP($J,"PRCPCARTS",0)),'$D(ALLCARTS) W !!,"NO CASE CARTS SELECTED!" Q
 Q
 ;
 ;
INSTRKIT ;  select a group of instrument kits
 ;  if all kits are selected, return allkits=1
 ;  selected instrument kits are returned in tmp($j,"prcpkits",itemda)
 N %,ITEMDA
 K ALLKITS,^TMP($J,"PRCPKITS")
 W !!,"To select ALL instrument kits, press RETURN."
 F  S ITEMDA=$$SELECT^PRCPCED0("K",0,0) Q:'ITEMDA  S ^TMP($J,"PRCPKITS",ITEMDA)=""
 I ITEMDA["^" K ^TMP($J,"PRCPKITS") Q
 I '$O(^TMP($J,"PRCPKITS",0)) S XP="Do you want to select ALL instrument kits",XH="Enter 'YES' to select ALL instrument kits, 'NO' or '^' to exit." W ! I $$YN^PRCPUYN(1)=1 S ALLKITS=1
 I '$O(^TMP($J,"PRCPKITS",0)),'$D(ALLKITS) W !!,"NO INSTRUMENT KITS SELECTED!" Q
 Q
