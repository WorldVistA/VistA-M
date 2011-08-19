ONCOW1 ; GENERATED FROM 'ONCOW1' PRINT TEMPLATE (#874) ; 03/11/05 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(874,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W " Patient Name:  "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,2) S C=$P(^DD(165.5,.02,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D N:$X>9 Q:'DN  W ?9 W "Alias:  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S X="" D ALIAS^ONCOES W $J(X,21) K Y(160,1)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>59 Q:'DN  W ?59 W "Accession No:  "
 S X=$G(^ONCO(165.5,D0,0)) W ?0,$E($P(X,U,5),1,9)
 D N:$X>95 Q:'DN  W ?95 W "Hospital No:  "
 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,3),X=X K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Home Address:  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D B1
 G B1R
B1 ;
 S X="" D ADD^ONCOES W $J(X,41) K Y(160,.119)
 Q
B1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>59 Q:'DN  W ?59 W "Accession Yr:  "
 S X=$G(^ONCO(165.5,D0,0)) W ?0,$E($P(X,U,7),1,4)
 D N:$X>89 Q:'DN  W ?89 W "Hospital Chart No:  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D C1
 G C1R
C1 ;
 D SSN^ONCOES W $J(X,12) K Y(160,2)
 D N:$X>17 Q:'DN  W ?17 S X="" D ZIP^ONCOES W $J(X,21) K Y(160,.116)
 Q
C1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>52 Q:'DN  W ?52 W "Primary Sequence No:  "
 S X=$G(^ONCO(165.5,D0,0)) W ?0,$E($P(X,U,6),1,2)
 D N:$X>95 Q:'DN  W ?95 W "Regional No:  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D D1
 G D1R
D1 ;
 S X=$G(^ONCO(160,D0,0)) W ?0,$E($P(X,U,3),1,8)
 D N:$X>8 Q:'DN  W ?8 W "County:  "
 S X="" D CTY^ONCOES W $J(X,21) K Y(160,.12)
 D N:$X>96 Q:'DN  W ?96 W "Central No:  "
 S X=$G(^ONCO(160,D0,0)) W ?0,$E($P(X,U,4),1,8)
 D N:$X>0 Q:'DN  W ?0 W "Home Telephone:  "
 D PH^ONCOES W $J(X,21) K Y(160,.131)
 Q
D1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>90 Q:'DN  W ?90 W "Date of First Contact:  "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,35) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D E1
 G E1R
E1 ;
 D N:$X>0 Q:'DN  W ?0 W "Next of Kin:  "
 S X="" D NOKEO^ONCOCON W $J(X,21) K Y(160,.214)
 Q
E1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N W ?0 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "Social Security No:  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D F1
 G F1R
F1 ;
 D SSN^ONCOES W $J(X,12) K Y(160,2)
 D N:$X>50 Q:'DN  W ?50 W "Sex:  "
 S X=$G(^ONCO(160,D0,0)) S Y=$P(X,U,8) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 W ?58 D DOB^ONCOES,DATEOT^ONCOES K DIP K:DN Y
 D N:$X>89 Q:'DN  W ?89 W "Date of Birth:  "
 W X K DIP K:DN Y
 D N:$X>1 Q:'DN  W ?1 W "Address at Dx:  "
 Q
F1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 S X=$G(^ONCO(165.5,D0,1)) W ?0,$E($P(X,U,1),1,40)
 D N:$X>49 Q:'DN  W ?49 W "Race:  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D G1
 G G1R
G1 ;
 S X=$G(^ONCO(160,D0,0)) S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^ONCO(164.46,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,50)
 D N:$X>92 Q:'DN  W ?92 W "Birthplace:  "
 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 Q
G1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 S X=$G(^ONCO(165.5,D0,1)) D N:$X>17 Q:'DN  W ?17,$E($P(X,U,2),1,9)
 D N:$X>44 Q:'DN  W ?44 W "Ethnicity:  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D H1
 G H1R
H1 ;
 S X=$G(^ONCO(160,D0,0)) S Y=$P(X,U,7) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 Q
H1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>93 Q:'DN  W ?93 W "Age at Dx:  "
 D N:$X>105 Q:'DN  W ?105 D AGE^ONCOCOM W $E(X,1,3) K Y(165.5,4)
 D N:$X>7 Q:'DN  W ?7 W "County:  "
 S X=$G(^ONCO(165.5,D0,1)) S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^VIC(5.1,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
