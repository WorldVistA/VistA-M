PRCPBALM ;WISC/RGY,RFJ-process barcode data                         ;04 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PHYSICAL ;  physical count
 D UPDATE("P") Q
 ;
 ;
USAGE ;  usage
 D UPDATE("U") Q
 ;
 ;
UPDATE(PRCPTYPE) ;  update inventory count
 ;  type P:physical counts, U:usage
 I PRCPTYPE'="P",PRCPTYPE'="U" Q
 I '$D(PRCTID)!'$D(PRCTTI)!'$O(^PRCT(446.4,PRCTID,2,PRCTTI,1,0)) Q
 N PRCPFSCA,PRCTDA,PRCTDA1,PRCTDATA,PRCTDAT1,Y
 S PRCTDA=+PRCTID,PRCTDA1=+PRCTTI
 S PRCTDATA=$G(^PRCT(446.4,PRCTDA,0)) I PRCTDATA="" Q
 S PRCTDAT1=$G(^PRCT(446.4,PRCTDA,2,PRCTDA1,0)) I PRCTDAT1="" Q
 I $E($G(^PRCT(446.4,PRCTDA,2,PRCTDA1,1,1,0)),1,2)'="ID" W !,"    Error: First record not an Identifier record." Q
 S Y=$P(PRCTDAT1,"^") D DD^%DT S $P(PRCTDAT1,"^")=Y
 S $P(PRCTDAT1,"^",2)=$$USER^PRCPUREP(+$P(PRCTDAT1,"^",2))
 L +^PRCT(446.4,PRCTDA,2,PRCTDA1):5 I '$T D SHOWWHO^PRCPULOC(446.4,PRCTDA_"-"_PRCTDA,0) Q
 D ADD^PRCPULOC(446.4,PRCTDA_"-"_PRCTDA1,0,"Upload Barcode Data")
 D EN^VALM("PRCP UPLOAD BARCODE DATA")
 D CLEAR^PRCPULOC(446.4,PRCTDA_"-"_PRCTDA1,0)
 L -^PRCT(446.4,PRCTDA,2,PRCTDA1)
 Q
 ;
 ;
HDR ;  header
 S VALMHDR(1)="UPLOAD PROGRAM: "_$P(PRCTDATA,"^")
 S VALMHDR(2)=$E("   UPLOAD DATE: "_$P(PRCTDAT1,"^")_"    USER: "_$P(PRCTDAT1,"^",2)_"                                            ",1,66)_"* *QUANTITY* *"
 S VALMHDR(3)="LINE  DESCRIPTION                  IM#     NSN           UNIT/IS  ONHAND  UPLOAD"
 Q
 ;
 ;
EXIT ;  exit
 K ^TMP($J,"PRCPBALM"),^TMP($J,"PRCPBALMAG"),^TMP($J,"PRCPBALMD"),^TMP($J,"PRCPBALME"),^TMP($J,"PRCPBALMU"),^TMP($J,"PRCPBAL3")
 Q
 ;
 ;
INIT ;  build array
 D BUILD^PRCPBALB
 Q
