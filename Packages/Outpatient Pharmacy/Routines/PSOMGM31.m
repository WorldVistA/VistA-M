PSOMGM31 ;BHAM ISC/JMB - MONTHLY MANAGEMENT PRESCRIPTION COSTS REPORT CONTD ; 3/19/93
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
SUB ;PRINT SUB TOTALS
 I 'PRT D MON^PSOMGMN3 W !?13 F K=1:1:9 W $J("=======",13)
 W !,$S('PRT:"DIV TOTAL",1:$E($P(^PS(59,DIV,0),"^"),1,8)),?13,$J($FN($S($P(S2(DIV),"^",4)=0!($P(S3(DIV),"^",2)=0):0,1:$P(S3(DIV),"^",2)/$P(S2(DIV),"^",4)),"",2),13)
 W $J($FN($S($P(S2(DIV),"^",3)=0!($P(S3(DIV),"^",3)=0):0,1:$P(S3(DIV),"^",3)/$P(S2(DIV),"^",3)),"",2),13),$J($FN($S($P(S3(DIV),"^",7)=0!($P(S1(DIV),"^",12)=0):0,1:($P(S3(DIV),"^",7)/$P(S1(DIV),"^",12))),"",2),13)
 W $J($FN($S($P(S3(DIV),"^",7)=0!($P(S1(DIV),"^",10)=0):0,1:$P(S3(DIV),"^",7)/$P(S1(DIV),"^",10)),"",2),13),$J($FN($S($P(S3(DIV),"^",8)=0!($P(S1(DIV),"^",11)=0):0,1:$P(S3(DIV),"^",8)/$P(S1(DIV),"^",11)),"",2),13)
 W $J($FN($P(S3(DIV),"^",7),"",2),13),$J($FN($P(S3(DIV),"^",8),"",2),13),$J($FN($P(S3(DIV),"^",9),"",2),13),$J($FN($S($P(S3(DIV),"^",9)=0!($P(S2(DIV),"^",13)=0):0,1:$P(S3(DIV),"^",9)/$P(S2(DIV),"^",13)),"",2),13)
 Q
TOT ;PRINT GRAND TOTALS
 S PRT=1 D RPT^PSOMGMN3 F DIV=0:0 S DIV=$O(^PS(59,DIV)) Q:'DIV  D SUB
 W !?13 F K=1:1:9 W $J("=======",13)
 W !,"GR TOTAL",?13 I ANS="A" W $J($FN($S($P(T2,"^",4)=0!($P(T3,"^",2)=0):0,1:$P(T3,"^",2)/$P(T2,"^",4)),"",2),13) D
 .W $J($FN($S($P(T2,"^",3)=0!($P(T3,"^",3)=0):0,1:$P(T3,"^",3)/$P(T2,"^",3)),"",2),13)
 .W $J($FN($S($P(T3,"^",7)=0!($P(T1,"^",12)=0):0,1:$P(T3,"^",7)/$P(T1,"^",12)),"",2),13)
 .W $J($FN($S($P(T3,"^",7)=0!($P(T1,"^",10)=0):0,1:$P(T3,"^",7)/$P(T1,"^",10)),"",2),13)
 .W $J($FN($S($P(T3,"^",8)=0!($P(T1,"^",11)=0):0,1:$P(T3,"^",8)/$P(T1,"^",11)),"",2),13)
 ;
 E  W $J($FN($S($P(S2(DIV),"^",4)=0!($P(T3,"^",2)=0):0,1:($P(SUBS(DIV),"^",4)*$P(T3,"^",2))/$P(S2(DIV),"^",4)),"",2),13) D
 .W $J($FN($S($P(S2(DIV),"^",3)=0!($P(T3,"^",3)=0):0,1:($P(S2(DIV),"^",3)*$P(T3,"^",3))/$P(S2(DIV),"^",3)),"",2),13)
 .W $J($FN($S($P(T3,"^",7)=0!($P(S1(DIV),"^",12)=0):0,1:$P(T3,"^",7)/$P(S1(DIV),"^",12)),"",2),13)
 .W $J($FN($S($P(T3,"^",7)=0!($P(S1(DIV),"^",10)=0):0,1:$P(T3,"^",7)/$P(S1(DIV),"^",10)),"",2),13)
 .W $J($FN($S($P(T3,"^",8)=0!($P(S1(DIV),"^",11)=0):0,1:$P(T3,"^",8)/$P(S1(DIV),"^",11)),"",2),13)
 W $J($FN($P(T3,"^",7),"",2),13),$J($FN($P(T3,"^",8),"",2),13),$J($FN($P(T3,"^",9),"",2),13)
 I ANS="A" W $J($FN($S($P(T3,"^",9)=0!($P(T2,"^",13)=0):0,1:$P(T3,"^",9)/$P(T2,"^",13)),"",2),13)
 E  W $J($FN($S($P(T3,"^",9)=0!($P(S2(DIV),"^",13)=0):0,1:$P(T3,"^",9)/$P(S2(DIV),"^",13)),"",2),13)
 I QTR W !!,"QUARTER "_QTR_" OUTPATIENT PRESCRIPTION COSTS/PATIENT = $"_$FN($S(QTCST=0!(QTMREQ=0):0,1:QTCST/QTMREQ),"",2)
 E  W !!,"QUARTERLY OUTPATIENT PRESCRIPTION COST/PATIENT NOT AVAILABLE"
 W !!!?17,"FINISHED PRINTING ON: " D NOW^%DTC S Y=% X ^DD("DD") W Y,@IOF
 Q
