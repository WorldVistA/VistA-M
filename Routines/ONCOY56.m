ONCOY56 ; GENERATED FROM 'ONCOY56' PRINT TEMPLATE (#814) ; 04/10/06 ; (FILE 165.5, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(814,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D T Q:'DN  D N W ?0 W "* RECURRENCES *"
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Type of First Recurrence......:"
 S X=$G(^ONCO(165.5,D0,5)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOPCE W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,5)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,2) S Y(0)=Y S:Y'="" Y=$P($G(^ONCO(160.12,Y,0)),U,2) W $E(Y,1,34)
 D N:$X>2 Q:'DN  W ?2 W "Distant Site 1................:"
 S X=$G(^ONCO(165.5,D0,5)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Distant Site 2................:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Distant Site 3................:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 S I(1)=23,J(1)=165.572 F D1=0:0 Q:$O(^ONCO(165.5,D0,23,D1))'>0  X:$D(DSC(165.572)) DSC(165.572) S D1=$O(^(D1)) Q:D1'>0  D:$X>58 T Q:'DN  D A1
 G A1R
A1 ;
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 W "Type of Subsequent Recurrence.:"
 S X=$G(^ONCO(165.5,D0,23,D1,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,1) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 S X=$G(^ONCO(165.5,D0,23,D1,0)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,2) S Y(0)=Y S:Y'="" Y=$P(^ONCO(160.12,Y,0),"^",2) W $E(Y,1,34)
 D N:$X>2 Q:'DN  W ?2 W "Distant Site 1................:"
 S X=$G(^ONCO(165.5,D0,23,D1,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Distant Site 2................:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "Distant Site 3................:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 Q
A1R ;
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
