MCARORB ; GENERATED FROM 'MCRHBACK' PRINT TEMPLATE (#999) ; 03/29/03 ; (FILE 701, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(999,"DXS")
 S I(0)="^MCAR(701,",J(0)=701
 D N:$X>0 Q:'DN  W ?0 W "BACK GROUND INFORMATION"
 S I(100)="^MCAR(690,",J(100)=690 S I(0,0)=D0 S DIP(1)=$S($D(^MCAR(701,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S I(200)="^DPT(",J(200)=2 S I(100,0)=D0 S DIP(101)=$S($D(^MCAR(690,D0,0)):^(0),1:"") S X=$P(DIP(101),U,1),X=X S D(0)=+X S D0=D(0) I D0>0 D A2
 G A2R
A2 ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Address:"
 S X=$G(^DPT(D0,.11)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,1),1,35)
 D N:$X>19 Q:'DN  W ?19,$E($P(X,U,2),1,30)
 D N:$X>19 Q:'DN  W ?19,$E($P(X,U,3),1,30)
 D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^DIC(5,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>29 Q:'DN  W ?29,$E($P(X,U,6),1,5)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Home phone:"
 S X=$G(^DPT(D0,.13)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,1),1,20)
 D N:$X>0 Q:'DN  W ?0 W "Work phone:"
 D N:$X>19 Q:'DN  W ?19,$E($P(X,U,2),1,20)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Sex:"
 S X=$G(^DPT(D0,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Race: "
 W ?8 W ?19,$G(MCARRC) K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Maritus status: "
 S X=$G(^DPT(D0,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^DIC(11,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,15)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Employment status: "
 S X=$G(^DPT(D0,.311)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,15) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Occupation:"
 S X=$G(^DPT(D0,0)) D N:$X>19 Q:'DN  W ?19,$E($P(X,U,7),1,30)
 Q
A2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 F Y=0:0 Q:$Y>(IOSL-3)  W !
 D N:$X>0 Q:'DN  W ?0 W " "
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
