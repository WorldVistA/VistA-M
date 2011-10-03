YSCPAO ; GENERATED FROM 'YSSR REVIEW ACTION PRINT' PRINT TEMPLATE (#562) ; 08/21/96 ; (FILE 615.2, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(562,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 D PARSE^YSSRU K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 S DIP(1)=$S($D(^YS(615.2,D0,50)):^(50),1:"") S X=$P(DIP(1),U,3) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 S X=$G(^YS(615.2,D0,0)) D N:$X>10 Q:'DN  W ?10 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,17)
 D N:$X>29 Q:'DN  W ?29 S X="YSAT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") S X=X S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 D N:$X>39 Q:'DN  W ?39 S X="YSAT1",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 S I(1)=10,J(1)=615.21 F D1=0:0 Q:$O(^YS(615.2,D0,10,D1))'>0  X:$D(DSC(615.21)) DSC(615.21) S D1=$O(^(D1)) Q:D1'>0  D:$X>50 T Q:'DN  D A1
 G A1R
A1 ;
 D N:$X>46 Q:'DN  W ?46 X DXS(1,9.2) S DIP(101)=$S($D(^YSR(615.5,D0,0)):^(0),1:"") S X=$P(DIP(101),U,1) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y W $E(X,1,14)
 Q
A1R ;
 S I(1)=5,J(1)=615.34 F D1=0:0 Q:$O(^YS(615.2,D0,5,D1))'>0  X:$D(DSC(615.34)) DSC(615.34) S D1=$O(^(D1)) Q:D1'>0  D:$X>62 T Q:'DN  D B1
 G B1R
B1 ;
 D T Q:'DN  W ?63 X DXS(2,9.2) S DIP(101)=$S($D(^YSR(615.6,D0,0)):^(0),1:"") S X=$P(DIP(101),U,1) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y W $E(X,1,17)
 Q
B1R ;
 D N:$X>0 Q:'DN  W ?0 W "COMMENTS ON REASON FOR S/R:"
 S I(1)=10,J(1)=615.21 F D1=0:0 Q:$O(^YS(615.2,D0,10,D1))'>0  X:$D(DSC(615.21)) DSC(615.21) S D1=$O(^(D1)) Q:D1'>0  D:$X>29 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^YS(615.2,D0,10,D1,0)) D T Q:'DN  W ?0,$E($P(X,U,2),1,200)
 Q
C1R ;
 D N:$X>0 Q:'DN  W ?0 W "GENERAL COMMENTS:  "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=30,J(1)=615.27 F D1=0:0 Q:$O(^YS(615.2,D0,30,D1))'>0  S D1=$O(^(D1)) D:$X>21 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^YS(615.2,D0,30,D1,0)) S DIWL=1,DIWR=78 D ^DIWP
 Q
D1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W " "
 K Y K DIWF
 Q
HEAD ;
 W !,?0,"D"
 W !,?0,"PARSE^YSSRU"
 W !,?0,"NUMDATE(ACTUAL"
 W !,?0,"DATE OF"
 W !,?0,"REVIEW)"
 W !,?10,"NAME",?29,"NUMDATE(YSPARAM("
 W !,?39,"YSPARAM("
 W !,?46,"REASONS FOR"
 W !,?46,"S/R:REASON"
 W !,?63,"TYPE OF"
 W !,?63,"SECLUSION/RESTRAINT:.01"
 W !
 W !,?0,"DESCRIBE CIRCUMSTANCES"
 W !,?0,"GENERAL COMMENTS"
 W !,"--------------------------------------------------------------------------------",!!
