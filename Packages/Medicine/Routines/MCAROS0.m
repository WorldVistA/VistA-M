MCAROS0 ; GENERATED FROM 'MCARSR' PRINT TEMPLATE (#993) ; 10/04/96 ; (FILE 694.5, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(993,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N W ?0 W "II. CLINICAL DATA"
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>34 Q:'DN  W ?34 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "Sex                   "
 X DXS(2,9.3) S DIP(201)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P($P(DIP(202),$C(59)_$P(DIP(201),U,2)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,0)):^(0),1:"") S X="Age                   "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 X DXS(5,9) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 X DXS(7,9) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 W "NYHA functional class       "
 S X=$G(^MCAR(694.5,D0,1)) D N:$X>66 Q:'DN  S DIWL=67,DIWR=80 S Y=$P(X,U,17) S:Y]"" Y=$S($D(DXS(15,Y)):DXS(15,Y),1:Y) S X=Y D ^DIWP
 D A^DIWW
 D N:$X>0 Q:'DN  W ?0 X DXS(8,9) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(9,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 X DXS(10,9) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(11,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,1)):^(1),1:"") S X="Creatinine            "_$P(DIP(1),U,23) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(12,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 X DXS(13,9) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(14,9) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
