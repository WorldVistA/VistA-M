ONCOW11 ; GENERATED FROM 'ONCOW1' PRINT TEMPLATE (#874) ; 06/30/97 ; (continued)
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
 S X=$G(^ONCO(165.5,D0,1)) D N:$X>17 Q:'DN  W ?17,$E($P(X,U,2),1,9)
 D N:$X>44 Q:'DN  W ?44 W "Ethnicity:  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D H1
 G H1R
H1 ;
 S X=$G(^ONCO(160,D0,0)) S Y=$P(X,U,7) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 Q
H1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>93 Q:'DN  W ?93 W "Age at Dx:  "
 D N:$X>105 Q:'DN  W ?105 D AGE^ONCOCOM W $E(X,1,3) K Y(165.5,4)
 D N:$X>7 Q:'DN  W ?7 W "County:  "
 S X=$G(^ONCO(165.5,D0,1)) S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^VIC(5.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
