ONCOXPC ; GENERATED FROM 'ONCO XPATIENT CONTACTS' PRINT TEMPLATE (#807) ; 09/24/96 ; (FILE 160, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(807,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S I(1)="""C""",J(1)=160.03 F D1=0:0 Q:$O(^ONCO(160,D0,"C",D1))'>0  X:$D(DSC(160.03)) DSC(160.03) S D1=$O(^(D1)) Q:D1'>0  D:$X>0 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>9 Q:'DN  W ?9 W "Type: "
 S X=$G(^ONCO(160,D0,"C",D1,0)) D N:$X>15 Q:'DN  W ?15 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>34 Q:'DN  W ?34 W "Name: "
 D N:$X>41 Q:'DN  W ?41 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^ONCO(165,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 Q
A1R ;
 K Y
 Q
HEAD ;
 W !,?15,"TYPE OF"
 W !,?15,"FOLLOW-UP"
 W !,?15,"CONTACT",?41,"CONTACT NAME"
 W !,"--------------------------------------------------------------------------------",!!
