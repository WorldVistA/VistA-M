PRCATW1 ; GENERATED FROM 'PRCAC TR LIST' PRINT TEMPLATE (#408) ; 06/27/96 ; (FILE 433, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(408,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S DIWF="W"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "WRITE-OFF PROCESS:"
 S X=$G(^PRCA(433,D0,1)) D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,1) D DT
 D N:$X>37 Q:'DN  W ?37 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^PRCA(430.3,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>2 Q:'DN  W ?2 W "PROCESSED BY:"
 S X=$G(^PRCA(433,D0,0)) W ?17 S Y=$P(X,U,9) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 S I(1)=7,J(1)=433.041 F D1=0:0 Q:$O(^PRCA(433,D0,7,D1))'>0  S D1=$O(^(D1)) D:$X>54 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^PRCA(433,D0,7,D1,0)) S DIWL=55,DIWR=78 D ^DIWP
 Q
A1R ;
 D 0^DIWW K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
