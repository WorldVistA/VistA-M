DVBASRP1 ;GT- CAPRI SURGERY CASE LOOKUP ; 5/13/2002
 ;;2.7;AMIE;**42**;Apr 10, 1995
STATUS ; print case status
 I $P($G(^SRF(VAR,30)),"^")'="" D CAN Q
 I $P($G(^SRF(VAR,31)),"^",8)'="" D CAN Q
 I $P($G(^SRF(VAR,.2)),"^",12) S DVBSROP=DVBSROP_"^"_"(COMPLETED)" Q
 I $D(^SRF(VAR,.2)),$P(^(.2),"^",12)="" S DVBSTAT=0 D SCH I DVBSTATS=0 D REQ Q:DVBSTATS  G NO
 I '$D(^SRF(VAR,.2)) S DVBSTAT=0 D SCH I DVBSTATS=0 D REQ Q:DVBSTATS=1  G NO
 Q
NO ; not requested or scheduled
 S DVBSROP=DVBSROP_"^"_"(NOT COMPLETE)"
 Q
CAN ; cancelled or aborted
 S SR(.2)=$G(^SRF(VAR,.2)) I $P(SR(.2),"^")!($P(SR(.2),"^",10)) S DVBSROP=DVBSROP_"^"_"(ABORTED)" Q
 S DVBSROP=DVBSROP_"^"_"(CANCELLED)"
 Q
SCH ; check to see if case is scheduled
 I '$D(^SRF(VAR,31)) S DVBSTATS=0 Q
 I $P($G(^SRF(VAR,31)),"^",4)="" S DVBSTATS=0 Q
 I $P($G(^SRF(VAR,31)),"^",4) D:DVBSTAT=0 TIM0 D:DVBSTAT=1 TIM1 S DVBSTATS=1 Q
 Q
TIM0 I '$D(^SRF(VAR,.2)) S DVBSROP=DVBSROP_"^"_"(SCHEDULED)" Q
 I $P(^SRF(VAR,.2),"^",2) S DVBSROP=DVBSROP_"^"_"(NOT COMPLETE)" Q
 I $P(^SRF(VAR,.2),"^",2)="" S DVBSROP=DVBSROP_"^"_"(SCHEDULED)"
 Q
TIM1 S DVBSROP=DVBSROP_"^"_"(SCHEDULED)" Q
REQ ; check to see if case has been requested
 I $D(^SRF(VAR,"REQ")),$P(^("REQ"),"^")=1,'$D(^SRF(VAR,.2)) S DVBSROP=DVBSROP_"^"_" (REQUESTED)" S DVBSTATS=1 Q
 I $D(^SRF(VAR,"REQ")),$P(^("REQ"),"^")=1,$D(^SRF(VAR,.2)),$P(^(.2),"^",2)="" S DVBSROP=DVBSROP_"^"_"(REQUESTED)" S DVBSTATS=1
 Q
ABORT ; aborted case
 S DVBABORT=0 I $D(^SRF(VAR,.2)),$P(^(.2),"^",10)'="" S DVBABORT=1
 Q
