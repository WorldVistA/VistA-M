PRCHAAC3 ;WIFO/TN/CR-CONT. OF IFCAP HL7 MESSAGE TO AUSTIN ;4/28/05 2:43 PM
 ;;5.1;IFCAP;**79**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;This function is called from the routine PRCHAAC.
 ;
LIDT(PRCPO) ;This function goes through all the line items on a PO
 ;       to get information on the item with the highest dollar amount.
 ;       If there is a problem with the PO, the function will return
 ;       a zero
 ;
 ;     1         2         3            4             5        6     
 ; PO Number^PO Total^Description^item amount^contract number^FSC
 ; FSC - FEDERAL SUPPLY CLASSIFICATION
 ;
 N AMT,AMT1,CNT,DESC,ITEM,ITEM1,PO,REC,REC1,REC2,TOTAL
 I '$D(^PRC(442,PRCPO,2,0)) QUIT 0     ;No line items
 ;
 ;Get line item with the highest cost
 S AMT="",ITEM1=0
 F  S ITEM1=$O(^PRC(442,PRCPO,2,ITEM1)) Q:'ITEM1  D
 . S REC=$G(^PRC(442,PRCPO,2,ITEM1,2)) ;Get item record
 . QUIT:REC=""
 . S REC=$P(REC,U,1,3)  ;Get the 1st 3 fields
 . S AMT1=+REC          ;Cost of the item
 . I AMT1<AMT QUIT      ;Get the next record
 . S AMT=AMT1
 . S ITEM=ITEM1
 . S REC2=REC           ;Save record with highest dollar amount
 ;
 I 'AMT QUIT 0          ;No dollar amount
 S REC1=^PRC(442,PRCPO,0)
 S PO=$P(REC1,U)                              ;Get PO number
 S TOTAL=$P(REC1,U,15)                        ;Get PO total
 S DESC=^PRC(442,PRCPO,2,ITEM,1,1,0)          ;Get item description
 ; Clean the HL7 message of any '^,~,&,\, or |'.
T I DESC["^"!(DESC["|")!(DESC["~")!(DESC["&")!(DESC["\") S DESC=$$STRIP^XLFSTR(DESC,"^~|&\")
 S PO=PO_"^"_TOTAL_"^"_$E(DESC,1,50)_"^"_REC2 ;Setup return data
 ;
 QUIT PO
