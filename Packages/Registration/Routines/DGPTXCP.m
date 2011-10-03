DGPTXCP ; GENERATED FROM 'DGPT QUICK PROFILE' PRINT TEMPLATE (#216) ; 06/26/96 ; (FILE 45.86, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(216,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "Census Period Start Date: "
 S X=$G(^DG(45.86,D0,0)) W ?28 S Y=$P(X,U,5) D DT
 D N:$X>0 Q:'DN  W ?0 W "Census Period End   Date: "
 W ?28 S Y=$P(X,U,1) D DT
 W ?41 W "   [CENSUS DATE]"
 D T Q:'DN  D N W ?0 W ""
 D N:$X>0 Q:'DN  W ?0 W "          Close-out Date: "
 W ?28 S Y=$P(X,U,2) D DT
 D N:$X>0 Q:'DN  W ?0 W "      OK to transmit PTF: "
 W ?28 S Y=$P(X,U,3) D DT
 D T Q:'DN  D N W ?0 W ""
 D N:$X>0 Q:'DN  W ?0 W " Currently Active Census: "
 W ?28 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "   WorkFile Last Updated: "
 W ?28 S Y=$P(X,U,6) D DT
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
