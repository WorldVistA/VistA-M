ONCOX61 ; GENERATED FROM 'ONCOX6' PRINT TEMPLATE (#847) ; 11/27/97 ; (continued)
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
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,14) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "Lymph Nodes:  "
 D N:$X>15 Q:'DN  W ?15 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 W "Metastasis-2:  "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,15) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D N:$X>1 Q:'DN  W ?1 W "General Summary Stage:  "
 D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,17) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D N:$X>49 Q:'DN  W ?49 W "Metastasis-3:  "
 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(12,Y)):DXS(12,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
