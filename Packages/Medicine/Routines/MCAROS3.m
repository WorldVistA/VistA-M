MCAROS3 ; GENERATED FROM 'MCARSR3' PRINT TEMPLATE (#996) ; 10/04/96 ; (FILE 694.5, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(996,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>1 Q:'DN  W ?1 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "Date of death"
 S X=$G(^MCAR(694.5,D0,13)) D N:$X>65 Q:'DN  S DIWL=66,DIWR=80 S Y=$P(X,U,5) X ^DD("DD") S:Y["@" Y=$P(Y,"@")_"  "_$P(Y,"@",2) S X=Y D ^DIWP
 D A^DIWW
 D N:$X>1 Q:'DN  W ?1 W "C.Perioperative (30 day) Complications"
 D N:$X>4 Q:'DN  W ?4 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(5,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "Renal failure requiring"
 D N:$X>44 Q:'DN  W ?44 W "Repeat cardiopulmonary"
 D N:$X>5 Q:'DN  W ?5 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>45 Q:'DN  W ?45 X DXS(7,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 X DXS(8,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(9,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 X DXS(10,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(11,9) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
