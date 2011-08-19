MCOBRH1 ; GENERATED FROM 'MCRHBRPR' PRINT TEMPLATE (#1036) ; 10/04/96 ; (continued)
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
 S X=$G(^MCAR(701,D0,5)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(21,Y)):DXS(21,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "GRIP STRENGTH-LEFT:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,10) W:Y]"" $J(Y,4,0)
 D N:$X>0 Q:'DN  W ?0 W "SYNOVIAL (BAKER'S) CYST:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(22,Y)):DXS(22,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "GRIP STRENGTH-RIGHT:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,11) W:Y]"" $J(Y,4,0)
 D N:$X>0 Q:'DN  W ?0 W "TOPHI:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(23,Y)):DXS(23,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
