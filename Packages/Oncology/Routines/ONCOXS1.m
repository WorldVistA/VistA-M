ONCOXS1 ; GENERATED FROM 'ONCO XADMISSION' PRINT TEMPLATE (#835) ; 08/13/05 ; (FILE 165.5, MARGIN=80)
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
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D N:$X>4 Q:'DN  W ?4 W "Site/Gp: "
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^ONCO(164.2,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>49 Q:'DN  W ?49 W "Date of First Contact: "
 D N:$X>66 Q:'DN  W ?66 S Y=$P(X,U,35) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,11)
 D N:$X>4 Q:'DN  W ?4 W "Date Dx: "
 S X=$G(^ONCO(165.5,D0,0)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,16) S Y(0)=Y S X=Y D DATEOT^ONCOES W $J(Y,13)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
