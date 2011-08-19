PRCPESTO ;WISC/RFJ-storage locations                                ;23 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,COUNT,D,D0,DA,DIDEL,PRCPPRIV,DI,DIC,DIE,DLAYGO,DQ,DR,EACHONE,ITEMDA,LASTONE,PRCPFLAG,PRCPINPT,STORE,TOTAL,TOTAL1,X,Y
 S PRCPINPT=PRCP("I")
 F  D  Q:$G(PRCPFLAG)
 .   S DIC="^PRCP(445.4,",DIC("S")="I $P(^(0),U,2)=PRCP(""I"")",DIC(0)="QEALM",DLAYGO=445.4,PRCPPRIV=1 W ! D ^DIC I Y'>0 S PRCPFLAG=1 Q
 .   S DIE="^PRCP(445.4,",DR=".01;2",(STORE,DA)=+Y,DIDEL=445.4 D ^DIE
 .   I '$D(^PRCP(445.4,STORE,0)) D
 .   .   W !!,"<<< Removing this storage location from all items in the inventory point"
 .   .   S EACHONE=$$INPERCNT^PRCPUX2(+$P($G(^PRCP(445,PRCP("I"),1,0)),"^",4),"*",PRCP("RV1"),PRCP("RV0"))
 .   .   S (ITEMDA,TOTAL,TOTAL1)=0 F COUNT=1:1 S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) D
 .   .   .   S LASTONE=$$SHPERCNT^PRCPUX2(COUNT,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 .   .   .   I D'="",$P(D,"^",6)=STORE S $P(^PRCP(445,PRCP("I"),1,ITEMDA,0),"^",6)="",TOTAL=TOTAL+1
 .   .   .   I $D(^PRCP(445,PRCP("I"),1,ITEMDA,1,STORE,0)) K ^(0) S %=$P(^PRCP(445,PRCP("I"),1,ITEMDA,1,0),"^",4)-1,TOTAL1=TOTAL1+1 I %'<0 S $P(^(0),"^",4)=%
 .   .   D QPERCNT^PRCPUX2(+$G(LASTONE),"*",PRCP("RV1"),PRCP("RV0"))
 .   .   W !!?10,"Total items with main storage location removed: ",TOTAL
 .   .   W !!?10,"Total items with additional storage location removed: ",TOTAL1
 Q
 ;
 ;
STORELOC(DA) ;  return storage location given entry da
 N Y S Y=$P($G(^PRCP(445.4,+DA,0)),"^") I Y="" S Y="?"
 Q Y
 ;
 ;
STORAGE(INVPT,ITEMDA) ;  return main starage location for invpt and item
 Q $$STORELOC($P($G(^PRCP(445,+INVPT,1,+ITEMDA,0)),"^",6))
 ;
 ;
STORE(INVPT) ;  select storage location for inventory point
 N %,DIC,PRCPPRIV,X,Y
 S DIC="^PRCP(445.4,",DIC("S")="I $P(^(0),U,2)="_INVPT,DIC(0)="QEAM",PRCPPRIV=1
 D ^DIC
 Q $S(Y'>0:0,1:+Y)
