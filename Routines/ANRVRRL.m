ANRVRRL ; GENERATED FROM 'ANRVRRL' PRINT TEMPLATE (#998) ; 01/26/98 ; (FILE 2042.5, MARGIN=132)
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(998,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S I(1)=1,J(1)=2042.5.01 F D1=0:0 Q:$O(^ANRV(2042.5,D0,1,D1))'>0  X:$D(DSC(2042.5.01)) DSC(2042.5.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>0 T Q:'DN  D A1
 G A1R
A1 ;
 W ?0 S DIP(1)=$S($D(^ANRV(2042.5,D0,1,D1,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 Q
A1R ;
 S X=$G(^ANRV(2042.5,D0,0)) D N:$X>15 Q:'DN  W ?15 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^ANRV(2040,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 S I(1)=1,J(1)=2042.5.01 F D1=0:0 Q:$O(^ANRV(2042.5,D0,1,D1))'>0  X:$D(DSC(2042.5.01)) DSC(2042.5.01) S D1=$O(^(D1)) Q:D1'>0  D:$X>47 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^ANRV(2042.5,D0,1,D1,0)) D N:$X>51 Q:'DN  W ?51 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^ANRV(2042,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,22)
 S X=$G(^ANRV(2042.5,D0,1,D1,2)) D N:$X>75 Q:'DN  W ?75 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 S X=$G(^ANRV(2042.5,D0,1,D1,0)) D N:$X>86 Q:'DN  W ?86 S Y=$P(X,U,3) D DT
 D N:$X>99 Q:'DN  W ?99 S Y=$P(X,U,4) D DT
 D N:$X>113 Q:'DN  W ?113 S Y=$P(X,U,5) D DT
 Q
B1R ;
 K Y
 Q
HEAD ;
 W !,?0,"REFERRAL DATE",?15,"NAME",?51,"PLACE OF REFERRAL",?75,"STATUS",?86,"NOTIF. DATE",?99,"ADM. DATE",?113,"DSCH. DATE"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
