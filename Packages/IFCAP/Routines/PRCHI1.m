PRCHI1 ; GENERATED FROM 'PRCH ITEM TXHIST' PRINT TEMPLATE (#1193) ; 10/27/00 ; (FILE 442, MARGIN=80)
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
 S I(0)="^PRC(442,",J(0)=442
 S X=$G(^PRC(442,D0,1)) W ?0 S Y=$P(X,U,15) D DT
 S X=$G(^PRC(442,D0,0)) W ?13,$E($P(X,U,1),1,30)
 S I(1)=2,J(1)=442.01 F D1=0:0 Q:$O(^PRC(442,D0,2,D1))'>0  X:$D(DSC(442.01)) DSC(442.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>45 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRC(442,D0,2,D1,2)) D N:$X>24 Q:'DN  W ?24 S Y=$P(X,U,8) W:Y]"" $J(Y,10,2)
 S X=$G(^PRC(442,D0,2,D1,0)) W ?36 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^PRCD(420.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,2)
 D N:$X>42 Q:'DN  W ?42 W " "
 W ?45 D CALCCST^PRCHRPTX K DIP K:DN Y
 S X=$G(^PRC(442,D0,2,D1,2)) W ?56 S Y=$P(X,U,1) W:Y]"" $J(Y,10,2)
 S X=$G(^PRC(442,D0,2,D1,0)) W ?68 S Y=$P(X,U,2) W:Y]"" $J(Y,9,0)
 Q
A1R ;
 S X=$G(^PRC(442,D0,1)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^PRC(440,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,36)
 K Y
 Q
HEAD ;
 W !,?0,"Date"
 W !,?0,"Ordered",?13,"PO Number"
 W !,?26,"Quantity",?36,"Unit"
 W !,?26,"Previous",?36,"of"
 W !,?26,"Received",?36,"Purchase"
 W !,?69,"Quantity"
 W !,?45,"Unit Cost",?56,"Total Cost",?70,"Ordered"
 W !,?0,"VENDOR"
 W !,"--------------------------------------------------------------------------------",!!
