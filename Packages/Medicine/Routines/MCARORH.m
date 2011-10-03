MCARORH ; GENERATED FROM 'MCRHHIST' PRINT TEMPLATE (#1000) ; 10/04/96 ; (FILE 701, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1000,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 F Y=0:0 Q:$Y>-1  W !
 D N:$X>0 Q:'DN  W ?0 W "Patient History"
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Head,Eyes,Ears,Nose,Mouth:"
 D N:$X>0 Q:'DN  W ?0 W "BLURRED VISION:"
 S X=$G(^MCAR(701,D0,0)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "DRY EYES:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "Musculosketal:"
 D N:$X>0 Q:'DN  W ?0 W "RINGING IN EARS:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,15) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "STIFF IN THE MORNING HOW LONG:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,36) W:Y]"" $J(Y,2,0)
 D N:$X>0 Q:'DN  W ?0 W "HEARING DIFFICULTIES:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "JOINT PAIN:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,37) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "MOUTH SORES:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,13) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "JOINT SWELLING:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,38) W:Y]"" $S($D(DXS(7,Y)):DXS(7,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "DRY MOUTH:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "LOW BACK PAIN:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,39) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "LOSS,CHANGE IN TASTE:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,11) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "MUSCLE PAIN:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,40) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "HEADACHE:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "NECK PAIN:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,41) W:Y]"" $S($D(DXS(13,Y)):DXS(13,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "DIZZINESS:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "NUMBNESS OR TINGLING:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,43) W:Y]"" $S($D(DXS(15,Y)):DXS(15,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "FEVER:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(16,Y)):DXS(16,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "SWELLING OF LEGS:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,44) W:Y]"" $S($D(DXS(17,Y)):DXS(17,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "NIGHT SWEATS:"
 S X=$G(^MCAR(701,D0,1)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(18,Y)):DXS(18,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "WEAKNESS OF MUSCLES:"
 S X=$G(^MCAR(701,D0,0)) D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,45) W:Y]"" $S($D(DXS(19,Y)):DXS(19,Y),1:Y)
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "Chest, Lung, and Heart:"
 D N:$X>39 Q:'DN  W ?39 W "Neurologic and Psychologic:"
 D N:$X>0 Q:'DN  W ?0 W "CHEST PAIN/TAKING DEEP BREATH:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,17) W:Y]"" $S($D(DXS(20,Y)):DXS(20,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "DEPRESSION:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,46) W:Y]"" $S($D(DXS(21,Y)):DXS(21,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "SHORTNESS OF BREATH:"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,18) W:Y]"" $S($D(DXS(22,Y)):DXS(22,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "INSOMNIA:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,47) W:Y]"" $S($D(DXS(23,Y)):DXS(23,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "WHEEZING(ASTHMA):"
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,19) W:Y]"" $S($D(DXS(24,Y)):DXS(24,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "NERVOUSNESS:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,48) W:Y]"" $S($D(DXS(25,Y)):DXS(25,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "SEIZURES OR CONVULSION:"
 D N:$X>71 Q:'DN  W ?71 S Y=$P(X,U,49) W:Y]"" $S($D(DXS(26,Y)):DXS(26,Y),1:Y)
 G ^MCARORH1
