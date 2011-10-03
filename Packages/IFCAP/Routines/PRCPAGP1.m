PRCPAGP1 ;WISC/RFJ-autogenerate primary or whse order ; 10/30/06 12:31pm
V ;;5.1;IFCAP;**1,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
START ;  start autogenerating items
 ; new of X,X1,X2 added with PRC*5.1*98
 N %,CONV,COST,DESCNSN,EACHONE,ERROR,EXIT,G,GROUP,GROUPNM
 N INACTIVE,ISSMULT,ITEMDA,ITEMDATA,LASTONE,LEVEL,MANSRCE,MINISS
 N NOWDT,NUMBER,ORDER,PRCPFLAG,QTY,QTYAVAIL,TEMPLVL,TOTITEMS,TYPE
 N UNITI,UNITR,VENDATA,VENDOR,VENDORNM,WHSEDATA,X,X1,X2
 D NOW^%DTC S NOWDT=%
 L +^PRCP(445,PRCP("I"),1):5 I '$T D SHOWWHO^PRCPULOC(445,PRCP("I")_"-1",0) Q
 D ADD^PRCPULOC(445,PRCP("I")_"-1",0,"Autogeneration")
 W !!,"<<< Starting Auto-generation ...",!
 S EACHONE=$$INPERCNT^PRCPUX2(+$P($G(^PRCP(445,PRCP("I"),1,0)),"^",4),"*",PRCP("RV1"),PRCP("RV0"))
 S (TOTITEMS,ITEMDA)=0
 F NUMBER=1:1 S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S ITEMDATA=$G(^(ITEMDA,0)) I ITEMDATA'="" D
 . S LASTONE=$$SHPERCNT^PRCPUX2(NUMBER,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 . ;  use this for sorting (primary:description, whse:nsn)
 . I PRCP("DPTYPE")="P" D
 . . S DESCNSN=$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,16)
 . . S:DESCNSN="" DESCNSN=" "
 . E  S DESCNSN=$$NSN^PRCPUX1(ITEMDA) I DESCNSN="" D  D ERROR Q
 . . S DESCNSN=" "
 . . S ERROR="NSN is missing for item"
 . ;  remove temp stock level if greater than date
 . I $P(ITEMDATA,"^",23)>0,NOWDT>$P(ITEMDATA,"^",24) D
 . . D DELTEMP^PRCPAGU1(PRCP("I"),ITEMDA)
 . . S $P(ITEMDATA,"^",23,24)="^"
 . ;  check for 'delete item when inventory 0'
 . I $P(ITEMDATA,"^",26)="Y" D  Q
 . . I $P(ITEMDATA,"^",7)!($P(ITEMDATA,"^",19))!($P(ITEMDATA,"^",27)) Q
 . . S INACTIVE=$P(^PRCP(445,PRCP("I"),0),"^",13)
 . . I INACTIVE D  I EXIT Q
 . . . S EXIT=0
 . . . D NOW^%DTC
 . . . S X1=X,X2=-(INACTIVE*30+1)
 . . . D C^%DTC
 . . . I $O(^PRCP(445,PRCP("I"),1,ITEMDA,2,$E(X,1,5)-.1)) S EXIT=1 Q
 . . . I $O(^PRCP(445,PRCP("I"),1,ITEMDA,3,X)) S EXIT=1 Q
 . . I $$ORDCHK^PRCPUITM(ITEMDA,PRCP("I"),"RCE","") D  D ERROR S EXIT=1 Q
 . . . S ERROR="INACTIVE ITEM ON ORDER - can't delete from inventory point (KWZ)"
 . . S ERROR="DELETING ITEM from inventory point (KWZ)" D ERROR
 . . D DELITEM^PRCPUITM(PRCP("I"),ITEMDA)
 . ;  not a purchasable item
 . I '$$PURCHASE^PRCPU441(ITEMDA) Q
 . ;  BOC
 . I $$SUBACCT^PRCPU441(ITEMDA)="" S ERROR="BOC is missing for item" D ERROR Q
 . ;  inactive items
 . I $$INACTIVE^PRCPU441(ITEMDA) D  D ERROR Q
 . . S %=^PRC(441,ITEMDA,3)
 . . S ERROR="INACTIVATED item.  "_$S($P(%,"^",4)<1:"There are NO substitute items",1:"Use item number: "_$P(%,"^",4))
 . ;
 . ;  group not selected
 . S GROUP=+$P(ITEMDATA,"^",21)
 . S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 . I GROUPNM'="" S GROUPNM=$E(GROUPNM,1,20)_" (#"_GROUP_")"
 . S:GROUPNM="" GROUPNM=" "
 . I GROUPNM=" " S ERROR="GROUP CATEGORY missing for item" D ERROR Q
 . I $G(GROUPALL),$D(^TMP($J,"PRCPAG","GN",GROUP)) D  Q
 . . S ^TMP($J,"PRCPAG","NOG",GROUPNM,DESCNSN,ITEMDA)="" Q
 . I '$G(GROUPALL),'$D(^TMP($J,"PRCPAG","GY",GROUP)) D  Q
 . . S ^TMP($J,"PRCPAG","NOG",GROUPNM,DESCNSN,ITEMDA)="" Q
 . ;
 . ;  vendor not selected
 . S MANSRCE=$P(ITEMDATA,"^",12)
 . S VENDOR=+MANSRCE I MANSRCE["PRCP(445" S VENDOR=WHSE
 . S VENDORNM=$P($G(^PRC(440,VENDOR,0)),"^")
 . I VENDORNM="" D  D ERROR Q
 . . S ERROR="MANDATORY OR REQUESTED SOURCE is missing for item"
 . I $G(VENDALL),$D(^TMP($J,"PRCPAG","VN",VENDOR)) D  Q
 . . S ^TMP($J,"PRCPAG","NOV",VENDORNM,VENDOR,DESCNSN,ITEMDA)="" Q
 . I '$G(VENDALL),'$D(^TMP($J,"PRCPAG","VY",VENDOR)) D  Q
 . . S ^TMP($J,"PRCPAG","NOV",VENDORNM,VENDOR,DESCNSN,ITEMDA)="" Q
 . I $P(ITEMDATA,"^",26)="Y" D  D ERROR Q
 . . S ERROR="KWZ is set to YES, item not ordered"
 . ;  check normal stock level (zero allowed for on-demand items - PRC*5.1*98)
 . I $P(ITEMDATA,"^",9)=0&($P(ITEMDATA,"^",30)'="Y")!($P(ITEMDATA,"^",9)']"") D  D ERROR Q
 . . S ERROR="NORMAL STOCK LEVEL missing for item"
 . ;  check standard reorder point (no nils, 0 valid with PRC*5.1*1)
 . I $P(ITEMDATA,"^",10)']"" D  D ERROR Q
 . . S ERROR="STANDARD REORDER POINT missing for item"
 . S VENDATA=$$GETVEN^PRCPUVEN(PRCP("I"),ITEMDA,MANSRCE,1)
 . I 'VENDATA D  D ERROR Q
 . . S ERROR="Vendor '"_VENDORNM_" is NOT a procurement source"
 . ;
 . ;  get vendor data
 . K PRCPFLAG D  I $G(PRCPFLAG) Q
 . . I MANSRCE["PRCP(445" D  Q
 . . . S WHSEDATA=$G(^PRCP(445,+MANSRCE,1,ITEMDA,0))
 . . . I WHSEDATA="" D  Q
 . . . . S ERROR="Item NOT stored in the warehouse inventory point"
 . . . . D ERROR
 . . . . S PRCPFLAG=1 Q
 . . . S UNITI=$$UNIT^PRCPUX1(+MANSRCE,ITEMDA,"/")
 . . . S COST=$P(WHSEDATA,"^",15)
 . . . S:$P(WHSEDATA,"^",22)>COST COST=$P(WHSEDATA,"^",22)
 . . . S MINISS=$P(WHSEDATA,"^",17)
 . . . S ISSMULT=$P(WHSEDATA,"^",25)
 . . S %=$G(^PRC(441,ITEMDA,2,+MANSRCE,0))
 . . S UNITI=$$UNITVAL^PRCPUX1($P(%,"^",8),$P(%,"^",7),"/")
 . . S COST=$P(%,"^",2)
 . . S MINISS=$P(%,"^",12)
 . . S ISSMULT=$P(%,"^",11)
 . S UNITR=$$UNITVAL^PRCPUX1($P(VENDATA,"^",3),$P(VENDATA,"^",2),"/")
 . I UNITI'=UNITR D  D ERROR Q
 . . S ERROR="UNIT/REC: "_UNITR_"  does not equal UNIT/ISS: "_UNITI_" for vendor: "_VENDORNM
 . S CONV=+$P(VENDATA,"^",4) S:CONV<1 CONV=1
 . D QTYORD^PRCPAGU2
 D CLEAR^PRCPULOC(445,PRCP("I")_"-1",0)
 L -^PRCP(445,PRCP("I"),1)
 ;
 D QPERCNT^PRCPUX2(+$G(LASTONE),"*",PRCP("RV1"),PRCP("RV0"))
 W !!,"<<< Finished !"
 D CONT^PRCPAGP2 Q
 ;
 ;
ERROR ;  set tmp with error message
 S ^TMP($J,"PRCPAG","ER",DESCNSN,ITEMDA)=ERROR Q
