MCAROC22 ; GENERATED FROM 'MCARCATH2' PRINT TEMPLATE (#973) ; 10/04/96 ; (continued)
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
 S Y(691.26,36,2)=$S($D(^MCAR(691.1,D0,0)):^(0),1:""),Y(691.26,36,1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X=$P(Y(691.26,36,1),U,9),X=$S($P(Y(691.26,36,2),U,9):X/$P(Y(691.26,36,2),U,9),1:"*******") S X=$J(X,0,2) W:X'?."*" $J(X,7,2)
 D N:$X>9 Q:'DN  W ?9 W "INDOGREEN"
 S X=$G(^MCAR(691.1,D0,19,D1,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,12) W:Y]"" $J(Y,6,2)
 D N:$X>55 Q:'DN  W ?55
 S Y(691.26,39,2)=$S($D(^MCAR(691.1,D0,0)):^(0),1:""),Y(691.26,39,1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X=$P(Y(691.26,39,1),U,12),X=$S($P(Y(691.26,39,2),U,9):X/$P(Y(691.26,39,2),U,9),1:"*******") S X=$J(X,0,2) W:X'?."*" $J(X,7,2)
 D N:$X>9 Q:'DN  W ?9 W "THERMODILUTION"
 S X=$G(^MCAR(691.1,D0,19,D1,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,14) W:Y]"" $J(Y,6,2)
 D N:$X>55 Q:'DN  W ?55
 S Y(691.26,41,2)=$S($D(^MCAR(691.1,D0,0)):^(0),1:""),Y(691.26,41,1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X=$P(Y(691.26,41,1),U,14),X=$S($P(Y(691.26,41,2),U,9):X/$P(Y(691.26,41,2),U,9),1:"*******") S X=$J(X,0,2) W:X'?."*" $J(X,7,2)
 D T Q:'DN  D N D N:$X>6 Q:'DN  W ?6 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,1)):^(1),1:"") S X="A V AREA (CM SQ): "_$P(DIP(1),U,19) K DIP K:DN Y W X
 Q
H1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
