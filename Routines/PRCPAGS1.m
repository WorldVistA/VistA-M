PRCPAGS1 ;WISC/RFJ-autogenerate secondary order ; 10/30/06 12:32pm
V ;;5.1;IFCAP;**1,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; PRCPSCHE is a flag passed by the Scheduler
 ; PRCPFBAR is a flag passed by the barcode upload
 ;
START ;  start autogenerating items
 N %,CONV,COST,DESCNSN,EACHONE,ERROR,EXIT,GROUP,GROUPNM
 N INACTIVE,ISSMULT,ITEMDA,ITEMDATA,LASTONE,LEVEL,MINISS,NOWDT,NUMBER
 N ORDER,PRIMDATA,QTY,QTYAVAIL,TEMPLVL,TOTITEMS,TYPE
 N UNITI,UNITR,VENDATA,VENDOR,VENDORNM,X,Y
 D NOW^%DTC S NOWDT=%
 L +^PRCP(445,PRCP("I"),1):5 I '$T D  Q
 . I '$D(PRCPSCHE) D SHOWWHO^PRCPULOC(445,PRCP("I")_"-1",0)
 . I $D(PRCPSCHE) S $P(PRCPSCHE,"^",2)=4
 D ADD^PRCPULOC(445,PRCP("I")_"-1",0,"Autogeneration")
 W !!,"<<< Starting Auto-generation ...",!
 I '$D(PRCPSCHE) S EACHONE=$$INPERCNT^PRCPUX2(+$P($G(^PRCP(445,PRCP("I"),1,0)),"^",4),"*",PRCP("RV1"),PRCP("RV0"))
 S (TOTITEMS,ITEMDA)=0
 F NUMBER=1:1 S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S ITEMDATA=$G(^(ITEMDA,0)) I ITEMDATA'="" D
 . I '$D(PRCPSCHE) S LASTONE=$$SHPERCNT^PRCPUX2(NUMBER,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 . S DESCNSN=$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,16)
 . S:DESCNSN="" DESCNSN=" "
 . S GROUP=+$P(ITEMDATA,"^",21)
 . S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 . I GROUPNM'="" S GROUPNM=$E(GROUPNM,1,20)_"(#"_GROUP_")"
 . S:GROUPNM="" GROUPNM=" "
 . ;  remove temp stock level if greater than date
 . I $P(ITEMDATA,"^",23)>0,NOWDT>$P(ITEMDATA,"^",24) D
 . . D DELTEMP^PRCPAGU1(PRCP("I"),ITEMDA)
 . . S $P(ITEMDATA,"^",23,24)="^"
 . ;  check for 'delete item when inventory 0'
 . I $P(ITEMDATA,"^",26)="Y" D  Q
 . . I $P(ITEMDATA,"^",7)!($P(ITEMDATA,"^",19))!($P(ITEMDATA,"^",27)) Q
 . . S INACTIVE=$P(^PRCP(445,PRCP("I"),0),"^",13)
 . . I INACTIVE D  I EXIT Q
 . . . N X1,X2 ; initialization of X1,X2 added with PRC*5.1*98
 . . . S EXIT=0
 . . . D NOW^%DTC
 . . . S X1=X,X2=-(INACTIVE*30+1)
 . . . D C^%DTC
 . . . I $O(^PRCP(445,PRCP("I"),1,ITEMDA,2,$E(X,1,5)-.1)) S EXIT=1 Q
 . . . I $O(^PRCP(445,PRCP("I"),1,ITEMDA,3,X)) S EXIT=1 Q
 . . I $$ORDCHK^PRCPUITM(ITEMDA,PRCP("I"),"RCE","") D  D ERROR Q
 . . . S ERROR="INACTIVE ITEM ON ORDER - can't delete from inventory point (KWZ)"
 . . S ERROR="DELETING ITEM from inventory point (KWZ)"
 . . D ERROR
 . . D DELITEM^PRCPUITM(PRCP("I"),ITEMDA)
 . ;
 . ;  primary vendor not selected
 . S VENDOR=$P(ITEMDATA,"^",12)
 . I 'VENDOR D  D ERROR Q
 . . S ERROR="MANDATORY OR REQUESTED SOURCE is missing for item"
 . I VENDOR["PRC(440" D  D ERROR Q
 . . S ERROR="MANDATORY OR REQUESTED SOURCE should be a primary distribution point"
 . S VENDOR=+VENDOR
 . I '$D(^TMP($J,"PRCPAG","V",VENDOR)) D  Q
 . . S %=$S('VENDOR:" ",1:$$INVNAME^PRCPUX1(VENDOR))
 . . S:%="" %=" "
 . . S ^TMP($J,"PRCPAG","NOV",%,VENDOR,DESCNSN,ITEMDA)=""
 . I $P(ITEMDATA,"^",26)="Y" D  D ERROR Q
 . . S ERROR="KWZ is set to YES, item not ordered"
 . ;  check normal stock level (O allowed for ODI per PRC*5.1*98)
 . I $P(ITEMDATA,"^",9)=0&($P(ITEMDATA,"^",30)'="Y")!($P(ITEMDATA,"^",9)']"") D  D ERROR Q
 . . S ERROR="NORMAL STOCK LEVEL missing for item"
 . ;  check standard re-order point (no nils, 0 valid with PRC*5.1*1)
 . I $P(ITEMDATA,"^",10)']"" D  D ERROR Q
 . . S ERROR="STANDARD REORDER POINT missing for item"
 . S VENDORNM=$$INVNAME^PRCPUX1(VENDOR)
 . S VENDATA=$$GETVEN^PRCPUVEN(PRCP("I"),ITEMDA,VENDOR_";PRCP(445,",1)
 . I 'VENDATA D  D ERROR Q
 . . S ERROR="Primary '"_VENDORNM_" is NOT a procurement source"
 . S PRIMDATA=$G(^PRCP(445,VENDOR,1,ITEMDA,0))
 . I PRIMDATA="" D  D ERROR Q
 . . S ERROR="Item NOT stored in primary inventory point: "_VENDORNM
 . S UNITI=$$UNIT^PRCPUX1(VENDOR,ITEMDA,"/")
 . S UNITR=$$UNITVAL^PRCPUX1($P(VENDATA,"^",3),$P(VENDATA,"^",2),"/")
 . I UNITI'=UNITR D  D ERROR Q
 . . S ERROR="UNIT/REC: "_UNITR_"  does not equal UNIT/ISS: "_UNITI_" for primary inventory point: "_VENDORNM
 . S CONV=+$P(VENDATA,"^",4) S:CONV<1 CONV=1
 . S COST=$P(PRIMDATA,"^",22)
 . I $P(PRIMDATA,"^",15)>COST S COST=$P(PRIMDATA,"^",15)
 . S MINISS=$P(PRIMDATA,"^",17)
 . S ISSMULT=$P(PRIMDATA,"^",25)
 . D QTYORD^PRCPAGU2
 D CLEAR^PRCPULOC(445,PRCP("I")_"-1",0)
 L -^PRCP(445,PRCP("I"),1)
 ;
 I '$D(PRCPSCHE) D QPERCNT^PRCPUX2(+$G(LASTONE),"*",PRCP("RV1"),PRCP("RV0"))
 W !!,"<<< Finished !"
 D CONT^PRCPAGS2
 Q
 ;
 ;
ERROR ;  set tmp with error message
 S ^TMP($J,"PRCPAG","ER",DESCNSN,ITEMDA)=ERROR Q
