PSOXWRN ; GENERATED FROM 'PSO DRUG WARNINGS' PRINT TEMPLATE (#1506) ; 10/05/22 ; (FILE 52, MARGIN=255)
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
 I $D(DXS)<9 M DXS=^DIPT(1506,"DXS")
 S I(0)="^PSRX(",J(0)=52
 W "\\"
 W "^"
 S X=$G(^PSRX(D0,0)) S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 W "^"
 X DXS(1,9) K DIP K:DN Y W X
 W "^"
 S I(100)="^DPT(",J(100)=2 S I(0,0)=D0 S DIP(1)=$S($D(^PSRX(D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X  S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S X=$G(^DPT(D0,.11)) W ?0,$E($P(X,U,1),1,35)
 W "^"
 W ?0,$E($P(X,U,2),1,30)
 W "^"
 W ?0,$E($P(X,U,3),1,30)
 W "^"
 W ?0,$E($P(X,U,4),1,15)
 W "^"
 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^DIC(5,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 W "^"
 W ?0,$E($P(X,U,6),1,5)
 W "^"
 S X=$G(^DPT(D0,.13)) W ?0,$E($P(X,U,1),1,20)
 W "^"
 W ?0,$E($P(X,U,2),1,20)
 W "^"
 W ?0,$E($P(X,U,4),1,20)
 W "^"
 X DXS(2,9.2) S X=$S(DIP(102):DIP(103),DIP(104):X) K DIP K:DN Y W X
 W "^"
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 S X=$G(^PSRX(D0,0)) W ?0,$E($P(X,U,1),1,11)
 W "^"
 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 W "^"
 S DIP(1)=$S($D(^PSRX(D0,"OR1")):^("OR1"),1:"") S X=$P(DIP(1),U,8) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 W "^"
 X DXS(3,9) K DIP K:DN Y W X
 W "^"
 W ?0 X DXS(4,9.4) S X=$P($P(DIP(9),$C(59)_$P(DIP(1),U,1)_":",2),$C(59)),X=$S(DIP(6):DIP(7),DIP(8):X) K DIP K:DN Y W X
 W "^"
 S DIP(1)=$S($D(^PSRX(D0,0)):^(0),1:"") S X=$P(DIP(1),U,9),DIP(2)=$G(X),DIP(3)=$G(X),DIP(4)="" X DXS(5,9.4) S X=+DIP(4),Y=X,X=DIP(2),X=X-Y K DIP K:DN Y W X
 W "^"
 S X=$G(^PSRX(D0,0)) S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,35)
 W "^"
 S DIP(1)=$S($D(^PSRX(D0,3)):^(3),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 W "^"
 S DIP(1)=$S($D(^PSRX(D0,2)):^(2),1:"") S X=$P(DIP(1),U,15) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,?0,"$S((STATUS=""ACTIVE"")&(PARK=""YES""):""ACTIVE/PARK"",1:STATUS)"
 W !,"------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",!!
