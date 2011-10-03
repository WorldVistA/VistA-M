GECSULOC ;WISC/RFJ-lock system                                      ;01 Nov 93
 ;;2.0;GCS;;MAR 14, 1995
 Q
 ;
 ;
LOCKSYS(GECSSYST) ;  lock generic code sheet system
 ;  gecssyst='SITE'-'SYSTEM ID'-'BATCH or TRANSMIT'
 ;  example: 460-VOL-BATCH
 ;  return entry number for success, 0 if already locked
 ;
 ;  system not found in file, add it
 I '$O(^GECS(2101.6,"B",GECSSYST,0)) D
 .   L +^GECS(2101.6):10 I '$T Q
 .   N D0,DD,DIC,DLAYGO,X,Y
 .   S DIC="^GECS(2101.6,",DIC(0)="L",DLAYGO=2101.6,X=GECSSYST D FILE^DICN
 .   L -^GECS(2101.6)
 S DA=+$O(^GECS(2101.6,"B",GECSSYST,0)) I 'DA W !,"Unable to add system ",GECSSYST," to LOCK file # 2101.6." Q 0
 ;
 L +^GECS(2101.6,DA):30
 ;  success
 I $T D NOW^%DTC S $P(^GECS(2101.6,DA,0),"^",2,4)="^"_DUZ_"^"_% Q DA
 ;
 ;  already locked, show who
 S %=^GECS(2101.6,DA,0),Y=$P(%,"^",4) I Y D DD^%DT
 W !,"SYSTEM ",GECSSYST," IS CURRENTLY LOCKED BY ",$P($G(^VA(200,+$P(%,"^",3),0)),"^")," ON ",Y,"."
 Q 0
 ;
 ;
UNLOCK(DA) ;  unlock generic code sheet system da
 I '$D(^GECS(2101.6,DA,0)) Q
 S $P(^GECS(2101.6,DA,0),"^",2,4)="^^"
 L -^GECS(2101.6,DA)
 Q
