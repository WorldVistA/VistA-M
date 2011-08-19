MCARORF2 ; GENERATED FROM 'MCRHPHYS' PRINT TEMPLATE (#1015) ; 10/04/96 ; (continued)
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
 D N:$X>0 Q:'DN  W ?0 W "Sub-Cutaneous Nodules"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,4) W:Y]"" $J($S($D(DXS(44,Y)):DXS(44,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Synovial (Baker's) Cyst"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,5) W:Y]"" $J($S($D(DXS(45,Y)):DXS(45,Y),1:Y),8)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Heel Pain"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,6) W:Y]"" $J($S($D(DXS(46,Y)):DXS(46,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Tenosynovitis (Tendon Rubs)"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,7) W:Y]"" $J($S($D(DXS(47,Y)):DXS(47,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Temporal Artery Tenderness"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,8) W:Y]"" $J($S($D(DXS(48,Y)):DXS(48,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Costochondritis"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,9) W:Y]"" $J($S($D(DXS(49,Y)):DXS(49,Y),1:Y),8)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "F U N C T I O N A L   A S S E S S M E N T :"
 D N:$X>0 Q:'DN  W ?0 W "Grip Strength - left"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,10) W:Y]"" $J(Y,8,0)
 D N:$X>40 Q:'DN  W ?40 W " mmHg"
 D N:$X>0 Q:'DN  W ?0 W "Grip Strength - Right"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,11) W:Y]"" $J(Y,8,0)
 D N:$X>40 Q:'DN  W ?40 W " mmHg"
 D N:$X>0 Q:'DN  W ?0 W "Schober Test (10 cm Base)"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,12) W:Y]"" $J(Y,8,0)
 D N:$X>40 Q:'DN  W ?40 W " cm"
 D N:$X>0 Q:'DN  W ?0 W "Chest Expansion"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,13) W:Y]"" $J(Y,8,0)
 D N:$X>40 Q:'DN  W ?40 W " cm"
 D N:$X>0 Q:'DN  W ?0 W "Occiput - Wall"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,14) W:Y]"" $J(Y,8,0)
 D N:$X>40 Q:'DN  W ?40 W " cm"
 D N:$X>0 Q:'DN  W ?0 W "Finger-to-Palm Crease - left"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,15) W:Y]"" $J(Y,8,1)
 D N:$X>40 Q:'DN  W ?40 W " cm"
 D N:$X>0 Q:'DN  W ?0 W "Finger-to-Palm Crease - Right"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,16) W:Y]"" $J(Y,8,1)
 D N:$X>40 Q:'DN  W ?40 W " cm"
 D N:$X>0 Q:'DN  W ?0 W "Interincisor Distance"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,17) W:Y]"" $J(Y,8,0)
 D N:$X>40 Q:'DN  W ?40 W " mm"
 D N:$X>0 Q:'DN  W ?0 W "Schirmer Test"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,18) W:Y]"" $J(Y,8,0)
 D N:$X>40 Q:'DN  W ?40 W " mm"
 D N:$X>0 Q:'DN  W ?0 W "Walk Time (50 feet)"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,19) W:Y]"" $J(Y,8,0)
 D N:$X>40 Q:'DN  W ?40 W " secs"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "M I S C E L L A N E O U S :"
 D N:$X>0 Q:'DN  W ?0 W "Functional Class (ARA)"
 D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,20) W:Y]"" $J($S($D(DXS(50,Y)):DXS(50,Y),1:Y),16)
 D N:$X>0 Q:'DN  W ?0 W "Disease Severity - Patient Estimate"
 D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,21) W:Y]"" $J($S($D(DXS(51,Y)):DXS(51,Y),1:Y),16)
 D N:$X>0 Q:'DN  W ?0 W "Disease Severity - Physician Estimate"
 D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,52) W:Y]"" $J($S($D(DXS(52,Y)):DXS(52,Y),1:Y),16)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "J O I N T   E X A M I N A T I O N:"
 D N:$X>0 Q:'DN  W ?0 W "LEFT"
 D N:$X>70 Q:'DN  W ?70 W "RIGHT"
 D N:$X>0 Q:'DN  W ?0 W "----"
 D N:$X>70 Q:'DN  W ?70 W "-----"
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,22) W:Y]"" $S($D(DXS(53,Y)):DXS(53,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Fingers - DIPs"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,23) W:Y]"" $J($S($D(DXS(54,Y)):DXS(54,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,24) W:Y]"" $S($D(DXS(55,Y)):DXS(55,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "Fingers - PIPs"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,25) W:Y]"" $J($S($D(DXS(56,Y)):DXS(56,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,26) W:Y]"" $S($D(DXS(57,Y)):DXS(57,Y),1:Y)
 D N:$X>30 Q:'DN  W ?30 W "MCPs"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,27) W:Y]"" $J($S($D(DXS(58,Y)):DXS(58,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,28) W:Y]"" $S($D(DXS(59,Y)):DXS(59,Y),1:Y)
 G ^MCARORF3
