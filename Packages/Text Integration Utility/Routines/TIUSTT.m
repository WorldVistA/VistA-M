TIUSTT ; GENERATED FROM 'TIU PRINT TRANS STATS' PRINT TEMPLATE (#1117) ; 03/03/04 ; (FILE 8925, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(1117,"DXS")
 S I(0)="^TIU(8925,",J(0)=8925
 S X=$G(^TIU(8925,D0,13)) W ?0 S Y=$P(X,U,2),C=1 D D S Y(0)=Y S Y=$S(+$G(TIUINI):$$LOWER^TIULS($P($G(^VA(200,+Y(0),0)),U,2)),1:$P($G(^VA(200,+Y(0),0)),U,2)) W $E(Y,1,15)
 S X=$G(^TIU(8925,D0,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,10),C=2 D P:Y]"" W $J(Y,8)
 D N:$X>27 Q:'DN  W ?27 S DIP(1)=$S($D(^TIU(8925,D0,13)):^(13),1:"") S X=$P(DIP(1),U,1),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>41 Q:'DN  W ?41 X DXS(1,9) K DIP K:DN Y W $E(X,1,15)
 D N:$X>58 Q:'DN  W ?58 X DXS(2,9.2) S X1=DIP(2) D ^XUWORKDY K DIP K:DN Y W $J(X,3) K Y(8925,-1) S Y=X,C=3 D P:Y'?."*"
 D N:$X>74 Q:'DN  W ?74 X DXS(3,9.2) S X1=DIP(2) D ^XUWORKDY K DIP K:DN Y W $J(X,3) K Y(8925,-1) S Y=X,C=4 D P:Y'?."*"
 D N:$X>89 Q:'DN  W ?89 X DXS(4,9.2) S X1=DIP(2) D ^XUWORKDY K DIP K:DN Y W $J(X,3) K Y(8925,-1) S Y=X,C=5 D P:Y'?."*"
 D N:$X>104 Q:'DN  W ?104 X DXS(5,9) K DIP K:DN Y W $J(X,3) K Y(8925,-1) S Y=X,C=6 D P:Y'?."*"
 S X=$G(^TIU(8925,D0,0)) D N:$X>119 Q:'DN  W ?119 S Y=$P(X,U,1) S Y(0)=Y S Y=$S($$PNAME^TIULC1(+Y)]"":$$PNAME^TIULC1(+Y),$P(^TIU(8925.1,+Y,0),U,3)]"":$P(^TIU(8925.1,+Y,0),U,3),1:Y) W $E(Y,1,8)
 K Y
 Q
HEAD ;
 W !,?20,"Line"
 W !,?0,"Transciber",?19,"Count",?27,"Ref Date",?41,"Patient",?58,"Disch-Dict",?74,"Dict-Transcr",?89,"Transcr-Sign",?104,"Sign-Cosign"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
