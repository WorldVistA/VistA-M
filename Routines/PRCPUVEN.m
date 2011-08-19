PRCPUVEN ;WISC/RFJ-add,update,delete procurement sources            ;06 Oct 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ADDVEN(INVPT,ITEMDA,VENDOR,UNITREC,PKGMULT,CONVFACT) ;  add procurement source
 ;  vendor=vendorda;prc(440,
 ;  vendor will be added if its not already there.
 ;  data will be updated if not null.
 I '$D(^PRCP(445,INVPT,1,ITEMDA,0)) Q
 N %,DATA,X,Y
 S Y=$O(^PRCP(445,INVPT,1,ITEMDA,5,"B",VENDOR,0))
 I 'Y D
 .   N DA,DIC,D0,DD,DLAYGO,DINUM,X
 .   S:'$D(^PRCP(445,INVPT,1,ITEMDA,5,0)) ^(0)="^445.07IV^^"
 .   S DIC="^PRCP(445,"_INVPT_",1,"_ITEMDA_",5,",X=VENDOR,DA(1)=ITEMDA,DA(2)=INVPT,DIC(0)="L",DLAYGO=445
 .   D FILE^DICN
 I '$D(^PRCP(445,INVPT,1,ITEMDA,5,+Y,0)) Q
 L +^PRCP(445,INVPT,1,ITEMDA,5,+Y)
 S DATA=^PRCP(445,INVPT,1,ITEMDA,5,+Y,0)
 I UNITREC S $P(DATA,"^",2)=UNITREC
 I PKGMULT S $P(DATA,"^",3)=PKGMULT
 I CONVFACT S $P(DATA,"^",4)=CONVFACT
 S ^PRCP(445,INVPT,1,ITEMDA,5,+Y,0)=DATA
 L -^PRCP(445,INVPT,1,ITEMDA,5,+Y)
 Q
 ;
 ;
DELVEN(INVPT,ITEMDA,VENDORDA) ;  delete procurement sources
 ;  vendorda=entryda for procurement source
 I '$D(^PRCP(445,INVPT,1,ITEMDA,5,VENDORDA,0)) Q
 N %,DA,DIC,DIK,X,Y
 S DIK="^PRCP(445,"_INVPT_",1,"_ITEMDA_",5,",DA=VENDORDA,DA(1)=ITEMDA,DA(2)=INVPT
 D ^DIK
 Q
 ;
 ;
GETVEN(INVPT,ITEMDA,VENDOR,CONVFACT) ;  get procurement source data
 ;  vendor=vendor;prcp(445 or vendor;prc(440
 ;  if 'conv factor, convfact=convfact passed
 ;  returns procsource^unitrec^pkgmult^conv^entryda
 S %=+$O(^PRCP(445,INVPT,1,ITEMDA,5,"B",VENDOR,0)),Y=$G(^PRCP(445,INVPT,1,ITEMDA,5,%,0))
 I CONVFACT S:'$P(Y,"^",4) $P(Y,"^",4)=CONVFACT
 I 'Y Q Y
 S $P(Y,"^",5)=%
 Q Y
