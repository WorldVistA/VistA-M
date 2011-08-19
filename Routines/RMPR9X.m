RMPR9X  ;HOIFO/HNC - X-REF SUSPENSE FILE ;5/6/03  08:08
 ;;3.0;PROSTHETICS;**59**;Feb 09, 1996
 ;
 Q
EN02 ;Date Closed and number of processing days
 N RMPRDAYS S RMPRCD=""
 S RMPRCD=$P($P(^RMPR(668,DA,0),U,5),".",1)
 N X
 S RMPRDAYS=$$PDAY^RMPREOU(DA)
 S ^RMPR(668,"CD",RMPRCD,RMPRDAYS,DA)=""
 Q
KILL02 ;
 N RMPRDAYS,RMPRCD
 S RMPRCD=$P(X,".",1)
 S RMPRDAYS=$$PDAY^RMPREOU(DA)
 K ^RMPR(668,"CD",RMPRCD,RMPRDAYS,DA)
 Q
EN01 ;L1 x-ref
 I X="" Q
 N L2,L3,M3
 ;L2 last 2 ssn
 ;L3 status
 ;M3 old status
 S DFN=$P($G(^RMPR(668,DA,0)),U,2)
 Q:DFN=""
 D DEM^VADPT
 S L2=$E($P(VADM(2),U,1),8,9)
 S L3=$P($G(^RMPR(668,DA,0)),U,10)
 Q:L3=""
 ;last 2 SSN, status, ien
 S M3=""
 F  S M3=$O(^RMPR(668,"L1",L2,M3)) Q:M3=""  D
 .I $D(^RMPR(668,"L1",L2,M3,DA)) K ^RMPR(668,"L1",L2,M3,DA)
 S ^RMPR(668,"L1",L2,L3,DA)=""
 K VADM
 Q
KILL01 ;kill L1 x-ref
 N L2,L3,M3
 ;L2 last 2 ssn
 ;L3 status
 ;M3 old status
 S DFN=$P($G(^RMPR(668,DA,0)),U,2)
 Q:DFN=""
 D DEM^VADPT
 S L2=$E($P(VADM(2),U,1),8,9)
 S L3=$P($G(^RMPR(668,DA,0)),U,10)
 Q:L3=""
 ;last 2 SSN, status, ien
 S M3=""
 F  S M3=$O(^RMPR(668,"L1",L2,M3)) Q:M3=""  D
 .I $D(^RMPR(668,"L1",L2,M3,DA)) K ^RMPR(668,"L1",L2,M3,DA)
 K VADM
 Q
EN0 ;L x-ref
 I X="" Q
 N L2,L3,L4,M3,M4
 S DFN=$P($G(^RMPR(668,DA,0)),U,2)
 Q:DFN=""
 D DEM^VADPT
 S L2=$E($P(VADM(2),U,1),8,9)
 S L3=$P($G(^RMPR(668,DA,0)),U,10)
 Q:L3=""
 S L4=$P($P(^RMPR(668,DA,0),U,1),".",1)
 ;last 2 SSN, date no time, status, ien
 S M4=0
 F  S M4=$O(^RMPR(668,"L",L2,M4)) Q:M4'>0  D
 .S M3=""
 .F  S M3=$O(^RMPR(668,"L",L2,M4,M3)) Q:M3=""  D
 .  .I $D(^RMPR(668,"L",L2,M4,M3,DA)) K ^RMPR(668,"L",L2,M4,M3,DA)
 S ^RMPR(668,"L",L2,L4,L3,DA)=""
 K VADM
 Q
KILL0 ;
 N L2,L3,M3,M4
 S DFN=$P($G(^RMPR(668,DA,0)),U,2)
 Q:DFN=""
 S L3=$P(^RMPR(668,DA,0),U,10)
 D DEM^VADPT
 S L2=$E($P(VADM(2),U,1),8,9)
 ;unknown status
 S M4=0
 F  S M4=$O(^RMPR(668,"L",L2,M4)) Q:M4'>0  D
 .S M3=""
 .F  S M3=$O(^RMPR(668,"L",L2,M4,M3)) Q:M3=""  D
 .  .I $D(^RMPR(668,"L",L2,M4,M3,DA)) K ^RMPR(668,"L",L2,M4,M3,DA)
 Q
EN      ;Create Entry point
 I X="C" D KILL Q
 I X="X" D KILL Q
 I X="" Q
 N L2
 S DFN=$P($G(^RMPR(668,DA,0)),U,2)
 Q:DFN=""
 D DEM^VADPT
 S L2=$E($P(VADM(2),U,1),8,9)
 S ^RMPR(668,"I",L2,DA)=""
 K VADM
 Q
KILL ;Kill entry point
 N L2
 S DFN=$P($G(^RMPR(668,DA,0)),U,2)
 Q:DFN=""
 D DEM^VADPT
 S L2=$E($P(VADM(2),U,1),8,9)
 K ^RMPR(668,"I",L2,DA)
 Q
EN1 ;
 S WHOZ=$P(^RMPR(669.9,DA(1),5,DA,0),U,1)
 S ^RMPR(669.9,"PA",WHOZ,DA(1))=""
 Q
KILL1 ;
 S WHOZ=$P(^RMPR(669.9,DA(1),5,DA,0),U,1)
 K ^RMPR(669.9,"PA",WHOZ,DA(1))
 Q
EN2 ;PCARD CROSS REFERENCE
 S WHOZ=$P(^RMPR(669.9,DA(1),5,DA,0),U,1)
 S PCRD=$P(^RMPR(669.9,DA(1),5,DA,0),U,5)
 S ^RMPR(669.9,"PCRD",WHOZ,PCRD,DA(1))=""
 Q
KILL2 ;PCARD CROSS REFERENCE
 Q
 ;END
