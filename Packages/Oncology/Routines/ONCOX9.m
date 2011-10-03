ONCOX9 ; GENERATED FROM 'ONCOX9' PRINT TEMPLATE (#850) ; 09/07/00 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(850,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "Recurrence Date:  "
 S X=$G(^ONCO(165.5,D0,5)) S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOPCE W $E(Y,1,30)
 D N:$X>49 Q:'DN  W ?49 W "Distant Site 1:  "
 X DXS(2,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>1 Q:'DN  W ?1 W "Type of 1st Recurrence:  "
 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "Distant Site 2:  "
 X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "Distant Site 3:  "
 X DXS(5,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 S I(1)=23,J(1)=165.572 F D1=0:0 Q:$O(^ONCO(165.5,D0,23,D1))'>0  X:$D(DSC(165.572)) DSC(165.572) S D1=$O(^(D1)) Q:D1'>0  D:$X>68 T Q:'DN  D A1
 G A1R
A1 ;
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "Subsequent Recurrence Date:  "
 S X=$G(^ONCO(165.5,D0,23,D1,0)) S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>1 Q:'DN  W ?1 W "Type of Subsequent Recurrence:  "
 X DXS(6,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "Distant Site 1:  "
 X DXS(7,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "Distant Site 2:  "
 X DXS(8,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "Distant Site 3:  "
 X DXS(9,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 Q
A1R ;
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
