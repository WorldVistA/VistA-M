PSOMGRP3 ;BHAM ISC/JMB - DAILY MANAGEMENT COST REPORT ;3/19/93
 ;;7.0;OUTPATIENT PHARMACY;**14,175**;DEC 1997
EN S (CNT,PG)=0,(T1,T2)="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^" D:ANS="A" PRI I ANS="S" S (S1(DIV),S2(DIV))="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^" D DV
 Q
RPT S PG=PG+1 W:CNT @IOF S CNT=CNT+1 U IO W !!?30,"O U T P A T I E N T   P H A R M A C Y   M A N A G E M E N T   R E P O R T",!?57,"PRESCRIPTION COSTS",?123,"PAGE ",PG
 W !!?40,"FROM "_$E(SDT,4,5)_"-"_$E(SDT,6,7)_"-"_$E(SDT,2,3),?60,"TO "_$E(EDT,4,5)_"-"_$E(EDT,6,7)_"-"_$E(EDT,2,3)_"      "_$S('PRT:"DIVISION: "_$P(^PS(59,DIV,0),"^"),1:"ALL DIVISIONS")
 W !! F K=1:1:10 W $J($P("^AVG^AVG^AVG^AVG COST^AVG^TOT^TOT^TOT^AVG PARTIC","^",K),13)
 W !,"DATE",?13 F K=1:1:9 W $J($P("STAFF^FEE^RX^PER EQ FL^METH^RX^METH^PART PHARM^PHARM RX","^",K),13)
 W ! F K=1:1:131 W "-"
 Q
PRI S T3="0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00",PG=0 F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV  S (S1(DIV),S2(DIV))="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^" D DV
 D TOT^PSOMGR31 Q
DV S (BEG,PRT)=0 D RPT S S3(DIV)="0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00" F PDATE=SDT-1:0 S PDATE=$O(^PS(59.12,PDATE)) D:$Y+6>IOSL RPT D:'PDATE!(PDATE>EDT) SUB Q:'PDATE!(PDATE>EDT)  D
 .S DVMN=DIV_"^"_$E(PDATE,1,5) S:'BEG PRV=DIV_"^"_$E(PDATE,1,5),M1(DVMN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0",M2(DVMN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0",M3(DVMN)="0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00",BEG=1
 .I DVMN'=PRV D MON S PRV=DIV_"^"_$E(PDATE,1,5),M1(DVMN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0",M2(DVMN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0",M3(DVMN)="0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00^0.00"
 .W !,$E(PDATE,4,5)_"-"_$E(PDATE,6,8)_"-"_$E(PDATE,2,3),?13
 .D:$G(^PS(59.12,PDATE,3,DIV,0))'=DIV_"^0^0^0^0^0^0^0^^0^0^0^0^0^0^0^0" LN
 .F K=10,11,12 S $P(M1(DVMN),"^",K)=$P(M1(DVMN),"^",K)+$P($G(^PS(59.12,PDATE,1,DIV,0)),"^",K),$P(S1(DIV),"^",K)=$P(S1(DIV),"^",K)+$P($G(^PS(59.12,PDATE,1,DIV,0)),"^",K),$P(T1,"^",K)=$P(T1,"^",K)+$P($G(^PS(59.12,PDATE,1,DIV,0)),"^",K)
 .F K=3,4,13 S $P(M2(DVMN),"^",K)=$P(M2(DVMN),"^",K)+$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",K),$P(S2(DIV),"^",K)=$P(S2(DIV),"^",K)+$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",K),$P(T2,"^",K)=$P(T2,"^",K)+$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",K)
 I ANS="S" W !!!?17,"FINISHED PRINTING ON: " D NOW^%DTC S Y=% X ^DD("DD") W Y,@IOF
 Q
LN F K=2:1:10 W $J(+$P($G(^PS(59.12,PDATE,3,DIV,0)),"^",K),13)
 F K=4:1:10 S $P(M3(DVMN),"^",K)=$P(M3(DVMN),"^",K)+$P($G(^PS(59.12,PDATE,3,DIV,0)),"^",K),$P(S3(DIV),"^",K)=$P(S3(DIV),"^",K)+$P($G(^PS(59.12,PDATE,3,DIV,0)),"^",K) S:$D(T3) $P(T3,"^",K)=$P(T3,"^",K)+$P($G(^PS(59.12,PDATE,3,DIV,0)),"^",K)
 S AVGST=$P($G(^PS(59.12,PDATE,3,DIV,0)),"^",2)*$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",4),$P(M3(DVMN),"^",2)=$P(M3(DVMN),"^",2)+AVGST,$P(S3(DIV),"^",2)=$P(S3(DIV),"^",2)+AVGST S:$D(T3) $P(T3,"^",2)=$P(T3,"^",2)+AVGST K AVGST
 S AVGFEE=$P($G(^PS(59.12,PDATE,3,DIV,0)),"^",3)*$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",3),$P(M3(DVMN),"^",3)=$P(M3(DVMN),"^",3)+AVGFEE,$P(S3(DIV),"^",3)=$P(S3(DIV),"^",3)+AVGFEE S:$D(T3) $P(T3,"^",3)=$P(T3,"^",3)+AVGFEE K AVGFEE
 Q
MON W !?13 F K=1:1:9 W $J("-------",13)
 W !,"MON TOTAL",?13,$J($FN($S($P(M3(PRV),"^",2)=0!($P(M2(PRV),"^",4)=0):0,1:($P(M3(PRV),"^",2)/$P(M2(PRV),"^",4))),"",2),13)
 W $J($FN($S($P(M2(PRV),"^",3)=0!($P(M3(PRV),"^",3)=0):0,1:$P(M3(PRV),"^",3)/$P(M2(PRV),"^",3)),"",2),13)
 W $J($FN($S($P(M3(PRV),"^",7)=0!($P(M1(PRV),"^",12)=0):0,1:($P(M3(PRV),"^",7)/$P(M1(PRV),"^",12))),"",2),13)
 W $J($FN($S($P(M3(PRV),"^",7)=0!($P(M1(PRV),"^",10)=0):0,1:$P(M3(PRV),"^",7)/$P(M1(PRV),"^",10)),"",2),13),$J($FN($S($P(M3(PRV),"^",8)=0!($P(M1(PRV),"^",11)=0):0,1:$P(M3(PRV),"^",8)/$P(M1(PRV),"^",11)),"",2),13)
 W $J($FN($P(M3(PRV),"^",7),"",2),13),$J($FN($P(M3(PRV),"^",8),"",2),13),$J($FN($P(M3(PRV),"^",9),"",2),13),$J($FN($S($P(M3(PRV),"^",9)=0!($P(M2(PRV),"^",13)=0):0,1:$P(M3(PRV),"^",9)/$P(M2(PRV),"^",13)),"",2),13),!
 Q
SUB I 'PRT D MON W !?13 F K=1:1:9 W $J("=======",13)
 W !,$S('PRT:"DIV TOTAL",1:$E($P(^PS(59,DIV,0),"^"),1,8)),?13,$J($FN($S($P(S2(DIV),"^",4)=0!($P(S3(DIV),"^",2)=0):0,1:$P(S3(DIV),"^",2)/$P(S2(DIV),"^",4)),"",2),13)
 W $J($FN($S($P(S2(DIV),"^",3)=0!($P(S3(DIV),"^",3)=0):0,1:$P(S3(DIV),"^",3)/$P(S2(DIV),"^",3)),"",2),13)
 W $J($FN($S($P(S3(DIV),"^",7)=0!($P(S1(DIV),"^",12)=0):0,1:($P(S3(DIV),"^",7)/$P(S1(DIV),"^",12))),"",2),13)
 W $J($FN($S($P(S3(DIV),"^",7)=0!($P(S1(DIV),"^",10)=0):0,1:$P(S3(DIV),"^",7)/$P(S1(DIV),"^",10)),"",2),13),$J($FN($S($P(S3(DIV),"^",8)=0!($P(S1(DIV),"^",11)=0):0,1:$P(S3(DIV),"^",8)/$P(S1(DIV),"^",11)),"",2),13)
 W $J($FN($P(S3(DIV),"^",7),"",2),13),$J($FN($P(S3(DIV),"^",8),"",2),13),$J($FN($P(S3(DIV),"^",9),"",2),13)
 W $J($FN($S($P(S3(DIV),"^",9)=0!($P(S2(DIV),"^",13)=0):0,1:$P(S3(DIV),"^",9)/$P(S2(DIV),"^",13)),"",2),13)
 Q
