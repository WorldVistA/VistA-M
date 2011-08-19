PRCATO2 ; GENERATED FROM 'PRCA DISP AUDIT' PRINT TEMPLATE (#395) ; 03/30/98 ; (FILE 430, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(395,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S DIWF="W"
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=80,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "BILL #: "
 S X=$G(^PRCA(430,D0,0)) W ?10,$E($P(X,U,1),1,30)
 D N:$X>29 Q:'DN  W ?29 W "CATEGORY: "
 W ?41 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>41 Q:'DN  W ?41 S Y=$P(X,U,16) S Y=$S(Y="":Y,$D(^PRCA(430.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W "DATE BILL PREPARED:"
 D N:$X>20 Q:'DN  W ?20 S Y=$P(X,U,10) D DT
 W ?33 I $D(PRCAT),PRCAT["T" D PATNM^PRCADR1 K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "DEBTOR: "
 S X=$G(^PRCA(430,D0,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,9) S C=$P(^DD(430,9,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 W ?41 S PRCALN=9 D EN2^PRCADR1 K PRCALN K DIP K:DN Y
 W ?52 I $D(PRCAT),PRCAT["T" D EN6^PRCADR1 K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "RECEIVABLE CODE: "
 W ?19 X DXS(1,9.2) S DIP(101)=$S($D(^RCD(340,D0,0)):^(0),1:"") S X=$P($P(DIP(102),$C(59)_$P(DIP(101),U,5)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 W ?30 D RESULT^PRCAEIN K DIP K:DN Y
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 X DXS(2,9.2) S DIP(101)=$S($D(^DIC(49,D0,0)):^(0),1:"") S X=$P(DIP(101),U,2),Y=X,X=DIP(1),X=X_Y_" BY : " S D0=I(0,0) K DIP K:DN Y W X
 S X=$G(^PRCA(430,D0,104)) W ?11 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "Date"
 D N:$X>11 Q:'DN  W ?11 W "Description"
 D N:$X>34 Q:'DN  W ?34 W "Quantity"
 D N:$X>45 Q:'DN  W ?45 W "Units"
 D N:$X>53 Q:'DN  W ?53 W "Cost"
 D N:$X>63 Q:'DN  W ?63 W "Total Cost"
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=80,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 S I(1)=101,J(1)=430.02 F D1=0:0 Q:$O(^PRCA(430,D0,101,D1))'>0  X:$D(DSC(430.02)) DSC(430.02) S D1=$O(^(D1)) Q:D1'>0  D:$X>11 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) K DIP K:DN Y W X
 D N:$X>34 Q:'DN  W ?34 X DXS(3,9) K DIP K:DN Y W X
 S X=$G(^PRCA(430,D0,101,D1,0)) D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^PRCD(420.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,5)
 D N:$X>53 Q:'DN  W ?53 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,4),DIP(2)=X S X=1,DIP(3)=X S X=4,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 S DIP(1)=$S($D(^PRCA(430,D0,101,D1,0)):^(0),1:"") S X=$P(DIP(1),U,6),DIP(2)=X S X=1,DIP(3)=X S X=2,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 S I(2)=1,J(2)=430.22 F D2=0:0 Q:$O(^PRCA(430,D0,101,D1,1,D2))'>0  S D2=$O(^(D2)) D:$X>74 T Q:'DN  D A2
 G A2R
A2 ;
 S X=$G(^PRCA(430,D0,101,D1,1,D2,0)) S DIWL=12,DIWR=78 D ^DIWP
 Q
A2R ;
 D A^DIWW
 Q
A1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
