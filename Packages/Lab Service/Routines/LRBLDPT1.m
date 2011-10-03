LRBLDPT1 ; GENERATED FROM 'LRBL DONOR TESTING REPORT' PRINT TEMPLATE (#2590) ; 01/20/93 ; (continued)
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^TMP($J,1))#2,^(1)?1U1P1E.E X ^(1)
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1
 D N:$X>103 Q:'DN  W ?103 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(14,Y)):DXS(14,Y),1:Y)
 D N:$X>111 Q:'DN  W ?111 S Y=$P(X,U,4) D DT
 D N:$X>124 Q:'DN  W ?124 X DXS(1,9) K DIP K:DN Y W $E(X,1,3)
 D N:$X>128 Q:'DN  W ?128 X DXS(2,9) K DIP K:DN Y W $E(X,1,3)
 Q
A2R ;
 Q
B1R ;
 K Y
 Q
HEAD ;
 W !,?111,"EXPIRATION"
 W !,?0,"DONATION DATE",?14,"UNIT #",?26,"DONOR",?33,"PDef",?39,"PR",?42,"REC",?47,"ABO",?51,"Rh",?55,"AbS",?59,"RPR",?63,"Hep",?67,"HIV",?71,"HT1",?76,"COLL.DISP",?86,"COMPONENT",?103,"DISPO.",?111,"DATE",?124,"LTc",?128,"VTc"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
