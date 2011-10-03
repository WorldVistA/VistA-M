MCAROGA1 ; GENERATED FROM 'MCAROGA' PRINT TEMPLATE (#1001) ; 10/04/96 ; (continued)
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
 S I(1)=26,J(1)=699.74 F D1=0:0 Q:$O(^MCAR(699,D0,26,D1))'>0  X:$D(DSC(699.74)) DSC(699.74) S D1=$O(^(D1)) Q:D1'>0  D:$X>19 T Q:'DN  D G1
 G G1R
G1 ;
 S X=$G(^MCAR(699,D0,26,D1,0)) D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 W "  "
 W ?0,$E($P(X,U,2),1,30)
 Q
G1R ;
 D N:$X>2 Q:'DN  W ?2 W "Instructions: "
 S I(1)=203,J(1)=699.0203 F D1=0:0 Q:$O(^MCAR(699,D0,203,D1))'>0  S D1=$O(^(D1)) D:$X>18 T Q:'DN  D H1
 G H1R
H1 ;
 S X=$G(^MCAR(699,D0,203,D1,0)) S DIWL=1,DIWR=65 D ^DIWP
 Q
H1R ;
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>2 Q:'DN  W ?2 W "PHYSICIANS' SIGNATURE ____________________________________"
 W ?62 S MCFILE=699 D DISP^MCMAG K DIP K:DN Y
 D T Q:'DN  W ?2 K MCFILE K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
