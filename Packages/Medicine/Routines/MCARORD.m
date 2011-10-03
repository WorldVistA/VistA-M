MCARORD ; GENERATED FROM 'MCRHDEATH' PRINT TEMPLATE (#1005) ; 10/04/96 ; (FILE 701, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1005,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "DEATH - ADMIN."
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Lost or death status:"
 S X=$G(^MCAR(701,D0,9)) D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Death date:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,2) D DT
 D N:$X>0 Q:'DN  W ?0 W "Disease activity:"
 S X=$G(^MCAR(701,D0,8)) D N:$X>23 Q:'DN  W ?23,$E($P(X,U,9),1,25)
 D N:$X>0 Q:'DN  W ?0 W "Autopsy available:"
 S X=$G(^MCAR(701,D0,9)) D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Cause of Death:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Chart type:"
 S X=$G(^MCAR(701,D0,8)) D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,25) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Observer:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,26) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,25)
 D N:$X>0 Q:'DN  W ?0 W "DEC number:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,28),1,25)
 D N:$X>0 Q:'DN  W ?0 W "Visit number:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,29),1,25)
 F Y=0:0 Q:$Y>(IOSL-3)  W !
 D N:$X>0 Q:'DN  W ?0 W " "
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
