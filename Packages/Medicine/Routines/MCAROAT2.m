MCAROAT2 ; GENERATED FROM 'MCAREP2' PRINT TEMPLATE (#1041) ; 10/04/96 ; (continued)
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
 D ^DIWW
 S I(1)=4,J(1)=691.922 F D1=0:0 Q:$O(^MCAR(691.9,D0,4,D1))'>0  X:$D(DSC(691.922)) DSC(691.922) S D1=$O(^(D1)) Q:D1'>0  D:$X>81 NX^DIWW D E1
 G E1R
E1 ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "DISCHARGE DATE: "
 S X=$G(^MCAR(691.9,D0,4,D1,0)) W ?22 S Y=$P(X,U,1) D DT
 D N:$X>7 Q:'DN  W ?7 W "MEDICATIONS ON DISCHARGE: "
 W ?0,$E($P(X,U,2),1,40)
 Q
E1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
