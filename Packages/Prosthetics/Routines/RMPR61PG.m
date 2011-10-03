RMPR61PG ;OIFO HINES/AA-PURGE 661.2 PROS STOCK ITEM RECORD FILE ;04/16/05
 ;;3.0;PROSTHETICS;**107**;04/16/05
 ;
 ; This routine used to remove records from Global RMPR(661.2
 ; and remove the pointers to RMPR(661.2 from Global 
 ; RMPR(660 field 4.6 to reduce the install time for Patch RMPR*3*61
 ;
 ;
EN ;
 ; Check for installed RMPR*3.0*61 sites ** DO NOT CONTINUE PROCESS
 ; Patch 61 creates global #661.6 
 ;
 I '$D(^RMPR(661.6,0)) D BACKUP D UPDATE G EXIT Q
 Q
 ;
UPDATE ;
 ; Processing for non-installed RMPR*3.0*61 sites ** CONTINE TO PROCESS
 ;
 S RMPRIEN=0,(RMPRDAT,RMPRORDT)=""
 D NOW^%DTC S RMPRYR=X-0020000,RMPRDAT=X
 ;
 ; RMPRYR = used to determine entries 2 years or more prior to
 ; today's date
 ; RMPRIEN = Internal Entry Number for records in RMPR(660
 ; RMPRNODE = Store the one (1) node for the selected record
 ; RMPRPNTR = Pointer to record IEN in Global RMPR(661.2
 ; RMPRREC = Store the zero Node of the RMPR(661.2 Record
 ; RMPRDAT = Record Date used to identify records 2+ years from
 ; today's date.
 ; 
 F  S RMPRIEN=$O(^RMPR(660,RMPRIEN)) G:RMPRIEN'>0 EXIT  D
 .S RMPRNODE=$G(^RMPR(660,RMPRIEN,1)) Q:RMPRNODE=""
 .S RMPRPNTR=$P(RMPRNODE,"^",5) Q:RMPRPNTR=""
 .S RMPRREC=$G(^RMPR(661.2,RMPRPNTR,0)),RMPRDAT=$P(RMPRREC,"^",1) Q:RMPRDAT'>0
 .I RMPRDAT<RMPRYR D
 ..;
 ..S DIK="^RMPR(661.2,",DA=RMPRPNTR D ^DIK
 ..;
 ..; DELETE RECORD IN RMPR(661.2
 ..;
 ..S DR="4.6///@",DIE="^RMPR(660,",DA=RMPRIEN D ^DIE
 ..;
 ..; REMOVE POINTER FROM RMPR(660,FIELD 4.6
 ..;
 ..Q
 .Q
 Q
BACKUP ;
 ; CREATE BACKUP OF GLOBAL ^RMPR(661.2 TO ^XTMP("RMPR6612"
 ; PURGE DATE WILL BE 90 DAYS FOR THE DATE THIS PATCH IS RUN
 ;
 S DA=0
 D NOW^%DTC S RMPRPGDT=X+0000300,RMPRTODT=X
 S ^XTMP("RMPR6612",0)=RMPRPGDT_"^"_RMPRTODT
 F  S DA=$O(^RMPR(661.2,DA)) Q:'DA  D
 .S ^XTMP("RMPR6612",DA,0)=$G(^RMPR(661.2,DA,0))
 .I $D(^RMPR(661.2,DA,1)) S ^XTMP("RMPR6612",DA,1)=$G(^RMPR(661.2,DA,1))
 .Q
 Q
EXIT ;
 Q:+$G(DUZ)'>0
 S RMPRDUZ=$$WHO^RMPREOU(DUZ)
 S XMY(RMPRDUZ)=""
 S XMDUZ=DUZ
 S XMSUB="PATCH RMPR*3.0*107 HAS COMPLETED"
 S RMPRMSG(1)="PATCH RMPR*3.0*107 HAS COMPLETED SUCCESSFULLY"
 S XMTEXT="RMPRMSG("
 D ^XMD
 ; End of Message
 K RMPRIEN,RMPRNODE,RMPRPNTR,RMPRREC,RMPRDAT,RMPRYR,DIE,DIK,DA,DR
 K RMPRDUZ,RMPRMSG,RMPRPGDT,RMPRTODT,RMPRORDT
 Q
