MCAROS1 ; GENERATED FROM 'MCARSR1' PRINT TEMPLATE (#994) ; 10/04/96 ; (FILE 694.5, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(994,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "III. CARDIAC CATHETERIZATION AND ANGIOGRAPHIC DATA"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,2)):^(2),1:"") S X="LVEDP                    "_$P(DIP(1),U,6)_"mm Hg" K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 W "Lv Contraction Score (from contrast or"
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,2)):^(2),1:"") S X="Aortic systolic pressure "_$P(DIP(1),U,2)_"mm Hg" K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 W "radionuclide angiogram or 2D echo)"
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,2)):^(2),1:"") S X="*PA systolic pressure    "_$P(DIP(1),U,3)_"mm Hg" K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,2)):^(2),1:"") S X="*PAW mean pressure       "_$P(DIP(1),U,4)_"mm Hg" K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 W "Grade  Ejection Fraction     Definition"
 D N:$X>0 Q:'DN  W ?0 W "*patients having right heart cath."
 D N:$X>41 Q:'DN  W ?41 W "Range"
 S X=$G(^MCAR(694.5,D0,4)) D N:$X>41 Q:'DN  W ?41 S Y=$P(X,U,15) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,4)):^(4),1:"") S X="Percent left main stenosis "_$P(DIP(1),U,1)_"%" K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "Number of other major coronary"
 D N:$X>0 Q:'DN  W ?0 W " arteries (LAD,right with PDA,"
 D N:$X>0 Q:'DN  W ?0 W " circumflex with marginals)"
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,4)):^(4),1:"") S X=" with stenosis(es) => 50%    "_$P(DIP(1),U,14) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
