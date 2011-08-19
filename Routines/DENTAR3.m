DENTAR3 ;ISC2/SAW,HAG-CLASS I-VI SERVICE REPORT RELEASE OPTION ; 3/13/89  10:46 AM ;
 ;VERSION 1.2
 S Y(0)=DENTY0,Z1="CLASS I TO VI (TYPE 3) REPORT FOR "_Z1,Z3="STATION NUMBER: "_Z2,DENTCD=$P(Y(0),"^",30),DENT=$S(DENTCD="C":8,DENTCD="D":"D",1:3)_DENTSTA_$E(DENT,4,5)_$E(DENT,6,7)_$E(DENT,2,3) F I=1:1:3 S (A(I),D(I),T(I))=""
 W @IOF,?(80-$L(Z1)/2),Z1,!,?(80-$L(Z3)/2),Z3
 W !!,?15,"TREATMENT",?32,"TREATMENT CASES",?53,"TREATMENT CASES"
 W !,?12,"CASES AUTHORIZED",?31,"PENDING INITIATION",?52,"PENDING COMPLETION"
 W !,"CLASS I",?18,$J($P(Y(0),U,2),3) S A(1)=$P(Y(0),U,2),L=2,A=1 D B W ?38,$J($P(Y(0),U,3),3) S A(2)=$P(Y(0),U,3),A=2 D B W ?59,$J($P(Y(0),U,4),3) S A(3)=$P(Y(0),U,4),A=3 D B
 W !,"CLASS II",?18,$J($P(Y(0),U,5),3) S A(1)=$P(Y(0),U,5),L=3,A=1 D B W ?38,$J($P(Y(0),U,6),3) S A(2)=$P(Y(0),U,6),A=2 D B W ?59,$J($P(Y(0),U,7),3) S A(3)=$P(Y(0),U,7),A=3 D B
 W !,"CLASS IIA",?18,$J($P(Y(0),U,8),3) S A(1)=$P(Y(0),U,8),L=2,A=1 D B W ?38,$J($P(Y(0),U,9),3) S A(2)=$P(Y(0),U,9),A=2 D B W ?59,$J($P(Y(0),U,10),3) S A(3)=$P(Y(0),U,10),A=3 D B
 W !,"CLASS IIB",?18,$J($P(Y(0),U,11),3) S A(1)=$P(Y(0),U,11),L=2,A=1 D B W ?38,$J($P(Y(0),U,12),3) S A(2)=$P(Y(0),U,12),A=2 D B W ?59,$J($P(Y(0),U,13),3) S A(3)=$P(Y(0),U,13),A=3 D B
 W !,"CLASS IIC",?18,$J($P(Y(0),U,14),3) S A(1)=$P(Y(0),U,14),L=2,A=1 D B W ?38,$J($P(Y(0),U,15),3) S A(2)=$P(Y(0),U,15),A=2 D B W ?59,$J($P(Y(0),U,16),3) S A(3)=$P(Y(0),U,16),A=3 D B
 W !,"CLASS III",?18,$J($P(Y(0),U,17),3) S A(1)=$P(Y(0),U,17),L=3,A=1 D B W ?38,$J($P(Y(0),U,18),3) S A(2)=$P(Y(0),U,18),A=2 D B W ?59,$J($P(Y(0),U,19),3) S A(3)=$P(Y(0),U,19),A=3 D B
 W !,"CLASS IV",?18,$J($P(Y(0),U,20),3) S A(1)=$P(Y(0),U,20),L=3,A=1 D B W ?38,$J($P(Y(0),U,21),3) S A(2)=$P(Y(0),U,21),A=2 D B W ?59,$J($P(Y(0),U,22),3) S A(3)=$P(Y(0),U,22),A=3 D B
 W !,"CLASS V",?18,$J($P(Y(0),U,23),3) S A(1)=$P(Y(0),U,23),L=2,A=1 D B W ?38,$J($P(Y(0),U,24),3) S A(2)=$P(Y(0),U,24),A=2 D B W ?59,$J($P(Y(0),U,25),3) S A(3)=$P(Y(0),U,25),A=3 D B
 W !,"CLASS VI",?18,$J($P(Y(0),U,26),3) S A(1)=$P(Y(0),U,26),L=2,A=1 D B W ?38,$J($P(Y(0),U,27),3) S A(2)=$P(Y(0),U,27),A=2 D B W ?59,$J($P(Y(0),U,28),3) S A(3)=$P(Y(0),U,28),A=3 D B
 W !!,?5,"TOTALS",?17,$J(T(1),4),?37,$J(T(2),4),?58,$J(T(3),4)
 F I=1:1:3 S DENT=DENT_D(I)
 K A,D,DENTCD,I,L,T,V,Y Q
B S V="000"_A(A),D(A)=D(A)_$E(V,$L(V)-(L-1),$L(V)),T(A)=T(A)+A(A) Q
