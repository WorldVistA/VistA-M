MCAROGC ; GENERATED FROM 'MCCONSULT' PRINT TEMPLATE (#1016) ; 10/04/96 ; (FILE 699.5, MARGIN=80)
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
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Provider/Physician: "
 S X=$G(^MCAR(699.5,D0,0)) W ?22 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Consultation Type: "
 W ?21 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^MCAR(699.82,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Subjective: "
 S I(1)=20,J(1)=699.532 F D1=0:0 Q:$O(^MCAR(699.5,D0,20,D1))'>0  S D1=$O(^(D1)) D:$X>14 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(699.5,D0,20,D1,0)) S DIWL=14,DIWR=73 D ^DIWP
 Q
A1R ;
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Objective:"
 S I(1)=21,J(1)=699.533 F D1=0:0 Q:$O(^MCAR(699.5,D0,21,D1))'>0  S D1=$O(^(D1)) D:$X>12 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(699.5,D0,21,D1,0)) S DIWL=14,DIWR=73 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Assessment:"
 S I(1)=22,J(1)=699.534 F D1=0:0 Q:$O(^MCAR(699.5,D0,22,D1))'>0  S D1=$O(^(D1)) D:$X>13 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(699.5,D0,22,D1,0)) S DIWL=14,DIWR=73 D ^DIWP
 Q
C1R ;
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Planned:"
 S I(1)=35,J(1)=699.535 F D1=0:0 Q:$O(^MCAR(699.5,D0,35,D1))'>0  S D1=$O(^(D1)) D:$X>10 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(699.5,D0,35,D1,0)) S DIWL=14,DIWR=73 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Indication Comment:  "
 S X=$G(^MCAR(699.5,D0,0)) D N:$X>24 Q:'DN  S DIWL=25,DIWR=80 S Y=$P(X,U,7) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Procedure Summary: "
 S X=$G(^MCAR(699.5,D0,.2)) D N:$X>21 Q:'DN  S DIWL=22,DIWR=80 S Y=$P(X,U,2) S X=Y D ^DIWP
 D 0^DIWW K DIP K:DN Y
 W ?21 S MCFILE=699.5 D DISP^MCMAG K DIP K:DN Y
 W ?32 K MCFILE K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
