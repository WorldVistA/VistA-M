DVBARPUR ;557/THM-PURGE AMIE FILES ;21 JUL 89
 ;;2.7;AMIE;;Apr 10, 1995
 ;NOTE:  This program was designed to run on the TaskManager.  There is
 ;       no output at all.  It will, however, run real-time, if desired.
 ;
SETUP D NOPARM^DVBAUTL2 G:$D(DVBAQUIT) EXIT ;no parameters set
 I '$D(DT) S X="T" D ^%DT S DT=Y
 ;
PART1 ;for 7131 file--^DVB(396,
 S HIST=$S($P(^DVB(396.1,1,0),U,10)]"":$P(^(0),U,10),1:60) ;IF NOTHING SET, KEEP 60 DAYS
 D DATE
GO S MA="" F I=0:0 S MA=$O(^DVB(396,"F",MA)) Q:MA=""  S MB="" F J=0:0 S MB=$O(^DVB(396,"F",MA,MB)) Q:MB=""  D KILL
 D PART2
 ;
EXIT K DVBAQUIT,NODE,DIK,X,Y,MA,MB,I,J,DA,PDATE,X1,X2,HIST,%,%DT,%H,LOC
 Q
 ;
KILL I '$D(^DVB(396,MB,0)) K ^DVB(396,"F",MA,MB)
 I $D(^DVB(396,MB,0)) DO 
  .S X1=PDATE,X2=MA D ^%DTC I X>0 S DA=MB,DIK="^DVB(396," D ^DIK K DIK,DA
 Q
DATE S X1=DT,X2=HIST,X2=-X2 D C^%DTC S PDATE=X
 Q
PART2 ;for NOTICE OF DISCHARGE file--^DVB(396.2
 S HIST=30 D DATE
 F LOC=0:0 S LOC=$O(^DVB(396.2,"C",LOC)) Q:LOC=""  F NODE=0:0 S NODE=$O(^DVB(396.2,"C",LOC,"P",NODE)) Q:NODE=""  D KILL2
 Q
 ;
KILL2 I '$D(^DVB(396.2,NODE)) K ^DVB(396.2,"C",LOC,"P",NODE) Q
 S X1=PDATE,X2=$P(^DVB(396.2,NODE,0),U,5) D ^%DTC I X>0 S DA=NODE,DIK="^DVB(396.2," D ^DIK K DIK,DA
 Q
