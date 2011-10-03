ONCOXA2 ; GENERATED FROM 'ONCOXA2' PRINT TEMPLATE (#828) ; 03/11/05 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(828,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D N:$X>2 Q:'DN  W ?2 W "Race: "
 W ?10 X ^DD(165.5,.12,9.2) S Y(165.5,.12,101)=$S($D(^ONCO(160,D0,0)):^(0),1:"") S X=$S('$D(^ONCO(164.46,+$P(Y(165.5,.12,101),U,6),0)):"",1:$P(^(0),U,1)) S D0=Y(165.5,.12,80) W $E(X,1,8) K Y(165.5,.12)
 D N:$X>39 Q:'DN  W ?39 W "Sex: "
 X "N I,Y "_$P(^DD(165.5,.1,0),U,5,99) S DIP(1)=X S X=DIP(1),DIP(2)=$G(X) S X="(",DIP(3)=$G(X) S X=1,X=$P(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Age at Dx: "
 D AGE^ONCOCOM W $J(X,4) K Y(165.5,4)
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 W ?15 D DOB^ONCOES K DIP K:DN Y
 D N:$X>39 Q:'DN  W ?39 W "Date of Birth: "
 W X K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "Birthplace: "
 S X=$G(^ONCO(160,D0,0)) S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^ONCO(165.2,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,40)
 D N:$X>39 Q:'DN  W ?39 W "Occupation: "
 S X="" D OCC^ONCOES W $J(X,16) K Y(160,12)
 D N:$X>2 Q:'DN  W ?2 W "SSN: "
 D SSN^ONCOES W $J(X,12) K Y(160,2)
 D N:$X>39 Q:'DN  W ?39 W "Religion: "
 D REL^ONCOES W $J(X,9) K Y(160,13)
 D N:$X>39 Q:'DN  W ?39 W "Employment status: "
 S X="" D EMP^ONCOES W $J(X,11) K Y(160,47)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>2 Q:'DN  W ?2 W "Facility referred from: "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,18) S Y(0)=Y S:Y'="" Y=$S($D(^ONCO(160.19,Y,0)):$P(^(0),U,2),1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Facility referred to: "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,19) S Y(0)=Y S:Y'="" Y=$S($D(^ONCO(160.19,Y,0)):$P(^(0),U,2),1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Date Dx: "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,16) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,18)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Following physician: "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,12) S Y=$S(Y="":Y,$D(^ONCO(165,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Primary surgeon: "
 S Y=$P(X,U,11) S Y=$S(Y="":Y,$D(^ONCO(165,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Physician #3: "
 S Y=$P(X,U,14) S Y=$S(Y="":Y,$D(^ONCO(165,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Physician #4: "
 S Y=$P(X,U,15) S Y=$S(Y="":Y,$D(^ONCO(165,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Laterality: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,8) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
