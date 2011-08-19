PSOMGRP2 ;BHAM ISC/JMB - DAILY MANAGEMENT TYPE OF PRESCRIPTIONS REPORT ; 3/19/93
 ;;7.0;OUTPATIENT PHARMACY;**14**;DEC 1997
EN S (CNT,PG)=0 D:ANS="A" PRI I ANS="S" S S1(DIV)=0 D DV
 Q
RPT ;HEADER
 S PG=PG+1 W:CNT @IOF S CNT=CNT+1 U IO W !!?30,"O U T P A T I E N T   P H A R M A C Y   M A N A G E M E N T   R E P O R T",!?52,"TYPE OF PRESCRIPTIONS FILLED",?124,"PAGE ",PG
 W !!?40,"FROM "_$E(SDT,4,5)_"-"_$E(SDT,6,7)_"-"_$E(SDT,2,3),?60,"TO "_$E(EDT,4,5)_"-"_$E(EDT,6,7)_"-"_$E(EDT,2,3)_"      "_$S('PRT:"DIVISION: "_$P(^PS(59,DIV,0),"^"),1:"ALL DIVISIONS")
 W !! F K=1:1:11 W $J($P("^^^FEE^^^TOT^^^WD^PARTIC","^",K),10)
 W $J("% OF FEE",12),!,"DATE",?10 F K=1:1:10 W $J($P("FEE^STAFF^& STAFF^NEW^REFILL^FILLS^WD^MAIL^& MAIL^PHARM","^",K),10)
 W $J("FL BY VA",12),$J("INVEST",10),! F K=1:1:132 W "-"
 Q
PRI S T1="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^",T2="0^0^0^0^0^0^0^0^0^0^0^0^0^0.0",PG=0 F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV  S S1(DIV)=0 D DV
 D TOT Q
DV S (BEG,PRT)=0 D RPT S S2(DIV)="0^0^0^0^0^0^0^0^0^0^0^0^0^0.0" F PDATE=SDT-1:0 S PDATE=$O(^PS(59.12,PDATE)) D:$Y+6>IOSL RPT D:'PDATE!(PDATE>EDT) SUB Q:'PDATE!(PDATE>EDT)  D
 .S DVMN=DIV_"^"_$E(PDATE,1,5) S:'BEG PRV=DIV_"^"_$E(PDATE,1,5),M1(DVMN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0",M2(DVMN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0",BEG=1
 .I DVMN'=PRV D MON S PRV=DIV_"^"_$E(PDATE,1,5),M1(DVMN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0",M2(DVMN)="0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 .W !,$E(PDATE,4,5)_"-"_$E(PDATE,6,8)_"-"_$E(PDATE,2,3),?10
 .D:$G(^PS(59.12,PDATE,2,DIV,0))'=DIV_"^0^0^0^0^0^0^0^0^0^0^0^0^0^0" LN
 I ANS="S" W !!!?17,"FINISHED PRINTING ON: " D NOW^%DTC S Y=% X ^DD("DD") W Y,@IOF
 Q
LN F K=3,4,5,6,7,8,9,10,11,13,14 W:K<14 $J(+$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",K),10) W:K=14 $J($FN($P($G(^PS(59.12,PDATE,2,DIV,0)),"^",K),"",1),12) D
 .S $P(M2(DVMN),"^",K)=$P(M2(DVMN),"^",K)+$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",K)
 .S $P(S2(DIV),"^",K)=$P(S2(DIV),"^",K)+$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",K) S:$D(T2) $P(T2,"^",K)=$P(T2,"^",K)+$P($G(^PS(59.12,PDATE,2,DIV,0)),"^",K)
 W $J(+$P($G(^PS(59.12,PDATE,1,DIV,0)),"^",17),10) S $P(S1(DIV),"^",17)=$P(S1(DIV),"^",17)+$P($G(^PS(59.12,PDATE,1,DIV,0)),"^",17),$P(M1(DVMN),"^",17)=$P(M1(DVMN),"^",17)+$P($G(^PS(59.12,PDATE,1,DIV,0)),"^",17)
 Q
MON ;PRINT MONTHLY TOTALS
 W !?10 F K=1:1:10 W $J("-------",10)
 W $J("-------",12),$J("-------",10)
 W !,"MON TOTAL",?10 F K=3,4,5,6,7,8,9,10,11,13 W $J($P(M2(PRV),"^",K),10)
 W $J($FN($S($P(M2(PRV),"^",3)=0&($P(M2(PRV),"^",13))=0:0,$P(M2(PRV),"^",3)=0:100,$P(M2(PRV),"^",13)=0:0,1:($P(M2(PRV),"^",3)/($P(M2(PRV),"^",3)+$P(M2(PRV),"^",13)))*100),"",1),12)
 W $J($P(M1(PRV),"^",17),10),!
 Q
SUB ;PRINT SUB TOTALS
 I 'PRT D MON W !?10 F K=1:1:10 W $J("=======",10)
 W:'PRT $J("=======",12),$J("=======",10) W !,$S('PRT:"DIV TOTAL",1:$E($P(^PS(59,DIV,0),"^"),1,8)),?10 F K=3,4,5,6,7,8,9,10,11,13 W $J($P(S2(DIV),"^",K),10)
 W $J($FN($S($P(S2(DIV),"^",3)=0&($P(S2(DIV),"^",13))=0:0,$P(S2(DIV),"^",3)=0:100,$P(S2(DIV),"^",13)=0:0,1:($P(S2(DIV),"^",3)/($P(S2(DIV),"^",3)+$P(S2(DIV),"^",13)))*100),"",1),12)
 W $J($P(S1(DIV),"^",17),10)
 ;W:RUN=2&(ANS="S") @IOF
 Q
TOT ;PRINT GRAND TOTALS
 S PRT=1 D RPT F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV  D SUB
 W !!?10 F K=1:1:10 W $J("=======",10)
 W $J("=======",12),$J("=======",10),!,"GR TOTAL",?10 F K=3,4,5,6,7,8,9,10,11,13 W $J($P(T2,"^",K),10)
 W $J($FN($S($P(T2,"^",3)=0&($P(T2,"^",13)=0):0,$P(T2,"^",3)=0:100,$P(T2,"^",13)=0:0,1:($P(T2,"^",3)/($P(T2,"^",3)+$P(T2,"^",13)))*100),"",1),12)
 W:ANS="A" $J($P(T1,"^",17),10) W:ANS="S" $J($S($P(S1(DIV),"^",17)="":0,1:$P(S1(DIV),"^",17)),10)
 W !!!?17,"FINISHED PRINTING ON: " D NOW^%DTC S Y=% X ^DD("DD") W Y W:RUN'="A" @IOF
 Q
