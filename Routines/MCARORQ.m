MCARORQ ; GENERATED FROM 'MCRHHAQ' PRINT TEMPLATE (#1004) ; 10/04/96 ; (FILE 701, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1004,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "HEALTH ASSESSMENT"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Questionnaire date:"
 S X=$G(^MCAR(701,D0,0)) D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,63) D DT
 D N:$X>0 Q:'DN  W ?0 W "Study status:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,66) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Drug Study:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,67) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "Dressing and Grooming:"
 S X=$G(^MCAR(701,D0,8)) D N:$X>23 Q:'DN  W ?23,$E($P(X,U,14),1,15)
 D N:$X>0 Q:'DN  W ?0 W "Arising:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,15),1,15)
 D N:$X>0 Q:'DN  W ?0 W "Eating:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,16),1,15)
 D N:$X>0 Q:'DN  W ?0 W "Walking:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,17),1,15)
 D N:$X>0 Q:'DN  W ?0 W "Hygiene:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,18),1,15)
 D N:$X>0 Q:'DN  W ?0 W "Reach:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,19),1,15)
 D N:$X>0 Q:'DN  W ?0 W "Activities:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,21),1,15)
 D N:$X>0 Q:'DN  W ?0 W "Pain Scale:"
 D N:$X>23 Q:'DN  W ?23,$E($P(X,U,12),1,15)
 F Y=0:0 Q:$Y>(IOSL-3)  W !
 D N:$X>0 Q:'DN  W ?0 W " "
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
