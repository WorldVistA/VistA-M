MCAROS2 ; GENERATED FROM 'MCARSR2' PRINT TEMPLATE (#995) ; 10/04/96 ; (FILE 694.5, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(995,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "IV. OPERATIVE RISK SUMMARY DATA"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Physician's preoperative "
 D N:$X>34 Q:'DN  W ?34 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "estimate of operative "
 D N:$X>34 Q:'DN  W ?34 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^MCAR(694.5,D0,4)):^(4),1:"") S X="mortality           "_$P(DIP(1),U,18)_"%" K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 X DXS(3,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "V. OPERATIVE DATA"
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "A.Procedure(s)"
 D N:$X>4 Q:'DN  W ?4 W "CABG distal anastomoses:"
 D N:$X>44 Q:'DN  W ?44 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(694.5,D0,10)):^(10),1:"") S X="number with vein         "_$P(DIP(1),U,2) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(5,9) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(694.5,D0,10)):^(10),1:"") S X="number with IMA          "_$P(DIP(1),U,3) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "Great vessel repair requiring"
 D N:$X>4 Q:'DN  W ?4 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(7,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 X DXS(8,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(9,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 X DXS(10,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(11,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "Other(not checked above)"
 S I(1)=11,J(1)=694.586 F D1=0:0 Q:$O(^MCAR(694.5,D0,11,D1))'>0  X:$D(DSC(694.586)) DSC(694.586) S D1=$O(^(D1)) Q:D1'>0  D:$X>4 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(694.5,D0,11,D1,0)) D N:$X>4 Q:'DN  W ?4 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.6,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,60)
 Q
A1R ;
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
