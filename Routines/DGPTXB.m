DGPTXB ; GENERATED FROM 'DG PTF PT BRIEF LIST' PRINT TEMPLATE (#217) ; 03/30/98 ; (FILE 45, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(217,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 S Y=D0 W:Y]"" $J(Y,7,0)
 S X=$G(^DGPT(D0,0)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>24 Q:'DN  W ?24 S Y=$P(X,U,2) D DT
 D N:$X>49 Q:'DN  W ?49 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 K Y
 Q
HEAD ;
 W !,?3,"PTF#",?9,"Status",?24,"Admission Date"
 W !,"--------------------------------------------------------------------------------",!!
