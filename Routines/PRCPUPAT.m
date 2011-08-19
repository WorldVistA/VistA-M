PRCPUPAT ;WISC/RFJ-move item from prim to seco to patient           ;09 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PATIENT(PATDFN,SURGDA) ;  create patient distribution entry for patdfn
 ;  return entry created
 N %,%H,%I,DA,X,Y
 I 'PATDFN Q 0
 D NOW^%DTC
 S DA=$$ADD(%,PATDFN)
 I SURGDA D SURGERY(DA,SURGDA)
 Q DA
 ;
 ;
SURGERY(DA,SURGDA) ;  update distribution with surgery data
 I '$D(^PRCP(446.1,DA,0)) Q
 N %,D0,DI,DIC,DIE,DQ,DR,OPCODE,OPROOM,PRCPSDAT,SURGDATA,SURGEON,SURGSPEC,X,Y
 ;  get surgery data
 D SURGDATA^PRCPCRPL(SURGDA,".01;.011;.02;.04;.14;27")
 I '$D(PRCPSDAT(130,SURGDA,.01,"I")) Q
 ;
 S DR="1///S;2///`"_PRCPSDAT(130,SURGDA,.01,"I")_";"
 ;  operating room
 S OPROOM=+$G(PRCPSDAT(130,SURGDA,.02,"I")) I OPROOM S DR=DR_"130.02///`"_OPROOM_";"
 ;  surgical specialty
 S SURGSPEC=$G(PRCPSDAT(130,SURGDA,.04,"I")) I SURGSPEC S DR=DR_"130.03///`"_SURGSPEC_";"
 ;  inpatient/outpatient
 I $D(PRCPSDAT(130,SURGDA,.011,"E")) S DR=DR_"3///"_PRCPSDAT(130,SURGDA,.011,"E")_";"
 ;  surgeon
 S SURGEON=$G(PRCPSDAT(130,SURGDA,.14,"I")) I SURGEON S DR=DR_"130.04///`"_SURGEON_";"
 ;  principal procedure code
 S OPCODE=$G(PRCPSDAT(130,SURGDA,27,"I")) I OPCODE S DR=DR_"130.01///`"_OPCODE_";"
 ;
 ;  add fields to entry
 L +^PRCP(446.1,DA)
 S (DIC,DIE)="^PRCP(446.1," D ^DIE
 L -^PRCP(446.1,DA)
 Q
 ;
 ;
ADD(DATETIME,PATDFN)      ;  add new entry to patient distribution file
 N %,DA,D0,DD,DI,DIC,DIE,DINUM,DLAYGO,DQ,DR,PRCPPRIV,X,Y
 L +^PRCP(446.1)
 S DIC="^PRCP(446.1,",DIC(0)="L",DIC("DR")="2///`"_PATDFN,DLAYGO=446.1,PRCPPRIV=1,(DINUM,X)=DATETIME
 D FILE^DICN
 L -^PRCP(446.1)
 Q +Y
 ;
 ;
DISTITEM(DATETIME,ITEMDA,QTY,COST) ;  distribute itemda to patient
 ;  qty and cost distributed
 I '$D(^PRCP(446.1,DATETIME,0)) Q
 L +^PRCP(446.1,DATETIME)
 N DATA
 I '$D(^PRCP(446.1,DATETIME,445,ITEMDA,0)) D
 .   I '$D(^PRCP(446.1,DATETIME,445,0)) S ^(0)="^446.11P^^"
 .   N D0,DA,DD,DIC,DLAYGO,X,Y
 .   S DIC="^PRCP(446.1,"_DATETIME_",445,",DIC(0)="L",DLAYGO=446.1,DA(1)=DATETIME,(X,DINUM)=ITEMDA D FILE^DICN
 S DATA=$G(^PRCP(446.1,DATETIME,445,ITEMDA,0)) I DATA="" L -^PRCP(446.1,DATETIME) Q
 S $P(DATA,"^",2)=$P(DATA,"^",2)+QTY
 S $P(DATA,"^",3)=$P(DATA,"^",3)+COST
 S ^PRCP(446.1,DATETIME,445,ITEMDA,0)=DATA
 S $P(^PRCP(446.1,DATETIME,0),"^",5)=$P(^PRCP(446.1,DATETIME,0),"^",5)+COST
 L -^PRCP(446.1,DATETIME)
 Q
 ;
 ;
SELECT() ;  return selected entry
 N %,DIC,PRCPPRIV,X,Y
 S DIC="^PRCP(446.1,",DIC(0)="QEAM",PRCPPRIV=1
 D ^DIC
 Q $S(Y'>0:0,1:+Y)
