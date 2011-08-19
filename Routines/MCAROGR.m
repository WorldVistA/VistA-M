MCAROGR ; GENERATED FROM 'MCARGIRCLI' PRINT TEMPLATE (#981) ; 10/04/96 ; (FILE 699, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(981,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D T Q:'DN  D N W ?0 W "Proc: "
 S X=$G(^MCAR(699,D0,0)) S Y=$P(X,U,12) S Y=$S(Y="":Y,$D(^MCAR(697.2,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,10)
 D N:$X>19 Q:'DN  W ?19 W "Patient:  "
 D N:$X>29 Q:'DN  W ?29 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,22)
 D N:$X>59 Q:'DN  W ?59 W "PHONE:  "
 X DXS(1,9) K DIP K:DN Y W X
 S I(1)=25,J(1)=699.73 F D1=0:0 Q:$O(^MCAR(699,D0,25,D1))'>0  X:$D(DSC(699.73)) DSC(699.73) S D1=$O(^(D1)) Q:D1'>0  D:$X>69 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>0 Q:'DN  W ?0 W "DISPOSITION: "
 S X=$G(^MCAR(699,D0,25,D1,0)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>44 Q:'DN  W ?44 W "Follow-up Date:  "
 S Y=$P(X,U,2) D DT
 D N:$X>0 Q:'DN  W ?0 W "REASON:  "
 W ?0,$E($P(X,U,3),1,80)
 D N:$X>0 Q:'DN  W ?0 F I=1:1:80 W "-" K DIP K:DN Y
 Q
A1R ;
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
