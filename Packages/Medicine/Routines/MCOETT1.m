MCOETT1 ; GENERATED FROM 'MCARETT1' PRINT TEMPLATE (#164) ; 03/21/95 ; (FILE 691.7, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(164,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>44 Q:'DN  W ?44 W "TIME TEST:"
 W ?56 X DXS(1,9.2) S X=$E($P(X,".",2)_"0000",1,4),%=X>1159 S:X>1259 X=X-1200 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M" K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "AGE:"
 W ?10 X DXS(2,9) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "WT LBS:"
 S X=$G(^MCAR(691.7,D0,10)) W ?53 S Y=$P(X,U,1) W:Y]"" $J(Y,4,0)
 D N:$X>4 Q:'DN  W ?4 W "SEX:"
 W ?10 X DXS(3,9.3) S DIP(201)=$S($D(^DPT(D0,0)):^(0),1:"") S X=$P($P(DIP(202),$C(59)_$P(DIP(201),U,2)_":",2),$C(59),1) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>44 Q:'DN  W ?44 W "WARD/CLINIC: "
 S X=$G(^MCAR(691.7,D0,10)) S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 D N:$X>4 Q:'DN  W ?4 W "REF PHYS: "
 S X=$G(^MCAR(691.7,D0,3)) W ?16,$E($P(X,U,1),1,20)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "ETT PROTOCOL:"
 W ?19 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(8,Y)):DXS(8,Y),1:Y)
 D N:$X>4 Q:'DN  W ?4 X $P(^DD(691.7,46,0),U,5,99) S DIP(1)=X S X="TARGET HR: "_DIP(1) K DIP K:DN Y W X
 D N:$X>4 Q:'DN  W ?4 W "RESTING EKG:"
 S I(1)=2,J(1)=691.72 F D1=0:0 Q:$O(^MCAR(691.7,D0,2,D1))'>0  S D1=$O(^(D1)) D:$X>18 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.7,D0,2,D1,0)) S DIWL=19,DIWR=78 D ^DIWP
 Q
A1R ;
 D A^DIWW
 D N:$X>4 Q:'DN  W ?4 W "----------------------------------------------------------------------"
 D N:$X>18 Q:'DN  W ?18 W "SUPINE"
 D N:$X>33 Q:'DN  W ?33 W "UPRIGHT"
 D N:$X>48 Q:'DN  W ?48 W "ONSET CP"
 D N:$X>63 Q:'DN  W ?63 W "PEAK EX"
 D N:$X>18 Q:'DN  W ?18 W "------"
 D N:$X>33 Q:'DN  W ?33 W "-------"
 D N:$X>48 Q:'DN  W ?48 W "--------"
 D N:$X>63 Q:'DN  W ?63 W "-------"
 D N:$X>6 Q:'DN  W ?6 W "HR"
 S X=$G(^MCAR(691.7,D0,3)) D N:$X>18 Q:'DN  W ?18 S Y=$P(X,U,4) W:Y]"" $J(Y,4,0)
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,7) W:Y]"" $J(Y,4,0)
 D N:$X>48 Q:'DN  W ?48 S Y=$P(X,U,15) W:Y]"" $J(Y,4,0)
 S X=$G(^MCAR(691.7,D0,4)) D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,1) W:Y]"" $J(Y,4,0)
 D N:$X>6 Q:'DN  W ?6 W "SBP/DBP"
 D N:$X>18 Q:'DN  W ?18 S DIP(1)=$S($D(^MCAR(691.7,D0,3)):^(3),1:"") S X=$P(DIP(1),U,5)_"/"_$P(DIP(1),U,6) K DIP K:DN Y W X
 D N:$X>33 Q:'DN  W ?33 S DIP(1)=$S($D(^MCAR(691.7,D0,3)):^(3),1:"") S X=$P(DIP(1),U,8)_"/"_$P(DIP(1),U,9) K DIP K:DN Y W X
 D N:$X>48 Q:'DN  W ?48 X DXS(4,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X=$P(DIP(1),U,2)_"/"_$P(DIP(1),U,3) K DIP K:DN Y W X
 D N:$X>6 Q:'DN  W ?6 W "ST/SLP"
 D N:$X>18 Q:'DN  W ?18 S DIP(1)=$S($D(^MCAR(691.7,D0,3)):^(3),1:"") S X=$P(DIP(1),U,10)_"/"_$P(DIP(1),U,11) K DIP K:DN Y W X
 D N:$X>33 Q:'DN  W ?33 S DIP(2)=$S($D(^MCAR(691.7,D0,3)):^(3),1:""),DIP(1)=$S($D(^(7)):^(7),1:"") S X=$P(DIP(1),U,3)_"/"_$P(DIP(2),U,12) K DIP K:DN Y W X
 D N:$X>48 Q:'DN  W ?48 X DXS(5,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X=$P(DIP(1),U,7)_"/"_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>6 Q:'DN  W ?6 W "RPP/1000"
 D N:$X>18 Q:'DN  W ?18 X $P(^DD(691.7,12,0),U,5,99) S DIP(1)=X S X=DIP(1),DIP(2)=X S X=6,DIP(3)=X S X=2,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>33 Q:'DN  W ?33 X $P(^DD(691.7,16,0),U,5,99) S DIP(1)=X S X=DIP(1),DIP(2)=X S X=6,DIP(3)=X S X=2,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 G ^MCOETT11
