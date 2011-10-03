MCOBC1 ; GENERATED FROM 'MCARCATHBRPR' PRINT TEMPLATE (#1019) ; 10/04/96 ; (FILE 691.1, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1019,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 W "DATE/TIME: "
 S X=$G(^MCAR(691.1,D0,0)) S Y=$P(X,U,1) D DT
 D N:$X>34 Q:'DN  W ?34 W "MEDICAL PATIENT: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURES: "
 S I(1)=3,J(1)=691.13 F D1=0:0 Q:$O(^MCAR(691.1,D0,3,D1))'>0  X:$D(DSC(691.13)) DSC(691.13) S D1=$O(^(D1)) Q:D1'>0  D:$X>18 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.1,D0,3,D1,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INDICATIONS: "
 S I(1)=8,J(1)=691.18 F D1=0:0 Q:$O(^MCAR(691.1,D0,8,D1))'>0  X:$D(DSC(691.18)) DSC(691.18) S D1=$O(^(D1)) Q:D1'>0  D:$X>19 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(691.1,D0,8,D1,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 Q
B1R ;
 S I(1)=19,J(1)=691.26 F D1=0:0 Q:$O(^MCAR(691.1,D0,19,D1))'>0  X:$D(DSC(691.26)) DSC(691.26) S D1=$O(^(D1)) Q:D1'>0  D:$X>71 T Q:'DN  D C1
 G C1R
C1 ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERVENTION: "
 S X=$G(^MCAR(691.1,D0,19,D1,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D T Q:'DN  D N D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="RA MEAN PRESSURE: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 W "PA SYSTOLIC/DIASTOLIC: "
 W ?64 X DXS(1,9.2) S DIP(5)=X S X=$P(DIP(1),U,9)_"/"_$P(DIP(1),U,10),X=$S(DIP(3):DIP(4),DIP(5):X) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="PCW MEAN: "_$P(DIP(1),U,15) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 S DIP(1)=$S($D(^MCAR(691.1,D0,19,D1,0)):^(0),1:"") S X="LV END DIASTOLIC (Z): "_$P(DIP(1),U,21) K DIP K:DN Y W X
 Q
C1R ;
 D T Q:'DN  D N W ?0 W " "
 S I(1)=21,J(1)=691.27 F D1=0:0 Q:$O(^MCAR(691.1,D0,21,D1))'>0  X:$D(DSC(691.27)) DSC(691.27) S D1=$O(^(D1)) Q:D1'>0  D:$X>3 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(691.1,D0,21,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,4) W:Y]"" $J(Y,7,2)
 Q
D1R ;
 S I(1)=25,J(1)=691.29 F D1=0:0 Q:$O(^MCAR(691.1,D0,25,D1))'>0  X:$D(DSC(691.29)) DSC(691.29) S D1=$O(^(D1)) Q:D1'>0  D:$X>48 T Q:'DN  D E1
 G E1R
E1 ;
 D N:$X>9 Q:'DN  W ?9 W "LEFT MAIN CA NARROWING"
 S X=$G(^MCAR(691.1,D0,25,D1,0)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 Q
E1R ;
 S I(1)=25.5,J(1)=691.47 F D1=0:0 Q:$O(^MCAR(691.1,D0,25.5,D1))'>0  X:$D(DSC(691.47)) DSC(691.47) S D1=$O(^(D1)) Q:D1'>0  D:$X>58 T Q:'DN  D F1
 G F1R
F1 ;
 D N:$X>9 Q:'DN  W ?9 W "LEFT MAIN CA NARROWING NUMBER"
 S X=$G(^MCAR(691.1,D0,25.5,D1,0)) D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,1) W:Y]"" $J(Y,6,2)
 Q
F1R ;
 S I(1)=27,J(1)=691.3 F D1=0:0 Q:$O(^MCAR(691.1,D0,27,D1))'>0  X:$D(DSC(691.3)) DSC(691.3) S D1=$O(^(D1)) Q:D1'>0  D:$X>47 T Q:'DN  D G1
 G G1R
G1 ;
 S X=$G(^MCAR(691.1,D0,27,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,4) W:Y]"" $J(Y,7,2)
 Q
G1R ;
 S I(1)=31,J(1)=691.32 F D1=0:0 Q:$O(^MCAR(691.1,D0,31,D1))'>0  X:$D(DSC(691.32)) DSC(691.32) S D1=$O(^(D1)) Q:D1'>0  D:$X>48 T Q:'DN  D H1
 G H1R^MCOBC11
H1 ;
 S X=$G(^MCAR(691.1,D0,31,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(696.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 G ^MCOBC11
