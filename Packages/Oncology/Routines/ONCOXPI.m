ONCOXPI ; GENERATED FROM 'ONCO XPATIENT INFO' PRINT TEMPLATE (#1276) ; 08/13/03 ; (FILE 160, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(1276,"DXS")
 S I(0)="^ONCO(160,",J(0)=160
 D T Q:'DN  D N D N:$X>9 Q:'DN  W ?9 W "SSN:"
 D N:$X>13 Q:'DN  W ?13 D SSN^ONCOES W $J(X,12) K Y(160,2)
 D N:$X>43 Q:'DN  W ?43 W "Race: "
 S X=$G(^ONCO(160,D0,0)) D N:$X>49 Q:'DN  W ?49 S Y=$P(X,U,6) S Y=$S(Y="":Y,$D(^ONCO(164.46,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,50)
 D N:$X>9 Q:'DN  W ?9 W "DOB: "
 D N:$X>14 Q:'DN  W ?14 D DOB^ONCOES W $E(X,1,10) K Y(160,3)
 D N:$X>44 Q:'DN  W ?44 W "Sex: "
 S X=$G(^ONCO(160,D0,0)) D N:$X>49 Q:'DN  W ?49 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,?14,"DOB"
 W !,"--------------------------------------------------------------------------------",!!
