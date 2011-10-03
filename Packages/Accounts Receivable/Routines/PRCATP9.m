PRCATP9 ; GENERATED FROM 'PRCAT NEW TRANS' PRINT TEMPLATE (#399) ; 10/02/99 ; (FILE 433, MARGIN=80)
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
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=79,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "TRANSACTION NO.:"
 S X=$G(^PRCA(433,D0,0)) S Y=$P(X,U,1) W:Y]"" $J(Y,7,0)
 D N:$X>0 Q:'DN  W ?0 W "BILL NO.: "
 D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 W ?14 S PRCABN=$P(X,U,2) K DIP K:DN Y
 S I(100)="^PRCA(430,",J(100)=430 S I(0,0)=D0 S DIP(1)=$S($D(^PRCA(433,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 D N:$X>39 Q:'DN  W ?39 S DIP(101)=$S($D(^PRCA(430,D0,0)):^(0),1:"") S X="CATEGORY:  "_$S('$D(^PRCA(430.2,+$P(DIP(101),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W $E(X,1,25)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D N:$X>0 Q:'DN  W ?0 W "TRANS.DATE: "
 S X=$G(^PRCA(433,D0,1)) D N:$X>14 Q:'DN  W ?14 S Y=$P(X,U,1) D DT
 D N:$X>39 Q:'DN  W ?39 W "TRANS.TYPE: "
 D N:$X>52 Q:'DN  W ?52 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "FY"
 D N:$X>9 Q:'DN  W ?9 W "APPROP.SYMBOL"
 D N:$X>29 Q:'DN  W ?29 W "TRANS.AMOUNT"
 S I(1)=4,J(1)=433.01 F D1=0:0 Q:$O(^PRCA(433,D0,4,D1))'>0  X:$D(DSC(433.01)) DSC(433.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>43 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^PRCA(433,D0,4,D1,0)) D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,30)
 W ?32 D APPR^PRCALM K DIP K:DN Y
 S X=$G(^PRCA(433,D0,4,D1,0)) D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,5) W:Y]"" $J(Y,10,2)
 Q
B1R ;
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=79,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
