SD376P ;BP-OIFO/esw,swo - POSTINSTALL DRIVER ; 10/27/04 3:39pm
 ;;5.3;Scheduling;**376**;Aug 13, 1993
EN ;manual entry point
 ;ST   :  station number
 ;STR  :  list of stations receiving AA ack's only
 ;STS  :  current station number with comma's concatenated
 I '$$PROD^XUPROD(1) D  Q
 . D BMES^XPDUTL("NOT A PRODUCTION SYSTEM.  POST INIT CANCELLED")
EN1 N ST,STR,STS
 S ST=$P($$SITE^VASITE(),"^",3)
 Q:ST=""
 S STR=","_$P($T(STAT),";;",2)_","
 S STS=","_ST_","
 I STR[STS D EN^SDRPA18,CLEAN Q  ;process stations that received AA ack only then quit
 I ST=674 D EN^SDRPA17(ST),EN^SDRPA18,CLEAN Q
 I ST<529 D EN^SDRPA10(ST),EN^SDRPA18,CLEAN Q 
 I ST<547 D EN^SDRPA11(ST),EN^SDRPA18,CLEAN Q
 I ST<555 D EN^SDRPA12(ST),EN^SDRPA18,CLEAN Q
 I ST<571 D EN^SDRPA13(ST),EN^SDRPA18,CLEAN Q
 I ST<619 D EN^SDRPA14(ST),EN^SDRPA18,CLEAN Q
 I ST<664 D EN^SDRPA15(ST),EN^SDRPA18,CLEAN Q
 D EN^SDRPA16(ST),EN^SDRPA18,CLEAN Q
 Q
PR(SB,SM,ER,SQ) ;process the message number and error code
 ;SB - Batch #
 ;SM - Message #
 ;ER - Error code
 ;SQ - Sequence number
 ;V1 - Run number
 ;V2 - ien in appt multiple
 ;V3 - ien in batch tracking multiple
 ;SM is the batch # found in the "AMSG" xref and corresponds to the message control id
 ;SB is our batch control, use for the 2 node multiples B xref lookups
 N V1,V2,V3
 ;get the run number
 S V1=$O(^SDWL(409.6,"AMSG",SM,SQ,"")) Q:'V1  D
 . ;get the ien in that run
 . S V2=$O(^SDWL(409.6,"AMSG",SM,SQ,V1,"")) Q:'V2  D
 .. ;now get the ien of the batch tracking entry
 .. S V3=$O(^SDWL(409.6,V1,2,"B",SB,"")) Q:'V3  D
 ... ;quit if there is an ack date
 ... I $P($G(^SDWL(409.6,V1,2,V3,0)),"^",4)'="" Q
 ... ;update batch tracking
 ... I ER="" S DA=V3,DA(1)=V1,DIE="^SDWL(409.6,"_V1_",2,",DR=".04///"_$$NOW^XLFDT_";.05///AE" D ^DIE K DIE,DA,DR Q
 ...;
 ...;update error codes
 ... S DA=V2,DA(1)=V1,DIE="^SDWL(409.6,"_V1_",1,"
 ... S DR="7////"_$O(^SCPT(404.472,"B",ER,"")) D ^DIE
 ... I $D(^SDWL(409.6,"AE","Y",V1,V2)) Q
 ... I $D(^SDWL(409.6,"AE","N",V1,V2)) D
 .... S DR="4///Y" D ^DIE K DIE,DA,DR
 Q
CLEAN ;clean up batches previous to current one by checking for "AE",("S" or "R") xref and
 ;deleting if entry in xref exists
 ;RUN  :  run #           (ien of multiple entry)
 ;V1   :  previous run #  (ien of multiple entry)  
 ;V2   :  ien           (ien in multiple)
 N V1,V2,V3,ZNODE
 S V1=9999999 F  S V1=$O(^SDWL(409.6,V1),-1) Q:'V1  D
 .F V3="R","S" S V2=0 F  S V2=$O(^SDWL(409.6,"AE",V3,V1,V2)) Q:'V2  D
 ..S ZNODE=$G(^SDWL(409.6,V1,1,V2,0))
 ..S DIK="^SDWL(409.6,"_V1_",1,"
 ..S DA(1)=V1,DA=V2 D ^DIK K DIK
 Q
 ;listing of all stations that received only AA ack - no rejection
STAT ;;358,405,463,503,516,517,523,538,540,542,552,564,575,583,600,613,632,649,653,656,676,679,687,692,693,757
