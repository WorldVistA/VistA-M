XUCT ; GENERATED FROM 'XTER ERROR SUMMARY' PRINT TEMPLATE (#1511) ; 04/28/11 ; (FILE 3.077, MARGIN=80)
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
 I $D(DXS)<9 M DXS=^DIPT(1511,"DXS")
 S I(0)="^%ZTER(3.077,",J(0)=3.077
 S X=$G(^%ZTER(3.077,D0,0)) W ?0,$E($P(X,U,4),1,20)
 W ?22 S Y=$P(X,U,3) D DT
 D N:$X>2 Q:'DN  W ?2 X DXS(1,9.2) S X1=DIP(4) S X2=DIP(2) S X=$TR(X2,X1,X) K DIP K:DN Y W $E(X,1,45)
 D T Q:'DN  W ?2 X DXS(2,9.2) S X1=DIP(4) S X2=DIP(2) S X=$TR(X2,X1,X) K DIP K:DN Y W $E(X,1,79)
 D T Q:'DN  W ?2 X DXS(3,9.2) S X1=DIP(4) S X2=DIP(2) S X=$TR(X2,X1,X) K DIP K:DN Y W $E(X,1,240)
 K Y
 Q
HEAD ;
 W !,?0,"ROUTINE NAME",?22,"MOST RECENT DATE/TIME"
 W !,?2,"Error Text"
 W !,?2,"Last Global"
 W !,?2,"Stack List"
 W !,"--------------------------------------------------------------------------------",!!
