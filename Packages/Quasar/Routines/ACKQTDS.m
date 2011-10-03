ACKQTDS ; GENERATED FROM 'ACKQTDS' PRINT TEMPLATE (#969) ; 09/26/96 ; (FILE 509850.6, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(969,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 S DIP(1)=$S($D(^ACK(509850.6,D0,0)):^(0),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W $E(X,1,8)
 S X=$G(^ACK(509850.6,D0,0)) W ?15 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^ACK(509850.2,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 W ?37 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 S X=$G(^ACK(509850.6,D0,2)) W ?59 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 W ?67 X DXS(1,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,?59,"CLINIC"
 W !,?59,"STOP",?67,"$S(INTERNAL(C"
 W !,?0,"NUMDATE(DATE)",?15,"PATIENT NAME",?37,"CLINIC LOCATION",?59,"CODE",?67,"AND P)=1:"
 W !,"--------------------------------------------------------------------------------",!!
