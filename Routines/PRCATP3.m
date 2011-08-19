PRCATP3 ; GENERATED FROM 'PRCA VENDOR PROFILE' PRINT TEMPLATE (#428) ; 05/04/10 ; (FILE 430, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(428,"DXS")
 S I(0)="^PRCA(430,",J(0)=430
 W ?0 S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100) S Y=X K DIP K:DN Y S Y=X D DT
 W ?20 W " ACCOUNTS RECEIVABLE PROFILE"
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=$G(X) S X=75,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "NAME: "
 S X=$G(^PRCA(430,D0,0)) S Y=$P(X,U,9) S C=$P(^DD(430,9,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "BILL #: "
 W ?0,$E($P(X,U,1),1,30)
 W ?49 D EN2^PRCADR1 K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "CURRENT STATUS: "
 S X=$G(^PRCA(430,D0,0)) S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^PRCA(430.3,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "CATEGORY: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430.2,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W "CP: "
 S X=$G(^PRCA(430,D0,11)) W ?0,$E($P(X,U,1),1,15)
 D N:$X>39 Q:'DN  W ?39 W "FUND (APPROPRIATION): "
 W ?0,$E($P(X,U,17),1,6)
 D N:$X>39 Q:'DN  W ?39 W "DATE BILL PREPARED: "
 S X=$G(^PRCA(430,D0,0)) S Y=$P(X,U,10) D DT
 W ?61 D EN1^PRCADR1 K DIP K:DN Y
 D T Q:'DN  W ?2 D EN3^PRCADR K DIP K:DN Y
 W ?13 D EN5^PRCADR Q:$D(PRCA("HALT"))  W "" K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "TRANSACTIONS: "
 W ?16 D EN2^PRCADR K DIP K:DN Y
 W ?27 Q:$D(PRCA("HALT"))  W "" K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "BILL RESULTING FROM: "
 W ?23 X DXS(1,9) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "Date"
 D N:$X>11 Q:'DN  W ?11 W "Description"
 D N:$X>34 Q:'DN  W ?34 W "Quantity"
 D N:$X>45 Q:'DN  W ?45 W "Units"
 D N:$X>53 Q:'DN  W ?53 W "Cost"
 D N:$X>63 Q:'DN  W ?63 W "Total Cost"
 D N:$X>0 Q:'DN  W ?0 W "================================================================================"
 S I(1)=101,J(1)=430.02 F D1=0:0 Q:$O(^PRCA(430,D0,101,D1))'>0  X:$D(DSC(430.02)) DSC(430.02) S D1=$O(^(D1)) Q:D1'>0  D:$X>82 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(2,9) K DIP K:DN Y W X
 S X=$G(^PRCA(430,D0,101,D1,0)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^PRCD(420.5,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,5)
 D N:$X>53 Q:'DN  W ?53 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,4),DIP(2)=$G(X) S X=0,DIP(3)=$G(X) S X=4,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,6),DIP(2)=$G(X) S X=0,DIP(3)=$G(X) S X=2,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 S I(2)=1,J(2)=430.22 F D2=0:0 Q:$O(^PRCA(430,D0,101,D1,1,D2))'>0  S D2=$O(^(D2)) D:$X>74 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^PRCA(430,D0,101,D1,1,D2,0)) S DIWL=12,DIWR=78 D ^DIWP
 Q
A2R ;
 D 0^DIWW
 D ^DIWW
 Q
A1R ;
 D T Q:'DN  W ?2 D EN4^PRCADR1 K DIP K:DN Y
 W ?13 Q:'$D(PRCA("WROFF"))  K DXS S D0=PRCA("WROFF") D ^PRCATW1 K DXS K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
