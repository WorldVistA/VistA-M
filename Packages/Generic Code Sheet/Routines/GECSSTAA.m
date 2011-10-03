GECSSTAA ;WISC/RFJ,KLD-stacker file utilities ;24 Nov 93
 ;;2.0;GCS;**4,5,10,12,19,26,27,28**;MAR 14, 1995
 Q
 ;
 ;
ADD(SEGMENT,CONTROL,BATCH,DOCUMENT,DESCRIPT) ;  add entry to stack file
 ;  segment = code sheet segment from file 2101.2
 ;  control = control segment
 ;  batch = batch segment (optional, use "" if not defined)
 ;  document = doc and <tc>1 segments (optional, use "" if not defined)
 ;  descript = 79 character description of event
 ;  return internal entry number
 N %,%H,%I,DA,DATE,DIE,DR,TIME,TRANID,X,GDT
 L +^GECS(2100.1,0)
 S %=^GECS(2100.1,0)
 F DA=$P(%,"^",3)+1:1 Q:'$D(^GECS(2100.1,DA))
 S $P(%,"^",3)=DA,$P(%,"^",4)=$P(%,"^",4)+1,^GECS(2100.1,0)=%
 L -^GECS(2100.1,0)
 ;
 L +^GECS(2100.1,DA)
 S DATE=$P(CONTROL,"^",10),DATE=($E(DATE,1,2)-17)_$E(DATE,3,8)
 S TIME=$P(CONTROL,"^",11)
 S TRANID=$P(CONTROL,"^",6)_"-"_$P(CONTROL,"^",9) I $P(CONTROL,"^",8) S TRANID=TRANID_"-"_$P(CONTROL,"^",8)
 ; NEW ENTRY FOR NOIS
 ;  for transaction class not equal DOC (i.e. VRQ)
 I $P(CONTROL,"^",6)="  " S $P(TRANID,"-")=$E($P(CONTROL,"^",5),1,2)
 ; ORG ENTRY
 S ^GECS(2100.1,DA,0)=TRANID_"^F^^^"_SEGMENT_"^"_$S($P(CONTROL,"^",2)="CFD":"M",1:"A")
 S GDT=DATE_"."_TIME
 S DR="2///^S X=GDT",DIE=2100.1 D ^DIE
 I $L(DESCRIPT) S ^GECS(2100.1,DA,1)=$E(DESCRIPT,1,79)
 S ^GECS(2100.1,"B",TRANID,DA)=""
 S %=$E($P(TRANID,"-",2),4,9) I $L(%) S ^GECS(2100.1,"BID",%,DA)=""
 K ^GECS(2100.1,DA,10)
 D SETCS(DA,CONTROL)
 I $P(CONTROL,"^",8),BATCH'="" D SETCS(DA,BATCH)
 I DOCUMENT'="" D SETCS(DA,DOCUMENT)
 L -^GECS(2100.1,DA)
 Q DA
 ;
 ;
SETCS(DA,DATA)   ;  set data in wp code sheet field
 ;  da = stack internal entry number
 ;  data = code sheet data to store
 ;  dt must be set to standard date prior to call
 I '$D(^GECS(2100.1,DA)) Q
 L +^GECS(2100.1,DA)
 I '$D(^GECS(2100.1,DA,10,0)) S ^(0)="^^0^0^"_DT
 N HOLDDATE,I,X,Y
 F I=$P($G(^GECS(2100.1,DA,10,0)),"^",3)+1:1 Q:'$D(^GECS(2100.1,DA,10,I,0))
 S $P(^GECS(2100.1,DA,10,0),"^",3,4)=I_"^"_I
 S DATA=$TR(DATA,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S ^GECS(2100.1,DA,10,I,0)=DATA
 S $P(^GECS(2100.1,DA,11),"^")=$P($G(^GECS(2100.1,DA,11)),"^")+$L(DATA)
 ;  compute checksum
 S X=$P(^GECS(2100.1,DA,11),"^",2)_DATA X $S($G(^%ZOSF("LPC"))'="":^("LPC"),1:"S Y=""""") S $P(^GECS(2100.1,DA,11),"^",2)=Y
 ;  find hold date
 I $E($P(DATA,"^"),3)=2!($P(DATA,"^")="AT1") S HOLDDATE=$$HOLDDATE^GECSSTTR(DATA) I HOLDDATE S $P(^GECS(2100.1,DA,11),"^",3)=HOLDDATE
 L -^GECS(2100.1,DA)
 Q
 ;
 ;
SETSTAT(DA,STATUS)    ;  mark entry in stack for transmission
 ;  da = stack internal entry number
 ;  status = Queued for tran;        Marked for tran by event
 ;           Transmitted;            Error in transmission
 I "QMTEARF"'[$E(STATUS) Q
 N %,GECSFAUT,DIR
 S %=$G(^GECS(2100.1,DA,0)) I %="" Q
 L +^GECS(2100.1,DA)
 I $P(%,"^",4)'="" K ^GECS(2100.1,"AS",$P(%,"^",4),DA)
 S $P(^GECS(2100.1,DA,0),"^",4)=$E(STATUS)
 I $L(STATUS) S ^GECS(2100.1,"AS",$E(STATUS),DA)=""
 L -^GECS(2100.1,DA)
 I STATUS="M" D
 .   K ^TMP($J,"GECSSTTR")
 .   S GECSFAUT=1
 .   D BUILD^GECSSTTM(DA)
 .   D TRANSMIT^GECSSTTT
 .   K ^TMP($J,"GECSSTTR")
 Q
 ;
 ;
SETKEY(DA,KEY) ;  set the key for document lookup
 I '$D(^GECS(2100.1,DA,0)) Q
 N %,D,D0,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^GECS(2100.1,",DR="8///"_KEY_";"
 ;  if key is null, delete it
 I KEY="" S DR="8///@;"
 D ^DIE
 Q
 ;
 ;
CHEKDUPL(DATA)     ;  called from control input template to check for duplicate
 ;  entry in the stack file.
 ;  data=same as "fms" node in file 2100
 ;      =transcode^transnumber
 N TRANNUMB
 S TRANNUMB=$E($P(DATA,"^",2)_"           ",1,11)
 I $D(^GECS(2100.1,"B",$P(DATA,"^")_"-"_TRANNUMB)) Q 1
 Q 0
 ;
 ;
SELECT(GECSTRAN,GECSSITE,GECSSTAT,GECSSCRN,GECSPROM) ;  select stack entry
 ;  gecstran = optional screen transaction types (delimit using ^)
 ;  gecssite = optional screen for station number
 ;  gecsstat = optional screen for status (delimit using ^)
 ;  gecsscrn = optional additional screen which is executed
 ;  gecsprom = optional prompt
 ;  return internal entry of stack selected ^ document id
 N %,%Y,DDH,DIC,GECSDATA,SCREEN,X,Y
 S DIC="^GECS(2100.1,",DIC(0)="QEAMZ",DIC("A")="Select Stack Document for Retransmission: "
 I $G(GECSPROM)'="" S DIC("A")=GECSPROM
 S SCREEN="S GECSDATA=$G(^GECS(2100.1,+Y,0))"
 I $G(GECSTRAN)'="" S SCREEN=SCREEN_" I GECSTRAN[$E(GECSDATA,1,2)"
 I $G(GECSSITE)'="" S SCREEN=SCREEN_" I $E($P(GECSDATA,""-"",2),1,3)=GECSSITE"
 I $G(GECSSTAT)'="" S SCREEN=SCREEN_" I GECSSTAT[$P(GECSDATA,U,4)"
 I $G(GECSSCRN)'="" S SCREEN=SCREEN_" X GECSSCRN"
 S DIC("S")=SCREEN
 W ! D ^DIC
 Q $S(Y>0:+Y_"^"_$P(Y,"^",2),1:0)
