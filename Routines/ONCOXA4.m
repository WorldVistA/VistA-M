ONCOXA4 ; GENERATED FROM 'ONCOXA4' PRINT TEMPLATE (#839) ; 08/13/03 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(839,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Abstract Date: "
 S X=$G(^ONCO(165.5,D0,7)) S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "Status: "
 S X=$G(^ONCO(165.5,D0,7)) S Y=$P(X,U,2) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Date Printed: "
 S X=DT S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>39 Q:'DN  W ?39 W "Abstracter: "
 S X=$G(^ONCO(165.5,D0,7)) S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,35)
 D N:$X>2 Q:'DN  W ?2 W "Date of Last Patient Contact: "
 X DXS(1,9.2) S X=DIP(101) S D0=I(0,0) S Y=X K DIP K:DN Y S Y=X D DT
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
