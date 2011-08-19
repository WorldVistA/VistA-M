MCOBT ; GENERATED FROM 'MCARETTBRPR' PRINT TEMPLATE (#1024) ; 10/04/96 ; (FILE 691.7, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1024,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 X DXS(1,9) K DIP K:DN Y W $E(X,1,18)
 D N:$X>34 Q:'DN  W ?34 W "MEDICAL PATIENT: "
 S X=$G(^MCAR(691.7,D0,0)) S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "REASON FOR TEST: "
 S DIWL=1,DIWR=55 S Y=$P(X,U,4) S:Y]"" Y=$S($D(DXS(3,Y)):DXS(3,Y),1:Y) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "ETT PROTOCOL: "
 S X=$G(^MCAR(691.7,D0,3)) S Y=$P(X,U,2) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>16 Q:'DN  W ?16 W "PEAK EX"
 D N:$X>16 Q:'DN  W ?16 W "-------"
 D N:$X>7 Q:'DN  W ?7 W "HR"
 S X=$G(^MCAR(691.7,D0,4)) D N:$X>16 Q:'DN  W ?16 S Y=$P(X,U,1) W:Y]"" $J(Y,4,0)
 D N:$X>7 Q:'DN  W ?7 W "SBP/DBP"
 D N:$X>16 Q:'DN  W ?16 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X=$P(DIP(1),U,2)_"/"_$P(DIP(1),U,3) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 W "ST/SLP"
 D N:$X>16 Q:'DN  W ?16 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X=$P(DIP(1),U,7)_"/"_$P(DIP(1),U,8) K DIP K:DN Y W X
 D N:$X>7 Q:'DN  W ?7 W "RPP/1000"
 D N:$X>16 Q:'DN  W ?16 X $P(^DD(691.7,42,0),U,5,99) S DIP(1)=X S X=DIP(1),DIP(2)=X S X=6,DIP(3)=X S X=2,X=$J(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X="PEAK MPH: "_$P(DIP(1),U,4) K DIP K:DN Y W X
 W ?15 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X="     %GRADE: "_$P(DIP(1),U,5) K DIP K:DN Y W X
 W ?26 S DIP(1)=$S($D(^MCAR(691.7,D0,4)):^(4),1:"") S X="     METS: "_$P(DIP(1),U,6) K DIP K:DN Y W X
 W ?37 X $P(^DD(691.7,48,0),U,5,99) S DIP(1)=X S X="     %TARGET HR: "_DIP(1) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 X DXS(2,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SIGNIFICANT ARRHYTHMIAS:"
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "BLOOD PRESSURE CHANGES:"
 S X=$G(^MCAR(691.7,D0,7)) W ?29 S Y=$P(X,U,4) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "COMPLICATIONS:"
 S I(1)=11,J(1)=691.703 F D1=0:0 Q:$O(^MCAR(691.7,D0,11,D1))'>0  X:$D(DSC(691.703)) DSC(691.703) S D1=$O(^(D1)) Q:D1'>0  D:$X>20 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.7,D0,11,D1,0)) D N:$X>19 Q:'DN  W ?19 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^MCAR(696.9,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,40)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(691.7,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 D N:$X>9 Q:'DN  S DIWL=10,DIWR=74 S Y=$P(X,U,2) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "EKG TECH:"
 S X=$G(^MCAR(691.7,D0,7)) S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "ATTN PHYS:"
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 W ?16 S MCFILE=691.7 D DISP^MCMAG K DIP K:DN Y
 W ?27 K MCFILE K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
