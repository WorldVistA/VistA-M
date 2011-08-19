PRCATP7 ; GENERATED FROM 'PRCAT NEW AR' PRINT TEMPLATE (#409) ; 10/02/99 ; (FILE 430, MARGIN=80)
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
 S I(0)="^PRCA(430,",J(0)=430
 W ?0 W:$D(IOF) @IOF K DIP K:DN Y
 D T Q:'DN  D N D N D N D N:$X>27 Q:'DN  W ?27 W "NEW ACCOUNTS RECEIVABLE"
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=80,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>3 Q:'DN  W ?3 W "BILL NO.:"
 S X=$G(^PRCA(430,D0,0)) D N:$X>14 Q:'DN  W ?14,$E($P(X,U,1),1,30)
 D N:$X>40 Q:'DN  W ?40 W "NAME:"
 D N:$X>48 Q:'DN  W ?48 S Y=$P(X,U,9) S C=$P(^DD(430,9,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>3 Q:'DN  W ?3 W "STATUS:"
 D N:$X>12 Q:'DN  W ?12 S Y=$P(X,U,8) S Y=$S(Y="":Y,$D(^PRCA(430.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>40 Q:'DN  W ?40 W "CATEGORY:"
 D N:$X>51 Q:'DN  W ?51 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>3 Q:'DN  W ?3 W "GL NO.:"
 D N:$X>12 Q:'DN  W ?12,$E($P(X,U,4),1,4)
 D N:$X>40 Q:'DN  W ?40 W "DATE BILL PREPARED:"
 D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,10) D DT
 D T Q:'DN  D N D N:$X>3 Q:'DN  W ?3 W "FISCAL YEAR"
 D N:$X>19 Q:'DN  W ?19 W "APPROPRIATION SYMBOL"
 D N:$X>44 Q:'DN  W ?44 W "AMOUNT"
 S I(1)=2,J(1)=430.01 F D1=0:0 Q:$O(^PRCA(430,D0,2,D1))'>0  X:$D(DSC(430.01)) DSC(430.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>52 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCA(430,D0,2,D1,0)) D N:$X>5 Q:'DN  W ?5,$E($P(X,U,1),1,30)
 D N:$X>21 Q:'DN  W ?21,$E($P(X,U,4),1,30)
 D N:$X>40 Q:'DN  W ?40 S Y=$P(X,U,8) W:Y]"" $J(Y,10,2)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>3 Q:'DN  W ?3 W "BILL RESULTING FROM:"
 S X=$G(^PRCA(430,D0,0)) D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,5) S Y(0)=Y I $D(^PRCA(430.6,+Y,0)) S Y=$P(^PRCA(430.6,+Y,0),U,2) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>3 Q:'DN  W ?3 W "SIGNATURE CODE:"
 S X=$G(^PRCA(430,D0,9)) D N:$X>21 Q:'DN  W ?21 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=80,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
