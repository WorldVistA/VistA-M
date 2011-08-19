PRCPDAPI ;WISC/RFJ-drug accountability/prime vendor (check item)    ;15 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ITEM ;  check line item, item master file for errors
 ;  major errors in format or upload
 I '$P(DATA,"^",2) D ERROR^PRCPDAPE("'IT1' ITEM DATA, INVOICE LINE NUMBER (piece 2) NOT DEFINED") Q
 I $D(^TMP($J,"PRCPDAPV SET",STCTRL,"IT",+$P(DATA,"^",2))) D ERROR^PRCPDAPE("'IT1' ITEM DATA, INVOICE NUMBER (piece 2) APPEARS ON THE INVOICE MORE THAN ONCE") Q
 I $P(DATA,"^",6)'="DS" D ERROR^PRCPDAPE("'IT1' ITEM DATA, UNIT PRICE CODE (piece 6) SHOULD EQUAL 'DS' FOR DISCOUNT") Q
 I $P(DATA,"^",7)'="ND" D ERROR^PRCPDAPE("'IT1' ITEM DATA, ITEM IDENTIFIER (piece 7) SHOULD EQUAL 'ND' FOR NATIONAL DRUG CODE") Q
 ;
 ;  no major errors in format or upload
 S LINEITEM=+$P(DATA,"^",2),NDC=$P(DATA,"^",8),VDC=$P(DATA,"^",10)
 S ^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM)=+$P(DATA,"^",3)_"^"_$P(DATA,"^",4)_"^"_(+$P(DATA,"^",5))_"^"_NDC_"^"_VDC
 ;
 ;  get item master file and vendor entry
 D GETITEM
 I 'ITEMDA S:VDC="" VDC=" " S ITEMDA=+$O(^PRC(441,"D",VDC,0)) I ITEMDA S VENDA=+$O(^PRC(441,"D",VDC,ITEMDA,0))
 I 'ITEMDA S VDC="#"_VDC,ITEMDA=+$O(^PRC(441,"D",VDC,0)) I ITEMDA S VENDA=+$O(^PRC(441,"D",VDC,ITEMDA,0))
 I 'ITEMDA S ^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM,"E")="ERROR: ITEM NOT STORED IN ITEM MASTER FILE (#441).",^TMP($J,"PRCPDAPV SET",STCTRL,"E")=1,PRCPFERR=1 Q
 ;  check item master file errors
 I ITEMDA,$L(NDC) S %=+$O(^PRC(441,"F",NDC,ITEMDA)) I % S ^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM,"E1")="ERROR: THE NDC ["_NDC_"] IS A DUPLICATE WITH ITEM MASTER #"_%,^TMP($J,"PRCPDAPV SET",STCTRL,"E")=1,PRCPFERR=1
 I '$D(^PRC(441,ITEMDA,2,PRCPVEND,0)) S ^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM,"E2")="ERROR: THE PRIME VENDOR IS NOT A VENDOR IN THE ITEM MASTER FILE (#441).",^TMP($J,"PRCPDAPV SET",STCTRL,"E")=1,PRCPFERR=1
 S $P(^TMP($J,"PRCPDAPV SET",STCTRL,"IT",LINEITEM),"^",6)=ITEMDA_"^"_VENDA
 Q
 ;
 ;
GETITEM       ;  lookup item on ndc with all combinations
 ;  requires ndc
 ;  returns itemda, ndc found, vendor
 N END,END0,FRO,FRO0,MID,MID0
 ;
 S END=$E(NDC,$L(NDC)-1,$L(NDC)),FRO=$E(NDC,1,$L(NDC)-2)
 S MID=$E(FRO,$L(FRO)-3,$L(FRO)),FRO=$E(FRO,1,$L(FRO)-4)
 ;         
 S FRO0=FRO,MID0=MID,END0=END
 F  D  Q:ITEMDA
 .   D LOOKUP(FRO0,MID0,END0) Q:ITEMDA
 .   ;
 .   I $E(FRO0)=0 S FRO0=$E(FRO0,2,99) Q
 .   I $E(MID0)=0 S FRO0=FRO,MID0=$E(MID0,2,99) Q
 .   I $E(END0)=0 S FRO0=FRO,MID0=MID,END0=$E(END0,2,99) Q
 .   S ITEMDA=-1
 I ITEMDA=-1 S ITEMDA=0
 Q
 ;
 ;
LOOKUP(FRO,MID,END)          ;  lookup item by NDC (fro-mid-end)
 S NDC=FRO_"-"_MID_"-"_END
 S ITEMDA=+$O(^PRC(441,"F",NDC,0))
 I ITEMDA S VENDA=+$O(^PRC(441,"F",NDC,ITEMDA,0))
 Q
