PRCAI134 ;WASH-ISC@ALTOONA,PA/LDB-Reset Waived in Full Transactions;1/7/99 11:00 AM
V ;;4.5;Accounts Receivable;**134**;Mar 20, 1995
 ;
EN ;Loop thru waived in full transactions and reset principal amount
 N AMT,BN,DAT,PRIN,TR,TR0,TR4,TR40
 S DAT=0 F  S DAT=$O(^PRCA(433,"AT",10,DAT)) Q:'DAT  D
 .S TR=0 F  S TR=$O(^PRCA(433,"AT",10,DAT,TR)) Q:'TR  D
 ..S TR0=$G(^PRCA(433,+TR,0)) Q:'TR0  S BN=$P(TR0,"^",2) Q:'BN
 ..I '$O(^PRCA(433,"C",BN,TR)) D CHK
 D CHK2
 Q
 ;
CHK ;Check amount in 4 node of 433
 S PRIN=$P($G(^PRCA(430,+BN,7)),"^") Q:'PRIN
 S TR4=0 S TR4=$O(^PRCA(433,+TR,4,TR4)) Q:'TR4
 S TR40=$G(^PRCA(433,+TR,4,TR4,0)) Q:TR40=""
 S AMT=$P(TR40,"^",5) Q:AMT=PRIN
 S $P(^PRCA(433,+TR,4,TR4,0),"^",5)=PRIN
 ;  update the fy current prin balance in 430
 I $D(^PRCA(430,BN,2,TR4,0)) S $P(^PRCA(430,BN,2,TR4,0),"^",2)=PRIN
 Q
 ;
CHK2 ;Loop thru ACTIVE and OPEN RX Co-pay and C Means Test bills to reset current principal
 N BN,BN0,FY,FY2,PRIN,X
 F X=16,23,42 S BN=0 F  S BN=$O(^PRCA(430,"AC",X,BN)) Q:'BN  D
 .S BN0=$G(^PRCA(430,+BN,0)) Q:BN0']""  I ("^23^22^18^")'[("^"_$P(BN0,"^",2)_"^") Q
 .S PRIN=$P($G(^PRCA(430,+BN,7)),"^") Q:'PRIN
 .S FY=$O(^PRCA(430,+BN,2,0)) Q:'FY
 .S FY2=$G(^PRCA(430,+BN,2,FY,0)) Q:FY2']""
 .I $P(^PRCA(430,+BN,2,FY,0),"^",2)'=+PRIN S $P(^PRCA(430,+BN,2,FY,0),"^",2)=+PRIN
 Q
