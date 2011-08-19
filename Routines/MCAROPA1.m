MCAROPA1 ; GENERATED FROM 'MCAROPA' PRINT TEMPLATE (#989) ; 10/04/96 ; (continued)
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
 D N:$X>5 Q:'DN  W ?5 X DXS(6,9.2) S DIP(103)=X S X="",DIP(104)=X S X=1,DIP(105)=X S X="SUDDENESS:  ",X=$S(DIP(103):DIP(104),DIP(105):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) S Y=$P(X,U,3) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(7,9.2) S X=$S(DIP(102):DIP(103),DIP(104):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) S Y=$P(X,U,4) D DT
 D T Q:'DN  D N D N:$X>2 Q:'DN  W ?2 X DXS(8,9.2) S X=$S(DIP(102):DIP(103),DIP(104):X) K DIP K:DN Y W X
 S X=$G(^MCAR(690,D0,"P3")) W ?0,$E($P(X,U,5),1,25)
 Q
B1R ;
 K J(100),I(100) S:$D(I(0,0)) D0=I(0,0)
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
