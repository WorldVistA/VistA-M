MCARORH2 ; GENERATED FROM 'MCRHHIST' PRINT TEMPLATE (#1000) ; 10/04/96 ; (continued)
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
 D N:$X>0 Q:'DN  W ?0 W "BURNING ON URINATION:"
 S X=$G(^MCAR(701,D0,0)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,33) W:Y]"" $S($D(DXS(53,Y)):DXS(53,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "LOW RED BLOOD COUNT:"
 S X=$G(^MCAR(701,D0,10)) D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(54,Y)):DXS(54,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "KIDNEY PROBLEMS:"
 S X=$G(^MCAR(701,D0,1)) W ?0,$J($P(X,U,4),19)
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Females Only:"
 D N:$X>0 Q:'DN  W ?0 W "PREGNANT:"
 S X=$G(^MCAR(701,D0,0)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,34) W:Y]"" $S($D(DXS(55,Y)):DXS(55,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "Males Only:"
 D N:$X>39 Q:'DN  W ?39 W "DISCHARGE FROM PENIS:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,60) W:Y]"" $S($D(DXS(56,Y)):DXS(56,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Other:"
 D N:$X>39 Q:'DN  W ?39 W "IMPOTENCE:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,61) W:Y]"" $S($D(DXS(57,Y)):DXS(57,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "OTHER:"
 S X=$G(^MCAR(701,D0,1)) W ?0,$J($P(X,U,10),30)
 D N:$X>39 Q:'DN  W ?39 W "RASH/ULCERS ON PENIS:"
 S X=$G(^MCAR(701,D0,0)) D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,62) W:Y]"" $S($D(DXS(58,Y)):DXS(58,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
