SDRPA09 ;BP-OIFO/SWO,ESW - rejection utility ; 12/16/03 8:25am [2/19/04 5:24pm]
 ;;5.3;Scheduling;**333**;Aug 13, 199
 ;Rejection processing of all batches from the first run
 ;
 ;
SELECT ;Select Batch Control Id  for the rejection process
 N SDPT,SDAR,DIC,Y,SDBM,SDBS,SDOUT S SDPT=0,SDOUT=1 N % S %=0 F  Q:(%=1!(SDOUT=0))  S DIC="409.6",DIC(0)="QEAMZ",DIC("A")="Select running date:" D ^DIC Q:Y<1  S SDPT=+Y D  Q:SDOUT=0
 .S SDPT=+Y
 .I SDPT>0 W !,"Correct Running Date? " S %=1 D YN^DICN D:(%=1)  Q:Y<1
 ..N DA S DIR(0)="409.7,.01" F  D ^DIR S SDB=+Y Q:'SDB  D 
 ...I $D(^SDWL(409.6,SDPT,2,"B",SDB)) S SDBS=$O(^SDWL(409.6,SDPT,2,"B",SDB,"")) D  Q
 ....I $P(^SDWL(409.6,SDPT,2,SDBS,0),"^",5)'="" W !,"Batch already Acknowledged!" Q
 ....S SDBM=$P(^SDWL(409.6,SDPT,2,SDBS,0),"^",3),SDAR(SDBM)=SDB
 ...I '$D(^SDWL(409.6,SDPT,2,"B",SDB)) W !,"Non existing batch control ID from this run!" Q
 ..I '$O(SDAR("")) W !,"No Batches Selected, OK to quit? " S %=1 D YN^DICN S SDOUT=0 Q
 Q:'$D(SDAR)
QUE W !!,"This job has been tasked"
 N ZTSAVE,IOP S IOP=0 F X="SDPT","SDAR(","IOP" S ZTSAVE(X)=""
 W ! D EN^XUTMDEVQ("STRT^SDRPA09","Whole Batch Rejection Report",.ZTSAVE) S SDOUT=0 Q
 Q
STRT ;Tasked Entry
 N BATCHID0,SDB,V4
 S SDB="" F  S SDB=$O(SDAR(SDB)) Q:SDB=""  S BATCHID0=SDAR(SDB) D AR(SDB) D  D MSG^SDRPA06(BATCHID0,3,SDPT,SDB)
 .S V4=$O(^SDWL(409.6,SDPT,2,"B",BATCHID0,""))
 .S DA=V4,DA(1)=SDPT,DIE="^SDWL(409.6,"_SDPT_",2,",DR=".04///"_$$NOW^XLFDT_";.05///"_"MR"
 .D ^DIE K DIE
 Q
AR(BATCH) ;whole batch rejection
 ;BATCH  :  originating batch number
 ;V1     :  sequence #  (individual message number in batch)
 ;V2     :  run #       (ien of multiple entry)
 ;V3     :  ien         (ien in multiple)
 N DA,DIE,DR,V1,V2,V3,ZNODE
 S V1=0
 F  S V1=$O(^SDWL(409.6,"AMSG",BATCH,V1)) Q:'V1  D
 . S V2=$O(^SDWL(409.6,"AMSG",BATCH,V1,"")) Q:'V2
 . S V3=0 F  S V3=$O(^SDWL(409.6,"AMSG",BATCH,V1,V2,V3)) Q:'V3  D
 .. S ZNODE=$G(^SDWL(409.6,V2,1,V3,0)) Q:ZNODE=""
 .. ;4TH PIECE IS MESSAGE NUMBER
 .. S DA=V3,DA(1)=V2,DIE="^SDWL(409.6,"_V2_",1,"
 .. S DR="7///R" D ^DIE
 .. I $D(^SDWL(409.6,"AE","Y",V2,V3)) Q
 .. I $D(^SDWL(409.6,"AE","N",V2,V3)) D
 ... S DR="4///Y" D ^DIE
 Q
