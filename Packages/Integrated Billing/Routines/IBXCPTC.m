IBXCPTC ; GENERATED FROM 'IB CPT CP DISPLAY' PRINT TEMPLATE (#238) ; 06/27/96 ; (FILE 350.71, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(238,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S X=$G(^IBE(350.71,D0,0)) D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,59)
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "CHECK-OFF SHEET"
 D N:$X>60 Q:'DN  W ?60 W "PRINT ORDER"
 D N:$X>1 Q:'DN  W ?1 W "---------------"
 D N:$X>60 Q:'DN  W ?60 W "-----------"
 D N:$X>1 Q:'DN  W ?1 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^IBE(350.7,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>60 Q:'DN  W ?60 S Y=$P(X,U,2) W:Y]"" $J(Y,7,0)
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "PROCEDURES"
 D N:$X>60 Q:'DN  W ?60 W "PRINT ORDER"
 D N:$X>73 Q:'DN  W ?73 W "CHARGE"
 D N:$X>1 Q:'DN  W ?1 W "----------"
 D N:$X>60 Q:'DN  W ?60 W "-----------"
 D N:$X>73 Q:'DN  W ?73 W "------"
 S DIXX(1)="A1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(1,9.2) S X="" S D0=I(0,0)
 G A1R
A1 ;
 I $D(DSC(350.71)) X DSC(350.71) E  Q
 W:$X>81 ! S I(100)="^IBE(350.71,",J(100)=350.71
 D N:$X>1 Q:'DN  W ?1 X DXS(2,9.2) S X=$S('$D(^ICPT(+$P(DIP(201),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(100,0) K DIP K:DN Y W X
 S X=$G(^IBE(350.71,D0,0)) D N:$X>8 Q:'DN  W ?8,$E($P(X,U,1),1,51)
 D N:$X>60 Q:'DN  W ?60 S Y=$P(X,U,2) W:Y]"" $J(Y,7,0)
 D N:$X>71 Q:'DN  W ?71 X ^DD(350.71,.08,9.4) S X1=Y(350.71,.08,1) S IBCDX=X,IBDTX=X1 D FCC^IBEFUNC1 S X=IBCHGX K IBCDX,IBDTX,IBCHGX S X=X S D0=Y(350.71,.08,80) S X=$J(X,0,2) W:X'?."*" $J(X,8,2) K Y(350.71,.08)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
