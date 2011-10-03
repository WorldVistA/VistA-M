ONCOXP1 ; GENERATED FROM 'ONCO XPATIENT DATA' PRINT TEMPLATE (#774) ; 03/11/05 ; (FILE 160, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(774,"DXS")
 S I(0)="^ONCO(160,",J(0)=160
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "Place of Birth: "
 S X=$G(^ONCO(160,D0,0)) D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^ONCO(165.2,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,40)
 D N:$X>54 Q:'DN  W ?54 W "Race: "
 D N:$X>60 Q:'DN  W ?60 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^ONCO(164.46,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,19)
 D N:$X>4 Q:'DN  W ?4 W "Spanish origin: "
 D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>54 Q:'DN  W ?54 W "Sex: "
 D N:$X>60 Q:'DN  W ?60 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
