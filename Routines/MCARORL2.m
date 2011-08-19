MCARORL2 ; GENERATED FROM 'MCRHLAB' PRINT TEMPLATE (#1009) ; 10/04/96 ; (continued)
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
 D N:$X>0 Q:'DN  W ?0 W "Protrhombin time"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,430)) ^(430) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "Partial thromboplastin"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,431)) ^(431) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "IRON"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,750)) ^(750) K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "TIBC"
 D N:$X>27 Q:'DN  W ?27 W:$D(^UTILITY("DIQ1",$J,63.04,DA,748)) ^(748) K DIP K:DN Y
 F Y=0:0 Q:$Y>(IOSL-3)  W !
 D N:$X>0 Q:'DN  W ?0 W " "
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
