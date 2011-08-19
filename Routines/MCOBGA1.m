MCOBGA1 ; GENERATED FROM 'MCARGIBRPR' PRINT TEMPLATE (#1026) ; 10/04/96 ; (continued)
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
 D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^MCAR(699.55,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 W ?16 X DXS(1,9) K DIP K:DN Y
 W ?27 K ZI,ZZ K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 X DXS(2,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 S X=$G(^MCAR(699,D0,30,D1,0)) W ?0,$E($P(X,U,4),1,15)
 D N:$X>2 Q:'DN  W ?2 W "TECHNIQUE: "
 S I(2)=2,J(2)=699.15 F D2=0:0 Q:$O(^MCAR(699,D0,30,D1,2,D2))'>0  X:$D(DSC(699.15)) DSC(699.15) S D2=$O(^(D2)) Q:D2'>0  D:$X>15 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^MCAR(699,D0,30,D1,2,D2,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.6,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,60)
 Q
A2R ;
 D N:$X>2 Q:'DN  W ?2 W "IMPRESSION: "
 S X=$G(^MCAR(699,D0,30,D1,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 W ?16 D TECH^MCARGS K DIP K:DN Y
 Q
F1R ;
 W ?27 X DXS(3,9) K DIP K:DN Y
 W ?38 X DXS(4,9) K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(5,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "RESULTS: "
 S I(1)=16,J(1)=699.56 F D1=0:0 Q:$O(^MCAR(699,D0,16,D1))'>0  X:$D(DSC(699.56)) DSC(699.56) S D1=$O(^(D1)) Q:D1'>0  D:$X>13 T Q:'DN  D G1
 G G1R
G1 ;
 S X=$G(^MCAR(699,D0,16,D1,0)) D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(699.81,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,60)
 Q
G1R ;
 D N:$X>2 Q:'DN  W ?2 W "COMPLICATIONS: "
 S I(1)=17,J(1)=699.58 F D1=0:0 Q:$O(^MCAR(699,D0,17,D1))'>0  X:$D(DSC(699.58)) DSC(699.58) S D1=$O(^(D1)) Q:D1'>0  D:$X>19 T Q:'DN  D H1
 G H1R
H1 ;
 S X=$G(^MCAR(699,D0,17,D1,0)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696.9,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 W ", "
 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 Q
H1R ;
 S I(1)=25,J(1)=699.73 F D1=0:0 Q:$O(^MCAR(699,D0,25,D1))'>0  X:$D(DSC(699.73)) DSC(699.73) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D I1
 G I1R
I1 ;
 D N:$X>2 Q:'DN  W ?2 W "DISPOSITION: "
 S X=$G(^MCAR(699,D0,25,D1,0)) D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>12 Q:'DN  W ?12 W "DATE: "
 D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,2) D DT
 Q
I1R ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(6,9) K DIP K:DN Y W X
 D N:$X>2 Q:'DN  W ?2 W "PRIMARY: "
 S X=$G(^MCAR(699,D0,204)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 S I(1)=27,J(1)=699.75 F D1=0:0 Q:$O(^MCAR(699,D0,27,D1))'>0  X:$D(DSC(699.75)) DSC(699.75) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D J1
 G J1R
J1 ;
 D N:$X>2 Q:'DN  W ?2 W "SECONDARY: "
 S X=$G(^MCAR(699,D0,27,D1,0)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 Q
J1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 S X=$G(^MCAR(699,D0,.2)) S DIWL=1,DIWR=55 S Y=$P(X,U,2) S X=Y D ^DIWP
 D 0^DIWW K DIP K:DN Y
 W ?25 S MCFILE=699 D DISP^MCMAG K DIP K:DN Y
 W ?36 K MCFILE K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
