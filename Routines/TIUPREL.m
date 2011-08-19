TIUPREL ; GENERATED FROM 'TIU RELEASED/UNVERIFIED PRINT' PRINT TEMPLATE (#1115) ; 07/02/04 ; (FILE 8925, MARGIN=132)
 G BEGIN
CP G CP^DIO2
C S DQ(C)=Y
S S Q(C)=Y*Y+Q(C) S:L(C)>Y L(C)=Y S:H(C)<Y H(C)=Y
P S N(C)=N(C)+1
A S S(C)=S(C)+Y
 Q
D I Y=DITTO(C) S Y="" Q
 S DITTO(C)=Y
 Q
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
 I $D(DXS)<9 M DXS=^DIPT(1115,"DXS")
 S I(0)="^TIU(8925,",J(0)=8925
 S X=$G(^TIU(8925,D0,0)) W ?0 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^AUPNPAT(Y,0))#2:$P(^(0),U),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 S I(100)="^AUPNPAT(",J(100)=9000001 S I(0,0)=D0 S DIP(1)=$S($D(^TIU(8925,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 S I(200)="^DPT(",J(200)=2 S I(100,0)=D0 S DIP(101)=$S($D(^AUPNPAT(D0,0)):^(0),1:"") S X=$P(DIP(101),U,1),X=X S D(0)=+X S D0=D(0) I D0>0 D A2
 G A2R
A2 ;
 S X=$G(^DPT(D0,0)) W ?32,$E($P(X,U,9),1,10)
 Q
A2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 W ?44 S DIP(1)=$S($D(^TIU(8925,D0,0)):^(0),1:"") S X=$P(DIP(1),U,7) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 W ?55 S DIP(1)=$S($D(^TIU(8925,D0,0)):^(0),1:"") S X=$P(DIP(1),U,8) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 W ?66 X DXS(1,9.2) S X1=DIP(1) S X=$$NAME^TIULS(X,X1) K DIP K:DN Y W $E(X,1,15)
 S X=$G(^TIU(8925,D0,0)) W ?83 S Y=$P(X,U,9) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 W ?93 S Y=$P(X,U,10),C=1 D A:Y]"" W $E(Y,1,8)
 W ?103 S Y=$P(X,U,1) S Y(0)=Y S Y=$S($$PNAME^TIULC1(+Y)]"":$$PNAME^TIULC1(+Y),$P(^TIU(8925.1,+Y,0),U,3)]"":$P(^TIU(8925.1,+Y,0),U,3),1:Y) W $E(Y,1,8)
 K Y
 Q
HEAD ;
 W !,?93,"LINE"
 W !,?0,"PATIENT",?32,"SSN",?44,"ADM DATE",?55,"DIS DATE",?66,"DICTATED BY",?83,"URGENCY",?93,"COUNT"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
