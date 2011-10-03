MPIFAREQ ;BPCIO/CMC-AUTO ACCEPT REQUESTS NOT PROCEESED ; NOV 16, 2000
 ;;1.0; MASTER PATIENT INDEX VISTA ;**11**;30 Apr 99
 ;
 ; If a request goes unprocessed for more than 14 days, it will 
 ; be processed as if auto-accept was enabled.
 ;
 ; This will be a job that will run in the background, nightly
CHK ;
 N IEN,RDT,NODE,X,Y,%,NDT,X1,X2,PAT,REQ
 K ARRAY
 S (REQ,IEN)=0
 D NOW^%DTC
 S NDT=X
 F  S IEN=$O(^MPIF(984.9,"AC",3,IEN)) Q:IEN=""  D
 .S NODE=$G(^MPIF(984.9,IEN,0))
 .S RDT=$P(NODE,"^",3),PAT=$P(NODE,"^",4)
 .S X1=NDT,X2=RDT
 .D ^%DTC
 .I X>14 D
 ..K ARRAY
 ..D OTHERS(PAT,IEN,.ARRAY)
 ..I ARRAY(0)'=0 S REQ=0  F  S REQ=$O(ARRAY(REQ)) Q:REQ=""  D AUTODIS(ARRAY(REQ))
 ..; ^ automatically disapprove any other requests for this patient that are pending
 ..D AUTO^MPIFREQ(IEN)
 ..; ^ auto approve request older than 14 days
 K ARRAY
 Q
 ;
OTHERS(PT,ENT,ARR) ;
 N IEN,CNT
 K ARR
 S IEN="",CNT=0
 F  S IEN=$O(^MPIF(984.9,"C",PT,IEN)) Q:IEN=""  D
 .I IEN'=ENT,$P($G(^MPIF(984.9,IEN,0)),"^",6)=3 D
 ..S CNT=CNT+1
 ..S ARR(IEN)=$P($G(^MPIF(984.9,IEN,0)),"^")
 S ARR(0)=CNT
 Q
 ;
AUTODIS(REQNO) ;
 N DIE,DA,DR,IEN,NOTES
 S DIE="^MPIF(984.9,",IEN=$O(^MPIF(984.9,"B",REQNO,""))
 Q:IEN=""
 S DA=IEN,NOTES="Multiple Request to Change CMOR, Other Request received 1st"
 S DR=".06///5;3.01///Automatic Processing;2.02///TODAY;3.02///"_NOTES
 D ^DIE
 D EN^MPIFRESS(IEN)
 Q
