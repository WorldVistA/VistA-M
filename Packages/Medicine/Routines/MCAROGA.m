MCAROGA ; GENERATED FROM 'MCAROGA' PRINT TEMPLATE (#1001) ; 10/04/96 ; (FILE 699, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1001,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(1,9) K DIP K:DN Y W X
 S I(1)=30,J(1)=699.01 F D1=0:0 Q:$O(^MCAR(699,D0,30,D1))'>0  X:$D(DSC(699.01)) DSC(699.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>0 T Q:'DN  D A1
 G A1R
A1 ;
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "LOCATION: "
 S X=$G(^MCAR(699,D0,30,D1,0)) W ?14 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "DESCRIPTION: "
 D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^MCAR(699.55,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 W ?16 X DXS(2,9) K DIP K:DN Y
 W ?27 K ZI,ZZ K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 X DXS(3,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 S X=$G(^MCAR(699,D0,30,D1,0)) W ?0,$E($P(X,U,4),1,15)
 D N:$X>2 Q:'DN  W ?2 W "Technique: "
 S I(2)=2,J(2)=699.15 F D2=0:0 Q:$O(^MCAR(699,D0,30,D1,2,D2))'>0  X:$D(DSC(699.15)) DSC(699.15) S D2=$O(^(D2)) Q:D2'>0  D:$X>15 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^MCAR(699,D0,30,D1,2,D2,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.6,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,60)
 Q
A2R ;
 D N:$X>2 Q:'DN  W ?2 W "Impression: "
 S X=$G(^MCAR(699,D0,30,D1,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 W ?16 D TECH^MCARGS K DIP K:DN Y
 Q
A1R ;
 W ?27 X DXS(4,9) K DIP K:DN Y
 W ?38 X DXS(5,9) K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Results:"
 S I(1)=16,J(1)=699.56 F D1=0:0 Q:$O(^MCAR(699,D0,16,D1))'>0  X:$D(DSC(699.56)) DSC(699.56) S D1=$O(^(D1)) Q:D1'>0  D:$X>12 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(699,D0,16,D1,0)) D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.81,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,60)
 Q
B1R ;
 D N:$X>2 Q:'DN  W ?2 W "Complications: "
 S I(1)=17,J(1)=699.58 F D1=0:0 Q:$O(^MCAR(699,D0,17,D1))'>0  X:$D(DSC(699.58)) DSC(699.58) S D1=$O(^(D1)) Q:D1'>0  D:$X>19 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(699,D0,17,D1,0)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696.9,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 W ", "
 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 Q
C1R ;
 S I(1)=25,J(1)=699.73 F D1=0:0 Q:$O(^MCAR(699,D0,25,D1))'>0  X:$D(DSC(699.73)) DSC(699.73) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D D1
 G D1R
D1 ;
 D N:$X>2 Q:'DN  W ?2 W "Disposition: "
 S X=$G(^MCAR(699,D0,25,D1,0)) D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>12 Q:'DN  W ?12 W "Date: "
 D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,2) D DT
 D N:$X>12 Q:'DN  W ?12 W "Reason: "
 D N:$X>20 Q:'DN  W ?20,$E($P(X,U,3),1,80)
 Q
D1R ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(7,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Primary: "
 S X=$G(^MCAR(699,D0,204)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 S X=$G(^MCAR(699,D0,205)) D N:$X>17 Q:'DN  W ?17,$E($P(X,U,1),1,60)
 S I(1)=27,J(1)=699.75 F D1=0:0 Q:$O(^MCAR(699,D0,27,D1))'>0  X:$D(DSC(699.75)) DSC(699.75) S D1=$O(^(D1)) Q:D1'>0  D:$X>79 T Q:'DN  D E1
 G E1R
E1 ;
 D N:$X>2 Q:'DN  W ?2 W "Secondary: "
 S X=$G(^MCAR(699,D0,27,D1,0)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 D N:$X>17 Q:'DN  W ?17,$E($P(X,U,2),1,60)
 Q
E1R ;
 D N:$X>2 Q:'DN  W ?2 W "Supplement: "
 S I(1)=33,J(1)=699.04 F D1=0:0 Q:$O(^MCAR(699,D0,33,D1))'>0  S D1=$O(^(D1)) D:$X>16 T Q:'DN  D F1
 G F1R
F1 ;
 S X=$G(^MCAR(699,D0,33,D1,0)) S DIWL=18,DIWR=78 D ^DIWP
 Q
F1R ;
 D A^DIWW
 D N:$X>2 Q:'DN  W ?2 X DXS(8,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(9,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "Prescriptions: "
 G ^MCAROGA1
