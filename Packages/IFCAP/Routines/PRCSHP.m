PRCSHP ; GENERATED FROM 'PRCS CP ITEMHIST' PRINT TEMPLATE (#1190) ; 10/27/00 ; (FILE 410, MARGIN=80)
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
 S I(0)="^PRCS(410,",J(0)=410
 S X=$G(^PRCS(410,D0,7)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,5) D DT
 D N:$X>12 Q:'DN  W ?12 S DIP(1)=$S($D(^PRCS(410,D0,0)):^(0),1:""),DIP(2)=$S($D(^(4)):^(4),1:"") S X=$P(DIP(1),U,5)_"-"_$P(DIP(2),U,5) K DIP K:DN Y W X
 S I(1)="""IT""",J(1)=410.02 F D1=0:0 Q:$O(^PRCS(410,D0,"IT",D1))'>0  X:$D(DSC(410.02)) DSC(410.02) S D1=$O(^(D1)) Q:D1'>0  D:$X>23 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCS(410,D0,"IT",D1,0)) D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,13) W:Y]"" $J(Y,7,0)
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,3) S Y=$S(Y="":Y,$D(^PRCD(420.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,2)
 D N:$X>38 Q:'DN  W ?38 S Y=$P(X,U,7) W:Y]"" $J(Y,11,2)
 D N:$X>58 Q:'DN  W ?58 S DIP(1)=$S($D(^PRCS(410,D0,"IT",D1,0)):^(0),1:"") S X=$P(DIP(1),U,7)*$P(DIP(1),U,2) K DIP K:DN Y W:X'?."*" $J(X,8,2)
 S X=$G(^PRCS(410,D0,"IT",D1,0)) D N:$X>67 Q:'DN  W ?67 S Y=$P(X,U,2) W:Y]"" $J(Y,9,0)
 Q
A1R ;
 D N:$X>0 Q:'DN  W ?0 W "VENDOR: **"
 S X=$G(^PRCS(410,D0,2)) W ?12,$E($P(X,U,1),1,30)
 K Y
 Q
HEAD ;
 W !,?25,"QUANTITY"
 W !,?0,"DATE SIGNED",?12,"STATION",?25,"RECEIVED"
 W !,?0,"(APPROVED)",?12,"NUMBER_",?25,"(PRIMARY)"
 W !,?34,"UNIT"
 W !,?34,"OF"
 W !,?34,"PURCHASE"
 W !,?62,"EST."
 W !,?62,"ITEM"
 W !,?40,"EST. ITEM",?60,"(UNIT)"
 W !,?38,"(UNIT) COST",?58,"COST*QUANTITY"
 W !,?68,"QUANTITY"
 W !,?12,"VENDOR"
 W !,"--------------------------------------------------------------------------------",!!
