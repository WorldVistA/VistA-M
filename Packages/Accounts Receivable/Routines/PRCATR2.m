PRCATR2 ; GENERATED FROM 'PRCAA AMEND AUDIT' PRINT TEMPLATE (#417) ; 06/27/96 ; (FILE 430, MARGIN=80)
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
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=79,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "BILL NO.:"
 S X=$G(^PRCA(430,D0,0)) D N:$X>10 Q:'DN  W ?10,$E($P(X,U,1),1,30)
 D N:$X>34 Q:'DN  W ?34 W "DEBTOR:"
 D N:$X>44 Q:'DN  W ?44 S Y=$P(X,U,9) S C=$P(^DD(430,9,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W "ORIGINAL AMOUNT:"
 D N:$X>16 Q:'DN  W ?16 S DIP(1)=$S($D(^PRCA(430,D0,0)):^(0),1:"") S X=" $"_$P(DIP(1),U,3) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 W "CATEGORY:"
 S X=$G(^PRCA(430,D0,0)) D N:$X>44 Q:'DN  W ?44 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "<<RETURNED>>"
 D N:$X>0 Q:'DN  W ?0 W "DATE:"
 S X=$G(^PRCA(430,D0,3)) D N:$X>6 Q:'DN  W ?6 S Y=$P(X,U,1) D DT
 D N:$X>34 Q:'DN  W ?34 S DIP(1)=$S($D(^PRCA(430,D0,3)):^(3),1:"") S X="BY: "_$S('$D(^VA(200,+$P(DIP(1),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "REASON:"
 W ?9 S PRCAPC=6 D PRCOMM^PRCALST K PRCAPC K DIP K:DN Y
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "<<AMENDED>>"
 D N:$X>0 Q:'DN  W ?0 W "DATE:"
 S X=$G(^PRCA(430,D0,3)) D N:$X>6 Q:'DN  W ?6 S Y=$P(X,U,3) D DT
 D N:$X>34 Q:'DN  W ?34 S DIP(1)=$S($D(^PRCA(430,D0,3)):^(3),1:"") S X="AMENDED BY: "_$S('$D(^VA(200,+$P(DIP(1),U,4),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^PRCA(430,D0,3)):^(3),1:"") S X="AMENDED AMOUNT: $"_$P(DIP(1),U,5) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "COMMENTS:"
 W ?11 S PRCAPC=7 D PRCOMM^PRCALST K PRCAPC K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=79,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
