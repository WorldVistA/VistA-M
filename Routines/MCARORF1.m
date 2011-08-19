MCARORF1 ; GENERATED FROM 'MCRHPHYS' PRINT TEMPLATE (#1015) ; 10/04/96 ; (continued)
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
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "S K I N"
 D N:$X>0 Q:'DN  W ?0 W "Heliotrope Eyelids"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,27) W:Y]"" $J($S($D(DXS(22,Y)):DXS(22,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Telangiectasis"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,37) W:Y]"" $J($S($D(DXS(23,Y)):DXS(23,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Rash - Malar"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,28) W:Y]"" $J($S($D(DXS(24,Y)):DXS(24,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Cutaneous Vasculitis"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,38) W:Y]"" $J($S($D(DXS(25,Y)):DXS(25,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Psoriasis"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,29) W:Y]"" $J($S($D(DXS(26,Y)):DXS(26,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Periungal Erythema"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,39) W:Y]"" $J($S($D(DXS(27,Y)):DXS(27,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Rash - Discoid"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,30) W:Y]"" $J($S($D(DXS(28,Y)):DXS(28,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Keratodermia Blennorrhagica"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,40) W:Y]"" $J($S($D(DXS(29,Y)):DXS(29,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Rash - JRA"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,31) W:Y]"" $J($S($D(DXS(30,Y)):DXS(30,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Knuckle Erythema"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,41) W:Y]"" $J($S($D(DXS(31,Y)):DXS(31,Y),1:Y),8)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Palpable Purpura"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,32) W:Y]"" $J($S($D(DXS(32,Y)):DXS(32,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Digital Ulcers"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,42) W:Y]"" $J($S($D(DXS(33,Y)):DXS(33,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Sclerodactyly"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,33) W:Y]"" $J($S($D(DXS(34,Y)):DXS(34,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Nail Pitting"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,43) W:Y]"" $J($S($D(DXS(35,Y)):DXS(35,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Scleroderma - Extremity"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,34) W:Y]"" $J($S($D(DXS(36,Y)):DXS(36,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Skin Ulcers"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,44) W:Y]"" $J($S($D(DXS(37,Y)):DXS(37,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Scleroderma - Generalized"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,35) W:Y]"" $J($S($D(DXS(38,Y)):DXS(38,Y),1:Y),8)
 D N:$X>39 Q:'DN  W ?39 W "Erythema Nodosum"
 D N:$X>70 Q:'DN  W ?70 S Y=$P(X,U,45) W:Y]"" $J($S($D(DXS(39,Y)):DXS(39,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Morphea"
 D N:$X>27 Q:'DN  W ?27 S Y=$P(X,U,36) W:Y]"" $J($S($D(DXS(40,Y)):DXS(40,Y),1:Y),8)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "C U R R E N T   M E D I C A T I O N :"
 S X=$G(^MCAR(701,D0,3)) D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,200)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "P R E S R I B E D   M E D I C A T I O N S :"
 S I(1)=4,J(1)=701.0108 F D1=0:0 Q:$O(^MCAR(701,D0,4,D1))'>0  S D1=$O(^(D1)) D:$X>45 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(701,D0,4,D1,0)) S DIWL=1,DIWR=78 D ^DIWP
 Q
B1R ;
 D A^DIWW
 F Y=0:0 Q:$Y>(IOSL-3)  W !
 W ?0 W " "
 F Y=0:0 Q:$Y>-1  W !
 D N:$X>0 Q:'DN  W ?0 W "PATIENT PHYSICAL EXAMINATION"
 S I(100)="^MCAR(690,",J(100)=690 S I(0,0)=D0 S DIP(1)=$S($D(^MCAR(701,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D C1
 G C1R
C1 ;
 Q
C1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "R H E U M A T I C :"
 D N:$X>0 Q:'DN  W ?0 W "Sysmmetrical Arthritis"
 S X=$G(^MCAR(701,D0,5)) D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,1) W:Y]"" $J($S($D(DXS(41,Y)):DXS(41,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Dactylitis"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,2) W:Y]"" $J($S($D(DXS(42,Y)):DXS(42,Y),1:Y),8)
 D N:$X>0 Q:'DN  W ?0 W "Tophi"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,3) W:Y]"" $J($S($D(DXS(43,Y)):DXS(43,Y),1:Y),8)
 G ^MCARORF2
