MCOBRHA1 ; GENERATED FROM 'MCRHBRPR1' PRINT TEMPLATE (#1037) ; 10/04/96 ; (continued)
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
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "MEDICATION: "
 S I(1)=6,J(1)=701.0201 F D1=0:0 Q:$O(^MCAR(701,D0,6,D1))'>0  X:$D(DSC(701.0201)) DSC(701.0201) S D1=$O(^(D1)) Q:D1'>0  D:$X>0 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(701,D0,6,D1,0)) D N:$X>4 Q:'DN  W ?4 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 D N:$X>4 Q:'DN  W ?4,$E($P(X,U,2),1,10)
 D N:$X>4 Q:'DN  W ?4,$E($P(X,U,3),1,10)
 Q
A1R ;
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "DIAGNOSIS: "
 S I(1)=13,J(1)=701.0615 F D1=0:0 Q:$O(^MCAR(701,D0,13,D1))'>0  X:$D(DSC(701.0615)) DSC(701.0615) S D1=$O(^(D1)) Q:D1'>0  D:$X>0 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(701,D0,13,D1,0)) D N:$X>4 Q:'DN  W ?4 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(697.5,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,50)
 D N:$X>4 Q:'DN  W ?4 S Y=$P(X,U,2) D DT
 Q
B1R ;
 S I(1)="""ICD""",J(1)=701.01 F D1=0:0 Q:$O(^MCAR(701,D0,"ICD",D1))'>0  X:$D(DSC(701.01)) DSC(701.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(701,D0,"ICD",D1,0)) D N:$X>9 Q:'DN  S DIWL=10,DIWR=69 S Y=$P(X,U,2) S X=Y D ^DIWP
 D A^DIWW
 Q
C1R ;
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "PROCEDURE SUMMARY: "
 S X=$G(^MCAR(701,D0,.2)) D N:$X>9 Q:'DN  S DIWL=10,DIWR=69 S Y=$P(X,U,2) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N D N:$X>0 Q:'DN  W ?0 W "SUMMARY: "
 S X=$G(^MCAR(701,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(34,Y)):DXS(34,Y),1:Y)
 W ?0 S MCFILE=701 D DISP^MCMAG K DIP K:DN Y
 W ?11 K MCFILE K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
