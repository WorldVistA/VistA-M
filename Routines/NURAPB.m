NURAPB ; GENERATED FROM 'NURA-P-EXCEPTION' PRINT TEMPLATE (#568) ; 06/10/97 ; (FILE 213.5, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(568,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S I(1)=1,J(1)=213.51 F D1=0:0 Q:$O(^NURSA(213.5,D0,1,D1))'>0  X:$D(DSC(213.51)) DSC(213.51) S D1=$O(^(D1)) Q:D1'>0  D:$X>0 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^NURSA(213.5,D0,1,D1,0)) D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,3) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>49 Q:'DN  W ?49 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>62 Q:'DN  W ?62 S Y=$P(X,U,5) D DT
 Q
A1R ;
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
