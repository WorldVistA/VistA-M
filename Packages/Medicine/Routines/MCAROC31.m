MCAROC31 ; GENERATED FROM 'MCARCATH3' PRINT TEMPLATE (#972) ; 10/04/96 ; (continued)
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
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(691.1,D0,29,D1,0)):^(0),1:"") S X="TO: "_$S('$D(^MCAR(696,+$P(DIP(1),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 Q
F1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.1,D0,30)):^(30),1:"") S X="CIRCUMFLEX: "_$S('$D(^MCAR(695.9,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 S I(1)=31,J(1)=691.32 F D1=0:0 Q:$O(^MCAR(691.1,D0,31,D1))'>0  X:$D(DSC(691.32)) DSC(691.32) S D1=$O(^(D1)) Q:D1'>0  D:$X>15 T Q:'DN  D G1
 G G1R
G1 ;
 S X=$G(^MCAR(691.1,D0,31,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,4) W:Y]"" $J(Y,7,2)
 W ?42 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^MCAR(696.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,25)
 Q
G1R ;
 D N:$X>7 Q:'DN  W ?7 X DXS(7,9.2) S DIP(3)=X S X=1,DIP(4)=X S X="",X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 X DXS(8,9.3) S DIP(5)=X S X=1,DIP(6)=X S X="",X=$S(DIP(3):DIP(5),DIP(6):X) K DIP K:DN Y W X
 S I(1)=33,J(1)=691.33 F D1=0:0 Q:$O(^MCAR(691.1,D0,33,D1))'>0  X:$D(DSC(691.33)) DSC(691.33) S D1=$O(^(D1)) Q:D1'>0  D:$X>18 T Q:'DN  D H1
 G H1R
H1 ;
 D N:$X>8 Q:'DN  W ?8 S DIP(1)=$S($D(^MCAR(691.1,D0,33,D1,0)):^(0),1:"") S X="FROM: "_$S('$D(^MCAR(696,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(691.1,D0,33,D1,0)):^(0),1:"") S X="TO: "_$S('$D(^MCAR(696,+$P(DIP(1),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 Q
H1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "BYPASS GRAFTS ?:"
 S X=$G(^MCAR(691.1,D0,35)) W ?22 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 S I(1)=36,J(1)=691.35 F D1=0:0 Q:$O(^MCAR(691.1,D0,36,D1))'>0  X:$D(DSC(691.35)) DSC(691.35) S D1=$O(^(D1)) Q:D1'>0  D:$X>35 T Q:'DN  D I1
 G I1R
I1 ;
 D N:$X>7 Q:'DN  W ?7 W "DISTAL ANASTOMOSIS:"
 S X=$G(^MCAR(691.1,D0,36,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,4) W:Y]"" $J(Y,7,2)
 W ?42 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^MCAR(696.4,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,25)
 Q
I1R ;
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
