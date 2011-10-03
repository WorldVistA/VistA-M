MCOBPF ; GENERATED FROM 'MCPFTBRPR1' PRINT TEMPLATE (#1038) ; 07/25/98 ; (FILE 700, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1038,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N W ?0 W "SUMMARY: "
 S X=$G(^MCAR(700,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D T Q:'DN  D N W ?0 W "PROCEDURE SUMMARY:  "
 W ?0,$E($P(X,U,2),1,79)
 D T Q:'DN  D N W ?0 W "INTERPRETATION:"
 W ?17 D COMP^MCPFTP5 K DIP K:DN Y
 S I(1)=25,J(1)=700.04 F D1=0:0 Q:$O(^MCAR(700,D0,25,D1))'>0  S D1=$O(^(D1)) D:$X>28 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(700,D0,25,D1,0)) S DIWL=18,DIWR=80 D ^DIWP
 Q
A1R ;
 D A^DIWW
 D T Q:'DN  D N W ?0 W "INTERPRETED BY:  "
 S I(1)=7,J(1)=700.021 F D1=0:0 Q:$O(^MCAR(700,D0,7,D1))'>0  X:$D(DSC(700.021)) DSC(700.021) S D1=$O(^(D1)) Q:D1'>0  D:$X>19 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(700,D0,7,D1,0)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 Q
B1R ;
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
