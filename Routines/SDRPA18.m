SDRPA18 ;BP-OIFO/ESW,SWO - UTILITY ; 10/31/04 6:05pm
 ;;5.3;Scheduling;**376**;Aug 13, 1993
EN ;Check the 1st and 2nd run for missing ACK's
 ;BTRAK  :  ien of batch tracking entry
 ;V1     :  ien of run
 ;ZNODE  :  zero node of batch tracking entry
 N BTRAK,DA,DIK,RUN,V1,V2,V3,ZNODE
 S V1=0 F  S V1=$O(^SDWL(409.6,V1)) Q:V1'>0  Q:+$G(^SDWL(409.6,V1,0))>3040514  D
 . S BTRAK=0 F  S BTRAK=$O(^SDWL(409.6,V1,2,BTRAK)) Q:'BTRAK  D
 .. S ZNODE=$G(^SDWL(409.6,V1,2,BTRAK,0)) Q:ZNODE=""
 .. I $P(ZNODE,"^",4)=""!($P(ZNODE,"^",5)="") D UPD(V1,BTRAK)
 .;check the "AE" xref for this run
 .F V2="S","N","R" S V3=0 I $D(^SDWL(409.6,"AE",V2,V1)) F  S V3=$O(^SDWL(409.6,"AE",V2,V1,V3)) Q:'V3  D
 .. S DIK="^SDWL(409.6,"_V1_",1," S DA=V3,DA(1)=V1 D ^DIK
 Q
UPD(V1,V2) ;update the missed ACK as AA
 ;V1  :  ien of run
 ;V2  :  ien of batch tracking multiple
 N DA,DIE,DR
 S DA=V2,DA(1)=V1,DIE="^SDWL(409.6,"_V1_",2,"
 S DR=".04///"_$$NOW^XLFDT_";.05///AA"
 D ^DIE K DIE
 Q
