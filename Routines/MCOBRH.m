MCOBRH ; GENERATED FROM 'MCRHBRPR' PRINT TEMPLATE (#1036) ; 10/04/96 ; (FILE 701, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1036,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "MEDICAL PATIENT: "
 S X=$G(^MCAR(701,D0,0)) S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W "HEIGHT:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,1) W:Y]"" $J(Y,4,0)
 D N:$X>39 Q:'DN  W ?39 W "WEIGHT:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,2) W:Y]"" $J(Y,6,1)
 D N:$X>0 Q:'DN  W ?0 W "SYSTOLIC PRESSURE: "
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,3) W:Y]"" $J(Y,4,0)
 D N:$X>39 Q:'DN  W ?39 W "DIASTOLIC PRESSURE: "
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,4) W:Y]"" $J(Y,4,0)
 D N:$X>0 Q:'DN  W ?0 W "PULSE: "
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,5) W:Y]"" $J(Y,4,0)
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "PHYSICAL EXAMINATION"
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "General: "
 D N:$X>0 Q:'DN  W ?0 W "UVEITIS/IRITIS: "
 S X=$G(^MCAR(701,D0,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "ORAL ULCERS: "
 S X=$G(^MCAR(701,D0,2)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "MUSCLE ATROPHY: "
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,22) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RALES: "
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,10) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "PSYCHOSIS: "
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,23) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "PLEURAL RUB/"
 D N:$X>0 Q:'DN  W ?0 W "CLINICAL PLEURISY:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,11) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "PERICARDIAL RUB/PERICARDITIS: "
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,13) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Skin: "
 D N:$X>0 Q:'DN  W ?0 W "CUTANEOUS VASCULTITIS: "
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,38) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RASH-MALAR: "
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,28) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "PERIUNGAL ERYTHEMA: "
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,39) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "RASH-OTHER: "
 S X=$G(^MCAR(701,D0,1)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "HELIOTROPE EYELIDS:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,27) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "KNUCKLE ERYTHEMA:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,41) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "TELANGIECTASIS:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,37) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "SCLERODACTYLY:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,33) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "SCLERODERMA-EXTREMITY:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,34) W:Y]"" $S($D(DXS(16,Y)):DXS(16,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "DACTYLITIS:"
 S X=$G(^MCAR(701,D0,5)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(17,Y)):DXS(17,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "SCLERODERMA-GENERALIZED:"
 S X=$G(^MCAR(701,D0,2)) D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,35) W:Y]"" $S($D(DXS(18,Y)):DXS(18,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "PSORIASIS:"
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,29) W:Y]"" $S($D(DXS(19,Y)):DXS(19,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "DIGITAL ULCERS:"
 D N:$X>69 Q:'DN  W ?69 S Y=$P(X,U,42) W:Y]"" $S($D(DXS(20,Y)):DXS(20,Y),1:Y)
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Rheumatic:"
 D N:$X>39 Q:'DN  W ?39 W "Measurements:"
 D N:$X>0 Q:'DN  W ?0 W "SUB-CUTANEOUS NODULES:"
 G ^MCOBRH1
