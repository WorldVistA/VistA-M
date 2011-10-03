MCOBH1 ; GENERATED FROM 'MCARHOLTERBRPR' PRINT TEMPLATE (#1023) ; 10/04/96 ; (FILE 691.6, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(1023,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 W "HOOK-UP DATE/TIME: "
 S X=$G(^MCAR(691.6,D0,0)) S Y=$P(X,U,1) D DT
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PATIENT: "
 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^MCAR(690,Y,0))#2:$P(^(0),U,1),1:Y) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,30)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "REQUESTED BY: "
 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "REASON FOR STUDY: "
 S I(1)=8,J(1)=691.65 F D1=0:0 Q:$O(^MCAR(691.6,D0,8,D1))'>0  X:$D(DSC(691.65)) DSC(691.65) S D1=$O(^(D1)) Q:D1'>0  D:$X>24 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^MCAR(691.6,D0,8,D1,0)) D N:$X>24 Q:'DN  W ?24 S Y=$P(X,U,1) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 Q
A1R ;
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "OTHER INDICATIONS: "
 S I(1)=10,J(1)=691.68 F D1=0:0 Q:$O(^MCAR(691.6,D0,10,D1))'>0  S D1=$O(^(D1)) D:$X>25 T Q:'DN  D B1
 G B1R
B1 ;
 S X=$G(^MCAR(691.6,D0,10,D1,0)) S DIWL=1,DIWR=55 D ^DIWP
 Q
B1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "REVIEWED BY: "
 S X=$G(^MCAR(691.6,D0,0)) S Y=$P(X,U,15) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,35)
 D N:$X>9 Q:'DN  W ?9 W "MAXIMUM"
 S X=$G(^MCAR(691.6,D0,4)) D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,5) W:Y]"" $J(Y,4,0)
 D N:$X>9 Q:'DN  W ?9 W "AVERAGE"
 D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,4) W:Y]"" $J(Y,4,0)
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,15) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "COUPLETS"
 D N:$X>3 Q:'DN  W ?3 W "NUMBER OF RUNS 3 OR MORE (VENT)"
 S Y=$P(X,U,16) W:Y]"" $J(Y,6,0)
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,18) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BEATS IN LONGEST RUN"
 D N:$X>3 Q:'DN  W ?3 S Y=$P(X,U,19) W:Y]"" $J(Y,8,0)
 D N:$X>12 Q:'DN  W ?12 W "BEATS FASTEST RUN AT"
 D N:$X>3 Q:'DN  W ?3 X DXS(1,9.2) S X=$P(DIP(1),U,22),X=$S($P(DIP(1),U,3):X\$P(DIP(1),U,3),1:"*******"),X=$S(DIP(2):DIP(3),DIP(4):DIP(5),DIP(6):X) K DIP K:DN Y W $J(X,8)
 D N:$X>12 Q:'DN  W ?12 W "AVE/HOUR"
 D T Q:'DN  D N D N D N:$X>4 Q:'DN  W ?4 X DXS(2,9) K DIP K:DN Y W X
 W ?15 X DXS(3,9.3) S X=$S(DIP(4):DIP(5),DIP(6):X) S Y=X,X=DIP(1),X=X_Y K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 S DIP(1)=$S($D(^MCAR(691.6,D0,9)):^(9),1:"") S X="ST LEVEL: "_$P(DIP(1),U,2) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 X DXS(4,9) K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "INTERPRETATION: "
 S I(1)=7,J(1)=691.63 F D1=0:0 Q:$O(^MCAR(691.6,D0,7,D1))'>0  S D1=$O(^(D1)) D:$X>22 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^MCAR(691.6,D0,7,D1,0)) S DIWL=1,DIWR=55 D ^DIWP
 Q
C1R ;
 D A^DIWW
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "SUMMARY: "
 S X=$G(^MCAR(691.6,D0,.2)) S Y=$P(X,U,1) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D T Q:'DN  D N D N:$X>4 Q:'DN  W ?4 W "PROCEDURE SUMMARY: "
 D N:$X>9 Q:'DN  S DIWL=10,DIWR=74 S Y=$P(X,U,2) S X=Y D ^DIWP
 D A^DIWW
 D T Q:'DN  W ?2 S MCFILE=691.6 D DISP^MCMAG K DIP K:DN Y
 W ?13 K MCFILE K DIP K:DN Y
 K Y K DIWF
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
