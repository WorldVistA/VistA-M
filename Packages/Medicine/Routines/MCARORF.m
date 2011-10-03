MCARORF ; GENERATED FROM 'MCRHPHYS' PRINT TEMPLATE (#1015) ; 10/04/96 ; (FILE 701, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1015,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 F Y=0:0 Q:$Y>-1  W !
 D N:$X>0 Q:'DN  W ?0 W "PATIENT PHYSICAL EXAMINATION"
 S I(100)="^MCAR(690,",J(100)=690 S I(0,0)=D0 S DIP(1)=$S($D(^MCAR(701,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Height"
 S X=$G(^MCAR(701,D0,2)) D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,1) W:Y]"" $J(Y,8,0)
 D N:$X>36 Q:'DN  W ?36 W " cm"
 D N:$X>0 Q:'DN  W ?0 W "Weight"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,2) W:Y]"" $J(Y,8,1)
 D N:$X>36 Q:'DN  W ?36 W " kg"
 D N:$X>0 Q:'DN  W ?0 W "Systolic pressure"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,3) W:Y]"" $J(Y,8,0)
 D N:$X>36 Q:'DN  W ?36 W " mmhg"
 D N:$X>0 Q:'DN  W ?0 W "Diastolic pressure"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,4) W:Y]"" $J(Y,8,0)
 D N:$X>36 Q:'DN  W ?36 W " mmhg"
 D N:$X>0 Q:'DN  W ?0 W "Pulse"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,5) W:Y]"" $J(Y,8,0)
 D N:$X>36 Q:'DN  W ?36 W " /min"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "G E N E R A L :"
 D N:$X>0 Q:'DN  W ?0 W "Uveitis"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,6) W:Y]"" $J($S($D(DXS(1,Y)):DXS(1,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Lymph Node Enlargement"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,16) W:Y]"" $J($S($D(DXS(2,Y)):DXS(2,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Cataract"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,7) W:Y]"" $J($S($D(DXS(3,Y)):DXS(3,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Muscle Tenderness"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,17) W:Y]"" $J($S($D(DXS(4,Y)):DXS(4,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Iritis"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,8) W:Y]"" $J($S($D(DXS(5,Y)):DXS(5,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Muscle Weakness - Dital"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,18) W:Y]"" $J($S($D(DXS(6,Y)):DXS(6,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Oral Ulcers"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,9) W:Y]"" $J($S($D(DXS(7,Y)):DXS(7,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Hepatomegaly"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,19) W:Y]"" $J($S($D(DXS(8,Y)):DXS(8,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Rales"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,10) W:Y]"" $J($S($D(DXS(9,Y)):DXS(9,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Splenomegoly"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,20) W:Y]"" $J($S($D(DXS(10,Y)):DXS(10,Y),1:Y),8)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Pleural Rub"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,11) W:Y]"" $J($S($D(DXS(11,Y)):DXS(11,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Muscle Weakness - Proximal"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,21) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Pleural Effusion"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,12) W:Y]"" $J($S($D(DXS(13,Y)):DXS(13,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Muscle Atrophy"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,22) W:Y]"" $J($S($D(DXS(14,Y)):DXS(14,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Pericardial Rub"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,13) W:Y]"" $J($S($D(DXS(15,Y)):DXS(15,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Psychosis"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,23) W:Y]"" $J($S($D(DXS(16,Y)):DXS(16,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Systolic Murmur"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,14) W:Y]"" $J($S($D(DXS(17,Y)):DXS(17,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Organic Brain Syndrome"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,24) W:Y]"" $J($S($D(DXS(18,Y)):DXS(18,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Diastolic Murmur"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,15) W:Y]"" $J($S($D(DXS(19,Y)):DXS(19,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Motor Neurophathy"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,25) W:Y]"" $J($S($D(DXS(20,Y)):DXS(20,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Sensory Neurophathy"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,26) W:Y]"" $J($S($D(DXS(21,Y)):DXS(21,Y),1:Y),8)
 G ^MCARORF1
