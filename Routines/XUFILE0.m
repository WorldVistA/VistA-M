XUFILE0 ;OAK-BP/ - GENERATED FROM 'XUFILEINQ' PRINT TEMPLATE (#30) ; [4/6/04 7:42am]
 ;;8.0;KERNEL;**342**;Jul 10, 1995
 ;;(FILE 200, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(30,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>37 Q:'DN  W ?37 X DXS(1,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W $E(X,1,35)
 S I(1)="""FOF""",J(1)=200.032 F D1=0:0 Q:$O(^VA(200,D0,"FOF",D1))'>0  X:$D(DSC(200.032)) DSC(200.032) S D1=$O(^(D1)) Q:D1'>0  D:$X>74 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>0 Q:'DN  W ?0,$E(D1,1,10)
 S X=$G(^VA(200,D0,"FOF",D1,0)) D N:$X>10 Q:'DN  W ?11 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^DIC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,25)
 W ?38 S Y=$P(X,U,2) W:Y]"" $J($S($D(DXS(2,Y)):DXS(2,Y),1:Y),3)
 W ?43 S Y=$P(X,U,3) W:Y]"" $J($S($D(DXS(3,Y)):DXS(3,Y),1:Y),5)
 W ?51 S Y=$P(X,U,4) W:Y]"" $J($S($D(DXS(4,Y)):DXS(4,Y),1:Y),5)
 W ?58 S Y=$P(X,U,5) W:Y]"" $J($S($D(DXS(5,Y)):DXS(5,Y),1:Y),4)
 W ?64 S Y=$P(X,U,6) W:Y]"" $J($S($D(DXS(6,Y)):DXS(6,Y),1:Y),5)
 W ?71 S Y=$P(X,U,7) W:Y]"" $J($S($D(DXS(7,Y)):DXS(7,Y),1:Y),5)
 Q
A1R ;
 K Y
 Q
HEAD ;
 W !,?0,"FILE#",?11,"ACCESSIBLE FILE",?39,"DD",?43,"DELETE",?51,"LAYGO",?58,"READ",?64,"WRITE",?71,"AUDIT"
 W !,"--------------------------------------------------------------------------------",!!
