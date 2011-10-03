YSCPAK ; GENERATED FROM 'YSSR NURSE MGT PRINT' PRINT TEMPLATE (#558) ; 08/21/96 ; (FILE 615.2, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(558,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 S DIWF="W"
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^YS(615.2,D0,0)):^(0),1:"") S X="NURSING SHIFT: "_$S('$D(^NURSF(211.6,+$P(DIP(1),U,6),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^YS(615.2,D0,0)):^(0),1:"") S X="NAME:  "_$S('$D(^DPT(+$P(DIP(1),U,2),0)):"",1:$P(^(0),U,1)) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "FROM:  "
 D N:$X>7 Q:'DN  W ?7 S DIP(1)=$S($D(^YS(615.2,D0,0)):^(0),1:"") S X=$P(DIP(1),U,3),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 W ?27 X DXS(1,9.2) S X=$E($P(X,".",2)_"0000",1,4),%=X>1159 S:X>1259 X=X-1200 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M" K DIP K:DN Y W X
 D N:$X>40 Q:'DN  W ?40 W "TO:"
 W ?45 S DIP(1)=$S($D(^YS(615.2,D0,40)):^(40),1:"") S X=$P(DIP(1),U,3),X=$P(X,".",1) S Y=X K DIP K:DN Y S Y=X D DT
 W ?65 X DXS(2,9.2) S X=$E($P(X,".",2)_"0000",1,4),%=X>1159 S:X>1259 X=X-1200 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M" K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "TOTAL TIME THIS EPISODE:  "
 W ?28 D PARSE^YSSRU K DIP K:DN Y
 D N:$X>29 Q:'DN  W ?29 S X="YSTT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "ORDERED BY:  "
 S X=$G(^YS(615.2,D0,25)) W ?15 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>0 Q:'DN  W ?0 W "REASON:  "
 S I(1)=10,J(1)=615.21 F D1=0:0 Q:$O(^YS(615.2,D0,10,D1))'>0  X:$D(DSC(615.21)) DSC(615.21) S D1=$O(^(D1)) Q:D1'>0  D:$X>11 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>10 Q:'DN  W ?10 X DXS(3,9.2) S DIP(101)=$S($D(^YSR(615.5,D0,0)):^(0),1:"") S X=$P(DIP(101),U,1) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y W X
 S X=$G(^YS(615.2,D0,10,D1,0)) D T Q:'DN  W ?10,$E($P(X,U,2),1,200)
 Q
A1R ;
 D N:$X>0 Q:'DN  W ?0 W "GENERAL COMMENTS:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=30,J(1)=615.27 F D1=0:0 Q:$O(^YS(615.2,D0,30,D1))'>0  S D1=$O(^(D1)) D:$X>21 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^YS(615.2,D0,30,D1,0)) S DIWL=1,DIWR=78 D ^DIWP
 Q
B1R ;
 D 0^DIWW K DIP K:DN Y
 D ^DIWW K Y K DIWF
 Q
HEAD ;
 W !,?7,"DATE(DATE/TIME",?27,"TIME(DATE/TIME"
 W !,?7,"APPLIED)",?27,"APPLIED)"
 W !,?65,"TIME(TIME"
 W !,?45,"DATE(TIME REMOVED)",?65,"REMOVED)"
 W !,?28,"D"
 W !,?28,"PARSE^YSSRU"
 W !,?29,"YSPARAM("
 W !,?15,"ORDERED BY"
 W !,?10,"REAS:REASON"
 W !
 W !,?10,"DESCRIBE CIRCUMSTANCES"
 W !,?0,"GENERAL COMMENTS"
 W !,"--------------------------------------------------------------------------------",!!
