IBXDIVD ; GENERATED FROM 'IB DIVISION DISPLAY' PRINT TEMPLATE (#240) ; 06/27/96 ; (FILE 40.8, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(240,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S X=$G(^DG(40.8,D0,0)) D T Q:'DN  D N W ?0,$E($P(X,U,1),1,35)
 D T Q:'DN  D N D N:$X>29 Q:'DN  W ?29 W "Wage"
 D N:$X>45 Q:'DN  W ?45 W "Non-Wage"
 D N:$X>2 Q:'DN  W ?2 W "Effective Date"
 D N:$X>19 Q:'DN  W ?19 W "Status"
 D N:$X>29 Q:'DN  W ?29 W "Percentage"
 D N:$X>45 Q:'DN  W ?45 W "Percentage"
 D N:$X>60 Q:'DN  W ?60 W "Locality Modifier"
 D N:$X>2 Q:'DN  W ?2 W "--------------"
 D N:$X>19 Q:'DN  W ?19 W "------"
 D N:$X>29 Q:'DN  W ?29 W "----------"
 D N:$X>45 Q:'DN  W ?45 W "----------"
 D N:$X>60 Q:'DN  W ?60 W "-----------------"
 S DIXX(1)="A1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(1,9.2) S X="" S D0=I(0,0)
 G A1R
A1 ;
 I $D(DSC(350.5)) X DSC(350.5) E  Q
 W:$X>79 ! S I(100)="^IBE(350.5,",J(100)=350.5
 S X=$G(^IBE(350.5,D0,0)) D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,1) D DT
 D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,5) W:Y]"" $J(Y,8,4)
 D N:$X>45 Q:'DN  W ?45 S Y=$P(X,U,6) W:Y]"" $J(Y,8,4)
 D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,7) W:Y]"" $J(Y,8,4)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N W ?0 W ""
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
