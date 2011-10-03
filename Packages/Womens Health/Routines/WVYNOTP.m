WVYNOTP ; GENERATED FROM 'WV PRINT NOTIF PURPOSE&LETTER' PRINT TEMPLATE (#2598) ; 10/16/97 ; (FILE 790.404, MARGIN=80)
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(2598,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 S:$D(WVPAGE) WVPAGE=WVPAGE+1 K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W "NOTIFICATION PURPOSE & LETTER LIST"
 D N:$X>47 Q:'DN  W ?47 S %=$P($H,",",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100) S Y=X K DIP K:DN Y S Y=X D DT
 D N:$X>69 Q:'DN  W ?69 W:$D(WVPAGE) "PAGE "_WVPAGE K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 S X="-",DIP(1)=X S X=80,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>1 Q:'DN  W ?1 W "PURPOSE: "
 S X=$G(^WV(790.404,D0,0)) W ?1,$E($P(X,U,1),1,50)
 D N:$X>54 Q:'DN  W ?54 W "SYNONYM: "
 W ?54,$E($P(X,U,3),1,6)
 D N:$X>0 Q:'DN  W ?0 W "PRIORITY: "
 W ?0 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>55 Q:'DN  W ?55 W "ACTIVE: "
 W ?55 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "BR or CX: "
 W ?0 S Y=$P(X,U,5) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 W ?0 W " LETTER:"
 D T Q:'DN  D N W ?0 W ""
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=1,J(1)=790.414 F D1=0:0 Q:$O(^WV(790.404,D0,1,D1))'>0  S D1=$O(^(D1)) D:$X>2 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^WV(790.404,D0,1,D1,0)) S DIWL=3,DIWR=78 D ^DIWP
 Q
A1R ;
 D A^DIWW
 D T Q:'DN  W ?2 D:$E(IOST)="C" DIRZ^WVUTL3 K DIP K:DN Y
 W ?15 W @IOF K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,?0,"S:$D(WVPAGE)"
 W !,?0,"WVPAGE=WVPAGE+1"
 W !,?47,"NOW"
 W !,?0,"DUP("
 W !,?1,"NOTIFICATION PURPOSE",?54,"SYNONYM"
 W !,?0,"PRIORITY",?55,"ACTIVE"
 W !,?0,"ASSOCIATE"
 W !,?0,"WITH BR/CX"
 W !,?0,"TX"
 W !,?2,"LETTER TEXT"
 W !,?2,"D:$E(IOST)=",?15,"W @IOF"
 W !,"--------------------------------------------------------------------------------",!!
