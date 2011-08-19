MCAROK ; GENERATED FROM 'MCAREKG1' PRINT TEMPLATE (#976) ; 03/26/01 ; (FILE 691.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(976,"DXS")
 S I(0)="^MCAR(691.5,",J(0)=691.5
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(691.5,D0,8)):^(8),1:"") S X="WARD/CLINIC: "_$S('$D(^SC(+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "AGE: "
 W $$RPTAGE^MCARUTL4(691.5,D0) K DIP K:DN Y
 D N:$X>44 Q:'DN  W ?44 W "SEX:"
 W ?50 X DXS(1,9.3) S X=$P($P(DIP(202),$C(59)_$P(DIP(201),U,2)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.5,D0,4)):^(4),1:"") S X="HT IN: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(1)=$S($D(^MCAR(691.5,D0,4)):^(4),1:"") S X="WT LBS: "_$P(DIP(1),U,3) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "BLOOD PRESSURE: "
 X DXS(2,9.2) S X=X_"/"_$P(DIP(1),U,1),X=$S(DIP(2):DIP(3),DIP(4):DIP(5),DIP(6):X) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 S DIP(2)=$C(59)_$P($G(^DD(691.5,2,0)),U,3),DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="TYPE: "_$P($P(DIP(2),$C(59)_$P(DIP(1),U,3)_":",2),$C(59),1) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="VENT RATE: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="PR INTERVAL: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>54 Q:'DN  W ?54 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="QRS DURATION: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="QT: "_$P(DIP(1),U,7) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="QTC: "_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>9 Q:'DN  W ?9 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="P AXIS: "_$P(DIP(1),U,9) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="R AXIS: "_$P(DIP(1),U,10) K DIP K:DN Y W X
 D N:$X>54 Q:'DN  W ?54 S DIP(1)=$S($D(^MCAR(691.5,D0,0)):^(0),1:"") S X="T AXIS: "_$P(DIP(1),U,11) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETATION: "
 S I(1)=3,J(1)=691.54 F D1=0:0 Q:$O(^MCAR(691.5,D0,3,D1))'>0  X:$D(DSC(691.54)) DSC(691.54) S D1=$O(^(D1)) Q:D1'>0  D:$X>22 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.5,D0,3,D1,0)) D N:$X>21 Q:'DN  W ?21 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(693.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
A1R ;
 S I(1)=5,J(1)=691.55 F D1=0:0 Q:$O(^MCAR(691.5,D0,5,D1))'>0  X:$D(DSC(691.55)) DSC(691.55) S D1=$O(^(D1)) Q:D1'>0  D:$X>53 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(691.5,D0,5,D1,0)) D N:$X>21 Q:'DN  W ?21 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(693.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
B1R ;
 S I(1)=6,J(1)=691.56 F D1=0:0 Q:$O(^MCAR(691.5,D0,6,D1))'>0  X:$D(DSC(691.56)) DSC(691.56) S D1=$O(^(D1)) Q:D1'>0  D:$X>53 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(691.5,D0,6,D1,0)) D N:$X>21 Q:'DN  W ?21 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(693.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
C1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INSTRUMENT DX: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=9,J(1)=691.57 F D1=0:0 Q:$O(^MCAR(691.5,D0,9,D1))'>0  S D1=$O(^(D1)) D:$X>21 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(691.5,D0,9,D1,0)) S DIWL=21,DIWR=78 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "CONFIRMATION STATUS: "
 S X=$G(^MCAR(691.5,D0,0)) S Y=$P(X,U,12) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMPARISON: "
 S X=$G(^MCAR(691.5,D0,1)) S DIWL=1,DIWR=60 S Y=$P(X,U,1) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMMENTS: "
 S I(1)=7,J(1)=691.517 F D1=0:0 Q:$O(^MCAR(691.5,D0,7,D1))'>0  S D1=$O(^(D1)) D:$X>16 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^MCAR(691.5,D0,7,D1,0)) S DIWL=1,DIWR=65 D ^DIWP
 Q
E1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "HEART MEDS:"
 S I(1)=2,J(1)=691.53 F D1=0:0 Q:$O(^MCAR(691.5,D0,2,D1))'>0  X:$D(DSC(691.53)) DSC(691.53) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D F1
 G F1R
F1 ;
 S X=$G(^MCAR(691.5,D0,2,D1,0)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 S DIP(1)=$S($D(^MCAR(691.5,D0,2,D1,0)):^(0),1:"") S X=" "_$P(DIP(1),U,2) K DIP K:DN Y W X
 S DIP(1)=$S($D(^MCAR(691.5,D0,2,D1,0)):^(0),1:"") S X=" "_$P(DIP(1),U,3) K DIP K:DN Y W X
 Q
F1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETED BY: "
 S X=$G(^MCAR(691.5,D0,0)) S Y=$P(X,U,13) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
