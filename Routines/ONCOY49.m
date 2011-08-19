ONCOY49 ; GENERATED FROM 'ONCOY49' PRINT TEMPLATE (#817) ; 04/23/09 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(817,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "CANCER REGISTRY EXTENDED ABSTRACT"
 D N:$X>64 Q:'DN  W ?64 S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100) S X=X,X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Abstracted by.................:"
 D N:$X>34 Q:'DN  W ?34 X DXS(1,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Reporting Facility............:"
 D N:$X>34 Q:'DN  W ?34 N DIERR X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W $E(X,1,45)
 D N:$X>2 Q:'DN  W ?2 W "FIN...........................:"
 S I(100)="^ONCO(160.19,",J(100)=160.19 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,3),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S X=$G(^ONCO(160.19,D0,0)) D N:$X>34 Q:'DN  W ?34,$E($P(X,U,1),1,8)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>2 Q:'DN  W ?2 W "Date Case Completed...........:"
 S X=$G(^ONCO(165.5,D0,7)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Patient Name..................:"
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) S C=$P(^DD(165.5,.02,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "SSN...........................:"
 D N:$X>34 Q:'DN  W ?34 X DXS(3,9.2) S X=DIP(101) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Site/Gp.......................:"
 D N:$X>34 Q:'DN  W ?34 X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Primary Site..................:"
 D N:$X>34 Q:'DN  W ?34 X DXS(5,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Laterality....................:"
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
