MCAROC1 ; GENERATED FROM 'MCARCATH1' PRINT TEMPLATE (#974) ; 10/04/96 ; (FILE 691.1, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(974,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>49 Q:'DN  W ?49 W "WARD/CLINIC: "
 S X=$G(^MCAR(691.1,D0,0)) S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>4 Q:'DN  W ?4 W "REF HOSP OR PHYS: "
 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^MCAR(697.1,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>49 Q:'DN  W ?49 S DIP(1)=$S($D(^MCAR(691.1,D0,0)):^(0),1:"") S X="CATH NO: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "HT IN: "
 S X=$G(^MCAR(691.1,D0,0)) S Y=$P(X,U,8) W:Y]"" $J(Y,3,0)
 D N:$X>27 Q:'DN  W ?27 W "WT LBS: "
 S Y=$P(X,U,7) W:Y]"" $J(Y,4,0)
 D N:$X>49 Q:'DN  W ?49 X DXS(1,9.2) S X=$S(DIP(2):DIP(3),DIP(4):DIP(5),DIP(6):X) K DIP K:DN Y W X
 S X=$G(^MCAR(691.1,D0,0)) S Y=$P(X,U,9) W:Y]"" $J(Y,6,2)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURES:"
 S I(1)=3,J(1)=691.13 F D1=0:0 Q:$O(^MCAR(691.1,D0,3,D1))'>0  X:$D(DSC(691.13)) DSC(691.13) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.1,D0,3,D1,0)) W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "HISTORY:"
 S I(1)=4,J(1)=691.14 F D1=0:0 Q:$O(^MCAR(691.1,D0,4,D1))'>0  S D1=$O(^(D1)) D:$X>14 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(691.1,D0,4,D1,0)) S DIWL=15,DIWR=78 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D N:$X>7 Q:'DN  W ?7 W "SYMPTOMS INCLUDED:"
 S I(1)=.3,J(1)=691.43 F D1=0:0 Q:$O(^MCAR(691.1,D0,.3,D1))'>0  X:$D(DSC(691.43)) DSC(691.43) S D1=$O(^(D1)) Q:D1'>0  D:$X>27 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(691.1,D0,.3,D1,0)) D N:$X>26 Q:'DN  W ?26 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,99)
 Q
C1R ;
 D N:$X>4 Q:'DN  W ?4 W "RISK FACTORS:"
 S I(1)=.4,J(1)=691.44 F D1=0:0 Q:$O(^MCAR(691.1,D0,.4,D1))'>0  X:$D(DSC(691.44)) DSC(691.44) S D1=$O(^(D1)) Q:D1'>0  D:$X>19 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(691.1,D0,.4,D1,0)) W ?19 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695.4,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 Q
D1R ;
 D N:$X>4 Q:'DN  W ?4 W "HEART MEDS:"
 S I(1)=6,J(1)=691.16 F D1=0:0 Q:$O(^MCAR(691.1,D0,6,D1))'>0  X:$D(DSC(691.16)) DSC(691.16) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^MCAR(691.1,D0,6,D1,0)) W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 S DIP(1)=$S($D(^MCAR(691.1,D0,6,D1,0)):^(0),1:"") S X=", "_$P(DIP(1),U,2) K DIP K:DN Y W X
 S DIP(1)=$S($D(^MCAR(691.1,D0,6,D1,0)):^(0),1:"") S X="  "_$P(DIP(1),U,3) K DIP K:DN Y W X
 Q
E1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PHYSICAL:"
 S I(1)=7,J(1)=691.17 F D1=0:0 Q:$O(^MCAR(691.1,D0,7,D1))'>0  S D1=$O(^(D1)) D:$X>15 T Q:'DN  D F1
 G F1R
F1 ;
 S X=$G(^MCAR(691.1,D0,7,D1,0)) S DIWL=17,DIWR=76 D ^DIWP
 Q
F1R ;
 D 0^DIWW K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
