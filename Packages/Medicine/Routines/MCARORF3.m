MCARORF3 ; GENERATED FROM 'MCRHPHYS' PRINT TEMPLATE (#1015) ; 10/04/96 ; (continued)
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
 D N:$X>30 Q:'DN  W ?30 W "First Carpomentacarpal"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,29) W:Y]"" $J($S($D(DXS(60,Y)):DXS(60,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,30) W:Y]"" $S($D(DXS(61,Y)):DXS(61,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Wrist"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,31) W:Y]"" $J($S($D(DXS(62,Y)):DXS(62,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,32) W:Y]"" $S($D(DXS(63,Y)):DXS(63,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Elbow"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,33) W:Y]"" $J($S($D(DXS(64,Y)):DXS(64,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,34) W:Y]"" $S($D(DXS(65,Y)):DXS(65,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Shoulder"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,35) W:Y]"" $J($S($D(DXS(66,Y)):DXS(66,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,36) W:Y]"" $S($D(DXS(67,Y)):DXS(67,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Sternoclavicular"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,37) W:Y]"" $J($S($D(DXS(68,Y)):DXS(68,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,38) W:Y]"" $S($D(DXS(69,Y)):DXS(69,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "TMJ"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,39) W:Y]"" $J($S($D(DXS(70,Y)):DXS(70,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,40) W:Y]"" $S($D(DXS(71,Y)):DXS(71,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "HIP"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,41) W:Y]"" $J($S($D(DXS(72,Y)):DXS(72,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,42) W:Y]"" $S($D(DXS(73,Y)):DXS(73,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Knee"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,43) W:Y]"" $J($S($D(DXS(74,Y)):DXS(74,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,44) W:Y]"" $S($D(DXS(75,Y)):DXS(75,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Ankle"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,45) W:Y]"" $J($S($D(DXS(76,Y)):DXS(76,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,46) W:Y]"" $S($D(DXS(77,Y)):DXS(77,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "MTP"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,47) W:Y]"" $J($S($D(DXS(78,Y)):DXS(78,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,48) W:Y]"" $S($D(DXS(79,Y)):DXS(79,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Toes - PIP"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,49) W:Y]"" $J($S($D(DXS(80,Y)):DXS(80,Y),1:Y),8)
 D T Q:'DN  D N D N:$X>30 Q:'DN  W ?30 W "Cervical Spine"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,50) W:Y]"" $J($S($D(DXS(81,Y)):DXS(81,Y),1:Y),8)
 D N:$X>30 Q:'DN  W ?30 W "Lumber Spine"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,51) W:Y]"" $J($S($D(DXS(82,Y)):DXS(82,Y),1:Y),8)
 F Y=0:0 Q:$Y>(IOSL-3)  W !
 D N:$X>0 Q:'DN  W ?0 W " "
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
