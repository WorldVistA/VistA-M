PRCATR1 ; GENERATED FROM 'PRCAP REPAYMENT' PRINT TEMPLATE (#404) ; 06/27/96 ; (FILE 430, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(404,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "BILL NO.: "
 S X=$G(^PRCA(430,D0,0)) D N:$X>11 Q:'DN  W ?11,$E($P(X,U,1),1,30)
 D N:$X>34 Q:'DN  W ?34 W "DEBTOR:"
 D N:$X>44 Q:'DN  W ?44 S Y=$P(X,U,9) S C=$P(^DD(430,9,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W "CURRENT BALANCE: "
 D N:$X>18 Q:'DN  W ?18 S Y(430,11,1)=$S($D(^PRCA(430,D0,7)):^(7),1:"") S X=$P(Y(430,11,1),U,1)+$P(Y(430,11,1),U,2)+$P(Y(430,11,1),U,3)+$P(Y(430,11,1),U,4)+$P(Y(430,11,1),U,5) S X=$J(X,0,2) W $E(X,1,12) K Y(430,11)
 D N:$X>34 Q:'DN  W ?34 W "REPAYMENT AMOUNT: "
 S X=$G(^PRCA(430,D0,4)) D N:$X>54 Q:'DN  W ?54 S Y=$P(X,U,3) W:Y]"" $J(Y,10,2)
 D T Q:'DN  D N D N:$X>24 Q:'DN  W ?24 W "REPAYMENT SCHEDULE"
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X S X=72,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "DUE"
 D N:$X>17 Q:'DN  W ?17 W "PAYMENT"
 D N:$X>34 Q:'DN  W ?34 W "SEND PAYMENT"
 D N:$X>54 Q:'DN  W ?54 W "DATE SENT PAYMENT"
 D N:$X>0 Q:'DN  W ?0 W "DATE"
 D N:$X>17 Q:'DN  W ?17 W "RECEIVED"
 D N:$X>34 Q:'DN  W ?34 W "STATEMENT"
 D N:$X>54 Q:'DN  W ?54 W "STATEMENT"
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X S X=72,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 S I(1)=5,J(1)=430.051 F D1=0:0 Q:$O(^PRCA(430,D0,5,D1))'>0  X:$D(DSC(430.051)) DSC(430.051) S D1=$O(^(D1)) Q:D1'>0  D:$X>11 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCA(430,D0,5,D1,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1) D DT
 D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>54 Q:'DN  W ?54 S Y=$P(X,U,5) D DT
 Q
A1R ;
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X S X=72,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
