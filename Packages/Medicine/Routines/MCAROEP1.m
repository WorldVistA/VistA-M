MCAROEP1 ; GENERATED FROM 'MCAREP1' PRINT TEMPLATE (#977) ; 10/04/96 ; (continued)
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
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SVT TYPE: "
 S DICMX="D L^DIWP" S DIWL=17,DIWR=78 X DXS(6,9.4) S X=$P($P(DIP(103),$C(59)_$P(DIP(102),U,1)_":",2),$C(59),1) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETATION:"
 S I(1)=12,J(1)=691.813 F D1=0:0 Q:$O(^MCAR(691.8,D0,12,D1))'>0  S D1=$O(^(D1)) D:$X>21 T Q:'DN  D H1
 G H1R
H1 ;
 S X=$G(^MCAR(691.8,D0,12,D1,0)) S DIWL=22,DIWR=78 D ^DIWP
 Q
H1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMMENTS: "
 S I(1)=13,J(1)=691.814 F D1=0:0 Q:$O(^MCAR(691.8,D0,13,D1))'>0  S D1=$O(^(D1)) D:$X>16 T Q:'DN  D I1
 G I1R
I1 ;
 S X=$G(^MCAR(691.8,D0,13,D1,0)) S DIWL=1,DIWR=60 D ^DIWP
 Q
I1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "FOLLOW UP: "
 S I(1)=14,J(1)=691.815 F D1=0:0 Q:$O(^MCAR(691.8,D0,14,D1))'>0  X:$D(DSC(691.815)) DSC(691.815) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D J1
 G J1R
J1 ;
 S X=$G(^MCAR(691.8,D0,14,D1,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 Q
J1R ;
 D T Q:'DN  D N D N D N:$X>4 Q:'DN  W ?4 W "CARDIOLOGY STAFF: "
 S X=$G(^MCAR(691.8,D0,15)) W ?24 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>4 Q:'DN  W ?4 W "CARDIOLOGY STAFF (2nd): "
 W ?30 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "CARDIOLOGY FELLOW: "
 W ?25 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>4 Q:'DN  W ?4 W "CARDIOLOGY FELLOW (2ND) "
 W ?30 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
