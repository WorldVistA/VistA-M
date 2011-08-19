MCARORN ; GENERATED FROM 'MCRHNARR' PRINT TEMPLATE (#1006) ; 10/04/96 ; (FILE 701, MARGIN=80)
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
 D N:$X>0 Q:'DN  W ?0 W "NARRATIVE HISTORY"
 D N:$X>0 Q:'DN  W ?0 W " "
 S I(1)=11,J(1)=701.0611 F D1=0:0 Q:$O(^MCAR(701,D0,11,D1))'>0  S D1=$O(^(D1)) D:$X>3 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(701,D0,11,D1,0)) S DIWL=1,DIWR=78 D ^DIWP
 Q
A1R ;
 D A^DIWW
 F Y=0:0 Q:$Y>(IOSL-3)  W !
 D N:$X>0 Q:'DN  W ?0 W " "
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
