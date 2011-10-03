MCOETT11 ; GENERATED FROM 'MCARETT1' PRINT TEMPLATE (#164) ; 03/21/95 ; (continued)
 ;;2.2;MEDICINE;;Jun 08, 1995
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1 D:'(DISTP#100) CSTP
 Q
CSTP I '$D(ZTQUEUED) K DISTOP Q
 Q:$G(DISTOP)=0  S:$G(DISTOP)="" DISTOP=1
 I DISTOP'=1 X DISTOP K:'$T DISTOP S DISTOP=$T Q:'$T
 Q:'$$S^%ZTLOAD
 W:$G(IO)]"" !,"*** TASK "_ZTSK_" STOPPED BY USER - DURING "_$S($D(DPQ):"SORT",1:"PRINT")_" EXECUTION ***",!! S ZTSTOP=1,DN=0 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP)
 D N:$X>48 Q:'DN  W ?48 X $P(^DD(691.7,28,0),U,5,99) S DIP(1)=X S X=DIP(1),DIP(2)=X S X=6,DIP(3)=X S X=2,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 X $P(^DD(691.7,42,0),U,5,99) S DIP(1)=X S X=DIP(1),DIP(2)=X S X=6,DIP(3)=X S X=2,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>6 Q:'DN  W ?6 W "MIN:SEC"
 D N:$X>49 Q:'DN  W ?49 X DXS(6,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>64 Q:'DN  W ?64 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X=$P(DIP(1),U,9)_":"_$P(DIP(1),U,10) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "----------------------------------------------------------------------"
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X="PEAK MPH: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 W ?15 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X="     % GRADE: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 W ?26 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X="     METS: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 W ?37 X $P(^DD(691.7,48,0),U,5,99) S DIP(1)=X S X="     % TARGET HR: "_DIP(1) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 X DXS(7,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.7,D0,5)):^(5),1:"") S X="TIME ST SEGMENT RETURN TO BASELINE: "_$P(DIP(1),U,7) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SIGNIFICANT ARRHYTHMIAS:"
 S X=$G(^MCAR(691.7,D0,5)) W ?30 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(9,Y)):DXS(9,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "BLOOD PRESSURE CHANGES:"
 S X=$G(^MCAR(691.7,D0,7)) W ?29 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(10,Y)):DXS(10,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "OTHER EKG CHANGES:"
 S I(1)=9,J(1)=691.75 F D1=0:0 Q:$O(^MCAR(691.7,D0,9,D1))'>0  S D1=$O(^(D1)) D:$X>24 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(691.7,D0,9,D1,0)) S DIWL=25,DIWR=78 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETATION:"
 S X=$G(^MCAR(691.7,D0,5)) W ?21 S Y=$P(X,U,8) W:Y]"" $S($D(DXS(11,Y)):DXS(11,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMMENTS:"
 S I(1)=6,J(1)=691.73 F D1=0:0 Q:$O(^MCAR(691.7,D0,6,D1))'>0  S D1=$O(^(D1)) D:$X>15 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(691.7,D0,6,D1,0)) S DIWL=16,DIWR=75 D ^DIWP
 Q
C1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "HEART MEDS:"
 S I(1)=1,J(1)=691.71 F D1=0:0 Q:$O(^MCAR(691.7,D0,1,D1))'>0  X:$D(DSC(691.71)) DSC(691.71) S D1=$O(^(D1)) Q:D1'>0  D:$X>17 T Q:'DN  D D1
 G D1R
D1 ;
 S X=$G(^MCAR(691.7,D0,1,D1,0)) W ?17 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(695,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^PSDRUG(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 W " "
 W ?0,$E($P(X,U,2),1,10)
 W " "
 W ?0,$E($P(X,U,3),1,10)
 Q
D1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMPLICATIONS:"
 S I(1)=11,J(1)=691.703 F D1=0:0 Q:$O(^MCAR(691.7,D0,11,D1))'>0  X:$D(DSC(691.703)) DSC(691.703) S D1=$O(^(D1)) Q:D1'>0  D:$X>20 T Q:'DN  D E1
 G E1R
E1 ;
 S X=$G(^MCAR(691.7,D0,11,D1,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696.9,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 Q
E1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "EKG TECH:"
 S X=$G(^MCAR(691.7,D0,7)) W ?15 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "ATTN PHYS:"
 W ?16 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
