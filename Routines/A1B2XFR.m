A1B2XFR ;ALB/MIR - SET STATUS TO DON'T SEND IF EDITED ; 14 JAN 91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 ;A1B2TAG - Line tag to call
 ;
 ;   call - PAT for updates to the ODS PATIENT file fields
 ;          REG for updates to the ODS REGISTRATION file fields
 ;          ADM for updates to the ODS ADMISSION or DISPLACED PATIENT
 ;                  file fields
 ;          ADM1 for SPECIALTY update to ODS ADMISSION file
 ;
 ;
 N D0,D1,D2,DIV
 N I,OLD,X,Y
 D ON^A1B2UTL I A1B2ODS D @A1B2TAG
 K A1B2ODS,A1B2TAG Q
 ;
 ;
PAT ; ODS PATIENT
 S X=$O(^A1B2(11500.1,"AD",DA,0)) I '$D(^A1B2(11500.1,+X,0)) Q
 S A1B2Y=11500.1 D UPD
 Q
 ;
 ;
REG ; ODS REGISTRATIONS
 S X=$S($D(^DPT(DA(1),"DIS",DA,"ODS")):+$P(^("ODS"),"^",2),1:"") I 'X Q
 I $D(^A1B2(11500.4,+X,0)) S A1B2Y=11500.4 D UPD
 Q
 ;
 ;
ADM ; ODS ADMISSIONS and DISPLACED PATIENTS
 S X=$S($D(^DGPM(DA,"ODS")):^("ODS"),1:"")
 I '$D(DGPMCA) S DGPMCA=$P(^DGPM(DA,0),"^",14)
 S X1=$S($D(^DGPM(DGPMCA,"ODS")):^("ODS"),1:"")
 I $D(^A1B2(11500.2,+$P(X1,"^",4),0)) S A1B2Y=11500.2,X=$P(X1,"^",4) D UPD Q
 I $D(^A1B2(11500.3,+$P(X,"^",7),0)) S A1B2Y=11500.3,X=$P(X,"^",7) D UPD
 Q
 ;
ADM1 ; ODS ADMISSIONS (for SPECIALTY)
 S X=$S($D(^DGPM(+$P(^DGPM(DA,0),"^",24),"ODS")):$P(^("ODS"),"^",4),1:"")
 I $D(^A1B2(11500.2,+X,0)) S A1B2Y=11500.2 D UPD
 Q
 ;
UPD ; update TRANSMISSION STATUS field to be 0...DON'T SEND, and re x-ref
 ;
 N DA S DA=+X
 S OLD=$S($D(^A1B2(A1B2Y,+X,1)):+^(1),1:0)
 F I=0:0 S I=$O(^DD(A1B2Y,1.01,1,I)) Q:'I  I $D(^(I,0)),(^(0)'["TRIGGER") S X=OLD X ^DD(A1B2Y,1.01,1,I,2) S X=0 X ^DD(A1B2Y,1.01,1,I,1)
 S $P(^A1B2(A1B2Y,+DA,1),"^",1)=0
 Q
