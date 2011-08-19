MCAROHF ; GENERATED FROM 'MCARHEMF' PRINT TEMPLATE (#987) ; 10/07/98 ; (FILE 694, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(987,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>25 Q:'DN  W ?25 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>7 Q:'DN  W ?7 W "CELLULARITY: "
 S X=$G(^MCAR(694,D0,1)) S Y=$P(X,U,3) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 W ?22 W " "
 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>49 Q:'DN  W ?49 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 X DXS(3,9) K DIP K:DN Y W X
 S DIP(2)=$C(59)_$S($D(^DD(694,10.1,0)):$P(^(0),U,3),1:""),DIP(1)=$S($D(^MCAR(694,D0,1)):^(1),1:"") S X=" "_$P($P(DIP(2),$C(59)_$P(DIP(1),U,8)_":",2),$C(59),1) K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 X DXS(4,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 S X=1 X "F I=1:1:X "_$S($D(^UTILITY($J,"W")):"S X="" |TAB|"" D L^DIWP",1:"W !") S X="" K DIP K:DN Y W X
 W ?49 X DXS(5,9) K DIP K:DN Y
 S I(1)=5,J(1)=694.01 F D1=0:0 Q:$O(^MCAR(694,D0,5,D1))'>0  X:$D(DSC(694.01)) DSC(694.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>60 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(694,D0,5,D1,0)) D N:$X>9 Q:'DN  S DIWL=10,DIWR=79 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(693,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
A1R ;
 S I(1)=7,J(1)=694.054 F D1=0:0 Q:$O(^MCAR(694,D0,7,D1))'>0  S D1=$O(^(D1)) D:$X>9 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(694,D0,7,D1,0)) S DIWL=7,DIWR=76 D ^DIWP
 Q
B1R ;
 D 0^DIWW K DIP K:DN Y
 S X=1 X "F I=1:1:X "_$S($D(^UTILITY($J,"W")):"S X="" |TAB|"" D L^DIWP",1:"W !") S X="" K DIP K:DN Y W X
 D ^DIWW
 D N:$X>4 Q:'DN  W ?4 W "COMPLICATIONS: "
 S I(1)=2,J(1)=694.055 F D1=0:0 Q:$O(^MCAR(694,D0,2,D1))'>0  X:$D(DSC(694.055)) DSC(694.055) S D1=$O(^(D1)) Q:D1'>0  D:$X>21 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(694,D0,2,D1,0)) D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696.9,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 Q
C1R ;
 S X=1 X "F I=1:1:X "_$S($D(^UTILITY($J,"W")):"S X="" |TAB|"" D L^DIWP",1:"W !") S X="" K DIP K:DN Y W X
 W ?20 X DXS(6,9) K DIP K:DN Y
 S I(1)=8,J(1)=694.035 F D1=0:0 Q:$O(^MCAR(694,D0,8,D1))'>0  X:$D(DSC(694.035)) DSC(694.035) S D1=$O(^(D1)) Q:D1'>0  D:$X>31 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(694,D0,8,D1,0)) D N:$X>9 Q:'DN  S DIWL=10,DIWR=79 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
D1R ;
 S I(1)=3,J(1)=694.041 F D1=0:0 Q:$O(^MCAR(694,D0,3,D1))'>0  S D1=$O(^(D1)) D:$X>81 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^MCAR(694,D0,3,D1,0)) S DIWL=7,DIWR=76 D ^DIWP
 Q
E1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(694,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 D N:$X>9 Q:'DN  S DIWL=10,DIWR=79 S Y=$P(X,U,2) S X=Y D ^DIWP
 D 0^DIWW K DIP K:DN Y
 W ?9 S MCFILE=694 D DISP^MCMAG K DIP K:DN Y
 W ?20 K MCFILE K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
