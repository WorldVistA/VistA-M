DVBAB68 ;ALB/SPH - CAPRI C&P EXAM DETAIL REPORT ;09/11/00
 ;;2.7;AMIE;**35,149**;Apr 10, 1995;Build 16
 ;
EN ;only need DFN to return data
 I '$D(^DVB(396.4,"APE",DFN)) S ZMSG(DVBABCNT)="No Requests are currently on file.",DVBABCNT=DVBABCNT+1 Q
 S ZMSG(DVBABCNT)="Requested exams currently on file:",DVBABCNT=DVBABCNT+1
 D SORT
 S ZMSG(DVBABCNT)="--------------------------------------------------------------------------------",DVBABCNT=DVBABCNT+1
 K DVBAEXM,DVBAEXST,DVBADA,DVBADONE,DVBAPDT,DVBAST,DVBARO,JX,DVBCX
 Q
 ;
STAT S DVBAST=$P(^DVB(396.4,DVBADA,0),U,4)
 S:$D(^DVB(396.4,DVBADA,"TRAN")) DVBCX=$P(^("TRAN"),U,3)
 S DVBAST=$S(DVBAST="C":"Completed",DVBAST="RX":"Cancelled by RO",DVBAST="X":"Cancelled by MAS",DVBAST="F":"Cancelled, failed to report",DVBAST="O":"Open",DVBAST="T":"Transferred",1:"Unknown status")
 Q
 ;
SORT ;  ** Explore 396.4 file; display exams already requested **
 N DVBAEXM,DVBADA,DVBADONE,DVBAPDT,DVBAST,DVBARO,DVBARQDT
 S (DVBAEXM,DVBADA,DVBADONE,DVBAPDT,DVBAST,DVBARO,DVBARQDT)=""
 F  S DVBAEXM=$O(^DVB(396.4,"APE",DFN,DVBAEXM)) Q:DVBAEXM=""!(DVBADONE=1)  F  S DVBARQDT=$O(^DVB(396.4,"APE",DFN,DVBAEXM,DVBARQDT)) Q:DVBARQDT=""  D FLOOP Q:DVBADONE=1
 Q
 ;
FLOOP ;  **  Final loop of "APE" index **
 F  S DVBADA=$O(^DVB(396.4,"APE",DFN,DVBAEXM,DVBARQDT,DVBADA)) Q:DVBADA=""  D BLD Q:DVBADONE=1  D PRINT
 Q
 ;
BLD ;  ** Set variables to be printed to screen **
 N DA,DIK,DATA,DVBAREQ,DVBASTAT,DVBATYPE
 ;don't continue if record doesn't exist in file #396.4
 I '$D(^DVB(396.4,DVBADA,0)) D  Q
 .;kill xref if record doesn't exist
 .K ^DVB(396.4,"APE",DFN,DVBAEXM,DVBARQDT,DVBADA)
 ;don't continue if record doesn't exist in file #396.3
 S DVBAREQ=$P(^DVB(396.4,DVBADA,0),U,2) D  Q:'DVBAREQ
 .I '$D(^DVB(396.3,DVBAREQ)) D
 ..;delete record in file #396.4 if its 'parent' in file #396.3 doesn't exist
 ..;remove reference to file #396.3 so call to ^dik won't error out
 ..S DATA=^DVB(396.4,DVBADA,0),$P(^(0),U,2)=""
 ..;delete "c" xref and mumps xrefs manually because reference to file #396.3 was removed
 ..S DVBATYPE=$P(DATA,U,3),DVBASTAT=$P(DATA,U,4)
 ..K ^DVB(396.4,"C",DVBAREQ,DVBADA)
 ..K ^DVB(396.4,"APE",DFN,DVBAEXM,DVBARQDT,DVBADA)
 ..K ^DVB(396.4,"APS",DFN,DVBATYPE,DVBASTAT,DVBADA)
 ..K ^DVB(396.4,"ARQ"_DVBAREQ,DVBATYPE,DVBADA)
 ..;proceed with fm delete
 ..S DIK="^DVB(396.4,",DA=DVBADA D ^DIK
 ..S DVBAREQ=0
 S Y=DVBARQDT X ^DD("DD") S DVBAPDT=Y
 S DVBARO=$P(^DVB(396.3,DVBAREQ,0),U,3)
 S DVBARO=$S($D(^DIC(4,+DVBARO,0)):$P(^(0),U,1),1:"Unknown RO")
 D STAT
 Q
 ;
PRINT ;  **  Print an entry from list of requested exams **
 S ZMSG(DVBABCNT)=DVBAEXM,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="Requested on "_DVBAPDT_" by "_DVBARO_" - "_DVBAST,DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="",DVBABCNT=DVBABCNT+1
 Q
