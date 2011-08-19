PRCATW2 ; GENERATED FROM 'PRCAP WAIVED' PRINT TEMPLATE (#402) ; 10/02/99 ; (FILE 433, MARGIN=80)
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
 S I(0)="^PRCA(433,",J(0)=433
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=75,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "BILL NO.: "
 S X=$G(^PRCA(433,D0,0)) D N:$X>12 Q:'DN  W ?12 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "WAIVED AMOUNT: "
 S X=$G(^PRCA(433,D0,1)) D N:$X>54 Q:'DN  W ?54 S Y=$P(X,U,5) W:Y]"" $J(Y,10,2)
 D N:$X>0 Q:'DN  W ?0 W "WAIVED DATE: "
 D N:$X>15 Q:'DN  W ?15 S Y=$P(X,U,1) D DT
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "FISCAL YEAR"
 D N:$X>19 Q:'DN  W ?19 W "WAIVED AMOUNT"
 D N:$X>34 Q:'DN  W ?34 W "PRIN.BAL. DUE"
 S I(1)=4,J(1)=433.01 F D1=0:0 Q:$O(^PRCA(433,D0,4,D1))'>0  X:$D(DSC(433.01)) DSC(433.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>49 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCA(433,D0,4,D1,0)) D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,30)
 D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,5) W:Y]"" $J(Y,10,2)
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) W:Y]"" $J(Y,11,2)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=75,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
