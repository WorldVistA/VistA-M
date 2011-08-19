PRCBTPT ; GENERATED FROM 'PRCB TEMP REVIEW' PRINT TEMPLATE (#332) ; 10/27/00 ; (FILE 421.1, MARGIN=80)
 G BEGIN
CP G CP^DIO2
C S DQ(C)=Y
S S Q(C)=Y*Y+Q(C) S:L(C)>Y L(C)=Y S:H(C)<Y H(C)=Y
P S N(C)=N(C)+1
A S S(C)=S(C)+Y
 Q
D I Y=DITTO(C) S Y="" Q
 S DITTO(C)=Y
 Q
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 S I(0)="^PRCF(421.1,",J(0)=421.1
 S X=$G(^PRCF(421.1,D0,0)) W ?0,$E($P(X,U,1),1,7)
 S I(1)=2,J(1)=421.15 F D1=0:0 Q:$O(^PRCF(421.1,D0,2,D1))'>0  S D1=$O(^(D1)) D:$X>13 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCF(421.1,D0,2,D1,0)) S DIWL=14,DIWR=53 D ^DIWP
 Q
A1R ;
 D 0^DIWW K DIP K:DN Y
 D ^DIWW
 S I(1)=1,J(1)=421.14 F D1=0:0 Q:$O(^PRCF(421.1,D0,1,D1))'>0  X:$D(DSC(421.14)) DSC(421.14) S D1=$O(^(D1)) Q:D1'>0  D:$X>55 NX^DIWW D B1
 G B1R
B1 ;
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^PRCF(421.1,D0,1,D1,0)):^(0),1:"") S X=$P(DIP(1),U,1),DIP(2)=X S X=" ",X=$P(DIP(2),X) K DIP K:DN Y W $E(X,1,7)
 W ?9 S DIP(1)=$S($D(^PRCF(421.1,D0,1,D1,4)):^(4),1:"") S X=$P(DIP(1),U,6),X=X K DIP K:DN Y W X
 S X=$G(^PRCF(421.1,D0,1,D1,0)) D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,2),C=1 D A:Y]"" W:Y]"" $J(Y,12,2)
 W ?25 S Y=$P(X,U,3),C=2 D A:Y]"" W:Y]"" $J(Y,12,2)
 W ?39 S Y=$P(X,U,4),C=3 D A:Y]"" W:Y]"" $J(Y,12,2)
 W ?53 S Y=$P(X,U,5),C=4 D A:Y]"" W:Y]"" $J(Y,12,2)
 S X=$G(^PRCF(421.1,D0,1,D1,4)) W ?67 S Y=$P(X,U,5) W:Y]"" $J(Y,12,2)
 Q
B1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,?0,"TRANSACTION"
 W !,?0,"NUMBER",?13,"DESCRIPTION"
 W !,?0,"CONTROL"
 W !,?0,"POINT",?9,"R/NR"
 W !,?67,"ANNUALIZATION"
 W !,?16,"1ST QTR",?30,"2ND QTR",?44,"3RD QTR",?58,"4TH QTR",?74,"AMOUNT"
 W !,"--------------------------------------------------------------------------------",!!
