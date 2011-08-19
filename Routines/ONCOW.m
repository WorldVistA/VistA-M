ONCOW ; GENERATED FROM 'ONCOX1' PRINT TEMPLATE (#842) ; 08/13/03 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(842,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 X DXS(1,9.2) S X=$J("",$S($D(DIWR)+$D(DIWL)=2:DIWR-DIWL+1,$D(IOM):IOM,1:80)-$L(X)\2-$X)_X K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>11 Q:'DN  W ?11 W "Abstracted by:  "
 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 W " - "
 W "      Abstract Status:  "
 S X=$G(^ONCO(165.5,D0,7)) S Y=$P(X,U,2) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 W "  on: "
 S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>99 Q:'DN  W ?99 S X=DT S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>11 Q:'DN  W ?11 W "Patient Summary/Abstract for "
 S X=$G(^ONCO(165.5,D0,0)) S Y=$P(X,U,2) S C=$P(^DD(165.5,.02,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 W "  "
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 D SSN^ONCOES W $J(X,12) K Y(160,2)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" S Y=X,X=DIP(1),X=X S X=X_Y K DIP K:DN Y W X
 D N:$X>24 Q:'DN  W ?24 W "-  V A  HOSPITAL  - "
 X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>69 Q:'DN  W ?69 W "ACOS #: "
 W ?79 S X=$$IIN^ONCFUNC W $E(X,1,8) K Y(165.5,67)
 D N:$X>89 Q:'DN  W ?89 W "State Hosp. No: "
 W ?107 S X=$$SHN^ONCFUNC W $E(X,1,8) K Y(165.5,68)
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
