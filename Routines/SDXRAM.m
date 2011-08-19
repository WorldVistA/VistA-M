SDXRAM ; GENERATED FROM 'SD-AMB-RAM-DISPLAY' PRINT TEMPLATE (#230) ; 06/13/96 ; (FILE 409.81, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(230,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N W ?0 W ""
 D N:$X>0 Q:'DN  W ?0 W "RAM Group"
 D N:$X>19 Q:'DN  W ?19 W "Weight [1 - low ; 4 - high]"
 D N:$X>0 Q:'DN  W ?0 W "---------"
 D N:$X>19 Q:'DN  W ?19 W "------"
 S X=$G(^SD(409.81,D0,0)) D N:$X>0 Q:'DN  W ?0,$E($P(X,U,1),1,30)
 D N:$X>21 Q:'DN  W ?21 S Y=$P(X,U,2) W:Y]"" $J(Y,3,0)
 D T Q:'DN  D N W ?0 W ""
 D N:$X>4 Q:'DN  W ?4 W "Effective Date"
 D N:$X>24 Q:'DN  W ?24 W "Reimbursement"
 D N:$X>4 Q:'DN  W ?4 W "--------------"
 D N:$X>24 Q:'DN  W ?24 W "-------------"
 D N:$X>4 Q:'DN  W ?4 W "** Current **"
 D N:$X>21 Q:'DN  W ?21 S %=$O(^SD(409.82,"AIVDT",D0,(9999998-DT))) S X=$S('%:0,$D(^SD(409.82,+$O(^(%,0)),0)):$P(^(0),U,3),1:0) W:X'?."*" $J(X,11,2) K Y(409.81,203)
 S DIXX(1)="A1",I(0,0)=D0 S I(0,0)=$S($D(D0):D0,1:"") X DXS(1,9.2) S X="" S D0=I(0,0)
 G A1R
A1 ;
 I $D(DSC(409.82)) X DSC(409.82) E  Q
 W:$X>34 ! S I(100)="^SD(409.82,",J(100)=409.82
 S X=$G(^SD(409.82,D0,0)) D N:$X>4 Q:'DN  W ?4 S Y=$P(X,U,1) D DT
 D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,3) W:Y]"" $J(Y,10,2)
 Q
A1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X,X1=DIP(1) S %=X1 X:%]"" "F X=X:0 S %=%_X1 Q:$L(%)>X" S X=$E(%,1,X) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
