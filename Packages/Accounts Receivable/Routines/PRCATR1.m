PRCATR1 ; GENERATED FROM 'PRCAP REPAYMENT' PRINT TEMPLATE (#404) ; 05/23/22 ; (FILE 430, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 X ^DD("DD")
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 M DXS=^DIPT(404,"DXS")
 S I(0)="^PRCA(430,",J(0)=430
 D N:$X>0 Q:'DN  W ?0 W "BILL NO.: "
 S X=$G(^PRCA(430,D0,0)) D N:$X>11 Q:'DN  W ?11,$E($P(X,U,1),1,14)
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
 S I(1)=5,J(1)=430.051 F D1=0:0 Q:$O(^PRCA(430,D0,5,D1))'>0  X $G(DSC(430.051))  S D1=$O(^(D1)) Q:D1'>0   D:$X>11 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCA(430,D0,5,D1,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1) D DT
 D N:$X>17 Q:'DN  W ?17 S Y=$P(X,U,2) W:Y]"" $E($$SET^DIQ(430.051,1,Y),1,3)
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,3) W:Y]"" $E($$SET^DIQ(430.051,2,Y),1,3)
 D N:$X>54 Q:'DN  W ?54 S Y=$P(X,U,5) D DT
 Q
A1R ;
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X S X=72,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
