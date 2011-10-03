MCOBK ; GENERATED FROM 'MCARECHOBRPR' PRINT TEMPLATE (#1021) ; 10/04/96 ; (FILE 691, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1021,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 W "DATE/TIME: "
 S X=$G(^MCAR(691,D0,0)) D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,1) D DT
 D N:$X>34 Q:'DN  W ?34 W "MEDICAL PATIENT: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>9 Q:'DN  W ?9 W "SEPTUM: "
 S X=$G(^MCAR(691,D0,4)) W ?0,$E($P(X,U,1),1,5)
 D N:$X>28 Q:'DN  W ?28 W "(8-11mm)"
 D N:$X>9 Q:'DN  W ?9 W "POST LV WALL: "
 W ?0,$E($P(X,U,2),1,5)
 D N:$X>28 Q:'DN  W ?28 W "(8-11mm)"
 D N:$X>9 Q:'DN  W ?9 W "LV DIASTOLE: "
 W ?0,$E($P(X,U,7),1,6)
 D N:$X>27 Q:'DN  W ?27 W "(40-55mm)"
 D N:$X>9 Q:'DN  W ?9 W "LV SYSTOLE: "
 W ?0,$E($P(X,U,8),1,6)
 D N:$X>27 Q:'DN  W ?27 W "(25-30mm)"
 D N:$X>9 Q:'DN  W ?9 W "% FRACT SHORT: "
 X ^DD(691,19,9.4) S X=$J(Y(691,19,8),Y(691,19,9),X) S X=$J(X,0,0) W $E(X,1,15) K Y(691,19)
 D N:$X>29 Q:'DN  W ?29 W "(25-45)"
 D N:$X>9 Q:'DN  W ?9 W "REGIONAL WALL MOTION"
 S I(1)=6,J(1)=691.04 F D1=0:0 Q:$O(^MCAR(691,D0,6,D1))'>0  X:$D(DSC(691.04)) DSC(691.04) S D1=$O(^(D1)) Q:D1'>0  D:$X>31 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691,D0,6,D1,0)) D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 X DXS(1,9.2) S X=X="",DIP(3)=X S X="",DIP(4)=X S X=1,DIP(5)=X S X=", ",X=$S(DIP(3):DIP(4),DIP(5):X) K DIP K:DN Y W X
 S X=$G(^MCAR(691,D0,6,D1,0)) S Y=$P(X,U,2) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "FINDINGS: "
 S I(1)=9,J(1)=691.06 F D1=0:0 Q:$O(^MCAR(691,D0,9,D1))'>0  X:$D(DSC(691.06)) DSC(691.06) S D1=$O(^(D1)) Q:D1'>0  D:$X>16 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(691,D0,9,D1,0)) D N:$X>9 Q:'DN  S DIWL=10,DIWR=74 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(693,Y,0))#2:$P(^(0),U,1),1:Y) S X=Y D ^DIWP
 D A^DIWW
 Q
B1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "DIAGNOSIS(ES): "
 S I(1)=14,J(1)=691.15 F D1=0:0 Q:$O(^MCAR(691,D0,14,D1))'>0  X:$D(DSC(691.15)) DSC(691.15) S D1=$O(^(D1)) Q:D1'>0  D:$X>21 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(691,D0,14,D1,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 Q
C1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "OTHER CONCLUSIONS:"
 S I(1)=10,J(1)=691.07 F D1=0:0 Q:$O(^MCAR(691,D0,10,D1))'>0  S D1=$O(^(D1)) D:$X>24 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(691,D0,10,D1,0)) S DIWL=10,DIWR=74 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(691,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 D N:$X>9 Q:'DN  S DIWL=10,DIWR=74 S Y=$P(X,U,2) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "CARDIOLOGY ATTENDING:"
 S X=$G(^MCAR(691,D0,11)) W ?27 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 W ?64 S MCFILE=691 D DISP^MCMAG K DIP K:DN Y
 D T Q:'DN  W ?2 K MCFILE K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
