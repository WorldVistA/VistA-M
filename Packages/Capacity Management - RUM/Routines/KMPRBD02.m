KMPRBD02 ;OAK/RAK - RUM Data Compression ;5/28/03  08:36
 ;;2.0;CAPACITY MANAGEMENT - RUM;;May 28, 2003
 ;
 ; Background Driver (cont.)
 ;
DAILY(KMPRTDAY) ;-- daily data compression and storage
 ;----------------------------------------------------------------------
 ; KMPRTDAY.. Day in $H format (+$H).  This represents the
 ;            ending point for compression.  Only dates LESS than
 ;            KMPRTDAY will be compressed.
 ;
 ; At midnight compress hourly info into daily stats. Daily stats are
 ; stored in file #8971.1.  Hourly data is killed.
 ;----------------------------------------------------------------------
 ;
 Q:'$G(KMPRTDAY)
 ;
 N COUNT,CNT,CNT1,CNT2,DATA,FMHDATE,HDATE,HTIME,I,JOB,MESSAGE
 N NODE,NW,OKAY,OPTION,NP,PT,PTM,X,VAR,USERS,USRDATA,WD,WORKDAY,YSTRDAY
 ;
 K ^TMP($J)
 ;
 ; make sure DT is defined.
 S:'$G(DT) DT=$$DT^XLFDT
 ;
 ; yesterday - this will be the data that is compiled and stored
 S YSTRDAY=$$HADD^XLFDT(KMPRTDAY,-1)
 ;
 S NODE=""
 F  S NODE=$O(^KMPTMP("KMPR","DLY",NODE)) Q:NODE=""  D
 .S HDATE=""
 .F  S HDATE=$O(^KMPTMP("KMPR","DLY",NODE,HDATE)) Q:HDATE=""!(HDATE'<KMPRTDAY)  D 
 ..; if less than 'yesterday' kill - old data
 ..I HDATE<YSTRDAY K ^KMPTMP("KMPR","DLY",NODE,HDATE) Q
 ..;
 ..S FMHDATE=+$$HTFM^XLFDT(HDATE,1)
 ..;
 ..; WORKDAY = 0 : weekend or holiday (non-workday)
 ..;         = 1 : workday
 ..;
 ..S WORKDAY=$$WORKDAY^XUWORKDY(FMHDATE)
 ..;
 ..S OPTION=""
 ..F  S OPTION=$O(^KMPTMP("KMPR","DLY",NODE,HDATE,OPTION)) Q:OPTION=""  D 
 ...K NP,PT
 ...S JOB=0,COUNT=""
 ...F  S JOB=$O(^KMPTMP("KMPR","DLY",NODE,HDATE,OPTION,JOB)) Q:'JOB  D 
 ....S PTM=""
 ....F  S PTM=$O(^KMPTMP("KMPR","DLY",NODE,HDATE,OPTION,JOB,PTM)) Q:PTM=""  D 
 .....; PTM:  non-prime time = 0   prime time = 1
 .....S DATA=^KMPTMP("KMPR","DLY",NODE,HDATE,OPTION,JOB,PTM)
 .....;
 .....; prime time or non-prime time
 .....S VAR=$S((WORKDAY&PTM):"PT",1:"NP") Q:VAR=""
 .....;
 .....; if current data is negative
 .....I $P($G(@VAR@(0)),U,5)<0 D 
 ......S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"C"),U,5)=$P(@VAR,U,5)
 .....;
 .....; if new data is negative
 .....I ($P(DATA,U,5)<0) D 
 ......S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"N"),U,5)=$P(DATA,U,5)
 .....;
 .....; if sum of pieces are negative
 .....I ($P($G(@VAR@(0)),U,5)+$P(DATA,U,5))<0 D 
 ......S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"T"),U,5)=($P(@VAR,U,5))_"+"_($P(DATA,U,5))_"="_($P(@VAR,U,5)+$P(DATA,U,5))
 .....;
 .....; accumulate totals
 .....; data elements - pieces 1 - 8
 .....F I=1:1:8 S $P(@VAR@(1),U,I)=$P($G(@VAR@(1)),U,I)+$P(DATA,U,I)
 .....;
 .....S USERS=$G(^TMP($J,HDATE,NODE,JOB)),USRDATA=0
 .....;
 .....; hour counts - pieces 10 - 33 - offset by -9
 .....; hour 0 = piece 10
 .....; hour 1 = piece 11
 .....; hour 2 = piece 12 ...
 .....F I=10:1:33 S CNT=$P(DATA,U,I) I +CNT D
 ......S CNT1=$P(CNT,"~"),CNT2=$P(CNT,"~",2)
 ......;
 ......; set for every hour that this particular $job ran
 ......I +CNT2 S $P(USERS,U,(I-9))=$P(USERS,U,(I-9))+1,USRDATA=1
 ......;
 ......; if workday capture workday counts
 ......I WORKDAY D
 .......; number of occurrences per hour
 .......S $P(PT(1.1),U,(I-9))=$P($G(PT(1.1)),U,(I-9))+CNT1
 .......; number of users for this particular option/protocol/rpc
 .......S $P(PT(1.2),U,(I-9))=$P($G(PT(1.2)),U,(I-9))+1
 ......;
 ......; else capture non-workday (weekend/holiday) counts
 ......E  D
 .......; number of occurrences per hour
 .......S $P(NP(1.1),U,(I-9))=$P($G(NP(1.1)),U,(I-9))+CNT1
 .......; number of users for this particular option/protocol/rpc
 .......S $P(NP(1.2),U,(I-9))=$P($G(NP(1.2)),U,(I-9))+1
 .....;
 .....; will have every hour that this particular $job ran
 .....I USRDATA S ^TMP($J,HDATE,NODE,JOB)=USERS
 .....;
 .....; piece 1 non-prime time - piece 2 prime time
 .....S $P(COUNT,U,(PTM+1))=$P(COUNT,U,(PTM+1))+1
 .....;
 .....; remove data from array
 .....K ^KMPTMP("KMPR","DLY",NODE,HDATE,OPTION,JOB,PTM)
 ...;
 ...; back to OPTION level
 ...; file data into file #8971.1
 ...D FILE^KMPRBD03(HDATE,NODE,OPTION,.PT,.NP,$P(COUNT,U,2),$P(COUNT,U),.OKAY,.MESSAGE)
 ...;
 ...; if not filed successfully set into 'ERR' node.
 ...I 'OKAY D 
 ....S ^KMPTMP("KMPR","ERR",HDATE,NODE,OPTION,0)=NP_$P(COUNT,U)
 ....S ^KMPTMP("KMPR","ERR",HDATE,NODE,OPTION,1)=PT_$P(COUNT,U,2)
 ....F I=0:0 S I=$O(MESSAGE(I)) Q:'I  D 
 .....S ^KMPTMP("KMPR","ERR",HDATE,NODE,OPTION,"MSG",I)=MESSAGE(I)
 ;
 ; find the total number of jobs that ran first minute of every hour
 S HDATE=""
 F  S HDATE=$O(^TMP($J,HDATE)) Q:HDATE=""!(HDATE'<KMPRTDAY)  D
 .;
 .S FMHDATE=+$$HTFM^XLFDT(HDATE,1)
 .S WORKDAY=$$WORKDAY^XUWORKDY(FMHDATE)
 .;
 .;        WD: workday     NW: non-workday
 .S VAR=$S(WORKDAY:"WD",1:"NW")
 .S NODE=""
 .F  S NODE=$O(^TMP($J,HDATE,NODE)) Q:NODE=""  D
 ..K NW,WD
 ..S JOB=""
 ..F  S JOB=$O(^TMP($J,HDATE,NODE,JOB)) Q:'JOB  D
 ...S DATA=^TMP($J,HDATE,NODE,JOB)
 ...F I=1:1:24 S CNT=$P(DATA,U,I) I +CNT D
 ....S $P(@VAR@(1.1),U,I)=$P($G(@VAR@(1.1)),U,I)+CNT
 ....S $P(@VAR@(1.2),U,I)=$P($G(@VAR@(1.2)),U,I)+1
 ..;
 ..; file number of users information
 ..D FILE^KMPRBD03(HDATE,NODE,"#USERS#",.WD,.NW)
 ;
 K ^TMP($J)
 ;
 Q
