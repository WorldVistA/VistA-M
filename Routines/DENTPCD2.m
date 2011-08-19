DENTPCD2 ;ISC2/SAW-PRINT CDR WORKSHEETS CON'T ; 11/16/88  10:29 AM ;
 ;VERSION 1.2
EN4 W @IOF,!,?32,"CDR WORKSHEET IV",!,?29,"EDUCATION DISTRIBUTION",!,?29,"(Trainee Salaries .11)"
 W !!,?6,"Bedsection distribution by Medical, Surgical and Psychiatric Services"
 W !!,?10,"MEDICAL",?38,"SURGICAL",?66,"PSYCHIATRIC" S (M,S,P)=0
 W !!,?8,"01",?13,$J($P(B(1),"^"),4,4),?36,"02",?41,$J($P(B(2),"^"),4,4),?64,"03",?70,$J($P(B(3),"^"),4,4) S M=M+$P(B(1),"^"),S=S+$P(B(2),"^"),P=P+$P(B(3),"^")
 W !,?8,"05",?13,$J($P(B(5),"^"),4,4),?36,15,?41,$J($P(B(15),"^"),4,4),?64,"04",?70,$J($P(B(4),"^"),4,4) S M=M+$P(B(5),"^"),S=S+$P(B(15),"^"),P=P+$P(B(4),"^")
 W !,?8,"06",?13,$J($P(B(6),"^"),4,4),?64,"08",?70,$J($P(B(8),"^"),4,4) S M=M+$P(B(6),"^"),P=P+$P(B(8),"^")
 W !,?8,"07",?13,$J($P(B(5),"^"),4,4),?33,"TOTAL",?41,$J(S,4,4),?64,"09",?70,$J($P(B(9),"^"),4,4) S M=M+$P(B(7),"^"),P=P+$P(B(9),"^")
 W !,?8,10,?13,$J($P(B(10),"^"),4,4) S M=M+$P(B(10),"^")
 W !,?8,11,?13,$J($P(B(11),"^"),4,4),?61,"TOTAL",?70,$J(P,4,4) S M=M+$P(B(10),"^")
 W !,?8,12,?13,$J($P(B(12),"^"),4,4) S M=M+$P(B(12),"^")
 W !,?8,14,?13,$J($P(B(14),"^"),4,4) S M=M+$P(B(14),"^") W !!,?5,"TOTAL",?13,$J(M,4,4)
 W !!,"Medical Proportion (1100.11)    ",$J(M,7,4),?41,"Surgical Proportion (1200.11)  ",$J(S,7,4)
 W !,"Psychiatric Prop. (1300.11)     ",$J(P,7,4),?41,"NHCU Proportion (1400.11)      ",$J($P(B(16),"^"),7,4)
 W !,"DOM Proportion (1500.11)        ",$J($P(B(17),"^"),7,4),?41,"Outpatient Prop. (1800.11)     ",$J(O,7,4)
EN5 W @IOF,!,?32,"CDR WORKSHEET V",!,?29,"EDUCATION DISTRIBUTION",!,?4,"(Instructional .12, Administrative .13, and Continuing Education 6014.00)"
 W !!,?6,"Bedsection distribution by Medical, Surgical and Psychiatric Services"
 W !!,?10,"MEDICAL",?38,"SURGICAL",?66,"PSYCHIATRIC" S (M,S,P)=0
 W !!,?8,"01",?13,$J($P(B(1),"^",3),4,4),?36,"02",?41,$J($P(B(2),"^",3),4,4),?64,"03",?70,$J($P(B(3),"^",3),4,4) S M=M+$P(B(1),"^",3),S=S+$P(B(2),"^",3),P=P+$P(B(3),"^",3)
 W !,?8,"05",?13,$J($P(B(5),"^",3),4,4),?36,15,?41,$J($P(B(15),"^",3),4,4),?64,"04",?70,$J($P(B(4),"^",3),4,4) S M=M+$P(B(5),"^",3),S=S+$P(B(15),"^",3),P=P+$P(B(4),"^",3)
 W !,?8,"06",?13,$J($P(B(6),"^",3),4,4),?64,"08",?70,$J($P(B(8),"^",3),4,4) S M=M+$P(B(6),"^",3),P=P+$P(B(8),"^",3)
 W !,?8,"07",?13,$J($P(B(5),"^",3),4,4),?33,"TOTAL",?41,$J(S,4,4),?64,"09",?70,$J($P(B(9),"^",3),4,4) S M=M+$P(B(7),"^",3),P=P+$P(B(9),"^",3)
 W !,?8,10,?13,$J($P(B(10),"^",3),4,4) S M=M+$P(B(10),"^",3)
 W !,?8,11,?13,$J($P(B(11),"^",3),4,4),?61,"TOTAL",?70,$J(P,4,4) S M=M+$P(B(10),"^",3)
 W !,?8,12,?13,$J($P(B(12),"^",3),4,4) S M=M+$P(B(12),"^",3)
 W !,?8,14,?13,$J($P(B(14),"^",3),4,4) S M=M+$P(B(14),"^",3) W !!,?5,"TOTAL",?13,$J(M,4,4)
 W ! S C=0 F I=1:1:6 S X=$P("Medical^Surgical^Psychiatric^NHCU^Domiciliary^Outpatient","^",I),Y=$S(I=1:M,I=2:S,I=3:P,I=4:B(16),I=5:B(17),1:B(18)) D T
 W !!,"Total Continuing Education Proportion (6014.00)",?50,$J(C,4,4)
 K B,C,E,F,I,M,O,P,P1,P2,P3,R,S,X,Y Q
T W !,X," Proportion "_$S(I'=6:1_I_"00.12)",1:"2800.12)"),?35,$J(Y*P1,4,4)
 W !,X," Proportion "_$S(I'=6:1_I_"00.13)",1:"2800.13)"),?35,$J(Y*P2,4,4)
 W !,X," Proportion (6014.00)",?35,$J(Y*.05,4,4),! S C=C+$J(Y*P3,4,4) Q
