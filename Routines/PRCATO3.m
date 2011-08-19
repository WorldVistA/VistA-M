PRCATO3 ; GENERATED FROM 'PRCAP COST' PRINT TEMPLATE (#400) ; 06/27/96 ; (FILE 433, MARGIN=80)
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
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=79,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "BILL N0.: "
 S X=$G(^PRCA(433,D0,0)) D N:$X>12 Q:'DN  W ?12 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,12)
 D N:$X>34 Q:'DN  W ?34 W "TRANSACTION DATE: "
 S X=$G(^PRCA(433,D0,1)) D N:$X>54 Q:'DN  W ?54 S Y=$P(X,U,1) D DT
 D N:$X>0 Q:'DN  W ?0 W "TYPE: "
 D N:$X>11 Q:'DN  W ?11 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>34 Q:'DN  W ?34 W "TOTAL TRANS. AMOUNT: "
 D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,5) W:Y]"" $J(Y,10,2)
 D N:$X>0 Q:'DN  W ?0 W "IRS LOC. COST: "
 S X=$G(^PRCA(433,D0,2)) W ?17 S Y=$P(X,U,1) W:Y]"" $J(Y,8,2)
 D N:$X>34 Q:'DN  W ?34 W "CREDIT REP.COST: "
 W ?53 S Y=$P(X,U,2) W:Y]"" $J(Y,8,2)
 D N:$X>0 Q:'DN  W ?0 W "DMV LOC.COST: "
 W ?16 S Y=$P(X,U,3) W:Y]"" $J(Y,8,2)
 D N:$X>34 Q:'DN  W ?34 W "CONSUMER REP.AGENCY COST: "
 W ?62 S Y=$P(X,U,4) W:Y]"" $J(Y,8,2)
 D N:$X>0 Q:'DN  W ?0 W "MARSHAL FEE: "
 W ?15 S Y=$P(X,U,5) W:Y]"" $J(Y,9,2)
 D N:$X>34 Q:'DN  W ?34 W "COURT COST: "
 W ?48 S Y=$P(X,U,6) W:Y]"" $J(Y,9,2)
 W ?59 I $D(PRCASUP) D EN2^PRCAEXM K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=79,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
