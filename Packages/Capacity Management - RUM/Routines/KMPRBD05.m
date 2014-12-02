KMPRBD05 ;OAK/RAK - RUM Data Compression for Test Lab ;1/30/13  08:30
 ;;2.0;CAPACITY MANAGEMENT - RUM;**2**;May 28, 2003;Build 12
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
 N CNT,DATA,FMHDATE,HDATE,HR,I,JOB,LAB,MINUTES,NODE,OPTION,QUIET
 ;
 K ^TMP($J)
 ;
 ; make sure DT is defined.
 S:'$G(DT) DT=$$DT^XLFDT
 ;
 ; if not queued output dots
 S QUIET=$D(ZTQUEUED)
 W:'QUIET !,"Compiling stats..."
 ;
 K ^KMPTMP("KMPR-TESTLAB"),^TMP($J)
 S NODE=""
 F  S NODE=$O(^KMPTMP("KMPR","DLY",NODE)) Q:NODE=""  D 
 .S HDATE=""
 .F  S HDATE=$O(^KMPTMP("KMPR","DLY",NODE,HDATE)) Q:HDATE=""!(HDATE'<KMPRTDAY)  D 
 ..;
 ..S FMHDATE=+$$HTFM^XLFDT(HDATE,1)
 ..;
 ..S HR=""
 ..F  S HR=$O(^KMPTMP("KMPR","DLY",NODE,HDATE,HR)) Q:HR=""  D 
 ...S OPTION=""
 ...F  S OPTION=$O(^KMPTMP("KMPR","DLY",NODE,HDATE,HR,OPTION)) Q:OPTION=""  D 
 ....S JOB=0
 ....F  S JOB=$O(^KMPTMP("KMPR","DLY",NODE,HDATE,HR,OPTION,JOB)) Q:'JOB  D 
 .....;
 .....S DATA=^KMPTMP("KMPR","DLY",NODE,HDATE,HR,OPTION,JOB)
 .....S MINUTES=$P(DATA,U,10,999)
 .....;
 .....S LAB=""
 .....; if current data is negative
 .....I $P(LAB,U,5)<0 D 
 ......S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"C"),U,5)=$P(LAB,U,5)
 .....;
 .....; if new data is negative
 .....I ($P(DATA,U,5)<0) D 
 ......S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"N"),U,5)=$P(DATA,U,5)
 .....;
 .....; if sum of pieces are negative
 .....I ($P(LAB,U,5)+$P(DATA,U,5))<0 D 
 ......S $P(^KMPTMP("KMPR","NEG","DLY",OPTION,"T"),U,5)=($P(LAB,U,5))_"+"_($P(DATA,U,5))_"="_($P(LAB,U,5)+$P(DATA,U,5))
 .....;
 .....; accumulate totals
 .....; data elements - pieces 1 - 8
 .....F I=1:1:8 S $P(LAB,U,I)=$P($G(LAB),U,I)+$P(DATA,U,I)
 .....;
 .....; CNT(1) = minutes  0 = 29
 .....; CNT(2) = minutes 30 = 59
 .....F I=1:1:30 S $P(CNT(1),U,I)=$P(MINUTES,U,I)
 .....F I=31:1:60 S $P(CNT(2),U,(I-30))=$P(MINUTES,U,I)
 .....;
 .....S ^TMP($J,HDATE,NODE,OPTION,HR)=LAB
 .....F I=1:1:30 S $P(^TMP($J,HDATE,NODE,OPTION,HR,1),U,I)=$P($G(^TMP($J,HDATE,NODE,OPTION,HR,1)),U,I)+$P(CNT(1),U,I)
 .....F I=1:1:30 S $P(^TMP($J,HDATE,NODE,OPTION,HR,2),U,I)=$P($G(^TMP($J,HDATE,NODE,OPTION,HR,2)),U,I)+$P(CNT(2),U,I)
 .....; remove data from array
 .....K ^KMPTMP("KMPR","DLY",NODE,HDATE,HR,OPTION,JOB)
 .....W:'QUIET "."
 ;
 ;
 ; compile into daily stats
 S HDATE=0
 F  S HDATE=$O(^TMP($J,HDATE)) Q:'HDATE  S NODE="" D 
 .S FMHDATE=$$HTFM^XLFDT(HDATE) Q:'FMHDATE
 .F  S NODE=$O(^TMP($J,HDATE,NODE)) Q:NODE=""  S OPTION="" D 
 ..F  S OPTION=$O(^TMP($J,HDATE,NODE,OPTION)) Q:OPTION=""  S HR=0 D 
 ...F  S HR=$O(^TMP($J,HDATE,NODE,OPTION,HR)) Q:'HR  D 
 ....S ^KMPTMP("KMPR-TESTLAB",FMHDATE,NODE,OPTION)=FMHDATE_"^^"_NODE_"^"_$P(OPTION,"***")_"^"_$P(OPTION,"***",2)_"^"_$$RUMDESIG^KMPRBD03(OPTION)
 ....S ^KMPTMP("KMPR-TESTLAB",FMHDATE,NODE,OPTION,HR,1)=$G(^TMP($J,HDATE,NODE,OPTION,HR,1))
 ....S ^KMPTMP("KMPR-TESTLAB",FMHDATE,NODE,OPTION,HR,2)=$G(^TMP($J,HDATE,NODE,OPTION,HR,2))
 ....W:'QUIET "."
 ;
 K ^TMP($J)
 ;
 W:'QUIET " done!"
 ;
 Q
