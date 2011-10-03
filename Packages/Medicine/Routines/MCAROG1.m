MCAROG1 ; GENERATED FROM 'MCAROG' PRINT TEMPLATE (#984) ; 10/04/96 ; (continued)
 G BEGIN
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
 S DIP(1)=$S($D(^MCAR(699,D0,8,D1,0)):^(0),1:"") S X=$P(DIP(1),U,3)_" mg  " K DIP K:DN Y W X
 S X=$G(^MCAR(699,D0,8,D1,0)) S Y=$P(X,U,2) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 Q
C1R ;
 W ?21 D:MCARGNAM="LAP" LAP^MCARGS K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
