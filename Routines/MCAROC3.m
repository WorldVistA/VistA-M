MCAROC3 ; GENERATED FROM 'MCARCATH3' PRINT TEMPLATE (#972) ; 10/04/96 ; (FILE 691.1, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(972,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N D N:$X>29 Q:'DN  W ?29 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 X DXS(2,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "RIGHT CORONARY ARTERY:"
 S X=$G(^MCAR(691.1,D0,20)) W ?28 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.9,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 S I(1)=21,J(1)=691.27 F D1=0:0 Q:$O(^MCAR(691.1,D0,21,D1))'>0  X:$D(DSC(691.27)) DSC(691.27) S D1=$O(^(D1)) Q:D1'>0  D:$X>60 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.1,D0,21,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,4) W:Y]"" $J(Y,7,2)
 W ?42 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^MCAR(696.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,25)
 Q
A1R ;
 D N:$X>7 Q:'DN  W ?7 X DXS(3,9.2) S DIP(3)=X S X=1,DIP(4)=X S X="",X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 X DXS(4,9.3) S DIP(5)=X S X=1,DIP(6)=X S X="",X=$S(DIP(3):DIP(5),DIP(6):X) K DIP K:DN Y W X
 S I(1)=23,J(1)=691.28 F D1=0:0 Q:$O(^MCAR(691.1,D0,23,D1))'>0  X:$D(DSC(691.28)) DSC(691.28) S D1=$O(^(D1)) Q:D1'>0  D:$X>18 T Q:'DN  D B1
 G B1R
B1 ;
 D N:$X>8 Q:'DN  W ?8 W "FROM:"
 S X=$G(^MCAR(691.1,D0,23,D1,0)) W ?15 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>44 Q:'DN  W ?44 W "TO:"
 W ?49 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
B1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.1,D0,24)):^(24),1:"") S X="LEFT MAIN CA: "_$S('$D(^MCAR(695.9,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 S I(1)=25,J(1)=691.29 F D1=0:0 Q:$O(^MCAR(691.1,D0,25,D1))'>0  X:$D(DSC(691.29)) DSC(691.29) S D1=$O(^(D1)) Q:D1'>0  D:$X>15 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(691.1,D0,25,D1,0)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 W ?52 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,25)
 Q
C1R ;
 S I(1)=25.5,J(1)=691.47 F D1=0:0 Q:$O(^MCAR(691.1,D0,25.5,D1))'>0  X:$D(DSC(691.47)) DSC(691.47) S D1=$O(^(D1)) Q:D1'>0  D:$X>79 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(691.1,D0,25.5,D1,0)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,1) W:Y]"" $J(Y,6,2)
 W ?41 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,25)
 Q
D1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.1,D0,26)):^(26),1:"") S X="LAD: "_$S('$D(^MCAR(695.9,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 S I(1)=27,J(1)=691.3 F D1=0:0 Q:$O(^MCAR(691.1,D0,27,D1))'>0  X:$D(DSC(691.3)) DSC(691.3) S D1=$O(^(D1)) Q:D1'>0  D:$X>15 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^MCAR(691.1,D0,27,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,4) W:Y]"" $J(Y,7,2)
 W ?42 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^MCAR(696.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,25)
 Q
E1R ;
 D N:$X>7 Q:'DN  W ?7 X DXS(5,9.2) S DIP(3)=X S X=1,DIP(4)=X S X="",X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 X DXS(6,9.3) S DIP(5)=X S X=1,DIP(6)=X S X="",X=$S(DIP(3):DIP(5),DIP(6):X) K DIP K:DN Y W X
 S I(1)=29,J(1)=691.31 F D1=0:0 Q:$O(^MCAR(691.1,D0,29,D1))'>0  X:$D(DSC(691.31)) DSC(691.31) S D1=$O(^(D1)) Q:D1'>0  D:$X>18 T Q:'DN  D F1
 G F1R^MCAROC31
F1 ;
 D N:$X>8 Q:'DN  W ?8 S DIP(1)=$S($D(^MCAR(691.1,D0,29,D1,0)):^(0),1:"") S X="FROM: "_$S('$D(^MCAR(696,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 G ^MCAROC31
