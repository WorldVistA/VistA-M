PRCHPOFX ;;WISC/AKS-Routine to fix Dan's PO conversion ;7/24/00  23:25
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Entry Point to subtract Shipping charges from Subamount1 and Subamt2.
 ;
 N N,BOC1,BOC2,AMT1,AMT2,ENTRY1,ENTRY2,SHIP,N7,BOC,STAT,M,N0
 S N=0 F  S N=$O(^PRC(442,N)) Q:'N  D:$P($G(^(N,0)),"^",19)=2 BOC D
 .S N7=$G(^PRC(442,N,7)),STAT=$P(N7,"^"),STAT="/"_STAT_"/"
 .I "/6/7/10/15/20/25/26/30/31/35/36/40/42/43/45/71/81/82/"'[STAT Q
 .I $P($G(^PRC(442,N,0)),"^",19)=1!($P($G(^(0)),"^",19)=2) Q
 .I $P($P($G(^PRC(442,N,12)),"^",3),".")>2940731 Q
 .I +$P($G(^PRC(442,N,0)),"^",6)>0,+$P(^(0),"^",13)>0,$D(^PRC(442,N,22)) D
 ..S N0=^PRC(442,N,0),BOC1=+$P(N0,"^",6),AMT1=+$P(N0,"^",7)
 ..S BOC2=+$P(N0,"^",8),AMT2=+$P(N0,"^",9),SHIP=+$P(N0,"^",13)
 ..S ENTRY1=$O(^PRC(442,N,22,"B",BOC1,0))
 ..S:BOC2>0 ENTRY2=$O(^PRC(442,N,22,"B",BOC2,0))
 ..I BOC2>0 S SHIP=SHIP/2,SHIP=SHIP*100+.5\1/100
 ..S $P(^PRC(442,N,22,ENTRY1,0),"^",2)=$P(^PRC(442,N,22,ENTRY1,0),"^",2)-SHIP
 ..S:BOC2>0 $P(^PRC(442,N,22,ENTRY2,0),"^",2)=$P(^PRC(442,N,22,ENTRY2,0),"^",2)-SHIP
 QUIT
BOC ;Correct BOC's for Supply Fund Purchase orders
 ;
 S M=0 F  S M=$O(^PRC(442,N,2,M)) Q:'M  I +$P($G(^(M,0)),"^",4)>0 D
 .S BOC=+$P(^PRC(442,N,2,M,0),"^",4)
 .S BOC=$P(^PRCD(420.2,BOC,0),"^"),$P(^PRC(442,N,2,M,0),"^",4)=BOC
 QUIT
