SROSPLG1 ;B'HAM ISC/ADM - STATUS OF SURGICAL CASE ;4/12/94  08:55
 ;;3.0; Surgery ;**28**;24 Jun 93
STATUS ; print case status
 I $P($G(^SRF(SROP,"NON")),"^")="Y" S SROPER=SROPER_$S($P($G(^(30)),"^"):" (ABORTED)",$P($G(^("NON")),"^",5):" (COMPLETED)",1:" (NOT COMPLETE)") Q
 I $P($G(^SRF(SROP,30)),"^")'="" D CAN Q
 I $P($G(^SRF(SROP,31)),"^",8)'="" D CAN Q
 I $P($G(^SRF(SROP,.2)),"^",12) S SROPER=SROPER_" (COMPLETED)" Q
 I $D(^SRF(SROP,.2)),$P(^(.2),"^",12)="" S SRSTAT=0 D SCH I SRSTATUS=0 D REQ Q:SRSTATUS  G NO
 I '$D(^SRF(SROP,.2)) S SRSTAT=0 D SCH I SRSTATUS=0 D REQ Q:SRSTATUS=1  G NO
 Q
NO ; not requested or scheduled
 S SROPER=SROPER_" (NOT COMPLETE)"
 Q
CAN ; cancelled or aborted
 S SR(.2)=$G(^SRF(SROP,.2)) I $P(SR(.2),"^")!($P(SR(.2),"^",10)) S SROPER=SROPER_" (ABORTED)" Q
 S SROPER=SROPER_" (CANCELLED)"
 Q
SCH ; check to see if case is scheduled
 I '$D(^SRF(SROP,31)) S SRSTATUS=0 Q
 I $P($G(^SRF(SROP,31)),"^",4)="" S SRSTATUS=0 Q
 I $P($G(^SRF(SROP,31)),"^",4) D:SRSTAT=0 TIM0 D:SRSTAT=1 TIM1 S SRSTATUS=1 Q
 Q
TIM0 I '$D(^SRF(SROP,.2)) S SROPER=SROPER_" (SCHEDULED)" Q
 I $P(^SRF(SROP,.2),"^",2) S SROPER=SROPER_" (NOT COMPLETE)" Q
 I $P(^SRF(SROP,.2),"^",2)="" S SROPER=SROPER_" (SCHEDULED)"
 Q
TIM1 S SROPER=SROPER_" (SCHEDULED)" Q
REQ ; check to see if case has been requested
 I $D(^SRF(SROP,"REQ")),$P(^("REQ"),"^")=1,'$D(^SRF(SROP,.2)) S SROPER=SROPER_" (REQUESTED)" S SRSTATUS=1 Q
 I $D(^SRF(SROP,"REQ")),$P(^("REQ"),"^")=1,$D(^SRF(SROP,.2)),$P(^(.2),"^",2)="" S SROPER=SROPER_" (REQUESTED)" S SRSTATUS=1
 Q
ABORT ; aborted case
 S SRABORT=0 I $D(^SRF(SROP,.2)),$P(^(.2),"^",10)'="" S SRABORT=1
 Q
