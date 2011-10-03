DVBAXF ; GENERATED FROM 'DVBA FINALIZED REPORT' PRINT TEMPLATE (#519) ; 04/03/98 ; (FILE 396, MARGIN=132)
 G BEGIN
CP G CP^DIO2
C S DQ(C)=Y
S S Q(C)=Y*Y+Q(C) S:L(C)>Y L(C)=Y S:H(C)<Y H(C)=Y
P S N(C)=N(C)+1
A S S(C)=S(C)+Y
 Q
D I Y=DITTO(C) S Y="" Q
 S DITTO(C)=Y
 Q
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(519,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 X DXS(1,9) K DIP K:DN Y W X
 D N:$X>17 Q:'DN  W ?17 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>31 Q:'DN  W ?31 S DIP(1)=$S($D(^DVB(396,D0,2)):^(2),1:"") S X=$P(DIP(1),U,7),DIP(2)=X S X=1,DIP(3)=X S X=15,X=$E(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>49 Q:'DN  W ?49 S DIP(1)=$S($D(^DVB(396,D0,1)):^(1),1:"") S X=$P(DIP(1),U,12),X1=X,X2=$P(DIP(1),U,1),X="" D:X2 ^%DTC:X1 K DIP K:DN Y W $E(X,1,9) K Y(396,-1) S Y=X,C=1 D A:Y'?."*"
 D N:$X>62 Q:'DN  W ?62 S DIP(1)=$S($D(^DVB(396,D0,1)):^(1),1:"") S X=$P(DIP(1),U,1) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) K DIP K:DN Y W X
 D N:$X>75 Q:'DN  W ?75 S DIP(1)=$S($D(^DVB(396,D0,1)):^(1),1:"") S X=$P(DIP(1),U,12) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3)) K DIP K:DN Y W X
 S X=$G(^DVB(396,D0,2)) D N:$X>87 Q:'DN  W ?87,$E($P(X,U,6),1,15)
 K Y
 Q
HEAD ;
 W !,?49,"TOTAL"
 W !,?0,"PATIENT",?31,"REQUESTING",?49,"DAYS TO",?62,"DATE OF",?75,"FINAL"
 W !,?0,"NAME",?17,"SSN",?31,"VARO",?49,"PROCESS",?62,"REQUEST",?75,"DATE",?87,"FINALIZED BY"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
