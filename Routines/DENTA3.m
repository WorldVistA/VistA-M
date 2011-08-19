DENTA3 ;ISC2/SAW-CLASS I-VI SERVICE REPORT OPTION ; 10/27/88  10:09 AM ;
 ;VERSION 1.2
 S Y(0)=DENTY0,Z1="CLASS I TO VI (TYPE 3) REPORT FOR "_Z1,Z3="STATION NUMBER: "_DENTSTA,(T(1),T(2),T(3))=""
 W @IOF,?(80-$L(Z1)/2),Z1,!,?(80-$L(Z3)/2),Z3
 W !!,?15,"TREATMENT",?32,"TREATMENT CASES",?53,"TREATMENT CASES"
 W !,?12,"CASES AUTHORIZED",?31,"PENDING INITIATION",?52,"PENDING COMPLETION"
 W !,"CLASS I",?18,$J($P(Y(0),U,2),3) S T(1)=T(1)+$P(Y(0),U,2) W ?38,$J($P(Y(0),U,3),3) S T(2)=T(2)+$P(Y(0),U,3) W ?59,$J($P(Y(0),U,4),3) S T(3)=T(3)+$P(Y(0),U,4)
 W !,"CLASS II",?18,$J($P(Y(0),U,5),3) S T(1)=T(1)+$P(Y(0),U,5) W ?38,$J($P(Y(0),U,6),3) S T(2)=T(2)+$P(Y(0),U,6) W ?59,$J($P(Y(0),U,7),3) S T(3)=T(3)+$P(Y(0),U,7)
 W !,"CLASS IIA",?18,$J($P(Y(0),U,8),3) S T(1)=T(1)+$P(Y(0),U,8) W ?38,$J($P(Y(0),U,9),3) S T(2)=T(2)+$P(Y(0),U,9) W ?59,$J($P(Y(0),U,10),3) S T(3)=T(3)+$P(Y(0),U,10)
 W !,"CLASS IIB",?18,$J($P(Y(0),U,11),3) S T(1)=T(1)+$P(Y(0),U,11) W ?38,$J($P(Y(0),U,12),3) S T(2)=T(2)+$P(Y(0),U,12) W ?59,$J($P(Y(0),U,13),3) S T(3)=T(3)+$P(Y(0),U,13)
 W !,"CLASS IIC",?18,$J($P(Y(0),U,14),3) S T(1)=T(1)+$P(Y(0),U,14) W ?38,$J($P(Y(0),U,15),3) S T(2)=T(2)+$P(Y(0),U,15) W ?59,$J($P(Y(0),U,16),3) S T(3)=T(3)+$P(Y(0),U,16)
 W !,"CLASS III",?18,$J($P(Y(0),U,17),3) S T(1)=T(1)+$P(Y(0),U,17) W ?38,$J($P(Y(0),U,18),3) S T(2)=T(2)+$P(Y(0),U,18) W ?59,$J($P(Y(0),U,19),3) S T(3)=T(3)+$P(Y(0),U,19)
 W !,"CLASS IV",?18,$J($P(Y(0),U,20),3) S T(1)=T(1)+$P(Y(0),U,20) W ?38,$J($P(Y(0),U,21),3) S T(2)=T(2)+$P(Y(0),U,21) W ?59,$J($P(Y(0),U,22),3) S T(3)=T(3)+$P(Y(0),U,22)
 W !,"CLASS V",?18,$J($P(Y(0),U,23),3) S T(1)=T(1)+$P(Y(0),U,23) W ?38,$J($P(Y(0),U,24),3) S T(2)=T(2)+$P(Y(0),U,24) W ?59,$J($P(Y(0),U,25),3) S T(3)=T(3)+$P(Y(0),U,25)
 W !,"CLASS VI",?18,$J($P(Y(0),U,26),3) S T(1)=T(1)+$P(Y(0),U,26) W ?38,$J($P(Y(0),U,27),3) S T(2)=T(2)+$P(Y(0),U,27) W ?59,$J($P(Y(0),U,28),3) S T(3)=T(3)+$P(Y(0),U,28)
 W !!,?5,"TOTALS",?17,$J(T(1),4),?37,$J(T(2),4),?58,$J(T(3),4),!
 K A,D,I,L,T,V Q
