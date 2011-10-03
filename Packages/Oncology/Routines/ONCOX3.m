ONCOX3 ; GENERATED FROM 'ONCOX3' PRINT TEMPLATE (#844) ; 06/27/02 ; (FILE 165.5, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(844,"DXS")
 S I(0)="^ONCO(165.5,",J(0)=165.5
 S I(100)="^ONCO(160,",J(100)=160 S I(0,0)=D0 S DIP(1)=$S($D(^ONCO(165.5,D0,0)):^(0),1:"") S X=$P(DIP(1),U,2),X=X S D(0)=+X S D0=D(0) I D0>0 D A1
 G A1R
A1 ;
 D T Q:'DN  D N W ?0 X DXS(1,9) K DIP K:DN Y W X
 D T Q:'DN  D N W ?0 W " "
 S I(200)="^ONCO(160,",J(200)=160 X DXS(2,9.3) S X=$P(DIP(201),U,1) X DXS(2,9.2) S X=X S D0=I(100,0) S D0=D(0) I D0>0 D A2
 G A2R
A2 ;
 S I(201)=9,J(201)=160.044 F D1=0:0 Q:$O(^ONCO(160,D0,9,D1))'>0  X:$D(DSC(160.044)) DSC(160.044) S D1=$O(^(D1)) Q:D1'>0  D:$X>3 T Q:'DN  D A3
 G A3R
A3 ;
 D N:$X>1 Q:'DN  W ?1 W "Family Member with Cancer:  "
 X DXS(3,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 D N:$X>47 Q:'DN  W ?47 W "Cancer:  "
 X DXS(4,9.2) X "F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S X=$E(X,0,%-1)_$C($A(X,%)+32)_$E(X,%+1,999)" K DIP K:DN Y W X
 Q
A3R ;
 Q
A2R ;
 K J(200),I(200) S:$D(I(100,0)) D0=I(100,0)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y
 Q
HEAD ;
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
