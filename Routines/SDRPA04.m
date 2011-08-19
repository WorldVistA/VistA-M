SDRPA04 ;BP-OIFO/ESW - SDRPA00 continuation PAIT - REPAIR  ; 11/2/04 11:47am  ; 5/31/07 5:29pm
 ;;5.3;Scheduling;**376,491**;Aug 13, 1993;Build 53
 ;SD/491 - not to error out while repairing with acks having received
 Q
MSGT(CRUNID,SDPEN,SDFIN,SDTOT,SDSTOP) ;create completion messages
 ;CRUNID - current run number
 ;SDPEN  - pendings
 ;SDFIN  - finals
 ;SDTOT  - total
 ;SDSTOP - task stop flag
 N SDB,SDTRF
 I '$D(SDTOT) S SDTOT=SDPEN+SDFIN
 N SFF S SFF=0
 I +SDTOT=0 S (SDPEN,SDFIN)=0,SFF=1
 I '$D(SDPEN),'$D(SDFIN) S (SDPEN,SDFIN)="undetermined",SFF=1
 N SDB,SDTRF
 S SDB=SDTOT\5000 I SDTOT-(5000*SDB)>0 S SDB=SDB+1 ;# of batches
 N NOW S NOW=$$NOW^XLFDT S SDTRF=$$FMTE^XLFDT(NOW,2),SDTRF=$P(SDTRF,":",1,2)
 N DA,DIE,DR D
 .S DA=CRUNID,DIE=409.6,DR="1.3///"_SDTOT_";1.4///"_SDB_";1.5///"_NOW D ^DIE
 D CLEAN(CRUNID)
 N SDS,SDSTAT,SDIP,SDAR,SDAP,SDMT,SDMS,SD870
 ;SDS - STATION #
 ;SDSTAT - SD-PAIT STATUS
 ;SDAIP  - IP ADDRESS
 ;SDAR   - COMMIT ACK RECEIVED
 ;SDAP   - COMMIT ACK PROCESSED
 ;SDMT   - MESSAGES (BATCHES) TO SEND
 ;SDMS   - MESSAGES (BATCHES) SENT
 S SD870=$O(^HLCS(870,"B","SD-PAIT",""))
 N ARRAY D GETS^DIQ(870,SD870_",","4;5;6;7;8;400.01","I","ARRAY")
 N SD87 S SD87=SD870_","
 S SDSTAT=ARRAY(870,SD87,4,"I")
 S SDAR=ARRAY(870,SD87,5,"I")
 S SDAP=ARRAY(870,SD87,6,"I")
 S SDMS=ARRAY(870,SD87,7,"I")
 S SDMT=ARRAY(870,SD87,8,"I")
 S SDIP=ARRAY(870,SD87,400.01,"I")
 S SDS=$P($$SITE^VASITE(),"^",3)
 ;S SDS=$E($O(^SDWL(409.6,"AMSG","")),1,3)
 N SDBT,STSK,SDSL ; Starting and Last scanned date
 S SDBT=$P(^SDWL(409.6,CRUNID,0),U),SDSL=$P(^SDWL(409.6,CRUNID,0),U,4)
 S STSK=$P(^SDWL(409.6,CRUNID,0),U,2)
 S SDBT=$$FMTE^XLFDT(SDBT,2),SDSL=$$FMTE^XLFDT(SDSL,2)
MSG ;send mail message
 N SDAMX,XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB=$G(SDS)_" - PAIT BACKGROUND JOB"
 S XMY("G.SD-PAIT")=""
 S XMY("S.SD-PAIT-SERVER@FORUM.VA.GOV")=""
 S XMTEXT="SDAMX("
 S DUZ=""
 S XMDUZ="POSTMASTER"
 S SDAMX(1)=""
 S SDAMX(2)="The PAIT job has completed - TASK #: "_STSK_" Log #: "_CRUNID_" on "_SDTRF
 S SDAMX(3)="Started: "_SDBT_"                        Last Scanned: "_SDSL
 S SDAMX(4)="Pending appointments: "_$J(SDPEN,10)
 S SDAMX(5)="Final appointments:   "_$J(SDFIN,10)
 S SDAMX(6)="                       ----------"
 S SDAMX(7)="Total appointments:   "_$J(SDTOT,10)_"   Number of batches: "_SDB
 S SDAMX(8)=""
 S SDAMX(9)="Fac Log Bch Appt #  Date finished  IP Address  Gen  Sent Com R Com P  Status"
 S SDAMX(10)="-----------------------------------------------------------------------"
 S SDAMX(11)=SDS_"|"_$J(CRUNID,3)_"|"_$J(SDB,3)_"|"_$J(SDTOT,7)_"|"_SDTRF_"|"_$J(SDIP,11)_"|"_$J(SDMT,4)_"|"_$J(SDMS,4)_"|"_$J(SDAR,4)_"|"_$J(SDAP,4)_"| "_SDSTAT
 S SDAMX(12)=""
 I $G(SDSTOP) S XMY("VHACIONHD@MED.VA.GOV")="" D  D ^XMD Q
 .S SDAMX(13)="WARNING: TASK STOPPED BY USER, NEEDS TO BE RESTARTED."
 .S SDAMX(14)="Initiate a Remedy ticket TO FOLLOW UP."
 I 'SFF I SDMT>0!(SDB=0) D  D ^XMD K ^TMP("SDDPT",$J) Q
 .I (SDMT-SDMS)=0 D  Q
 ..S SDAMX(13)="SUCCESS: Transmission completed."
 .I (SDMT-SDMS)<SDB!(SDB=1&(SDMT-SDMS)'<SDB)&(SDSTAT'["Shutdown") D  Q
 ..S SDAMX(13)="WARNING: "_(SDMT-SDMS)_" out of "_SDB_" batches still have to be transmitted,"
 ..S SDAMX(14)="please verify with the HL7 System Monitor."
 .S XMY("VHACIONHD@MED.VA.GOV")=""
 .I SDB>0 I (SDMT-SDMS)'<SDB D  Q
 ..S XMY("VHACIONHD@MED.VA.GOV")=""
 ..I SDSTAT["Shutdown" D
 ...S SDAMX(13)="SD-PAIT Logical Link has to be started, initiate Remedy ticket for Scheduling PAIT."
 ..E  S SDAMX(13)="Initiate a Remedy ticket for Interface Engine - communication problem."
 I SFF D  D ^XMD K ^TMP("SDDPT",$J) Q
 .S SDAMX(13)="WARNING!!!: Transmission of run#: "_CRUNID_" has been repaired, you may restart."
 .I SDB>0 I (SDMT-SDMS)'<SDB D
 ..S XMY("VHACIONHD@MED.VA.GOV")=""
 ..I SDSTAT["Shutdown" D  Q
 ...S SDAMX(14)="SD-PAIT Logical Link has to be started, initiate Remedy ticket for Scheduling PAIT."
 ..S SDAMX(14)="Initiate a Remedy ticket for Interface Engine - communication problem."
 Q
CLEAN(CRUNID) ;housekeeping
 ;clean up batches previous to current one by checking for "AE",("S" or "R") xref and
 ;deleting if entry in xref exists
 ;RUN  :  run #           (ien of multiple entry)
 ;V1   :  previous run #  (ien of multiple entry)  
 ;V2   :  ien           (ien in multiple)
 N V1,V2,V3,ZNODE,DIK
 S V1=CRUNID F  S V1=$O(^SDWL(409.6,V1),-1) Q:'V1  D
 .F V3="R","S" S V2=0 F  S V2=$O(^SDWL(409.6,"AE",V3,V1,V2)) Q:'V2  D
 ..S ZNODE=$G(^SDWL(409.6,V1,1,V2,0))
 ..S ^XTMP("SDRPA-"_$P(ZNODE,"^",3),0)=$$HTFM^XLFDT($H+7,1)_U_$$HTFM^XLFDT($H,1)
 ..S DIK="^SDWL(409.6,"_V1_",1,"
 ..S DA(1)=V1,DA=V2 D ^DIK
 ..S ^XTMP("SDRPA-"_$P(ZNODE,"^",3),"CLEAN",+$P(ZNODE,"^",4),0)=ZNODE ;diagnostics
 Q
RPAIT(RUN) ;
 ;RUN - run number - entry ^SDWL(409.6,RUN,0) to be repaired
 Q:+$G(RUN)'>1
 W !,"The repairing in progress...",!
 N SDE,SDEB,SDFE,SDLSD,SDRCNT,ZTSK
 S SDE=$G(^SDWL(409.6,RUN,0)) Q:SDE=""
 S ZTSK=$P(SDE,"^",2) D STAT^%ZTLOAD I ZTSK(1)=1!(ZTSK(1)=2) W !,"Task "_ZTSK_"is still active!" Q
 S SDEB=+$P(SDE,"^",3) ; last batch # submitted to HL7
 S SDRCNT=$O(^SDWL(409.6,RUN,1,999999999),-1) ;last entry
 I SDEB=0 S SDFE=0 S $P(^SDWL(409.6,RUN,0),U,4)=$P(^SDWL(409.6,RUN-1,0),U,4)
 I +SDEB>0 D
 .S SDFE=SDRCNT+1 F  S SDFE=$O(^SDWL(409.6,RUN,1,SDFE),-1) I $P(^SDWL(409.6,RUN,1,SDFE,0),U,3)'>SDEB&($P(^SDWL(409.6,RUN,1,SDFE,0),U,3)'="") Q  ; SD/491
 .N SDLSD1 S SDLSD1=$P(^SDWL(409.6,RUN,1,SDFE,0),U,7) ;retrieve the last used creation date of HL7 created 
 .N SDLSD2 S SDLSD2=$P($G(^SDWL(409.6,RUN,1,SDFE+1,0)),U,7)
 .S SDLSD=$P(SDE,U,4) ; last scanned date
 .I SDLSD="" D
 ..S $P(^SDWL(409.6,RUN,0),U,4)=$S(SDLSD2>SDLSD1:SDLSD1,1:SDLSD1-1)
 .E  S $P(^SDWL(409.6,RUN,0),U,4)=SDLSD-1
 N SDS,DIK F SDS=SDFE+1:1:SDRCNT I $D(^SDWL(409.6,RUN,1,SDS,0)) D EVAL(RUN,SDS) S DIK="^SDWL(409.6,"_RUN_",1,",DA(1)=RUN,DA=SDS D ^DIK
 S SDB=+$P($G(^SDWL(409.6,RUN,2,0)),U,3)
 S NOW=$$NOW^XLFDT,SDFE=5000*SDB
 S $P(^SDWL(409.6,RUN,0),U,5)=SDFE
 S $P(^SDWL(409.6,RUN,0),U,6)=SDB
 S $P(^SDWL(409.6,RUN,0),U,7)=NOW
 D MSGT(RUN,,,SDFE)
 W !!,"The last run number has been repaired, you may ONE TIME QUEUE the next one.",!
 Q
EVAL(RUN,SDS) ;
 ;evaluate if to update any 'S' or 'R' Retention Flags for
 ;the previous entry if exists.
 N SDSTR,DFN,SDDT S SDSTR=^SDWL(409.6,RUN,1,SDS,0)
 S DFN=+SDSTR,SDDT=$P(SDSTR,"^",2)
 Q:SDDT=""
 ;find a prior entry SDRUN
 N SDRUN S SDRUN=$O(^SDWL(409.6,"AC",DFN,SDDT,RUN),-1) Q:SDRUN=""
 N SDSQ S SDSQ=$O(^SDWL(409.6,"AC",DFN,SDDT,SDRUN,""))
 N SDSTRP S SDSTRP=^SDWL(409.6,SDRUN,1,SDSQ,0)
 N SDRET S SDRET=$P(SDSTRP,"^",5)
 I SDRET="S"!(SDRET="R") N DIC D
 .S SDRET="Y",DIC="^SDWL(409.6,"_SDRUN_",1,",DA(1)=SDRUN,DA=SDSQ,DIE=DIC,DR="4///"_SDRET D ^DIE
 Q
