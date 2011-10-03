PRCPEGRP ;WISC/RFJ-group categories                                 ;23 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,COUNT,D,D0,DA,DIDEL,PRCPPRIV,DI,DIC,DIE,DLAYGO,DQ,DR,EACHONE,GROUP,ITEMDA,LASTONE,PRCPFLAG,PRCPINPT,TOTAL,X,Y
 S PRCPINPT=PRCP("I")
 F  D  Q:$G(PRCPFLAG)
 .   S DIC="^PRCP(445.6,",DIC("S")="I $P(^(0),U,2)=PRCP(""I"")",DIC(0)="QEALM",DLAYGO=445.6,PRCPPRIV=1 W ! D ^DIC I Y'>0 S PRCPFLAG=1 Q
 .   S DIE="^PRCP(445.6,",DR=".01;2",(GROUP,DA)=+Y,DIDEL=445.6 D ^DIE
 .   I '$D(^PRCP(445.6,GROUP,0)) D
 .   .   W !!,"<<< Removing this group from all items in the inventory point"
 .   .   S EACHONE=$$INPERCNT^PRCPUX2(+$P($G(^PRCP(445,PRCP("I"),1,0)),"^",4),"*",PRCP("RV1"),PRCP("RV0"))
 .   .   S (ITEMDA,TOTAL)=0 F COUNT=1:1 S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) D
 .   .   .   S LASTONE=$$SHPERCNT^PRCPUX2(COUNT,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 .   .   .   I D'="",$P(D,"^",21)=GROUP S $P(^PRCP(445,PRCP("I"),1,ITEMDA,0),"^",21)="",TOTAL=TOTAL+1
 .   .   D QPERCNT^PRCPUX2(+$G(LASTONE),"*",PRCP("RV1"),PRCP("RV0"))
 .   .   W !!?10,"Total items with group category removed: ",TOTAL
 Q
 ;
 ;
GROUP(INVPT,GROUPDA) ;  select group for invpt
 ;  if groupda lookup without asking
 N DIC,X,Y
 S DIC="^PRCP(445.6,",DIC("S")="I $P(^(0),U,2)=INVPT",DIC(0)="QEAM",PRCPPRIV=1
 I $G(GROUPDA)'="" S DIC(0)="M",X=+GROUPDA
 D ^DIC K PRCPPRIV
 Q $S($G(X)["^":-1,Y<0:0,1:+Y)
 ;
 ;
ADDGRP(INVPT,GROUPNM,DESCRIPT) ;  add group name, description for invpt
 N D0,DA,DD,DIC,DLAYGO,DINUM,X,Y
 S DIC="^PRCP(445.6,",DIC(0)="L",DLAYGO=445.6,X=GROUPNM,DIC("DR")="1///"_INVPT_$S(DESCRIPT'="":";2///"_DESCRIPT,1:""),PRCPPRIV=1
 D FILE^DICN K PRCPPRIV
 Q +Y
 ;
 ;
GROUPNM(GROUPDA) ;  return group name for groupda
 I '$D(^PRCP(445.6,+GROUPDA,0)) Q ""
 N %
 S %=^PRCP(445.6,+GROUPDA,0)
 Q $P(%,"^")_": "_$P(%,"^",3)
 ;
 ;
GROUPDA(INVPT,ITEMDA) ;  return group da for invpt and item
 Q $P($G(^PRCP(445,+INVPT,1,+ITEMDA,0)),"^",21)
 ;
 ;
SETGRP(INVPT,ITEMDA,GROUPDA) ;  set group for invpt and item
 I '$D(^PRCP(445,+INVPT,1,+ITEMDA,0)) Q
 I '$D(^PRCP(445.6,+GROUPDA,0)) Q
 S $P(^PRCP(445,+INVPT,1,+ITEMDA,0),"^",21)=GROUPDA
 Q
