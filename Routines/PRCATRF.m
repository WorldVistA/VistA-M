PRCATRF ; GENERATED FROM 'PRCARFD' PRINT TEMPLATE (#435) ; 06/27/96 ; (FILE 430, MARGIN=80)
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
 S X=$G(^PRCA(430,D0,0)) W ?0,$E($P(X,U,1),1,30)
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,9) S C=$P(^DD(430,9,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 S X=$G(^PRCA(430,D0,7)) W ?46 S Y=$P(X,U,19) D DT
 D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,18) W:Y]"" $J(Y,10,2)
 D T Q:'DN  W ?46 S Y=$P(X,U,21) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 K Y
 Q
HEAD ;
 W !,?0,"BILL NO."
 W !,?46,"REFUNDED",?65,"REFUNDED"
 W !,?14,"DEBTOR",?46,"DATE",?67,"AMOUNT"
 W !
 W !,?46,"REFUNDED BY"
 W !,"--------------------------------------------------------------------------------",!!
