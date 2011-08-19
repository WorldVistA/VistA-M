MCARORP1 ; GENERATED FROM 'MCRHPHYS1' PRINT TEMPLATE (#1008) ; 10/04/96 ; (continued)
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
 S X=$G(^MCAR(701,D0,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(27,Y)):DXS(27,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "HELIOTROPE EYELIDS:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,27) W:Y]"" $S($D(DXS(28,Y)):DXS(28,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "KNUCKLE ERYTHEMA:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,41) W:Y]"" $S($D(DXS(29,Y)):DXS(29,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "TELANGIECTASIS:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,37) W:Y]"" $S($D(DXS(30,Y)):DXS(30,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "SUBCUTANEOUS CALCIFICATIONS:"
 S X=$G(^MCAR(701,D0,1)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(31,Y)):DXS(31,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "SCLERODACTYLY:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,33) W:Y]"" $S($D(DXS(32,Y)):DXS(32,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "KERATODERMIA BLENNORRHAGICA:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,40) W:Y]"" $S($D(DXS(33,Y)):DXS(33,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "SCLERODERMA-EXTREMITY:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,34) W:Y]"" $S($D(DXS(34,Y)):DXS(34,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "DACTYLITIS:"
 S X=$G(^MCAR(701,D0,5)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(35,Y)):DXS(35,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "SCLERODERMA-GENERALIZED:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,35) W:Y]"" $S($D(DXS(36,Y)):DXS(36,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "NAIL PITTING:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,43) W:Y]"" $S($D(DXS(37,Y)):DXS(37,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "MORPHEA:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,36) W:Y]"" $S($D(DXS(38,Y)):DXS(38,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "PSORIASIS:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,29) W:Y]"" $S($D(DXS(39,Y)):DXS(39,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "DIGITAL ULCERS:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,42) W:Y]"" $S($D(DXS(40,Y)):DXS(40,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "HEEL PAIN:"
 S X=$G(^MCAR(701,D0,5)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(41,Y)):DXS(41,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
