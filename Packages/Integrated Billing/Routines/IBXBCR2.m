IBXBCR2 ; GENERATED FROM 'IB BILLING CLOCK HEADER' PRINT TEMPLATE (#242) ; 08/03/23 ; (FILE 351, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 X ^DD("DD")
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 S I(0)="^IBE(351,",J(0)=351
 S X=$G(^IBE(351,D0,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,20)
 S I(100)="^DPT(",J(100)=2 S I(0,0)=D0 S DIP(1)=$S($D(^IBE(351,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X  S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S X=$G(^DPT(D0,0)) D N:$X>40 Q:'DN  W ?40 S Y=$P(X,U,3) S Y(0)=Y S X=Y(0) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) S Y=X W $E(Y,1,12)
 S X=$G(^DPT(D0,"TYPE")) D N:$X>56 Q:'DN  W ?56 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DG(391,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,22)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>0 Q:'DN  W ?0 W "================================================================================"
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
