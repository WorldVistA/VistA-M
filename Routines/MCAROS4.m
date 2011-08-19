MCAROS4 ; GENERATED FROM 'MCARSR4' PRINT TEMPLATE (#998) ; 10/04/96 ; (FILE 694.5, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(998,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>2 Q:'DN  W ?2 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 W "Repeat Cardiopulmonary   "
 D N:$X>2 Q:'DN  W ?2 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 X DXS(5,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 X DXS(7,9) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
