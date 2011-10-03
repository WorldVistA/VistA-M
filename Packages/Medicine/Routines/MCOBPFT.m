MCOBPFT ; GENERATED FROM 'MCPFTBRPR' PRINT TEMPLATE (#1029) ; 10/04/96 ; (FILE 700, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1029,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 W "DATE/TIME: "
 S X=$G(^MCAR(700,D0,0)) S Y=$P(X,U,1) D DT
 D N:$X>34 Q:'DN  W ?34 W "MEDICAL PATIENT: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(700,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "VOLUME STUDY: "
 S I(1)=3,J(1)=700.017 F D1=0:0 Q:$O(^MCAR(700,D0,3,D1))'>0  X:$D(DSC(700.017)) DSC(700.017) S D1=$O(^(D1)) Q:D1'>0  D:$X>20 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(700,D0,3,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,2) W:Y]"" $J(Y,6,2)
 Q
A1R ;
 S I(1)=4,J(1)=700.018 F D1=0:0 Q:$O(^MCAR(700,D0,4,D1))'>0  X:$D(DSC(700.018)) DSC(700.018) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D B1
 G B1R
B1 ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "FLOWS STUDY: "
 S X=$G(^MCAR(700,D0,4,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,2) W:Y]"" $J(Y,5,2)
 D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,3) W:Y]"" $J(Y,6,2)
 D N:$X>9 Q:'DN  W ?9 S Y(700.018,5,1)=$S($D(^MCAR(700,D0,4,D1,0)):^(0),1:"") S X=$P(Y(700.018,5,1),U,3),X=$S($P(Y(700.018,5,1),U,2):X/$P(Y(700.018,5,1),U,2),1:"*******")*100 S X=$J(X,0,0) W:X'?."*" $J(X,9,0) K Y(700.018,5)
 S X=$G(^MCAR(700,D0,4,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,7) W:Y]"" $J(Y,4,0)
 Q
B1R ;
 S I(1)=6,J(1)=700.02 F D1=0:0 Q:$O(^MCAR(700,D0,6,D1))'>0  X:$D(DSC(700.02)) DSC(700.02) S D1=$O(^(D1)) Q:D1'>0  D:$X>15 T Q:'DN  D C1
 G C1R
C1 ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "BLOOD GAS: "
 S X=$G(^MCAR(700,D0,6,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,3) W:Y]"" $J(Y,6,3)
 D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,4) W:Y]"" $J(Y,6,1)
 D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,5) W:Y]"" $J(Y,6,1)
 Q
C1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 S X=$G(^MCAR(700,D0,.2)) S DIWL=1,DIWR=55 S Y=$P(X,U,2) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETATION: "
 W ?22 D COMP^MCPFTP5 K DIP K:DN Y
 S I(1)=25,J(1)=700.04 F D1=0:0 Q:$O(^MCAR(700,D0,25,D1))'>0  S D1=$O(^(D1)) D:$X>33 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(700,D0,25,D1,0)) S DIWL=18,DIWR=80 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETED BY: "
 S I(1)=7,J(1)=700.021 F D1=0:0 Q:$O(^MCAR(700,D0,7,D1))'>0  X:$D(DSC(700.021)) DSC(700.021) S D1=$O(^(D1)) Q:D1'>0  D:$X>22 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^MCAR(700,D0,7,D1,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 Q
E1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
