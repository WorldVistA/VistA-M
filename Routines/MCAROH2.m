MCAROH2 ; GENERATED FROM 'MCARHOLT2' PRINT TEMPLATE (#980) ; 10/04/96 ; (FILE 691.6, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(980,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "------------------------------  SUMMARY  -------------------------------"
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(3,9) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 X DXS(4,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 X DXS(5,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "HEART MEDS:"
 S I(1)=1,J(1)=691.61 F D1=0:0 Q:$O(^MCAR(691.6,D0,1,D1))'>0  X:$D(DSC(691.61)) DSC(691.61) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.6,D0,1,D1,0)) W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 S DIP(1)=$S($D(^MCAR(691.6,D0,1,D1,0)):^(0),1:"") S X=" "_$P(DIP(1),U,2) K DIP K:DN Y W X
 S DIP(1)=$S($D(^MCAR(691.6,D0,1,D1,0)):^(0),1:"") S X=" "_$P(DIP(1),U,3) K DIP K:DN Y W X
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETATION:"
 S I(1)=7,J(1)=691.63 F D1=0:0 Q:$O(^MCAR(691.6,D0,7,D1))'>0  S D1=$O(^(D1)) D:$X>21 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(691.6,D0,7,D1,0)) S DIWL=1,DIWR=55 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMMENTS:"
 S I(1)=5,J(1)=691.64 F D1=0:0 Q:$O(^MCAR(691.6,D0,5,D1))'>0  S D1=$O(^(D1)) D:$X>15 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(691.6,D0,5,D1,0)) S DIWL=1,DIWR=75 D ^DIWP
 Q
C1R ;
 D 0^DIWW K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
