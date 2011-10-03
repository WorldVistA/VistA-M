PRCPOPPC ;WISC/RFJ-post items in a case cart or instrument kit      ;27 Sep 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
HDR ; -- header code
 D HDR^PRCPOPL
 S VALMHDR(3)=$J(" ",49)_"* * *  Q U A N T I T Y  * * *"
 Q
 ;
 ;
INIT ;  start list manager here and set up variables, clean up
 ;  ^tmp($j,"prcpopccik",ccikitem)=qty ordered (passed to program)
 ;  ^tmp($j,"prcpoppc",line,0)=""   (list array)
 ;  ^tmp($j,"prcpoppc-no",item)=""  (do not include in list)
 ;  ^tmp($j,"prcpoppc-items",item)=qty ordered ^ qty returned
 ;  ^tmp($j,"prcpoppc-return",item)=qty entered by user for return
 ;
 K ^TMP($J,"PRCPOPPC-RETURN"),^TMP($J,"PRCPOPPC-NO")
 D VARIABLE^PRCPOPU
 ;
BUILD ;  build list manager array
 N CCIKITEM,DATA,ITEMDA,ITEMQTY,QTYORD,PRCPFILE,SEQUENCE
 ;
 K ^TMP($J,"PRCPOPPC"),^TMP($J,"PRCPOPPC-IK"),^TMP($J,"PRCPOPPC-ITEMS")
 S (VALMCNT,CCIKITEM)=0 F  S CCIKITEM=$O(^TMP($J,"PRCPOPCCIK",CCIKITEM)) Q:'CCIKITEM  S QTYORD=^(CCIKITEM) I QTYORD D
 .   I $D(^TMP($J,"PRCPOPPC-NO",CCIKITEM)) Q
 .   S PRCPFILE=$$FILENUMB^PRCPCUT1(CCIKITEM) I 'PRCPFILE Q
 .   D CCIKNAME
 .   S ITEMDA=0 F  S ITEMDA=$O(^PRCP(PRCPFILE,CCIKITEM,1,ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA,0)) I $P(DATA,"^",2) D
 .   .   S ITEMQTY=$P(DATA,"^",2)*QTYORD
 .   .   I PRCPFILE=445.7,$D(^PRCP(445.8,ITEMDA)) S ^TMP($J,"PRCPOPPC-IK",ITEMDA)=$G(^TMP($J,"PRCPOPPC-IK",ITEMDA))+ITEMQTY
 .   .   D ITEMNAME
 ;
 ;  build list of instrument kits in case carts
 S PRCPFILE=445.8,CCIKITEM=0 F  S CCIKITEM=$O(^TMP($J,"PRCPOPPC-IK",CCIKITEM)) Q:'CCIKITEM  S QTYORD=^(CCIKITEM) I QTYORD D
 .   I $D(^TMP($J,"PRCPOPPC-NO",CCIKITEM)) Q
 .   D CCIKNAME
 .   ;  sort by sequence
 .   K ^TMP($J,"PRCPOPPCSEQ")
 .   S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.8,CCIKITEM,1,ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA,0)),^TMP($J,"PRCPOPPCSEQ",+$P(DATA,"^",3),ITEMDA)=""
 .   S SEQUENCE="" F  S SEQUENCE=$O(^TMP($J,"PRCPOPPCSEQ",SEQUENCE)) Q:SEQUENCE=""  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPOPPCSEQ",SEQUENCE,ITEMDA)) Q:'ITEMDA  S DATA=$G(^PRCP(445.8,CCIKITEM,1,ITEMDA,0)) I $P(DATA,"^",2) D
 .   .   S ITEMQTY=$P(DATA,"^",2)*QTYORD
 .   .   D ITEMNAME
 K ^TMP($J,"PRCPOPPC-IK"),^TMP($J,"PRCPOPPCSEQ")
 ;
 I VALMCNT=0 S VALMQUIT=1 Q
 Q
 ;
EXIT ; -- exit code
 K ^TMP($J,"PRCPOPCCIK")
 K ^TMP($J,"PRCPOPPC")
 K ^TMP($J,"PRCPOPPC-IK")
 K ^TMP($J,"PRCPOPPC-ITEMS")
 K ^TMP($J,"PRCPOPPC-NO")
 K ^TMP($J,"PRCPOPPC-RETURN")
 Q
 ;
 ;
EEITEMS ;  called from protocol file to enter/edit invpt items
 D FULL^VALM1
 N PRC,PRCP
 S PRCP("DPTYPE")="PS"
 D ^PRCPEILM
 D BUILD
 S VALMBCK="R"
 Q
 ;
 ;
CCIKNAME ;  set up ccikname header
 D SET^PRCPOPL(" ")
 D SET^PRCPOPL("                      * * * * * "_$S(PRCPFILE=445.7:"  CASE CART   ",1:"INSTRUMENT KIT")_"  * * * * *")
 D SET^PRCPOPL($E($E($$DESCR^PRCPUX1(PRCP("I"),CCIKITEM),1,40)_" (#"_CCIKITEM_") ...................................",1,49)_QTYORD)
 Q
 ;
 ;
ITEMNAME ;  set up item information
 I $D(^TMP($J,"PRCPOPPC-NO",ITEMDA)) Q
 N QTYRET,REUSABLE
 S REUSABLE=$$REUSABLE^PRCPU441(ITEMDA)
 S VALMCNT=VALMCNT+1
 S X=$$SETFLD^VALM1("  "_$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,28)_" (#"_ITEMDA_")","","ITEM")
 S X=$$SETFLD^VALM1($S(REUSABLE:"R",1:" "),X,"REUSABLE")
 S X=$$SETFLD^VALM1($P($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"^"),"^",2),X,"UNIT")
 S X=$$SETFLD^VALM1(ITEMQTY,X,"ORDERED")
 S QTYRET=$S($D(^TMP($J,"PRCPOPPC-RETURN",CCIKITEM,ITEMDA)):^(ITEMDA),REUSABLE:ITEMQTY,1:0)
 S X=$$SETFLD^VALM1(QTYRET,X,"RETURNED")
 S X=$$SETFLD^VALM1(ITEMQTY-QTYRET,X,"POSTING")
 D SET^VALM10(VALMCNT,X,VALMCNT)
 S ^TMP($J,"PRCPOPPC-ITEMS",CCIKITEM,ITEMDA)=ITEMQTY_"^"_QTYRET
 Q
